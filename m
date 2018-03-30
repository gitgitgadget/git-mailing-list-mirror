Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0E81F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeC3Tq3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:46:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55956 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbeC3Tq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:46:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id b127so16133753wmf.5
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uzZ5tVqqJKXerewON8z2WbWMnbA+7y3f62W8LshqtMU=;
        b=ZmzV1hPDCxQnmy6wIl6KyR1B10np5YbnbrGqdP/pfl63WU6n+Ifa5jX3dxFwI1KaCQ
         r7GadNvMARow61+WGFvEyT60zP/HFlZ91KwW/7W3V3qF0w9DNcQGaYkDHIt2uBgmdUC+
         my4YLilI09d+NAC17SPDhaVhlaW5AvQ6IKOdV0euSkm2OXgN3DmKxgKONYMiNCLYjkic
         28O1V/4bsvvtpJR+q1SEQ0JqAt6rN5jCppUhcrCXtcZ8x+Z4t/1R1hCABZBe0wK+HmUZ
         iztvwkEoNwj6EsMvrR+4/pzsk95LoskYVL2sUAtG2c1KiD4yYNlKS4uMbx1T2xHWxo1g
         UhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uzZ5tVqqJKXerewON8z2WbWMnbA+7y3f62W8LshqtMU=;
        b=Vz2rFJyvUhFUOt5tE7EWdligEI5pPkC8oqwHNL1sdM8cv6fOIS9lptQBznQP4lrL7f
         Uh+zk2k4wqoJ7spxiWX2K0ITGz5exbQl2oiCtfdBnXU/F3LPUL35TbeAElvn7QTw4srE
         sgrdHbrD2arrihTH9waqEIXS6wFbawWBhd2F1UQz2X0EXnBVsgFcZknSuQ+LGoczjpdu
         ldMFvNMl2EyoSYtcAiLbd+eWabElr2rtdTbfndBQZuhRdYdGbilOTr741bT4L8K0QEMb
         eEU1LwXrDO6f6MGN9qxAeDiM+jVDJ/4XYmOSLm/M010RLP4glOwuMCsSAUfc4uEdT6sJ
         MGTQ==
X-Gm-Message-State: AElRT7Hl1NwUuvZWH1cFJhBRR+XIbvpm8nBSsIf373JMxy0bc4210pgZ
        NZoMbR03vt2P4awhXx4sBNkH/HHr
X-Google-Smtp-Source: AIpwx4+JLIyKfxLIpqsH1qTbVT0pzc8WqstIZdP8qFn5qPGFdafiofppAZ75K7slM/Oy5d5acP222A==
X-Received: by 10.28.147.8 with SMTP id v8mr3358417wmd.13.1522439187508;
        Fri, 30 Mar 2018 12:46:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n47sm9319015wrf.41.2018.03.30.12.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 12:46:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] trace.c: export trace_setup_key
References: <20180330183425.GA30575@sigill.intra.peff.net>
        <20180330183459.GB31135@sigill.intra.peff.net>
Date:   Fri, 30 Mar 2018 12:46:26 -0700
In-Reply-To: <20180330183459.GB31135@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 30 Mar 2018 14:34:59 -0400")
Message-ID: <xmqq8ta92vot.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>
> This is so that we can print traces based on this key outside trace.c.

"this key" meaning...?  GIT_TRACE_SETUP?

>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  trace.c | 14 +++++++-------
>  trace.h |  1 +
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/trace.c b/trace.c
> index 7f3b08e148..fc623e91fd 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -26,6 +26,7 @@
>  
>  struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
>  struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
> +struct trace_key trace_setup_key = TRACE_KEY_INIT(SETUP);
>  
>  /* Get a trace file descriptor from "key" env variable. */
>  static int get_trace_fd(struct trace_key *key)
> @@ -300,11 +301,10 @@ static const char *quote_crnl(const char *path)
>  /* FIXME: move prefix to startup_info struct and get rid of this arg */
>  void trace_repo_setup(const char *prefix)
>  {
> -	static struct trace_key key = TRACE_KEY_INIT(SETUP);
>  	const char *git_work_tree;
>  	char *cwd;
>  
> -	if (!trace_want(&key))
> +	if (!trace_want(&trace_setup_key))
>  		return;
>  
>  	cwd = xgetcwd();
> @@ -315,11 +315,11 @@ void trace_repo_setup(const char *prefix)
>  	if (!prefix)
>  		prefix = "(null)";
>  
> -	trace_printf_key(&key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
> -	trace_printf_key(&key, "setup: git_common_dir: %s\n", quote_crnl(get_git_common_dir()));
> -	trace_printf_key(&key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
> -	trace_printf_key(&key, "setup: cwd: %s\n", quote_crnl(cwd));
> -	trace_printf_key(&key, "setup: prefix: %s\n", quote_crnl(prefix));
> +	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
> +	trace_printf_key(&trace_setup_key, "setup: git_common_dir: %s\n", quote_crnl(get_git_common_dir()));
> +	trace_printf_key(&trace_setup_key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
> +	trace_printf_key(&trace_setup_key, "setup: cwd: %s\n", quote_crnl(cwd));
> +	trace_printf_key(&trace_setup_key, "setup: prefix: %s\n", quote_crnl(prefix));
>  
>  	free(cwd);
>  }
> diff --git a/trace.h b/trace.h
> index 88055abef7..2b6a1bc17c 100644
> --- a/trace.h
> +++ b/trace.h
> @@ -15,6 +15,7 @@ extern struct trace_key trace_default_key;
>  
>  #define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
>  extern struct trace_key trace_perf_key;
> +extern struct trace_key trace_setup_key;
>  
>  extern void trace_repo_setup(const char *prefix);
>  extern int trace_want(struct trace_key *key);
