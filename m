Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D334217F56
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892293; cv=none; b=eDg9VIVJQwwfdYYg+f5uKNxLpDu3PYdMlKwn8Gx4P9c/LzQdtKWY+Moru46K+tP1B26Gaq8Wsf/gO8TLBB7aa1koDlU2sqBcwJ4JlPLb08a9nVwngkvnl/ZSXlj2n0DkzIP/9zjlL+VKISw7yr3JqrN7t7pe1f/s6k6LXlZHWOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892293; c=relaxed/simple;
	bh=wKu1B7wXOabwEiUszOCSEIeqQt3qocQQZxFFT78Ox34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwpWfX6mLj7EcCPXi4fBc4DoMJAVrLenGMU0bqjBjh98HPQMjKEfLEU6CnnVVhCWqbnFz+Xrf4nUEVrvxxibHfvwsuhgLUt8Jas7d+HRN5Lr4gd65eL6v855pIw//JwCMteTmusSHN+lUnqNE/lml10Z5mWCo1QOCZRmNeVLJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1NgNBTvB; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1NgNBTvB"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e3d97b8274so23911887b3.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729892290; x=1730497090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKu1B7wXOabwEiUszOCSEIeqQt3qocQQZxFFT78Ox34=;
        b=1NgNBTvBS7ja3D3Dmi422FIgJus5Vk3Jbb1c0zAFAz2myQNZtsCVwEhdoWuiSverxn
         Eo+dMs8wSvaPYaBIAFKrxTai4q/Q0BtgHA/3eByPQRJvMMlsRg3qYDgb8kXk+GoimqLQ
         q7TSDj23hUmW4qdtEUm57RUgqm29SXt1lxulXL95v4LmrQc39AjLD+2teHR0c3ekUZhT
         H1j3VzC6jQ0GrG63wFRPrI8TuOREWA2+QID8bfpmQ0goHkXHk/4bJWe1309rlOE5vUdz
         QeCAl0j4vWm/lyrC5NYFBwyPyEi7tSuj19WAbDpEM40mxVy9eQAn5caw/KMLrlB/xjRx
         LyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729892290; x=1730497090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKu1B7wXOabwEiUszOCSEIeqQt3qocQQZxFFT78Ox34=;
        b=cTwY6eFRkrTbAQUBQuY8TloIr9mDa4aJTbXim1LtwPJTzttqI4i/Ccvb2vKAfhH3wL
         hYFQbBcN52pqvt9tTQbRVBbdPws1ZCPLynUCIgfw9wUt2/46TRbPBhvLeV293A7sKK1q
         g1hjd1yosd35+0HLmq4nUgbKJ2j8FjeCed5+tynJAKkMR43B2Se94wADXMsmuBTOZX0a
         xSiiYD+I9Ne2d0vR8y3F13Wh55iaX/fKyvh/4cRWTPnVDYErCd2bN5OqFdUVaUuQr9gc
         sPuV3gpqtJBtGjLD4ms3DcC5J61SWaBfO1hJ4cQJr3nnA+2JX2UZZ/mmyvLa5KaL95tD
         Z3tQ==
X-Gm-Message-State: AOJu0YyvaL+HtLx4/SZYyR5UJd0adFru7yiwUHQNWfbVZOpVHbW+6NdF
	gQeYGHM6dIPeTrC+VPwZ6rtdY1NwcKDI+qQ8/kuNOzoVIgl4Pu/0BMhsh3N4CcSzUwpAo5PFQUx
	yFcI=
X-Google-Smtp-Source: AGHT+IHsVBLlnP+NMywFSzRSz9OMtdcP4v+UPk62t6Fyh6S6c1bip9UHLwWerbOMpEX6zlTQAYX6Yg==
X-Received: by 2002:a05:690c:3509:b0:6e3:36fd:d985 with SMTP id 00721157ae682-6e9d89815c8mr13953647b3.23.1729892290481;
        Fri, 25 Oct 2024 14:38:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c19665sm4409307b3.67.2024.10.25.14.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:38:10 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:38:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	shejialuo <shejialuo@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/5] Optionally link worktrees with relative paths
Message-ID: <ZxwPwfJnEJ8C/rkz@nand.local>
References: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
 <ZxwIEcUKMELmxeMh@nand.local>
 <D5572ICCKQXT.3UQ8AJ2GSUZIP@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D5572ICCKQXT.3UQ8AJ2GSUZIP@pm.me>

On Fri, Oct 25, 2024 at 09:11:30PM +0000, Caleb White wrote:
> Ah, I must've missed that---I was in the process of working on v4 and
> didn't realize that it had already been merged to master.
>
> I'll send a new round based on the current tip of master.

Thanks.

Looking at the dates, I should have held the existing round in 'next'
for a few days longer. But I figured that the existing v3 was already in
a good state, and hadn't heard otherwise since the original thread[1]
was quiet.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me/
