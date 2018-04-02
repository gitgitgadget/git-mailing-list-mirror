Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8B51F404
	for <e@80x24.org>; Mon,  2 Apr 2018 14:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeDBOqO (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 10:46:14 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33500 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeDBOqN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 10:46:13 -0400
Received: by mail-wr0-f194.google.com with SMTP id z73so14112013wrb.0
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8JbjqqVCCb99NpmQ33hB093V7alS+m/YuiQFeastPts=;
        b=Wm5U0M30HM+5K8QZZweo1efar/AgWDtjwKTymLlbdxJWDORCFYArRc12vz4vOt/s2d
         V3Kb6dFtk3Jk8DWn9EIpEQXzCT7j7sXfY7//zG9uct5J6w8PIH8C6bdCoUYiFi2JzpuU
         B48gpAnvu8uZF97qaYpxO8CBblfYz1UvO8wUJm3AhMhcqvrNU63/hC/SKZF630p5UaLd
         i4OJGbog5xwYR0P2fITUVs2xM1hWhol/DpTYoswISJMgNSDRsvqCgy4Lyl5cLDJkBQkf
         xqWySgvvFR1GHRrmZHy+p/huaqivHecZLhvW6vtPUA918WDoCGaRrW8bZDy1BTCu6Ft2
         16Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=8JbjqqVCCb99NpmQ33hB093V7alS+m/YuiQFeastPts=;
        b=FMV9pgJjGSqO7U+FUgSPY2PUZSINjvj8BFJa98/aJ36R2fum4O9dVW7+tWNgQY0G6H
         xYVg3Y1ey5alEB4p24KmuleD8NU2F3QL5IpkphU/NSH8mg0EHOWq2Z4uzR5MsmFvUUpe
         /4WYEhidbh9WjFM5FgWw4SHWabj6L2VZ2TGfwuEqAyuD5G7XAJDkxq0lPGB8oGjmR4+L
         FGa9PsgycFGxSY3UB0OggVWiADgFCv/g71Sxgz3f+pK9XSUSSkknbzPq61p5+GxzzFC1
         WsEOzDsUJE2vGMFtut9L7X9qe2fRkI23KK6kWlH9x5H69BFZQYSPXsJ7Yf6ioRvXrC/q
         acdw==
X-Gm-Message-State: AElRT7EzsHIdvIsVGkMvcne/teoN+9TJclrTglpbeAzFPdeR+7WInFC3
        zVTAVGEthfHkbVvwRK6DDXA=
X-Google-Smtp-Source: AIpwx49pL57JBMjoc4dcL+ylg1FCSAGiDffBUZi/HEtnOJsdHFNYn6uPIMWIFw4eSip3BmarhIUC8Q==
X-Received: by 10.223.130.246 with SMTP id 109mr7276871wrc.45.1522680371784;
        Mon, 02 Apr 2018 07:46:11 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (afx247.neoplus.adsl.tpnet.pl. [83.25.153.247])
        by smtp.gmail.com with ESMTPSA id u196sm621545wmf.30.2018.04.02.07.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 07:46:10 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 00/13] Serialized Git Commit Graph
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <867eptkeeq.fsf@gmail.com>
        <f5d8934e-afc2-39d4-b7d5-e5ba5e5021a1@gmail.com>
Date:   Mon, 02 Apr 2018 16:46:07 +0200
In-Reply-To: <f5d8934e-afc2-39d4-b7d5-e5ba5e5021a1@gmail.com> (Derrick
        Stolee's message of "Mon, 2 Apr 2018 09:02:11 -0400")
Message-ID: <861sfxekeo.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 3/30/2018 7:10 AM, Jakub Narebski wrote:
>> I hope that I am addressing the most recent version of this series.
>
> Hi Jakub. Thanks for the interest in this patch series.
>
> The most-recent version is v6 [1], but I will re-roll to v7 soon
> (after v2.17.0 is marked).
>
> [1] https://public-inbox.org/git/20180314192736.70602-1-dstolee@microsoft=
.com/T/#u

Ooops.  Sorry about that.

>> Derrick Stolee <stolee@gmail.com> writes:
[...]

>> What are the assumptions about the serialized commit graph format? Does
>> it need to be:
>>   - extensible without rewriting (e.g. append-only)?
>>   - like the above, but may need rewriting for optimal performance?
>>   - extending it needs to rewrite whole file?
>>
>> Excuse me if it waas already asked and answered.
>
> It is not extensible without rewriting. Reducing write time was not a
> main goal, since the graph will be written only occasionally during
> data management phases (like 'gc' or 'repack'; this integration is not
> implemented yet).

Ah.  I thought that it could be something easily extensible in-place,
and thus easy to keep up to date on each commit.

Recalculating it on 'gc' or 'repack' is still good, especially that it
works even when there are come commits outside commit-graph, without
this information.

>>
>>> The file format has room to store generation numbers, which will be
>>> provided as a patch after this framework is merged. Generation numbers
>>> are referenced by the design document but not implemented in order to
>>> make the current patch focus on the graph construction process. Once
>>> that is stable, it will be easier to add generation numbers and make
>>> graph walks aware of generation numbers one-by-one.
>>>
>> As the serialized commit graph format is versioned, I wonder if it would
>> be possible to speed up graph walks even more by adding to it FELINE
>> index (pair of numbers) from "Reachability Queries in Very Large Graphs:
>> A Fast Refined Olnine Search Approach" (2014) - available at
>> http://openproceedings.org/EDBT/2014/paper_166.pdf
>>
>> The implementation would probably need adjustments to make it
>> unambiguous and unambiguously extensible; unless there is place for
>> indices that are local-only and need to be recalculated from scratch
>> when graph changes (to cover all graph).
>
> The chunk-based format is intended to allow extra indexes like the one
> you recommend, without needing to increase the version number. Using
> an optional chunk allows older versions of Git to read the file
> without error, since the data is "extra", and newer versions can take
> advantage of the acceleration.

That's good.

> At one point, I was investigating these reachability indexes (I read
> "SCARAB: Scaling Reachability Computation on Large Graphs" by Jihn,
> Ruan, Dey, and Xu [2]) but find the question that these indexes target
> to be lacking for most of the Git uses. That is, they ask the boolean
> question "Can X reach Y?". More often, Git needs to answer "What is
> the set of commits reachable from X but not from Y" or "Topologically
> sort commits reachable from X" or "How many commits are in each part
> of the symmetric difference between reachable from X or reachable from
> Y?"

In the "Reachability Queries in Very Large Graphs..." by Veloso, Cerf,
Meira and Zaki FELINE-index work, authors mention SCARAB as something
that can be used in addition to FELINE-index, as a complementary data
(FELINE-SCARAB in the work, section 4.4).

I see the FELINE-index as a stronger form of generation numbers (called
also level of the vertex / node), in that it allows to negative-cut even
more, pruning paths that are known to be unreachable (or marking nodes
known to be unreachable in the "calculate difference" scenario).=20

Also, FELINE-index uses two integer numbers (coordinates in 2d space);
one of those indices can be the topological numbering (topological
sorting order) of nodes in the commit graph.  That would help to answer
even more Git questions.

> The case for "Can X reach Y?" is mostly for commands like 'git branch
> --contains', when 'git fetch' checks for forced-updates of branches,
> or when the server decides enough negotiation has occurred during a
> 'git fetch'. While these may be worth investigating, they also benefit
> greatly from the accelerated graph walk introduced in the current
> format.
>
> I would be happy to review any effort to extend the commit-graph
> format to include such indexes, as long as the performance benefits
> outweigh the complexity to create them.
>
> [2] http://citeseerx.ist.psu.edu/viewdoc/download?doi=3D10.1.1.719.8396&r=
ep=3Drep1&type=3Dpdf

The complexity of calculating FELINE index is O(|V| log(|V|) + |E|), the
storage complexity is 2*|V|.

>>
>>> Here are some performance results for a copy of the Linux repository
>>> where 'master' has 704,766 reachable commits and is behind 'origin/mast=
er'
>>> by 19,610 commits.
>>>
>>> | Command                          | Before | After  | Rel % |
>>> |----------------------------------|--------|--------|-------|
>>> | log --oneline --topo-order -1000 |  5.9s  |  0.7s  | -88%  |
>>> | branch -vv                       |  0.42s |  0.27s | -35%  |
>>> | rev-list --all                   |  6.4s  |  1.0s  | -84%  |
>>> | rev-list --all --objects         | 32.6s  | 27.6s  | -15%  |
>>
>> That's the "Rel %" of "Before", that is delta/before, isn't it?
>
> I do mean the relative change.

But is it relative to the state before, or relative to the state after?

[...]
>> I just wonder what happens in the (rare) presence of grafts (old
>> mechanism), or "git replace"-d commits...
>
> In the design document, I mention that the current implementation does
> not work with grafts (it will ignore them). A later patch will
> refactor the graft code so we can access it from the commit-graph
> parsing of a commit without copy-pasting the code out of
> parse_commit_gently().
>
> The commit-graph is only a compact representation of the object
> database. If a commit is replaced with 'git replace' before 'git
> commit-graph write' then the commit-graph write will write the
> replaced object. I haven't tested what happens when a commit-graph is
> written and then a commit is replaced, but my guess is that the
> replacement does not occur until a full parse is attempted (i.e. when
> reading author or commit message information). This will lead to
> unknown results.
>
> Thanks for pointing out the interaction with 'git replace'. I have
> items to fix grafts and replaced commits before integrating
> commit-graph writes into automatic actions like 'gc.auto'.

Note that you can make Git ignore replacements with appropriate command
line option for "git" wrapper; the transfer mechanism can safely
ignore replacements (treating refs/replacements just like it would any
other refs/).

Best regards,
--
Jakub Nar=C4=99bski
