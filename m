Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316302018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbcF0SZY (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33229 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbcF0SZW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id r201so26995689wme.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ELiRcM5s+jMUO9x92pV02dP3gK7WnZ+8o6G+ZGRGeng=;
        b=yoAGMyw8WQcw5XtsXkaTnuSIAp9+KD1ocbQQ1TROg4hUl3PcZOdz6krtQ6UJHExRds
         qboFEdiiL9Rh4pBsjTXCxcRAUUgAPfVyK5q8oTu431grLlnSbdsopgL8d9vmcnfxk4X6
         1BsXwdMdke9lyvAynm4tHOJR3I6cIVqgG6mtCPOrKhlqdzuqSfIXcy8JDHBMXGwdUxLT
         n7RmaeT6uJdtUWWiVXdBUp7L4DMHu4MrUnJvlTnbSSORcKEiEWbKLNL9c+Xd8WpXvf69
         lG+EVlDZgL7nMMG/m/bRP0lvU9JxJuoR9nmBa255zyRWzPSRLfSDqVrOwY+HT3LlM7/6
         S5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ELiRcM5s+jMUO9x92pV02dP3gK7WnZ+8o6G+ZGRGeng=;
        b=WuMWXcQmExtyDD1zcO8x8KFCV7pzKdDXEMtfSStzmy7sf+0bxrYvHNI2Cgfdw6dt/a
         chrFmA9f7StvSM7VxoRScFwl0WYM4efzxXL3YChCEIbERRaOSbCVGeCRGOcc/F3STgLK
         sp9jeFBFBhtq5cCjmgub5ih+cpzE5IW88FbmlhEG0YtpRSI3uXt6Mdgp9BYm1bAM8qSD
         k36jf52YyBLVCDRhRlySaGhALY4I4nYfJTxJLbBlCXpcLFL/2YBVQVdmIsmKMPa7ueKt
         1OBje6vFbyA+LpvanG6xyc7BJvekR99IHAUrRLRQJrTdWIb+RA0dLXpPVQj/pG1MQSg5
         s47g==
X-Gm-Message-State: ALyK8tKEZ1FsE0Mx3hdL1eYN1sQASJ23sBAiKwfQbHUgOMiAyZJR3qTSLkmIYuAakH8wNg==
X-Received: by 10.194.239.163 with SMTP id vt3mr2133879wjc.78.1467051920615;
        Mon, 27 Jun 2016 11:25:20 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:19 -0700 (PDT)
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
Subject: [PATCH v8 22/41] builtin/apply: make add_index_file() return -1 on error
Date:	Mon, 27 Jun 2016 20:24:10 +0200
Message-Id: <20160627182429.31550-23-chriscool@tuxfamily.org>
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
in "builtin/apply.c", add_index_file() should return -1 instead of
calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b0fd5f7..eadff4d 100644
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
2.9.0.172.gfb57a78

