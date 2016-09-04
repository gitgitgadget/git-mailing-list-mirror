Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8681D1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932389AbcIDUTx (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34171 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbcIDUTo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id w12so960407wmf.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6+xhYy9ahxOYY3hVff5yyH8xJu9ruPlFzYm+qooGSy8=;
        b=qsBBtFNxEYk2OUw4z6JTHIjhtQMzX0MRFps9R4VcPtAW5A8gSit3LQVH8h08K1Z0Vq
         hR35ClPpD4zhtacbsw83Clgbiv2RYbaclQP0Y7vZl7x75IbMpSKVfKeaIyt61Cm9xb3h
         oBFnRAfdG7vr691r6cH74RPqq7PK/+DAF5NjMlqr4hpHw4frUQ+T6BpcT+qk57spReqr
         EWfVX8XaRekAxq1Xg1+OqwQ/zPVOGYDPOFVMVotfj6JqsimkR+sB71bgsfZIetJNqEJP
         4OzAhE+JQATNtcvmXrqADsbhkJ6auJNEzgd1GKgaIDblVsVat7/yUi+Ms5A9IeEkmWqi
         qxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6+xhYy9ahxOYY3hVff5yyH8xJu9ruPlFzYm+qooGSy8=;
        b=M7Ye2CLNf3gc74ohRH9ngQGqcRyG0gALz8Ul5Uvt6eQv/olaOJFYn2G1vZVbkMVRcN
         8UN5Spoqk57Fk4L2+NnXPOjq194ja2fQCPgDfMceNFzdluNGUwUiSIzwFKhAe9QtzzC7
         e9G1Kk+7atJoeNtd1DB6PBCHKt1KoYbpArjTaYSfRLY0urTO12RTlTO5VfpB8+UoMQ5N
         fuFRMN8MWb8Tv1+YLhOdQDUqHY1loQtTKzA7QezCXpX/VpYPr2pv6AxUOAQysJTHCQXS
         rX+qJ/MtBmQ3DSFtHm/ZWFiQleJP6rKCb/zSt76WAY7o0Kk7+edhE/vZATCgrmK5y+9q
         4i0g==
X-Gm-Message-State: AE9vXwPLisEEU3aXdCATiY5p5wdW0vbe5M15AnWROhY1mhj2oJ/Gqtcx1CRcSw1kuxgspw==
X-Received: by 10.28.12.76 with SMTP id 73mr11722768wmm.118.1473020383240;
        Sun, 04 Sep 2016 13:19:43 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:41 -0700 (PDT)
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
Subject: [PATCH v14 32/41] apply: use error_errno() where possible
Date:   Sun,  4 Sep 2016 22:18:24 +0200
Message-Id: <20160904201833.21676-33-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid possible mistakes and to uniformly show the errno
related messages, let's use error_errno() where possible.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index a4dfc64..41a33d3 100644
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
@@ -4503,7 +4503,7 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 
 	rej = fopen(namebuf, "w");
 	if (!rej)
-		return error(_("cannot open %s: %s"), namebuf, strerror(errno));
+		return error_errno(_("cannot open %s"), namebuf);
 
 	/* Normal git tools never deal with .rej, so do not pretend
 	 * this is a git patch by saying --git or giving extended
-- 
2.10.0.41.g9df52c3

