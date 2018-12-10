Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6427220A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 06:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeLJGg6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 01:36:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34920 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJGg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 01:36:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so9224227wrb.2
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 22:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BXlp5YxT/48ISrKgsqSJnlzrCFZ+wJ3YlUaSMtfNiKI=;
        b=qphTN/udh0hY/wFT1HSFCtpdexe1y3B87Kc4AdEEciUXPV3gtQLESbJnGTG9stLuGU
         RmRq05pYyUyREnoMkN4NAufX1IvMRuDp02jK/YjZcbH0Hjj7QJ/e07mxjQrSKsDuQOFd
         2U83MeufAZ4huESwKYrnC3kKGgsTnCIoZn6Yuy0bf4V4M2lqnP+MUtyBPYitkb17Vrp6
         3z4rvaPszTR4lUkJFp9mdUwpL8wRhmnrfVsTaXc8q45ffja5KnvVqxR02dm7FIaXQgfB
         tnH/UEG3KIzd9XJthtWDuQoVPj2J5O2JXVe6bRHu487VqxSJ1hpfTUztZfyBuLaN3SOt
         bVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=BXlp5YxT/48ISrKgsqSJnlzrCFZ+wJ3YlUaSMtfNiKI=;
        b=RnNj8dPC+xr/9p0ScA0xD5fgX10Y2DminnCKIgYf5FFcnz3LwqLIpFwwx3101UVdsM
         wdIfkzd4QsxOgBnK69JfxlBAl4AOczL8j7fOPaQ0n6kwrI6wax2Z/Lm7p6aqz5Yqng6s
         Epm03rP6825+bYeMzzuwJ8F1A/m//HZ0hNZna8S4zeiklDe1CPomLQy2ByOSTbNPE2tk
         WtsK9M/1zXiqVLKrRJrh4HFFhOtfD+d5OAvWZnvcN9VQ+Drjivc3YjUknk98obeI51th
         0SC7oe5rlPhRkPB7+Nv3jimtHBzGrWApKHg/xI2xkSY25Cs+Ug6GY4jlbPoEHPlXDzFi
         eK8Q==
X-Gm-Message-State: AA+aEWbxKImp8fP0N2qj4i5eF82p8NhwN8SMXAuS4Xo61KnUgkwF2Cj7
        GLejLvGSQGchSAHjJJDrDcU=
X-Google-Smtp-Source: AFSGD/Ua0hA65psE9R2bYrbVVmeI/+QlYn/ziMz9BaGY0n67zALLrbyb1l9Sn1h44cO2pbBsjAPzRg==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr8263086wrv.287.1544423816227;
        Sun, 09 Dec 2018 22:36:56 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r77sm20639583wmd.22.2018.12.09.22.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:36:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH] parse-options: fix SunCC compiler warning
References: <87va4cujtx.fsf@evledraar.gmail.com>
        <20181209102724.8707-1-pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 15:36:54 +0900
In-Reply-To: <20181209102724.8707-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sun, 9 Dec 2018 11:27:24 +0100")
Message-ID: <xmqqy38xkhvd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The compiler reports this because show_gitcomp() never actually
> returns a value:
>
>     "parse-options.c", line 520: warning: Function has no return
>     statement : show_gitcomp
>
> The function calls exit() and will never return. Update and mark it
> NORETURN.

Yuck.  This should do for now, but I am not impressed by the choice
to hook show_gitcomp() call into parse_options_step(), which forces
such an abnormal exit deeper in the callchain [*1*].  For readers
(not compilers), it would help to have a comment at the caller that
says that show_gitcomp() never returns and exits.

	side note #1.  Perhaps parse_options_start() would have been
	a better place, instead of parse_options_step() that is
	repeatedly called in a loop and itself has a loop.  ANd
	worse yet, the check is done inside the loop even though the
	call is to be made only when the --git-completion-helper
	option is given as the sole request.

Thanks.

> Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  parse-options.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 3b874a83a0..6577e52f63 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -474,8 +474,8 @@ static void show_negated_gitcomp(const struct option *opts, int nr_noopts)
>  	}
>  }
>  
> -static int show_gitcomp(struct parse_opt_ctx_t *ctx,
> -			const struct option *opts)
> +static void NORETURN show_gitcomp(struct parse_opt_ctx_t *ctx,
> +				  const struct option *opts)
>  {
>  	const struct option *original_opts = opts;
>  	int nr_noopts = 0;
> @@ -550,7 +550,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>  
>  		/* lone --git-completion-helper is asked by git-completion.bash */
>  		if (ctx->total == 1 && !strcmp(arg + 1, "-git-completion-helper"))
> -			return show_gitcomp(ctx, options);
> +			show_gitcomp(ctx, options);
>  
>  		if (arg[1] != '-') {
>  			ctx->opt = arg + 1;
