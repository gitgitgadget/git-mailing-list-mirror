Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A7DA2024E
	for <e@80x24.org>; Thu,  3 May 2018 15:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeECPbG (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:31:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:49031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeECPbA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:31:00 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MfmZs-1f2FeO36YO-00NDaP; Thu, 03 May 2018 17:30:57 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/18] branch-diff: use color for the commit pairs
Date:   Thu,  3 May 2018 17:30:55 +0200
Message-Id: <c89937afc2820bb105f59963176a2024e79d6095.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OdXgJ+WitNcV5jF/K/X514XxcoPM/oEhVKOihNmdkl6dtAtGWRF
 sH+oMMfbSmoxEsnYtmkbs7RuzmqJwJYXThIz01noPspAq1VHXR3Jl5owXw3cKnNcbQRLoNe
 o3EK9Hut+T/HRb1WVAwIPuGNPkviDKIMwZGyzdVZ9D5Uhq3ltL7cRe2zh13e5XSZQGus5u8
 zHsmpupW5kvZ4qVpeSefQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i13mkCR9rVk=:q0q7uGjy9tc3NdwdPs4awQ
 z/WgmZ4pRarFVXpvjkZcmDZHfQgkbXyK2/jSIHKNUzn+AIk9Kw4RygiLtnjvhLEi27G/sy7nx
 LMLyK/yvBd94/REIlwfuxMRu7XDUF6FppXGelFIbSjpTdQP2pL732vDEwKo5KiPtCB8SPt3Gt
 sLgwKJgK3xEpX15yryV1SV82o2FKfaDDrRIXCctmWhl3FGc5pqNUxeiMP9cjfWzQ1OteVlGVL
 8W9b7++9JBG/nBuO5z/oZr6xGnWWp4Tr0Z43Mq/oM+9ow3PPEVFjXYCqKFgmE7i31j82MmVYH
 eSKlgxDJR25PU8FQiek19Jiwl45799p6bKwuwrJC6/qORWalZaTetkIQXfErhJstgcDQJSUUH
 Y0mNZFyaTAH/vjlyMtfhDo81Cmt2mzFDx2RmuenJEMnaMC+Wz6FP7C2Vly3Ruq2cYcmfAPJ4R
 MmJuMy12HfYLiqDQaQxllz9bctX+9k56ONUdSWvF+XuaG52jzgS8SHAVBX8zQbgL/Tn+LATmt
 5ctxirWJDxN+wGOkf8dDK3bAf1jIZgrp/DixirTwF8C6gtPVNl1cMrJ7ugsApF+7iTqSa/ImD
 rHEf5KKz+b8N1q/SUEWOqQLm3gl5i4rl8bgp6TnALiueUph8DxAqv7SsUodOteilOLQ9GBpeO
 2jamuAGVLhmZ7CqIAziiVfHBPRNAZBwIYGOlr8O0y8XH3SVyV9+CLaOLuwVoMCDNUXlLVWJcX
 eDG8IdjSvtCKrdvFXTokruevcQu/2SCYUxf8+gX+FDESEfLGl0nlFqews8paUik/xiG8c32SL
 vG+xOJo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Arguably the most important part of branch-diff's output is the list of
commits in the two branches, together with their relationships.

For that reason, tbdiff introduced color-coding that is pretty
intuitive, especially for unchanged patches (all dim yellow, like the
first line in `git show`'s output) vs modified patches (old commit is
red, new commit is green). Let's imitate that color scheme.

While at it, also copy tbdiff's change of the fragment color to magenta.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 49 +++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 7625da09e6f..e505b696d11 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -270,13 +270,19 @@ static int get_correspondences(struct string_list *a, struct string_list *b,
 	return res;
 }
 
-static void output_pair_header(struct strbuf *buf,
+static void output_pair_header(struct diff_options *diffopt, struct strbuf *buf,
 			       int i, struct patch_util *a_util,
 			       int j, struct patch_util *b_util)
 {
 	static char *dashes;
 	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
 	struct commit *commit;
+	char status;
+	const char *color_reset = diff_get_color_opt(diffopt, DIFF_RESET);
+	const char *color_old = diff_get_color_opt(diffopt, DIFF_FILE_OLD);
+	const char *color_new = diff_get_color_opt(diffopt, DIFF_FILE_NEW);
+	const char *color_commit = diff_get_color_opt(diffopt, DIFF_COMMIT);
+	const char *color;
 
 	if (!dashes) {
 		char *p;
@@ -286,21 +292,33 @@ static void output_pair_header(struct strbuf *buf,
 			*p = '-';
 	}
 
+	if (j < 0) {
+		color = color_old;
+		status = '<';
+	} else if (i < 0) {
+		color = color_new;
+		status = '>';
+	} else if (strcmp(a_util->patch, b_util->patch)) {
+		color = color_commit;
+		status = '!';
+	} else {
+		color = color_commit;
+		status = '=';
+	}
+
 	strbuf_reset(buf);
+	strbuf_addstr(buf, status == '!' ? color_old : color);
 	if (i < 0)
 		strbuf_addf(buf, "-:  %s ", dashes);
 	else
 		strbuf_addf(buf, "%d:  %s ", i + 1,
 			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
 
-	if (i < 0)
-		strbuf_addch(buf, '>');
-	else if (j < 0)
-		strbuf_addch(buf, '<');
-	else if (strcmp(a_util->patch, b_util->patch))
-		strbuf_addch(buf, '!');
-	else
-		strbuf_addch(buf, '=');
+	if (status == '!')
+		strbuf_addf(buf, "%s%s", color_reset, color);
+	strbuf_addch(buf, status);
+	if (status == '!')
+		strbuf_addf(buf, "%s%s", color_reset, color_new);
 
 	if (j < 0)
 		strbuf_addf(buf, " -:  %s", dashes);
@@ -313,12 +331,15 @@ static void output_pair_header(struct strbuf *buf,
 		const char *commit_buffer = get_commit_buffer(commit, NULL);
 		const char *subject;
 
+		if (status == '!')
+			strbuf_addf(buf, "%s%s", color_reset, color);
+
 		find_commit_subject(commit_buffer, &subject);
 		strbuf_addch(buf, ' ');
 		format_subject(buf, subject, " ");
 		unuse_commit_buffer(commit, commit_buffer);
 	}
-	strbuf_addch(buf, '\n');
+	strbuf_addf(buf, "%s\n", color_reset);
 
 	fwrite(buf->buf, buf->len, 1, stdout);
 }
@@ -381,21 +402,21 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			output_pair_header(&buf, i, a_util, -1, NULL);
+			output_pair_header(diffopt, &buf, i, a_util, -1, NULL);
 			i++;
 			continue;
 		}
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			output_pair_header(&buf, -1, NULL, j, b_util);
+			output_pair_header(diffopt, &buf, -1, NULL, j, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
 
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			output_pair_header(&buf,
+			output_pair_header(diffopt, &buf,
 					   b_util->matching, a_util, j, b_util);
 			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
 				patch_diff(a->items[b_util->matching].string,
@@ -427,6 +448,8 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 	struct string_list branch1 = STRING_LIST_INIT_DUP;
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
 
+	git_diff_basic_config("diff.color.frag", "magenta", NULL);
+
 	diff_setup(&diffopt);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
 	diffopt.flags.suppress_diff_headers = 1;
-- 
2.17.0.395.g6a618d6010f.dirty


