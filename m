From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [user] git-svn and svn cp
Date: Mon, 19 Nov 2007 15:04:24 +0100
Message-ID: <A27F6A8E-705B-4D76-A84A-D25BA733EE49@lrde.epita.fr>
References: <47416F68.9070908@ogersoft.at> <vpq3av25sg0.fsf@bauges.imag.fr> <86k5oez9f5.fsf@lola.quinscape.zz> <vpqzlxa2y2f.fsf@bauges.imag.fr> <EB96D9F3-D69C-4D46-961C-27885CBC0E52@lrde.epita.fr> <vpqtzni1h17.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6-278015885"
Content-Transfer-Encoding: 7bit
Cc: gerhard.oettl.ml@ogersoft.at, David Kastrup <dak@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Nov 19 15:05:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu7FE-0007A3-Dj
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 15:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbXKSOEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 09:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753115AbXKSOEn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 09:04:43 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:45792 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbXKSOEm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 09:04:42 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Iu7Es-0004bM-Ka; Mon, 19 Nov 2007 15:04:38 +0100
In-Reply-To: <vpqtzni1h17.fsf@bauges.imag.fr>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65447>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6-278015885
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 19, 2007, at 2:49 PM, Matthieu Moy wrote:

> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
>
>>> Not in the details. Well, I believe the accurate question (to  
>>> original
>>> poster) is: does your svn repository use the standard svn layout
>>> (tags/, branches/, trunk/)?
>>
>> I think this is irrelevant to the question he asked.
>
> Well, I'm far enough from being a git-svn expert, but I suppose
> git-svn will special-case the content of tags/ and branches/
> directories, and consider copies there to be tags and branches. I
> don't know whether git-svn does it efficiently, though.
>
> If you use "svn copy" with the meaning "create a tag" with a
> destination other than tags/ directory, then, git-svn can not guess it
> was actually a tag.

No, git-svn only needs to know where to look for branches and tags so  
that it can replicate them on the Git side by creating remote  
branches.  It has nothing to do with the fact that a tag or a branch  
happen to be a copy of something else (which isn't necessarily true,  
I can perfectly create a tag out of the blue which has its own unique  
content, same thing for branches).

The question of Gerhard was thus, why do we need to transfer "so  
much" data over the network when we should be able to guess that the  
data is already in the Git repo (because git-svn can figure out that  
something is a copy of something else -- because SVN records this  
information -- and thus save the network from downloading useless  
deltas).  It's possible that the code can be optimized to handle  
this, or so I guess.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-6-278015885
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHQZfowwE67wC8PUkRApPoAKDAAwGAZ+cHF3Xf6ldJod+m4VLZKQCgwqhi
9Sfy3i77Xqau23bzDWZDmvs=
=+3d+
-----END PGP SIGNATURE-----

--Apple-Mail-6-278015885--
