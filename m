Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CC82866
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783851334; cv=none; b=UdOPDxMczZ0LUdtDRcKqZmY5kkOVm9rz8NJ5uumU7qSDU8Xnla4hUUmaIlkhylbT1SKJTvVpKCwceRNh777ofq+nKII+c8wxS9yLAdH4KjgKxIsYRV3x14lOEf7/uHmOECtNYd8ypos2s8mLK/8A8o5NljCPdq7emBefojRlTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783851334; c=relaxed/simple;
	bh=YyL3BuW27JMC+793nDAxUEx8e1dYxSPibRMt4h8tdKQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lxQX3eM6oIVpGyn9jcD6brG3EGDwe94sOf80ZDpGJSNChlFz9TNefgxTZQ8XFBDWmb7bISe40XbVkD4S6sXfQDLAxSe9rvDzV42kkgvscQIoslt7xjZqLlaCiHWx+FTWVoXV99iNWxD2McZIdYu2fqIuVrYHdRkNfHu4sde/Sck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=QD883akS; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="QD883akS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783851324; x=1784456124;
	i=johannes.schindelin@gmx.de;
	bh=W66wyvxfDX4+T/fnTtll/sKZhyFmG99usC2YKu0wbmo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QD883akSTBNghIKlmcwwslqfy58MHu/suzy7YrOq23eW6T4WlqETUeQpHfSc+G6W
	 OrzQrsRBpNnqIYtrtzsPqPJsucsK0r9+Kx6/gf6IoKWkQYeyxp0gQ9hLxCBljexDt
	 yobZaXOzHnhhXNl80lXzZ2iM595KW8yh93loxcqrxOl5+U0HM0Nr0ROQOefDDIgeb
	 Apd42NlN+52aPjX+pv596sLBhb4T8g7QJC+L6WmZUYrhLQ/rFjr0iIwtKzmeu60gJ
	 nLp2E2vbItw+pfOv/NpcUwbwhv+I4R7gh5Lwrc4EWRh9Cf5TQsAhS32kzPY+GGaYQ
	 G6qT1D0k10xsRpINbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNcz-1xGHYJ2DlP-00iFKS; Sun, 12
 Jul 2026 12:15:24 +0200
Date: Sun, 12 Jul 2026 12:15:23 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
cc: Patrick Steinhardt <ps@pks.im>, GIT Mailing-list <git@vger.kernel.org>, 
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix up lib directory move
In-Reply-To: <0c94331b-7eb1-4116-afa5-811082ad5854@ramsayjones.plus.com>
Message-ID: <ef422523-1c50-ec79-e89a-f43f02ba1ca7@gmx.de>
References: <0c94331b-7eb1-4116-afa5-811082ad5854@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:NpG1G6P0qgCos0RhXRR2vQ7riKB2RgL4AegQdv49EXw4hFuWyQp
 2Upnn+EcUrwdSzgjp96swRZppUUnMaKd7T/RpVnmGmvPynd+1GMYDt45nfpalrx/jrKIFDX
 Y+hinVJgcxViDRGlGoJeX1XGXjjy2Xw5qrIUvpeY2hbHg2fo1pbVXQ8NCipJ/1uCP88fuGq
 v6WjiNn4UdDjx5NtnaxCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JmuJJRESChM=;iPz5ezCATxiJvvsGps+hW/70mjL
 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
Content-Transfer-Encoding: quoted-printable

Hi Ramsay,

On Fri, 10 Jul 2026, Ramsay Jones wrote:

> Commit 9759608622 ("Move libgit.a sources into separate "lib/" directory=
",

It's not your fault, but this commit is no longer reachable from any
official branch.

Maybe a more stable way to refer to this right now would be to name the
topic: `ps/libgit-in-subdir`.

> 2026-06-22) moved some files into a lib directory, but forgot to update
> a sparse dependency in the Makefile, resulting in a sparse error:
>=20
>       SP lib/pack-revindex.c
>   lib/pack-revindex.c:78:17: error: memset with byte count of 262144
>   make: *** [Makefile:3446: lib/pack-revindex.sp] Error 1
>=20
> Add the missing 'lib/' prefix to the pack-revindex.sp path.

That reasoning and that patch make sense to me. Thank you!

>=20
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>=20
> Hi Patrick,
>=20
> If you need to re-roll your 'ps/libgit-in-subdir' branch, could you plea=
se squash
> this into the relevant patch. (This patch was created directly on top of=
 the 'seen'
> branch, rather than on top of your branch).

That would be 8da3a2c01822 (Move libgit.a sources into separate "lib/"
directory, 2026-07-01), at least at the time of writing (that commit is
still not merged into `next` and hence subject to be rewritten).

Ciao,
Johannes

>=20
> Thanks
>=20
> ATB,
> Ramsay Jones
>=20
>=20
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 703772ba4f..a36d2c1942 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2974,7 +2974,7 @@ lib/gettext.sp lib/gettext.s lib/gettext.o: EXTRA_=
CPPFLAGS =3D \
>  http-push.sp lib/http.sp lib/http-walker.sp remote-curl.sp imap-send.sp=
: SP_EXTRA_FLAGS +=3D \
>  	-DCURL_DISABLE_TYPECHECK
> =20
> -pack-revindex.sp: SP_EXTRA_FLAGS +=3D -Wno-memcpy-max-count
> +lib/pack-revindex.sp: SP_EXTRA_FLAGS +=3D -Wno-memcpy-max-count
> =20
>  ifdef NO_EXPAT
>  lib/http-walker.sp lib/http-walker.s lib/http-walker.o: EXTRA_CPPFLAGS =
=3D -DNO_EXPAT
> --=20
> 2.55.0
>=20
>=20
