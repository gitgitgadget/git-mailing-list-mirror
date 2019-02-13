Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2F0E1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 21:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436894AbfBMVqj (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 16:46:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43020 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfBMVqj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 16:46:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id r2so4218943wrv.10
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 13:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dkCG9FNIgJvP8qGCjSdH1gfeS7PZlhv6kQ2bZyQuuGs=;
        b=RicXG46tG9NNFIc9kHf7nzRshF+NN4nDCZXor08m54RG8HrpT6P3HIzBHX8B3TpmDR
         Y5vFwq0CQIqVcwz2EsAiPZTqvDYFHh/f3m8DMXoNNsEL+pCEH0XlaF3OjD/vdICIewvK
         e7wiZclJqTjhXqdFwF8tQGfthv3ohegAgLamuzYolFmftspxAyNceDDZ3LJTJJM/6k6n
         TgMdrxgDlU+8/a0olQyBBnIrv1ZKHjFJsXs+ExghTME0gUtdzO1ice8E31ziUXkCEVnO
         9OSPak0WGFQMnHs7vSbiFb5E3mM6o1fbDzf9vPnifCtbpoOLmkjxVNMHWNApm+9c54l+
         gDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dkCG9FNIgJvP8qGCjSdH1gfeS7PZlhv6kQ2bZyQuuGs=;
        b=nFQuMlxcLKDuH6r2+aVcJf9DzqHmt25xrtRpljPW14tQpJFAFKhBVbk95803RLZ6ZP
         //Eg2ah0PJS02nQ/Cd8D3Byd8LFR07/5d2ybYKFzVrBLAWo4Th3nvc6yi+DtRHD2sIao
         /5OFawkroHd0XQUuO3TsXcBZzf86QkQZBujLhaZP/Xww9XSgyJRFbqoknvGVZGzI2wkW
         rzbmGcu1TuFGANfFcBSpNGp6UY4ehkHAHmdWXvcfdDEDOn5D+TKMXIVetddEKgcxIYoV
         xwjsZ2ASh/tBS360x7RTNQRigKyLqu6GFAmoBuxT1FpVVWGSdjnO8Gb83wpGN830/896
         Y+dQ==
X-Gm-Message-State: AHQUAua3qyWnalcpD7YTqGvy1oc+GViL/u2ezEaxNaO01nhyQ7OLa7Jw
        Y7hHlUTeWHKWtYZ/TKRTRu0=
X-Google-Smtp-Source: AHgI3Iax9u5EOA4CHsBh34y5VYg5p3OJIdER47WsMVYWE6eY28TX4m3wdqmCq+y7Pmv8DEgsGLgDcg==
X-Received: by 2002:adf:eac2:: with SMTP id o2mr168226wrn.280.1550094396911;
        Wed, 13 Feb 2019 13:46:36 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f2sm653880wmb.19.2019.02.13.13.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:46:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] mingw: use a more canonical method to fix the CPU reporting
References: <pull.125.git.gitgitgadget@gmail.com>
        <68df753d12b712ec33943a310f0bc80f4ec78d9a.1550053187.git.gitgitgadget@gmail.com>
Date:   Wed, 13 Feb 2019 13:46:35 -0800
In-Reply-To: <68df753d12b712ec33943a310f0bc80f4ec78d9a.1550053187.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 13 Feb 2019
        02:19:49 -0800 (PST)")
Message-ID: <xmqq8syjbbus.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In `git version --build-options`, we report also the CPU, but in Git for
> Windows we actually cross-compile the 32-bit version in a 64-bit Git for
> Windows, so we cannot rely on the auto-detected value.
>
> In 3815f64b0dd9 (mingw: fix CPU reporting in `git version
> --build-options`, 2019-02-07), we fixed this by a Windows-only
> workaround, making use of magic pre-processor constants, which works in
> GCC, but most likely not all C compilers.
>
> As pointed out by Eric Sunshine, there is a better way, anyway: to set
> the Makefile variable HOST_CPU explicitly for cross-compiled Git. So
> let's do that!
>
> This reverts commit 3815f64b0dd983bdbf9242a0547706d5d81cb3e6 partially.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.h   | 19 -------------------
>  config.mak.uname |  2 ++
>  2 files changed, 2 insertions(+), 19 deletions(-)

Will apply; thanks.

>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 363f047df0..8c24ddaa3e 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -6,25 +6,6 @@ typedef _sigset_t sigset_t;
>  #include <winsock2.h>
>  #include <ws2tcpip.h>
>  
> -#ifdef __MINGW64_VERSION_MAJOR
> -/*
> - * In Git for Windows, we cannot rely on `uname -m` to report the correct
> - * architecture: /usr/bin/uname.exe will report the architecture with which the
> - * current MSYS2 runtime was built, not the architecture for which we are
> - * currently compiling (both 32-bit and 64-bit `git.exe` is built in the 64-bit
> - * Git for Windows SDK).
> - */
> -#undef GIT_HOST_CPU
> -/* This was figured out by looking at `cpp -dM </dev/null`'s output */
> -#if defined(__x86_64__)
> -#define GIT_HOST_CPU "x86_64"
> -#elif defined(__i686__)
> -#define GIT_HOST_CPU "i686"
> -#else
> -#error "Unknown architecture"
> -#endif
> -#endif
> -
>  /* MinGW-w64 reports to have flockfile, but it does not actually have it. */
>  #ifdef __MINGW64_VERSION_MAJOR
>  #undef _POSIX_THREAD_SAFE_FUNCTIONS
> diff --git a/config.mak.uname b/config.mak.uname
> index 3ee7da0e23..194f20a8b3 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -553,9 +553,11 @@ else
>  		prefix = /usr/
>  		ifeq (MINGW32,$(MSYSTEM))
>  			prefix = /mingw32
> +			HOST_CPU = i686
>  		endif
>  		ifeq (MINGW64,$(MSYSTEM))
>  			prefix = /mingw64
> +			HOST_CPU = x86_64
>  		else
>  			COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
>  			BASIC_LDFLAGS += -Wl,--large-address-aware
