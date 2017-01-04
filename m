Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1D520754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966926AbdADSFf (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:05:35 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:32920 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761457AbdADSEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:30 -0500
Received: by mail-pg0-f53.google.com with SMTP id g1so190659227pgn.0
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YAeaHHSkOmPbKVBRh1ojNXYPQuCOW7LCuvu23hQBUq4=;
        b=C5E3PHiw454I0grdHE+LviL4fGuJsB7GqH1IXi8GrahICLMja5ytfClj4EsjgvQSGd
         V2HF+jxPozFJu6zKuPPOIyY7E12AVI1y98KCU4o7pOtsP6cUdQ7P5zVzFe7BNNrbEkhW
         hofwTlArKY18Xv+Aisis13gHTxa/k0GZweXTgFJcKa9hzlkQoKU2R5yVoWBVHJn+Nm5x
         2eMZJa7opDXl2zVBMXlHXXVJmIMtqAhPmuJLN4YF+yYXTRItR2QoBDTYVwx+/7qD98qh
         iItXfD4parbn98C+LpomDN6nj8oOnjEJ/GXKWNvss2W5T1aFeD8fi/ltLtqSavsz54VL
         1Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YAeaHHSkOmPbKVBRh1ojNXYPQuCOW7LCuvu23hQBUq4=;
        b=UF+LaHkOuyLvbdfDWSERBtcV30qRuLgB5LrmxWeHc/+C8JAfiecz2HsmerBMxPmoBd
         08A+GeEVoiq+DE93TccfvxQeeiX2JLEzAZdm7HQXqB6fE0n7cze3MqjL/R71ofJmbPPu
         nxC/AWveZ3kt8YCThkKJIfAXl6UmMZofDVROxcRAkkDXmOJ3oRtGKFaWYHhayO4P/qNa
         LhJM6kUueRx0k+dBwnDZ2XvvDdkybffWw0U6oIJoHIm/k6gFUmLiLTRwy1+WAWbLubTC
         3/pYNv0QdTeCk5vKPKWMQ/HMw0oBBs4ul8k1Z9WsmrOSuwNmlXZq4Bz+9FKVwk2Ue6xX
         eRhw==
X-Gm-Message-State: AIkVDXLtaphOVtgEulR7cWoMs4WgXoaRUAdxaMvAToM3U8rDQgm1QoCyBwxOV8AUoiEZEV5v
X-Received: by 10.98.103.201 with SMTP id t70mr63337398pfj.99.1483553069415;
        Wed, 04 Jan 2017 10:04:29 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:28 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 07/16] pathspec: remove unused variable from unsupported_magic
Date:   Wed,  4 Jan 2017 10:04:02 -0800
Message-Id: <20170104180411.150000-8-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Removed unused variable 'n' from the 'unsupported_magic()' function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index b8faa8f46..b9a3819d6 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -333,8 +333,8 @@ static void NORETURN unsupported_magic(const char *pattern,
 				       unsigned short_magic)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int i, n;
-	for (n = i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+	int i;
+	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 		const struct pathspec_magic *m = pathspec_magic + i;
 		if (!(magic & m->bit))
 			continue;
@@ -344,7 +344,6 @@ static void NORETURN unsupported_magic(const char *pattern,
 			strbuf_addf(&sb, "'%c'", m->mnemonic);
 		else
 			strbuf_addf(&sb, "'%s'", m->name);
-		n++;
 	}
 	/*
 	 * We may want to substitute "this command" with a command
-- 
2.11.0.390.gc69c2f50cf-goog

