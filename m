Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ADB82021E
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932243AbcIDUTP (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34031 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932235AbcIDUTM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id w12so959176wmf.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YuBs/UMneaUAjTuM/ZFgmBcTWBHUsWDbeJq/wKintvM=;
        b=SkP9GwBr7m60EsvCIxHySHYrNNV8dmcF6fqxl5e6Xn6AhsYX/MSNZVs7sSW/ajZNvb
         zkXO5tdWJcz+ZzlkTY8Ub+6ecffXT7bvjjqKQeakC3bTmXq3hh9U4Z//KvL2BjYGFqel
         fpDcjTEOLGz+0faAeezDMinUbymHQ26hiHQWCfg2rnrIASseajZTB8MTNNwbtXfHhCfM
         AO5LdimGXd8HZLMOa8yeVKuNfbos94QdZLg8cOL7kEmrV3pfSsAeXQQtNXcS2SR2xYzc
         tKhxdt7HQNFHJ39DKzo+zoc/C3N9EvET7hYI8lMPMZ076L/tq1EoC9P4iLe1KCvI5nRz
         gMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YuBs/UMneaUAjTuM/ZFgmBcTWBHUsWDbeJq/wKintvM=;
        b=g8DS9NNTq5LFtU6YDfRizZ+0L65rY/PBbvG4JX//zAkdAo2V4GR7dQm4+Lv4LomjOB
         lHj66RQM2Xr3Tgz1flySy2BsB90zRLhowwaVwsOzyGXYpj5bkssSjpBTFguSXHVa/eX4
         rWpzl0TVEEGEW5AYpfPn1md+xlhEdlfWzB5k2STXnvrNsWPwSl5uD8ew2orlfMlhWwfb
         YAI9EqkV+XQHQOXtukKbxXdW6f5Xp6OlhqEwaChhGfHIMFosD8JskR7aiYSU82puH/Or
         L4uiwmDb3H4QGVPer6KPB5g/QnBXMUUYmmqjND/Cm8IGae3cE/wHPYpEum9SWT1hLBlg
         7xbA==
X-Gm-Message-State: AE9vXwN7BJJg/I21L8Pix0JrQQ7k3BQyioDPRJj04bx9VF1qqvxTQwrARRpmNH5ogaUKrA==
X-Received: by 10.28.141.76 with SMTP id p73mr11715369wmd.118.1473020350886;
        Sun, 04 Sep 2016 13:19:10 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:10 -0700 (PDT)
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
Subject: [PATCH v14 17/41] builtin/apply: make gitdiff_*() return -1 on error
Date:   Sun,  4 Sep 2016 22:18:09 +0200
Message-Id: <20160904201833.21676-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", gitdiff_*() functions should return -1 instead
of calling die().

A previous patch made it possible for gitdiff_*() functions to
return -1 in case of error. Let's take advantage of that to
make gitdiff_verify_name() return -1 on error, and to have
gitdiff_oldname() and gitdiff_newname() directly return
what gitdiff_verify_name() returns.

Helped-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index eb918e5..6b16173 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -827,54 +827,56 @@ static int gitdiff_hdrend(struct apply_state *state,
 #define DIFF_OLD_NAME 0
 #define DIFF_NEW_NAME 1
 
-static void gitdiff_verify_name(struct apply_state *state,
-				const char *line,
-				int isnull,
-				char **name,
-				int side)
+static int gitdiff_verify_name(struct apply_state *state,
+			       const char *line,
+			       int isnull,
+			       char **name,
+			       int side)
 {
 	if (!*name && !isnull) {
 		*name = find_name(state, line, NULL, state->p_value, TERM_TAB);
-		return;
+		return 0;
 	}
 
 	if (*name) {
 		int len = strlen(*name);
 		char *another;
 		if (isnull)
-			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
-			    *name, state->linenr);
+			return error(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
+				     *name, state->linenr);
 		another = find_name(state, line, NULL, state->p_value, TERM_TAB);
-		if (!another || memcmp(another, *name, len + 1))
-			die((side == DIFF_NEW_NAME) ?
+		if (!another || memcmp(another, *name, len + 1)) {
+			free(another);
+			return error((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
 			    _("git apply: bad git-diff - inconsistent old filename on line %d"), state->linenr);
+		}
 		free(another);
 	} else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
-			die(_("git apply: bad git-diff - expected /dev/null on line %d"), state->linenr);
+			return error(_("git apply: bad git-diff - expected /dev/null on line %d"), state->linenr);
 	}
+
+	return 0;
 }
 
 static int gitdiff_oldname(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	gitdiff_verify_name(state, line,
-			    patch->is_new, &patch->old_name,
-			    DIFF_OLD_NAME);
-	return 0;
+	return gitdiff_verify_name(state, line,
+				   patch->is_new, &patch->old_name,
+				   DIFF_OLD_NAME);
 }
 
 static int gitdiff_newname(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	gitdiff_verify_name(state, line,
-			    patch->is_delete, &patch->new_name,
-			    DIFF_NEW_NAME);
-	return 0;
+	return gitdiff_verify_name(state, line,
+				   patch->is_delete, &patch->new_name,
+				   DIFF_NEW_NAME);
 }
 
 static int gitdiff_oldmode(struct apply_state *state,
-- 
2.10.0.41.g9df52c3

