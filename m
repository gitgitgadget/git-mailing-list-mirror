Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6D3E024F
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476078; cv=pass; b=RlQHZHFxoVrV7Ffw+Lf0zq4+f/VCdMe+jhMd7aY191WX/8D3Ew7kl6Frncf9ILPDWosoA4Cijbgt0d/m7VDQG1iMaYFM/qMENJqbnwvQCOcoE07iyNnmZT4OFowOQymdiw8okPC6wYDeI3I/AcbgKz1DKAhnDsToq4YM9L7OLgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476078; c=relaxed/simple;
	bh=HnmIPhoLkVlOfcFLslJFzG22A8Y9JRny6HAUVOg9kpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaTEIiY8GMYSVx6FOdWT8WrgmPa6SQ5OEeGldXOFqpeoTPkLrCGK0ekAjRGpeX3y+rtcrXVSb0lKtMC7Lv2eJQb8zZgPu2hysh3gz5nGaSbJ8f45Y2SBWxF5ZI9VPGf7GSXqfWLhns7HL8PQDJwbfph6HAoI5C3JkWFYXuSHt/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeC5ktf7; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeC5ktf7"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-697764213d6so1492088a12.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 05:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782476075; cv=none;
        d=google.com; s=arc-20260327;
        b=o7hQsJWVGccTEJICPTaSiLMLXQNaVRCYeOhi6/AFaSIPkIQIa10Se6D5kYbGIoh9hR
         C+DJhBUIEWv11TDSmkmmII9szCxsOGIlarvWqanLZBoxVqBzm5lKbr6LiN9WGL4NSobo
         L2+ImL2cLQxJ7gZ6hzPQREFiljUNdmrRWMlJmkkg2XJ3THeBXz76ow5/GP0KfUJHp3lC
         F8BvmKF1t+xK1UV2/B8dtRAfOB/ZDEQvPlWvCL5hYm+IRqTr1qXFMryUiu8IXkEokeIr
         L9qMua/1SDhxn/6+Ffpr1VeAMuxBaE8naWwkmOw9vNQ+kdKu/xX36wvhdbpoBLOrA8D4
         T+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HnmIPhoLkVlOfcFLslJFzG22A8Y9JRny6HAUVOg9kpQ=;
        fh=PF02c1ekjMEJb83S/4m57zgYrIx7lEmrn+OgHOwx11A=;
        b=Ewyii6bC91eBsF5UPo1nrc+LOIdNMZAYnQPI/vfhAMbG1XYcDc9MZJZNFKa9YLVI/k
         rfWvhhgZHdPK236z4RWS7/uxNGGjRBvkCN8LUSwrOmj7335gHLYtvbWLzMazQzLLk9iP
         TSHgiPtyBYPyfk2SB+pzN5qIRatvNNkPjbosyPjJEFVX2KsnKi5VKB49pyPrNk5NzrjP
         net9Hp9U/bLhvO97cGqdd6oGQjJh+YTEA4DCIHdBHuiBdQC1/ji7DyBr1PQDE/nC+mti
         PE172ZDv0I0YJekgE0LngZcBs/hZB50B9p9uElFA9jSzgbumJUfKELSgcdoO9CgbVliN
         VxZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782476075; x=1783080875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HnmIPhoLkVlOfcFLslJFzG22A8Y9JRny6HAUVOg9kpQ=;
        b=NeC5ktf76hCDp5fOVy0Pb43PM/EoIvG3vajKGgyxr/5fhWSIdhDlOUZFc54dcQR1n4
         HRwQdzensfMpZ3WUGTxYumh8es929Fs7qf2aw4r+dHyh1mEUuIR8hRBIGP2OB11QRTHa
         z4qn6npMUCxEExCAxS/Br9Z4ePyTb5Nx/D62ufScHtL9cKmolvm1eOIhp3yaQXG+iG2a
         eWPWlyBC/pIGTPO5G+/kKHjyLy3OWiANKp4mTpURysKDhH1V96SS/u5Sn6kN1sPM9QeF
         d/fRFbfyDy4aRE5uagnNM2cdpHWqSzynJ6ZMOTOzcvxajRQsafO/Kh4iRztvPqYIasSR
         u/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782476075; x=1783080875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnmIPhoLkVlOfcFLslJFzG22A8Y9JRny6HAUVOg9kpQ=;
        b=Vk4lovMNX038qcGoc79BzQ89e75pFwY2lkDRGEPOBooS2K2kcEsuUN0/pNX9cRYtog
         GgvLtti4Lt/gHG82Q2ihpwdLg4ArF0/C67IEJHrfjYQtgGeVs1e85Eog8WuPtY0jWJJt
         Qq1U6qaAqs6dUtfyPjIni6M1jjp4KaHIyGFI0pFsApPvs/yAqcYBEPh01CtS9f1iyAWU
         1mTdNthlgKEcTWGwfWL0i3YDhMRNgicCbPqVHZcv01vJTA1/u3pmCve40g4HzaRtHUdl
         JoSnbQ/gquMNewkFCIS6y7YCHf+tXlDqnGeV6Afz93yzImmtCZB0zTIeZ0+qCAMrSx1I
         7MoQ==
X-Gm-Message-State: AOJu0Yymyl1eVTI9nMHYD+3zdDa3uDDIIhiklc7imMvbd5a5x/ZL7z2w
	PkP+yC/W5cGjTiSrpYOZHm0j41UhQOzNr1VANc0qUrcJb8+n9mUUqEdW/i+xmSEOz2D6BmPEUnp
	nQvXZDCdoWSuTfJZY/oDnJ7mJnzWAnM4=
X-Gm-Gg: AfdE7ckLHGYe/z6VvuvjK/7kDi2kjqSW85mcMwWX6k76HsFa4p48/bF8w4SxTuU7dfm
	owfw+vxr34wGnm1lxHutWL3qn7KaxM0U3T91j29pblWLCms20DpaJC54ZwQw6dI8vFZxJrq5BOy
	JZoF86LF0PhYv3BR4TgGt4eK3me4+sPACbB29rjG6p42uYuojHmHNottNF/gWA1nFWM0rJb6IGZ
	VCT/qsqQ8ytf+u78M6cks8dcpf3N0uWZpNA3FGrd75GlMOyhnx3ccyMT17357GxIhvEZ6yFU+U1
	u8AHN8hBBK+KQXWWNuCEQcn41afR6GamrVzlb5xV5JBWAvoHpizIZZiRpNi6/7VXgpdTjAZySWF
	aM4TqUd/v5bk=
X-Received: by 2002:a05:6402:a294:20b0:698:1973:1daa with SMTP id
 4fb4d7f45d1cf-698197327camr1341933a12.18.1782476074984; Fri, 26 Jun 2026
 05:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com> <20260625-ps-eric-work-rebase-v14-6-09f7ffe21a53@gmail.com>
In-Reply-To: <20260625-ps-eric-work-rebase-v14-6-09f7ffe21a53@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Fri, 26 Jun 2026 17:44:07 +0530
X-Gm-Features: AVVi8Cf_dMrwcC2pTLjVijIGy3gqEK_XCw0ZIsQaDNetv_AGILUNMNqT3TsVR10
Message-ID: <CA+J6zkRm_F4MQ2K8Ayv8PGJOx+pNAg73+p-4VdOgkxeuKAkKew@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 06/13] fetch-pack: move function to connect.c
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, eric.peijian@gmail.com, 
	gitster@pobox.com, jltobler@gmail.com, karthik.188@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jun 2026 at 17:43, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> write_fetch_command_and_capabilities will be refactored in a subsequent

Nit: The paragraph below and the preceding patches refer to this function
as `write_fetch_command_and_capabilities()`. It will be nice to maintain
consistency throughout this series.

> commit where it will become a more general-purpose function, making it
> more accessible to additional commands in the future.
>
> Move `write_fetch_command_and_capabilities()` to `connect.c`, where
> there are similar purpose functions.
>
> Because string_list is only used as a pointer, use a forward
> declaration [1].
>
> [1]: https://lore.kernel.org/git/Z0RIqUAoEob8lGfM@pks.im/
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
[snip]
