Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037DD20281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969125AbdEXFQX (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:23 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33525 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969114AbdEXFQU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:20 -0400
Received: by mail-oi0-f66.google.com with SMTP id h4so31065850oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UHrktWVBfqUGwJ7SZnNS6boVU2IkOhek2YL6ApAmb2Y=;
        b=Ob/xF/C8AOr0GzUNOBbvp8W2bom309tT/NNLaDlUPkX9u/caQ4UNlRnP1hCI/qDu07
         22pyk2lIMDqinwY78xuV6LHDvp/AOVnVyR5hMi2oGBgj2TEfQMNE4ywT8Rol+AxSsaYf
         V8G3lFPS7pkwouJeCwBVVJSP91Na91k+eGqohO5rBIJLdi3SkBI37c2eFTLtMcmet7wz
         9NEHejV6Xi1aAJrsK1XgBjN6J8MVhHV0S3R05gU+HbkaRjrWXtfnXoK4l7v437jiW0Ud
         jz8Zyey8lUtZPe4+EfmIYMECYpjdVx3vOvzzkg/F1tpMyyQOC+1X5xx9FLPNOfyhj0zy
         OHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UHrktWVBfqUGwJ7SZnNS6boVU2IkOhek2YL6ApAmb2Y=;
        b=X2A3vItGqp5TNi7NeqW6Uuhx9IO4QKJr3UpfmjKObBKqbkgZrHr5PLpQamsxJa3wOH
         6mzcPhezf7PNX4BmtIP2tRQJjCGfbUb9oUIjsE9+4loob79m4eJmQvuzE7IxC7AdOht7
         +etWEpV8IMJIwraZSl49nt///mOG1C8TKDINb9JTjwNgsLkU7gWfOYX8Zc5iPuNnxDVe
         duUvFLpT/2k8oK79HZCfltTeUWcxwLRfG6cR0qM6PCSjKc6f5d0rQgs9uBK3qOgtE1zv
         ulCz7RrElge0NeVHjpZ3iM1dq6rSyFKNtlwUjX6PJ9gZQWB3tHyq0ItSjCSQ8E7tTe4K
         PMrQ==
X-Gm-Message-State: AODbwcDYdBzjkN8RaCJOBYy2ZIltk9aaYDlyazAecXdsa3iI3LIqTAce
        pXrdpzsddOZvQw==
X-Received: by 10.157.80.47 with SMTP id a47mr3907061oth.220.1495602979174;
        Tue, 23 May 2017 22:16:19 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:18 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 03/29] blame: remove unused parameters
Date:   Wed, 24 May 2017 00:15:11 -0500
Message-Id: <20170524051537.29978-4-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clean up blame code before moving it into libgit

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index fbd757e..3529f01 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -449,9 +449,7 @@ static struct origin *make_origin(struct commit *commit, const char *path)
  * Locate an existing origin or create a new one.
  * This moves the origin to front position in the commit util list.
  */
-static struct origin *get_origin(struct scoreboard *sb,
-				 struct commit *commit,
-				 const char *path)
+static struct origin *get_origin(struct commit *commit, const char *path)
 {
 	struct origin *o, *l;
 
@@ -499,8 +497,7 @@ static int fill_blob_sha1_and_mode(struct origin *origin)
  * We have an origin -- check if the same path exists in the
  * parent and return an origin structure to represent it.
  */
-static struct origin *find_origin(struct scoreboard *sb,
-				  struct commit *parent,
+static struct origin *find_origin(struct commit *parent,
 				  struct origin *origin)
 {
 	struct origin *porigin;
@@ -543,7 +540,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 
 	if (!diff_queued_diff.nr) {
 		/* The path is the same as parent */
-		porigin = get_origin(sb, parent, origin->path);
+		porigin = get_origin(parent, origin->path);
 		oidcpy(&porigin->blob_oid, &origin->blob_oid);
 		porigin->mode = origin->mode;
 	} else {
@@ -569,7 +566,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 			die("internal error in blame::find_origin (%c)",
 			    p->status);
 		case 'M':
-			porigin = get_origin(sb, parent, origin->path);
+			porigin = get_origin(parent, origin->path);
 			oidcpy(&porigin->blob_oid, &p->one->oid);
 			porigin->mode = p->one->mode;
 			break;
@@ -588,8 +585,7 @@ static struct origin *find_origin(struct scoreboard *sb,
  * We have an origin -- find the path that corresponds to it in its
  * parent and return an origin structure to represent it.
  */
-static struct origin *find_rename(struct scoreboard *sb,
-				  struct commit *parent,
+static struct origin *find_rename(struct commit *parent,
 				  struct origin *origin)
 {
 	struct origin *porigin = NULL;
@@ -615,7 +611,7 @@ static struct origin *find_rename(struct scoreboard *sb,
 		struct diff_filepair *p = diff_queued_diff.queue[i];
 		if ((p->status == 'R' || p->status == 'C') &&
 		    !strcmp(p->two->path, origin->path)) {
-			porigin = get_origin(sb, parent, p->one->path);
+			porigin = get_origin(parent, p->one->path);
 			oidcpy(&porigin->blob_oid, &p->one->oid);
 			porigin->mode = p->one->mode;
 			break;
@@ -1270,7 +1266,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 				/* find_move already dealt with this path */
 				continue;
 
-			norigin = get_origin(sb, parent, p->one->path);
+			norigin = get_origin(parent, p->one->path);
 			oidcpy(&norigin->blob_oid, &p->one->oid);
 			norigin->mode = p->one->mode;
 			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p);
@@ -1404,8 +1400,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * common cases, then we look for renames in the second pass.
 	 */
 	for (pass = 0; pass < 2 - no_whole_file_rename; pass++) {
-		struct origin *(*find)(struct scoreboard *,
-				       struct commit *, struct origin *);
+		struct origin *(*find)(struct commit *, struct origin *);
 		find = pass ? find_rename : find_origin;
 
 		for (i = 0, sg = first_scapegoat(revs, commit);
@@ -1418,7 +1413,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 				continue;
 			if (parse_commit(p))
 				continue;
-			porigin = find(sb, p, origin);
+			porigin = find(p, origin);
 			if (!porigin)
 				continue;
 			if (!oidcmp(&porigin->blob_oid, &origin->blob_oid)) {
@@ -2806,7 +2801,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		sb.final_buf_size = o->file.size;
 	}
 	else {
-		o = get_origin(&sb, sb.final, path);
+		o = get_origin(sb.final, path);
 		if (fill_blob_sha1_and_mode(o))
 			die(_("no such path %s in %s"), path, final_commit_name);
 
-- 
2.9.3

