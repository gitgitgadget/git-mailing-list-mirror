Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183C61F597
	for <e@80x24.org>; Wed, 25 Jul 2018 18:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbeGYTVN (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 15:21:13 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:43754 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbeGYTVM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 15:21:12 -0400
Received: by mail-wr1-f44.google.com with SMTP id b15-v6so8236004wrv.10
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1b18RDRJ7RND8egneEYQcbdh93qFbPfuiB8OitI+/vY=;
        b=cqv4u9J7umFyqiNFkAMeZaX7sXxKrudHepzoYLknan4rRBeRc7aOsDZBdyWzpUvCU3
         K7SEUTBgr2skfpz/J4cAfBFSFWTejEWsqTc4w4Xr8koozbdl8a9O8mlEH2ByuGIoqkHD
         EaiQpL8N/FoVAGfowEhF7phWDhWzLcS/eZ+YKPLi8eyf+fJLMfW5IGUVC+o4wJFQGEX2
         OdRYmon8Cq55A52gx0oVQ2Og7YND1G9nvyrX6iK6LvdAzM6/iTKiJHzwj4Vrwxv+dKZQ
         tF3fMlSuSgOO9Bh4nCYZompkk7HGG2bpodAcJW4cR8U0N4dN9E0ogEE16UEF4/r/7Y9W
         mcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1b18RDRJ7RND8egneEYQcbdh93qFbPfuiB8OitI+/vY=;
        b=p37/qE4+0d6S0X7J5ITuO6A7v/qGWKw84xxc5hzrGTR9dRzlrISxJ4nuHhmBAclSkV
         7n+4Ngxsg8ndS9m6q90RexTMvZfuD94tO/VPFYIT+z+/bVMhEZYpzj+V53z9hOeL1y9s
         hrMKNbBvXfsN1ur1yJgJ3HuUrSfXXzRQFsza7Vdduqq0o3RKn6fy81ICsRdfs5TsVyNI
         5ipCDzXnn12vhGtnIwCcXzYhp2l5U7iXuua+I7Z94eUr6TYt3QrvlPZXAIr7HhOx3v97
         6fd5i4sQhnN1q5yu/WlsOWqVp6j7mKcVit2/P3+ekpK1k1hHD8jSBheTY4XEwpmaGc8x
         2YKg==
X-Gm-Message-State: AOUpUlFuq1+qyGVF2kbetQap5Mi7cMyTvNrRXP6Aa196uIuEQNaYKqV9
        yyI3COwbEM4sgQwnfCAjQMM=
X-Google-Smtp-Source: AAOMgpc8K0RB3LgxekELRvNPqcmzqzfhmQnSRN2FgvNS1xinXFTsz2EcQc9tygprhStD3/82SJ4+7A==
X-Received: by 2002:adf:b243:: with SMTP id y3-v6mr16128953wra.90.1532542104153;
        Wed, 25 Jul 2018 11:08:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b198-v6sm6163623wme.11.2018.07.25.11.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 11:08:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     dstolee@microsoft.com, git@vger.kernel.org, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v2 15/18] test-reach: test commit_contains
References: <20180720163227.105950-16-dstolee@microsoft.com>
        <20180723203500.231932-1-jonathantanmy@google.com>
Date:   Wed, 25 Jul 2018 11:08:21 -0700
In-Reply-To: <20180723203500.231932-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 23 Jul 2018 13:35:00 -0700")
Message-ID: <xmqqr2jrur1m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> +	} else if (!strcmp(av[1], "commit_contains")) {
>> +		struct ref_filter filter;
>> +		struct contains_cache cache;
>> +		init_contains_cache(&cache);
>> +
>> +		if (ac > 2 && !strcmp(av[2], "--tag"))
>> +			filter.with_commit_tag_algo = 1;
>> +		else
>> +			filter.with_commit_tag_algo = 0;
>> +
>> +		printf("%s(_,A,X,_):%d\n", av[1], commit_contains(&filter, A, X, &cache));
>
> Should we initialize filter (with {NULL} or some equivalent)?

Sounds like a sensible suggestion.  Wouldn't we segfault otherwise
depending on what garbage bytes are on the stack?
