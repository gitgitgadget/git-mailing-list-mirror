Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3884B20248
	for <e@80x24.org>; Mon, 18 Mar 2019 06:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfCRGSp (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 02:18:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35468 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfCRGSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 02:18:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so9650499wrp.2
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 23:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ytnxEWYNOLz11zQtFFd9jjr+9XRxDpV/mD/xiMdC0o4=;
        b=otkh/OzDifitk4bA7prYz6MwpO1hytZn5+UkYWyAfSptshjnqYkVfEq0fgAhKCfTea
         E/kuvMmP3idE7MViFoj5YNkYY7pJ4f4xaYDuH9XSUAZaDWpHDRXYOLn/AK24lrl+kGqA
         ibrftcveQ6kUcbtGc5MJ48c3j3uoaubIuLWHC7Ldotxrps4UPhtsCO9YWyuTLT+AU9yf
         p4Xg51fPwAamWCZiK3WUDet2wOALl5R0/H55AmAsTW2bGZsI0EnE7iNDagddKIR4pCsU
         /2tMIlADrM4ETPNN4sCs4gHTralDoxSd5eknfsZXPy3HP1mEtK3yINwc9hnsOcNqoAuH
         E7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ytnxEWYNOLz11zQtFFd9jjr+9XRxDpV/mD/xiMdC0o4=;
        b=F076vxyp5/Q6fQHAOc4GI5e/bud3/1KeQ6zp6vQ4szTZYA+lwvd0h/vpZ3N0fn8Bdn
         8PpI//F56D3LVjzIY2FBq5jrdAf4PMvzt7e5f7NCxs9fFcWrBQU35n0KFixaHwwpWkww
         bgz3wCMTpMCLN1h16piEUEzi7MGF5ivXKqfcGjtWnNAgqqudzFgmkKB3J64qPjKYe3tr
         c4so8AWpthSPguEA56t4kgdOnyCGeH8RiDZor1FDZg26ysSi7jTu2/TU55m4j7UVNMyj
         29JcJuDybwYqbBdDDdJ2HwGTbu9EN5zU5sBMkawAhbs+G0MgRGN31NtEOsgjo5UMilG0
         qJUg==
X-Gm-Message-State: APjAAAU3850gVKkylDHWUyin0zweDyDg0ZRhtQeP7B42PzGDN7qVswMu
        HwPW83y9ARZtk3ndPJRGhYY=
X-Google-Smtp-Source: APXvYqxFcwi7nq5aBza0r7pe6KgQJkQNd8dTwUGu1pNr8eccFh4S4aRNAuBAbiKDHX6IDOcU2eJrUw==
X-Received: by 2002:a05:6000:4e:: with SMTP id k14mr11125157wrx.52.1552889921978;
        Sun, 17 Mar 2019 23:18:41 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id l3sm5067223wrr.25.2019.03.17.23.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 23:18:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH v1 1/1] trace2: NULL is not allowed for va_list
References: <20190316104715.27138-1-tboegi@web.de>
Date:   Mon, 18 Mar 2019 15:18:41 +0900
In-Reply-To: <20190316104715.27138-1-tboegi@web.de> (tboegi's message of "Sat,
        16 Mar 2019 11:47:15 +0100")
Message-ID: <xmqqlg1c3dtq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> Some compilers don't allow NULL to be passed for a va_list.
> Use va_list instead.

Wow (I seem to be keep saying this today).

>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
>  trace2.c                | 15 +++++++++++----
>  trace2.h                |  4 ++--
>  trace2/tr2_tgt_event.c  |  2 +-
>  trace2/tr2_tgt_normal.c |  2 +-
>  trace2/tr2_tgt_perf.c   |  2 +-
>  5 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/trace2.c b/trace2.c
> index ccccd4ef09..8bbad56887 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -548,10 +548,14 @@ void trace2_region_enter_printf_va_fl(const char *file, int line,
>  }
>
>  void trace2_region_enter_fl(const char *file, int line, const char *category,
> -			    const char *label, const struct repository *repo)
> +			    const char *label, const struct repository *repo, ...)
>  {
> +	va_list ap;
> +	va_start(ap, repo);
>  	trace2_region_enter_printf_va_fl(file, line, category, label, repo,
> -					 NULL, NULL);
> +					 NULL, ap);
> +	va_end(ap);
> +
>  }
>
>  void trace2_region_enter_printf_fl(const char *file, int line,
> @@ -621,10 +625,13 @@ void trace2_region_leave_printf_va_fl(const char *file, int line,
>  }
>
>  void trace2_region_leave_fl(const char *file, int line, const char *category,
> -			    const char *label, const struct repository *repo)
> +			    const char *label, const struct repository *repo, ...)
>  {
> +	va_list ap;
> +	va_start(ap, repo);
>  	trace2_region_leave_printf_va_fl(file, line, category, label, repo,
> -					 NULL, NULL);
> +					 NULL, ap);
> +	va_end(ap);
>  }
>
>  void trace2_region_leave_printf_fl(const char *file, int line,
> diff --git a/trace2.h b/trace2.h
> index ae5020d0e6..b330a54a89 100644
> --- a/trace2.h
> +++ b/trace2.h
> @@ -238,7 +238,7 @@ void trace2_def_repo_fl(const char *file, int line, struct repository *repo);
>   * on this thread.
>   */
>  void trace2_region_enter_fl(const char *file, int line, const char *category,
> -			    const char *label, const struct repository *repo);
> +			    const char *label, const struct repository *repo, ...);
>
>  #define trace2_region_enter(category, label, repo) \
>  	trace2_region_enter_fl(__FILE__, __LINE__, (category), (label), (repo))
> @@ -278,7 +278,7 @@ void trace2_region_enter_printf(const char *category, const char *label,
>   * in this nesting level.
>   */
>  void trace2_region_leave_fl(const char *file, int line, const char *category,
> -			    const char *label, const struct repository *repo);
> +			    const char *label, const struct repository *repo, ...);
>
>  #define trace2_region_leave(category, label, repo) \
>  	trace2_region_leave_fl(__FILE__, __LINE__, (category), (label), (repo))
> diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
> index 107cb5317d..1cf4f62441 100644
> --- a/trace2/tr2_tgt_event.c
> +++ b/trace2/tr2_tgt_event.c
> @@ -190,7 +190,7 @@ static void fn_atexit(uint64_t us_elapsed_absolute, int code)
>  static void maybe_add_string_va(struct json_writer *jw, const char *field_name,
>  				const char *fmt, va_list ap)
>  {
> -	if (fmt && *fmt && ap) {
> +	if (fmt && *fmt) {
>  		va_list copy_ap;
>  		struct strbuf buf = STRBUF_INIT;
>
> diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
> index 547183d5b6..1a07d70abd 100644
> --- a/trace2/tr2_tgt_normal.c
> +++ b/trace2/tr2_tgt_normal.c
> @@ -126,7 +126,7 @@ static void fn_atexit(uint64_t us_elapsed_absolute, int code)
>  static void maybe_append_string_va(struct strbuf *buf, const char *fmt,
>  				   va_list ap)
>  {
> -	if (fmt && *fmt && ap) {
> +	if (fmt && *fmt) {
>  		va_list copy_ap;
>
>  		va_copy(copy_ap, ap);
> diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
> index f0746fcf86..2a866d701b 100644
> --- a/trace2/tr2_tgt_perf.c
> +++ b/trace2/tr2_tgt_perf.c
> @@ -211,7 +211,7 @@ static void fn_atexit(uint64_t us_elapsed_absolute, int code)
>  static void maybe_append_string_va(struct strbuf *buf, const char *fmt,
>  				   va_list ap)
>  {
> -	if (fmt && *fmt && ap) {
> +	if (fmt && *fmt) {
>  		va_list copy_ap;
>
>  		va_copy(copy_ap, ap);
> --
> 2.21.0.135.g6e0cc67761
