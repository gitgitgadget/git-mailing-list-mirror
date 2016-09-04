Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B1232021E
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932266AbcIDUTV (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32850 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932235AbcIDUTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id w207so10456150wmw.0
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=efI9PzqktUuEEO1SUbda8YkY/SG1kGBzfYwdjrM3vJ0=;
        b=hcIpKneE10tW/1AJytepdH4CgcFBvq43qgIk+ZmqXTtaqq5s8r4we2Ne7Mv2j//xe0
         X0dPB/0btzhHfwwIcxqYQCYGms1ZxrW4ylZJkhhe6e4yMWqLUet+ZEAiiwPhLvGKEN5h
         kaWkPWySPERLXXyMIp2v5+BX8R+AqA4QC90U+0Ht61/cUuk2/Y5bXSXGadmD8XQc9uXh
         KYZsyQVArP3zsC6oQIcoKrtC4ptqsM8t6sC8ut3ZVE8eWuxNkoFINX4NsfUyZLzCfDQL
         O0j6A6MnXOMnrsAnkmFto7PYHmjpyLD8GjRxaw4rZNfW8jbzHzwTzixj18hr20B3Z/Og
         tfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=efI9PzqktUuEEO1SUbda8YkY/SG1kGBzfYwdjrM3vJ0=;
        b=UsnT8JFYdnvTq1LpqFl29vJrmNE6rTn/ZTRYkhlzvWb0MA5aZQvYQhZrXQ1w5YFuRX
         bl8a/M1NRApxU6UOgtFumtbYC5exhZ8byIH18XyZT+5HlJAAHLXYY1GPZ7YmRRDuuW02
         WTRkjLISB8MwDB0l2K8wsf99z4hWeicMdZ6665miQyjlmdpjDAqNwLd7hEwODC+8H2Eo
         IXYfoEaJv2Xv37DjRV1Flqk2qrj8dhbjNCPFNzYwDB0nJh3kueuVeB/SqsXDtn1DEOmU
         bB4RB+FqPlJqG9BMTy1bWt+hxwd/xnC2/kXvLtHHsUOZ9RmbOsFMAR2jqQ9mPwusH6CK
         yD2Q==
X-Gm-Message-State: AE9vXwOKSoW5U39bL6P6+swhzxZJRRlmF0zXX7gTvHi9JkYPBcAKaA4Abet5h4BQ0OXMHQ==
X-Received: by 10.194.75.225 with SMTP id f1mr27807066wjw.104.1473020354682;
        Sun, 04 Sep 2016 13:19:14 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:13 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 19/41] builtin/apply: make build_fake_ancestor() return -1 on error
Date:   Sun,  4 Sep 2016 22:18:11 +0200
Message-Id: <20160904201833.21676-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", build_fake_ancestor() should return -1 instead
of calling die().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 166e94d..575981b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3900,11 +3900,12 @@ static int preimage_sha1_in_gitlink_patch(struct patch *p, unsigned char sha1[20
 }
 
 /* Build an index that contains the just the files needed for a 3way merge */
-static void build_fake_ancestor(struct patch *list, const char *filename)
+static int build_fake_ancestor(struct patch *list, const char *filename)
 {
 	struct patch *patch;
 	struct index_state result = { NULL };
 	static struct lock_file lock;
+	int res;
 
 	/* Once we start supporting the reverse patch, it may be
 	 * worth showing the new sha1 prefix, but until then...
@@ -3922,31 +3923,38 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 			if (!preimage_sha1_in_gitlink_patch(patch, sha1))
 				; /* ok, the textual part looks sane */
 			else
-				die("sha1 information is lacking or useless for submodule %s",
-				    name);
+				return error("sha1 information is lacking or "
+					     "useless for submodule %s", name);
 		} else if (!get_sha1_blob(patch->old_sha1_prefix, sha1)) {
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
 			if (get_current_sha1(patch->old_name, sha1))
-				die("mode change for %s, which is not "
-				    "in current HEAD", name);
+				return error("mode change for %s, which is not "
+					     "in current HEAD", name);
 		} else
-			die("sha1 information is lacking or useless "
-			    "(%s).", name);
+			return error("sha1 information is lacking or useless "
+				     "(%s).", name);
 
 		ce = make_cache_entry(patch->old_mode, sha1, name, 0, 0);
 		if (!ce)
-			die(_("make_cache_entry failed for path '%s'"), name);
-		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
-			die ("Could not add %s to temporary index", name);
+			return error(_("make_cache_entry failed for path '%s'"),
+				     name);
+		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD)) {
+			free(ce);
+			return error("Could not add %s to temporary index",
+				     name);
+		}
 	}
 
 	hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
-	if (write_locked_index(&result, &lock, COMMIT_LOCK))
-		die ("Could not write temporary index to %s", filename);
-
+	res = write_locked_index(&result, &lock, COMMIT_LOCK);
 	discard_index(&result);
+
+	if (res)
+		return error("Could not write temporary index to %s", filename);
+
+	return 0;
 }
 
 static void stat_patch_list(struct apply_state *state, struct patch *patch)
@@ -4495,8 +4503,11 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if (state->fake_ancestor)
-		build_fake_ancestor(list, state->fake_ancestor);
+	if (state->fake_ancestor &&
+	    build_fake_ancestor(list, state->fake_ancestor)) {
+		res = -128;
+		goto end;
+	}
 
 	if (state->diffstat)
 		stat_patch_list(state, list);
-- 
2.10.0.41.g9df52c3

