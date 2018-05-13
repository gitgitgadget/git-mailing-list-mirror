Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23981F406
	for <e@80x24.org>; Sun, 13 May 2018 05:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeEMFwX (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:23 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43908 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeEMFwT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:19 -0400
Received: by mail-lf0-f67.google.com with SMTP id n18-v6so6904760lfh.10
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9q1Vcyo/klVwxvDuug07mBndb/zI6LwlT8ut6iCL0hM=;
        b=HqnBIPLqHQt/dBTRwlygXb60ksIOLgJeJTBWiNEDhZqBZtUSj6NzKAP91JAYwb8R0O
         Dtvx4hJ2oCilS8kBOfVMVurUsLKltIhFBvBweXG953sixXaVMDItMWofQ7mphQhHrOIZ
         B0t9s2ilabpTkI9DaMvKkT+AbNI18XoHQlIVjGM5+EO4ZaVCB+95fg2CO1EW9i2XUGoQ
         sBgBV6Ei77+a2eYv0nJutO7xUwU5FVq6ZsHPq4mF4Bn7FxZJ7ndssZA5wvOwlHbMJNQM
         gR681NwKvXSH8gX9yRr/1UBlpm0HD0tkmdPLdnDdv9GyN35rOehAcnlu5DbhIcptjlXA
         XHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9q1Vcyo/klVwxvDuug07mBndb/zI6LwlT8ut6iCL0hM=;
        b=Z8JO5DM2u+gnjB8kOFPbA6AxxejD2rjjL7SJlc87eGeZcV/aNjbeOnO2PuinvObiIM
         eZU/szlotwgM/oc8i6ARzCbbx7y+edrIau8I0n0hQh+iMaYJO2uONVkBxgTZoGV0vL9A
         jXLKRCTN5eYpT1HnirouD9apBp/qbYiVi1LskBYjmxfheiIwdr0ETnVyGRXsLX8jpCae
         SGp+Xz+7cpeFOfbhPK5Zzr5MS1RPmcJuibTZklqyq2a9rGNSuakuvbfpw++8IoislWT4
         2RoUR+3T8jRNxxwPpEa0Fug9knNjo5NsKSJ1CWXh8udLP63tXihcbXkUKMnUxXUZX7ig
         xg6Q==
X-Gm-Message-State: ALKqPwcGaeQ8ke68y3jSN5jFaLxvbls1Qu7LaQ4RnKsMu+RLcKPjJpvY
        cn3k7tO1bOctsIYSM//lLpkdHw==
X-Google-Smtp-Source: AB8JxZoeO4SDp0j7gz2gfqCRB8VgZU8XCXQcxTe3Gh90UGkSa1TUFBXoVqaDyrsminshgC/Aocu7tg==
X-Received: by 2002:a2e:2283:: with SMTP id i125-v6mr2069306lji.47.1526190737718;
        Sat, 12 May 2018 22:52:17 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 03/14] blame: use commit-slab for blame suspects instead of commit->util
Date:   Sun, 13 May 2018 07:51:57 +0200
Message-Id: <20180513055208.17952-4-pclouds@gmail.com>
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
 blame.c         | 42 +++++++++++++++++++++++++++++++-----------
 blame.h         |  2 ++
 builtin/blame.c |  2 +-
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/blame.c b/blame.c
index 78c9808bd1..18e8bd996a 100644
--- a/blame.c
+++ b/blame.c
@@ -6,6 +6,24 @@
 #include "diffcore.h"
 #include "tag.h"
 #include "blame.h"
+#include "commit-slab.h"
+
+define_commit_slab(blame_suspects, struct blame_origin *);
+static struct blame_suspects blame_suspects;
+
+struct blame_origin *get_blame_suspects(struct commit *commit)
+{
+	struct blame_origin **result;
+
+	result = blame_suspects_peek(&blame_suspects, commit);
+
+	return result ? *result : NULL;
+}
+
+static void set_blame_suspects(struct commit *commit, struct blame_origin *origin)
+{
+	*blame_suspects_at(&blame_suspects, commit) = origin;
+}
 
 void blame_origin_decref(struct blame_origin *o)
 {
@@ -15,12 +33,12 @@ void blame_origin_decref(struct blame_origin *o)
 			blame_origin_decref(o->previous);
 		free(o->file.ptr);
 		/* Should be present exactly once in commit chain */
-		for (p = o->commit->util; p; l = p, p = p->next) {
+		for (p = get_blame_suspects(o->commit); p; l = p, p = p->next) {
 			if (p == o) {
 				if (l)
 					l->next = p->next;
 				else
-					o->commit->util = p->next;
+					set_blame_suspects(o->commit, p->next);
 				free(o);
 				return;
 			}
@@ -41,8 +59,8 @@ static struct blame_origin *make_origin(struct commit *commit, const char *path)
 	FLEX_ALLOC_STR(o, path, path);
 	o->commit = commit;
 	o->refcnt = 1;
-	o->next = commit->util;
-	commit->util = o;
+	o->next = get_blame_suspects(commit);
+	set_blame_suspects(commit, o);
 	return o;
 }
 
@@ -54,13 +72,13 @@ static struct blame_origin *get_origin(struct commit *commit, const char *path)
 {
 	struct blame_origin *o, *l;
 
-	for (o = commit->util, l = NULL; o; l = o, o = o->next) {
+	for (o = get_blame_suspects(commit), l = NULL; o; l = o, o = o->next) {
 		if (!strcmp(o->path, path)) {
 			/* bump to front */
 			if (l) {
 				l->next = o->next;
-				o->next = commit->util;
-				commit->util = o;
+				o->next = get_blame_suspects(commit);
+				set_blame_suspects(commit, o);
 			}
 			return blame_origin_incref(o);
 		}
@@ -478,7 +496,7 @@ static void queue_blames(struct blame_scoreboard *sb, struct blame_origin *porig
 		porigin->suspects = blame_merge(porigin->suspects, sorted);
 	else {
 		struct blame_origin *o;
-		for (o = porigin->commit->util; o; o = o->next) {
+		for (o = get_blame_suspects(porigin->commit); o; o = o->next) {
 			if (o->suspects) {
 				porigin->suspects = sorted;
 				return;
@@ -525,7 +543,7 @@ static struct blame_origin *find_origin(struct commit *parent,
 	const char *paths[2];
 
 	/* First check any existing origins */
-	for (porigin = parent->util; porigin; porigin = porigin->next)
+	for (porigin = get_blame_suspects(parent); porigin; porigin = porigin->next)
 		if (!strcmp(porigin->path, origin->path)) {
 			/*
 			 * The same path between origin and its parent
@@ -1550,7 +1568,7 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 
 	while (commit) {
 		struct blame_entry *ent;
-		struct blame_origin *suspect = commit->util;
+		struct blame_origin *suspect = get_blame_suspects(commit);
 
 		/* find one suspect to break down */
 		while (suspect && !suspect->suspects)
@@ -1752,6 +1770,8 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 	struct commit *final_commit = NULL;
 	enum object_type type;
 
+	init_blame_suspects(&blame_suspects);
+
 	if (sb->reverse && sb->contents_from)
 		die(_("--contents and --reverse do not blend well."));
 
@@ -1815,7 +1835,7 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 	}
 
 	if (is_null_oid(&sb->final->object.oid)) {
-		o = sb->final->util;
+		o = get_blame_suspects(sb->final);
 		sb->final_buf = xmemdupz(o->file.ptr, o->file.size);
 		sb->final_buf_size = o->file.size;
 	}
diff --git a/blame.h b/blame.h
index a6c915c277..2092f9529c 100644
--- a/blame.h
+++ b/blame.h
@@ -172,4 +172,6 @@ extern void setup_scoreboard(struct blame_scoreboard *sb, const char *path, stru
 
 extern struct blame_entry *blame_entry_prepend(struct blame_entry *head, long start, long end, struct blame_origin *o);
 
+extern struct blame_origin *get_blame_suspects(struct commit *commit);
+
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index db38c0b307..969572810d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -457,7 +457,7 @@ static void output(struct blame_scoreboard *sb, int option)
 			struct commit *commit = ent->suspect->commit;
 			if (commit->object.flags & MORE_THAN_ONE_PATH)
 				continue;
-			for (suspect = commit->util; suspect; suspect = suspect->next) {
+			for (suspect = get_blame_suspects(commit); suspect; suspect = suspect->next) {
 				if (suspect->guilty && count++) {
 					commit->object.flags |= MORE_THAN_ONE_PATH;
 					break;
-- 
2.17.0.705.g3525833791

