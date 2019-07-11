Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCFBF1F4B6
	for <e@80x24.org>; Thu, 11 Jul 2019 16:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfGKQJD (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:09:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55460 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKQJD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 12:09:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so6233358wmj.5
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIbXyTxlwMdejKMx7NpVdVDXqC/2s+5mFLjBN4bTADg=;
        b=ZhtZHPllbfH29idDseyqtZZkGThCNKZGcezu/ILOCOEfYYn9UrEd5/J2IY3cnm2Dn6
         g1/8WJa4XnDkWPfULgUHrPG2vndj28I91zuS+vZv4H15CqiEocxp5u67V/Os0cS1RTU2
         d5rEg9KYoGZ8gtghqmszdRj6X2ATc9HwT+g4sEd0RqpCwjYfmrHVMbJEuKDWdjKCx/lA
         MfuFuVmEdYXgQ8FUV2zXrH7JUtS5eP5OJEl/50+ZkU0cSrA7qlgRd2Rw7OZsQunXmYjq
         G2yNYWqP3g+5iz/3LoMfjLNR9+W0tA8+UVYsPxres4Q9Xlwc5QHqnLAtdoGGGk/4Ferp
         qJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIbXyTxlwMdejKMx7NpVdVDXqC/2s+5mFLjBN4bTADg=;
        b=CBqUyIj/cs4CJeHH2CjUbYXPFmi3FKohqD325UoCLeKb83tJsCDoOtwmcXWMkwiIRq
         /69vEWKQ58dQPfIMZDgv2ZW0T9firDhFgj3rjAz2hk5IwDZV+3f91DgSJSAgWwtlOUfd
         QoamclvLWdgBtPmua8f2/YZYFd3dLcBrIbGfb+Nl/7FZ/gpLg0u2vig2fv+R/pjHnAsQ
         yjDj58VYIS1efDeCu8PmQ2e3MEJmJ06PdMiRee3YagmyoWtIG43S0O1VlHnOygok7iAY
         7pKV3FohynKo/S58LY7sUEddqz/jYeKfhUQtMr3SB4XpoaQ/zUwwjjg0DPYAUajoVh0Z
         UKFg==
X-Gm-Message-State: APjAAAU3t5tA18Fji+BzimY2NZtbRlYvQ1HL7daHuLBlqhz2cTcMBCUW
        PaGmPyipyK6WhXLrjVUVZwzK1PeMd/A=
X-Google-Smtp-Source: APXvYqwlYsrebjnXPh5wHBUvztz0HIzx+sRvu0QZJOKbEbH+vO+rQrM2Jkf/clJykJ1roNDNn6bMyg==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74mr5216997wme.9.1562861340734;
        Thu, 11 Jul 2019 09:09:00 -0700 (PDT)
Received: from localhost (host232-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.232])
        by smtp.gmail.com with ESMTPSA id u1sm6104679wml.14.2019.07.11.09.08.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:09:00 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 02/14] apply: only pass required data to skip_tree_prefix
Date:   Thu, 11 Jul 2019 17:08:39 +0100
Message-Id: <20190711160851.14380-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190711160851.14380-1-t.gummerer@gmail.com>
References: <20190708163315.29912-1-t.gummerer@gmail.com>
 <20190711160851.14380-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the 'skip_tree_prefix()' function takes 'struct apply_state'
as parameter, even though it only needs the p_value from that struct.

This function is in the callchain of 'parse_git_header()', which we
want to make more generally useful in a subsequent commit.  To make
that happen we only want to pass in the required data to
'parse_git_header()', and not the whole 'struct apply_state', and thus
we want functions in the callchain of 'parse_git_header()' to only
take arguments they really need.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 apply.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/apply.c b/apply.c
index 599cf8956f..fc7083fcbc 100644
--- a/apply.c
+++ b/apply.c
@@ -1137,17 +1137,17 @@ static int gitdiff_unrecognized(struct apply_state *state,
  * Skip p_value leading components from "line"; as we do not accept
  * absolute paths, return NULL in that case.
  */
-static const char *skip_tree_prefix(struct apply_state *state,
+static const char *skip_tree_prefix(int p_value,
 				    const char *line,
 				    int llen)
 {
 	int nslash;
 	int i;
 
-	if (!state->p_value)
+	if (!p_value)
 		return (llen && line[0] == '/') ? NULL : line;
 
-	nslash = state->p_value;
+	nslash = p_value;
 	for (i = 0; i < llen; i++) {
 		int ch = line[i];
 		if (ch == '/' && --nslash <= 0)
@@ -1184,7 +1184,7 @@ static char *git_header_name(struct apply_state *state,
 			goto free_and_fail1;
 
 		/* strip the a/b prefix including trailing slash */
-		cp = skip_tree_prefix(state, first.buf, first.len);
+		cp = skip_tree_prefix(state->p_value, first.buf, first.len);
 		if (!cp)
 			goto free_and_fail1;
 		strbuf_remove(&first, 0, cp - first.buf);
@@ -1201,7 +1201,7 @@ static char *git_header_name(struct apply_state *state,
 		if (*second == '"') {
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail1;
-			cp = skip_tree_prefix(state, sp.buf, sp.len);
+			cp = skip_tree_prefix(state->p_value, sp.buf, sp.len);
 			if (!cp)
 				goto free_and_fail1;
 			/* They must match, otherwise ignore */
@@ -1212,7 +1212,7 @@ static char *git_header_name(struct apply_state *state,
 		}
 
 		/* unquoted second */
-		cp = skip_tree_prefix(state, second, line + llen - second);
+		cp = skip_tree_prefix(state->p_value, second, line + llen - second);
 		if (!cp)
 			goto free_and_fail1;
 		if (line + llen - cp != first.len ||
@@ -1227,7 +1227,7 @@ static char *git_header_name(struct apply_state *state,
 	}
 
 	/* unquoted first name */
-	name = skip_tree_prefix(state, line, llen);
+	name = skip_tree_prefix(state->p_value, line, llen);
 	if (!name)
 		return NULL;
 
@@ -1243,7 +1243,7 @@ static char *git_header_name(struct apply_state *state,
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail2;
 
-			np = skip_tree_prefix(state, sp.buf, sp.len);
+			np = skip_tree_prefix(state->p_value, sp.buf, sp.len);
 			if (!np)
 				goto free_and_fail2;
 
@@ -1287,7 +1287,7 @@ static char *git_header_name(struct apply_state *state,
 			 */
 			if (!name[len + 1])
 				return NULL; /* no postimage name */
-			second = skip_tree_prefix(state, name + len + 1,
+			second = skip_tree_prefix(state->p_value, name + len + 1,
 						  line_len - (len + 1));
 			if (!second)
 				return NULL;
-- 
2.22.0.510.g264f2c817a

