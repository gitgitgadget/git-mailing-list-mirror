Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A6320248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfCOQAO (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:00:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40463 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfCOQAN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:00:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id t5so10138060wri.7
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rlx085tm1Uq4Vf2N3ei8v+BJfaqhpZ1jcSkPOmHfrrM=;
        b=kDD60LtU0+16ThvUkyC/OFCEaen2lP5qvOtJjGnDR7semIxW2RmYz7YjhCoSslXVTl
         7L23GCQ20fVPawljiUw+MjDNvtNQF1wVgikkBwPWxkL3+ltrSB6/cSp4HDzfGvbZB6SF
         ZLe8IBSLOMAOnkAGq5VJUxTdyOYgMpgxpQZfnIsmUKVtUc8709h/94vIETPyoxch2CCj
         bLoDq/PRYhAphVfWgfEgNuw9mIRW+DPLRHOHQjBB9eRv+wjo9SMYtkuQF7hhwPVM7S0N
         pQBi/Pr2o7VZ6CFZHssDmTLJneyb7BWL7UTHmM+v/0xrohz9UbvNpsRpiyMQwb4WAu3K
         1FVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rlx085tm1Uq4Vf2N3ei8v+BJfaqhpZ1jcSkPOmHfrrM=;
        b=gHBzk7jH9AJewKA4Y4fEFwGY/4L0fsgyVzGbFeluDYw6bzLedDJEQVpTrBaD4kPbKJ
         L5bUYowHkuBmOp6ZHAEDH3o0zBdcecz+UZly51vyO3mlSWJhf40CGhBdhKiPocHHJyO1
         bo9z6FQtGeYIM3nExq0H9ywVk/0YzjMPs6gKt5QkT+H2APXsJJZBWY0/ebNOfdrgSgow
         NnRUJ2YfmrTrOxmSxXvHOntW71VPHETMGmfztZGeW1TEBUTU54E3lImk4/zwvb+lIEPH
         WhcLOKQ4O7CkLLuifke6ItmPnMUYoh4VfvNhUYDsPoQermcK7xoARoqcoxcP6/lbLosw
         xO/g==
X-Gm-Message-State: APjAAAWUof36l4vw0JhnOBWnJUVxxY/yHyn2I0UBhd2qVm9s93nrvtEd
        GxPwgksSzLLLJ6AJyyZCgEvGVJQHFwg=
X-Google-Smtp-Source: APXvYqyPhYP8lz1L08BTpqsvGXziyKne9KcDpofpXTl9tuWKcTAKq/aRL5AuZf9ioyWY4SRFo4/UAA==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr2809914wrs.157.1552665611460;
        Fri, 15 Mar 2019 09:00:11 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm467766wmm.14.2019.03.15.09.00.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 09:00:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/8] gc: remove redundant check for gc_auto_threshold
Date:   Fri, 15 Mar 2019 16:59:52 +0100
Message-Id: <20190315155959.12390-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314123439.4347-1-avarab@gmail.com>
References: <20190314123439.4347-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Checking gc_auto_threshold in too_many_loose_objects() was added in
17815501a8 ("git-gc --auto: run "repack -A -d -l" as necessary.",
2007-09-17) when need_to_gc() itself was also reliant on
gc_auto_pack_limit before its early return:

    gc_auto_threshold <= 0 && gc_auto_pack_limit <= 0

When that check was simplified to just checking "gc_auto_threshold <=
0" in b14d255ba8 ("builtin-gc.c: allow disabling all auto-gc'ing by
assigning 0 to gc.auto", 2008-03-19) this unreachable code should have
been removed. We only call too_many_loose_objects() from within
need_to_gc() itself, which will return if this condition holds, and in
cmd_gc() which will return before ever getting to "auto_gc &&
too_many_loose_objects()" if "auto_gc && !need_to_gc()" is true
earlier in the function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 020f725acc4..8c2312681ce 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -157,9 +157,6 @@ static int too_many_loose_objects(void)
 	int num_loose = 0;
 	int needed = 0;
 
-	if (gc_auto_threshold <= 0)
-		return 0;
-
 	dir = opendir(git_path("objects/17"));
 	if (!dir)
 		return 0;
-- 
2.21.0.360.g471c308f928

