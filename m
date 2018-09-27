Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C341C1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeI1EVF (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:21:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51438 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeI1EVE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:21:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id y25-v6so318184wmi.1
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07PXM0yIsvldy3kRfG6nP6u9MUQvCcY0GvYWM8JiAKQ=;
        b=f1vIb8nyFpOUoP5Nc1Q4WkJpM9iU8Rmm2QwSr4ES27Lu4pxbYLU0SivQxNR5W8EiPI
         eh8CAJ/BVKhNZYDD6q6Up351kwygKzwxBwxm94zPW1ZJ3opOH0yQ4LFUFzERXKLzyv6N
         tUVIC1WpBRxEh5kSx5B84mNi+tz/adF5FU5FyvpQ0j7Pm4hs6Hp6b/me+pS2ZnBro9A8
         uDVUbVsB8bWr1LJTTsEpkicD142YE+6bdAKIPuXKblHKdbtc+lVbozBWXwcKDO9DlMJ6
         AsfuVM5Ha0AHnR5b9M5GGwuL3yza3UP+m65nxcqtSV8o3Uz0kyRrqESh7L5Y+vuxHf54
         A7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07PXM0yIsvldy3kRfG6nP6u9MUQvCcY0GvYWM8JiAKQ=;
        b=QV+KbY03NsYUcQQNv9bed11TepKTk0sWCxD/qQ5qbOAKn1kIjFjPKYGbqRDZfY1PBd
         /Vjlp6Y2FT2LWYcYKYcZPyhhgJ2+y3j0BNTjIy/hlNzHux/pSJe0Ut2VdNXFF8bTafyh
         Ihv55xd2WJgV93X8OqGA5Ygg/BOzYaEcph3SYIpXKkt+r+bwhNZtCdYwdbTSQb9sN3NE
         gQzIxGupGZFowqQM0a53GXiiiI0aR4VqJmY9GlUd/KFLlEMVwaustFBRawjTE2Hn20oK
         SUU3xIuPtgBWcrR6FKSsCm5AWtnlL6jpJV8ZK0ysd6JRb6iuDTKzeCwm1f32rOgHXRZK
         R75g==
X-Gm-Message-State: ABuFfohsov4nyebbiMHLy0bD2AVjRkLMHn8p+qqY0WuZ2LGe7QFF0mZm
        gjHjCTM6htL1L0uKPRPBHIc+smFs
X-Google-Smtp-Source: ACcGV63Tn4UZm5sXXCgNvPVyMaWjc1Xax4I2sBQe0PaQg91d/cdO9QjKsVl52+vQ06DExBPiDEwejQ==
X-Received: by 2002:a1c:c2c3:: with SMTP id s186-v6mr342683wmf.16.1538085638290;
        Thu, 27 Sep 2018 15:00:38 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-28-140.w86-222.abo.wanadoo.fr. [86.222.27.140])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm243153wmf.25.2018.09.27.15.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:00:37 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v8 09/20] sequencer: change the way skip_unnecessary_picks() returns its result
Date:   Thu, 27 Sep 2018 23:55:59 +0200
Message-Id: <20180927215610.32210-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927215610.32210-1-alban.gruin@gmail.com>
References: <20180828121045.14933-1-alban.gruin@gmail.com>
 <20180927215610.32210-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of skip_unnecessary_picks() printing its result to stdout, it
returns it into a struct object_id, as the rewrite of complete_action()
(to come in the next commit) will need it.

rebase--helper then is modified to fit this change.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
The changes are due to conflict resolution, no real changes otherwise.

 builtin/rebase--helper.c | 10 ++++++++--
 sequencer.c              | 13 ++++++-------
 sequencer.h              |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 313092c465..bed3dd2b95 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -90,8 +90,14 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!transform_todos(flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
-	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
-		return !!skip_unnecessary_picks();
+	if (command == SKIP_UNNECESSARY_PICKS && argc == 1) {
+		struct object_id oid;
+		int ret = skip_unnecessary_picks(&oid);
+
+		if (!ret)
+			puts(oid_to_hex(&oid));
+		return !!ret;
+	}
 	if (command == REARRANGE_SQUASH && argc == 1)
 		return !!rearrange_squash();
 	if (command == ADD_EXEC && argc == 2)
diff --git a/sequencer.c b/sequencer.c
index c7f930ab9c..f2cda5593d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4593,17 +4593,17 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
 }
 
 /* skip picking commits whose parents are unchanged */
-int skip_unnecessary_picks(void)
+int skip_unnecessary_picks(struct object_id *output_oid)
 {
 	const char *todo_file = rebase_path_todo();
 	struct strbuf buf = STRBUF_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
-	struct object_id onto_oid, *oid = &onto_oid, *parent_oid;
+	struct object_id *parent_oid;
 	int fd, i;
 
 	if (!read_oneliner(&buf, rebase_path_onto(), 0))
 		return error(_("could not read 'onto'"));
-	if (get_oid(buf.buf, &onto_oid)) {
+	if (get_oid(buf.buf, output_oid)) {
 		strbuf_release(&buf);
 		return error(_("need a HEAD to fixup"));
 	}
@@ -4633,9 +4633,9 @@ int skip_unnecessary_picks(void)
 		if (item->commit->parents->next)
 			break; /* merge commit */
 		parent_oid = &item->commit->parents->item->object.oid;
-		if (!oideq(parent_oid, oid))
+		if (!oideq(parent_oid, output_oid))
 			break;
-		oid = &item->commit->object.oid;
+		oidcpy(output_oid, &item->commit->object.oid);
 	}
 	if (i > 0) {
 		int offset = get_item_line_offset(&todo_list, i);
@@ -4664,11 +4664,10 @@ int skip_unnecessary_picks(void)
 
 		todo_list.current = i;
 		if (is_fixup(peek_command(&todo_list, 0)))
-			record_in_rewritten(oid, peek_command(&todo_list, 0));
+			record_in_rewritten(output_oid, peek_command(&todo_list, 0));
 	}
 
 	todo_list_release(&todo_list);
-	printf("%s\n", oid_to_hex(oid));
 
 	return 0;
 }
diff --git a/sequencer.h b/sequencer.h
index 5fa89edd3b..6b0885db57 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -96,7 +96,7 @@ int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
-int skip_unnecessary_picks(void);
+int skip_unnecessary_picks(struct object_id *output_oid);
 int rearrange_squash(void);
 
 extern const char sign_off_header[];
-- 
2.19.0

