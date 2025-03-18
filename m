Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F419F40A
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742280240; cv=none; b=HUXZ+TvjGLG4B0cgwYN7MiC43RLLacsqlA01TtNpxCvEDJBCCLJ5mtKarv3EKNS2CuKkdMK/bDx5vP2zj6v+uVOfhr8NymPqLn6aJ18gorrCEZLrtp8IKE/hLRcdqdYqZ7aOS6Mwieo1yfAAiVdw8LWNPPph1TQ7pdongL9tMLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742280240; c=relaxed/simple;
	bh=siuzb3n8e72mdGvjqbku8Y68BG66jsb01foOxB7zo8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1se7IF71SkhaP0qL0fpq7e5wMupnM1ZjjXy/Hq2I5HNgOoLyWUkCRfAyRusbuy696WjqCoumH6gEtpR0JFOOFCia/aVkoSF5IZc8mz1CmbBQsMh7G44DQu3BqSLs43zXDK2jlTPeSxq2MYt2uhMwgPBSwS9fpmIFcOu+UXn/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0ZuBssb; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0ZuBssb"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85df99da233so89394039f.3
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742280238; x=1742885038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpNG0wsVoRo2FWBtIwtcBoWA7qaqdPY//t3QRJBwJuA=;
        b=f0ZuBssbk9nlazGBSV0UlOmP76TdhwlQozPJ8wqK8RY/DgRWUkLXZTqt+xkhPkSFpz
         bYS18Ck/odxO60KMJRtWB6dDxfA9bex7tug8xJQznh98XwYBDSX6cCvt+yXT7tGwni1d
         zTpHwpL7QFafz7E3khm6T3OEtLhWmsz0368azMD1ddSnxLDNUUx5vR0X7zCyTF9/IllU
         TrKZqMjQvwhxQmml281cZQFsgHYgVDo2d0XNYR9jycL3QQwFkfXD6N2ztEVy35JvpgNs
         s0kCkDL0DPXBrUfyXcAekSKzCmv/UkEUi+N+f6BMxSf7nLKmigdcWmgiFKZauIiHMpuJ
         wx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742280238; x=1742885038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpNG0wsVoRo2FWBtIwtcBoWA7qaqdPY//t3QRJBwJuA=;
        b=D069oFBx4Cq8n0sCo7/db8PQj+QHassmoGPuY3gBapxkhtcbudzqsiOrJhrPwRa1Uj
         UotlzMVvUz5YAvR2hblZA3Cj4D/xBpMZqkcAJGfKOgQWkkcLG3gObTkW5OwnDnrbDVdy
         WNBX/F+L1Y5G2LGcnnGvRvvY7aVgooreMDmmm/aPu1QrcSr5txfekRuxQYm/IT56VkMq
         uVMUD3SboLSGGiUUriwiaFFWwgJrp5yacA5GIlbAm2pR2mwNQpuflq5eT80XZhIxtJZC
         KVb6FzHtPzV4M+rE3AmiEcC/BA/VElV8z6rQOZiZR5YOZoljtOgx51SHset8f/4HkV0O
         JpMQ==
X-Gm-Message-State: AOJu0YxLk6uQJsQ5PljfNwz46R6hVpSaXUNXhjSbtXVfNEQShgTbEs8K
	uKe+Fx3ql4K3/oMPPiDB4fDnGW6ZFbk8t43dDC5LSLIpclS1HQ4N+sOHqaj+ojeRPKYuKyueKC4
	5N+iDxr+YCimYa8DGFUarKBaHJN0=
X-Gm-Gg: ASbGncupmeB6mDimbsNT1WlnTSJDNsCxNsRwv7/eIL/YY80w/hOldR2fJpJ+ufGWexa
	gzTWFAAh3xPgU7cTX14ZkExNQI5h6wN7dLdl13NubV5BiBy56HiG6efTjjmxGorPi7HQgTmOC12
	1e34pwIUUg9WScmg51/IUjgpU3akRcEUPeV5viG+yc1fwYLMg9DmuljqAEagA=
X-Google-Smtp-Source: AGHT+IH6e6ax+sQl52jN1j7U7Bpleb8XAW3PfhO6e7xVLEbGlsVXoDRlGqsncYzokW+Y5O7J6CuQPqseG3Wd5O6UHBk=
X-Received: by 2002:a05:6602:3710:b0:85b:577b:37da with SMTP id
 ca18e2360f4ac-85dc48782e5mr1801466939f.9.1742280238358; Mon, 17 Mar 2025
 23:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723755667.git.me@ttaylorr.com> <cover.1741983492.git.me@ttaylorr.com>
 <a29f4ee60d519318d36a8d3c812b4bad039b891e.1741983492.git.me@ttaylorr.com>
In-Reply-To: <a29f4ee60d519318d36a8d3c812b4bad039b891e.1741983492.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Mar 2025 23:43:47 -0700
X-Gm-Features: AQ5f1Jorgbgkmly7KChDenZRMX6iu7Bpr4VpUunY4XA-PTAQRz18mbLFGI-vxRg
Message-ID: <CABPp-BE3dfXa8xda2M2zMH_Qhf_RPggBpC=tx8qaDpCmbr9hWA@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] pack-bitmap.c: keep track of each layer's type bitmaps
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:18=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Prepare for reading the type-level bitmaps from previous bitmap layers
> by maintaining an array for each type, where each element in that type's
> array corresponds to one layer's bitmap for that type.
>
> These fields will be used in a later commit to instantiate the 'struct
> ewah_or_iterator' for each type.
>

All I spotted was some possible wording fixups...

> +        *
> +        * When either associated either with a non-incremental MIDX, or
> +        * a single packfile, these arrays each contain a single
> +        * element.
> +        */

Drop the first "either", and the first comma?
