Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F9D1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 16:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeHRTlq (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 15:41:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35995 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeHRTlq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 15:41:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so9976404wmc.1
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lcJypHq8OSA0T0RpBwlTvUil6cB2gFx/j88bjpkK8v0=;
        b=FNkcMwVx+zEDCUrfYjCvtphZEgolIDZIPj2AILZ5T0QGK38/qgsou4I2gnRZo3yAmi
         Z0tYhDh8oz4mhaMW01FFHMbBNv1MrhnHA6Ye7IHKc1oBsKGBXg6eXXEobzoOiB101PEj
         T7wznBPotZzJ3OHcyG3UwpRQtbcj6sm/gP0kSX6F3TjfCO929xWEYcEu07LFXISWAshk
         SRiwQuGMqAbbjaeK3v4lZNddvELuMIyR3qUObVwm7ql1gMU5iQcmRDZ8wfuEoh7Nh07a
         5g3e3eOUJq9G8SNfa2Ut8vtsxJuj4IZqR8MX+Rj8PWqd9ALgjq4JXsL/i6CkoTJwv8Fu
         9f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lcJypHq8OSA0T0RpBwlTvUil6cB2gFx/j88bjpkK8v0=;
        b=cHJaIV79h/TphlEP4M5eTf/Q1+LiqRGjD3F6AmWETE/xMRt0Pcao76ffEj1rb/c9tQ
         Fk8KcG8fqfjwp5+hE6ZJ2OvugYs5Gm74aa5qnRLn+kSRn6TxYrOAOge7zcH4X8NotJrR
         lIYceKNd6NfRJCfyWTTQiT4U6C7ZJew2jjlKPXjwL7QsKvvm/if1bKEAhKj1tNaQ4FrP
         f3fX5kCIWaDaZimnIuhvTkBuNDQJ9MeKV8LcUcNaH4i14fICz6wbSCPMcIAsaRL9KeU/
         0cJpQKHAj4N92Jh6zhdPxs6HRMS/PMGtaQbwGtLoKaAGmpYPx2BEcMkAMLoXxB46JJzV
         Knrw==
X-Gm-Message-State: AOUpUlE/b5Glqb+GHvhgA7Xdzkz4TBlpGXYfpgBL/7z49HyWNPo9kP4b
        1CCK9SVuyNJSJF1nOhQrrTyfwHKo
X-Google-Smtp-Source: AA+uWPzwqRpX9szH4yr9Jik5WHJl/wAwlVVekmz+r3wPLGQKQWNFlWwrqXg8Ue/b3g4f2jJP1/1imw==
X-Received: by 2002:a1c:8dd1:: with SMTP id p200-v6mr19892006wmd.145.1534610007200;
        Sat, 18 Aug 2018 09:33:27 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id j8-v6sm3724295wrn.50.2018.08.18.09.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 09:33:26 -0700 (PDT)
Date:   Sat, 18 Aug 2018 17:33:25 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 22/26] stash: convert save to builtin
Message-ID: <20180818163325.GE11326@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <d39aca1880ccf94f9f207cd09b4a5cc2c3c233e7.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d39aca1880ccf94f9f207cd09b4a5cc2c3c233e7.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> Add stash save to the helper and delete functions which are no
> longer needed (`show_help()`, `save_stash()`, `push_stash()`,
> `create_stash()`, `clear_stash()`, `untracked_files()` and
> `no_changes()`).
> ---
>  builtin/stash--helper.c |  48 +++++++
>  git-stash.sh            | 311 +---------------------------------------
>  2 files changed, 50 insertions(+), 309 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 5c27f5dcf..f54a476e3 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -26,6 +26,8 @@ static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
>  	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
>  	   "          [--] [<pathspec>...]]"),
> +	N_("git stash--helper save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
> +	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
>  	NULL
>  };
>  
> @@ -81,6 +83,12 @@ static const char * const git_stash_helper_push_usage[] = {
>  	NULL
>  };
>  
> +static const char * const git_stash_helper_save_usage[] = {
> +	N_("git stash--helper save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
> +	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
> +	NULL
> +};
> +
>  static const char *ref_stash = "refs/stash";
>  static int quiet;
>  static struct strbuf stash_index_path = STRBUF_INIT;
> @@ -1445,6 +1453,44 @@ static int push_stash(int argc, const char **argv, const char *prefix)
>  			     include_untracked, quiet, stash_msg);
>  }
>  
> +static int save_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int i;
> +	int keep_index = -1;
> +	int patch_mode = 0;
> +	int include_untracked = 0;
> +	int quiet = 0;
> +	char *stash_msg = NULL;
> +	struct strbuf alt_stash_msg = STRBUF_INIT;
> +	struct option options[] = {
> +		OPT_SET_INT('k', "keep-index", &keep_index,
> +			N_("keep index"), 1),
> +		OPT_BOOL('p', "patch", &patch_mode,
> +			N_("stash in patch mode")),
> +		OPT_BOOL('q', "quiet", &quiet,
> +			N_("quiet mode")),

This could be OPT__QUIET again as mentioned in the previous patch as
well.

> +		OPT_BOOL('u', "include-untracked", &include_untracked,
> +			 N_("include untracked files in stash")),
> +		OPT_SET_INT('a', "all", &include_untracked,
> +			    N_("include ignore files"), 2),
> +		OPT_STRING('m', "message", &stash_msg, N_("message"),
> +			 N_("stash message")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_save_usage,
> +			     0);
> +
> +	for (i = 0; i < argc; ++i)
> +		strbuf_addf(&alt_stash_msg, "%s ", argv[i]);
> +
> +	stash_msg = strbuf_detach(&alt_stash_msg, NULL);

We unconditionally overwrite 'stash_msg' here, even if a '-m'
parameter was given earlier, which I don't think is what we intended
here.  I think we started "supporting" (not erroring out on rather)
the '-m' flag accidentally (my bad, sorry) in 'git stash save' rather
than intentionally, and indeed it has the same behaviour as the code
above.

However I think we should just not add support the '-m' flag here, as
it doesn't make a lot of sense to have two ways of passing a message.

We also never free the memory we get back here from 'strbuf_detach'.
As this is not code in 'libgit.a' that's probably fine, and we can
just add an 'UNLEAK(stash_msg)' here I think.

It may generally be interesting to consider using a leak checker, and
see how far we can get in making this leak free.  It may not be
possible to make 'git stash' completely leak free, as the underlying
APIs may not be, but it may be interesting to see how far we can get
for the new code only.

> +
> +	return do_push_stash(0, NULL, prefix, keep_index, patch_mode,
> +			     include_untracked, quiet, stash_msg);
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -1485,6 +1531,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!create_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "push"))
>  		return !!push_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "save"))
> +		return !!save_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
>
> [...]
