Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5D72018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbcF0S04 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33915 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbcF0SZP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id 187so26961916wmz.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uoz3x1IStxF482NdQY2ZeE1EDKEO3gzwGAwI8/jOnkM=;
        b=W6UtKaHz2M19G42KLM3qp9dpsrf+fZze1u43K/1ZgRhp8GggZqbMyX1pBxQzlhXoaz
         cBCDqWVIr3xsAAgU9LBGNmY6JcLLJ/pdXTmPtC40RE4H/tVoedmBpKO98XkT7LqtYYcM
         uRwWyn5m5g7U0CI8inR88s0Co80pEciBfZdv4lCL0MLoh/zpD+69UIkSXybEI2QXQ0In
         UIIdtVOJEVygcuZkQWA1kXwDBedm85V9KHgHhZ5heM0jSOLbEmMLCtOpL129fXy7w7Gq
         3FcUUvV5xeMuhfufIDxlvc2PpQ1LqcU1mux3YsjfSR9ZcVeR19QgixlKttsJVRG1DUOF
         wdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uoz3x1IStxF482NdQY2ZeE1EDKEO3gzwGAwI8/jOnkM=;
        b=D2WrumzNLxXyNwaZATor5yF32QgLc3JpX3kudjINWnENfE8mf6MjApTOwWZSyudQaw
         4h7tlzJiNghpDMajsxMpLYk/UHYK/EQ7dhHySIaNVa5L6dY32GDu8L/rvc9iEgpoHDhV
         jQQnrShsHc7zDgIjmGY41mv3xrjB64aFD01cMxq4Ud+amVaWB7I0YYjtmIjUDd8eQEie
         H39CVzui4uSac40kyME62aIqDydx6uU1NjiM9K4lL6iOv7hiYd6jZ77p20D1ZSedu2uC
         hV0h0vN1gfKlgmzTmSk4A8BTdy/LqeBrCZkXbFH8eorRsgsWnHSYbRYoNazdc32t0Tr9
         /8iw==
X-Gm-Message-State: ALyK8tKqykqARU6pqbAz7PGN3yfKPpkz8Ci8GhP8LVZck3cIJbOTctvYzoO1D6a2Yas0PA==
X-Received: by 10.28.189.215 with SMTP id n206mr12307389wmf.76.1467051913717;
        Mon, 27 Jun 2016 11:25:13 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:12 -0700 (PDT)
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
Subject: [PATCH v8 17/41] builtin/apply: make gitdiff_*() return -1 on error
Date:	Mon, 27 Jun 2016 20:24:05 +0200
Message-Id: <20160627182429.31550-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index 0bed352..b48b526 100644
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
2.9.0.172.gfb57a78

