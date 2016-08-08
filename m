Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19EE220193
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbcHHVE4 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33855 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbcHHVET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so17866491wma.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FZHyE7DOpjCBJtSjQUrIUlhuNNWBdk1/KhrjpmYIp8I=;
        b=zNeTx6O4g5JnLPKbLGfhUJ9ZmWn8K78zh9ir7RzcUKr9PH+nrA5ydD8TSr07eeDthC
         zf038KUpCmfifRSNEPDpHmxp9WJurmMuKcIEzU31x+Zi0VDEcpyv/6fD8sxDUlL5diSA
         34PXKG0ojHikadTAVVH8ipVJdZ/sakw7eO4hPtyE20TR15vBLhhJkbLsfox9iiCQY566
         GKwT+wICCNPtXjCKQGskdDTAAe27McC/K/Aaqq+KslYXvtoDZwUa1Fvf/zrAj+3pLahT
         67XYzoyayJYWplmyUBfQjb2+r2QntHaUcZmXv9OfyFH+2SSWqNLuTwZ586odWprG4kb/
         RYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FZHyE7DOpjCBJtSjQUrIUlhuNNWBdk1/KhrjpmYIp8I=;
        b=YQTotp51EQ3ndX/LkQNnKRQW3vFPya7IyMd+hdyeQaQvqKjHYzGMGMhSga9gDLPPc6
         7W1GDVHRE1ON9daWhxdfg4DtBBNWHuWgJ3ohABZqbiAZU4iA88QxRYxEBTJs24t2ejUb
         4A4bCNxc6I9GbjfitNNqF/66gGFe38KzyVTWcdjbLyM5NtMakjs9XQBCy2JnZJJbDeNR
         ji0GplWu92gyeA/iaDnGa/WAdJU7cyh7/8dyG+J/Xp9NtE7m+Yx5odJPpl17WFddXXVX
         CvsqKuU8xsz9T1jxuYnvvq8prvVtENkW9ggPwQqI2tORpW0LW6VCWYQ+s2XoZOUsuCs6
         Vuyg==
X-Gm-Message-State: AEkooutmvtQnm0nTElj+Oh3GJzPOAnCMHvSOepZd3JuA8R3WR7iCNfrS2EebMiodkYFfrA==
X-Received: by 10.194.43.9 with SMTP id s9mr36322919wjl.46.1470690257622;
        Mon, 08 Aug 2016 14:04:17 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:16 -0700 (PDT)
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
Subject: [PATCH v10 19/40] builtin/apply: make build_fake_ancestor() return -1 on error
Date:	Mon,  8 Aug 2016 23:03:16 +0200
Message-Id: <20160808210337.5038-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
2.9.2.614.g4980f51

