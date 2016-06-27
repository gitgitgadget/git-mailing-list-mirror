Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8CD2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbcF0SZV (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33154 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbcF0SZS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id r201so26995254wme.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s8xXtkhFFvpyV0H3xRMYjX+ru2wpJOGozfXckIgyrBA=;
        b=QQ2ehhNxi3ZaRzjthIwkz4ozigtpKQigMQQJKJDWNUyugcJZQShGeez9LA1fWJJHKR
         UTV6ggEuzqw43DaMxw8uQHo/KrtUgwPJlIU+nT9kkq6MzB/SMpA/Kfm355I2pHSABxNK
         IJ7ortpqV6IyNgVr1weRBrqsZIY6HIdxiJP6RTUI46UW2FUaX3+qvapughH28dFMfHEz
         Sw8gdNw+JswBjg73Zf964+MoCAO1XOhHYyVKK/h6FUKJCvC2Wz29rGcFspZfrkmBv80x
         2tiQy8MUbrPj9Wlaqx92kBPPm6F7+7BlkNw4zo7QW/vsDAYMBotoGZDm6qygusauUMll
         TPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s8xXtkhFFvpyV0H3xRMYjX+ru2wpJOGozfXckIgyrBA=;
        b=NPMGd2gc1VCeBTEsTPvi1EU2eNVKtAbEl4ohakWjjnGeqfo71exXJe4dMjaIr2FwV2
         rKKI8Q5Jh9a5h8V3FMF5alw529Ws33c2GugMSGwpif0XAqXIVvEMTTb1BT4I/0EjaMbJ
         7ns+yWsXv+HgDpwIqHjZ0cdM+6Jnkgn/ZgW45Y6/xTbu0qKWrDV7wsrrGRnaTRZ/helL
         KcD1XxfXf1PMsWF9dAlPjIsEs/C6Lmp4gpR63MVKV+enTdn9GD3ylDNCvN8Uhbn6YSoR
         4dtiq6yIYocC2L7yszEv75TJVQzuXrWxM+TQTInfAiEfZwlmjqKDdQ1VwQdP1H0bdWuD
         6XuQ==
X-Gm-Message-State: ALyK8tJOPoGJUW/C4kBFGfLHpN9LEjgNoW5c9Tp6AoLwkuC9WPYcn2F3aYGg8HunAYzJxg==
X-Received: by 10.28.46.147 with SMTP id u141mr11726282wmu.74.1467051916699;
        Mon, 27 Jun 2016 11:25:16 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:15 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 19/41] builtin/apply: make build_fake_ancestor() return -1 on error
Date:	Mon, 27 Jun 2016 20:24:07 +0200
Message-Id: <20160627182429.31550-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index d3a9da2..bb1dffa 100644
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
2.9.0.172.gfb57a78

