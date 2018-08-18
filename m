Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B421F954
	for <e@80x24.org>; Sat, 18 Aug 2018 22:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeHSB0f (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 21:26:35 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33446 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeHSB0f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 21:26:35 -0400
Received: by mail-wm0-f52.google.com with SMTP id i134-v6so4091464wmf.0
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 15:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dx2+tAf8F5CTHvYtrV7eDEi3XzJF9g6YJ7/0bZCIA+c=;
        b=Nj5K3m7p6l6V2ea3rmsQmIwUjMhLPor8F5uoDtfq5KCcBEtEUrJfTnI7CEYvUSD8UL
         ocHnNE5iW46iqtLXKPZM+dgINBMsy7N2WJq5jmJB10nQm/U7LtYCqJ8c9eJVnybGFuYn
         1dMzNNJ0Cqh9NhjL1/jPmwukAx1QVRBIlsnrabB5mFQmZUf4MWJkDlgPWycZ9IOgGhBb
         uTK0BJCXHRxBlGgNtMTSgbR3TVaWY56X7M0D++1U2iAt8+MeFW3WgGd3iQa+AWVunED4
         LL0EKrq0DP6gyUB22sUf4KZiNBDsYCOTnJciaXOHat/OitB9hccPhniHZ+hWaZeTZCMq
         pSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dx2+tAf8F5CTHvYtrV7eDEi3XzJF9g6YJ7/0bZCIA+c=;
        b=HyHk7HljiXUhVlaqUPJu7CmjOpxSqU86wKupAW0Myf5sOxRKno6Lpw67+yUzyVYp37
         /pUFIk+enTKL3T4NlZNs3qzqR59pUSbijCZU/wYv56qUdfNNyOuP5X9zV1LqZ2D03DLL
         7O+di4g69efsAO0htDEHFVk7lIIZaGGTLJkkoEC0tQ65OZBrieRDtfoYTz3vXaA4QwWB
         SI+du3xItp4SF1nEDmoT2WOGNus+/JPU9kXGug9giVQ2dMU8HCAt8C0v5e3SF/vvIR7y
         /xjOr8AyVB1BFXvyf3XEOJJnDn3pyNg8YLePqX3btVy30Uiznn46TI0dvZbrCIM3kaA7
         pfNw==
X-Gm-Message-State: AOUpUlGaW40VfjEFf7Yq93NB4DnmKRFLOTbvwLhu7wnf1xIR2/LWlfGu
        salhhZRDhv+tnl4GOOrUm/I=
X-Google-Smtp-Source: AA+uWPyZNgK7h8XKiKL53FRRMuSVsVbjBI54q4toSCOZfrx0VVI2etJeG6C4vZJoWztGISsV11ud+A==
X-Received: by 2002:a1c:c507:: with SMTP id v7-v6mr21491990wmf.151.1534630642267;
        Sat, 18 Aug 2018 15:17:22 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4873432wme.36.2018.08.18.15.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 15:17:21 -0700 (PDT)
Date:   Sat, 18 Aug 2018 23:17:20 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 21/26] stash: replace spawning `git ls-files`
 child process
Message-ID: <20180818221720.GI11326@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <3286e8443ed1c8f9560aa6bef01aa18ed78266df.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3286e8443ed1c8f9560aa6bef01aa18ed78266df.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> This commit replaces spawning `git ls-files` child process with
> API calls to get the untracked files.
> ---
>  builtin/stash--helper.c | 49 +++++++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 4fd79532c..5c27f5dcf 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -813,27 +813,42 @@ static int store_stash(int argc, const char **argv, const char *prefix)
>  /*
>   * `out` will be filled with the names of untracked files. The return value is:
>   *
> - * < 0 if there was a bug (any arg given outside the repo will be detected
> - *     by `setup_revision()`)
>   * = 0 if there are not any untracked files
>   * > 0 if there are untracked files
>   */
> -static int get_untracked_files(const char **argv, int line_term,
> +static int get_untracked_files(const char **argv, const char *prefix,
>  			       int include_untracked, struct strbuf *out)
>  {
> -	struct child_process cp = CHILD_PROCESS_INIT;
> -	cp.git_cmd = 1;
> -	argv_array_pushl(&cp.args, "ls-files", "-o", NULL);
> -	if (line_term)
> -		argv_array_push(&cp.args, "-z");
> +	int max_len;
> +	int i;
> +	char *seen;
> +	struct dir_struct dir;
> +	struct pathspec pathspec;
> +
> +	memset(&dir, 0, sizeof(dir));
>  	if (include_untracked != 2)
> -		argv_array_push(&cp.args, "--exclude-standard");
> -	argv_array_push(&cp.args, "--");
> -	if (argv)
> -		argv_array_pushv(&cp.args, argv);
> +		setup_standard_excludes(&dir);
>  
> -	if (pipe_command(&cp, NULL, 0, out, 0, NULL, 0))
> -		return -1;
> +	parse_pathspec(&pathspec, 0,
> +		       PATHSPEC_PREFER_FULL,
> +		       prefix, argv);
> +	seen = xcalloc(pathspec.nr, 1);
> +
> +	max_len = fill_directory(&dir, the_repository->index, &pathspec);
> +	for (i = 0; i < dir.nr; i++) {
> +		struct dir_entry *ent = dir.entries[i];
> +		if (!dir_path_match(ent, &pathspec, max_len, seen)) {
> +			free(ent);
> +			continue;
> +		}
> +		strbuf_addf(out, "%s\n", ent->name);

As mentioned in my comments about the 'diff-index' replacement, this
'\n' should probably be '\0', and we should keep the '-z' flag in 'git
update-index', in case somebody has a '\n' in their filenames.

While creating such a file is probably not a good idea anyway, we
should still be able to handle it (and have been before this, so we
shouldn't break it).

> +		free(ent);
> +	}
> +
> +	free(dir.entries);
> +	free(dir.ignored);
> +	clear_directory(&dir);
> +	free(seen);
>  	return out->len;
>  }
>  
> @@ -888,7 +903,7 @@ static int check_changes(const char **argv, int include_untracked,
>  		goto done;
>  	}
>  
> -	if (include_untracked && get_untracked_files(argv, 0,
> +	if (include_untracked && get_untracked_files(argv, prefix,
>  						     include_untracked, &out))
>  		ret = 1;
>  
> @@ -908,7 +923,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
>  	struct child_process cp2 = CHILD_PROCESS_INIT;
>  
>  	cp.git_cmd = 1;
> -	argv_array_pushl(&cp.args, "update-index", "-z", "--add",
> +	argv_array_pushl(&cp.args, "update-index", "--add",
>  			 "--remove", "--stdin", NULL);
>  	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
>  			 stash_index_path.buf);
> @@ -1134,7 +1149,7 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
>  		goto done;
>  	}
>  
> -	if (include_untracked && get_untracked_files(argv, 1,
> +	if (include_untracked && get_untracked_files(argv, prefix,
>  						     include_untracked, &out)) {
>  		if (save_untracked_files(info, &msg, &out)) {
>  			if (!quiet)
> -- 
> 2.18.0.573.g56500d98f
> 
