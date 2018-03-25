Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E38851F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 07:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeCYHIn (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 03:08:43 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40669 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbeCYHIm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 03:08:42 -0400
Received: by mail-qt0-f195.google.com with SMTP id g5so5520428qth.7
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nIcTv8M7aNB0R3DqlVnIOfkp6VrmGtUx+KhlXxToKhs=;
        b=WSTIj8kbiD1pafmURRLMmeKyfcDJLMf28RMo9dkIEUfxUhbt4FpFOANJgWtOdPAK6l
         kJhQ9dXZ2Xb5YQAdzPzs5fk5gLMbANNVk8edP8g3T5GNogjMQii3ImLMH6Jx4bOLEEFE
         zvLsfX40uwUVkmnCfA4IkUkWCqRa+j3vU9OMMVcgMbhKa2Bkil2fNXwHPQYQFBvULMRP
         yhoNMlwEGIhIZkfp1QPxP8iVy89rv1SYexXe1Iv90Y1q1SlXb4Ml4rasnv7A/rSnYcNQ
         KD1JYxSzmsRlJUUsDLiagtPvNd+W/cGWnz6hhEj3GBlLVyv3CWBaLcPywaGOMTxu+Yqr
         1N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nIcTv8M7aNB0R3DqlVnIOfkp6VrmGtUx+KhlXxToKhs=;
        b=GoscJmUJPO5P3y8y/cOiOcI3DF5GpG4Hvhgw9ZRxpfJx5jmYdZdzZXBiZmzkX3TuG4
         1OIAZkWcuOmhrTItfDx7a2JckOl/BABKsqsMAj0m7PqMqz+tZyfHUVltpRqmsicb8U/Y
         qpEA/QtjB49cPffUy9JQUkymFwbUziX6bBilw8YyPid3xnLTSWCCBUGTQmriU43MMhO6
         u5Wd5ah3VY7QgUHZ9cUWkK1qtuwQ1VLSRx+L+v5NtRtZEjn/yVHxPo6D/wK/eO0UaN7W
         gbt4mxzik9RvB6MKW906D4rRU3ELfsmKEhrCTGxuCZxn3983vIlb0LuefFSalbxZn3Iu
         P8PA==
X-Gm-Message-State: AElRT7GaL+0JGBtQCRUBbVjro6fu7onkeHfqhOHyH9XF0WgJGpQP68l8
        nM292yh6k1Jmkht0Dw9wXCMPO3sAS8HMV641vss=
X-Google-Smtp-Source: AIpwx492+UE/EO/DlVGwbcZVZ38z72/PFaeeDbzoSGTkEkB0Vo0qCTDQTxVn4xHqJg2ZuD3GjK6WEXd+jHshsJyp8MM=
X-Received: by 10.200.80.78 with SMTP id h14mr18719044qtm.154.1521961721729;
 Sun, 25 Mar 2018 00:08:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 25 Mar 2018 00:08:41 -0700 (PDT)
In-Reply-To: <20180324182313.13705-1-ungureanupaulsebastian@gmail.com>
References: <20180324182313.13705-1-ungureanupaulsebastian@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Mar 2018 03:08:41 -0400
X-Google-Sender-Auth: brVpprO5bjpVGOcgygzFr-1V-M4
Message-ID: <CAPig+cS9QwCOG7BA7O5Nu_zsh-xTbDFy2vTWpAXxBuKTY-uzUw@mail.gmail.com>
Subject: Re: [RFC][PATCH] git-stash: convert git stash list to C builtin
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 2:23 PM, Paul-Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
> Currently, because git stash is not fully converted to C, I
> introduced a new helper that will hold the converted commands.
> ---
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> @@ -0,0 +1,52 @@
> +int cmd_stash__helper(int argc, const char **argv, const char *prefix)
> +{
> +       int cmdmode = 0;
> +
> +       struct option options[] = {
> +               OPT_CMDMODE(0, "list", &cmdmode,
> +                        N_("list stash entries"), LIST_STASH),
> +               OPT_END()
> +       };

Is the intention that once git-stash--helper implements all 'stash'
functionality, you will simply rename git-stash--helper to git-stash?
If so, then I'd think that you'd want it to accept subcommand
arguments as bare words ("apply", "drop") in order to be consistent
with the existing git-stash command set, not in dashed form
("--apply", "--drop"). In that case, OPT_CMDMODE doesn't seem
appropriate. Instead, you should be consulting argv[] directly (as in
[1]) after parse_options().

[1]: https://public-inbox.org/git/20180324173707.17699-2-joel@teichroeb.net/

> +       argc = parse_options(argc, argv, prefix, options,
> +                            git_stash__helper_usage, PARSE_OPT_KEEP_UNKNOWN);
> +
> +       if (!cmdmode)
> +               usage_with_options(git_stash__helper_usage, options);
> +
> +       switch (cmdmode) {
> +               case LIST_STASH:
> +                       return list_stash(argc, argv, prefix);
> +       }
> +       return 0;
> +}
> diff --git a/git.c b/git.c
> @@ -466,6 +466,7 @@ static struct cmd_struct commands[] = {
>         { "show-branch", cmd_show_branch, RUN_SETUP },
>         { "show-ref", cmd_show_ref, RUN_SETUP },
>         { "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> +       { "stash--helper", cmd_stash__helper, RUN_SETUP },

You don't require a working tree? Seems odd for git-stash.

>         { "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>         { "stripspace", cmd_stripspace },
>         { "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
