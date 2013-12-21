From: fREW Schmidt <frioux@gmail.com>
Subject: Re: git-mv-submodule
Date: Sat, 21 Dec 2013 10:23:32 -0600
Message-ID: <20131221162332.GB7917@wanderlust>
References: <20131221094833.GA7917@wanderlust>
 <52B5BD1B.5090705@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Dec 21 17:23:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuPL3-00070D-3q
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 17:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab3LUQXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 11:23:37 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:41287 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612Ab3LUQXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 11:23:36 -0500
Received: by mail-oa0-f42.google.com with SMTP id i4so4196211oah.1
        for <git@vger.kernel.org>; Sat, 21 Dec 2013 08:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cA2WpIVHiAQfOBi9shIEvSWJfXBOmeOl1QV7zwF62P4=;
        b=Qa7Gd8u2mG2bXWtkC3iHCDfdY9r+j3oEJIhfy0lhm0DrCJBtrNtOI/uHwO/M3UCxL0
         vV3zV0JzG9G4x6UIEIPIeUMZsCO/o/dNFlOj0OsrQQUbPNf18z5O57XpAVQQQBOs/ZeP
         nUfUirlvml9LXMGl6E0phuPbc8a0pWYm3GnuWkgy51XFLnUrheHoHVOi9LlUwqscmYQX
         AheAbe855wqaQvpHR7NPREUCQzvPW8NHK8rxGmKglWSvWvJB6iC576siGmswqNxzS7Ai
         NO0On3HoDzMmeMuBBJPGwd8h0JeG3G27lym/MN9EJIu588KwgExFl9xqTPU8t3AG6kLY
         1AmQ==
X-Received: by 10.60.63.144 with SMTP id g16mr11010509oes.33.1387643016105;
        Sat, 21 Dec 2013 08:23:36 -0800 (PST)
Received: from localhost (24-182-106-91.dhcp.ftwo.tx.charter.com. [24.182.106.91])
        by mx.google.com with ESMTPSA id m4sm17542683oen.7.2013.12.21.08.23.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 21 Dec 2013 08:23:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52B5BD1B.5090705@web.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239624>


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2013 at 05:08:59PM +0100, Jens Lehmann wrote:
> Am 21.12.2013 10:48, schrieb fREW Schmidt:
> Thanks for sharing! Form a cursory look over your perl script it
> looks like it does what stock "git mv" will do since 1.8.5 (except
> for changing the name of the submodule, which I would not advise
> to do when only moving the submodule location in the work tree).

See, I thought I read that in the changelog; unfortunately I don'g
thing it does the final set of book-keeping (changing the .git file if
you changed the depth of the submodule in the mv and changing the path
of the worktree in the actual git repo in .git/modules)

I'd love to be wrong on that as this script is clearly not perfect.  I
think my second little script in my previous email re git submodule
bugs shows the issue.  I'll include it here for simplicity though:

 mkdir -p test/a test/b
 cd test/a
 git init
 touch a.txt
 git add a.txt
 git ci -m 'initial commit'
 cd ../b
 git init
 mkdir c
 touch c/c.txt
 git submodule add ../a c/a
 git ci -m 'initial commit'
 git mv c d
 git status

--=20
fREW Schmidt
http://blog.afoolishmanifesto.com

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAABCgAGBQJStcCCAAoJEG6zMC9zenWCEAEQAIG0T0z2yCfDIxHdafJ/ZSNv
SEUPV7eim/oY8UuG8Yp5crAZc8E3bwLp7u1gkWlfwZAFZ96TmnRhJe29Xb6Fw5t2
zdmIcSm94oZhYRr/nnyGG3dkTVwmP7fhBJoX2mkl1WSYPbh0tZIRYiehz5srhQcg
3UsNk3tE6DkxlqvgEFKNA+9Kj2JXQqV3jgCrRSdsi9KjD5SDg73IJY+/rFlhx5fZ
pSftf85DEXDAk7Njr+jaF3uJVC5MsBWi1rv2SUEAR0EjMS4jZA79M414Q31NM4Gw
E/fhJgRZi71vlZrjhmKpKLcJ00vwVYIPptoVaGtJaZuF/3mVjvIcp8IOANwoEHBC
4pCU80rnlEXboKiVSFPoA46qrR5SmteAomsjFR2xLXgn0gnFxev1Oe7xViYOsEBg
2vwVJWA6SJan3yavHxNEK47MkPZaVzRU6pYTlKzxZ3gWD9JWkvG9orILD9Ufg+0o
4IQiUfTdmJCWTizYC3JB1hoNK+VLYZYpW6zcSnqCGdWjmVSVYP9PE8+TulVWgyQ6
2cf4KYcq4YNqkvc6l6AZ6r0v4Rba41SOgc7BS/Kx4/OzBGMBWyTYU3sf0kelK3Su
X1r37uPYv5KgH9cDpcTDeIACRrOZqWQQnmvyeeYPPHKTX6QdwvfIX0aI8o5CD6a4
8gX1RnV9VJIn9NAN1jrl
=8TBJ
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
