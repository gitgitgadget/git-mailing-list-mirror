Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6C62018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbcF0S0N (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35520 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbcF0S0K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:26:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id a66so26935608wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NVLL9Nqh+UMkNwUIBvIJLjfLp5PE6fPvvyBa/fwyQuQ=;
        b=UcNnGM2/UTDwX+aXAKO13VVWMyVKWtjKQ60wI45/lYy/ggy5KnNnxNT1aMvqDvpztg
         xDaTeAEFzA75veNpIQg/0LEOKIWywyeG2pXusic0FjJKgCl52b9amKU5hLhjqZTvgZV1
         9ywTn5XcTR+Q06XvWWmYkWbX22CEcux6GH7C+y8vtLSKbgXEdVYJuIM5/Dff9Eh3f9YF
         gfu7e/XJV/ADvp62OokHTuApnjhmxfOxwb76XMY2uU67VnTi9lEGG/SHr6rBtO+jdYn+
         m+dBtQ4gu0Gbk454ust1rp0Fh+7/znmj9dJ2gJdjrxIoMzmLJPXW07dLAuwqT1zkHiKQ
         uyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NVLL9Nqh+UMkNwUIBvIJLjfLp5PE6fPvvyBa/fwyQuQ=;
        b=ROJAkfOgISSZorGEgiJy8tX3y/qKD+pUFvRdDCgmIAMb6X2igh6Kma13p3/mtuFTIa
         5Nra5gYIEGXn8pADlxK+GjvRWgKItCUnrf4K+NkMFwVKCPAdHHWiEM9mr2oi6FLbMyyr
         kFwVXmfbaOUnitdDqLrUheEwv/35BDTLTf9h+wPgug0Ce+JDutuh2QbnD1sTC4BMPEND
         dklzp/j55nYDI4QzLHtZqutqWScZ+XlJ1vDenfpSkUnm8Ex2wzkj9PX2pB1SotI1/Yya
         ZhsDdn74KlHpXe9gJWdRuHB5x2Onlzvv/R0d3nIhc/GHi/OIcrriH2wclCNQDbZ2Yd7m
         Q8Dg==
X-Gm-Message-State: ALyK8tKxvPMJLQsjYPgcNilp4bcZIYyVy/p5vlTC7Whqh6hWVVNwtr2Dm4OR0My+kUoYnw==
X-Received: by 10.194.38.4 with SMTP id c4mr2212205wjk.20.1467051955884;
        Mon, 27 Jun 2016 11:25:55 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:55 -0700 (PDT)
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
Subject: [PATCH v8 41/41] apply: use error_errno() where possible
Date:	Mon, 27 Jun 2016 20:24:29 +0200
Message-Id: <20160627182429.31550-42-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To avoid possible mistakes and to uniformly show the errno
related messages, let's use error_errno() where possible.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/apply.c b/apply.c
index de86f40..2ac22d3 100644
--- a/apply.c
+++ b/apply.c
@@ -3512,7 +3512,7 @@ static int load_current(struct apply_state *state,
 	ce = active_cache[pos];
 	if (lstat(name, &st)) {
 		if (errno != ENOENT)
-			return error(_("%s: %s"), name, strerror(errno));
+			return error_errno("%s", name);
 		if (checkout_target(&the_index, ce, &st))
 			return -1;
 	}
@@ -3671,7 +3671,7 @@ static int check_preimage(struct apply_state *state,
 	} else if (!state->cached) {
 		stat_ret = lstat(old_name, st);
 		if (stat_ret && errno != ENOENT)
-			return error(_("%s: %s"), old_name, strerror(errno));
+			return error_errno("%s", old_name);
 	}
 
 	if (state->check_index && !previous) {
@@ -3693,7 +3693,7 @@ static int check_preimage(struct apply_state *state,
 	} else if (stat_ret < 0) {
 		if (patch->is_new < 0)
 			goto is_new;
-		return error(_("%s: %s"), old_name, strerror(errno));
+		return error_errno("%s", old_name);
 	}
 
 	if (!state->cached && !previous)
@@ -3752,7 +3752,7 @@ static int check_to_create(struct apply_state *state,
 
 		return EXISTS_IN_WORKTREE;
 	} else if ((errno != ENOENT) && (errno != ENOTDIR)) {
-		return error("%s: %s", new_name, strerror(errno));
+		return error_errno("%s", new_name);
 	}
 	return 0;
 }
@@ -4271,9 +4271,9 @@ static int add_index_file(struct apply_state *state,
 		if (!state->cached) {
 			if (lstat(path, &st) < 0) {
 				free(ce);
-				return error(_("unable to stat newly "
-					       "created file '%s': %s"),
-					     path, strerror(errno));
+				return error_errno(_("unable to stat newly "
+						     "created file '%s'"),
+						   path);
 			}
 			fill_stat_cache_info(ce, &st);
 		}
@@ -4327,7 +4327,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	strbuf_release(&nbuf);
 
 	if (close(fd) < 0 && !res)
-		return error(_("closing file '%s': %s"), path, strerror(errno));
+		return error_errno(_("closing file '%s'"), path);
 
 	return res ? -1 : 0;
 }
@@ -4525,7 +4525,7 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 
 	rej = fopen(namebuf, "w");
 	if (!rej)
-		return error(_("cannot open %s: %s"), namebuf, strerror(errno));
+		return error_errno(_("cannot open %s"), namebuf);
 
 	/* Normal git tools never deal with .rej, so do not pretend
 	 * this is a git patch by saying --git or giving extended
-- 
2.9.0.172.gfb57a78

