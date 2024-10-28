Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24231DED42
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132097; cv=none; b=TqzQHsCKW+GsX07fgPPQ/mMy7I2K19RR5Ap3t0VgPt4RjMnayWf+p667N8gloBSotyHwDWum9DElLU3U8XOtD+LBc0L2lEDcKiQ3al+UScZ3tReUXt0rC2I3rlh6cK0+oLtr1fzHXlu5iJne0uafagxjSu0VEXWTUJq2LHO6NpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132097; c=relaxed/simple;
	bh=hQerueS0DdeAALLZfbIDvoX19w7oM+EUwgcDwH7moEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUnKFv9j0BoNZqJyer7DD0+xsCh+wWK/OGu24uxji5Mmd/BozN+tMv/yBgUxhlU8t9Dok86Orjxlp10WuHEb7ds4KXc1VbNvYSJlMRg/I6DBrvl5FlnbUM5w4J5HF661xkj7rKWskBeJF3gqOf/DpPD6ALHznPi+AROsHBNtkfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=biieZKsN; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="biieZKsN"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ea051d04caso9537097b3.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730132095; x=1730736895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RB2U/cdVCAvZgMpf/gt9HHPChH1csjgZYJiXz24omAA=;
        b=biieZKsNed/clNKwgOK3oCr3VDHd0DBKgSUmgg9KWb+CSKCpLztzkb5Hqf/1/kTZ0I
         Gz2jjQ4KAVteEC2e3dAQbYlbeZkBQ6HbncL2MLT6xVSP0yYZrvNnOvczVRdn261guSgA
         OtwyWp0EeXBSVYyXU2vAYj8WnyJrbL/tha6et/nEnVraHM/WcspVbZO3FGH/p9tshf8G
         biS9018OyZdC0+sDkztP/X5+enE7TqcRQHlfkRe8tZ74GkAekaOIMHFeGzL3+LeOqh3Q
         hjQfVzb9UG1mxREbNvZca/yDjjBhohjEhk+s+OShjyd53scMWE1oPHrHW7wcUINuSLK7
         8K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730132095; x=1730736895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB2U/cdVCAvZgMpf/gt9HHPChH1csjgZYJiXz24omAA=;
        b=DAqA2AP5F5TIv1XlOkAjKT0NoahC8NOhtzZ/DlEW3bq/2CYVupVTkXw6LivNHXTBkd
         jOW59FyIzyWpUIUok5Yu+5cbq7raoRqpgb1KNhZx8X0zhUfTQKKf2DW2d68NXneF+6Ue
         931219GKUQ2I9s3UrVqnCUJLemWrPdKwHhbHtp3+tJcaH1JjLocDtq+0Nw1eacaLlohr
         vsp3tZ8EtpeiUrlH/w1xDj0OfzMoVrvxf4PB2lxvHU/AMPNET5rHoLrgqngujOGFlhpw
         1PnSQmnS1vucv677+ztIGRuL3Vn2t2Qp7qw7Q11SqylL2v2CZpIf/el8x2V0XzPUjKFM
         W3OQ==
X-Gm-Message-State: AOJu0Yzx3ShEo/GwAnC/MHO5LMC0AOu2x6q0Hanyt1YsLEWyYIm7GiGi
	tLlCb/ccHNaEuUaEKQMOYCLHpbSMo+yRlGVa7MH4fal6dKU6rTJCcdDRjz/Gk7aiRyJ84aPgUGg
	SxUU=
X-Google-Smtp-Source: AGHT+IEhyl42McyRU/UIwtU7c0QphUeN6QisF5vJIfUBRP0l7rnvqkKuHQy2VWJtG2XyzaIl7e2AWg==
X-Received: by 2002:a05:690c:2c01:b0:6e2:7dd:af61 with SMTP id 00721157ae682-6e9d89768c1mr64619877b3.17.1730132093347;
        Mon, 28 Oct 2024 09:14:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6cae76fsm14840987b3.134.2024.10.28.09.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:14:52 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:14:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/8] packfile: pass down repository to `odb_pack_name`
Message-ID: <Zx+4ekA2Yqct2ack@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com>
 <73ba9945a7b7ec69e4ea29116c473b88e5c2a916.1730122499.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73ba9945a7b7ec69e4ea29116c473b88e5c2a916.1730122499.git.karthik.188@gmail.com>

On Mon, Oct 28, 2024 at 02:43:42PM +0100, Karthik Nayak wrote:
> ---
>  builtin/fast-import.c    | 8 ++++----
>  builtin/index-pack.c     | 4 ++--
>  builtin/pack-redundant.c | 4 ++--
>  http.c                   | 2 +-
>  packfile.c               | 9 ++++-----
>  packfile.h               | 3 ++-
>  6 files changed, 15 insertions(+), 15 deletions(-)

All looking very sensible, nicely done.

Thanks,
Taylor
