Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4941F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 11:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeKLVh0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 16:37:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35185 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeKLVh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 16:37:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so3980250pgu.2
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 03:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JsIRbTbXKE/XkRkjcllmf+EFZM+L1NFFuqC+iypS11o=;
        b=T/qF5+v0kSvdtRBW7G+bHsovIg9p10riqocTL1I9vJdTd585ElptCxggHth+82kqgI
         JQ7RUZdSwc8jkU+PavCkQZahS/UN8u9adnLr3+boMTR43UXrQgBo/SY19Krr1gxhUalI
         6y7JNyNX6fdk3HKcWjM7XBGu4CxCHqgK/8AmJX4agV0x1PvVf3FjWZU1qOt3ewonvmEv
         6w9kk07lkBWroXCA8lFgtfBld0gQqwKhGeBhLkNaKgDvJGXOn+eGhp5Ogngzk0frRf0e
         eAewzbGEQfw6X0XLsOdYOCaq7Sx0KDZPlRK8WlzrQ0356OPl2Ehp8itSDY+nRFqP7hmd
         M33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JsIRbTbXKE/XkRkjcllmf+EFZM+L1NFFuqC+iypS11o=;
        b=pAGBnsPHkskc49zmvUOUPLCWMbJdutAOgkVZ0sEo/PNIWz8a7zNZ1/8Q6CSf5iFKNA
         sWVigN8ar8A5CRcYYEPjpVPt/u7RvzBSAE+e6hy74Of7QffggjiOuVd2lcbV0X696MUa
         hyHvHbIZtRZZ4g+1bhUMwnCuSl8FUqcpI90rkm+R/koZW3EWYT5XQm2LNdl82CooaA3F
         px1JxV7nlDCfSskEBDDEorfMbcdRxq2OcG1OgIDYhoKK2DPhzcpu4PR6zfG2J2MVe454
         jnUvDXS4bttAApwA2YB3ecqR6dI61mUUBdIULyOn5Zi38h7vvao1HhP63ADIfdWoW7jX
         nkog==
X-Gm-Message-State: AGRZ1gL1vb5lrY6Hcnx7THg1YPYrFelsESrIHCteFRDnu00MyG2OP7cH
        JjUvhQ/iacKFWqldBdFzKIo2ouCZ
X-Google-Smtp-Source: AJdET5dZJw4T4zXnVqti7XNIez/0p9A8nFF1+RI9a3UBKUqSWkgJ0f6okr9CtluxC+yunVZGAsFK8w==
X-Received: by 2002:a62:2ad6:: with SMTP id q205-v6mr584462pfq.152.1542023072018;
        Mon, 12 Nov 2018 03:44:32 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id t21sm6066823pgg.24.2018.11.12.03.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 03:44:31 -0800 (PST)
Date:   Mon, 12 Nov 2018 03:44:31 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 11:44:25 GMT
Message-Id: <db963b20941b524199e51b9da0b59269db57c860.1542023066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.72.v2.git.gitgitgadget@gmail.com>
References: <pull.72.git.gitgitgadget@gmail.com>
        <pull.72.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/3] rebase: prepare reset_head() for more flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Currently, we only accept the flag indicating whether the HEAD should be
detached not. In the next commit, we want to introduce another flag: to
toggle between emulating `reset --hard` vs `checkout -q`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e173654d56..074594cf10 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -522,10 +522,13 @@ finished_rebase:
 
 #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
 
+#define RESET_HEAD_DETACH (1<<0)
+
 static int reset_head(struct object_id *oid, const char *action,
-		      const char *switch_to_branch, int detach_head,
+		      const char *switch_to_branch, unsigned flags,
 		      const char *reflog_orig_head, const char *reflog_head)
 {
+	unsigned detach_head = flags & RESET_HEAD_DETACH;
 	struct object_id head_oid;
 	struct tree_desc desc;
 	struct lock_file lock = LOCK_INIT;
@@ -1500,8 +1503,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 "it...\n"));
 
 	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
-	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1,
-	    NULL, msg.buf))
+	if (reset_head(&options.onto->object.oid, "checkout", NULL,
+		       RESET_HEAD_DETACH, NULL, msg.buf))
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
 
-- 
gitgitgadget

