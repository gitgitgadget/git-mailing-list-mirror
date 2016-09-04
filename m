Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63FC1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932424AbcIDUUM (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:20:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36406 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbcIDUT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id l65so2667789wmf.3
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vWmAx3d0SliPUDrq4wEXPjTf0znrGT74ii/aqLYnfRk=;
        b=HTFomwiblsBsOih8JiVJRpusFYz2losLtMpenZtZEpkC6pkQIOAIkcrL1jHsOOsY1U
         5H3laZ3SSY8PS+vucS1G1P8AOAfqNjf5gk0kEbJfSQ2tvI9A9DNAL/3gvuFpwanzC4or
         RDnF6rrc+YfpWydHJum8oF43UV1t9iSLu88x424IU6iEzO9WnlA4NCor5EqBF078s3mI
         GROuq1RnHqRsgHU5x7njhUFUV3kpjfQiOPUpM+29FvdkrO+V5zkzsWD1yRq6rVIdTeMG
         V8STphGwiaMYM/zCKAguVQHTgl1WYJpmQy+Lvlz457JiZEPEpwhGpY6iSnLdb01wGdOj
         UBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vWmAx3d0SliPUDrq4wEXPjTf0znrGT74ii/aqLYnfRk=;
        b=YzyQISQ0GsZxVT/wFr+B6NeWC7snxvhtViSrk/yLb0uygN2v4sj6oGxOl0rNwPuWQD
         zOC54hbNYCLtyAXujaYfWCorfHC0PKpTCxZXPFGH54lnkmrW8kakFq61ihdMcIXQX+B6
         NiTU5DKtQom/aZFyrQtr50+RAOhOi5PcdRqW5zD+5kq9lZmuAM70FRaO3zTJWyTVVxci
         vLnIMMf0s8vRt3e5nhhTI4uX8uccSvuvf698AUadaO/OeKWpsrHWJ7qnEh37urp5q+eF
         kY7VmLlcIwI18aU5K/k5eoq+Lv6SH14jdI09PFI1uSULxmwWyxQm1oZwEqdy/8JlFtl+
         u6nw==
X-Gm-Message-State: AE9vXwOx+V8IagiFY0Upiiu/5p/0JfSOziqxSNgKCiIybqhRGDdWLLPknN+Puk9R4RuesQ==
X-Received: by 10.194.200.198 with SMTP id ju6mr27965901wjc.184.1473020394814;
        Sun, 04 Sep 2016 13:19:54 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:54 -0700 (PDT)
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
Subject: [PATCH v14 40/41] apply: learn to use a different index file
Date:   Sun,  4 Sep 2016 22:18:32 +0200
Message-Id: <20160904201833.21676-41-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes we want to apply in a different index file.

Before the apply functionality was libified it was possible to
use the GIT_INDEX_FILE environment variable, for this purpose.

But now, as the apply functionality has been libified, it should
be possible to do that in a libified way.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 27 +++++++++++++++++++++------
 apply.h |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/apply.c b/apply.c
index f29387d..b1dd998 100644
--- a/apply.c
+++ b/apply.c
@@ -3993,12 +3993,21 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	return err;
 }
 
+static int read_apply_cache(struct apply_state *state)
+{
+	if (state->index_file)
+		return read_cache_from(state->index_file);
+	else
+		return read_cache();
+}
+
 /* This function tries to read the sha1 from the current index */
-static int get_current_sha1(const char *path, unsigned char *sha1)
+static int get_current_sha1(struct apply_state *state, const char *path,
+			    unsigned char *sha1)
 {
 	int pos;
 
-	if (read_cache() < 0)
+	if (read_apply_cache(state) < 0)
 		return -1;
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
@@ -4071,7 +4080,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
-			if (get_current_sha1(patch->old_name, sha1))
+			if (get_current_sha1(state, patch->old_name, sha1))
 				return error("mode change for %s, which is not "
 					     "in current HEAD", name);
 		} else
@@ -4675,10 +4684,16 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && state->newfd < 0)
-		state->newfd = hold_locked_index(state->lock_file, 1);
+	if (state->update_index && state->newfd < 0) {
+		if (state->index_file)
+			state->newfd = hold_lock_file_for_update(state->lock_file,
+								 state->index_file,
+								 LOCK_DIE_ON_ERROR);
+		else
+			state->newfd = hold_locked_index(state->lock_file, 1);
+	}
 
-	if (state->check_index && read_cache() < 0) {
+	if (state->check_index && read_apply_cache(state) < 0) {
 		error(_("unable to read index file"));
 		res = -128;
 		goto end;
diff --git a/apply.h b/apply.h
index 9fec536..b3d6783 100644
--- a/apply.h
+++ b/apply.h
@@ -63,6 +63,7 @@ struct apply_state {
 	int unsafe_paths;
 
 	/* Other non boolean parameters */
+	const char *index_file;
 	enum apply_verbosity apply_verbosity;
 	const char *fake_ancestor;
 	const char *patch_input_file;
-- 
2.10.0.41.g9df52c3

