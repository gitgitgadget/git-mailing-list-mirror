Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ADED1F955
	for <e@80x24.org>; Sat, 30 Jul 2016 17:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbcG3RZi (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:25:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33118 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbcG3RZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:25:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so20038651wme.0
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:25:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zYC67kRsJdKG385ttLIcjMHlsLzlJUJS4QUDe6l7Uxc=;
        b=Fw8893YbcGQTkjTVB+65xe4Xrhr9slbzcimeejFNSQhvuSdFh26KbF+QxFRBN3MSio
         RNxSlLRihG6Qditkos38IELMxFwfrrwkthtkb6wuEiuOJGbMKOlFsv+Qqt21qRW2ruNn
         3VJQH+bs4UqqQ9x/Uc+KjEoOAV+xmmRDjKeTuO2TwF8r4/ZgSkAouY6y0IEHbJ5SlqJ+
         6GaAV+mxNT+DQJyL0LD0Zt216rfK8WHYc5CQR5Ouhuhcr3dIROlnA54KC10/zJSd7+4r
         HAaAEFMHHX8/s05+9a872NRV8BcMJT+8UEZ8iR+fPPfutuPkm3oCfmBGOVOXC74iE6C5
         RxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zYC67kRsJdKG385ttLIcjMHlsLzlJUJS4QUDe6l7Uxc=;
        b=IM8NGsprtVeicbrYs5cfv5DOmci20Gkd25VXGUy/GEx2awaDEjyJXdpcwSwOzC4HMc
         lrjBTQOAReYrCaApFx4ZbLAlP3Mxu2G/YZ7eg4NFFjnqBzQqjMA2uh7+GIrN/9kOfig6
         z/XKDroh1Kd2bVLPngw9eyCd8QAawgTjj7Vp1fkmLwM4EQxnT4ouB4y6Y5EVTEAUGTcl
         +m0M6teLDkc2rya9CVQ8GBWExlHCW2ePY1WY8Hgz7NGQIMXI91uPMoqgbLoAY6vV6tVe
         hkP0Du1Np3RLebCbfJpLJrUq3l0KFSeXB71q46TDdYO8RCKG+8zOvGnCRUW0X9Wbms18
         VswQ==
X-Gm-Message-State: AEkoouutZrER48XyrGMcIRRYgKH5E9mbJKvsRZj7MOtB6e9Y241cWLPsnKk6osiUvfSsmg==
X-Received: by 10.28.128.15 with SMTP id b15mr50863221wmd.100.1469899529913;
        Sat, 30 Jul 2016 10:25:29 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:29 -0700 (PDT)
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
Subject: [PATCH v9 05/41] builtin/apply: make find_header() return -128 instead of die()ing
Date:	Sat, 30 Jul 2016 19:24:33 +0200
Message-Id: <20160730172509.22939-6-chriscool@tuxfamily.org>
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
in builtin/apply.c, let's make find_header() return -128 instead of
calling die().

We could make it return -1, unfortunately find_header() already
returns -1 when no header is found.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c       | 40 ++++++++++++++++++++++++++++------------
 t/t4254-am-corrupt.sh |  2 +-
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e710ef7..9e78758 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1419,6 +1419,14 @@ static int parse_fragment_header(const char *line, int len, struct fragment *fra
 	return offset;
 }
 
+/*
+ * Find file diff header
+ *
+ * Returns:
+ *  -1 if no header was found
+ *  -128 in case of error
+ *   the size of the header in bytes (called "offset") otherwise
+ */
 static int find_header(struct apply_state *state,
 		       const char *line,
 		       unsigned long size,
@@ -1452,8 +1460,9 @@ static int find_header(struct apply_state *state,
 			struct fragment dummy;
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
-			die(_("patch fragment without header at line %d: %.*s"),
-			    state->linenr, (int)len-1, line);
+			error(_("patch fragment without header at line %d: %.*s"),
+				     state->linenr, (int)len-1, line);
+			return -128;
 		}
 
 		if (size < len + 6)
@@ -1468,19 +1477,23 @@ static int find_header(struct apply_state *state,
 			if (git_hdr_len <= len)
 				continue;
 			if (!patch->old_name && !patch->new_name) {
-				if (!patch->def_name)
-					die(Q_("git diff header lacks filename information when removing "
-					       "%d leading pathname component (line %d)",
-					       "git diff header lacks filename information when removing "
-					       "%d leading pathname components (line %d)",
-					       state->p_value),
-					    state->p_value, state->linenr);
+				if (!patch->def_name) {
+					error(Q_("git diff header lacks filename information when removing "
+							"%d leading pathname component (line %d)",
+							"git diff header lacks filename information when removing "
+							"%d leading pathname components (line %d)",
+							state->p_value),
+						     state->p_value, state->linenr);
+					return -128;
+				}
 				patch->old_name = xstrdup(patch->def_name);
 				patch->new_name = xstrdup(patch->def_name);
 			}
-			if (!patch->is_delete && !patch->new_name)
-				die("git diff header lacks filename information "
-				    "(line %d)", state->linenr);
+			if (!patch->is_delete && !patch->new_name) {
+				error("git diff header lacks filename information "
+					     "(line %d)", state->linenr);
+				return -128;
+			}
 			patch->is_toplevel_relative = 1;
 			*hdrsize = git_hdr_len;
 			return offset;
@@ -1996,6 +2009,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 	int hdrsize, patchsize;
 	int offset = find_header(state, buffer, size, &hdrsize, patch);
 
+	if (offset == -128)
+		exit(128);
+
 	if (offset < 0)
 		return offset;
 
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 85716dd..9bd7dd2 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -29,7 +29,7 @@ test_expect_success 'try to apply corrupted patch' '
 '
 
 test_expect_success 'compare diagnostic; ensure file is still here' '
-	echo "fatal: git diff header lacks filename information (line 4)" >expected &&
+	echo "error: git diff header lacks filename information (line 4)" >expected &&
 	test_path_is_file f &&
 	test_cmp expected actual
 '
-- 
2.9.2.558.gf53e569

