Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D06E11F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeGUW7O (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:14 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:46721 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeGUW7O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:14 -0400
Received: by mail-pl0-f43.google.com with SMTP id t17-v6so4072275ply.13
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9enesAFvtH82y/VSm0waFT9NdtTxzit5SsjaPbFilW4=;
        b=FsrZL5tGQwOWhQas/bhUi6oPDLa5Kmb/MXqm1KLROvy40swnMN3sFzVP8JfQFa/Z84
         gc/vzRiLYaaAHWFQ3QYejIwZzCrd21EttOPMPrkAX7tqaoxHsmbbeznyDRytziJJxNfd
         Jvr7tsdMhiBEpSmueKugCrKVAc4jTjFEePMnVt3fU7PUDHpHXV1kPSLbPS9dSMnSk0Tv
         M0bPX4VgMm1si20ga+bPa1YkNKDg3e+1e9AylY5AW0QI6hnlSFUrqjChj/nple8RE2bp
         wSFbw+KaQbFUDtkg+I5tgLjz1h9C3er9wHLedMbwjZI9PhbPA+AoN2RvsQZIZsUNM28C
         ft7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9enesAFvtH82y/VSm0waFT9NdtTxzit5SsjaPbFilW4=;
        b=GRXWIsfqfpuAmUGsea/m+YejO7fUrr7nYKYUFh1hxtb9+HsN30U7Mhnle9RE2zjbno
         T6Uil+vLCe4Gae15SCueyd/DnucFhzTjJbJ3MoOfZesT4YvyexE4C+oVTQZnu6P8hj4B
         for+7SO9ZG6BqhLSv8E+GuIeLAFQ2Jfg5Ljqa+xBugU77RgOM+OF/pIpkT4q5ruzOaXV
         HkZGU6CxgAym1l/6K4poK+7megKUeO897uKWrcglxoDdi3jKCoCD7pMF/fRgMn3ThxWy
         +zXA8BwxfkU0eiBS0BkjR4Wp0368XHsPVtueBX+WW3CihpyXbf5M6Y0cWNLh2tSgxIKG
         37qQ==
X-Gm-Message-State: AOUpUlEFONVaeO91cEznPfDSoNh9Lj/xCd/cNu8oU15h0R++Jsl6t6Q7
        Ld7m+qNq6xKbMGIhZ84laQthZbmb
X-Google-Smtp-Source: AAOMgpd/s0fwsBj5uEcfc1PmzrRukrnFMz3+S42hPCJJFgJeqraO7A7V2tjoFe9fBVqBGwvcEpgedQ==
X-Received: by 2002:a17:902:694a:: with SMTP id k10-v6mr7199218plt.166.1532210698121;
        Sat, 21 Jul 2018 15:04:58 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id b1-v6sm7702136pff.141.2018.07.21.15.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:04:57 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:04:57 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:30 GMT
Message-Id: <9641ab5c0df984f5e7ea9c49debffffe2a929095.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 09/21] range-diff: adjust the output of the commit pairs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This change brings `git range-diff` yet another step closer to
feature parity with tbdiff: it now shows the oneline, too, and indicates
with `=` when the commits have identical diffs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 64 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 1ecee2c09..8329f52e7 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -7,6 +7,8 @@
 #include "xdiff-interface.h"
 #include "linear-assignment.h"
 #include "diffcore.h"
+#include "commit.h"
+#include "pretty.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -255,9 +257,54 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 	free(b2a);
 }
 
-static const char *short_oid(struct patch_util *util)
+static void output_pair_header(struct strbuf *buf,
+			       struct strbuf *dashes,
+			       struct patch_util *a_util,
+			       struct patch_util *b_util)
 {
-	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
+	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
+	struct commit *commit;
+
+	if (!dashes->len)
+		strbuf_addchars(dashes, '-',
+				strlen(find_unique_abbrev(oid,
+							  DEFAULT_ABBREV)));
+
+	strbuf_reset(buf);
+	if (!a_util)
+		strbuf_addf(buf, "-:  %s ", dashes->buf);
+	else
+		strbuf_addf(buf, "%d:  %s ", a_util->i + 1,
+			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
+
+	if (!a_util)
+		strbuf_addch(buf, '>');
+	else if (!b_util)
+		strbuf_addch(buf, '<');
+	else if (strcmp(a_util->patch, b_util->patch))
+		strbuf_addch(buf, '!');
+	else
+		strbuf_addch(buf, '=');
+
+	if (!b_util)
+		strbuf_addf(buf, " -:  %s", dashes->buf);
+	else
+		strbuf_addf(buf, " %d:  %s", b_util->i + 1,
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
 
 static struct diff_filespec *get_filespec(const char *name, const char *p)
@@ -286,6 +333,7 @@ static void patch_diff(const char *a, const char *b,
 static void output(struct string_list *a, struct string_list *b,
 		   struct diff_options *diffopt)
 {
+	struct strbuf buf = STRBUF_INIT, dashes = STRBUF_INIT;
 	int i = 0, j = 0;
 
 	/*
@@ -307,25 +355,21 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			printf("%d: %s < -: --------\n",
-			       i + 1, short_oid(a_util));
+			output_pair_header(&buf, &dashes, a_util, NULL);
 			i++;
 			continue;
 		}
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			printf("-: -------- > %d: %s\n",
-			       j + 1, short_oid(b_util));
+			output_pair_header(&buf, &dashes, NULL, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
 
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			printf("%d: %s ! %d: %s\n",
-			       b_util->matching + 1, short_oid(a_util),
-			       j + 1, short_oid(b_util));
+			output_pair_header(&buf, &dashes, a_util, b_util);
 			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
 				patch_diff(a->items[b_util->matching].string,
 					   b->items[j].string, diffopt);
@@ -333,6 +377,8 @@ static void output(struct string_list *a, struct string_list *b,
 			j++;
 		}
 	}
+	strbuf_release(&buf);
+	strbuf_release(&dashes);
 }
 
 int show_range_diff(const char *range1, const char *range2,
-- 
gitgitgadget

