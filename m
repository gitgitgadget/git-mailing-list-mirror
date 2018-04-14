Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B6F81F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeDNPfr (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:35:47 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34366 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeDNPfp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:45 -0400
Received: by mail-lf0-f68.google.com with SMTP id r7-v6so9295083lfr.1
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ywGHgBgwvllc9bx1XB+DzmetPIJ0CdnPgq36mBEen44=;
        b=bJT5e4klgRzRNGYjuxxG1D7sDhq6lI/zohn36QGtWmjmwnuSz5MdppnvYV454aVjWf
         OaVZfEHC7wQ9x/o0Y4fKcwCTZb2M9KC4h10r8O8T5oIyr3rPtDVcVhg9InWUgIJnT4+Y
         V4lkPoMI/VPhHcGzfqpAjVFk630nDrV4QztwM0h8BfJAXUP4T35lW5XJoadcDPp0nL5x
         c6lLpR3FyxRLH6noT9VbNrzrrYGN+pLF6SpmBfS8OEzHZeLBQP8s64yj8bDdJJw9IRwr
         NCjdlXxygTXp2weZbZAmLEmqd8iDejvstmVy4yap2SnHu7yUB14BXvjQB3nB4iRKsMnl
         iMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ywGHgBgwvllc9bx1XB+DzmetPIJ0CdnPgq36mBEen44=;
        b=ayaaTKscaDz6pneUiEsGrXSrnU2AKizyEoAiClKXPOw6qVrsShMlQFRZcbQrxGHekT
         xnrwKrlw0SJDRKiiAFrdSs22mUVg3WA5Zn1T5GnaBnfORAHHY5a1FDiMQYRcXfyRuU3k
         q/OBLRb+ohjouQc5hRT4FqqGaDdlCX2cmIJP7Atu5iMbqunRdqS/5z+n2MFUItEsEMXn
         i8w5s2MuOeB1AvnKQnH35V+KQ/ntkTgg3m8sjN7ndGFaIZJlB4Xsxi6S55BO65VdEihb
         pnPsJe6yGs8o4M/nkvcjy6SczgrL8DnoreGQK0ZmelstWnYMkpEPKsv/s1I4WloR198V
         37Dw==
X-Gm-Message-State: ALQs6tBIpMDOsVL7vipgPP8jV27Ue5EEM2q1gav4/tEckpgNo5KCXqFj
        0knTC13nFFI6Mi3pKgqACh1C4Q==
X-Google-Smtp-Source: AIpwx48xWLqrxKj7coCoUeG0hOTQpr11GdGKzEbMJOpSW/cpGHl3vQgUeVVFa5G79L57V5coj5/58A==
X-Received: by 2002:a19:1122:: with SMTP id g34-v6mr9551077lfi.6.1523720143620;
        Sat, 14 Apr 2018 08:35:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/15] ci: exercise the whole test suite with uncommon code in pack-objects
Date:   Sat, 14 Apr 2018 17:35:13 +0200
Message-Id: <20180414153513.9902-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414153513.9902-1-pclouds@gmail.com>
References: <20180414153513.9902-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some recent optimizations have been added to pack-objects to reduce
memory usage and some code paths are split into two: one for common
use cases and one for rare ones. Make sure the rare cases are tested
with Travis since it requires manual test configuration that is
unlikely to be done by developers.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 ci/run-build-and-tests.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 8190a753de..4b04c75b7f 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -11,7 +11,10 @@ make --jobs=2
 make --quiet test
 if test "$jobname" = "linux-gcc"
 then
-	GIT_TEST_SPLIT_INDEX=yes make --quiet test
+	export GIT_TEST_SPLIT_INDEX=yes
+	export GIT_TEST_FULL_IN_PACK_ARRAY=true
+	export GIT_TEST_OE_SIZE=10
+	make --quiet test
 fi
 
 check_unignored_build_artifacts
-- 
2.17.0.367.g5dd2e386c3

