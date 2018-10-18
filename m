Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5B361F453
	for <e@80x24.org>; Thu, 18 Oct 2018 03:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeJRLqE (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 07:46:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36061 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeJRLqE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 07:46:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so4189233wmf.1
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 20:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HH/ExK/89MUK/rQUPLQwhlqjsmiZrchZILef8zgfbOI=;
        b=bex+9W+AG9GI0eyIAqVWsGkMNVIuUO42dl1Z5UeZaD/Rpsf+WLHHLiqKqjcshbwLZM
         J/XOkIkh+vmpaq08MS3TTQ2OHmvPoEhokqcCwBG9lWw3SOEsvvO4hRnOuT7tOOElTc8Y
         sXe/B7AFuKJt/q5uM3gywJekeZ/vnAOa+Pk1aMhCa8D0A+dSglGf/574N7Yg1AqTUgo4
         GBaBKnJOhPGQYDClRRWiNBINP3LbKnW0Al3xacGV+c1oF8A3imd23wOrP+z4bXfc/CJA
         0tfLV1K+NF0rilo08yoKdweXwMKCPgpxu2dH/mOHPfoZjItVP5bsHnb/SiRkawWjT279
         Wj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HH/ExK/89MUK/rQUPLQwhlqjsmiZrchZILef8zgfbOI=;
        b=YunGhZwZCp8BFlpGmThk7/UwGa0QS8oeIiNC9RuFEhmOw/EYH5o3jFd5IyYSi0Q4Z6
         Hp5myE+/u+8mozofu68BfRDyqpHkgHuHSKIyEjttK+9bVdNnRLq3rQBNQBs9UIyu5zAf
         Jexd729KVs8ldHL/+OPyj+tnWXumPmAbQyBbX3r4mFqzdQvN+76kwMWu4hhY4EAMElkK
         M80IVbC9AgIAhZBRikconx2mS644GG0tX4X5OpzbI3XtUPLK5RDSJfmWA3e2Q9p6T46d
         a88+EZsv/dtdyOUcQAnmGk7Q6fdJTWTeOSzRxjXDrfXrBX1bLpycn1mZMkGVb7p1TPuU
         7Znw==
X-Gm-Message-State: ABuFfoi4KW0kWZAzf72B5e7XYtf41BFt2UNQhStz+ss4CbJoZ6ccj7z8
        dcM66pTbjqSUWJiAb1T19zc=
X-Google-Smtp-Source: ACcGV62OHPc/mRlMdCbXh5wMYEIV+KkUR3p3BOTQgXQant3u85aNUc/rbYVVFqI/j2zB3xAKLyMzyQ==
X-Received: by 2002:a1c:710:: with SMTP id 16-v6mr5513965wmh.22.1539834429856;
        Wed, 17 Oct 2018 20:47:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c13-v6sm16956881wrm.50.2018.10.17.20.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 20:47:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] Use commit-graph by default
References: <pull.50.git.gitgitgadget@gmail.com>
Date:   Thu, 18 Oct 2018 12:47:08 +0900
In-Reply-To: <pull.50.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Wed, 17 Oct 2018 13:33:10 -0700 (PDT)")
Message-ID: <xmqqlg6vvrur.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The commit-graph feature is starting to stabilize. Based on what is in
> master right now, we have:
>
> Git 2.18:
>
>  * Ability to write commit-graph (requires user interaction).
>    
>    
>  * Commit parsing is faster when commit-graph exists.
>    
>    
>  * Must have core.commitGraph true to use.
>    
>    
>
> Git 2.19:
>
>  * Ability to write commit-graph on GC with gc.writeCommitGraph.
>    
>    
>  * Generation numbers written in commit-graph
>    
>    
>  * A few reachability algorithms make use of generation numbers.
>    
>    
>
> (queued for) master:
>
>  * The test suite passes with GIT_TEST_COMMIT_GRAPH=1
>    
>    
>  * 'git commit-graph write' has progress indicators.
>    
>    
>  * The commit-graph is automatically disabled when grafts or replace-objects
>    exist.

If I recall correctly, one more task that was discussed but hasn't
been addressed well is how the generation and incremental update of
it should integrate with the normal repository maintenance workflow
(perhaps "gc --auto").  If we are going to turn it on by default, it
would be good to see if we can avoid multiple independent walks done
over the same history graph by repack, prune and now commit-graph,
before such a change happens.

Thanks.



