Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BEF3207D6
	for <e@80x24.org>; Fri,  5 May 2017 05:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755390AbdEEF2C (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 01:28:02 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33855 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbdEEF1j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 01:27:39 -0400
Received: by mail-io0-f193.google.com with SMTP id 12so2185687iol.1
        for <git@vger.kernel.org>; Thu, 04 May 2017 22:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yijkiBt99zQPrx1M4qhhyYiLjSGywf5+fZQk1UXlRR0=;
        b=M1gToeUBJaSbULAo/0uHWBEhwECUTkxw9Bay5JLNkHc0tW4TtZzPRfplXiRwCnvJmu
         gpUgnWyG0Ya1HI7hIn4E/8iwBh24WuPZkFZIdzsqcWRbuSUR3aly04yzPOSWdUdxUn6+
         7YykcGrr8aYrLhXf/laJ8svCyuHjb1O+muzw3vpfWcXaYe5kfG7yls+V1Ua2ZZlmIC8S
         jk/P6Y96awS7Kb1RmAscTaU0KYavdKwNhg65rxExR8nNUBbgB75EQWe7WkArnm9Arak6
         IAskHt1A8kui2jw6Vnuluacnkptt6r8dujU3/a6UA2QPITFII2EWeiIT2Un6GxPUH7oS
         S5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yijkiBt99zQPrx1M4qhhyYiLjSGywf5+fZQk1UXlRR0=;
        b=e4VQfR9DojgwptN+l75zz4GA1XLoLGDmkrtANypYKwVqs2W4mbCjkRV9aBF4CgyAJ2
         GeVe7n9OUyAcIYVK6r7ItChBmWcNkOg7hI1mhuaGzjEP6xAjIirH8auttfgvu9Cy3qPv
         ByUw/ufPJssaK3as+62rA3n6Uq2c5oVoi2yNik7azuo08ZWS1Xp4K6rq0LGUunl87kTA
         cXAOSltAjATJz28kKiIRVeOEWZpWAOWCQakOXUJ++WMzm74NL6nRWBqHN88zuURDWOAv
         OZjmwEMJgNW1FfAzGaP7Yh9CU4XYxQUS9UD00Mm6uO1vko7D95t9G2aydj3M9EGFO41y
         7L3w==
X-Gm-Message-State: AN3rC/6tHgjAn7KPzThbSHZQsmFtAImMSqdgpIpqpzhv5g5MMI/GT0e4
        Vldcrzwv0nuqYQ==
X-Received: by 10.202.57.11 with SMTP id g11mr15584645oia.160.1493962058967;
        Thu, 04 May 2017 22:27:38 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 2sm2179586ota.46.2017.05.04.22.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 22:27:38 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH 04/10] Remove unused parameter from get_origin()
Date:   Fri,  5 May 2017 00:27:23 -0500
Message-Id: <20170505052729.7576-5-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170505052729.7576-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index c419981..cc46f56 100644
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
 
@@ -543,7 +541,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 
 	if (!diff_queued_diff.nr) {
 		/* The path is the same as parent */
-		porigin = get_origin(sb, parent, origin->path);
+		porigin = get_origin(parent, origin->path);
 		oidcpy(&porigin->blob_oid, &origin->blob_oid);
 		porigin->mode = origin->mode;
 	} else {
@@ -569,7 +567,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 			die("internal error in blame::find_origin (%c)",
 			    p->status);
 		case 'M':
-			porigin = get_origin(sb, parent, origin->path);
+			porigin = get_origin(parent, origin->path);
 			oidcpy(&porigin->blob_oid, &p->one->oid);
 			porigin->mode = p->one->mode;
 			break;
@@ -615,7 +613,7 @@ static struct origin *find_rename(struct scoreboard *sb,
 		struct diff_filepair *p = diff_queued_diff.queue[i];
 		if ((p->status == 'R' || p->status == 'C') &&
 		    !strcmp(p->two->path, origin->path)) {
-			porigin = get_origin(sb, parent, p->one->path);
+			porigin = get_origin(parent, p->one->path);
 			oidcpy(&porigin->blob_oid, &p->one->oid);
 			porigin->mode = p->one->mode;
 			break;
@@ -1270,7 +1268,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 				/* find_move already dealt with this path */
 				continue;
 
-			norigin = get_origin(sb, parent, p->one->path);
+			norigin = get_origin(parent, p->one->path);
 			oidcpy(&norigin->blob_oid, &p->one->oid);
 			norigin->mode = p->one->mode;
 			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p);
@@ -2806,7 +2804,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		sb.final_buf_size = o->file.size;
 	}
 	else {
-		o = get_origin(&sb, sb.final, path);
+		o = get_origin(sb.final, path);
 		if (fill_blob_sha1_and_mode(o))
 			die(_("no such path %s in %s"), path, final_commit_name);
 
-- 
2.9.3

