Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C24C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 10:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjEPKZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjEPKY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 06:24:59 -0400
X-Greylist: delayed 310 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 03:24:46 PDT
Received: from qs51p00im-qukt01071502.me.com (qs51p00im-qukt01071502.me.com [17.57.155.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E745B8E
        for <git@vger.kernel.org>; Tue, 16 May 2023 03:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1684232375;
        bh=dgO79jIb1j3EmBA4Zx4OTxzQTIHgYLJD6EkreArNX4k=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=dfu4GB57T9dj3SsLplftNf0esi1C9ZCawCSC9u2bfW8OKxXmtZ6onMc1Tyu9+A+u+
         62ErhbOWUVBncnZ3BjmaekhOyBzOncd7+VFCmvhGBSCPM5rINbzUyKIB+6+J13BQpn
         fzElLj0vF72MuWYfZcgDNw0hSZ3QsKMbNdG1sU7HnmYGh7lbu8QfEihUJ/KTJDgzgR
         MpmwHhatQHNMjWCfR4smEhh1yAMI1I5C+ZncSWz550q+QKyjD9d2doK/r0wu1Z5Ch2
         wtiLgpIRr0l8xCOdUO2Wv90EqQvFgGFHM82llWWN+3WMBFlWXlgnN7c60M/Zy8fqhJ
         7wcpgL4mbMcTA==
Received: from localhost.localdomain (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01071502.me.com (Postfix) with ESMTPSA id D12EA668017C;
        Tue, 16 May 2023 10:19:34 +0000 (UTC)
From:   Emir SARI <emir_sari@icloud.com>
To:     git@vger.kernel.org
Cc:     Emir SARI <emir_sari@icloud.com>
Subject: [PATCH] i18n: Enable percentage l10n for more strings
Date:   Tue, 16 May 2023 13:19:11 +0300
Message-Id: <20230516101911.93809-1-emir_sari@icloud.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LbFiP2US2nZHakJavW3kZtRjzy0gbXX4
X-Proofpoint-ORIG-GUID: LbFiP2US2nZHakJavW3kZtRjzy0gbXX4
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2305160087
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This enables percentage localization in more progress views, and
provides a more cohesive l10n environment among the translated messages.
---
 apply.c    |  8 ++++----
 progress.c | 18 ++++++++++++++++--
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/apply.c b/apply.c
index 6212ab3..3e1d08d 100644
--- a/apply.c
+++ b/apply.c
@@ -4247,11 +4247,11 @@ static void show_rename_copy(struct patch *p)
 	 * new_name through the end of names are renames
 	 */
 	if (old_name != p->old_name)
-		printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
+		printf(_(" %s %.*s{%s => %s} (%d%%)\n"), renamecopy,
 		       (int)(old_name - p->old_name), p->old_name,
 		       old_name, new_name, p->score);
 	else
-		printf(" %s %s => %s (%d%%)\n", renamecopy,
+		printf(_(" %s %s => %s (%d%%)\n"), renamecopy,
 		       p->old_name, p->new_name, p->score);
 	show_mode_change(p, 0);
 }
@@ -4270,8 +4270,8 @@ static void summary_patch_list(struct patch *patch)
 				show_rename_copy(p);
 			else {
 				if (p->score) {
-					printf(" rewrite %s (%d%%)\n",
-					       p->new_name, p->score);
+					printf(" rewrite %s ", p->new_name);
+					printf(_("(%d%%)\n"), p->score);
 					show_mode_change(p, 0);
 				}
 				else
diff --git a/progress.c b/progress.c
index f695798..1f8d372 100644
--- a/progress.c
+++ b/progress.c
@@ -124,10 +124,24 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 			progress->last_percent = percent;
 
 			strbuf_reset(counters_sb);
-			strbuf_addf(counters_sb,
-				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
+
+			struct strbuf progress_sb = STRBUF_INIT;
+			strbuf_addf(&progress_sb,
+				_("%u%% (%"PRIuMAX"/%"PRIuMAX")%s"), percent,
 				    (uintmax_t)n, (uintmax_t)progress->total,
 				    tp);
+			struct strbuf progress_str = STRBUF_INIT;
+			strbuf_addstr(&progress_str, progress_sb.buf);
+			strbuf_release(&progress_sb);
+
+			if (percent < 10)
+			    strbuf_insert(&progress_str, 0, "  ", 2);
+			else if (percent < 100)
+			    strbuf_insert(&progress_str, 0, " ", 1);
+
+			strbuf_addf(counters_sb, "%s", progress_str.buf);
+			strbuf_release(&progress_str);
+
 			show_update = 1;
 		}
 	} else if (progress_update) {
-- 
2.40.1

