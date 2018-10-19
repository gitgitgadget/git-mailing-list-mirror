Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81EF71F453
	for <e@80x24.org>; Fri, 19 Oct 2018 00:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeJSIka (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 04:40:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40917 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeJSIka (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 04:40:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so35582001wro.7
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 17:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=kzFtXPM/2gYjwKEoft6XvimixOorVhLk20tvlJQ+64g=;
        b=bGfXHr8aSmTMMwBsg9vIYqdIjB5A5GllhTR0kukVNceoNT/gr8NAMRpX6C+7MPefUR
         klX7LvylG/aWvf2YpKSkx3mxQbjKHq2xTYcZI3XYpeL810KNYkTgzI4SVldLP6dBn3KO
         UkIDD3kkpQ1Cpg7pIPmYYdkbl3SARv2f2u/j0QI2Z5blsNGuQBUL4YJKzpwI67bL2WQv
         1+g+OzbftMl88cm0yKKrGYtWEPcpGVPnWcY2pTSL4SH+gtzZIp0yycQ/WmmLrp14sbTF
         lajnKoY2uFFcMEmGJ13ISQm1U/jMKM5K5kvTKH7xl2LAcbNVTRo2/eJbqN56SAiGDmR4
         Ztkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=kzFtXPM/2gYjwKEoft6XvimixOorVhLk20tvlJQ+64g=;
        b=mkJmUrrXXO2GYwjBg4rr6PLkErkcfjRwoKe2jeYQ6jYfAOd2fKSyzmv1tUD3LVS5FK
         2VlATFoVvCxBNq8J8eAEgdAu+NWHH87PWJhhth2P1hdK5MMWNjbQwuetd0FaoMG3NXwH
         zTt6jD1LOfMXzG7zV15xr8Rhak0o989yGy1YrXYQfMM+fQOuJkefFcqBvGDk733JOv/t
         TIwezWvtB8tR7tBOG1erb2mGtwBDJykw85wWgGg07yUpwo7D9i1Rs3nmUc7I0DsHsIv/
         +jJmYUWaI82fjyJkGg9gpYAQsqIdfzzNgQwUX6UQ+oV0MmEveGWaqWKOwLsndJCrkgdQ
         QOHQ==
X-Gm-Message-State: ABuFfoiAMQyum++wjfbflBQVyu9OXmxNO9ZL6h9uG9Se66uayaZhHmGC
        dh+SziNJ36v9GUnet7Vzj7o=
X-Google-Smtp-Source: ACcGV60LVS91uhkWz2jOjUgIMVjSFqGevLmdo7l3kzd4XL+ZxSXXhvY1mcEEZ/4HOaX34fqFW7j8tQ==
X-Received: by 2002:adf:e808:: with SMTP id o8-v6mr29819920wrm.269.1539909413002;
        Thu, 18 Oct 2018 17:36:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c64-v6sm1328157wma.44.2018.10.18.17.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 17:36:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] t6501: use --quiet when testing gc stderr
References: <pull.50.git.gitgitgadget@gmail.com>
        <ab118e60e9988076edf43d0ed8c1924e6569a9d0.1539808389.git.gitgitgadget@gmail.com>
        <xmqq1s8nvndm.fsf@gitster-ct.c.googlers.com>
        <90d051a5-8c02-518d-01a7-16746061e6b9@gmail.com>
Date:   Fri, 19 Oct 2018 09:36:51 +0900
In-Reply-To: <90d051a5-8c02-518d-01a7-16746061e6b9@gmail.com> (Derrick
        Stolee's message of "Thu, 18 Oct 2018 08:59:32 -0400")
Message-ID: <xmqqk1me4vrw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> This code from builtin/gc.c makes it look like we are doing that:
>
>         if (gc_write_commit_graph)
>                 write_commit_graph_reachable(get_object_directory(), 0,
>                                              !quiet && !daemonized);
>
> But really, daemonized is only for when running in the background.

But that is something we can easily fix, no?

"git grep isatty" tells you that we use isatty(2) to decide if we
want to go verbose or show progress.  Another frequent use of isatty
in our codebase of course is to use of a pager and columnar output
formats.
