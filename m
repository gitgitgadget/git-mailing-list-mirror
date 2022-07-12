Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF2FC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiGLNQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiGLNQo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:16:44 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00B9B62A4
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:16:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id p13so4810177ilq.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=NEtYCevmRVUg++HOh7rUmEnSk2zvm72eIKUtjiltYTs=;
        b=VLJM/ftmgeA8KroszDvt9ZlsACoyM2oNGe8cR0GO66YLXmHJH97A9VhMuI9HHfgJQ7
         MOMncvjZlcQCfUXuEih2K6dyukhjf6nLx3N9Vrl9D2aYMrrdb/jWGF9EErx29XMhZPuH
         r8C96y3ZcX9f1DFyT3wwgg11itPvN/rtobV9/2uu3byf9oY6O5yWuRQ6mKGvs7/LWwrS
         fiCM53CfIB6D+umwWScvcBphUNqoJviCg5wic6rnHwEUStlLg+CnFHFBxeJOWe9V0+AG
         8ndwIWh2TZFFioKXq3EvUgfYNbMo9uDeC/LtRPoPNh1Me5nXng4384oK/PqaLTmMVICR
         dQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NEtYCevmRVUg++HOh7rUmEnSk2zvm72eIKUtjiltYTs=;
        b=m3z8u7jvYb4eeB/2X7GV5E5+O3RSSyPQJW8mt27ALXmr5MVAgRR0NUqnqgfrXl5RJv
         Scevd64hRPgAn0ua5tcUZj4mdMThM9q4KLCwawil92ILQqf34s8K/X8V+OtJPi9DYhDq
         8i7I1DcUeHH30T29RsyNwL1uNaD5qoovizau29MtO4KhOEoxyw7+mxxtJXOYJErinuUr
         wm4LtNJDsh4uUpAxZ0xA/3X+TyIbIdNF0X5bXdTtMxKkwCz3RnPFp/fiQuAb9zPfmeao
         OkeP3kmfszsvBmM80eWI6CDG6HSeG4BtAYGB6oRgTcQNJjCa5h8ufoknkzR4xUdw7muq
         OsMg==
X-Gm-Message-State: AJIora+J6t+CBSA0VMGOrGjqFsxqQyak/c9gdE+CaLDo+kF/twbs54N7
        ZG4Cpce2t27CC5zMo7h9sXquIHkW4hlV
X-Google-Smtp-Source: AGRyM1v5D5c81PF4rmtTHz2vr0MJeBj+lXe0z3TQu6mK4icRT0b9CgZ2g439dKagsYaK5pSek260Wg==
X-Received: by 2002:a05:6e02:2188:b0:2dc:7546:1ea9 with SMTP id j8-20020a056e02218800b002dc75461ea9mr7166607ila.136.1657631784782;
        Tue, 12 Jul 2022 06:16:24 -0700 (PDT)
Received: from [192.168.0.180] ([199.102.122.24])
        by smtp.gmail.com with ESMTPSA id p6-20020a02b006000000b0032b3a7817acsm4062182jah.112.2022.07.12.06.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 06:16:24 -0700 (PDT)
Message-ID: <b0b3917e-cec8-37bf-0482-e3d5f207eda0@github.com>
Date:   Tue, 12 Jul 2022 07:16:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [GSoC] Week 3 and week 4 status update
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAJyCBOSrhxbCcDX5oWBuNEWOxQu2Rmk+T+paORLzoLF=iaBH1Q@mail.gmail.com>
 <803773d1-25b6-e62b-18fa-efd9fdc92c97@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <803773d1-25b6-e62b-18fa-efd9fdc92c97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/22 2:24 AM, Shaoxuan Yuan wrote:
> Hi Git community,
> 
> Here is Shaoxuan Yuan.
> 
> I'm writing to share my latest progress [1] from GSoC week 3 and week 4.

Thanks for the report!

> This week I'm working to ship a PATCH v5 [2] (please reference all the
> code here) to address the issues raised in PATCH v4 [3].

(I think this is left over from earlier?)

> The good news is, that PATCH v5 is being queued into the 'next' branch, which
> means it could potentially be merged into 'master'. It marks that this stage
> of work is almost done.

In fact, the latest "What's Cooking" says this:

* sy/mv-out-of-cone (2022-07-01) 8 commits
  (merged to 'next' on 2022-07-08 at 654970fdb7)
 + mv: add check_dir_in_index() and solve general dir check issue
 + mv: use flags mode for update_mode
 + mv: check if <destination> exists in index to handle overwriting
 + mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
 + mv: decouple if/else-if checks using goto
 + mv: update sparsity after moving from out-of-cone to in-cone
 + t1092: mv directory from out-of-cone to in-cone
 + t7002: add tests for moving out-of-cone file/directory

 "git mv A B" in a sparsely populated working tree can be asked to
 move a path between directories that are "in cone" (i.e. expected
 to be materialized in the working tree) and "out of cone"
 (i.e. expected to be hidden).  The handling of such cases has been
 improved.

 Will merge to 'master'.
 source: <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>

So, it is already in 'next' and will merge to 'master' soon. You
should expect those commits to be final (barring anything drastic
noticed during the cooking phase) so you can send your next set
of patches. Just make sure to point out in the cover letter that
they are based on sy/mv-out-of-cone. That branch is available in
the gitgitgadget/git repository so you can base a PR against it,
if you want.

Thanks,
-Stolee
