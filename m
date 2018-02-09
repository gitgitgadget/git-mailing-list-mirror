Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 062CF1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 14:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbeBIOUC (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 09:20:02 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36160 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeBIOUB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 09:20:01 -0500
Received: by mail-wm0-f66.google.com with SMTP id f3so16600693wmc.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 06:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bJSTZfD0s7lkDKzEoqyHqgDMbz2LmcuNFSz8S7KyW2c=;
        b=jqvpyzoKKgEzyxYd8Xf92tDybeIv3t00Vnr7zfnAemRymPF85f4qMtPfYmNiHA/G5y
         cTKc1xziD69wsivRuTsVtfTpAacoBze36CWWlWvRT7QLnu+5HR8p1PE9IiYFDC0UqteI
         ynUqGwRXRc4BJ04y0UKcPu0Mv0MObfLEYfLiABJmLxudXxGo9Mmaryj3H+eE+v9UlfEm
         qqwHrUBAxR9WqY7BAwL+0NGMFvRSJ92TPydnHTOWRt5nTeHPkmgAwDLt5saSd7E5rQm+
         V3gMfbTNDjPXIpqPUkwO+8ka3P9ZDwd3WJh6fQlN0u01BkDNAgHRNNEsySjxU9fzRXVV
         vhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=bJSTZfD0s7lkDKzEoqyHqgDMbz2LmcuNFSz8S7KyW2c=;
        b=efKLL306nMm/x57Tfb6eKj1b/uZIHLE+/m8n8eFFszt8JN4QXDjCqJiIXZqXxX9ztk
         2puNLv+XnXiHmIClMjWXJ7reo3Y2CWNxzcsv52MiY+6k9w7WPYYX9+UruVxAkW5EqKTv
         hyItB6j30+dlZNnVDU29tha/kh/wHoNFJzifSfXs59UPkYKbccHdqsQLNyWT3j6ZQnRJ
         RlRCheSAvoycEb9GsxVZbmRpPBId6nbag78FcYaFVd0DaKF49bbp7pl4ylU9kHgNNsOq
         b4qwLzugiDVFiOgc961afbHJlGEtXx8HK8wIRVA6sfNUiCo97/LP3iPKrc7sFIbFL05v
         RARQ==
X-Gm-Message-State: APf1xPB0DuxrEC9nNveyLYOnfRNZy8qKky4yoG8PpJjWHMvuoEOhsnh2
        T1x5NUnHecPddWQPYg3NoAdbM5Ag
X-Google-Smtp-Source: AH8x225wBsX/F8AJAqhdNMfTWHqLNBnGReH7EaWUcGMIFf6DL1HKcPqrqArV/qDNjhhmyguA5cCxKg==
X-Received: by 10.28.181.72 with SMTP id e69mr2031782wmf.7.1518185999504;
        Fri, 09 Feb 2018 06:19:59 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id h14sm2519940wrb.29.2018.02.09.06.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 06:19:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 42/42] git-completion.bash: add GIT_COMPLETION_OPTIONS=all config
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com> <20180209110221.27224-43-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180209110221.27224-43-pclouds@gmail.com>
Date:   Fri, 09 Feb 2018 15:19:57 +0100
Message-ID: <877ermmeia.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 09 2018, Nguyễn Thái Ngọc Duy jotted:

> By default, some option names (mostly --force, scripting related or for
> internal use) are not completable for various reasons. When
> GIT_COMPLETION_OPTIONS is set to all, all options (except hidden ones)
> are completable.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  contrib/completion/git-completion.bash |  6 +++++-
>  parse-options.c                        | 11 +++++++----
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0ddf40063b..0cfa489a8e 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -36,6 +36,10 @@
>  #
>  #     When set to "1", do not include "DWIM" suggestions in git-checkout
>  #     completion (e.g., completing "foo" when "origin/foo" exists).
> +#
> +#   GIT_COMPLETION_OPTIONS
> +#
> +#     When set to "all", complete all possible options

I was going to suggest some wording like:

    When set to "all", include options considered unsafe such as --force
    in the completion.

However per your cover letter it's not just used for that:

     10 --force
      4 --rerere-autoupdate
      1 --unsafe-paths
      1 --thin
      1 --overwrite-ignore
      1 --open-files-in-pager
      1 --null
      1 --ext-grep
      1 --exit-code
      1 --auto

I wonder if we shouldn't just make this only about --force, I don't see
why "git grep --o<TAB>" should only show --or but not
--open-files-in-pager, and e.g. "git grep --<TAB>" is already verbose so
we're not saving much by excluding those.

Then this could just become:

    GIT_COMPLETION_SHOWUNSAFEOPTIONS=1

Or other similar boolean variable, for consistency with all the "*SHOW*
variables already in git-completion.bash.

>  case "$COMP_WORDBREAKS" in
>  *:*) : great ;;
> @@ -303,7 +307,7 @@ __gitcomp_builtin ()
>  	if [ -z "$options" ]; then
>  		# leading and trailing spaces are significant to make
>  		# option removal work correctly.
> -		options=" $(__git ${cmd/_/ } --git-completion-helper) $incl "
> +		options=" $(__git ${cmd/_/ } --git-completion-helper=$GIT_COMPLETION_OPTIONS) $incl "
>  		for i in $excl; do
>  			options="${options/ $i / }"
>  		done
> diff --git a/parse-options.c b/parse-options.c
> index 979577ba2c..5b8b2b376e 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -430,14 +430,17 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
>   * many options that do not suppress it properly.
>   */
>  static int show_gitcomp(struct parse_opt_ctx_t *ctx,
> -			const struct option *opts)
> +			const struct option *opts,
> +			const char *arg)
>  {
>  	for (; opts->type != OPTION_END; opts++) {
>  		const char *suffix = "";
>
>  		if (!opts->long_name)
>  			continue;
> -		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
> +		if (opts->flags & PARSE_OPT_HIDDEN)
> +			continue;
> +		if ((opts->flags & PARSE_OPT_NOCOMPLETE) && strcmp(arg, "all"))
>  			continue;
>
>  		switch (opts->type) {
> @@ -498,8 +501,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>  			goto show_usage;
>
>  		/* lone --git-completion-helper is asked by git-completion.bash */
> -		if (ctx->total == 1 && !strcmp(arg + 1, "-git-completion-helper"))
> -			return show_gitcomp(ctx, options);
> +		if (ctx->total == 1 && skip_prefix(arg + 1, "-git-completion-helper=", &arg))
> +			return show_gitcomp(ctx, options, arg);
>
>  		if (arg[1] != '-') {
>  			ctx->opt = arg + 1;
