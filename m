Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0995E2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbcHHVEy (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34076 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbcHHVEq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so17868486wma.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jK9eb7tXozEwLonCDeow02xN5HH8eArGiIU8Jj5dom0=;
        b=NXqEIHUujJxLm3iQIjUtJCKo/oTXnzEuHdHc22QOCZeeivk88fe03X/VgcsYBAoMup
         9IRB/SweaYispeZUMvmZYuwP+CX8TYVQolt0TLOywn2BRGhbmVaM6vGKWPaq9ZnFQ93R
         73OwNZZYt+7zkssbjiPFMHneAltSb93XgUsWYm8xytb14Lsmz1wdxjF/675nja/AQSjy
         uhSsgbydVX7jmsiB1EWf7xs6hgPC6wzMF7MS3bJ3Go17Qv6H1i5dPB0EbNS9rQ9zN3W4
         2J8NkGFErGeE7sXp9l3eRYOBB5fyFzj5bfUrHxSiasie9UxSWOTBIV9uYvt7HvGuLVcE
         +2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jK9eb7tXozEwLonCDeow02xN5HH8eArGiIU8Jj5dom0=;
        b=iHqAAIVSjKmsPIA+jiK1Kh7O2bqSKCvc8NdFcNMe35yTT1k7UAiukpJpirFNLnkp+w
         0FJCSCFg524MhvF1QCLNLR3FA/B2xUPpt8+AG2OHOMJhrcBUX67nVKCFn7xSbMClWnSV
         WO0K2vONhr7BzpWgW18mIWnU3eBG2RQjkXv10ZVnjV8P4c4sKP+i943eUiFHyZvknc3i
         SP79wCAuh1+SuYyP90LGgAAjJz9eWCSUl20U/MdjQbgPCLsHBf6kuX2CqHAhkYzzurvF
         jB+2cIgNtz1ChnMhTQH7ZPTCLOjddW7U82uTmWTy1eNOueE56hLw+RMYEbuWE/AR0ZDu
         P8zQ==
X-Gm-Message-State: AEkoouuGAjvBlqr5sIFsCS7KpS8RZcx0q1wGTzEvYRkUaZ0+i1GE4NsdYjPgXdy989pPgw==
X-Received: by 10.28.98.197 with SMTP id w188mr16900053wmb.45.1470690285164;
        Mon, 08 Aug 2016 14:04:45 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:44 -0700 (PDT)
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
Subject: [PATCH v10 32/40] apply: use error_errno() where possible
Date:	Mon,  8 Aug 2016 23:03:29 +0200
Message-Id: <20160808210337.5038-33-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
index c0cb3f5..41a33d3 100644
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
@@ -4306,7 +4306,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	strbuf_release(&nbuf);
 
 	if (close(fd) < 0 && !res)
-		return error(_("closing file '%s': %s"), path, strerror(errno));
+		return error_errno(_("closing file '%s'"), path);
 
 	return res ? -1 : 0;
 }
@@ -4503,7 +4503,7 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 
 	rej = fopen(namebuf, "w");
 	if (!rej)
-		return error(_("cannot open %s: %s"), namebuf, strerror(errno));
+		return error_errno(_("cannot open %s"), namebuf);
 
 	/* Normal git tools never deal with .rej, so do not pretend
 	 * this is a git patch by saying --git or giving extended
-- 
2.9.2.614.g4980f51

