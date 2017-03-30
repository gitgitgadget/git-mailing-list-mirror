Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53CF20958
	for <e@80x24.org>; Thu, 30 Mar 2017 01:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933273AbdC3Bdh (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 21:33:37 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34189 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933231AbdC3Bdg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 21:33:36 -0400
Received: by mail-lf0-f68.google.com with SMTP id x137so3229290lff.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 18:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+RHd/byLhaQYb54OtzK1Li0m5zK1xGYJLkh9M+xMAz4=;
        b=BctmLDZXU7UaBDn9KHL9KZkvRvcNt/hL1CupZVAJn2BXA/u9FGxz+0/2ZrIdkmGQsw
         JIPPIufExRlxqBtXT0A27FHEcbOnbqCNBQraVY0eh7c3pXMT2tZ3olI8D2PnwKWjKU8t
         ZV/xWHSvYFDdduRfkFrv82LM6XncRB0xC6tNQhtkmEs9cbxcoKldZBNn/1tMdup7nrSN
         xEJ1OHT8anhaRgwlXbWf3wsEb/Un+jxtybaX7QRMutXgUYqvrWA+Drcmt+S8qK22lMTB
         yKmXHqaE0n6lxmMo++gDJnvnvMq0WE+Y/ZZ0KiA7fIN+Moim/WDKXlIP2Nuc2ge0bQRV
         D6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+RHd/byLhaQYb54OtzK1Li0m5zK1xGYJLkh9M+xMAz4=;
        b=Zm8YR2pBJSnmlzgAaOiOUvA2tMep77q9ExQJ0cDgkD9PeaY7TCX+CJXEpLI0ov/iEa
         T7JZs+/NLkelyV+4GfG08UAfloOlR9Eon6Ug+lYKcJsLpD/cwUbwYX48QL/UU1NZBHyv
         sZ0PEobpWM8WsM8PKNhbbRi93mIwWEJtzqckc5O/Z3EBQMfgEf4aHayvG2dhih3K4Qi9
         0MqVOV2pepnPzBO+7VmbXdQI0EMFxoi686xahR1d7QU2my5RJhBWEHtWFBlwLgcLcY7X
         JT4Hvsud/jZqeRItgC2jO9DDyqp2dZSX+twid+bOaEHn6p0P9nalQzsCYzi5zDtEmW4r
         qV2A==
X-Gm-Message-State: AFeK/H2TuaPK8RjHYGR6uq/LDRjKRh+ijgAr41k68aJO62DruZJvG31jD6o0dQ18OaagUs8xnlDoJIMuysLwnw==
X-Received: by 10.25.77.2 with SMTP id a2mr1026632lfb.143.1490837614410; Wed,
 29 Mar 2017 18:33:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Wed, 29 Mar 2017 18:33:13 -0700 (PDT)
In-Reply-To: <20170330012025.22122-1-sbeller@google.com>
References: <20170330012025.22122-1-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 29 Mar 2017 18:33:13 -0700
Message-ID: <CA+P7+xodO7=0TQPZPseDPw_Owsdy2jrCUKpP0G_+j-bz51KNVA@mail.gmail.com>
Subject: Re: [RFC PATCH] change default for status.submoduleSummary to true
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 6:20 PM, Stefan Beller <sbeller@google.com> wrote:
> A user complained about the workflow with submodules:
>> Re submodules pain, I've seen a lot of people get confused about
>> how and when to commit submodule changes. The main thing missing
>> in the related UIs is some way to summarize the subproject commit
>> diff in a human readable way. Maybe last log message would be better
>> than just sha?
>
> We could advise all the confused users to turn on
> status.submoduleSummary.  However there is no downside from turning
> it on by default apart from a slight change in behavior and bit
> longer output of git-status and the help in git-commit.
>

Makes sense to me.

Thanks,
Jake

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  Maybe we can merge this early after 2.13, so we have a longer time frame
>  in which people may react to this change of a default?
>
>  Thanks,
>  Stefan
>
>  Documentation/config.txt | 2 +-
>  builtin/commit.c         | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1df1965457..34d4735414 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2984,7 +2984,7 @@ This variable can be overridden with the -u|--untracked-files option
>  of linkgit:git-status[1] and linkgit:git-commit[1].
>
>  status.submoduleSummary::
> -       Defaults to false.
> +       Defaults to true.
>         If this is set to a non zero number or true (identical to -1 or an
>         unlimited number), the submodule summary will be enabled and a
>         summary of commits for modified submodules will be shown (see
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 4e288bc513..833a651013 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1388,6 +1388,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>
>         s.ignore_submodule_arg = ignore_submodule_arg;
>         s.status_format = status_format;
> +       s.submodule_summary = -1;
>         s.verbose = verbose;
>
>         wt_status_collect(&s);
> @@ -1650,6 +1651,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>         status_init_config(&s, git_commit_config);
>         status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
>         s.colopts = 0;
> +       s.submodule_summary = -1;
>
>         if (get_sha1("HEAD", oid.hash))
>                 current_head = NULL;
> --
> 2.12.2.511.g2abb8caf66
>
