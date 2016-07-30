Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8021F955
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbcG3R10 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34241 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so20052564wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vfDxvNYj1xHi600whtIx/sqB2G9AtMDPZuNPYR77aA0=;
        b=eyNsewlIT9P0sQXexg/FvzoD8MFyufXk/DkWhyeh9G633twa80ScbAp30FuJT/yL5P
         jrxp+5gzPeHxsuHqXyJNo/gvRBPsICHkfVIex0M2zCz0Pw9n+P1zbPl43xqKkEbTj4DO
         GkZJlIzhLtvXbKucOGde1RtiMz8VJ/I92otUselX6q+YyFPlCBPF9TRpaej3+hSs7ZlP
         EaSM+wnwTSzp9RVM5V2Rc34nqWQ5rViEOG9Vm9Tz3ZGJPnYDSWGI4GYzfHDZK2oLu/kZ
         m/FkyVPpcV2y/f/avH69OCcPY5q30LnYybyWrkqC6AeqN5Fh5DQE8LP2Ks7QRsh+AANC
         IlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vfDxvNYj1xHi600whtIx/sqB2G9AtMDPZuNPYR77aA0=;
        b=SKa1iGePe9oXGZko8h8NqKnSwzh32VYK0UbmxkZcYUGpKMZ8ZiGskolozF+XNgE9Y1
         gGYASZC3/tAOh4u59PUf7rr3Wz3l+w62jUJE18vHpZlPgGzh07dDzqYYr1RVshDEJcrE
         kH4ypB3ahsoowbhCDDjc1QAZfCA2d72JsFW15xJARy9hCIsJtfLPGjiKHNb6wY0UozbZ
         ufqyhjteQ5VJ5a8sx0+sQAEZcRe6uOmYDrj8+2FitzbIBuuL0sEF8KkrlTKI/jwtsuJm
         fmEIP3KAM68L6SRo/U3aQ5/qTLFcU5i0l3nyj497WmFqNtN6hLe6ybTlcoSZM430tqq3
         tTYw==
X-Gm-Message-State: AEkoouu4LWEsLaRajqb79MBrMrWcrjDpHKes+eps7mrSdDeeddcShiuI6AkmGEOyF+NRIg==
X-Received: by 10.194.240.4 with SMTP id vw4mr48181799wjc.22.1469899560863;
        Sat, 30 Jul 2016 10:26:00 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:00 -0700 (PDT)
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
Subject: [PATCH v9 22/41] builtin/apply: make add_index_file() return -1 on error
Date:	Sat, 30 Jul 2016 19:24:50 +0200
Message-Id: <20160730172509.22939-23-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
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
index 1f405b4..a87ca0b 100644
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
2.9.2.558.gf53e569

