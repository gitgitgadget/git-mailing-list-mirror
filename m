Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3222018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbcHHVEE (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34731 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbcHHVEA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so17865142wma.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:03:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0hMsoZTeSk8TY/9W7yYQP0ilm08WQE5VCWYkos3qzHg=;
        b=pNSIjXEB3cBmfFekT4H7t9jFHnvvgNqb83Mie2PVu0+2lAoCXUTCMqWGevn731A0/b
         mxbad3hXGQ5qsAfJJY+YEtpwiH3G6L5ugCGKT+wNC1qPVpZOpBsrkBG/hgkfXYIU8T+q
         zDktZOb16cgwXipaZtQqjUVE5WskmCQN4HECcpwYCOnxn3jhtPgDkRMq9jx/B/6iEiW+
         KLNZ8xIlhZWW6GPYxIySDlN4IiNagjIz3KmCyU4j5QSUpC/IeuQlgqR0jN0qdrjTuj8L
         JEfgizihLtWAlofNQ4QEHTr7j9cRmbgYR9CfpJssIPGl8q8+jBAsthI8ZJAQOeWdotE5
         fiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0hMsoZTeSk8TY/9W7yYQP0ilm08WQE5VCWYkos3qzHg=;
        b=b1u0s4zr4udhIRd+T4WgbYWiGPDLwCbPuGxF/aoUaLtGjYGzANMiMjQthfIQ/iQ9l+
         0JHSmJe7akjfYDwvuUwd3jio25A9uT0lNA2EC21cit1AXVDx05b98P94Cp1Q+xkcBgUd
         blZ0FUYC7BgRWC9eN8RHeamkQMp13qw+NoBt5IJHsl2cIShTpyWh4iok8LU27Derdv+l
         zAa9mp+gNxaCjA3Kf6x6hi/RGdvJ4gWJ2SGmsXYhYVD2K+xzP0LYFhqo0tHI0XpPnHMT
         Zwp4gy6jRtPk9qNCv3VLUzbVRrojkXopc1GC8aI0b/ddTC41VNhbqbEeQQGCFP9z6Myv
         Vndg==
X-Gm-Message-State: AEkoouvkcgtKbXp3TNTO/p1YU0toF0/qadf1m6cMr2LIZwxHtWykuYq683bPI4IFsxuWoA==
X-Received: by 10.194.87.34 with SMTP id u2mr11109344wjz.118.1470690238787;
        Mon, 08 Aug 2016 14:03:58 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:03:58 -0700 (PDT)
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
Subject: [PATCH v10 05/40] builtin/apply: make find_header() return -128 instead of die()ing
Date:	Mon,  8 Aug 2016 23:03:02 +0200
Message-Id: <20160808210337.5038-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
index dd7afee..434ba0c 100644
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
2.9.2.614.g4980f51

