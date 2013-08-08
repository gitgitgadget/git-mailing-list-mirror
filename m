From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] diff: remove another ternary expression always evaluating
 to true
Date: Thu, 08 Aug 2013 23:22:32 +0200
Message-ID: <52040C18.4030306@googlemail.com>
References: <1375988103-29947-1-git-send-email-stefanbeller@googlemail.com> <alpine.DEB.1.00.1308082257580.24252@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8A34DFE03A62B26FBED90979"
Cc: Jens.Lehmann@web.de, gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:22:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7XfH-0007FV-TA
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966712Ab3HHVWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:22:32 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:35404 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966701Ab3HHVWb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 17:22:31 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so1755562eek.15
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=aGq7RihzY/NyfplFugSW4KwKytVsqRtJ4hp5+Ol4uec=;
        b=eAUtIpjFaGw3px63u3kPilp5m2HzrRH2NK4280ZMHxBu0Ufqz0PdaEekhbflm1Efg5
         DzMJsDlU4tGWclhPsLrhjlGHY7vYhnRanA5cf3CMnq2slnnHMUjeyqmZND2na/befeEW
         wgxNwdv7KEFxaQ70p1557hk+UKCqKmooE3hCsyj35M2vps5Ye0hqpQZ+EA8AlfRYTXP5
         +PWFf2j5yDGRejeDsXY+CozTNa8sVtjv+ykwz+3XPynnK4/8bOH6DnA30Na7/RlTrf+Q
         0pKjZfpy7LqIaCExhK9exYQ8nmMhZh9fF1/V0LL5aVprbTanZLrYPnFaCSq8C+BIMYSg
         IhQg==
X-Received: by 10.14.69.206 with SMTP id n54mr10016573eed.118.1375996949780;
        Thu, 08 Aug 2013 14:22:29 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id n42sm22702297eeh.15.2013.08.08.14.22.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 14:22:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <alpine.DEB.1.00.1308082257580.24252@s15462909.onlinehome-server.info>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231935>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A34DFE03A62B26FBED90979
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/08/2013 11:01 PM, Johannes Schindelin wrote:
> Hi Stefan,
>=20
> On Thu, 8 Aug 2013, Stefan Beller wrote:
>=20
>> The condition before the changed line dereferences 'one' to query the =
mode,
>> so if the condition evaluates to true, the variable one must not be nu=
ll.
>=20
> To show this better, please use -U10 (or some other appropriate context=

> option) in the future.
>=20
>> Therefore we do not need the ternary operator depending on one, giving=

>> either one->path or two->path. This always evaluates to one->path, so =
we
>> can remove the ternary operator.
>>
>> The condition and the usage of the ternary operator have been introduc=
ed
>> by the same commit (752c0c24, 2009-10-19, Add the --submodule option t=
o
>> the diff option family). As that commit message refers to a GitTogethe=
r
>> I'd assume that patch was crafted in a hurry, so maybe overlooking the=

>> need for a ternary operator there.
>=20
> If this is my code, I do not need a GitTogether to excuse my sloppiness=
=2E
> In this particular case, I imagine the appropriate fix is to test for
> one->path instead of removing the conditional, though.
>=20
> Ciao,
> Johannes
>=20

Ok, here is a resend with -U10
I forgot about the -U10 as gitk shows a different number of lines=20
of context around. Is there a way to configure gitk to show less lines
of code or a default -U10 for send-email/format-patch?

So you rather propose to have=20
-		show_submodule_summary(o->file, one ? one->path : two->path,
+		show_submodule_summary(o->file, one->path ? one->path : two->path,

instead of the patch below?
(The test suite run without any problem using that patch)

Stefan

--8<--
=46rom 3a580c51f0bf70745f26eb5045d646dfead2afd3 Mon Sep 17 00:00:00 2001
From: Stefan Beller <stefanbeller@googlemail.com>
Date: Thu, 8 Aug 2013 20:54:24 +0200
Subject: [PATCH] diff: remove another ternary expression always evaluatin=
g to
 true

The condition before the changed line dereferences 'one' to query the mod=
e,
so if the condition evaluates to true, the variable one must not be null.=

Therefore we do not need the ternary operator depending on one, giving
either one->path or two->path. This always evaluates to one->path, so
we can remove the ternary operator.

The condition and the usage of the ternary operator have been introduced
by the same commit (752c0c24, 2009-10-19, Add the --submodule option to
the diff option family). As that commit message refers to a GitTogether
I'd assume that patch was crafted in a hurry, so maybe overlooking the
need for a ternary operator there.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 diff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 80f8439..f30b7e4 100644
--- a/diff.c
+++ b/diff.c
@@ -2245,22 +2245,21 @@ static void builtin_diff(const char *name_a,
 	struct userdiff_driver *textconv_one =3D NULL;
 	struct userdiff_driver *textconv_two =3D NULL;
 	struct strbuf header =3D STRBUF_INIT;
 	const char *line_prefix =3D diff_line_prefix(o);
=20
 	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
 			(!one->mode || S_ISGITLINK(one->mode)) &&
 			(!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del =3D diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add =3D diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_summary(o->file, one ? one->path : two->path,
-				line_prefix,
+		show_submodule_summary(o->file, one->path, line_prefix,
 				one->sha1, two->sha1, two->dirty_submodule,
 				meta, del, add, reset);
 		return;
 	}
=20
 	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
 		textconv_one =3D get_textconv(one);
 		textconv_two =3D get_textconv(two);
 	}
=20
--=20
1.8.4.rc1.25.gd121ba2



--------------enig8A34DFE03A62B26FBED90979
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSBAwYAAoJEJQCPTzLflhqPa4QAPAJxRIHU8JbwUQYbvPJpOyx
CNq9riVXL4ttSJl8WxSKU436I6teD0yskH5kJAc6qPZWjiTS1p9I25kMoZwPWzuu
xzI3/Mg9fXXOgCbnWj0tZpRqqqnwzjt8rAT64fdY16l7gcsEx7cgWDPCEEpurghY
aO2iNi1Ve+WiOHdOOmBEq+Te11wzXbUJj31nydLCRwIYvf+Pb3nVFsNZKDkjLWLW
qMLSkGaDE4QjsePs9g6tC6g2JDUyCkLUacIUwM0RwTYYKLZhVxrnmLbTfzI02QBR
b7Wh0HllXHfIyC2lOBIhu43rID/sZISJwT8F0XoCB4jUBoMGez3n5TGvKT2tBdsX
/XNBs8fefl0LXHYUrK1rQBtTjhXL9ZjyKkkr+PmnGKbs8HObwjYKt3f3YTptGskh
psLQ+Xb7jeCm7m+KV1g/V2LPQlgBBajRqsw9S/2RiHdFcYme5Q+WPbTg7hdd0Ebt
ytn3cnCtTD2X5c0PmYCi9l462VMZFhQ1ijy6j+vwrfuV7Ni1mbXPbFN7fTM1fTqH
z5ZCDRdAKia7SEx4XcUr9EB+D3ATlFXEWrGe4+DJ8UdG7BuWdZfFC4R34xeGL2JC
qLwJ9ihq1cL6quhob+Gms0iLzKU1KWBwuZTeHAQwlxiMy49YQD/Psnf7m34/7jkq
61PCMQFRZy8k1bduQxwQ
=uH7d
-----END PGP SIGNATURE-----

--------------enig8A34DFE03A62B26FBED90979--
