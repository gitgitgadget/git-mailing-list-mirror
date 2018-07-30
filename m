Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E503B1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 18:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeG3UBm (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 16:01:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33231 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeG3UBm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 16:01:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id x5-v6so4541216edr.0
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFARPfAq1sAWodgVAXcFEjhhc/tLJNxF8oG1kVU3SGI=;
        b=PhRtTsIPJzFqFvKre1WshIX7+8evd6ycX2lqo7etF2zmq4GzkZsND7baobLENNX0sE
         ul/oSbSG4Pz8r2tkK8X4SzL7BixC8bm33Shy9yy+q44/0w+pnng6IsvtRJuTU5tWdHJP
         Y5KU8OAnMCljFIM1PVoHIyAdYLX/hLpuXzb4wIF1AfJl2o8rRlh5P5z9E/lKKfHTwUFv
         L/oVZAYvewxAWoUQVsSUBEOIdo8LJgB7yqjr+qD3hD8yZCDNHkvHgJMUKvNAw2kaJCeW
         P7+YEegWDe36HaNXUJctyx0vJzr7UIU+ZhQBdQhfq9uzz1OoorHZ8S8vlBsTrZlAzk9a
         Et3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFARPfAq1sAWodgVAXcFEjhhc/tLJNxF8oG1kVU3SGI=;
        b=r3APedMSscJa6XID5DsDeyYlBhPt0MhM/d0IcHx4MQW5h35LvNMFbs59Ml7ho7JTJO
         aYmasfehGY7v+mYvDrSrntuZl3kW/l+yeDVeGpXfFTStY26h80sqXXUFbKgZ21t1frj+
         RwyE1MCKNdV98p7h9MjqPlXSp9idiHbkxDjpy4bGnX8GoVOV9k4VqsGlT6dzbT8h0E3U
         yaY8cMGrCyzScXtPgBqXcV3uN359Kz1pfWYGtkH/PC4M/adhPTzVry0TpLHmemMQaY4h
         iAdDI91CgbEueCYYez2sEuLCUfOhu3g/OFEluG8SO9km13uYz+uo+Rt3Pli/miAqC7zB
         TUZQ==
X-Gm-Message-State: AOUpUlGQbN6hnbsAF/pUA44+f93XS3Om6fwLNi2N+0wAKy9mAIbbCkjw
        8XlIG46ISVSxisuAXy25AGQ=
X-Google-Smtp-Source: AAOMgpeR5htqXuNecHqWpfjIN9ziw+Q9zoATz9QWcB6+FfzYB0ExrdicRNXAz5yF+nJ5NzdxKJbIRQ==
X-Received: by 2002:a50:ad55:: with SMTP id z21-v6mr8918283edc.142.1532975126942;
        Mon, 30 Jul 2018 11:25:26 -0700 (PDT)
Received: from localhost.localdomain (x590d1455.dyn.telefonica.de. [89.13.20.85])
        by smtp.gmail.com with ESMTPSA id t8-v6sm2136770edr.91.2018.07.30.11.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 11:25:26 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: [GSoC][PATCH v4 15/20] rebase -i: rewrite write_basic_state() in C
Date:   Mon, 30 Jul 2018 20:25:16 +0200
Message-Id: <20180730182516.32644-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180724163221.15201-16-alban.gruin@gmail.com>
References: <20180710121557.6698-1-alban.gruin@gmail.com> <20180724163221.15201-1-alban.gruin@gmail.com> <20180724163221.15201-16-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/sequencer.c b/sequencer.c
> index 1c035ceec7..d257903db0 100644
> --- a/sequencer.c
> +++ b/sequencer.c

> +int write_basic_state(struct replay_opts *opts, const char *head_name,
> +		      const char *onto, const char *orig_head)
> +{
> +	const char *quiet = getenv("GIT_QUIET");
> +
> +	if (head_name)
> +		write_file(rebase_path_head_name(), "%s\n", head_name);
> +	if (onto)
> +		write_file(rebase_path_onto(), "%s\n", onto);
> +	if (orig_head)
> +		write_file(rebase_path_orig_head(), "%s\n", orig_head);
> +
> +	if (quiet)
> +		write_file(rebase_path_quiet(), "%s\n", quiet);
> +	else
> +		write_file(rebase_path_quiet(), "");

This is not a faithful conversion of the original.  git-rebase.sh writes
this 'quiet' file with:

  echo "$GIT_QUIET" > "$state_dir"/quiet

which means that a single newline character was written even when
$GIT_QUIET was unset/empty.

I seem to recall a case in the past, when a shell-to-C conversion
accidentally dropped a newline from a similar state-file, which then
caused some issues later on.  But I don't remember the specifics and a
quick search didn't turn up anything relevant either...

> +
> +	if (opts->verbose)
> +		write_file(rebase_path_verbose(), "");
> +	if (opts->strategy)
> +		write_file(rebase_path_strategy(), "%s\n", opts->strategy);
> +	if (opts->xopts_nr > 0)
> +		write_strategy_opts(opts);
> +
> +	if (opts->allow_rerere_auto == RERERE_AUTOUPDATE)
> +		write_file(rebase_path_allow_rerere_autoupdate(), "--rerere-autoupdate\n");
> +	else if (opts->allow_rerere_auto == RERERE_NOAUTOUPDATE)
> +		write_file(rebase_path_allow_rerere_autoupdate(), "--no-rerere-autoupdate\n");
> +
> +	if (opts->gpg_sign)
> +		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
> +	if (opts->signoff)
> +		write_file(rebase_path_signoff(), "--signoff\n");
> +
> +	return 0;
> +}
> +
>  static int walk_revs_populate_todo(struct todo_list *todo_list,
>  				struct replay_opts *opts)
>  {
