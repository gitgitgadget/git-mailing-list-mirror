Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670921F404
	for <e@80x24.org>; Tue, 17 Apr 2018 00:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbeDQAWA (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 20:22:00 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44069 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbeDQAV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 20:21:59 -0400
Received: by mail-qt0-f196.google.com with SMTP id j26so17357642qtl.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 17:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IHbuLpNJ4GKXh+UKNTjvYokuno79TNN7NtAzsz3J1C0=;
        b=tVwNzWcrLHZNly8bGyNZuQj37qIqfHLl6E0+FW0j806uyeFZDeHX7D9wta9iQh26D2
         /iQJaauI9elxIXTk39fH3vpp7ISZpFnW2KtPoEzShXMvUHt2mFcu7S+/JyREMJYc9Mw2
         3yrUsj2hDq0hYXREl/26nn6R0bhBmVbMf5JSoJ98lZFWsdHgEXeACG6m7Oo9xpPgc+dY
         ZsojHHCSxM52cU/2do5qcbMAyltHzBgbW2Uyud/UhMjkU4TnHVpODk3ZkWXoH1TsHU4e
         DJvU05AwhizTrKmJF5BYOubHl6Y5Cyh0SAn46sdeLnF3RPDykxHm82dG7WmqXm197vsO
         oOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IHbuLpNJ4GKXh+UKNTjvYokuno79TNN7NtAzsz3J1C0=;
        b=MvCQS2Sud29ML0Fkm7y4VI4qIwn7rR0tDYpMcJJKQcgUKzgw9Cf2DViCeccxyxcNkm
         23qV2jzqclWRATvXuSbZVYNogexwxYdr/0fouWdpBps6FE72KFqoGZVFLNH58yd0MOjq
         w+OclfOvM0A2i3knNbzY0NG6Ud7ZC9zrOZbORsrpmvV23t8lihCJOP44Pnp6ZNoki/5T
         Vs+PxVYgM30WLRDBeELFnLWGqAvlla7Y3lGRKr7OXtjIHiHEIzMEl/POVAKu8/R4g+rY
         Lr2EbcgV0LBuvGdOpgu4B38S4ztzFqsuW2dvWHjK1hfXk2TpcAdicMaYeFnPZ5FsVUBz
         8Fow==
X-Gm-Message-State: ALQs6tCDtwBIb3JQPGmYm1K/hghzD8pGqnIsij7DKmiRfMRZ997ysfqK
        VUeEb6E8kmLanhnFGCbeOAsGpRCDNy9Y2WNtF60=
X-Google-Smtp-Source: AIpwx4+Zcs/XtJk5MU4DThQVOtiDnb9TeZXL48iKdXRiXt5FfzWevyv8fAPOxjdbq0l7UCugwdsu4X5HcgyKcy5BVIc=
X-Received: by 10.237.49.195 with SMTP id 61mr18097336qth.77.1523924518952;
 Mon, 16 Apr 2018 17:21:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 16 Apr 2018 17:21:58 -0700 (PDT)
In-Reply-To: <20180416221654.49454-1-sbeller@google.com>
References: <20180416221654.49454-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Apr 2018 20:21:58 -0400
X-Google-Sender-Auth: R6McGnFBaGpcI1TEA-a3iSVbHnA
Message-ID: <CAPig+cSHmxtsz2NNAFvbqXRFKE87ZVyUYpRigjgXE5p8LcR09A@mail.gmail.com>
Subject: Re: [PATCH] worktree: accept -f as short for --force for removal
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 6:16 PM, Stefan Beller <sbeller@google.com> wrote:
> The force flag is very common in many commands and is commonly
> abbreviated with '-f', so add that to worktree removal, too
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -783,7 +783,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
>  {
>         int force = 0;
>         struct option options[] = {
> -               OPT_BOOL(0, "force", &force,
> +               OPT_BOOL('f', "force", &force,
>                          N_("force removing even if the worktree is dirty")),

Should this be using OPT__FORCE, rather than OPT_BOOL, to be
consistent with worktree.c:add()?

Also, can you amend the commit message to mention that "git worktree
remove -f" was already documented, and that it was only the
implementation which was lacking? Thanks.

>                 OPT_END()
>         };
