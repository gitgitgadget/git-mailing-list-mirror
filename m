Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0F21F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfJ2Umi (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:42:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46244 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2Umi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:42:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id b25so10453290pfi.13
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EBqOaRS+2L/FY10HUQHOrMyeReSaMg/IF5cOVzIZbcY=;
        b=ZFD+jd7r45DcmnUyzvKi1Jx3K9wpRxs0DTvd2oMSL+dgTmYZpWkgopMkM0YZnLcjkN
         G8AyrJeNaudWRmeGtaeni+gcjJbV5M1EZx3p27yYDJeRfJgEN2f74jCnXYmKtO8NLLq+
         erBNGtMza/rkO4zeJ5UsqSkkXALmE7rzNgIsk2GPheYCeYhzrSHapzaUeEuqmglrRWzH
         Ax7+CCihu7Oztw5EmMjSPhPZWm6p30sCZePgzgN7rGuOFWLGr7ukBhrCcsueq6pKGuii
         IMFV5m6UX4WPVg1X39kAOGMkALE5Uii0MlFsoxBb4vrMIwtLFEF5OpQP7pKgqkta1O5V
         cGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EBqOaRS+2L/FY10HUQHOrMyeReSaMg/IF5cOVzIZbcY=;
        b=oX1DVJUqK4XmV4L4coPtUC+mxB/ZVaGrWDXNTbyQAEHGhvXBBR8pQMtgO+s4fGJjRi
         FaMeOwdBfkXdBTiqixRtMfvcBxd9WjqbZURFN8Md4bQIrqL2JoHxcfUVThW3T5N2WFdk
         72SwksybqO90AXxf/NFI/BtpudRE0FByjXCfIVVu3oGKAzFWStiZtFavYhzvz6eNvWBS
         01fPddHsY8Ll4tfh8ab+h9lpTHFvfewcKWP45z3xyW1bRw0lb9olOiVVjb60wgNaDev+
         W8Cc7fJR6aytn+M7Af7IUT5/rWhvPHpFSJDr1eFyj6mZ48JgMCn+RtqwBTmTFa/C2UO3
         QNFg==
X-Gm-Message-State: APjAAAVWijhKkjGfNhmzeiWFg07gmFDI8wQB/AcTQCfVhWzIjD+GDa96
        B3M/Zg1iTWG8rNDaJgqqUtxMOA==
X-Google-Smtp-Source: APXvYqykeI2h9LP3DpNzEoHg15nXGZAwShqnv0gb+pUTFsVtEe4ZcRk5eJG402QYpg54V1RFTo34Lg==
X-Received: by 2002:a63:d415:: with SMTP id a21mr28434622pgh.299.1572381756539;
        Tue, 29 Oct 2019 13:42:36 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id e7sm97163pgr.25.2019.10.29.13.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:42:33 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:42:28 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     george espinoza via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, George Espinoza <gespinoz2019@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] [Outreachy] merge-ours: include parse-options
Message-ID: <20191029204228.GA229589@google.com>
References: <pull.425.git.1572306149.gitgitgadget@gmail.com>
 <8c088194f604eac3a6b00c48a7fddfdf807571fc.1572306149.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c088194f604eac3a6b00c48a7fddfdf807571fc.1572306149.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 11:42:29PM +0000, george espinoza via GitGitGadget wrote:
> From: george espinoza <gespinoz2019@gmail.com>
> 
> Teach this command which currently handles its own argv to use
> parse-options instead because parse-options helps make sure we handle
> user input like -h in a standardized way across the project.
> Also deleted the NO_PARSEOPT flag from git.c to coincide with
> the conversion of the structure in this command since merge-ours
> now uses parse-options and needed to update git.c accordingly.

Hmm, I could still wish for some rephrasing on this commit message. Now
that you took my example suggestions and pasted them directly into your
previous sentences, it doesn't flow very nicely. The point comes across
but it's a little redundant (for example, "also <verb> from git.c ....
and needed to update git.c" is redundant).

When significant assistance and advice is received it's often good form
to include a "Helped-by:" line which looks similar to the signoff line,
to provide credit. Maybe you will consider it as myself and dscho spent
quite some time helping you in the GitGitGadget PR as well as via
IRC/mail? :)

Otherwise, the code looks OK to me.

 - Emily

> 
> Signed-off-by: george espinoza <gespinoz2019@gmail.com>
> ---
>  builtin/merge-ours.c | 14 ++++++++++----
>  git.c                |  2 +-
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
> index 4594507420..fb3674a384 100644
> --- a/builtin/merge-ours.c
> +++ b/builtin/merge-ours.c
> @@ -11,14 +11,20 @@
>  #include "git-compat-util.h"
>  #include "builtin.h"
>  #include "diff.h"
> +#include "parse-options.h"
>  
> -static const char builtin_merge_ours_usage[] =
> -	"git merge-ours <base>... -- HEAD <remote>...";
> +static const char * const merge_ours_usage[] = {
> +	N_("git merge-ours [<base>...] -- <head> <merge-head>..."),
> +	NULL,
> +};
>  
>  int cmd_merge_ours(int argc, const char **argv, const char *prefix)
>  {
> -	if (argc == 2 && !strcmp(argv[1], "-h"))
> -		usage(builtin_merge_ours_usage);
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, merge_ours_usage, 0);
>  
>  	/*
>  	 * The contents of the current index becomes the tree we
> diff --git a/git.c b/git.c
> index ce6ab0ece2..6aee0e9477 100644
> --- a/git.c
> +++ b/git.c
> @@ -527,7 +527,7 @@ static struct cmd_struct commands[] = {
>  	{ "merge-base", cmd_merge_base, RUN_SETUP },
>  	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
>  	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
> -	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
> +	{ "merge-ours", cmd_merge_ours, RUN_SETUP },
>  	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>  	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>  	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
> -- 
> gitgitgadget
