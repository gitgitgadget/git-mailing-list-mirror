Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB072018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbcHHVE2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36218 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbcHHVEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so317727wmf.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fW4ruB/kzt30fTWYhlbbE0hlFIsDQv8hPQmtGGOiaqU=;
        b=sPfWJhmXOrSQhD/8vi/VUJE7iyLVhkWoiTRlLbujPLTQMWyLOP++ZxqXfcOt6S6tZL
         7o3y3jtXCTgE9w6oLlcDum75rNx7n1VTmCGaNHSpgc/mEf+Ey9zd+PnoPNTjaXoR55bW
         G2V3VVAQGUU/xjLCmBJVQHr8I97hqO5GYqKrbK1YxoTTT6TNqhE+jkAK6VjvNllgrf9n
         wXpxf6qrxb/SXmC7I7DVI29TyALKPLO7QdiNUYiV7+WNrnpm9C4fHj2PDUE4kn57pjPt
         rUw9Ym9qY1me16N0xwHwAv0VOHdGMK7IDzPf/kP0+5HD1nDQvUIELaIqxWCsHBGYHILl
         +Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fW4ruB/kzt30fTWYhlbbE0hlFIsDQv8hPQmtGGOiaqU=;
        b=KPk+3TXclfVmGOGeSS8DjUaY3uH80mp+/5w6d13dxZ4fvxLJmfg1QaUKcDS5Sb/llf
         4OEdNhwLhPQeozPBUCKvDpEFRn4HBadu0rcakfKk6GQjXUe638x8ilRd3+wzeptAGv78
         FQ+ZP3itKzJONEnw5SqZuylF0VtP3d/3Ax78vbj4K3XaXDTgisFqjNIBjRNHd8Ex0Qbb
         BFHNRsGD7pOTcALFLIkYD0lHk2Or5GWm6bztSDbR8934nvIrmhJ7UbVBoIAvxLWHKecb
         OkEXAvbjoLDYl/RQBjcq8tl3VMup6LxLkYNB0nZFr1sLKSAUnR1OF8FYr7FIg9BEwWvu
         rOIw==
X-Gm-Message-State: AEkoouupUH0k1kDIJio+2SsZiOLE8XpHX6wuIM2zd4yjUAzP9U7YY1m9GXt/6RSvah3ifA==
X-Received: by 10.28.50.3 with SMTP id y3mr18306042wmy.23.1470690261430;
        Mon, 08 Aug 2016 14:04:21 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:20 -0700 (PDT)
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
Subject: [PATCH v10 22/40] builtin/apply: make add_index_file() return -1 on error
Date:	Mon,  8 Aug 2016 23:03:19 +0200
Message-Id: <20160808210337.5038-23-chriscool@tuxfamily.org>
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
2.9.2.614.g4980f51

