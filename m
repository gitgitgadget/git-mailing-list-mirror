Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88CE1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 19:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeI2CGs (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 22:06:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35638 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeI2CGs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 22:06:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id z14-v6so7970996qtn.2
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bpNpj9aEKQrt4XvO2APsnpAHt+cpsxe8AoEMV1SCTbY=;
        b=fAjHbnjQw4QXU0PBu2kUpqHaoUjMEB9ey8ISKPah1yQpqo1Ypowc2tQvEd6FRjQXu6
         Da8xMxRxYK1+ucstv/wQo3jmYX0kw/PVfOxmTr7BtWw1zdfzp7XR7xMneX14CuUYKHGq
         WLgRjHfx/yRJq3AQEpLcRMjYuiTRtFNiRqD9J5OR1O8hUB/GWX8vLUKGPu0ReiWBxjxt
         Jmm8rYbDEXp2+m7ETnl6djQ2SwhHORQfK7TvnUf2lPZGhEUKqO8DjvuEsRMLKOJkvwH9
         O8+qalXhPd4XutgF2ZCMPK6FPvpqTyKPiwgEZAcQtCrpSFhMsc+uHxXhuJlPklu+ZhB8
         GVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bpNpj9aEKQrt4XvO2APsnpAHt+cpsxe8AoEMV1SCTbY=;
        b=HjLjo8iPVm7N1XLjzOB6MNxacblRuhB8L+Edvn4QjJ5kA9knol2fjKHfqHjLDMcHKK
         3f7my9Pf681/jHxvjS2J64f9LZbtfIfE6rVThaujhLhGraB2yNZNZx7QxVDD2NaJjxmh
         bzE6x2Izkd7oj1dWyDWh3oOYAWq2L0ADGKoMcGjTT5jr+nqOTLVeARYPYjw5vZQhrqbi
         4kK3WIY0FKtLhEuOflLs1mKGaD9Xv2BQeFqV5jreg9VNkX0QUsTVP7wo6xptiNvoThun
         72bZhwVkUgqORfD32W4KTvIgmv/bYWPzyqn/HpWwkn81RIR9H1cnp+1Yw7jD4sW1e7AL
         74yg==
X-Gm-Message-State: ABuFfogUtPrx1PWw9se2iUHh3F58jhS7ENHIonyE++ZVYlZ5nu6ohi5V
        Xzw4VNsu+75sHTmhYagJfBRwLMhq6z4=
X-Google-Smtp-Source: ACcGV61X3sKuFB/LlvMyH6mE9GWjImUY0M0un4dtplTY5VD4bjafl8JMU2VkGbfAXyWz4V/brZmoQQ==
X-Received: by 2002:a0c:91fd:: with SMTP id r58-v6mr116891qvr.30.1538163691604;
        Fri, 28 Sep 2018 12:41:31 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id m61-v6sm1140284qte.30.2018.09.28.12.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 12:41:30 -0700 (PDT)
Subject: Re: [PATCH v6 4/7] config: add new index.threads config setting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
 <20180926195442.1380-5-benpeart@microsoft.com>
 <20180928002627.GO27036@localhost>
 <cbc48a95-62f5-a098-fb70-97b6cf241920@gmail.com>
 <xmqqsh1tczyz.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a58a5cce-b3c2-62a2-598b-6b7dbe1a86fc@gmail.com>
Date:   Fri, 28 Sep 2018 15:41:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqsh1tczyz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/28/2018 1:07 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>>> Why does multithreading have to be disabled in this test?
>>
>> If multi-threading is enabled, it will write out the IEOT extension
>> which changes the SHA and causes the test to fail.
> 
> I think it is a design mistake to let the writing processes's
> capability decide what is written in the file to be read later by a
> different process, which possibly may have different capability.  If
> you are not writing with multiple threads, it should not matter if
> that writer process is capable of and configured to spawn 8 threads
> if the process were reading the file---as it is not reading the file
> it is writing right now.
> 
> I can understand if the design is to write IEOT only if the
> resulting index is expected to become large enough (above an
> arbitrary threshold like 100k entries) to matter.  I also can
> understand if IEOT is omitted when the repository configuration says
> that no process is allowed to read the index with multi-threaded
> codepath in that repository.
> 

There are two different paths which determine how many blocks are 
written to the IEOT.  The first is the default path.  On this path, the 
number of blocks is determined by the number of cache entries divided by 
the THREAD_COST.  If there are sufficient entries to make it faster to 
use threading, then it will automatically use enough blocks to optimize 
the performance of reading the entries across multiple threads.

I currently cap the maximum number of blocks to be the number of cores 
that would be available to process them on that same machine purely as 
an optimization.  The majority of the time, the index will be read from 
the same machine that it was written on so this works well.  Before I 
added that logic, you would usually end up with more blocks than 
available threads which meant some threads had more to do than the other 
threads and resulted in worse performance.  For example, 4 blocks across 
3 threads results in the 1st thread having twice as much work to do as 
the other threads.

If the index is copied to a machine with a different number of cores, it 
will still all work - it just may not be optimal for that machine.  This 
is self correcting because as soon as the index is written out, it will 
be optimized for that machine.

If the "automatically try to make it perform optimally" logic doesn't 
work for some reason, we have path #2.

The second path is when the user specifies a specific number of blocks 
via the GIT_TEST_INDEX_THREADS=<n> environment variable or the 
index.threads=<n> config setting.  If they ask for n blocks, they will 
get n blocks.  This is the "I know what I'm doing and want to control 
the behavior" path.

I just added one additional test (see patch below) to avoid a divide by 
zero bug and simplify things a bit.  With this change, if there are 
fewer than two blocks, the IEOT extension is not written out as it isn't 
needed.  The load would be single threaded anyway so there is no reason 
to write out a IEOT extensions that won't be used.



diff --git a/read-cache.c b/read-cache.c
index f5d766088d..a1006fa824 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2751,18 +2751,23 @@ static int do_write_index(struct index_state 
*istate, struct tempfile *tempfil
e,
                  */
                 if (!nr) {
                         ieot_blocks = istate->cache_nr / THREAD_COST;
-                       if (ieot_blocks < 1)
-                               ieot_blocks = 1;
                         cpus = online_cpus();
                         if (ieot_blocks > cpus - 1)
                                 ieot_blocks = cpus - 1;
                 } else {
                         ieot_blocks = nr;
                 }
-               ieot = xcalloc(1, sizeof(struct index_entry_offset_table)
-                       + (ieot_blocks * sizeof(struct 
index_entry_offset)));
-               ieot->nr = 0;
-               ieot_work = DIV_ROUND_UP(entries, ieot_blocks);
+
+               /*
+                * no reason to write out the IEOT extension if we don't
+                * have enough blocks to utilize multi-threading
+                */
+               if (ieot_blocks > 1) {
+                       ieot = xcalloc(1, sizeof(struct 
index_entry_offset_table)
+                               + (ieot_blocks * sizeof(struct 
index_entry_offset)));
+                       ieot->nr = 0;
+                       ieot_work = DIV_ROUND_UP(entries, ieot_blocks);
+               }
         }
  #endif

