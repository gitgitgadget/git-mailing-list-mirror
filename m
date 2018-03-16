Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6BB1FAE2
	for <e@80x24.org>; Fri, 16 Mar 2018 15:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeCPPG1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 11:06:27 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:51189 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeCPPG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 11:06:26 -0400
Received: by mail-wm0-f47.google.com with SMTP id w128so3652643wmw.0
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=szSEze62JtCZ9LG3Rpiq+IUqveV9yov/zIpT7T+lL8M=;
        b=uA6j/9EWVkSq4JmAINCqJcg/9mSHcl036jmJEFXduGkjeHdAC+sn5RT0cpOhqD8g0A
         RNkMjZ0S20UvwlCTwoV7RsA2RKZKLVX0RH8OYGyZRh83NO7GsMT05TGXstf8E6DA0+8O
         80YcHV77HL6NHe8TtEo3L2jK7FV4wCjAANYmY4utkx5gYagpS1iuiWhjveJLRyMVi/RC
         WHmWjRpySpRMPbabwYzmfqGHrtTZvV+I4wKASu0k9mCWthilJZB+ORwOVBwqHEM6ZZWX
         sQa60rjyrnYArAA7Mf1D4yv/SeJV/oFnENcooEjAAj07fc4iDBO78HXXL5H2wxr4iE6D
         BwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=szSEze62JtCZ9LG3Rpiq+IUqveV9yov/zIpT7T+lL8M=;
        b=CHVry1YsebbGRWXpEiplmgd78lbhAxz2Anm/LIsoYT2HIdZgaOrztULyZjHlSoKl4B
         jGrqTUZpIZQ4lbiaxOv4br0Juc9opCJq8ubCeSaoiNI6hORsBkElqL5o7DYiySPViYkq
         rrKCxrqZ/0QrGnajOknbK2kArBmpcJTs9P6i/2NlPiiu/qZlIzpUgH3Ftlvw8vWeZGGs
         TzTSCQ690qnaqnQIpD5eG0i57ZTBSD6Aix4QkFjBae1hBOoCrEPdKetjfWvp3+PwS3Gw
         67JRdW2wca6jXdMt7Pl9w/PVvQxPBz7bEu+VwFBSwAd75Te758vc/FrxoYu0FYBtKek8
         lFgA==
X-Gm-Message-State: AElRT7GqlOcXfZtIhT0LQ8qyWkBjJnUcQFrqF1u9Pn9PkVMTMGV64ZL6
        VwW8vQyBa2a9fwijx5/YvSFUnu/i
X-Google-Smtp-Source: AG47ELvZ8ZU/MmZnBRBrmQyaCfAIO2K7LVwSUmpYa4GkqQcghePrzImWXJTiQc8LzXKykePZ6Qt8Jw==
X-Received: by 10.80.176.69 with SMTP id i63mr2905379edd.215.1521212785239;
        Fri, 16 Mar 2018 08:06:25 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id i10sm3798218edl.40.2018.03.16.08.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 08:06:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com> <20180314192736.70602-1-dstolee@microsoft.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180314192736.70602-1-dstolee@microsoft.com>
Date:   Fri, 16 Mar 2018 16:06:23 +0100
Message-ID: <878tasdpqo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 14 2018, Derrick Stolee jotted:

> Hopefully this version is ready to merge. I have several follow-up topics
> in mind to submit soon after, including:

I've been doing some preliminary testing of this internally, all good so
far, on a relatively small repo (~100k commits) I was using for testing:

    - git -c core.commitGraph=true -C <repo> rev-list --all:
        -      /mnt/ext4_graph => min:273    mean:279    max:389    -- (273 274 275 276 277 279 282 282 345 389)
        -            /mnt/ext4 => min:1087   mean:1123   max:1175   -- (1087 1092 1092 1104 1117 1123 1126 1136 1143 1175)

This is on a fresh clone with one giant pack and where the commit graph
data was generated afterwards with "git commit-graph write" for the
*_graph repo, so it contains all the commits.

So less than 25% of the mean time it spent before. Nice. Those are times
in milliseconds over 10 runs, for this particular one I didn't get much
of an improvement in --graph, but still ~10%:

    - git -c core.commitGraph=true -C <repo> log --oneline --graph:
        -      /mnt/ext4_graph => min:1420   mean:1449   max:1586   -- (1420 1423 1428 1434 1449 1449 1490 1548 1567 1586)
        -            /mnt/ext4 => min:1547   mean:1616   max:2136   -- (1547 1557 1581 1585 1598 1616 1621 1740 1964 2136)

I noticed that it takes a *long* time to generate the graph, on a bigger
repo I have it takes 20 minutes, and this is a repo where repack -A -d
itself takes 5-8 minutes, probably on the upper end of that with the
bitmap, but once you do that it's relatively snappy with --stdin-commits
--additive when I feed it the new commits.

I don't have any need really to make this run in 10m instead of 20m,
just something I found interesting, i.e. how it compares to the repack
itself.
