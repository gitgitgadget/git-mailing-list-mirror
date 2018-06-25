Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D804F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeGPN1j (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42195 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbeGPN1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so7417261pgp.9
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AlBsAx6DODxCf+cxt/Q0mf5YAeSjmnPoIeW7e/3bR6k=;
        b=oCuC61HL1dDwn4pcGWy9ZP7hFjOjd0fkhMqjNm5C+q4A1UtJUZ0Dhkm9jqMTfFKO2W
         4avxLIoJdV/I7AWQShwXiNBq9mVQpUAVC319Qy+gQW6M6InBYGx+k/87s63msLeHLT4X
         dqeTQeklD9pMeQuYcpLc6KV9BH88mVB7r6SwMByVurU4uxfkneNEqq5f6H0q4qQg06j+
         Bt7CMFU4gaQUGvoxPkwE/qbt2fbJRYSG2WOLfgVdM7Lt9A/V++W3ByaCy0T7KgU60xok
         i49xTY3SGQg+7Tg3zRpBYoi9VXIp7P6z1/LcBdngAUAQmR1odJIkTUEVBzR34p0kWJKY
         Gitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AlBsAx6DODxCf+cxt/Q0mf5YAeSjmnPoIeW7e/3bR6k=;
        b=gBs0gPtVw/prhn508JDh+zgauF1NqzdCUFRnW2A2kjh7wP6qK//1iF8UTCprmLyjUf
         6OWvpmteQCN4s2DleO2Va0aBGPT5tVncnbiBLfD6YgzFS7nFhhu0B2ozJF+eIwZ3tatR
         XJBImCQGqFsu6BNI9DUxfkyDUhEXKZV9R7MwLb+ymSDmri09mDb11wVKgTGTcOPYmuUN
         uSKKAXObLhT17/QrMQ501oJD1e8d7h7s+M87fDf3zZpKQFj6ilvrmm4iLefgrnoU182n
         79yX+Z+XVjXWp326hJhwVDLPFQcTOSAyhcqeGVDLEO7Ntsg8tgEWj8gHZOu01CqNhwNu
         0/yw==
X-Gm-Message-State: AOUpUlHmCgzh78Cwv/Lrjo7VQgPaJWkWmvsTYAwevv4Gf/vaSiyWXi0t
        MItI+dNsKzcSBi5HRs09DQimDg==
X-Google-Smtp-Source: AAOMgpcvnu5akR7+MvMQMC31BI97ykBKnRdVfygRUz1s9dgoLezft3IJvq4tosPBK61Sre6SgaK3Vw==
X-Received: by 2002:aa7:82c3:: with SMTP id f3-v6mr4936181pfn.136.1531746017908;
        Mon, 16 Jul 2018 06:00:17 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id x25-v6sm18333956pgv.63.2018.07.16.06.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:17 -0700 (PDT)
Message-Id: <7a6d1cbe12efa0a452a977f1f6bb8c618421040b.1531746010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jun 2018 13:35:03 -0400
Subject: [PATCH 02/16] commit-reach: move ref_newer from remote.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/remote.c |  1 +
 commit-reach.c   | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h   |  2 ++
 http-push.c      |  1 +
 remote.c         | 50 +-------------------------------------------
 remote.h         |  1 -
 6 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c74ee8869..79b032644 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -10,6 +10,7 @@
 #include "refspec.h"
 #include "object-store.h"
 #include "argv-array.h"
+#include "commit-reach.h"
 
 static const char * const builtin_remote_usage[] = {
 	N_("git remote [-v | --verbose]"),
diff --git a/commit-reach.c b/commit-reach.c
index f2e2f7461..a6bc4781a 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,5 +1,10 @@
 #include "cache.h"
+#include "commit.h"
+#include "decorate.h"
 #include "prio-queue.h"
+#include "tree.h"
+#include "revision.h"
+#include "tag.h"
 #include "commit-reach.h"
 
 /* Remember to update object flag allocation in object.h */
@@ -357,3 +362,52 @@ void reduce_heads_replace(struct commit_list **heads)
 	free_commit_list(*heads);
 	*heads = result;
 }
+
+static void unmark_and_free(struct commit_list *list, unsigned int mark)
+{
+	while (list) {
+		struct commit *commit = pop_commit(&list);
+		commit->object.flags &= ~mark;
+	}
+}
+
+int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
+{
+	struct object *o;
+	struct commit *old_commit, *new_commit;
+	struct commit_list *list, *used;
+	int found = 0;
+
+	/*
+	 * Both new_commit and old_commit must be commit-ish and new_commit is descendant of
+	 * old_commit.  Otherwise we require --force.
+	 */
+	o = deref_tag(the_repository, parse_object(the_repository, old_oid),
+		      NULL, 0);
+	if (!o || o->type != OBJ_COMMIT)
+		return 0;
+	old_commit = (struct commit *) o;
+
+	o = deref_tag(the_repository, parse_object(the_repository, new_oid),
+		      NULL, 0);
+	if (!o || o->type != OBJ_COMMIT)
+		return 0;
+	new_commit = (struct commit *) o;
+
+	if (parse_commit(new_commit) < 0)
+		return 0;
+
+	used = list = NULL;
+	commit_list_insert(new_commit, &list);
+	while (list) {
+		new_commit = pop_most_recent_commit(&list, TMP_MARK);
+		commit_list_insert(new_commit, &used);
+		if (new_commit == old_commit) {
+			found = 1;
+			break;
+		}
+	}
+	unmark_and_free(list, TMP_MARK);
+	unmark_and_free(used, TMP_MARK);
+	return found;
+}
diff --git a/commit-reach.h b/commit-reach.h
index 244f48c5f..35ec9f0dd 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -38,4 +38,6 @@ struct commit_list *reduce_heads(struct commit_list *heads);
  */
 void reduce_heads_replace(struct commit_list **heads);
 
+int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
+
 #endif
diff --git a/http-push.c b/http-push.c
index 5eaf551b5..e007cb5a6 100644
--- a/http-push.c
+++ b/http-push.c
@@ -14,6 +14,7 @@
 #include "argv-array.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "commit-reach.h"
 
 
 #ifdef EXPAT_NEEDS_XMLPARSE_H
diff --git a/remote.c b/remote.c
index 26b1fbd9a..f0c23bae4 100644
--- a/remote.c
+++ b/remote.c
@@ -12,6 +12,7 @@
 #include "string-list.h"
 #include "mergesort.h"
 #include "argv-array.h"
+#include "commit-reach.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
@@ -1783,55 +1784,6 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
 	return 1;
 }
 
-static void unmark_and_free(struct commit_list *list, unsigned int mark)
-{
-	while (list) {
-		struct commit *commit = pop_commit(&list);
-		commit->object.flags &= ~mark;
-	}
-}
-
-int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
-{
-	struct object *o;
-	struct commit *old_commit, *new_commit;
-	struct commit_list *list, *used;
-	int found = 0;
-
-	/*
-	 * Both new_commit and old_commit must be commit-ish and new_commit is descendant of
-	 * old_commit.  Otherwise we require --force.
-	 */
-	o = deref_tag(the_repository, parse_object(the_repository, old_oid),
-		      NULL, 0);
-	if (!o || o->type != OBJ_COMMIT)
-		return 0;
-	old_commit = (struct commit *) o;
-
-	o = deref_tag(the_repository, parse_object(the_repository, new_oid),
-		      NULL, 0);
-	if (!o || o->type != OBJ_COMMIT)
-		return 0;
-	new_commit = (struct commit *) o;
-
-	if (parse_commit(new_commit) < 0)
-		return 0;
-
-	used = list = NULL;
-	commit_list_insert(new_commit, &list);
-	while (list) {
-		new_commit = pop_most_recent_commit(&list, TMP_MARK);
-		commit_list_insert(new_commit, &used);
-		if (new_commit == old_commit) {
-			found = 1;
-			break;
-		}
-	}
-	unmark_and_free(list, TMP_MARK);
-	unmark_and_free(used, TMP_MARK);
-	return found;
-}
-
 /*
  * Lookup the upstream branch for the given branch and if present, optionally
  * compute the commit ahead/behind values for the pair.
diff --git a/remote.h b/remote.h
index 45ecc6cef..56fb9cbb2 100644
--- a/remote.h
+++ b/remote.h
@@ -149,7 +149,6 @@ extern struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 				    const struct string_list *server_options);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
-int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
 
 /*
  * Remove and free all but the first of any entries in the input list
-- 
gitgitgadget

