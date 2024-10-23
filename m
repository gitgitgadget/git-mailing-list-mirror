Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9FB1D043F
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704198; cv=none; b=SzQjC/SH62W6GKJ0Tu9pvetsJJmP80W0OKF6wMDe7ZsedLUUjAdzLYnJF6mzVfZ9KM36n1P5gQPeIiWD/eCNWWhHkf+DLiJn84wQFwpDKtv+QV5g/XBACcIdzUro04DbHyuSQdCOOkK9GkN+TvsT+7rhY4HtVzpzOv2gXedMwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704198; c=relaxed/simple;
	bh=f8Dv0Je5Yd+STgqodnpVMWYuWdGTirQ8GRIHIhd0flY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMwPPdpgDnbRM7ESUev3qAzNZ3Lpi/9TENsScJpa8L2lxRQVowteI8lQDiLvoFwzlqqFIudjTtAGwERrmbwd9acFnFY1MMLldx/BntrY1ALAKkcx6Q7ulxk5+UzcY9vGss04BYvWWriWsZISaPDRZaj81AwioLusa91KsEP0P9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZMhYDRqQ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZMhYDRqQ"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-715716974baso27233a34.1
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729704196; x=1730308996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpWSEBGLYjOOX1dUb54be1rkq/WpZNLltiR8svtWlZQ=;
        b=ZMhYDRqQgAQpHsr+cFI3Ah5jg7AD33ejzTiy8UqimWhnQubtopTFGsBeXG7qzQCwwu
         kJnySj4wyar8FNQhbJrXcDG5ZDw3CX9c5Iou53GNZEEWDPPtdhJAbBtzEx1jRFi4qnxe
         WB6b9X4Fd2fLOan2GbpkKOkShr7lr4Iw310Uo5OmvvwAOLyooq67u7eFXFWekzXDV03+
         cHPA6B+nlvJwfxmLS7On8iQ7lyzUz8dqcrVjZscaZf8TTJY9UOw2igx7PK57ZyC5GgO7
         Jzxuy6wgAk/5ndtLQjcggsNI89vxp8YpQd80iq/T+Q8iGeoVPXH1jDxGUkREG2apYI+R
         JB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704196; x=1730308996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpWSEBGLYjOOX1dUb54be1rkq/WpZNLltiR8svtWlZQ=;
        b=JsEdJ41Vn8yRL6vGAtQiJLRFLeSffpDRBA3Un1PNg51j3VuTIEGyy4SQeDL7bUm46S
         Dqu6YqYf0rO5il8IKSXIwPMI2bIqKzM5SQhCBhosV4zdMEy9Du4ulX8Z8l26C1+m12nj
         f2VcG7gp8pPJDtwZvW3Uz8oqdmu9W1Pbr/KY+eWvOO1g4/P1z1K2e+MZ25LwPgVRnIi1
         e5HHSwok96e3vbEBfdrIUEItxLCyPMcskTt/hQGYJaF1rB92nUYx+6zkgPPJx+QBwoZH
         zXWdHnHa+9rM+wq9IFwqT802wHGkQPNccgn774eHZ6bipM9bUgUHJP27DpkUegVbxf0D
         IckQ==
X-Gm-Message-State: AOJu0YwplD3tCGDqvl0t/5XSNwkDiUc6jlQqI2MdOI2opq3kfYzDXflB
	04SP0wHLwA82Z8V/gfxtO9CmGPZQI2OfQo+kjQgPY6VJSqOJzOaYFBCAzJy+E78=
X-Google-Smtp-Source: AGHT+IGXpurU7AjdcaSO8W4Nlap0/wFLmj5Qxt0kdD6PbWgjrLHPTolykJV1mgHZchbvIX7KE6cIqA==
X-Received: by 2002:a05:6830:2701:b0:718:41c6:821c with SMTP id 46e09a7af769-7184b3688e2mr4085360a34.5.1729704196096;
        Wed, 23 Oct 2024 10:23:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00902ca1sm41403866d6.53.2024.10.23.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:23:15 -0700 (PDT)
Date: Wed, 23 Oct 2024 13:23:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] compat/mingw: share file handles created via
 `CreateFileW()`
Message-ID: <ZxkxAvLeMtxstVdS@nand.local>
References: <cover.1729695349.git.ps@pks.im>
 <907576d23d1dc39b679a323e74b6bfb227d6c17d.1729695349.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <907576d23d1dc39b679a323e74b6bfb227d6c17d.1729695349.git.ps@pks.im>

On Wed, Oct 23, 2024 at 05:04:58PM +0200, Patrick Steinhardt wrote:
> Unless told otherwise, Windows will keep other processes from reading,
> writing and deleting files when one has an open handle that was created
> via `CreateFileW()`. This behaviour can be altered via `FILE_SHARE_*`
> flags such that other processes _can_ read and/or modify such a file.
> This sharing mechanism is quite important in the context of Git, as we
> assume POSIX semantics all over the place.
>
> There are two calls where we don't set up those flags though:
>
>   - We don't set `FILE_SHARE_DELETE` when creating a file for appending
>     via `mingw_open_append()`. This makes it impossible to delete the
>     file from another process or to replace it via an atomic rename.
>
>   - When opening a file such that we can change its access/modification
>     times. This makes it impossible to perform any kind of operation
>     on this file at all from another process. While we only open the
>     file for a short amount of time to update its timestamps, this still
>     opens us up for a race condition with another process.
>
> Adapt both of these callsites to pass all three sharing flags.

Interesting, and especially so noting that we *do* call CreateFileW()
with the FILE_SHARE_DELETE flag in other functions like create_watch(),
mingw_open_existing(), mingw_getcwd(), etc.

Why didn't we call CreateFileW() with FILE_SHARE_DELETE in the below two
functions? I assume Johannes Schindelin and/or Johannes Sixt (both CC'd)
would know the answer. Regardless, it would be interesting and useful
(IMHO) to include such a detail in the commit message.

Thanks,
Taylor
