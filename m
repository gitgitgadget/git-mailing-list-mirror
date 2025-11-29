Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2FD27E
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764457515; cv=none; b=dIrJkKDbCo99P1MFjcvPxKFpWgnG5uM0M0LMIMhr5Z0x/XMPd3MKJHOezn25zEpHzdYcLaxgg3WNtRAqbilQaDgq7HRp/qodKOa2HFxOPml+VeLTagSfKRaPOhtB/q5pvc+ieh0zRQIoicZ1si3Lssm2ZchceJx7IrHZxotbSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764457515; c=relaxed/simple;
	bh=YV+J1rcFAbSnJopy63e+ihNGW/4Z8P63ZU8Fa7P5EZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVONOSxYpDp6UYofT2qBAUoDGRhybCr7CgbPCWTv7p+TN6sisgl72/rGKvpRVyP8l0kqOCR2MgZQyM7umyvyUTOzE32RG5lY8Y20N1cHZ4YF/1NZ62N2hz5HJQYK3CWhUCQBZJOlEup1ylD8pMbYg8MErQRsnGx7VpaBECyhXL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGglly8Q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGglly8Q"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47797676c62so3675485e9.1
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 15:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764457512; x=1765062312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YV+J1rcFAbSnJopy63e+ihNGW/4Z8P63ZU8Fa7P5EZw=;
        b=aGglly8QFbZHK9wY8RS7duCNxBigJjMXO2ctv2NhIfqdmCdHwNvu+LMAbLQOLgUdg4
         A/8Ovj5zGzO1S/gO5rgY8GCh+hkZffbORFXZirLJDq4mwSuxZRmlx+4a1neVhCswnPhT
         kRKRLkIApI9Mm4U/OmHx9tClMGYdGx6XSFcc0y9SEaKOg2QrTSdK93ffHE+OTPFTEZn4
         GFU6XrZcjdlVKqFRc+hvOFTZLuOPbpR/xFWWOfTEoUCiJ+K4rFyFACJIdnxg/UCbG0Q6
         p4LcIsXPI35uF1SrOtg2PiWmWY+sXWWHotJI7FMHwgVzfrSvYrq4CwfZV64hYHbJW6tN
         TPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764457512; x=1765062312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YV+J1rcFAbSnJopy63e+ihNGW/4Z8P63ZU8Fa7P5EZw=;
        b=mIeaKJw3Omi0zoSszO+7L05A9QLASwGeKseZXBnD6kLy7A4hy/fZPUrkj67apFKbvx
         yAsppNDVxMqLkckN+iFTMiBIkHGt4S038R4RckJJ2Km3+0ktxlRGN71mdr4Wx0Ann29L
         V0HzL4to/fvp1k9lcygveS2S+DkyoIjFuOypeGno9CLaux25eP4lgjvaG0jq3lkh64eN
         w2z5jeKyjbgJgUs3/kDtfRZYiXTcu1BDZErD8s4d/M5e4SVNvn9ciJSgOeY3sE0iKOjq
         xIGIBlnQ1xIvoQgtg1ZILbBZkhEsL2t3k5jNX3nndleYlnyyeV2pP3V1rjcUH5/m1mbC
         Aoew==
X-Gm-Message-State: AOJu0YwmIoWxAZyfE9UofB3QHZvoc5+tTY6XKXMK29B5k+5l7qnXdKrx
	P0CbPmjqaOFpWfVhK8L9IL/alfgbWidi5J5RHB/aF+HnnJ8APmzHYFmw+3I0UySB8CqanA==
X-Gm-Gg: ASbGncuaaKra3Qd5Cv3EFfApy1ZKP4aNa9EHTX7uAmlfldW1GL/EUF7tOwZz4mcFtQP
	5cNyGVgqj64dW8GqnzF+5tPtkTG/L2dtiXeo12wrBWx5p5pRwN3XN2C2JT0G2oI0MOkA4yF3Cvx
	faEsJGy7fk+S/n/1xwD4Ko5mWsDy0bJTwk7sKuzRzk5lsi5I6dzNiifjTap0FPrPfvfwfVreYR5
	vMbVvx6/lFV1zoc+EeR8bnMyEuB1HVq68advqL5dI9ZHYkCriIw8X+9TBbXGTMvfzxrYCvgWEwb
	d/vkL1N0aQ6tx9qpe+HcasCCWYqmZovN88nchUZg/dJk9KQ+V6NtwlWATdLIozl5ymqUEeqRTjl
	of9qMA524C3Z9upCaX4OAbRFZv19xxmX9EHeOxQ1lAtLqPA1o3DG+cJIRmd5u4TAj6gxDwjuyzz
	zT/FZV6Vl298IE884=
X-Google-Smtp-Source: AGHT+IGqF385GZB0e+PWa7OHUKTC14jW+ElUnIbKvV0uQCgFTDOFU7sTIXiYmCMU/weothPWv0trUw==
X-Received: by 2002:a5d:64e6:0:b0:42b:4177:712e with SMTP id ffacd0b85a97d-42cc3f868f1mr18147993f8f.4.1764457511852;
        Sat, 29 Nov 2025 15:05:11 -0800 (PST)
Received: from desktop ([194.127.199.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a310sm17990769f8f.26.2025.11.29.15.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 15:05:10 -0800 (PST)
Date: Sat, 29 Nov 2025 23:05:08 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Update documentation/discoverability around
 `scalar`
Message-ID: <jcqsqytuxpqwn3yhpz7fxucbuuf635q3jfgkjzauxwhrkhl7gg@g42r5kwwoknd>
References: <20251129183236.52760-1-matthewhughes934@gmail.com>
 <FD92D0BF-E2C0-485E-A121-4C92BD20F7F9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FD92D0BF-E2C0-485E-A121-4C92BD20F7F9@gmail.com>

On Sat, Nov 29, 2025 at 02:55:10PM -0500, Ben Knoble wrote:
> I think Stolee implemented a few similar things in GitGitGadget PR 2010

Ah, indeed it looks like it with https://github.com/gitgitgadget/git/pull/2010,
that also covers the first patch of this patchset. So In that case I might just
redraw this patchset and submit the second commit on its own as a documentation
improvement, thanks!
