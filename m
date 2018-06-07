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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5188C1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934852AbeFGOpZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:45:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55726 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934720AbeFGOpV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:45:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so18602925wmh.5
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=50iI1ZqHnUaUglTf3R7etVmrlBrMG27WuLOyd8btAlU=;
        b=bZgpnM3s538b6zb4FJZ6I7Ky2PwDLbp2/CV88Ia3S4650v/g7ONqo9WMwJitnuklGD
         jTyEaqyIyD9JoVmvWaSGdDl+P78Fo8XrbO/GAKJ4z7GiDpt50wZD3G7+Pg0ol4DBIjTX
         2U26v4uJGiKdtf9/LqZD3mRrugIWY16TWtsgnWw3RZt+NB/OxqlbeF8elggozbu496eE
         ADBGqLTtw3/bCHyMDNkGQr58ocH7efkyqvkLcwxcVnZb8ds8syRqzbb+Sx9eogE8qDjW
         6tf7V10e+RlOVdh9qpvDBUh178BTJhuUT6JUX7HTNf5ls0tvhT2N+0sA56BT+QhGkFEl
         N1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=50iI1ZqHnUaUglTf3R7etVmrlBrMG27WuLOyd8btAlU=;
        b=hF90w+QwGAZdr07GhqBxv6uyGXvcvELpkTSavfijUpSY6LpABQq3VKktj1DPxJa3rT
         ZdytoMxVZBmkFIDpcCGUl51Ppmiy0D7tizQjT4gte00WZSws9mAZ4IY5HEZoa77XyJJ8
         xLn8c9X1rDX2eV2euPgjPj+zpThADcqnDbDZuHQw9E6+N5O9zDfaD+uzNVmo8X+UvjdQ
         UmmwxS9pWzHTOkaqKh936QHqZzYpMobERGaPPalQYKZsZZjqVwbwyYe+3nbQr4WDxuJr
         ajtsyUrqN/vaTvxxP7VJQIQqLA+tFQuybNEzuiduc4pokJFu6uEsfn6aHGPRyozK2WCX
         Ir6A==
X-Gm-Message-State: APt69E21uhOmZTXJn3ZJY8PzdbL8UeXNCaW+QwcaVLR+wDWX+wpO4WJP
        oAoSaUUvhpoKbEXhE2+ZlNK6b3T2
X-Google-Smtp-Source: ADUXVKKiZqc0PujGppvfRW0PCIXOKgKO+TYbb5R9RI1TspkYq/g0x05WaM/qMfWcMp33G2/UUQM2Tg==
X-Received: by 2002:a50:a4c6:: with SMTP id x6-v6mr2882733edb.247.1528382719547;
        Thu, 07 Jun 2018 07:45:19 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id d11-v6sm2671459edh.61.2018.06.07.07.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 07:45:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, dstolee@microsoft.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: Re: [PATCH 00/23] Multi-pack-index (MIDX)
References: <20180607140338.32440-1-dstolee@microsoft.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180607140338.32440-1-dstolee@microsoft.com>
Date:   Thu, 07 Jun 2018 16:45:18 +0200
Message-ID: <877enazmdd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 07 2018, Derrick Stolee wrote:

> To test the performance in this situation, I created a
> script that organizes the Linux repository in a similar
> fashion. I split the commit history into 50 parts by
> creating branches on every 10,000 commits of the first-
> parent history. Then, `git rev-list --objects A ^B`
> provides the list of objects reachable from A but not B,
> so I could send that to `git pack-objects` to create
> these "time-based" packfiles. With these 50 packfiles
> (deleting the old one from my fresh clone, and deleting
> all tags as they were no longer on-disk) I could then
> test 'git rev-list --objects HEAD^{tree}' and see:
>
>         Before: 0.17s
>         After:  0.13s
>         % Diff: -23.5%
>
> By adding logic to count hits and misses to bsearch_pack,
> I was able to see that the command above calls that
> method 266,930 times with a hit rate of 33%. The MIDX
> has the same number of calls with a 100% hit rate.

Do you have the script you used for this? It would be very interesting
as something we could stick in t/perf/ to test this use-case in the
future.

How does this & the numbers below compare to just a naïve
--max-pack-size=<similar size> on linux.git?

Is it possible for you to tar this test repo up and share it as a
one-off? I've been polishing the core.validateAbbrev series I have, and
it would be interesting to compare some of the (abbrev) numbers.

> Abbreviation Speedups
> ---------------------
>
> To fully disambiguate an abbreviation, we must iterate
> through all packfiles to ensure no collision exists in
> any packfile. This requires O(P log N) time. With the
> MIDX, this is only O(log N) time. Our standard test [2]
> is 'git log --oneline --parents --raw' because it writes
> many abbreviations while also doing a lot of other work
> (walking commits and trees to compute the raw diff).
>
> For a copy of the Linux repository with 50 packfiles
> split by time, we observed the following:
>
>         Before: 100.5 s
>         After:   58.2 s
>         % Diff: -59.7%
>
>
> Request for Review Attention
> ----------------------------
>
> I tried my best to take the feedback from the commit-graph
> feature and apply it to this feature. I also worked to
> follow the object-store refactoring as I could. I also have
> some local commits that create a 'verify' subcommand and
> integrate with 'fsck' similar to the commit-graph, but I'll
> leave those for a later series (and review is still underway
> for that part of the commit-graph).
>
> One place where I could use some guidance is related to the
> current state of 'the_hash_algo' patches. The file format
> allows a different "hash version" which then indicates the
> length of the hash. What's the best way to ensure this
> feature doesn't cause extra pain in the hash-agnostic series?
> This will inform how I go back and make the commit-graph
> feature better in this area, too.
>
>
> Thanks,
> -Stolee
