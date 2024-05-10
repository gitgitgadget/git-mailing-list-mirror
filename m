Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B33CA6B
	for <git@vger.kernel.org>; Fri, 10 May 2024 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358796; cv=none; b=AA1mCTIOvubZypseAYBl33FVWgwzGd+fpf+gL7d2R2Z9uQDm+iUCvK9gpL1G3F902VfRqokvDs8Ur/0bE6q9NCvURF9bMLIZE6CyV+Snq+b58Er0jmSKYmP+0lGvzxa11hqtBQAMuHUy+d0Byg9/Pr07GZsUzjTy/cf8tg+JEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358796; c=relaxed/simple;
	bh=1SVOA7oob4lIPb/mDmbnjGEE1DUhSFoj1FAPv1ERzzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVk6O/F56GjF3FvPRDkLZkZurLguyCU75Pdda5mUH6h/WDmnRP485rdN3MQMy7LRtHB5nfRzGMX1uuICB5PqqDPLjoFBHYNpqJ1x602DdLyg4yWS7yo8/Igzy+bRBRClOy4VKXklXNe6OpPPbpmXO93KG3gjcgyoOKIQi+l1C/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIfvDaiL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIfvDaiL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41c1b75ca31so15576685e9.2
        for <git@vger.kernel.org>; Fri, 10 May 2024 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715358793; x=1715963593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+J6QbfCLgE5yqvmnlv9nJFB6SY4EDebUXOZJfDVuSM=;
        b=bIfvDaiL5+fqP/GfxlSqqPFvyQD6sOejmiebFq2oie3FoWqdOFKaDPgDaITTeYdGiI
         +z13J2nKhFymEWdC2yZjUTTmT1II36mVOQZMUL0+L21RX/ZhrRM+IBB6jED2BblVrTpt
         jJmYewTElSc7ratFbzTYzy6Sy2+AdXMhf1j/jqMTbYIEzZ5gtjflRzCn71BcLr/G6T/A
         bi5ff8X1DVXec7joR7JyHxZge1V+DTsHZzwy1VGm8CFHbt/G4a9Pxmrcp/fnDn9XHsV3
         p+Q15YhTEE9Zn4LHWRsEgYwdbi7imEzK1Eq7szuUoTMifi76+OyvI3GMMk9sZ0rH9FBM
         ns1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715358793; x=1715963593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+J6QbfCLgE5yqvmnlv9nJFB6SY4EDebUXOZJfDVuSM=;
        b=lhWKMHQc4QdvHy23/DFke0FhSsMvc6rvkQbxsBuYJWLkIv0UujkMWL+IbRHIySYs9Z
         +LXKaWR1Vf0D8g7DFndntHX1XEk0TIFKGw0h+bOM0K6ii38D9Y0LRpZZAtkUWUFVv7qU
         U8UmicWDsL2TUvdnVmQCYKugST9NNCeOmbtzBmroxMaMX5S0pFmOrTa9c34mGD+11tbK
         fwhhOIt+xxM5ivnz3UjDxQMq41y9mmRxioWpJJaZpk6fq/wkc93czlngRtsFEK9T1cvi
         FCtFkmThM4mLfMK91RW4+h9P143RG4QxB6IVwLJiudRURws05UZtLndYCl06nQ+3q8Yw
         NYSw==
X-Forwarded-Encrypted: i=1; AJvYcCVN7B43IYrc1UrVA4I0W3bn+B0xV61jWiGviuQ0vY9hulgDFp7k3Iwt2ljzaz0ypI5MVm8L8eFQy+QupTeLszHPrYlz
X-Gm-Message-State: AOJu0YyIGVY6/zBIhML6nO7mGk1oHX6yN+RIR27dka4YPyI/zBvv1vTL
	x3IGbN2zv0wYsDyvgbnmmE1n7HNn5A8bivLdwBpN/yjCWToR9xnU
X-Google-Smtp-Source: AGHT+IHiC/JUI3VEKwN6KJ3azIuxzwyu6X/85zZ6fOQPgHkXE6o5n+CVLI3JHIahX5fi58LJJXsJMw==
X-Received: by 2002:a05:600c:450e:b0:41c:2499:fa0e with SMTP id 5b1f17b1804b1-41fea931878mr28535565e9.4.1715358792741;
        Fri, 10 May 2024 09:33:12 -0700 (PDT)
Received: from cayenne.localnet ([2a01:e0a:d1:f360:88a3:1fd3:d5ae:2efd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fa6sm69497325e9.2.2024.05.10.09.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 09:33:12 -0700 (PDT)
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <avila.jn@gmail.com>
To: Helge Kreutzmann <debian@helgefjell.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
Subject: Re: i18n of git man pages
Date: Fri, 10 May 2024 18:33:11 +0200
Message-ID: <1968476.PYKUYFuaPT@cayenne>
In-Reply-To: <xmqqedacxdv1.fsf@gitster.g>
References:
 <Zjuokc2H0zI1JCVH@meinfjell.helgefjelltest.de>
 <ZjvHoykzIo34YJaT@meinfjell.helgefjelltest.de> <xmqqedacxdv1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Junio,

On Wednesday, 8 May 2024 22:12:02 CEST Junio C Hamano wrote:
> Helge Kreutzmann <debian@helgefjell.de> writes:
>=20
> > This mentions https://github.com/jnavila/git-manpages-l10n, so I can
> > point our translator to this source.
>=20
> That is a good move.
>=20
> Perhaps we should make the manpage l10n project easier to discover
> on our end to help volunteers.
>=20
> Possible places are the "SubmittingPatches" document in our tree,
> and "the Notes from the maintainer" letter that are sent out after
> major releases.
>=20
> Jean-No=EBl, how does the following look?
>=20
> Thanks.
>=20
>  Documentation/SubmittingPatches | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPa=
tches
> index 384893be1c..b36b3d9919 100644
> --- c/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> @@ -562,6 +562,13 @@ repositories.
> =20
>  Patches to these parts should be based on their trees.
> =20
> +- The "Git documentation translations" project, led by Jean-No=EBl
> +  Avila, translates our documentation pages.  Theire work products are
> +  maintained separately from this project:
> +
> +	https://github.com/jnavila/git-manpages-l10n/
> +
> +
>  [[patch-flow]]
>  =3D=3D An ideal patch flow
> =20
>=20
>=20
>=20

This looks good to me. At some point, the repo should migrate to a dedicate=
d organization (maybe git).

Best regards,

JN


