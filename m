Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183FF1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 09:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfFYJS2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 05:18:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50980 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbfFYJS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 05:18:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so2038461wmf.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tbGr36w0oXvHegogjs96bxyicy9MjSnnZGsp2lTSCG4=;
        b=PCrxL8T8/F41l1VlUinAo2cN0tZKLwnriGl7kozo6cS5u+jJZyywbER/vSHAAaq7fy
         Oq8h5nqnU1kM3WFRp1BWNQKH7LS0n0LF+7FSZ1mZKBMKhHPo7GVHGUsK0hqwlsdmKHou
         esC8BC6yw6agxjfU0KN4GK0/Wg01EjiaE0pCo1UgbaPaCzP2JGovjRUqdsgFmlo/4O/9
         4a5eZ5ZIdRI4CwR7drXr6fWRs08qfjNbAHgdd6OJQ0QPePPZwwsBWFyM8TulGBTKW/ou
         draaUZgvLkX4MGMQBhlbWhWPFSM6/pam43RpZZ0R4g0yn7XqgmZayBDFqw99uIktkvB7
         wxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tbGr36w0oXvHegogjs96bxyicy9MjSnnZGsp2lTSCG4=;
        b=tHKUVoF5PKA3YjLYLsxlfH8pNwL79hyya5M8iSoIk77GyWhTUiG1MfrZfLmLVZtXgc
         vuE3T0cP3O7NhkKe2xHjvMWa+KwmHSmkRXc7WWHxgQm2Oj4xKopbSC3lmhJdPHL5zOE3
         nogBy1AHM+Q8VBTEO6C/PliZSbG9mOCKSIUYGAKQQSwBccl4u4jfyfhKQNJ+l/Wr/VeY
         5sWCbj/TgmKdEypHZeSi69FPtlklCOa2XechjPNZbADq6CxjpwdDdx8V8H6zjuCNGrst
         6ld/6nW9prjTg129xZYlVyHGyopJGRDFiWQhi0Q25MvbO/vy0zcxT3hMTQ69kjpZu75O
         UxwQ==
X-Gm-Message-State: APjAAAV3wcz+9FsQcQHRILo5ZfCOgtiW0BOJoHaHspa6my9/Y/YnKeyA
        RRm4NJc58N2HZ0E3FA3na0g=
X-Google-Smtp-Source: APXvYqxqdiNWMVNDg4/JPU+ro8RYrr4EKaz7hjLCvjO+AdnPxPWMAvs2skIQ9Obo/yIvH0+FFS7TIQ==
X-Received: by 2002:a1c:2088:: with SMTP id g130mr11306198wmg.80.1561454306587;
        Tue, 25 Jun 2019 02:18:26 -0700 (PDT)
Received: from localhost (adsl-24.176.58.195.tellas.gr. [176.58.195.24])
        by smtp.gmail.com with ESMTPSA id x129sm1655632wmg.44.2019.06.25.02.18.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 02:18:25 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:18:22 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, phillip.wood123@gmail.com,
        gitster@pobox.com, martin.agren@gmail.com
Subject: Re: [GSoC][PATCH v7 1/6] advice: add sequencerInUse config variable
Message-ID: <20190625091822.GB2423@hank.intra.tgummerer.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
 <20190623200338.17144-2-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623200338.17144-2-rohit.ashiwal265@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/24, Rohit Ashiwal wrote:
> Calls to advise() which are not guarded by advice.* config variables
> are "bad" as they do not let the user say, "I've learned this part
> of Git enough, please don't tell me what to do verbosely.". Add a
> configuration variable "sequencerInUse" which controls whether to
> display advice when any sequencer command is in progress.

It would be nice if this patch not only introduced this config
variable, but also started making use of it.  That would make it
immediately clear why this variable is useful.  Otherwise the commit
message should state that this is only useful in a future commit.

Not sure that's worth a reroll by itself though.

> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>  Documentation/config/advice.txt | 2 ++
>  advice.c                        | 2 ++
>  advice.h                        | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index ec4f6ae658..1cd9096c98 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -57,6 +57,8 @@ advice.*::
>  	resolveConflict::
>  		Advice shown by various commands when conflicts
>  		prevent the operation from being performed.
> +	sequencerInUse::
> +		Advice shown when a sequencer command is already in progress.
>  	implicitIdentity::
>  		Advice on how to set your identity configuration when
>  		your information is guessed from the system username and
> diff --git a/advice.c b/advice.c
> index ce5f374ecd..b101f0c264 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -15,6 +15,7 @@ int advice_status_u_option = 1;
>  int advice_commit_before_merge = 1;
>  int advice_reset_quiet_warning = 1;
>  int advice_resolve_conflict = 1;
> +int advice_sequencer_in_use = 1;
>  int advice_implicit_identity = 1;
>  int advice_detached_head = 1;
>  int advice_set_upstream_failure = 1;
> @@ -71,6 +72,7 @@ static struct {
>  	{ "commitBeforeMerge", &advice_commit_before_merge },
>  	{ "resetQuiet", &advice_reset_quiet_warning },
>  	{ "resolveConflict", &advice_resolve_conflict },
> +	{ "sequencerInUse", &advice_sequencer_in_use },
>  	{ "implicitIdentity", &advice_implicit_identity },
>  	{ "detachedHead", &advice_detached_head },
>  	{ "setupStreamFailure", &advice_set_upstream_failure },
> diff --git a/advice.h b/advice.h
> index e50f02cdfe..ebc838d7bc 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -15,6 +15,7 @@ extern int advice_status_u_option;
>  extern int advice_commit_before_merge;
>  extern int advice_reset_quiet_warning;
>  extern int advice_resolve_conflict;
> +extern int advice_sequencer_in_use;
>  extern int advice_implicit_identity;
>  extern int advice_detached_head;
>  extern int advice_set_upstream_failure;
> -- 
> 2.21.0
> 
