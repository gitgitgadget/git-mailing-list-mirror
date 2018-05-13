Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005591F406
	for <e@80x24.org>; Sun, 13 May 2018 05:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbeEMFwb (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:31 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43911 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeEMFwX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:23 -0400
Received: by mail-lf0-f68.google.com with SMTP id n18-v6so6904831lfh.10
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eq9SuG4kTFNhxO9wYANoiV2gas6hXXRkWtlOB/ZBM4=;
        b=ivDWMxpTx+SKa5g6Qiks2v9023r6Ni6qkBXHy2NX0Cu7okue04r0m6ffrQ2pOdUpxC
         NnFDX7KHpw6Xwdg4Rx/JWXeASCVrziyPwjm6QsT0CGVs+31rp01LHKIOzihZt2Rm3ZNJ
         qDuzQwEa2Kyiyi6kA/110WyejaZ7DmqsVJ9YhPh6VPYt6+pmObOv3iwi6MNeUEQU+/jW
         Ru2vUvla7QFug8Q0MYc1EJakMUW5W+6liAzDRYE1QBQ+bpRVnCWku/WRyaZbnKlu4ihJ
         B3ZsOU4a9Sy/NPYxn3Lo33bWEvWPXwpFBd3u4raBpTw+pOwtI4VgClkv7bMPBf8OCgF6
         hgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eq9SuG4kTFNhxO9wYANoiV2gas6hXXRkWtlOB/ZBM4=;
        b=CYNTVO8ryQCES38tCJ8rPHuBjGiMIM4EldtKbaesB+Eyf7l2EO/7IixZVjvmsbhkmL
         BmFFmuVOWJRGnLvdOIs4uulxFuF9hUXexlhKZm3zDDQDUF05MM2TcjE2JZqHAFpQ7vOz
         EebRKHM83R3UA3Vb3ebdlSTrVPKvrGyE3xeT8LuoVx0sb5wgYvL+5d2OZD3L2d+SXqo/
         oqI5VbofLAhiH53l9rBMFdr/MlV69VfCho7vIXPufOPNCQV++yfUL/bm3p2qkwgyO4k8
         PSu2F+SJmjg7saYucY1KlltUVLrf3Jn4N5weEaCGquFT3mbG0np54beTXVrk2Da/kzI3
         QjtQ==
X-Gm-Message-State: ALKqPwfalsWi+pY9dAmvFmueHhshBMHOwfEuIrMyj8f85Ag+SuxfDRAy
        DUfd6u+gWCcH94WOAPDZ52NbUw==
X-Google-Smtp-Source: AB8JxZpQMtaShAShQ+lDLwR326CNpG5Y/yTMrSXnJZvwACF9hDnODdeMDa36qNHGnpoPVV5ZP6qN7A==
X-Received: by 2002:a2e:4dd6:: with SMTP id c83-v6mr1893911ljd.126.1526190740846;
        Sat, 12 May 2018 22:52:20 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:20 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 06/14] sequencer.c: use commit-slab to mark seen commits
Date:   Sun, 13 May 2018 07:52:00 +0200
Message-Id: <20180513055208.17952-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513055208.17952-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180513055208.17952-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sequencer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4ce5120e77..6b785c6c5f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -23,6 +23,7 @@
 #include "hashmap.h"
 #include "notes-utils.h"
 #include "sigchain.h"
+#include "commit-slab.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -3160,6 +3161,7 @@ static enum check_level get_missing_commit_check_level(void)
 	return CHECK_IGNORE;
 }
 
+define_commit_slab(commit_seen, uint8_t);
 /*
  * Check if the user dropped some commits by mistake
  * Behaviour determined by rebase.missingCommitsCheck.
@@ -3173,6 +3175,9 @@ int check_todo_list(void)
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf missing = STRBUF_INIT;
 	int advise_to_edit_todo = 0, res = 0, i;
+	struct commit_seen commit_seen;
+
+	init_commit_seen(&commit_seen);
 
 	strbuf_addstr(&todo_file, rebase_path_todo());
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file.buf) < 0) {
@@ -3189,7 +3194,7 @@ int check_todo_list(void)
 	for (i = 0; i < todo_list.nr; i++) {
 		struct commit *commit = todo_list.items[i].commit;
 		if (commit)
-			commit->util = (void *)1;
+			*commit_seen_at(&commit_seen, commit) = 1;
 	}
 
 	todo_list_release(&todo_list);
@@ -3205,11 +3210,11 @@ int check_todo_list(void)
 	for (i = todo_list.nr - 1; i >= 0; i--) {
 		struct todo_item *item = todo_list.items + i;
 		struct commit *commit = item->commit;
-		if (commit && !commit->util) {
+		if (commit && !*commit_seen_at(&commit_seen, commit)) {
 			strbuf_addf(&missing, " - %s %.*s\n",
 				    short_commit_name(commit),
 				    item->arg_len, item->arg);
-			commit->util = (void *)1;
+			*commit_seen_at(&commit_seen, commit) = 1;
 		}
 	}
 
@@ -3235,6 +3240,7 @@ int check_todo_list(void)
 		"The possible behaviours are: ignore, warn, error.\n\n"));
 
 leave_check:
+	clear_commit_seen(&commit_seen);
 	strbuf_release(&todo_file);
 	todo_list_release(&todo_list);
 
-- 
2.17.0.705.g3525833791

