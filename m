Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C8D1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeA2Wit (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:49 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:51128 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeA2Wio (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:44 -0500
Received: by mail-vk0-f74.google.com with SMTP id z207so5821292vkd.17
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=0fTyQJ5LQp7QXze4UwmhoCk7v6Yc8uJnxm7mg+iQQpQ=;
        b=dr4fzUy4psGBtbwEXjvhCOd8vkOEWEOms1ok4ruxs8KOe5IaGWWpewHO4j5P9nxOkh
         eFSq5QTDVfpchjT1MVGE2ZKnB2FXjox9e0r05Ce6PeK9O3TBilcpGr6TK+LUB9NwHicR
         5iJmon4j9VhC1I3d/WVdZGz3TCpvUSOMsIjpDmnEgX/6CXB7BTHwrqJKeFMnYhhdvdgf
         8908Q2dohOIBWaK5QdnbAyPcIibYK6kpExLMA44esJ8jdmOrh4o3UmbLmrJ4gXzpDJH4
         pH/m7auX4TBfwAlPEUFuGlNnBezC2xITVNvCKGYbDsm61pCQ8bxjz47mvf48dZ3tdwdS
         if3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=0fTyQJ5LQp7QXze4UwmhoCk7v6Yc8uJnxm7mg+iQQpQ=;
        b=CiK2c8d4lLLrHL66VrpG9JK0bte+bT8s0JxFgXyRfz7H9d/gz573FleuKdxW7lDaUu
         l0XGQmfNFdbbAKP0ebW9otyn4D8WuLtNfYs87FSWnFD4cWc4OPH4mpZGRxaPjstvtfu1
         P+S1zTgdnedNVm+bevM8ne40QBz/Vn8rCfhiFTLgtNfYKqpT0Gv2z364GapqcTworcCt
         5n5TDhaUTWDr4p5APRtcJSdu+4Y12AkBCXlkUDNw+kGOYTnPdt6W+apOiE0jUApGZ8Jz
         CWuhVWx4eXZOjXGomMS9ldXSrjmHwTX24cT6C1CP1j4QPKeReaVdrwmwgnMhIcRsrdgE
         0P3Q==
X-Gm-Message-State: AKwxytctrF2QMrnXbQ6M4F/czjPtTu0nzkDxTxbDLyrOPxBITCft+1bW
        ZIp+f8x29ga45R9yodcIgbp6UTW4gQn5V4yv5113zxIeBFGhUvl3GVrCQ4BEF/IKAzYE3LjA30q
        c8mNpciOoB5yr2aromNwTpl4/hpNFyCgqzvbhT0x00tgI8afMjOFcf8a2Jw==
X-Google-Smtp-Source: AH8x226COl5E4nF8BXzIW6ZRzWvkupE3bKb8M+GR/Ew+e8GqRF+To4pCjo+ebfiyL3O6d8gmhPBygWWYmvI=
MIME-Version: 1.0
X-Received: by 10.176.7.33 with SMTP id h30mr12325322uah.70.1517265524069;
 Mon, 29 Jan 2018 14:38:44 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:18 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-28-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 27/37] submodule: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 14 +++++++-------
 submodule.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index cd18400e8..244c3c21b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -590,7 +590,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule)
 {
-	const struct object_id *old = the_hash_algo->empty_tree, *new = the_hash_algo->empty_tree;
+	const struct object_id *old = the_hash_algo->empty_tree, *new_oid = the_hash_algo->empty_tree;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -607,7 +607,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	if (left)
 		old = one;
 	if (right)
-		new = two;
+		new_oid = two;
 
 	cp.git_cmd = 1;
 	cp.dir = path;
@@ -638,7 +638,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	 * haven't yet been committed to the submodule yet.
 	 */
 	if (!(dirty_submodule & DIRTY_SUBMODULE_MODIFIED))
-		argv_array_push(&cp.args, oid_to_hex(new));
+		argv_array_push(&cp.args, oid_to_hex(new_oid));
 
 	prepare_submodule_repo_env(&cp.env_array);
 	if (start_command(&cp))
@@ -1579,7 +1579,7 @@ static void submodule_reset_index(const char *path)
  */
 int submodule_move_head(const char *path,
 			 const char *old,
-			 const char *new,
+			 const char *new_head,
 			 unsigned flags)
 {
 	int ret = 0;
@@ -1660,7 +1660,7 @@ int submodule_move_head(const char *path,
 	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
 		argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
 
-	argv_array_push(&cp.args, new ? new : EMPTY_TREE_SHA1_HEX);
+	argv_array_push(&cp.args, new_head ? new_head : EMPTY_TREE_SHA1_HEX);
 
 	if (run_command(&cp)) {
 		ret = -1;
@@ -1668,7 +1668,7 @@ int submodule_move_head(const char *path,
 	}
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
-		if (new) {
+		if (new_head) {
 			child_process_init(&cp);
 			/* also set the HEAD accordingly */
 			cp.git_cmd = 1;
@@ -1677,7 +1677,7 @@ int submodule_move_head(const char *path,
 
 			prepare_submodule_repo_env(&cp.env_array);
 			argv_array_pushl(&cp.args, "update-ref", "HEAD",
-					 "--no-deref", new, NULL);
+					 "--no-deref", new_head, NULL);
 
 			if (run_command(&cp)) {
 				ret = -1;
diff --git a/submodule.h b/submodule.h
index b9b7ef003..9589f1312 100644
--- a/submodule.h
+++ b/submodule.h
@@ -117,7 +117,7 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 #define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
 extern int submodule_move_head(const char *path,
 			       const char *old,
-			       const char *new,
+			       const char *new_head,
 			       unsigned flags);
 
 /*
-- 
2.16.0.rc1.238.g530d649a79-goog

