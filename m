From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Rewriting git-repack.sh in C
Date: Fri, 02 Aug 2013 15:48:59 +0200
Message-ID: <51FBB8CB.8020600@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8E5678D8758859A3FD885EEA"
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 02 15:48:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Fii-0000PB-4B
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 15:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab3HBNsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 09:48:36 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:55693 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845Ab3HBNsf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 09:48:35 -0400
Received: by mail-wg0-f50.google.com with SMTP id m15so534681wgh.5
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type;
        bh=onqD3TGRWmiencgJ5hhTQydBJyEJNXEH6egGnKYMczs=;
        b=FQBsXpPNJQmpYG/wbKzWPWQ0VjI3j8cgnahsU6UiVI7EPkYcUg1sTqI86doPZKt1Px
         ZzCIGypXSEP298/W1PZiOPgJ1ddA13FdGI4wsLlq/VVqlyHRVra5PEchHBxQJ+n+xEXZ
         SDZgb9/jcUhZR/3E4+35WRKtoBhKeTEcC9NNW96O4F+WvO36iefVOCN7u7Ff3cXTIJ+i
         7aWrJb11Rvuy8r/Vb82/SbDsQTLpGfmyTXd0cC5upjmCfEwqY8PaxPPMzMDB/mqrsP6Y
         PWh7M8mi3OuiTVoBagkmwxKQGNrf7evcnCKN6LLPQUtax1ZERe9DiMQmMPfX6Ih63pzZ
         i1WQ==
X-Received: by 10.180.198.79 with SMTP id ja15mr1929569wic.36.1375451314126;
        Fri, 02 Aug 2013 06:48:34 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id li9sm3481767wic.2.2013.08.02.06.48.32
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 06:48:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231523>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E5678D8758859A3FD885EEA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I'd like to rewrite the repack shell script in C.
So I tried the naive approach reading the man page and=20
the script itself and write C program by matching each block/line=20
of the script with a function in C

Now I stumble upon other git commands (git pack-objects).
What's the best way to approach such a plumbing command?

I don't think just calling cmd_pack_objects(argc, **argv) would=20
be the right thing to do, as we're not using all the command=20
line parameters, so some of the logic in cmd_pack_object could=20
be skipped.
Another approach would be to use some of the functions as used=20
by cmd_pack_objects, but these mostly reside in builtin/pack_objects.c
They'd need to be moved up to pack.h/pack.c.

So my question is, how you'd generally approach rewriting a=20
shell script in C.

Stefan






--------------enig8E5678D8758859A3FD885EEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+7jLAAoJEJQCPTzLflhqbTEQAOYgPxiR49JNTbDkAioDIzzp
nLsO46qucZkApc4PfGALjoUJW+XHcsEtSw1z+R9bgKigNLIwSPijCeTrfgyiZVrY
KyhVxg7uYbETPZQUem23DIATwfqzkz+wkmJ0NPpX6x8IClQkBY0nwNvcaMsjgxTG
OhftNEkNGVRJqiMpPgu+Lw3uZB/1UviO7AEyibLARSLl994xmaK5IjC0VkfMi80j
UIEPGtwUSQJX4mW2eUWELJBNH8usD3b9KZDbT2ie0I7pCuFcI2vdbohrZxXdimND
97H3U83AXzgL81Rvq2IQpCxbyM0rfuTHCvJlIGmjCgBFgXtQnqURkxmWaOgXgMvP
46f+FbCHBwgm7UclIhRTI1p51tE2VdCtxP4u+2Rk0lsabc3niK6Qt1YJV43s1Rki
yCxWGLCpHgmZoN3VRrsBVYvCChg0cjUyuLT9pZjmY/Kz3EIwVwwjwbDMdNPLX3AH
IqyKx+JM2On8Xb+cnUHq4WO6LBa/F1BMH3av9mmsqo1ghPcjqMgsvPvJbg+Ffhsk
N4SDxe0vXa+7lPb4D3NUHOlF7WX7J/B7l2K31+WfDv10SvMJiywDFHlANNTqBJsk
7JFh8pjuHfZ/mSk9U0+U2klLrGaHcQZHYqstBv8G2iyCHJRLzZ+F93tlThxsNI8F
QDDdwUGcgbX8jZVVI6k7
=fjpZ
-----END PGP SIGNATURE-----

--------------enig8E5678D8758859A3FD885EEA--
