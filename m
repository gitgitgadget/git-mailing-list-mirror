Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991611F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbcG3R1w (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35874 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so20019419wma.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=exoxhvcUyBviXPG2OaQP7B2weVrVqSkVwMAquvUb8mo=;
        b=Jdq0RaT/BChg9QLbpxBMB4r9M3/B4PtlnGJlTOdGrhxcOqnhn6HPlT6RVlW/ueEt+k
         cFH3of5cwPFdiLB0QzbBokYU67aElRhWIMc78cYxDzq5smQmAlfqZuQyoIwsIRc1i6hS
         ldD+tm4EuejNPj0HXxCQUDAqNfaNyjI3NWYUghq5dZHh7hLysl9sSJqXrgLkJKWKSvCt
         iaGHfZ1QTV/vhfbU+L+FWl/MQd/qHSkVFjzXTib1eysQaxQ5paAa+8xDPB6Vl+tx7w9n
         OvEb5QnbkaByuwEHwThqyXBGORqo4VSQ1eO6wH0p7J8WN7KtZBn2zwKwuyZsDAjf8Mrw
         qKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=exoxhvcUyBviXPG2OaQP7B2weVrVqSkVwMAquvUb8mo=;
        b=gU4l/+ug2hHHi3+fY9OgkPRcPEhrI3mYz9TBv3ArsvAlAB1XDTPs9iDrIpqcmQ9hU2
         WU82p4CWJ0Y6iEjXtKiX4Hfx5512BAJWzy0CKAsFSqxwPU58TDC+yevBrZjz484ndpXx
         ZRFg2CmUSPmEuZWkMYAOSQcgrSafuaGF/ZjMhxDYxWrymiQBWEeD8Gx748XpLqVUkxZV
         +kQ1iXDa/UatvPvcECkUDGyLUnazIbb8RaVgkdruSzN+4kG/k2tAk3a9ksxDOg2URHsi
         wKxgF6NXlJPhQtyGSpm6nXbbJzvjO8UvQSXQN+OjOcIgvORuFkb3gMfJZ/b8KanQCSdj
         zqOA==
X-Gm-Message-State: AEkoouvxRI6oqEh3h3ErPV7GzXZaFovBm0rSjsM3Tt6Rq/VIOdO+gE4pIY7MkdGMbGyUGg==
X-Received: by 10.28.182.84 with SMTP id g81mr6299062wmf.20.1469899583713;
        Sat, 30 Jul 2016 10:26:23 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:23 -0700 (PDT)
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
Subject: [PATCH v9 32/41] apply: use error_errno() where possible
Date:	Sat, 30 Jul 2016 19:25:00 +0200
Message-Id: <20160730172509.22939-33-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
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
index 12cad24..7ccb6b5 100644
--- a/apply.c
+++ b/apply.c
@@ -3497,7 +3497,7 @@ static int load_current(struct apply_state *state,
 	ce = active_cache[pos];
 	if (lstat(name, &st)) {
 		if (errno != ENOENT)
-			return error(_("%s: %s"), name, strerror(errno));
+			return error_errno("%s", name);
 		if (checkout_target(&the_index, ce, &st))
 			return -1;
 	}
@@ -3647,7 +3647,7 @@ static int check_preimage(struct apply_state *state,
 	} else if (!state->cached) {
 		stat_ret = lstat(old_name, st);
 		if (stat_ret && errno != ENOENT)
-			return error(_("%s: %s"), old_name, strerror(errno));
+			return error_errno("%s", old_name);
 	}
 
 	if (state->check_index && !previous) {
@@ -3669,7 +3669,7 @@ static int check_preimage(struct apply_state *state,
 	} else if (stat_ret < 0) {
 		if (patch->is_new < 0)
 			goto is_new;
-		return error(_("%s: %s"), old_name, strerror(errno));
+		return error_errno("%s", old_name);
 	}
 
 	if (!state->cached && !previous)
@@ -3728,7 +3728,7 @@ static int check_to_create(struct apply_state *state,
 
 		return EXISTS_IN_WORKTREE;
 	} else if ((errno != ENOENT) && (errno != ENOTDIR)) {
-		return error("%s: %s", new_name, strerror(errno));
+		return error_errno("%s", new_name);
 	}
 	return 0;
 }
@@ -4247,9 +4247,9 @@ static int add_index_file(struct apply_state *state,
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
@@ -4303,7 +4303,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	strbuf_release(&nbuf);
 
 	if (close(fd) < 0 && !res)
-		return error(_("closing file '%s': %s"), path, strerror(errno));
+		return error_errno(_("closing file '%s'"), path);
 
 	return res ? -1 : 0;
 }
@@ -4500,7 +4500,7 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 
 	rej = fopen(namebuf, "w");
 	if (!rej)
-		return error(_("cannot open %s: %s"), namebuf, strerror(errno));
+		return error_errno(_("cannot open %s"), namebuf);
 
 	/* Normal git tools never deal with .rej, so do not pretend
 	 * this is a git patch by saying --git or giving extended
-- 
2.9.2.558.gf53e569

