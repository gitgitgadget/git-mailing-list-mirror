Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005351F453
	for <e@80x24.org>; Thu, 24 Jan 2019 09:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfAXJkN (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 04:40:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36297 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfAXJkN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 04:40:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so5706306wrp.3
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 01:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=qnhyVJrru7zMiI7n/yEqjdN4SsJ+YMPRkUhaaT7kPkQ=;
        b=OWkryx8mdgnqpXCHPZ1vDNL0UKLVE4T/re11wU4P1F8aC8KxO7j+JjRo5snaQZGGvT
         NXGkFPkzufNwzIc9yfsBaQanmYZr9OrKVCcLtzKnAI13fK3I7StfQI+kbJkTvwdIbWhk
         3/il2OSEE3EylMANFzL12Pq4rvk7yo2b2iDrL1wSKsE7S5Nq6BzZ9fFa037DgThkXvxs
         UB8RacnldUH26UuF76IDh2ag+SxS1+4epEk0o+qeR48PgOYWvGFv70Bt+sj10RpeiwJ5
         Hu9nZ9jRrlcWf4makDNRmsuueXDgebuF9a1ijEvFlqp7CjqwvVDlNSBCHXSi2w3iYBVm
         suKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=qnhyVJrru7zMiI7n/yEqjdN4SsJ+YMPRkUhaaT7kPkQ=;
        b=UlGsZSpsRzo1d0P0o6iRIxRtxTT8feSR8ohv0llyssyTlOGVPHHH/8pwOoh74oaZKY
         vYh46G0+r+uQBeqvh5emqf6Q/7vPGBJkCCtS0UAVya4a+1BVjkh8bvgG8+PPOQjFw+gh
         z6gz0u6pU3tBruC9okK7neLVZxD0naVD8BIOsKT2N/O4k1892RosetLOvkqC5Ug7SkyF
         piJuKNdli5uDBXx++0QaA6tMJDpusoNsbhT9mYS/8+zmUkk/QXQISoH9fZO8SCDN3IEM
         NW+X4Ol9o4zbM1F+a1I7AayzI1OZw6bh2INm0wz6Z42RrLYEITzCxnOh9L6hsG9Xxl8F
         OfOQ==
X-Gm-Message-State: AJcUukfY+m5iHugmOOj8t1QmX56fD2n9vZyWGI6mnKke2/OVDk9HMJx0
        a6pwJ9H1WsUWuCsqG80tOwU=
X-Google-Smtp-Source: ALg8bN7AqgAFVbtP3t8vgN+BOb2Rzu0DUxiCJXiqT4bzM1ESyPXKcGlE6UpZflc3wadsjfF8R6Ivjg==
X-Received: by 2002:adf:e608:: with SMTP id p8mr6469973wrm.166.1548322811547;
        Thu, 24 Jan 2019 01:40:11 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id f137sm47547980wmg.29.2019.01.24.01.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 01:40:10 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/6] commit-graph: implement file format version 2
References: <pull.112.git.gitgitgadget@gmail.com> <c55e0a738c79c30affcf2cb68564c01c36c66dff.1548280753.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <c55e0a738c79c30affcf2cb68564c01c36c66dff.1548280753.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Jan 2019 10:40:09 +0100
Message-ID: <878sza4cna.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 23 2019, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The commit-graph file format had some shortcomings which we now
> correct:
>
>   1. The hash algorithm was determined by a single byte, instead
>      of the 4-byte format identifier.
>
>   2. There was no way to update the reachability index we used.
>      We currently only support generation numbers, but that will
>      change in the future.
>
>   3. Git did not fail with error if the unused eighth byte was
>      non-zero, so we could not use that to indicate an incremental
>      file format without breaking compatibility across versions.
>
> The new format modifies the header of the commit-graph to solve
> these problems. We use the 4-byte hash format id, freeing up a byte
> in our 32-bit alignment to introduce a reachability index version.
> We can also fail to read the commit-graph if the eighth byte is
> non-zero.

I haven't tested, but it looks from the patch like we can transparently
read existing v1 data and then will write v2 the next time. Would be
helpful for reviewers if this was noted explicitly in the commit
message.

Should there be a GIT_TEST_COMMIT_GRAPH_VERSION=[12] going forward to
test the non-default version, or do you feel confident the tests added
here test the upgrade path & old code well enough?

> The 'git commit-graph read' subcommand needs updating to show the
> new data.

Let's say "The ... subcommand has been updated to show the new
data". This sounds like a later patch is going to do that, but in fact
it's done here.

> Set the default file format version to 2, and adjust the tests to
> expect the new 'git commit-graph read' output.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  .../technical/commit-graph-format.txt         | 26 +++++++++-
>  builtin/commit-graph.c                        |  9 ++++
>  commit-graph.c                                | 47 ++++++++++++++++---
>  commit-graph.h                                |  1 +
>  t/t5318-commit-graph.sh                       |  9 +++-
>  5 files changed, 83 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> index 16452a0504..e367aa94b1 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -31,13 +31,22 @@ and hash type.
>
>  All 4-byte numbers are in network order.
>
> +There are two versions available, 1 and 2. These currently differ only in
> +the header.

Shouldn't this be s/currently/ / ? Won't we add a version 3 if we make
new changes?
