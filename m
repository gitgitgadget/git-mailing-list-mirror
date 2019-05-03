Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 000E51F453
	for <e@80x24.org>; Fri,  3 May 2019 12:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfECMrc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 08:47:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38751 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbfECMr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 08:47:28 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so6485751qth.5
        for <git@vger.kernel.org>; Fri, 03 May 2019 05:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=azHVkWo+k6iwDwHpxfvGfuzEaIycJ7rOUciTe2awnQs=;
        b=gY0BBxuca5VyCh/6yNaBJlJheZ3gr+Vw70MEDyh+jW9QbC+xq4SOOrwjlNRjynPe77
         7x0A33bwUAqvTRfVTdYGCMO6JhAuoSet6yXhYfCJpGrryAUtEHRrWznLHnHA7lSGnLXA
         7u0faJVWE521ZT6KM2qIy/R79UJDgHKmZ1NOrpn/0Vzql6ph7CVVe9rn0+0I6G4k3umf
         jFyC1pZGh9zekW2SJgboV+memgvUfOVuMvC0Tf4rZ331Hbd5u2rdnTIQfkWt01pXMwN2
         6daJv6H+n5uWGfxUVhxN2ZgeCb7Ov0tG0hxQ5RYFkrleFft3qZIRDAH66kmXJ56DD5M8
         EtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=azHVkWo+k6iwDwHpxfvGfuzEaIycJ7rOUciTe2awnQs=;
        b=b7Pg8QpvYKx27dn1duxnD/wS75gLLL6ZDPfIXq84DOuYEnacWZhQHK7Jy81iQMqutG
         aaISa9beeFn2jg+Alty+4cndOkN4OI6Ke+hO2qvEtj6UiYEmyN52webPln1vXb7DXWm7
         /nVG1kffCmZbv1hvkGHT0HGSNlrVDiP3aRs//JKGrjylariyklsn57O2IX+N21jjfh6C
         0jS7Z0r7rA5NtNYszzg/e26kcrBXS0Ra8f/dc3RFusgyC7hu9MIJK6gZKPZB5mH51LDp
         2V/4zEumnFDPyjyJlL3nvXk93EEPwg64MDcAXihrwDBhQpUStO5Ldm6KDCAgU8rlaWAP
         tRXg==
X-Gm-Message-State: APjAAAW+5hlORgNL2qAdiY9ShysvNLPJI1U3d03obT4RGPMuMpbbizjS
        KY+CYfG7uZUwn/T6Yy+30jZT09N7Rxo=
X-Google-Smtp-Source: APXvYqw+0ZbAQaeiN+QW/49cbPvQZTkJzR7hVBFNUtyYLHAcznzxJKxQO8A0WtGIIr59B4lH+86wRA==
X-Received: by 2002:ac8:18e6:: with SMTP id o35mr8334474qtk.77.1556887647393;
        Fri, 03 May 2019 05:47:27 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id b187sm1222781qkd.73.2019.05.03.05.47.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 05:47:26 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Create commit-graph file format v2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>
References: <pull.112.v2.git.gitgitgadget@gmail.com>
 <pull.112.v3.git.gitgitgadget@gmail.com> <87lfzprkfc.fsf@evledraar.gmail.com>
 <bb0c22f9-9d0b-0fa6-e826-8e2ac146c6f9@gmail.com>
 <87h8acivkh.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <04ac97c5-ab2b-2b23-4c84-8ed8aab0e2f5@gmail.com>
Date:   Fri, 3 May 2019 08:47:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <87h8acivkh.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/2/2019 2:02 PM, Ævar Arnfjörð Bjarmason wrote:
>
> But those are separate from any back-compat concerns, which is what I
> think makes sense to focus on now.

Thinking more on this topic, I think I have a way to satisfy _all_ of
your concerns by simplifying the plan for incremental commit-graph files.

My initial plan was to have the "commit-graph" file always be the "tip"
file, and it would point to some number of "graph-{hash}.graph" files.
Then, we would have some set of strategies to decide when we create a new
.graph file or when we compact the files down into the "commit-graph"
file.

This has several issues regarding race conditions that I had not yet
resolved (and maybe would always have problems).

It would be much simpler to restrict the model. Your idea of changing
the file name is the inspiration here.

* The "commit-graph" file is the base commit graph. It is always
  closed under reachability (if a commit exists in this file, then
  its parents are also in this file). We will also consider this to
  be "commit-graph-0".

* A commit-graph-<N> exists, then we check for the existence of
  commit-graph-<N+1>. This file can contain commits whose parents
  are in any smaller file.

I think this resolves the issue of back-compat without updating
the file format:

1. Old clients will never look at commit-graph-N, so they will
   never complain about an "incomplete" file.

2. If we always open a read handle as we move up the list, then
   a "merge and collapse" write to commit-graph-N will not
   interrupt an existing process reading that file.

I'll start hacking on this model.

Thanks,
-Stolee
