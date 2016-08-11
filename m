Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4061203C1
	for <e@80x24.org>; Thu, 11 Aug 2016 18:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbcHKSq4 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:46:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34312 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbcHKSqy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:46:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so868845wma.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:46:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1H03CUghNzhrYUPd6ljzd9rSxJW7aDwSzA2D1F4dDQc=;
        b=xdL0sFaSBEhNj4Kg9MITua/vHE/cuETyBPnrOHrERyfKhwvdBfK3NHQKg/LSBdfG/Z
         jqfXbmuZkDWa4JmJH/vPi7VbPDyNe35cc5ZqkWGGPW/M4R8tXa8Wn13AmSvETViNb+nQ
         vCuruQ9fKcETxdf284zk4T+Kjr1BrXfDFo7n1BI9spXV0gOtm/stdOUuCd1lq9OgboK+
         nEUuTv0PQq1fPkXZKcD8LRKHb7dmpcRe/5836+olHaUyW0CtQ5C+/XPR2EMVgS8NbDxt
         lBnKSoQ4pwRJNkx6kvgRHnImUCFjt9EO34onFwTMIbvmjdYc93DRQfKgr90KR/T9t2Ak
         Zgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1H03CUghNzhrYUPd6ljzd9rSxJW7aDwSzA2D1F4dDQc=;
        b=XTpQa2hFLBmpGQySwtTOhIKVRy7igUK0f7209vfk2JQRQ1fppd562fBZ/S1okt0Owp
         TT/2oC1sV2OI8X0IknlFfqBmYdksVNgzEhC9nUr93V2mkidVSJAKFVMMHS6ozCnf8ftD
         2+F320MehjsN6iNpdxn+gPLEnJplGLdzlDhG2DdRLggIw4Cpw1kjCAuo7H6oUARZy1FG
         HSxHBQjLU/XzgybMQA3gvPr4Lnyh6FcnYoQ1jmbUtWfYfEullhIMzd3qkbsY19MLmO3h
         mjbmegrkA1LN+B1QhXygD2O/bhPfY99MF4z6KIxp4uMgthHVreyuK5hrGILtmCnB2WKi
         HXdQ==
X-Gm-Message-State: AEkooutvJpTECu1qZ6FP6hcNPb1lGyqt/RCFGN7IDEVmm+WeCwYBnv0bVWBXYrq+tyRUCg==
X-Received: by 10.28.139.144 with SMTP id n138mr11188575wmd.71.1470941212227;
        Thu, 11 Aug 2016 11:46:52 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id 190sm1047236wmk.13.2016.08.11.11.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 11:46:51 -0700 (PDT)
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
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 05/13] apply: use error_errno() where possible
Date:	Thu, 11 Aug 2016 20:44:53 +0200
Message-Id: <20160811184501.384-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.769.gc0f0333
In-Reply-To: <20160811184501.384-1-chriscool@tuxfamily.org>
References: <20160811184501.384-1-chriscool@tuxfamily.org>
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
2.9.2.769.gc0f0333

