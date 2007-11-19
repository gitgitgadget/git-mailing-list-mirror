From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 17:57:50 +0100
Message-ID: <E983072E-E9FD-499E-A418-B630A275C4F3@lrde.epita.fr>
References: <1195477504.8093.15.camel@localhost> <8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-11-288422153"
Content-Transfer-Encoding: 7bit
Cc: "Jonas Juselius" <jonas.juselius@chem.uit.no>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 17:58:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu9xH-00063g-DK
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 17:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbXKSQ6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 11:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbXKSQ6I
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 11:58:08 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:39176 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbXKSQ6G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 11:58:06 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Iu9wi-0007xe-Nt; Mon, 19 Nov 2007 17:58:04 +0100
In-Reply-To: <8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65467>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-11-288422153
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 19, 2007, at 5:45 PM, Lars Hjemli wrote:

> On Nov 19, 2007 2:05 PM, Jonas Juselius  
> <jonas.juselius@chem.uit.no> wrote:
> Also, I think you might scare users away from 'git reset':
>
>   git reset resets the branch to a specified state invisibly and
>   without possibility to go back. Ever. Your call.
>
> That's not true, since any "modern" git has reflogs enabled. If you do
> 'git reset --hard HEAD^^^' and then realize it was a mistake you can
> just 'git reset --hard HEAD@{1}'

Yes, I've always been very scared of git-reset until I had a somewhat  
better understanding of Git internals.  In fact the only danger of  
`git reset --hard' is that you loose dirty changes (not yet in the  
index) and staged changes (in the index).  git-reset will never, ever  
delete objects from your repo.  Thus, you can perfectly well remember  
the current revision sha1 (let's call it `A') and then git reset -- 
hard HEAD~42 and then git reset --hard A.  In between the two Git  
commands, it's possible that all the objects of the history from  
HEAD~42..A be unreachable.  Nothing wrong with this, it just that if  
run, say, git gc --prune (note the --prune) you will loose them.

Understanding this is very important because ``error humanum est'',  
and people happen to screw up their hard work and they don't realize  
that they can go back without even knowing what the hell the reflog  
is or how to use it (I personally don't know -- but I'd like to, give  
me pointers please :D).  For instance, I once rebased a dozen of  
commits on a given branch and I realised that I completely screwed my  
nice patch series by collapsing changes, introducing changes at the  
wrong revision etc.  I could start over again by simply doing a git  
reset --hard <HEAD_sha1_before_rebase>.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-11-288422153
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHQcCOwwE67wC8PUkRAuRLAKDEuS9fhNpdh6Om9xJ8HDhgtddCRQCfdQW0
L8wBLA42alu49D4d8215PgE=
=X5zb
-----END PGP SIGNATURE-----

--Apple-Mail-11-288422153--
