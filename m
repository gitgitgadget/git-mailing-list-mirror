Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1765B20248
	for <e@80x24.org>; Thu, 14 Mar 2019 12:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfCNMe4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 08:34:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50553 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCNMez (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 08:34:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id x7so2803618wmj.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 05:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=29pkbaKIcEZV76rA9luir7yhyIu1NXmLODyRRnt9pU0=;
        b=LWFqaRMnChJFKBQovbBjPLHZDZdKjgsvwcIouomX7f9SuQacF7QNpHHasickK0KOuk
         FThkiHpS36K/mE7kBfSWlD0TwkrJBXzx5lK1WWbdX/pp6UK99dKCoYr26+PNr96XEqvq
         aeEPoNnYSe+NECRQSh2x31+Qjh5IGhufQLjYI4ksRQac/A2o/rKZO/HgpMo7x+Zr8+jd
         NyWmZFCfefSvpPc7DiQqTYWGGzkW0ZMv7UQkw0EhJrlsUTF0PHP2zrAtR9RV9a0sfmpq
         ug48CEF95UxeZh/98TicwGX599FlafsRIXHXY6JZy8Rbqxe23tVXFjsCVM8cdonTAPj9
         +8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29pkbaKIcEZV76rA9luir7yhyIu1NXmLODyRRnt9pU0=;
        b=OjlS+nrMCYlhZRwtwtWIzOeGb6Ne8QxHtELZOnWWd9pZyU5+n9SyZKAsViCpjbui8W
         clXhQduiaBw9xFZYV9b2/wODm/vyE2mumpQF5C9uyjnO48CNnltjIjrX3FhZ/aZbgKYC
         QwwgD8e+Ras4ArT0tzk1iiKNfy/+DO9rs7ofrco2EBOZGe1HQ8cqsEmMzpyE4Otdyjn1
         ZJg2ilctvUKFJ04vyUk4jEpkIqRPrSDz4BHRTTGGGgMkhnVfibzs0nkDy10cjvVoaqdz
         4cFpPQnEfuFf8WYPhJgSAjAa7XrqCa5J5f1p94H1bRn/Sux1ixnHIWnpwGXifi5YPPz6
         JjmQ==
X-Gm-Message-State: APjAAAW4K+EeZ0Srr8NabldIgITWPjeeldZ8HHYQImVR100tnlzrE3hb
        GBdWIWMOLxM8EOdXXE6dQXAea6yi+uA=
X-Google-Smtp-Source: APXvYqzmWta0wiJnMCynBX9YrnNkoJIAqpY+SyPwGPqNEN6q0vx7SY10ICd36Ok2DvVusLIwcuH3+Q==
X-Received: by 2002:a1c:7a1a:: with SMTP id v26mr2296097wmc.129.1552566892890;
        Thu, 14 Mar 2019 05:34:52 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p6sm42374095wre.63.2019.03.14.05.34.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 05:34:51 -0700 (PDT)
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
Subject: [PATCH v2 1/7] gc: remove redundant check for gc_auto_threshold
Date:   Thu, 14 Mar 2019 13:34:33 +0100
Message-Id: <20190314123439.4347-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190313235439.30439-1-avarab@gmail.com>
References: <20190313235439.30439-1-avarab@gmail.com>
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
index 020f725acc..8c2312681c 100644
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

