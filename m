From: Marcus Griep <marcus@griep.us>
Subject: Re: [RFC Redux] strbuf: Add method to convert byte-size to human
 readable form
Date: Fri, 19 Sep 2008 11:56:42 -0400
Message-ID: <48D3CBBA.8060507@griep.us>
References: <1221279997-9336-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8FC393904163CEC817A40190"
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 19 17:58:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgiN3-0004pN-3K
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 17:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbYISP5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 11:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbYISP5D
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 11:57:03 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:13769 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbYISP5B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 11:57:01 -0400
Received: by qw-out-2122.google.com with SMTP id 3so51825qwe.37
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:sender;
        bh=mUHBUWt1n/pFBdV2a0PX+5/TdZADNeLTV88Z/0clIyo=;
        b=n5rzlKA0xebuh4JtA/g95bKBM4JQTdw9TgfV+35zlxfv9DDnOuv3851yE0kKszlxP4
         FZW7m/+Jp4oyjiRXzkdy0ZUW0g80lGGVlkioIwuU0MOid5CQF5B0Z7I3MiWoY0Umvtz7
         X8w/QrEX4+0WaKG62lJcCOuwqrVe3Imbchngs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type:sender;
        b=lQRCR3HeMZJrU/Y463/T9VWJEoxFcCXCnGcUqTYUJBuBiuWM1P2F9dqZlIiVz7B7x9
         b6+Xgms7cfr6TsngbHmB9Xg5nGLNPzwo7cJUKJ/6MllSRr0M+rigHcElsHAgWcltWbeI
         jy8g1PjXPRxnJ8wRGNAqHDkiQ7cfeAvaIBfXg=
Received: by 10.214.12.19 with SMTP id 19mr338991qal.43.1221839818566;
        Fri, 19 Sep 2008 08:56:58 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id 2sm1116823qwi.5.2008.09.19.08.56.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Sep 2008 08:56:55 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <1221279997-9336-1-git-send-email-marcus@griep.us>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96297>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8FC393904163CEC817A40190
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

If there is no comment on this, Junio, would you be ok accepting this as =
a patch,
even as a feature-branch on pu or next?

Marcus Griep wrote:
> Takes a strbuf as its first argument and appends the human-readable
> form of 'value', the second argument, to that buffer.
>=20
> e.g. strbuf_append_human_readable(sb, 1012, 0, 0, HR_SPACE)
> produces "0.9 Ki".
>=20
> Documented in strbuf.h; units can be directly appended to the strbuf
> to produce "0.9 KiB/s", "0.9 KiB".
>=20
> Supports SI magnitude prefixes as well as padding and spacing of
> the units portion of the output.
>=20
> Also, add in test cases to ensure it produces the expected output
> and to demonstrate what different arguments do.
>=20
> Signed-off-by: Marcus Griep <marcus@griep.us>
> ---
>=20
>  This is a redux of a prior patch as part of a series on count-objects
>  but is now split off and submitted on its own as an RFC for a library
>  function to be added to strbuf.  If accepted, I'd like to standardize
>  upon this method for user visible byte-sizes, thoroughput, large objec=
t
>  counts, etc.
>=20
>  Provides similar functionality similar to the '-h' size output of du
>  in the default case.
>=20
>  Based on master, but also applies cleanly to next.
>=20
>  .gitignore                |    1 +
>  Makefile                  |    2 +-
>  strbuf.c                  |   92 +++++++++++++++++++++++++++++++++++++=
++++++++
>  strbuf.h                  |   30 +++++++++++++++
>  t/t0031-human-readable.sh |   49 ++++++++++++++++++++++++
>  test-human-read.c         |   23 +++++++++++
>  6 files changed, 196 insertions(+), 1 deletions(-)
>  create mode 100755 t/t0031-human-readable.sh
>  create mode 100644 test-human-read.c

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enig8FC393904163CEC817A40190
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSNPLxQPFruyc22R/AQJ7MA//atcAJVe+uXyAe/G1/PNJR61E0bTZ+nu7
Eg91xhrYGdEhbTdb6m7b0Q2mK+aZedGxiC9MEahgX4iKjXu/BLj4bnuX4mO+vMnw
4KIcoA4bAY2zf9ZPPU3OyZcrf+dqEvfE1Kf8H9rFdQ5M6nlGE1H+c9qw5yfCzZhl
p/iUOzi33AbG0lfoBjqg390WxBgST/bbATRMtKLAJzZ31v3C81bSfnjwDVTpIHj0
MDAWMtWeehUXNkRU003UbDk94xFxsyYcJOSCuG9LYg8BXh2XddphCpy7s7UNxySH
f/NQGuc2aIgq3UqDSQ6RFZTPDOZZyrwrIgU/P8GLaYmztGnFs+xfvTSHvY+6g6I0
GQxK50sprbXxY2cFuE4q9ldwD+paYbCbiQ+GWNPFuFrMLbv8sNWaUlf2V19rtYvH
0nMzWOPi49Kpo2uZabi5BrW4carQ9vREXxebs/JeLZG+QzF0l3Rk7bNHDAiAPYlQ
tz/Muwn6GQXgEeT8usSZEipMl9hs7KtJ9F2YZwdGzHKwIM4aB5uqE2kIX2AWX62l
qdijppsmHsRnH2JGSASGTTaxQIfXEHAwo7qd6CvAtSaD1BQd516x1GpLk11mdw05
rVdLidOplDyxP1gI41Zf62M7lLykouZUfJt1Yt24jPK7/9nokqy77ieF7VyzWOpt
qc1vvIRDvjY=
=oa8D
-----END PGP SIGNATURE-----

--------------enig8FC393904163CEC817A40190--
