Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75EA21FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 09:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752818AbcLHJxD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 04:53:03 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:36247 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbcLHJxC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 04:53:02 -0500
Received: by mail-io0-f193.google.com with SMTP id s82so2285893ioi.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 01:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iq2VLABxpYVxUH/6RdWJHxmH1jtn3zNL/MHouryTEpY=;
        b=luk7qqfvO1XSBsyvh581FXzzd1zey1ylYk9MiGbM+KzKnpiRdLC/NRJRl0S2NdHUbI
         T2SkIsJRbNNTC5W+B/oJDl7fZGS1VcuwW0g89sMW2b/ImFCW+Ix4V95UhVOKIbzyAE9a
         ineKZBWRyPRMcV9W5mLBvKrQHhLx4F8y2VaP+dXRgDhOXZh2XIfGepWknY27UVB28j1h
         JgUpRYqgjo5TLQIyqCt76L5uh0fBp1BvKJ2J3ml/utwb0GcmTuJICZXAwtec6o2oRgQv
         Lx/ZBhp8wPnnZ2m1spol23BxjSdFiy9hf+gn3Kde5F4ftivOG3QBjOV4u4e5Cq1KQVuj
         F7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iq2VLABxpYVxUH/6RdWJHxmH1jtn3zNL/MHouryTEpY=;
        b=aZFLKtd2pXMIZ7hQ14koh4dvnVUNt9m9u2N+wFyKO05DjEd7tINSbrvh+AGFo9q+Qs
         Er7ekJ2n8x4kx7CjW3mrRTwal4LYVYg9MGCEviNX9sEQfVzK2HJGENMYspulZHmlJYrJ
         mOLB+9SyxhDhQj6yD4CEUsd4b+q358xNmX5RV2ufHrxRZK89WeJi/GfTW6Am0gORYtDD
         XIxdzvmkA1eiDLlUrGMZ5FNLWVeohDnyhpbYpiCB3+TtWeoryOS8KnXGtsxP12cukBW4
         wHVEguWoR9sm/AzUSrqC1HKH30seBxZPioe6MTkVChYPPbXvP5ex7l0Gc0mSNSjRnRby
         9gHg==
X-Gm-Message-State: AKaTC01P0kIzU8urL+lG13PxzVhrLzF3s6+1DF87EKHCsMpAxGMSE0kP9qx0MJWgs4gidVa2T+pn4t5JjoppAg==
X-Received: by 10.107.44.137 with SMTP id s131mr59362300ios.212.1481190781408;
 Thu, 08 Dec 2016 01:53:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 8 Dec 2016 01:52:30 -0800 (PST)
In-Reply-To: <20161208014623.7588-3-sbeller@google.com>
References: <20161208014623.7588-1-sbeller@google.com> <20161208014623.7588-3-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 16:52:30 +0700
Message-ID: <CACsJy8AohKMTm0inUyxu=kTwxNFcCbbBRO=O126SCzi5e=0tSQ@mail.gmail.com>
Subject: Re: [PATCHv6 2/7] submodule helper: support super prefix
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 8:46 AM, Stefan Beller <sbeller@google.com> wrote:
> Just like main commands in Git, the submodule helper needs
> access to the superproject prefix. Enable this in the git.c
> but have its own fuse in the helper code by having a flag to
> turn on the super prefix.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/submodule--helper.c | 31 ++++++++++++++++++++-----------
>  git.c                       |  2 +-
>  2 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 4beeda5f9f..33676a57cf 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1076,21 +1076,24 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
>         return 0;
>  }
>
> +#define SUPPORT_SUPER_PREFIX (1<<0)
> +
>  struct cmd_struct {
>         const char *cmd;
>         int (*fn)(int, const char **, const char *);
> +       int option;

unsigned int is probably safer for variables that are used as bit-flags.

>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> @@ -1100,9 +1103,15 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>                 die(_("submodule--helper subcommand must be "
>                       "called with a subcommand"));
>
> -       for (i = 0; i < ARRAY_SIZE(commands); i++)
> -               if (!strcmp(argv[1], commands[i].cmd))
> +       for (i = 0; i < ARRAY_SIZE(commands); i++) {
> +               if (!strcmp(argv[1], commands[i].cmd)) {
> +                       if (get_super_prefix() &&
> +                           !(commands[i].option & SUPPORT_SUPER_PREFIX))
> +                               die("%s doesn't support --super-prefix",
> +                                   commands[i].cmd);

If it's meant for users to see, please _() the string.

>                         return commands[i].fn(argc - 1, argv + 1, prefix);
> +               }
> +       }
>
>         die(_("'%s' is not a valid submodule--helper "
>               "subcommand"), argv[1]);
> diff --git a/git.c b/git.c
> index efa1059fe0..98dcf6c518 100644
> --- a/git.c
> +++ b/git.c
> @@ -493,7 +493,7 @@ static struct cmd_struct commands[] = {
>         { "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>         { "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>         { "stripspace", cmd_stripspace },
> -       { "submodule--helper", cmd_submodule__helper, RUN_SETUP },
> +       { "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},

The same macro defined twice in two separate .c files? Hmm.. it
confused me a bit because i thought there was a connection.. I guess
it's ok.
-- 
Duy
