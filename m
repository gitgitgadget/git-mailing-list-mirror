Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA934538A
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730072821; cv=none; b=prvDJw1Ak2ge5l77GsA7ysn5VnxEpbwKMNQZg2z/XAaGsfoxPbznvNwB+3GlJXNmlo+Wt+Y6cIlVG5SGUPOnKLx4B+yNS3l39+RSojIAJ9nqsp05WFKjIzO/WnzKLbx319yOgsE1DMJ2BVYVf7763UylssaEgP736U5W6eBX0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730072821; c=relaxed/simple;
	bh=GMMCpzcGfyxiYF0l949CfNZxvTmikNXYU/DnWE7dXxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swVWor86eBCwsBSMLAHAn9cS6nP15TlkApemEmxuZQFg0KJNkh1BeNfcS7rqXQk/wOQKUuc0iW/H/XuGCvmSNJQ/qlTpjUZapp5k9iPWdxZk7tQlYP6WVESwxqsytx76wsPzp9qqNgPmXNrJq8UDJaLyyY71VHXVYfJNSM8J5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tAcZDlUP; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tAcZDlUP"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e291f1d659aso4051269276.3
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 16:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730072819; x=1730677619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Pr3WLYN4xMWgD1sqzRuaA7N7i656toTQQw7H1btOTg=;
        b=tAcZDlUPYAOFgcRMK6E95l7yebAOdJ12cejmcFgs9W2VB4BOf07DBRK0ozRwjgwOe0
         ZEsTIpbhbzt/4K0EZOX5yl05gXqcBJSkn8ql4TfwFhUaEo2+d5nYNvT5/uA3A/Ql1snR
         Qss5sJFad6wYBFhe8JDr51lhtTKAiJb0TRQTd1h28hQnt4OxkLeNJ71NNB5OC1bJPawB
         ej0NJUlOZ6XhbkWK8peupYxazUZLID88J1wdx2Wcvk1oE9sJLSKd+BxXrlbkJKjrJsnA
         E9NTQUr1p4ynvtZ09jQ20lon+RYo+6ddxLZZPAi7fiwPUvxAj5wBZf5d89JDovYqJYZf
         z5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730072819; x=1730677619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Pr3WLYN4xMWgD1sqzRuaA7N7i656toTQQw7H1btOTg=;
        b=GoypzHn4R7NY4ZcSOaWX/GCOB7Rtyx/IZXLjUMNkd3Fm2N4I/EWvOGlRzOEQHhQ20d
         HDVlD1yUO9kZFecndgb7jdExrqXrWvMCRCc5fv+L3yXoRpVXq/1sAH4lng72XGquZncj
         BCGkiCV63Yv+GEv4aGUJTC+gLTSw/HYn6jENTAI+M3/95pVT8M9WEWe1b/4FovRGMZJL
         R6aJiAmbFRbkRvk05ApQrPoLGPmrafXjt12yaphuvOz1/ofO8BUQLFCyg9snR7b4nz+7
         XH0e7dW7f3woL6NTIyy75PkjDY/x7kbXqWvI8HY+TjvsLE9ukPZLQ5Nd0xeZnUXaSdlz
         +25A==
X-Forwarded-Encrypted: i=1; AJvYcCVGkKVCFzwfDJJiSEl2Pz8HzAMxvy+o2CPe8/DWu659r5Eh4iNKo4eGpyc6DVBsR2a2+eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydCI476YRsX4EuFXhHGI+fiZ5ugq+OS7NfRRPGiNxT8MESP0B6
	WYwPkZNLQoWsYqerw68wQ4bZP9gUDQ4xWmeqEgBg2F2P0XYkwdhRfWrym5u7cDc=
X-Google-Smtp-Source: AGHT+IEvZmgQQAlk6zUGAhTfLzGE/InRzA4WQT5tqq6dWrESZHRS7EetjRzJTpbk2M36qmMZ75ioxA==
X-Received: by 2002:a05:690c:f10:b0:6e5:e714:3bdf with SMTP id 00721157ae682-6e9d89a8cd4mr49926677b3.5.1730072818609;
        Sun, 27 Oct 2024 16:46:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c7aadfsm11864257b3.86.2024.10.27.16.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 16:46:58 -0700 (PDT)
Date: Sun, 27 Oct 2024 19:46:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] compat/mingw: share file handles created via
 `CreateFileW()`
Message-ID: <Zx7Q8L6/cPId1ZMu@nand.local>
References: <cover.1729695349.git.ps@pks.im>
 <907576d23d1dc39b679a323e74b6bfb227d6c17d.1729695349.git.ps@pks.im>
 <ZxkxAvLeMtxstVdS@nand.local>
 <bc0c9853-7dd4-4b1d-9985-25f75815b0a9@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc0c9853-7dd4-4b1d-9985-25f75815b0a9@kdbg.org>

On Sun, Oct 27, 2024 at 02:14:30PM +0100, Johannes Sixt wrote:
> Am 23.10.24 um 19:23 schrieb Taylor Blau:
> > On Wed, Oct 23, 2024 at 05:04:58PM +0200, Patrick Steinhardt wrote:
> >> Unless told otherwise, Windows will keep other processes from reading,
> >> writing and deleting files when one has an open handle that was created
> >> via `CreateFileW()`. This behaviour can be altered via `FILE_SHARE_*`
> >> flags such that other processes _can_ read and/or modify such a file.
> >> This sharing mechanism is quite important in the context of Git, as we
> >> assume POSIX semantics all over the place.
> >>
> >> There are two calls where we don't set up those flags though:
> >>
> >>   - We don't set `FILE_SHARE_DELETE` when creating a file for appending
> >>     via `mingw_open_append()`. This makes it impossible to delete the
> >>     file from another process or to replace it via an atomic rename.
> >>
> >>   - When opening a file such that we can change its access/modification
> >>     times. This makes it impossible to perform any kind of operation
> >>     on this file at all from another process. While we only open the
> >>     file for a short amount of time to update its timestamps, this still
> >>     opens us up for a race condition with another process.
> >>
> >> Adapt both of these callsites to pass all three sharing flags.
> >
> > Interesting, and especially so noting that we *do* call CreateFileW()
> > with the FILE_SHARE_DELETE flag in other functions like create_watch(),
> > mingw_open_existing(), mingw_getcwd(), etc.
> >
> > Why didn't we call CreateFileW() with FILE_SHARE_DELETE in the below two
> > functions? I assume Johannes Schindelin and/or Johannes Sixt (both CC'd)
> > would know the answer. Regardless, it would be interesting and useful
> > (IMHO) to include such a detail in the commit message.
>
> My attitude in the past was that deleting a file that is open elsewhere
> is a bug, so FILE_SHARE_DELETE would not be needed, but its absence
> could point to a bug elsewhere. Now that we have a reftable
> implementation, it looks like I can't uphold this attitude anymore.

Makes sense.

Thanks,
Taylor
