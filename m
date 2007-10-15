From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git-svn and submodules
Date: Mon, 15 Oct 2007 12:53:11 +0200
Message-ID: <AA453A15-BBF1-4EA6-B1AC-1C4E00E89FB2@lrde.epita.fr>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr> <86lka4ofb8.fsf@lola.quinscape.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-74--609973098"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 12:54:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhNaC-000778-Em
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 12:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758403AbXJOKxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 06:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758323AbXJOKxt
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 06:53:49 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:47883 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758263AbXJOKxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 06:53:48 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IhNZz-0007eY-Cz; Mon, 15 Oct 2007 12:53:47 +0200
In-Reply-To: <86lka4ofb8.fsf@lola.quinscape.zz>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60981>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-74--609973098
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 15, 2007, at 12:14 PM, David Kastrup wrote:

> Benoit SIGOURE <tsuna@lrde.epita.fr> writes:
>
>> This week I'm probably going to start to dive in git-svn by
>> implementing simpler things first:
>>   - git svn create-ignore (to create one .gitignore per directory
>> from the svn:ignore properties.  This has the disadvantage of
>> committing the .gitignore during the next dcommit, but when you
>> import a repo with tons of ignores (>1000), using git svn show-ignore
>> to build .git/info/exclude is *not* a good idea, because things like
>> git-status will end up doing >1000 fnmatch *per file* in the repo,
>> which leads to git-status taking more than 4s on my Core2Duo 2Ghz 2G
>> RAM)
>
> Well, then this should be fixed in git general, by sorting the ignores
> (wildcards in the first place where they can match), and then just
> moving those patterns that can actually match according to sort order
> to the list of fnmatch candidates (and moving those files that can't
> match anymore die to the sort order out again).
>
> I don't think that the final "solution" for avoiding a lousy global
> O(n^2) algorithm is to replace it with lousy local O(n^2) algorithms
> and just hope for smaller values of n.

That's entirely true, it's more of a workaround than a real  
solution.  Anyways, there could be other situations in which someone  
would like to generate the .gitignore instead of using .git/info/ 
exclude, so this feature could be useful anyways.

I can try to address this issue later, if I have enough free time in  
my hands to do so.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-74--609973098
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHE0aXwwE67wC8PUkRAqilAKCbllgn8CZugNrRMkiCP7p2v4hQqwCgxnnM
KX9a1gYFq0tEcNByX1yKq1w=
=SWgN
-----END PGP SIGNATURE-----

--Apple-Mail-74--609973098--
