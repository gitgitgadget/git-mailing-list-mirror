Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8799C2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbcF0SZP (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36094 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbcF0SZL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id c82so26935882wme.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:24:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YVRONh/6iKUxXy80uHb2Al4qUphdJTBbQVmDuDJW0DA=;
        b=qikLGI+fCB4Hfi+v1mcqVCqaovytBU7n55esCndIv55KM/XhwolAPnwjxt5EIwqJXw
         U9O/mcl1Ne23jypCs7QrUSgfI54Dx/nUV72Zz1iU+Q2ttgM/LlqJZYuWo+T1jgqpqdnb
         3b3fMUzyEwiherw2qRbKnqp+Xwp7X3KaaqhxhIHVtxXXhNJtd0F9023cwqbBEUy7XDcl
         v9o7a9+iafWLJJAa3uSoT+KaOVoLMpC6U/5C+auYnmqOfgY35etReRfybYN2KJdqzMB4
         CJ5Jns8RXVxzNlc6DSJLflGEvVOHMSji9YLAmWDrwywS7d88lyXYVsXNALrWJhrO5D1T
         ZbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YVRONh/6iKUxXy80uHb2Al4qUphdJTBbQVmDuDJW0DA=;
        b=gO7SNJpGVJuahVTFbMSiTYCMCMft5fFjrCZ1qszHzzxJ0WhqEWGaspJTRPMF2crj2r
         rJX4BiF55Ho1gRb0sFOFogBLUh0gzW2Dy3Ffi5OWZyaOf/myIMo+A3hRMOkO7XZd8hVl
         OFVfAwEM42P5I/LoFigv3CgsNqHOHznE3+iS2KDmylo3BkK5XZBnDbe2s6LuAFNAgRkl
         RVEEeqJcshWVVMQq3wa+hpZie/3RDwF1tkGlPWvY2iQjkvEQVTSDl1PJoY1Q9NyymC60
         rYkx2XzwW/6qEWP6oiYfZuzwOvnbKNR+7BoZzfA/Y7qYYzXw83rtDQTM7ua83w/huEAy
         JcZw==
X-Gm-Message-State: ALyK8tIDH+tA3ulBSsTptt9Fe8rj2Gzy2F7lXRQJyxEsaqm+BW/mfJuoWiUdwstl4MUQMw==
X-Received: by 10.28.30.23 with SMTP id e23mr369142wme.66.1467051897319;
        Mon, 27 Jun 2016 11:24:57 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:24:56 -0700 (PDT)
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
Subject: [PATCH v8 05/41] builtin/apply: make find_header() return -128 instead of die()ing
Date:	Mon, 27 Jun 2016 20:23:53 +0200
Message-Id: <20160627182429.31550-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
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
index ba716c1..aff0d66 100644
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
2.9.0.172.gfb57a78

