Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA641F731
	for <e@80x24.org>; Tue,  6 Aug 2019 09:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbfHFJWG (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 05:22:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39510 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfHFJWG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 05:22:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so65341093wmc.4
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7vxElpLHclCKeHNV6hxrdZxwP/JLQKR1FkUyx9Nrc1s=;
        b=s+B93cFGC46mEDkfmyqyRHLEUXjYS5sVSvBRUHuhUr2GNQG7XPqPpyyS+EQDdWD5Do
         10pWSVri0Df9n+o3pWSs7OkRtKWZRCuAW3xrSPzCiE+8iFxp4nTI3LDjTQR25y/G6o+C
         1Gd0He3FPM+xq3i+rpP0zDL4/cEcFilDrp4CFxPNLPTJnrJKGjOpUbqvyZRNAiqzNxOM
         s+Hp1558K76dDw+TjYWuWSLMH7K8wZxqQ8DVpuubDHDy3a6MW0swgDWEGk25JV+1iwFO
         P6CayUogO7HOaf4PxbV52Gh8qTCBS99WhZy4n/bF6Z4GVj9qLJVEHhJ77xCKT/6BWDDX
         4oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7vxElpLHclCKeHNV6hxrdZxwP/JLQKR1FkUyx9Nrc1s=;
        b=U+ZtDD30mXAfuMIn1mmhDtnc3bvEEEb7m0s1/ZRsfF5ER2re7+G1qgC58kqumpBsLp
         tgGtmn9B9o5TxJjl/gR0FAMtJrIWwNcQYY8CgwnMfowpJu32oW6BgPFBz1xkar7BPiGq
         Etz8gxKb3jTKMAIpadjYHXocCpEKSwzzUjH8hocsmnYnX2/QA7b/D7gKxOUHnjVmtSts
         xGeXxjKzD7trcj8SuasyJsSFLZPW85Iynx935cLMZxuok2TgUXjCccW5rYSQRjEupfpq
         vwknC/mqSp5d1wMKoSJZJG6HKg05YX7N7bApMkbD6aZCN6JOUIHms8GToxzbk4J82J2r
         L76A==
X-Gm-Message-State: APjAAAW9K2VRPREBLrfcufQGF/A2d3kYEaXt4sI9zZX3n5ZjAzE2t8Ce
        IaJQ5gLzwL6NBmwixH/9+AM=
X-Google-Smtp-Source: APXvYqwESuG5fX2iDXnD9sjua17TFSJqyOo6HhvMgBxaxa/2PutttCBl4NtA61ERC1JjRZXqqVkFmg==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr3602543wml.126.1565083323677;
        Tue, 06 Aug 2019 02:22:03 -0700 (PDT)
Received: from szeder.dev (x4dbe4c2a.dyn.telefonica.de. [77.190.76.42])
        by smtp.gmail.com with ESMTPSA id i6sm86995021wrv.47.2019.08.06.02.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 02:22:02 -0700 (PDT)
Date:   Tue, 6 Aug 2019 11:21:59 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit-graph: fix bug around octopus merges
Message-ID: <20190806092159.GE20404@szeder.dev>
References: <pull.308.git.gitgitgadget@gmail.com>
 <6e913ac2b6ddc080c7796e93f019243bbdce1dff.1565023420.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e913ac2b6ddc080c7796e93f019243bbdce1dff.1565023420.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 05, 2019 at 09:43:41AM -0700, Derrick Stolee via GitGitGadget wrote:

> In such a case, the reading
> process outputs the following message to stderr:
> 
> 	warning: commit-graph chain does not match
> 
> These warnings are output in the test suite, but ignored. By
> checking the stderr of `git commit-graph verify` to include
> the expected progress output, it will now catch this error.

There should be a better way to check this than relying on the number
of progress lines, e.g. 'git commit-graph verify' could print
something specific, like "Verified 3 commit-graph files, all OK", to
its standard output, and the test should check only that.  Or check
only that there is no warning on standard error.

On one hand, see the recent commits 077b979891 (t3404: make the
'rebase.missingCommitsCheck=ignore' test more focused, 2019-06-24) and
bb431c3dad (t3420: remove progress lines before comparing output,
2019-07-04), where we started to exclude the progress output from
verification in tests like this that are not specifically about
progress output.

On the other hand, one of my fun side-projects is to run some
semi-automated and souped-up CI builds of currently cooking topics,
which include a custom GETTEXT_POISON mode [1], where the poisoned
translated progress output in this new test looks like this [2]:

  V.e.r.i.f.y.i.n.g. .c.o.m.m.i.t.s. .i.n. .c.o.m.m.i.t. .g.r.a.p.h.: 100% (1/1),  d.o.n.e..
  V.e.r.i.f.y.i.n.g. .c.o.m.m.i.t.s. .i.n. .c.o.m.m.i.t. .g.r.a.p.h.: 100% (5/5),  d.o.n.e..
  V.e.r.i.f.y.i.n.g. .c.o.m.m.i.t.s. .i.n. .c.o.m.m.i.t. .g.r.a.p.h.:
    100% (12/12),  d.o.n.e..

So this makes the progress lines almost twice as long, and as the last
commit-graph file contains double-digit commits, the length of the
progress line just happens to exceed the width of a 80 character
terminal, and gets line wrapped.  This throws off the line count
check, as there are now 4 lines on standard error instead of the
expected 3.


[1] https://public-inbox.org/git/20181022202241.18629-1-szeder.dev@gmail.com/
[2] https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/568120252#L4120
    Note that the highlighted line is in the 'after failure' fold, and
    your browser might unhelpfully fold it up before you could take a
    good look.


> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index 03f45a1ed9..99f4ef4c19 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -319,7 +319,9 @@ test_expect_success 'add octopus merge' '
>  	git merge commits/3 commits/4 &&
>  	git branch merge/octopus &&
>  	git commit-graph write --reachable --split &&
> -	git commit-graph verify &&
> +	git commit-graph verify 2>err &&
> +	test_line_count = 3 err &&
> +	test_i18ngrep ! warning err &&
>  	test_line_count = 3 $graphdir/commit-graph-chain
>  '
>  
> -- 
> gitgitgadget
