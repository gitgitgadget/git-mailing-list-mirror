Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BD123E325
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104530; cv=none; b=Kd4fXYEX4kjzKpZh7+CJMnB1YDMpMgFVJQrLDhQ3cPs81B8uXa55fLlpz7vQ90FCFeXN2b9Hl9w8D+PF9AwrtBsQ9UD5q3ufvmY4Lzk5aHMslWQMjPUxcK1TKNhJjaK+WjeK6p2Vqy7ZLkD63UDpBNgTsz3s67jsVDUqmYmeJnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104530; c=relaxed/simple;
	bh=CnpPkCDgRKXdEoNVjykfay8vNojhbG60F8KkzyJt1tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZbrfXPhFaRDHyyvfZKkWRF37v74g5vK1IJizS4BXbjskJeu1mI75bIE0L0rClmg+84VQ5EXGsYvkhInSeIeVSgfAST14rbOhqoNpYmhWRTcLBRAUDUVjQEOCKFqg9QtgQrERb6PRJ75JZcRT0TJPr3SafIpgS4QE6qdcHjItE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNxLRUx4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNxLRUx4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2494440f3so16111875ad.2
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 11:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776104527; x=1776709327; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3tsV3QVy8x67OS/T0KrduX8EqxZboDPXSi2EmjDc80Q=;
        b=RNxLRUx4cVEdU5qseNNKKmEDLOb4ROv1LsycDI8MYfXBLONkfTICC3yBC3Y21Zz4GU
         COMwOon+epsoUAlVxYYfSw/WVR+Nz8kO9vlGg//d85jAJgLGImb1kDm1Pnyi4iRVhqyR
         JxsVfE/gG20K5LIjkX8lwAGtHfAPkohUKR2Jy59Hh/LPK7ugAFA57LU0BVZvJ6JQsi37
         GpgFgB3iO5+VOJf8utX9jTc5MCzEZOjCuUEotvSKSA3TPKaarHLKF0KXer9Hz8vVI/KA
         dVXWJfoezZJgQV4orOBl3ZP6Nh7Kq8+Ei3wLQZE/49Rl0RZPiE9bYQFErwbfPXpfbjmD
         +9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776104527; x=1776709327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tsV3QVy8x67OS/T0KrduX8EqxZboDPXSi2EmjDc80Q=;
        b=ZrNhEadTORwL9hOHdiWUpvSnd90jvckj2TF9Zw8GHUt5NYK1tclyRi4mcDvp6Phgb3
         0nSR4ncE8zczysd0ynLxQ/+m6nSystcY1+VSI9aBJQ4a9Au/6xwmtjmuXEDQydhNJlPq
         pHKriLNX7E4+CJLx/ILFisyhaqoGL2SJ9ODowN83Ym4+zuqYdD2XrEv1PAlP/CiYv8Gn
         7MvSLAtj3PmLviGB1cn6GWey84cFeqqtJEhLAFDois5YaMSJIkcj4/zgnihooCxBOBLY
         4QF7DR1IK82Mxc9mTgqCSpobLHum2AX2ys6IP0Ir3L0uXZTHGm7i7vBtPz2qyDXeNRat
         rJ7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/4ZbhCVnTpU9TUm9sCt+3cydtchXaiTIXrpdE85txOMLN8SSOQfJEaA2rrNh1fiYtaDYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6cH8akIz5KyOBNZhQogjPLOxKk22XsP5mNP/Avuf/gDzSWGK
	zzL6WQ1Jf558UwzOy76ywcZqQ/c5uoRspXYcTWKexzCa7gPnPDGJl6PT
X-Gm-Gg: AeBDieuRdq9KrqwG2zG2+sleUWchoz6eB0g6U9//2ar2lSug4zKhXSFOxKkYmpntQNS
	30tKlQWDGZf4d9h/yDG2Tvae9U9l6c0jXKePJ5LJGexdazPSSId910/6imuUxZwfnhVIbOLYo4g
	FCp04L/JjN32ViUhjsF/r1Y6ZD5exgFPuSW5Q8UIyJyfMLXpqvegGWHIrjeM+8f0NY0iXIOyw8s
	t+12Ki9m81MhBww8/5iCLbTmo+msw8WQr8tCo70bNbrAMophV0oGlyDMDhlZlFas8ZtHCsEbpnh
	YuylIDUFaecauNw7GYT9DuvaFfLJ2r5kkEc84lYFgg24xiwyBW+nLpLUeLYbaSLkSDMOVh3HZxf
	vuSli32nfXAB70naZu8tQnMwOwrSb7yi69lF0YhzcOzjTWDmd4Fsn+DkMiPphqqyFo3zXKJ+3dS
	2kybPzlZbgB2+/sAPkBDzip+F67uA+xDGMjg==
X-Received: by 2002:a17:902:ba94:b0:2b2:5840:80c4 with SMTP id d9443c01a7336-2b2d5a291e5mr103395295ad.25.1776104526709;
        Mon, 13 Apr 2026 11:22:06 -0700 (PDT)
Received: from localhost ([42.114.219.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f26cf3sm131037645ad.60.2026.04.13.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:22:06 -0700 (PDT)
Date: Tue, 14 Apr 2026 01:22:00 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Tian Yuchen <cat@malon.dev>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [GSoC PATCH] promisor-remote: fix promisor.quiet to use the
 correct repository
Message-ID: <fcnv7hv53khhctafvzqn6dygbyq2tkyy4i2gawcbahdnevg2hw@7h6bvxlub7ib>
References: <20260406183041.783800-1-vikingtc4@gmail.com>
 <fbe81fee-ef1a-499e-bf53-d6f1761bb30e@malon.dev>
 <xmqqzf3dxqdy.fsf@gitster.g>
 <a6382ad3-6ce4-4e85-bdff-8e90068f25dd@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6382ad3-6ce4-4e85-bdff-8e90068f25dd@malon.dev>

On Thu, Apr 09, 2026 at 12:34:47PM +0800, Tian Yuchen wrote:
> On 4/9/26 02:23, Junio C Hamano wrote:
> 
> > FWIW, I didn't see it fail in my local environment (both in 'seen'
> > and also standalone) or at GitHub CI (in 'seen'), so it is a bit
> > hasty to conclude that the patch was sent without proper testing.
> 
> You’re right, I was a bit hasty.
> 
> > I wonder what is different in _your_ environment (note, I am not
> > saying your environment is _wrong_.  It is just different, perhaps
> > the compiler I use and your build environment may align things
> > differently, or perhaps on-stack "uninitialied" pieces of memory
> > happen to have different values that the code is reading that causes
> > different behaviours---in which case it is the code that is wrong.
> > Asking for environment differences is the first step to figure out
> > what incorrect environment dependencies the code has).
> > 
> 
> ---
> 
> git version 2.43.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> 
> Using built-in specs.
> COLLECT_GCC=gcc
> COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-linux-gnu/13/lto-wrapper
> OFFLOAD_TARGET_NAMES=nvptx-none:amdgcn-amdhsa
> OFFLOAD_TARGET_DEFAULT=1
> Target: x86_64-linux-gnu
> Configured with: ../src/configure -v --with-pkgversion='Ubuntu
> 13.3.0-6ubuntu2~24.04.1'
> --with-bugurl=file:///usr/share/doc/gcc-13/README.Bugs
> --enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++,m2 --prefix=/usr
> --with-gcc-major-version-only --program-suffix=-13
> --program-prefix=x86_64-linux-gnu- --enable-shared --enable-linker-build-id
> --libexecdir=/usr/libexec --without-included-gettext --enable-threads=posix
> --libdir=/usr/lib --enable-nls --enable-bootstrap --enable-clocale=gnu
> --enable-libstdcxx-debug --enable-libstdcxx-time=yes
> --with-default-libstdcxx-abi=new --enable-libstdcxx-backtrace
> --enable-gnu-unique-object --disable-vtable-verify --enable-plugin
> --enable-default-pie --with-system-zlib --enable-libphobos-checking=release
> --with-target-system-zlib=auto --enable-objc-gc=auto --enable-multiarch
> --disable-werror --enable-cet --with-arch-32=i686 --with-abi=m64
> --with-multilib-list=m32,m64,mx32 --enable-multilib --with-tune=generic --enable-offload-targets=nvptx-none=/build/gcc-13-EldibY/gcc-13-13.3.0/debian/tmp-nvptx/usr,amdgcn-amdhsa=/build/gcc-13-EldibY/gcc-13-13.3.0/debian/tmp-gcn/usr
> --enable-offload-defaulted --without-cuda-driver --enable-checking=release
> --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu
> --with-build-config=bootstrap-lto-lean --enable-link-serialization=2
> Thread model: posix
> Supported LTO compression algorithms: zlib zstd
> gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04.1)
> 
> Linux malon-Yoga-14sARE-2020 6.14.0-37-generic #37~24.04.1-Ubuntu SMP
> PREEMPT_DYNAMIC Thu Nov 20 10:25:38 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
> 
> ---
> 
> By the way, I find this bit of code rather confusing to me:
> 
> > +	GIT_TRACE2_EVENT="$(pwd)/pc-quiet-trace" \
> > +		git -C super-work grep --cached --recurse-submodules "world" \
> > +		2>/dev/null &&
> > +	grep negotiationAlgorithm pc-quiet-trace | grep -e --quiet
> 
> Is this grep pattern correct?
> 
AFAICT, this intent is to check that "--quiet" appears as an argument
in the trace2 event that contains "negotiationAlgorithm". That said,
the "-e" flag tells grep to treat the next argument as the search
pattern, so "grep -e --quiet" searches for the literal string "--quiet"
rather than grep misinterpreting as one of its own options.

BRs,
Trieu Huynh
> Thanks, Yuchen
