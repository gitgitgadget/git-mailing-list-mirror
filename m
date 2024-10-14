Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858FA14AD38
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943072; cv=none; b=P1HDt65g/rZBdjTk2r9H42FKjQHuYLGjLZ4C1XvyUyPMcO4rmhD7JPub2Ydy0acJN7JhqWIhpH/GxUobMXKd82x57Givper7JXtKxtoAUVYsbaVu545fqi0f/oZ5ktWKUeWJ1ibnxsTyH/0jckWX8dE0PfpgGbPL5pyJSTA59Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943072; c=relaxed/simple;
	bh=ZMwnVXC1KjJ1YL3q7iSquCatuhIXpJzUc1eDBS0RNSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nq8ZR2/Az3mHBEnECSTqIjLgwub14XhZmRN7eqECecwGiqyBRNcQmYlXJ+p1qBTS4av3gDygzQOzYU5KXcBa0zSCRriDTJ2gCfxwsjIRnuBjH2yRkCB+/LIAZdDXVbgfXHUhx0u4BmWYbk5BSCc4TcNRqmP04BDEKKWg+cuPOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KL8KpCSx; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KL8KpCSx"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e34fa656a2so26701437b3.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728943069; x=1729547869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/kjMbKd3YBAl0XV0FjXB/bsupkMQMBn70h2uXHDpFLI=;
        b=KL8KpCSx0sk0Mhk0hPxSFsNrfCl2M24s3U2mxOTk1rhi28RtkTVIujcaz6VOiutulJ
         ap/cr09Tc3dlnML+gD/XUVoPDvPx7ndNItVRwBDDhWeq2Iq/x7ibgDYhSSh6gnsOM6+k
         b6ATbwM+4IpvowxHirFBfAZTTdfCeRIp5mGTW0pudPkslvdER3IIEDwPSs/29pHoJwKI
         11P8w4VipNPkT3jJWQxEKWlO1Aj/CGeCEN8QeGLFyLta85e6WG0WmpYGfqkTqTtxLFnF
         Y2Wf7DuMBOod/t91jhQjmw+KVGYrQQjU+v9sZues36hCu0dYN/pcS0+MBDnO91J35dpW
         0s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943069; x=1729547869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kjMbKd3YBAl0XV0FjXB/bsupkMQMBn70h2uXHDpFLI=;
        b=pTLf7uCmSITAS5rZfKOL4lQEIX6odiJuZsEfUCLuRAsyPRlxmNEbd9KcKGb5MYcJHB
         gekfF2lwQLWn/s96ncagoU4PyEEmMpiDskBTOX59Nm4cEb9DbelsWuLGnfuWzxEBinBS
         ttQxRNgL/hMgR03WNtN/35JCPg28Sw7GBCD3z794dnAgU8eu4q/DvzHgrq7TD8Cby9bx
         a+QoebOcRXCMx3IPQFJq+IDOVC4blNKeXvm0x5Vy6UrkMJOCIiYm5CaFfTFQ5wKnUWK0
         ge0EWGy36vZGujAwaUhVCvaiORhFPpckMmejoIvJwsDIzQJjzF2lV4dDv4eIep50MLNO
         LHCA==
X-Gm-Message-State: AOJu0YzYYheDHmMopTb1bSk4WiIM03OBoUiPqaPfnecK+xib7tiIzKXP
	RzWK+YnbtkMb/zB/2g7jiFfZ8OV4hys/s70ZsIo/IysrD8xkYXS8HWesVYS98w8=
X-Google-Smtp-Source: AGHT+IE1HWn24ju6e4stWXYbvlgi1n8rTkfx/jsEbJAWr+8Ak7Vtu7yGpygAKsi3cSSeT9gD5nou5w==
X-Received: by 2002:a05:690c:6381:b0:6e3:36cc:eb74 with SMTP id 00721157ae682-6e3644c016dmr76783077b3.32.1728943069588;
        Mon, 14 Oct 2024 14:57:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5ae1b94sm32337b3.14.2024.10.14.14.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:57:49 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:57:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: chizobajames21@gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	ps@pks.im, sunshine@sunshineco.com
Subject: Re: [Outreachy][PATCH v6] t6050: avoid pipes with upstream Git
 commands
Message-ID: <Zw2T3PmdbgRGrIdF@nand.local>
References: <20241012062126.603967-1-chizobajames21@gmail.com>
 <20241014152411.11052-1-chizobajames21@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241014152411.11052-1-chizobajames21@gmail.com>

On Mon, Oct 14, 2024 at 04:24:11PM +0100, chizobajames21@gmail.com wrote:
>  test_expect_success 'test GIT_NO_REPLACE_OBJECTS env variable' '
> -	GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 | grep "author A U Thor" &&
> -	GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 | grep "A U Thor"
> +	GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 >actual &&
> +	test_grep "author A U Thor"  actual &&

Nit: it looks like there is an extra space between the closing '"' quote
character and the filename 'actual'.

> @@ -284,8 +313,8 @@ test_expect_success 'bisect and replacements' '
>  '
>
>  test_expect_success 'index-pack and replacements' '
> -	git --no-replace-objects rev-list --objects HEAD |
> -	git --no-replace-objects pack-objects test- &&
> +	git --no-replace-objects rev-list --objects HEAD >actual &&
> +	git --no-replace-objects pack-objects test- <actual &&
>  	git index-pack test-*.pack
>  '

Hmm. In other instances, actual seems like an OK name choice, but here I
wonder if 'in' would be more appropriate, since we're feeding it as
input to another Git command.

Other than those couple of comments, these all look pretty reasonable to
me.

Thanks,
Taylor
