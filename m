Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 512CD1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 17:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeI0ANh (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:13:37 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:36964 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeI0ANh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:13:37 -0400
Received: by mail-wm1-f48.google.com with SMTP id y26-v6so2720451wma.2
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PbCVLw6K0ZJtSU+wYl6SphJiaK+idV21T5t8ZiGs9fs=;
        b=eIt5hAxkclo4ws2o3GdNhun1WB0MTEFuOSQKK/mFvmVFoaRQEkqynHgxFqlQ1yGKkg
         5PqKOjjzVqS59Rr3iJp/A7S8fGJdyz0fdht1aQaAYNXlOM2lUe9goXljfrTwC7IOaYql
         FIobi4P2uDXQanK37OWy3hlARu0ENsvTafL5+EIkWK+GtAAdfOz5eB/4+Fuyj5HCT56B
         jmSIhsGN1RHjF2rdtZzgNgJa+FLc5/pqTtl5i2ubXK4UkEVTsRIyJY4xYL02l9EQnXNl
         xTGOaTCabZr/vFxAWSGmhTMP7K4gb/xw6mQK+XOEKuBLIp8kzTDieLuDONCvWUViqz6V
         r4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PbCVLw6K0ZJtSU+wYl6SphJiaK+idV21T5t8ZiGs9fs=;
        b=B5fPmNKtnY0mwOfdjulvPPMPnSygs0gSnV2TBO7ImhudxEleY2ygdC6Fm37fmcLUv7
         XWnLq3c6h/rrh1xGqWKSqJ/lXVCHc9NOvTotmiIdBbrkQxnJZ3FRPH8DGG6iuWbmMYC0
         UJ8YZ+7ST6YAGM+LWUmDHrUf/XCcUwFm5EtN6/fDyJVNPBDghrn9aJmnPCmqon1djyRP
         T+QXiqyjy2QqSYnhICYdVoa4w297v0wzY+A3xnZVOM6rOIHft1KwBN+zFeSevFX+ZgVG
         +CXqaCvlmpnpp4VCQhKF2ZRsdJsHp5DmlxcuTOoqJW0aHzKuhHfvbtg5aJ3xzpwTvscI
         GByw==
X-Gm-Message-State: ABuFfojfwkMf8HWNqcZVLfQJgPLGXJSITV92pttLaYPYeW9bSB6iClKP
        NjUH2AOqts7Pqt27r4MLnm4=
X-Google-Smtp-Source: ACcGV60OqWzgK1evvTpyN0/sN9ivjttdpl8ciRit0RNDZaHZLZL6gzxo2lWE8s8n7E6i7IQM1IpnyQ==
X-Received: by 2002:a1c:e4c6:: with SMTP id b189-v6mr5263537wmh.114.1537984768305;
        Wed, 26 Sep 2018 10:59:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e141-v6sm36109wmd.32.2018.09.26.10.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 10:59:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
Date:   Wed, 26 Sep 2018 10:59:27 -0700
In-Reply-To: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com> (Derrick
        Stolee's message of "Tue, 25 Sep 2018 14:42:24 -0400")
Message-ID: <xmqqtvmckum8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> In an effort to ensure new code is reasonably covered by the test
> suite, we now have contrib/coverage-diff.sh to combine the gcov output
> from 'make coverage-test ; make coverage-report' with the output from
> 'git diff A B' to discover _new_ lines of code that are not covered.
>
> This report takes the output of these results after running on four
> branches:
>
>         pu: 80e728fa913dc3a1165b6dec9a7afa6052a86325
>
>        jch: 0c10634844314ab89666ed0a1c7d36dde7ac9689
>
>       next: 76f2f5c1e34c4dbef1029e2984c2892894c444ce
>
>     master: fe8321ec057f9231c26c29b364721568e58040f7
>
> master@{1}: 2d3b1c576c85b7f5db1f418907af00ab88e0c303
>
> I ran the test suite on each of these branches on an Ubuntu Linux VM,
> and I'm missing some dependencies (like apache, svn, and perforce) so
> not all tests are run.

Thanks.

> master@{1}..master:
>
> builtin/remote.c
> 5025425dfff     (   Shulhan     2018-09-13 20:18:33 +0700
> 864)            return error(_("No such remote: '%s'"), name);
> commit-reach.c
> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
> 559)                    continue;
> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
> 569)                    from->objects[i].item->flags |= assign_flag;
> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
> 570)                    continue;
> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
> 576)                    result = 0;
> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
> 577)                    goto cleanup;
> cat: compat#mingw.c.gcov: No such file or directory
> ll-merge.c
> d64324cb60e     (Torsten Bögershausen   2018-09-12 21:32:02
> +0200       379)                    marker_size =
> DEFAULT_CONFLICT_MARKER_SIZE;
> remote-curl.c
> c3b9bc94b9b     (Elijah Newren  2018-09-05 10:03:07 -0700
> 181)            options.filter = xstrdup(value);

As I think the data presented here is very valuable, let me ignore
the findings of this specific run (which will be fixed by individual
authors as/if necessary), and focus on the way the data is presented
(which will affect the ease of consumption by authors of future
commits).

These wrapped blame output lines are harder to view.  Can we have
this in plain/text without format=flowed at least?  

I personally do not mind a monospaced and non-wrapping website, just
I do not mind visiting travis-ci.org for recent results from time to
time.  Others may differ.

There is an error message from "cat" in it, by the way.

> preload-index.c
> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
> +0200       73)                     struct progress_data *pd =
> p->progress;
> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
> +0200       75) pthread_mutex_lock(&pd->mutex);
> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
> +0200       76)                     pd->n += last_nr - nr;
> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
> +0200       77) display_progress(pd->progress, pd->n);
> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
> +0200       78) pthread_mutex_unlock(&pd->mutex);
> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
> +0200       79)                     last_nr = nr;

I wonder how much we can save the effort that is needed to scan the
output if we somehow coalesce these consecutive lines that are
attributed to the same commit.

In any case, thanks for doing this.
