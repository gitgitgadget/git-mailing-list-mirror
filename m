Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20EE220193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbcIDUTa (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35496 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbcIDUTU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id c133so10466369wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KD4riBJ9OxxnR22qaugN5s1dvgIQg8vSizW8H3uuy4o=;
        b=0PLCYEZi33l5qFTu4wAJuvmUYVtdXEBSoUHAhJswU87EHn33cedEl90pE2+UX0MwNH
         uMuVEZgvgQTHeDEAmALkyZnEj89+m2Mts9X+eo6X8Y/S2/ZZnMj6eX/5e6dJUqnNzWIL
         sStsuqDj+/wqj3CcGNhHqb/RxEV/1rhkwWBJswQnJVAc5l1XOJN6RFnjLv60AYSix+Hi
         wkEtJk8bVPgDEuuoQCqvn2ygErGkztKjfsG9YgZ0bh6YIgyqjanUJ6O8zGb1nls9RH7h
         Rq+me9qd8FofN0p0wwmwiW9pSVoqd6tXt1/rO7goG3NCHeHukM0RUnC5nUE3ekwgSp/O
         j3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KD4riBJ9OxxnR22qaugN5s1dvgIQg8vSizW8H3uuy4o=;
        b=YRCQ9mGyZi/1FNEex2Io+VMVAz/aiXHPR5RaCSTKSo5/jtL3xeSCHvjlX+aoC63KU6
         lKPfapQVVo30gR1H6PJC5F6Vo96EhDbjjOerm+QtHFwLf9ZFaY7ggK8MGDi6tC3f9U+S
         VJx8uYVrtIZPiEjUE2fAIIaOdPJ+bVi3JymJQ5fsF/AP9Aa7mCdY25rTOIzPrgA6Z3he
         k2nkBpLqTiFITTRSshV7cgaIExmwSGWkieiOlqWG1RyRLR1QxiPAKTSqFoFO0577zdrl
         moILCDbePYuo1n2tUB3QRDEKsXFvENINt+D+PtEKs+jaF27OEyNswbrtEpBLKk36pLU2
         5eUg==
X-Gm-Message-State: AE9vXwNC7RIiD35Z4/coyeGTunhff+NChmYUCziDMSFjUR2/72iJ5vIrvgbAf2dKX6S2Sg==
X-Received: by 10.28.16.3 with SMTP id 3mr12555456wmq.58.1473020359243;
        Sun, 04 Sep 2016 13:19:19 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:18 -0700 (PDT)
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
Subject: [PATCH v14 22/41] builtin/apply: make add_index_file() return -1 on error
Date:   Sun,  4 Sep 2016 22:18:14 +0200
Message-Id: <20160904201833.21676-23-chriscool@tuxfamily.org>
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
in "builtin/apply.c", add_index_file() should return -1 instead of
calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ad0b875..a646900 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4099,11 +4099,11 @@ static int remove_file(struct apply_state *state, struct patch *patch, int rmdir
 	return 0;
 }
 
-static void add_index_file(struct apply_state *state,
-			   const char *path,
-			   unsigned mode,
-			   void *buf,
-			   unsigned long size)
+static int add_index_file(struct apply_state *state,
+			  const char *path,
+			  unsigned mode,
+			  void *buf,
+			  unsigned long size)
 {
 	struct stat st;
 	struct cache_entry *ce;
@@ -4111,7 +4111,7 @@ static void add_index_file(struct apply_state *state,
 	unsigned ce_size = cache_entry_size(namelen);
 
 	if (!state->update_index)
-		return;
+		return 0;
 
 	ce = xcalloc(1, ce_size);
 	memcpy(ce->name, path, namelen);
@@ -4122,20 +4122,32 @@ static void add_index_file(struct apply_state *state,
 		const char *s;
 
 		if (!skip_prefix(buf, "Subproject commit ", &s) ||
-		    get_sha1_hex(s, ce->sha1))
-			die(_("corrupt patch for submodule %s"), path);
+		    get_sha1_hex(s, ce->sha1)) {
+			free(ce);
+			return error(_("corrupt patch for submodule %s"), path);
+		}
 	} else {
 		if (!state->cached) {
-			if (lstat(path, &st) < 0)
-				die_errno(_("unable to stat newly created file '%s'"),
-					  path);
+			if (lstat(path, &st) < 0) {
+				free(ce);
+				return error(_("unable to stat newly "
+					       "created file '%s': %s"),
+					     path, strerror(errno));
+			}
 			fill_stat_cache_info(ce, &st);
 		}
-		if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
-			die(_("unable to create backing store for newly created file %s"), path);
+		if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0) {
+			free(ce);
+			return error(_("unable to create backing store "
+				       "for newly created file %s"), path);
+		}
 	}
-	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
-		die(_("unable to add cache entry for %s"), path);
+	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+		free(ce);
+		return error(_("unable to add cache entry for %s"), path);
+	}
+
+	return 0;
 }
 
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
@@ -4271,8 +4283,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
 	if (patch->conflicted_threeway) {
 		if (add_conflicted_stages_file(state, patch))
 			exit(128);
-	} else
-		add_index_file(state, path, mode, buf, size);
+	} else {
+		if (add_index_file(state, path, mode, buf, size))
+			exit(128);
+	}
 }
 
 /* phase zero is to remove, phase one is to create */
-- 
2.10.0.41.g9df52c3

