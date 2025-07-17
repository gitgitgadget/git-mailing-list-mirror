Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D001547CC
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792420; cv=none; b=g+Phi6leFbNgKMj7Ehm9+MQYVc4huNezYs7GZ3aSwzrKubD7Ijo94M/F99zrXxWS6MYg9IcolaVLzp2Eo7C6qOEx9RrpXcPjtG3Bp1sSHzAcabJYTy9w+7UqSHL0R0AiTnArbL9ViSQIRqcQxtiPnV+ebIpXzOD0qBGQwe/ZgG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792420; c=relaxed/simple;
	bh=Cemw2fJ2YG89xYlKUc52/7bDCpVMoRWSZn/aknOgtuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZNiSOJfm3hpO9paTZxclZnCNYFoHQcHShOdaiKrzLPSPIXWPyet5hY58vdQlMpf4+xLEXc3I2Tk7ZPgpmFBVVjKUiLF4+5bqXOB2pQrp5CvWN1T+dexWqWNJUeBX9tc1ba+YVNQpFvWt/DkRZ0/3Ik7GQArUY1OKc5hInKjKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=mfOCgH7K; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="mfOCgH7K"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8bc13221eeso1594153276.3
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752792418; x=1753397218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMFfOvbkvIc0BLtEw3RlXWBpehuL4t6K7tcVEfs7gtA=;
        b=mfOCgH7KFujGY+cQ11glZo4Jl+q4/NhHfbT/5kZw7imGiwSbNPoM3Rp6Kn0j3NjYp2
         yG1LsA6Ri9AOi5mj7MlPWk2UoWV3jCFMcpMKYaJv9QRRV5chtzKQDEUx7DH8xle4TNlG
         QK8g1VpAdE6EeEoB8Mt32LNCqte127TrlhNrzZTmOhuayGb6knz/y+eb8k2mgZb1ZTkJ
         bHZanyvxoKPIQm/YpmbPXAS/yrJqfOkocdLAYV8DTRvRYr6hA/rm6svIYQPamiP+Mlkw
         JsmghId4VgO9IQBGQWUz6LvXirJsGz/A5ger7hZoNHHKyp3SAHedIQ4EfHplQBzZIA83
         cDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752792418; x=1753397218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMFfOvbkvIc0BLtEw3RlXWBpehuL4t6K7tcVEfs7gtA=;
        b=KlzbORbmpTn/iqI7vaVR0hvYqd4vV6Mh1UikAOKtWn5iIBuLgMEhYmwCwRXjeh2Hqd
         2LyLlAsm4w4YigYzJEnLcepotuLCq7NcTZsqQYs5+Ku4CNLALuZi4INlF3FE88Yfod7/
         57hxruUT9MZLOrS/dPgEVm1JCmK3dIFA02/JQw5f7tyPgLBBeofCRP3ym0qG5eblUpUF
         dn5IRhjKLajtbw/UOkyzC0dr//KaRpOY2XQWNegRBqXACE5G85P1egObOfJwqGmtKSf+
         YCfPmNDJ07BApBduENO6qmkkanwNOKLn0/FhjP72oSkhb/s5ibm1uE4TMGW5k7CAG654
         WImA==
X-Gm-Message-State: AOJu0YwOj2k3BYgzixHUJQxodF6bStUemN11T5JWxC6pvOtHOd9g2P9w
	1Pyb3TNrzW/58FVPdLYaZPM17E31fD7HfbmIF11J6R8RsoiPA5InqqhrKQa5ksoMyWE7HRFOuDY
	udiETgyI=
X-Gm-Gg: ASbGncsMhw+0/Z0zmNxIJZdzBAyYmexml6aD9J943+avzoX0ZlG5nfaPU5bTePG8fuO
	PGxs/qycxDEZ96ztic6l4K4hq/Gc8NBv9zINi0Xn1ItPsqT3QmiCHfok+Kr0p8aAuDn5Sc4Ey+F
	8Yv3/GDG/Y6oO7dAJxJdZlYCWx9O6ylZcedH8gn/4I9iqFkJexQfXmWUlzg3Q3RMuLC2jQqQVhG
	6EEDxV5fUO6UZBi9m7V4T3Lltz0XYkz3qJbKch2M8WXuI6Wk28C80Noo4lWqjisOy5DL2QKIFr/
	i0UM+sgCfwELYf9zeFOaFwY5cS24K5q6E/tqjthFcSMfyuzhcFUC0/iAp+Y9UAIsvavjeIMaQeF
	DNbog5O0FUXzXEyoDSdKq/nfRoD1NNmvwVulYb5lCxakONZbgrmG8J/9XAwaQ9P4kW8HWEA==
X-Google-Smtp-Source: AGHT+IGzmC4YTKNSJdBuGzFKOWnSaTJEujFHEXnjglfi+G6NVc36PlSRuWEXQUOLGRxbmnn7wDH9fQ==
X-Received: by 2002:a05:690c:dd4:b0:712:7c60:4cd9 with SMTP id 00721157ae682-718a97cf09emr77305737b3.28.1752792417792;
        Thu, 17 Jul 2025 15:46:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7195335e895sm436677b3.105.2025.07.17.15.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 15:46:57 -0700 (PDT)
Date: Thu, 17 Jul 2025 18:46:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
Message-ID: <aHl9YLc823uWwgIp@nand.local>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>

On Thu, Jul 17, 2025 at 08:32:21PM +0000, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> A few commits ago, we added definitions for Rust primitive types,
> to facilitate interoperability between C and Rust. Switch a
> few variables to use these types. Which, for now, will
> require adding some casts.

Hmm, interesting. I am not super familiar with how people typically
handle interoperability between C and Rust, but having to change types
on the C side to make it work with Rust is a bit surprising to me.

I would have expected that the Rust side would have declared its types
using libc::c_int, libc::size_t, and so on. I think I have a vague
preference towards putting the burden of casting on the Rust side, but,
again, I am not super familiar with how transitions like these are
typically approached.

> ---
>  xdiff/xdiffi.c    |  8 ++++----
>  xdiff/xemit.c     |  2 +-
>  xdiff/xmerge.c    | 14 +++++++-------
>  xdiff/xpatience.c |  2 +-
>  xdiff/xprepare.c  |  6 +++---
>  xdiff/xtypes.h    |  6 +++---
>  xdiff/xutils.c    |  4 ++--
>  7 files changed, 21 insertions(+), 21 deletions(-)

The rest of the patch looks good to me, assuming that the burden of
casting is placed on the C side.

Thanks,
Taylor
