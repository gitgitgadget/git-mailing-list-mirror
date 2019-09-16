Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3AF61F463
	for <e@80x24.org>; Mon, 16 Sep 2019 22:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfIPWgM (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 18:36:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39657 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfIPWgM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 18:36:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so1052776wrj.6
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 15:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bqWe/Aj6u284E6jwEzxZYxMcTqXtn5vESOHsV0TSrj0=;
        b=SRZSLqVtrsk/ErzCjLCgGKZUa//CNmAonLxXUNMHtPlKoPIWdv8lobqwQgqNdYNI3x
         IrB5MWdmBCytlwBn9Sy5+zTmm4yR2pCjjxYu7oeoszHWJqOIsR1S/PtE7V1dli0bluuz
         fj+Usto47BQa/Y1CzZkDUMC2yxwqyGsvoKp0gUldSJcd+1lI+BZKIZaO1FPOADWXWUsX
         /4UBQUs1+gJk1DLDqrsIqViNjJnEmGmRoYYrBc614FLhblQVCXRGeMhJiahTRY0pQfMf
         PCck4hWQxBs9h3VrQvJUFjTfT9PHZhSj9IWulcZfsPVchdQB4TSel5mhtiDdWjYMs8L+
         FlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bqWe/Aj6u284E6jwEzxZYxMcTqXtn5vESOHsV0TSrj0=;
        b=aoWsEmc/2XHyGvNpQdfDWc4f+LkQLM16EpbXWD9tAscKFGauJRTwaPAG7yqR1XwqVX
         ZoxPv7KAGp3JryfvmuxJKIwjynyn5G9j6t2OpY4lbj9ii1KF0lNwJ1z5XYYYVR/9MpV5
         3BwDNNfoaDQMhsBVnS0YimrO3lU9A+QUW7sZgWMsRACkZrzL4TcveDVwz7780im3J6bG
         cuGvk+QZnpMxr7Jq0DdjqeqlzkJb5zMtiUAh3UiGcGmYaWUWTjceRLYF/f32FFIn2x5o
         SvdbaiKzwRhQ+bnGSmkP110gL+QLkC6wASnwrAheGtn5M7uvA6Nzg+h/sS9FCGmzk5lr
         5gvw==
X-Gm-Message-State: APjAAAVfmQ7sVU8VEnVkNitRugE905mbwAaxPrrTJjxl+SgyEnRdwSMw
        T9UpH0v1wKJ15PDsb9jf4pE=
X-Google-Smtp-Source: APXvYqw9LQFnb3fc50S64nQ6rcHyd261bCyDTBsx0yZVPlsmPjAkjGJNxZRRN6IZd16kuBItxy5RAQ==
X-Received: by 2002:a5d:6049:: with SMTP id j9mr402903wrt.213.1568673370265;
        Mon, 16 Sep 2019 15:36:10 -0700 (PDT)
Received: from szeder.dev (x4db93de7.dyn.telefonica.de. [77.185.61.231])
        by smtp.gmail.com with ESMTPSA id z9sm246628wrp.26.2019.09.16.15.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 15:36:09 -0700 (PDT)
Date:   Tue, 17 Sep 2019 00:36:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/1] commit-graph: add --[no-]progress to write and
 verify.
Message-ID: <20190916223607.GE6190@szeder.dev>
References: <pull.315.git.gitgitgadget@gmail.com>
 <pull.315.v2.git.gitgitgadget@gmail.com>
 <47cc99bd151db67fe2ee0f91bb98b3eb7e55786d.1566836997.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47cc99bd151db67fe2ee0f91bb98b3eb7e55786d.1566836997.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 09:29:58AM -0700, Garima Singh via GitGitGadget wrote:
> From: Garima Singh <garima.singh@microsoft.com>
> 
> Add --[no-]progress to git commit-graph write and verify.
> The progress feature was introduced in 7b0f229
> ("commit-graph write: add progress output", 2018-09-17) but
> the ability to opt-out was overlooked.

> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index 99f4ef4c19..4fc3fda9d6 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -319,7 +319,7 @@ test_expect_success 'add octopus merge' '
>  	git merge commits/3 commits/4 &&
>  	git branch merge/octopus &&
>  	git commit-graph write --reachable --split &&
> -	git commit-graph verify 2>err &&
> +	git commit-graph verify --progress 2>err &&

Why is it necessary to use '--progress' here?  It should not be
necessary, because the commit message doesn't mention that it changed
the default behavior of 'git commit-graph verify'...

>  	test_line_count = 3 err &&

Having said that, this test should not check the number of progress
lines in the first place; see the recent discussion:

https://public-inbox.org/git/ec14865f-98cb-5e1a-b580-8b6fddaa6217@gmail.com/

>  	test_i18ngrep ! warning err &&
>  	test_line_count = 3 $graphdir/commit-graph-chain
> -- 
> gitgitgadget
