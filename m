Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CBE81F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932140AbeAXUgT (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:36:19 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41874 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXUgS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:36:18 -0500
Received: by mail-pg0-f67.google.com with SMTP id 136so3517869pgd.8
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 12:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VWQkA3k47Qh/81o40LMWfKi0jF++m46a6cIHgNcwIdU=;
        b=fSNI8C2wvLC1F7M8HDnITxgM/q1D2F54DCgifj0RzaAceUUVS1HemZW++JDW3SGK7q
         prn2mo0RYaOFuHGd0KZtq6U134KKmd6Pw8Fl4elPx/Lgl1Y9rtTQqMUfoWYr4ErbvBFT
         Y/LWw7hSb2syHt8zwDE47PBZpPDa4Jv0YmrWlVbb0eFxsWtk+CcI4mumeZi1kOYkS540
         /Qqo//TZk6az99ZNJipilETUvkGiduLPc8nz5cSpFdPvT8AMZCv9XhoGitupEnyp/oUd
         sfhnsTblgXtFromMKjNjP4ZWjCKEKwThjvyIwuDgxfI5/nTiJTdqlqoRZyf+1uJM8yYd
         UL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VWQkA3k47Qh/81o40LMWfKi0jF++m46a6cIHgNcwIdU=;
        b=K2dqyUP4H2TRAKrhhcsKHLE8bPS0JftNew+0ZxGsag2FLBrU67vh8Q9MUa7QMKYjf6
         qeD6CJ3mN2gVALONbi6a8b1ExswqKjKfEHVz6a6rja5XfnYaRUjLmBJxri4FGbg7mLYe
         rElZAanyOVV5StrhM6dtbLp9j2rN7YYA07yw8l6nXU/EyM4imFTmKJRYUEwB6r16iVl6
         xNScVvRB4wH8l+/AFxpOkMfJijHEjKdwBtgLxrDcT36+tzov7mJGUCMMKxnhOOlHANMi
         Db5jNtTiBFCuaVrtKhY6vgDBA5BeDNk08iHcT5aD/HsWZY7ckdlh2NXzWK8ZQuujMmsE
         n48A==
X-Gm-Message-State: AKwxytcnAFTSALhhkiVzn3yJ79B3fC5gKNSm9I+kL0BJImlfKSQUmZkU
        Mc0hcpCCP94OSKI2q2ZqgxaLtdEOat8=
X-Google-Smtp-Source: AH8x225gByiCRkIIRy+explg+juG+VaP0yEOzjCr0zjGCaa/8eltALIErZ/YXxDMGUQWtEoW4SoDGw==
X-Received: by 2002:a17:902:f:: with SMTP id 15-v6mr9146231pla.419.1516826177763;
        Wed, 24 Jan 2018 12:36:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id c184sm11949365pfg.57.2018.01.24.12.36.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 12:36:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 3/4] Bring NonStop platform definitions up to date in git-compat-util.h
References: <20180121234203.13764-1-randall.s.becker@rogers.com>
        <20180121234203.13764-4-randall.s.becker@rogers.com>
Date:   Wed, 24 Jan 2018 12:36:16 -0800
In-Reply-To: <20180121234203.13764-4-randall.s.becker@rogers.com> (randall
        s. becker's message of "Sun, 21 Jan 2018 18:42:02 -0500")
Message-ID: <xmqq1sifdmf3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> Add correct FLOSS (NonStop platform emulation) definitions into
> git-compat-util.h to allow correct emulation of non-platform
> behaviour. Also added NSIG definition that is not explicitly
> supplied in signal.h on platform.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  git-compat-util.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 68b2ad531..fb3ef0dcf 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -378,6 +378,21 @@ static inline char *git_find_last_dir_sep(const char *path)
>  #define find_last_dir_sep git_find_last_dir_sep
>  #endif
>  
> +#ifdef __TANDEM
> +#if !defined(_THREAD_SUPPORT_FUNCTIONS) && !defined(_PUT_MODEL_)
> +/* #include <floss.h(floss_read,floss_write,floss_fsync,floss_fork)> */
> +/* #include <floss.h(floss_fork)> */
> +#endif

The above adds a conditional no-op?  That's confusing...

> +#include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
> +#include <floss.h(floss_getpwuid)>
> +#if ! defined NSIG
> +/* NonStop NSE and NSX do not provide NSIG. SIGGUARDIAN(99) is the highest
> +   known, by detective work using kill -l as a list is all signals
> +   instead of signal.h where it should be. */
> +# define NSIG 100
> +#endif
> +#endif
> +
>  #if defined(__HP_cc) && (__HP_cc >= 61000)
>  #define NORETURN __attribute__((noreturn))
>  #define NORETURN_PTR
