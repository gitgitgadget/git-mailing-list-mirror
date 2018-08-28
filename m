Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65AC11F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeH2Bae (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:30:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33341 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeH2Bae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:30:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id 60-v6so1309122ple.0
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HoNk1zMe/NnogDXqTxiYFlyfhv/bmlKtdeOPVjyYihM=;
        b=kCv+IrhbTq2YQTEl1GXNpubhV4YAqdB4lxuKnBI84pfj+AWi0GRcjngRIQzqkBG4qw
         hDMJxb8hwIGVotfUXC2yg96ec5q8LewXnevMx/3MVN7Id/cWvg/XKT2KDZBVUUHu72+K
         pityrBGndJxR1AOnsyFhfxwuLZSdrsLI8RMBr71t/f3QLqUzwkEftrDJRQ2jdRRdTTrh
         XjEEDb4Xrh+KcALIFVbPUrKx9sYu89yon79kPu5X5p4mS62rq0MEsMc7y69JoyXclG/d
         Na9o71UPWxwjjKAifrAWRIh816/f4e3a/wHv0wV9MQPpo4O+Pd2aXCBxWvXEdF1qeKGi
         G8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HoNk1zMe/NnogDXqTxiYFlyfhv/bmlKtdeOPVjyYihM=;
        b=UeX3Rf9agkYhrsI949OxyRC7iCJGgEax7FRPQ0hnNjUh7pNjb1bPlS41Bti5PySfK7
         JwQnls+C1UTTXvjlv9fEm+HA7M9CvwkQPuj1g534U10lk/vuM1xoV/2zwcUKKqj+4Xnm
         V/EH8vYQ7Qh6mnpHfjywuMYK+GQt0gBZ0ZQuOuVlNN6EdOQ5ZOaQIxQvhwtc3sSIfDMD
         o8ebSBTmrvUYaHS6UxMWOmzjCe/3yxeK71CMGXFOQ4av9qCLIYHQBGUm72uIqnDxWJS2
         GmgYB1mDGE3QPOnmla7PFgl+pb7/s0DIrdzDKvTV850zB1WcjaZOLa/MJ1y3q6DwgLMv
         c74Q==
X-Gm-Message-State: APzg51CPcq1+Rk4nVYBv7O89AWfFB14a15/tu1Ak91tRrpcEj4sj6khz
        aFlGg38hkqS4nUVcxbqayE8=
X-Google-Smtp-Source: ANB0VdaKmhb73sd7n7/Nzqggu6KZtbpKh6hyCEwXP9m1JYtV8Oncg8ERDkYMqyl5BJnTrYzLDzCoOQ==
X-Received: by 2002:a17:902:b702:: with SMTP id d2-v6mr3268666pls.12.1535492220105;
        Tue, 28 Aug 2018 14:37:00 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h7-v6sm6682640pfd.155.2018.08.28.14.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 14:36:59 -0700 (PDT)
Date:   Tue, 28 Aug 2018 14:36:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH] commit-reach: correct accidental #include of C file
Message-ID: <20180828213657.GA74296@aiede.svl.corp.google.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
 <20180720163227.105950-5-dstolee@microsoft.com>
 <20180828212457.GA74687@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828212457.GA74687@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without this change, the build breaks with clang:

 libgit/ref-filter.pic.o: multiple definition of 'filter_refs'
 libgit/commit-reach.pic.o: previous definition here

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:
> Derrick Stolee wrote:

>> --- a/commit-reach.c
>> +++ b/commit-reach.c
>> @@ -1,8 +1,10 @@
>>  #include "cache.h"
>>  #include "commit.h"
>> +#include "commit-graph.h"
>>  #include "decorate.h"
>>  #include "prio-queue.h"
>>  #include "tree.h"
>> +#include "ref-filter.c"
>
> Did you mean "ref-filter.h"?
>
> This broke the build here.  Is there some check that we can use to
> prevent it happening again?  I don't think we ever intentionally
> #include a .c file.

Here's what I'm applying locally.

Thanks,
Jonathan

 commit-reach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index c996524032..86715c103c 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -4,7 +4,7 @@
 #include "decorate.h"
 #include "prio-queue.h"
 #include "tree.h"
-#include "ref-filter.c"
+#include "ref-filter.h"
 #include "revision.h"
 #include "tag.h"
 #include "commit-reach.h"
-- 
2.19.0.rc0.228.g281dcd1b4d0

