Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B71F131A
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777205660; cv=none; b=tT8r7bg7s4/zs0gqR8QmasNslKUT/F23kr3y1YG11AV/QEP3MOq9p74GXjvATmDChXA5AnZV9h81On9PbLSdF1M4xzbAze97AVpucNFKNc9h3R6Q4cFMYNDX3NbCv1rnW9sWJVd7qmlpG+/ov8e0Hlv47bi98xA1e5k9HPzgdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777205660; c=relaxed/simple;
	bh=cRUGGUxJe9HcXIhdWfGJT2RpheGSvl+u5fPOP0ZssGc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R5grLo/Gi2RIq+VZqK7eTm3WUR/OtUDbKl9hbCfSdGyM/eFDqXfY5501r2HAobDPnevwMqbx1I2dlzeZaI7zNugXvhQtiMd21ucVpK0K9RdLawXQjXNa3J5eNxCgIWxX/fS0Tpd1cv27sxSKNNDKoWwJuXqtwNnQuH6NHLS31Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=J/2c+5wP; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="J/2c+5wP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777205645; x=1777810445;
	i=johannes.schindelin@gmx.de;
	bh=5pw9zkvCeNwPzTqu9A9al+nkHjg/jpPu6CQARSQDBTg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J/2c+5wPMzz5wJGpkKbE2JfS5BL09LK7MJ858c4UMT2vshi7aCKfPKueOJr45UlV
	 ajyye1IHeTjhc/toUrvYZ17MFlOrLxNeOpDik658AYnnCVcl8Obwv54nNlFcWaspB
	 lCPzTMa2tCLV62dm2RizIYXXmgyzMeaD3mQ/YZJcXgZHlNpGDNvOj7g32NgoEv+Tb
	 TWzMmImAEPU1tPxutBDQeaueormRvgHXnpwUKhq9z+acHUHoMRlDPwOuggmW823+p
	 QpkOSBlV/1w5wj3LD4d/z/uKxsaFkIfRR+TqOmZqma0VMf5+XF51xp+gSP05jfaDC
	 WofcWmj83llV6EwFWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1vITPG3EOF-00xqqF; Sun, 26
 Apr 2026 14:14:05 +0200
Date: Sun, 26 Apr 2026 14:14:03 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Jiamu Sun <39@barroit.sh>, 
    GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] parse-options: fix sparse 'plain integer as NULL
 pointer'
In-Reply-To: <CAPc5daWZUJA0sEqS4Qk2vn5x+LNRgphxjzjdbcLFpEgS+69kUg@mail.gmail.com>
Message-ID: <d0357af8-ce70-77be-a885-070420d76c0b@gmx.de>
References: <7aac2206-8b60-484f-a5f6-4943348ad3f6@ramsayjones.plus.com> <CAPc5daWZUJA0sEqS4Qk2vn5x+LNRgphxjzjdbcLFpEgS+69kUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-819879958-1777205645=:26638"
X-Provags-ID: V03:K1:vnzyPFaqy1m4sYJ0+aGrHKB+UzBd4A2LkwCEq4Kiuj+/tCkIwSB
 cPXTUSDdOUGPWOwPoUAdZSVHtk6U1yLVmAVIK30VL9LseGlMpbuNihTXCJamU484mp/cPKo
 iQYn2JzqWsn8QdkTlp20DT0iXiZN+rLz+Clkqfzq7GBVJZRm0DcpRzI6ReltGvFpb38DDtf
 pQAATQSbo5vGU0gdLTX3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:td9Nz9GLs3Q=;d1SAntaK4bJQ2BJSCsWfViLFkAP
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-819879958-1777205645=:26638
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sun, 26 Apr 2026, Junio C Hamano wrote:

> Another thing from GitHub CI
>=20
> https://github.com/git/git/actions/runs/24825391649/job/72659919418#step=
:9:144
>=20
>   Error: parse-options.c:680:30: comparison of integer expressions of
> different signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare]
>     680 |        (n < cmds->nr && best =3D=3D (intptr_t)cmds->items[n].u=
til);
>         |                              ^~

Indeed. With this patch on top of Ramsay's fixup, it passes the build:
https://github.com/dscho/git/actions/runs/24955417618

=2D- snip --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sun, 26 Apr 2026 11:11:35 +0000
Subject: [PATCH] fixup! parseopt: autocorrect mistyped subcommands

Fix a build warning in `linux32`: Change `best` from `unsigned int` to
`intptr_t` to match the `(intptr_t)` casts it is compared against, fixing
a sign-compare warning on 32-bit platforms where `intptr_t` is `int`.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 parse-options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 14f3f385eb4..0ba6905fed5 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -648,7 +648,8 @@ static const char *autocorrect_subcommand(const char *=
cmd,
 					  struct string_list *cmds)
 {
 	struct autocorrect autocorrect =3D { 0 };
-	unsigned int n =3D 0, best =3D 0;
+	unsigned int n =3D 0;
+	intptr_t best =3D 0;
 	struct string_list_item *cand;
=20
 	autocorrect_resolve(&autocorrect);
=2D- snap --

Ciao,
Johannes

>=20
> 2026=E5=B9=B44=E6=9C=8824=E6=97=A5(=E9=87=91) 1:05 Ramsay Jones <ramsay@=
ramsayjones.plus.com>:
> >
> >
> > Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> > ---
> >
> > Hi Jiamu Sun,
> >
> > If you need to re-roll your 'js/parseopt-subcommand-autocorrection'
> > branch, could you please squash this into the patch corresponding
> > to commit b9e6a2d30a ("parseopt: autocorrect mistyped subcommands",
> > 2026-04-23).
> >
> > Thanks.
> >
> > ATB,
> > Ramsay Jones
> >
> >  parse-options.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/parse-options.c b/parse-options.c
> > index d60e7bd3c9..14f3f385eb 100644
> > --- a/parse-options.c
> > +++ b/parse-options.c
> > @@ -658,7 +658,7 @@ static const char *autocorrect_subcommand(const ch=
ar *cmd,
> >
> >         for_each_string_list_item(cand, cmds) {
> >                 if (starts_with(cand->string, cmd)) {
> > -                       cand->util =3D 0;
> > +                       cand->util =3D NULL;
> >                 } else {
> >                         int edit =3D levenshtein(cmd, cand->string,
> >                                                0, 2, 1, 3) + 1;
> > --
> > 2.54.0
>=20
>=20

--8323328-819879958-1777205645=:26638--
