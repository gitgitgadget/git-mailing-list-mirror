Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33E1C200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeEDPfF (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:35:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:59173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751419AbeEDPe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:34:56 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MWTfu-1eqqgd3yNG-00Xf27; Fri, 04 May 2018 17:34:50 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/18] branch-diff: adjust the output of the commit pairs
Date:   Fri,  4 May 2018 17:34:49 +0200
Message-Id: <0e4c8279e467e2e75864bcce8ec90cf4f81c2c34.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WG6hfzI/ZJvrPBIcCdPYasGnyT5dxB3Ll7SkFzhHFsgd38DZGhz
 yCKruRrPEHM/Md788e7rmV6GQsCyp6TAVFwzStggTDCRf1GzFpBGN20liZQ9Jproy5ZGaUu
 42ktqkR07uDyXZZDlGLAz6HhWaP9q98NJxH0Zd2TunA1Kocn7/YjQUTqwU9wvLkN4DH4nTE
 cnMyLohk4d1IXiXBdpWNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q7acQS+TGVo=:XF9DQJlW4My9D8JUMch5kr
 bUTcb0FXtTfAWauV4Z83fyJTnUbsdAP6xt0sUeqT2OP1l2vIpg4PaA5Wt2ZlB3U63lfBU81ME
 BEIuTW97JjdMIBRf66Viy1F4Z9QyXBm8d61e1rGfxw0a2hR18Z3celai3vIhHUB9e3aY6C+ky
 ud9f3K6FhxGdlmsKvpVwka62BFVInDvMFjTQR8vqm2lajl6GgJG/jbASDbnRAzJeS03yjD8+d
 241a5zDRb3kgFUSQSUCxxtb8mNtbQCXzDsrp+T2p7zJkBCynJhmQyjgi7UPInOE+vRvzESR1k
 yPgVeZJ+bOIEQyeHGJrBnYHMcyQHkR+57T47VLrrSda0Wp4JkJE0+MTrF1+SfxuyiCKhuV0B3
 Uexzr+Tw6+uXaJ0HLIM2viH7i01lIg+ml16ksVAB1oCTdjapBI4q6g3IowqX6hK74sctY1grv
 jJVlIT2ZSsifstCQ7azJrsNtMVyFwg+0EE5l6GDRHNuAaTXErkvIbLlmF9o5ET3UfH2e+OdR1
 MWZKv4U5xJMB3mAG+kfmIO6IQzTxVZPRp0Pj78Sjo3FUnA//ftwbGMBsSnepC0EDI09QB8tZz
 dQQYkxUBoQogsJV/8Tg0ezymcFlFlKtKDtq2+MmtcKvv6h5XWapOaf+79MLtK/iWtihkW9kYp
 0xMzQT+6EyqOvgohnUPHfk9xfJ31joF13I95Y5FZeOrwe2p9nlyfCZMsW4aHds3ykZY3aUsXK
 ESZ4SBjNlGymDuzmNALzN0YweTgkQeVUS/2Ug+PohSsEArKwWMST5zbX3r/4mGXZOnyis2SaN
 Tg0grs5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change brings branch-diff yet another step closer to feature parity
with tbdiff: it now shows the oneline, too, and indicates with `=` when
the commits have identical diffs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 67 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index ed520d6229d..5b187890bdf 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -9,6 +9,8 @@
 #include "hungarian.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "commit.h"
+#include "pretty.h"
 
 static const char * const builtin_branch_diff_usage[] = {
 N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
@@ -270,9 +272,57 @@ static int get_correspondences(struct string_list *a, struct string_list *b,
 	return res;
 }
 
-static const char *short_oid(struct patch_util *util)
+static void output_pair_header(struct strbuf *buf,
+			       int i, struct patch_util *a_util,
+			       int j, struct patch_util *b_util)
 {
-	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
+	static char *dashes;
+	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
+	struct commit *commit;
+
+	if (!dashes) {
+		char *p;
+
+		dashes = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));
+		for (p = dashes; *p; p++)
+			*p = '-';
+	}
+
+	strbuf_reset(buf);
+	if (i < 0)
+		strbuf_addf(buf, "-:  %s ", dashes);
+	else
+		strbuf_addf(buf, "%d:  %s ", i + 1,
+			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
+
+	if (i < 0)
+		strbuf_addch(buf, '>');
+	else if (j < 0)
+		strbuf_addch(buf, '<');
+	else if (strcmp(a_util->patch, b_util->patch))
+		strbuf_addch(buf, '!');
+	else
+		strbuf_addch(buf, '=');
+
+	if (j < 0)
+		strbuf_addf(buf, " -:  %s", dashes);
+	else
+		strbuf_addf(buf, " %d:  %s", j + 1,
+			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
+
+	commit = lookup_commit_reference(oid);
+	if (commit) {
+		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *subject;
+
+		find_commit_subject(commit_buffer, &subject);
+		strbuf_addch(buf, ' ');
+		format_subject(buf, subject, " ");
+		unuse_commit_buffer(commit, commit_buffer);
+	}
+	strbuf_addch(buf, '\n');
+
+	fwrite(buf->buf, buf->len, 1, stdout);
 }
 
 static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
@@ -306,6 +356,7 @@ static void patch_diff(const char *a, const char *b,
 static void output(struct string_list *a, struct string_list *b,
 		   struct diff_options *diffopt)
 {
+	struct strbuf buf = STRBUF_INIT;
 	int i = 0, j = 0;
 
 	/*
@@ -327,25 +378,22 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			printf("%d: %s < -: --------\n",
-			       i + 1, short_oid(a_util));
+			output_pair_header(&buf, i, a_util, -1, NULL);
 			i++;
 			continue;
 		}
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			printf("-: -------- > %d: %s\n",
-			       j + 1, short_oid(b_util));
+			output_pair_header(&buf, -1, NULL, j, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
 
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			printf("%d: %s ! %d: %s\n",
-			       b_util->matching + 1, short_oid(a_util),
-			       j + 1, short_oid(b_util));
+			output_pair_header(&buf,
+					   b_util->matching, a_util, j, b_util);
 			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
 				patch_diff(a->items[b_util->matching].string,
 					   b->items[j].string, diffopt);
@@ -353,6 +401,7 @@ static void output(struct string_list *a, struct string_list *b,
 			j++;
 		}
 	}
+	strbuf_release(&buf);
 }
 
 int cmd_branch_diff(int argc, const char **argv, const char *prefix)
-- 
2.17.0.409.g71698f11835


