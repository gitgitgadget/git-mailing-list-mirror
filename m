Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4554F1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 13:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeJHUzK (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 16:55:10 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33088 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJHUzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 16:55:09 -0400
Received: by mail-wr1-f42.google.com with SMTP id e4-v6so20935622wrs.0
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=O+qXu0LpaL8XTzm8PV+5pJ92ApJTND/0YLEhoRqjDfA=;
        b=a1mwlArhDG1RFpCiNJ9ZioRsMPi6iVmqOqtDf+ZtMsKVC8JrfTW4mlqqeq6CSgDjLd
         1BSizQTh/juL8xvJHW5fahdbKDM5UHNQgJQrJlwE+v/8G3wMfdUXcwXtFyZ7T/NwY9HW
         9tiNZ9DKJufph2ULNItcw6XXQ3fnFDVTt+g7PIGgcvkeZuFVPLCDOohL+XDf81S+gvSc
         GKP43t5oJdsGVYcVOQR6KTeVll3eAfiJ/4/njuMLQTaaVKkrp1IlIl6A7i8ip0eE6usv
         n6FI81LnhnTek0muNW9DcrEgRIKKoXNjos5+AeM6F5Owc5ucFOtgR72z3zOL1OZbCjGE
         0uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=O+qXu0LpaL8XTzm8PV+5pJ92ApJTND/0YLEhoRqjDfA=;
        b=bkbpPrfXv4khq17X7mXQG+2ywYmpJ30R5xKI33NkghZKbENLYBR9jazlHy1EYiQE+q
         tyoKJuxci0DDr+wEK5UNyVWqcqrqfnGPbISspLZ2xzDPqMAU2UU5RBuLKtq4Uri8nmS5
         R01M7IrKC8yiE4LOmY3QkB1s7gbLeSYiNG2xksF1Zn2VnRz/98CwjjE+iCW7xQNbtCnc
         Q32H3rYDf6UlFxG7GAM4l/4UCdlSWQovlSelROQNkZ9bR5dRCJh7iRuBNaWb6Hb+VtPE
         63QtLzcQiE00LifKdSXzU5sOT50zKogZ/Mut3mv/Fjuniv74/qXa9KZvIaZ2pbx0dZXU
         IpQQ==
X-Gm-Message-State: ABuFfohA3ou4rwP7X+FIfqxXh8koX1TW/5TwW8rw8yS+WKsjAs6rsbgg
        CVe0q9QtbVJ39z+oe3SjNjk=
X-Google-Smtp-Source: ACcGV62csNaZAW8cGR5uEGZ0VUnB2JkgKNYCNhHlB8McT416aCn3uv7+LFAQWgBvdUOQsxm9nGkT5Q==
X-Received: by 2002:a5d:480b:: with SMTP id l11-v6mr10619494wrq.28.1539006200632;
        Mon, 08 Oct 2018 06:43:20 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id o126-v6sm9610027wmo.3.2018.10.08.06.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 06:43:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit-graph: define GIT_TEST_COMMIT_GRAPH
References: <pull.26.git.gitgitgadget@gmail.com> <85d02ac8d8c9a8950ce1a9760a541ff506945de0.1535488400.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <85d02ac8d8c9a8950ce1a9760a541ff506945de0.1535488400.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Oct 2018 15:43:18 +0200
Message-ID: <87bm84a70p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 28 2018, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The commit-graph feature is tested in isolation by
> t5318-commit-graph.sh and t6600-test-reach.sh, but there are many
> more interesting scenarios involving commit walks. Many of these
> scenarios are covered by the existing test suite, but we need to
> maintain coverage when the optional commit-graph structure is not
> present.
>
> To allow running the full test suite with the commit-graph present,
> add a new test environment variable, GIT_TEST_COMMIT_GRAPH. Similar
> to GIT_TEST_SPLIT_INDEX, this variable makes every Git command try
> to load the commit-graph when parsing commits, and writes the
> commit-graph file after every 'git commit' command.
>
> There are a few tests that rely on commits not existing in
> pack-files to trigger important events, so manually set
> GIT_TEST_COMMIT_GRAPH to false for the necessary commands.
>
> There is one test in t6024-recursive-merge.sh that relies on the
> merge-base algorithm picking one of two ambiguous merge-bases, and
> the commit-graph feature changes which merge-base is picked.
>

The test feature itself seems fine, but this consistently fails ever
since it got introduced (a reset --hard on the commit merged to msater
in git.git):

    GIT_TEST_COMMIT_GRAPH=true prove -j$(parallel --number-of-cores) t5500-fetch-pack.sh t6001-rev-list-graft.sh t6050-replace.sh
    Test Summary Report
    -------------------
    t6001-rev-list-graft.sh (Wstat: 256 Tests: 14 Failed: 6)
      Failed tests:  3, 5, 7, 9, 11, 13
      Non-zero exit status: 1
    t6050-replace.sh       (Wstat: 256 Tests: 35 Failed: 9)
      Failed tests:  12-16, 24-25, 30, 35
      Non-zero exit status: 1
    t5500-fetch-pack.sh    (Wstat: 256 Tests: 357 Failed: 1)
      Failed test:  351
      Non-zero exit status: 1

This is on Linux/Debian 4.17.0-1-amd64. Can you reproduce this? If not I
can provide more info (-x output etc..).
