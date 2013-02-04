From: Robert Clausecker <fuzxxl@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Mon, 04 Feb 2013 13:14:05 +0100
Message-ID: <1359980045.24730.32.camel@t520>
References: <1359901085.24730.11.camel@t520>
	 <510F9907.7010107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Yfzb9nmPbiPyxycE9XSd"
To: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 13:14:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Kwl-0006ZT-MR
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 13:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab3BDMOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 07:14:19 -0500
Received: from mail-we0-f177.google.com ([74.125.82.177]:40418 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab3BDMOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 07:14:15 -0500
Received: by mail-we0-f177.google.com with SMTP id d7so4724858wer.36
        for <git@vger.kernel.org>; Mon, 04 Feb 2013 04:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:date:in-reply-to:references
         :content-type:x-mailer:mime-version;
        bh=6PlyVFGjxlPoyvMOPOI/5EnOZ63g5b+em++fL3sPXaY=;
        b=IjRKogN4zbvRE4ncrYsthhXAKbLHSLgR0VednWXpO0vvgbip1Rh0MqFUIStQUiHLl5
         sHxdQmUZwQ9EplS9gKIl08xpVpSzjzhhHlBhjUvettSXds+8wsBFLkRV+2boCJTiTHOr
         XrC1FyfpSswYzqB5w9cq0nxx72zjqKXW9r6L/uoJ2Ocr0ubUP85SzbQ+qaFbfc0fyuzl
         bh8j+9tBkYCQzFiLs3z4ZImmg0W7wGCtDmFmw5IZJVhl/J0VWM8BCPdEJLS8aPk2hQ+F
         zKqH0BXFOftjTscBD43lPxAZA3TSY5ak0xO6FzI1hy4aNF32AslQUAVhZOCPEaX07lGu
         luxA==
X-Received: by 10.194.242.69 with SMTP id wo5mr34721058wjc.10.1359980054006;
        Mon, 04 Feb 2013 04:14:14 -0800 (PST)
Received: from [192.168.42.248] ([2.208.120.198])
        by mx.google.com with ESMTPS id e6sm21207517wiz.1.2013.02.04.04.14.12
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Feb 2013 04:14:13 -0800 (PST)
In-Reply-To: <510F9907.7010107@drmicha.warpmail.net>
X-Mailer: Evolution 3.6.0-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215376>


--=-Yfzb9nmPbiPyxycE9XSd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Montag, den 04.02.2013, 12:18 +0100 schrieb Michael J Gruber:
> Sitaram has said much about the Unix philosophy already, and Konstantin
> gave a variant of checkout. Just two more cents:
>=20
> How would you copy a directory tree? I presume you wouldn't use "tar c .
> | tar -xC gothere", but what would be your worklflow?
>=20
> Depending on what you actually want to achieve, "git clone -b branch"
> and removing the superfluous .git-dir might be a viable option. (Beware
> the hardlinks, though.)
>
> Michael

The specific workflow I am planning is this:

I have a server that hosts a bare git repository. This git repository
contains a branch production. Whenever somebody pushes to production a
hook automatically puts a copy of the current production branch
into /var/www/foo. I could of course use pull for that but it just does
not feels right. Why should I have a repository twice on the server?=20

Adding an option to put the tree of an arbitrary revision into a
directory is something that improves usability as it is an operation
semantically different from tar. Saying that you can already get this
with git archive and ad-hoc unpacking is as saying: You don't need cp.
Just tar the file and untar it somewhere else.

Of course that is a possibility but it does not not feel right and is
not intuitive. Adding this feature won't cause feature creep but would
rather add an operation that makes sense in some scenarios and reduces
the dependencies on other commands that might not be available on other
platforms (If you care about that).

Also, this functionality is in full accordance with the Unix principle
as it is a basic operation ("put tree into files") and not something
super special. Also, it always feels like a hack if you do this ad-hoc
unpacking. Like "git can't do it the simple way".

Yours, Robert Clausecker

--=-Yfzb9nmPbiPyxycE9XSd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJRD6YNAAoJEDpa/qG5y+V56zYIAI3jGpBd9CwTMwkm2+DXsepI
bWQWlCpK6x2SdmxQUbhmWPewh9XGiN+dy835L6ogcmJgbd3s+OuEi74+lTnyerXu
iHVqHHZpViaoMp6LvIAic9szkR3PUcGK/fSwrgpjvBOygaPrxCcmZzUqYf3C33rO
SB10I7Df9KWxxoMDT4lIlP6bDAH6cn/8rsSUS5/ewDtwRzxYkQBPgBZHDCC7nfd7
8N7BluRisdYa4/lrHHJHCaPhsCheY3UVB7QV0tur7YByEbYZcd6kjYaTXJDsad26
WQZn90dyyZbzek+c9CC/cZOHJy/Pg8k7gCzzxJJ0pZycGrFIW/OdrO3vJkM6O5M=
=ySF+
-----END PGP SIGNATURE-----

--=-Yfzb9nmPbiPyxycE9XSd--
