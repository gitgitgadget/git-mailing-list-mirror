Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 159F31F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759329AbeD0VkE (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:40:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:37741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759082AbeD0VkB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:40:01 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lp7d2-1eiKSW3jGO-00etdd; Fri, 27 Apr 2018 23:39:57 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v6 07/11] Deprecate support for .git/info/grafts
Date:   Fri, 27 Apr 2018 23:39:54 +0200
Message-Id: <36532fa9f3812839e27e3ac74d54f4fc5e5a38e4.1524865158.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524865158.git.johannes.schindelin@gmx.de>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:dHD810VRmsWfzqHki2X6bu3V8+Y2gxCppifgGDw7sh5NEaH8Na2
 T8cfk0ClUxzZ02tSDnBTtm3GcMIRZtjOVhxdJoQbmPHdtpK6O7RrU8/1UX85xoSQ+kv85rm
 edZ276u77QZis92vaJY+ilqGBgWMU31kzd52OrKWgKMFj7awlQs2dm0q1ouRtCTMYJehy/1
 fNL3ZPxV+M7fEnA4d4BCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QfJbdrWRnFM=:z/WFMR0q29a+QJ2aPJ5G7I
 nrLJGNVbVkJfQuK8nryMXgRDyT+IGiFashQTtMWO4ShXKwqleASGJu5hf3Am14M2RMEaGlM/s
 lsN1EOwZD/ZzlfsGTTDyj1C51Te0mc6Ela3IEa2v8Bm3S6bAkrlSOihTp3+WCo6OwqJTZlfXP
 1KlPOUF4F+zvdhyPPYzBsol8zSxbVJzRtsrx7By062iSNFWFtkSTsUhv9zvWjdYGyQRQ+dvkb
 u2jltpm5CrM+UOcVretQfl/QglWjsYfIMiiG+Gz3m7RdLDgdBinSoiSdPPXIDqbT7ZfMGmZpN
 VVzWUXRIRV4BnaZrv0OLrJ18KI5YUVQBzdUnJf6iMVkHN6sqt/08id6JFhtJf3jlwtsUl+ATR
 qZcog1qTc71AZUj0ChBBJ4FMIARiQn1PpPNSo5cKcnO44LXdRwMEMLE+RIi4Fcok0NlCtIzKA
 CQqQrtiNwQ8fJkW3HNlRzJZR2oBMI95MNjp1hNNh6bFRygZvt3bccGBeUTBe2dqLQ+laosLFP
 clRLHjeeW39yZmx4Xqzpu7zQAhIgb6Jd2vK19Rpht2Ii+AbMehWNqIZfzrtOVIjoPwlQOHMug
 i4xMG2GVw/es0FAm7otpLq+TPD7v0WQ2eDQx6ekM+CrMRJuDrOlcHTevDko4dEu3lRMirkyum
 rtl8lYJx18lQGAR6uIPN5L5Hy2sdfiGMSg71GxAw3cJStHyUIGDknoemeCSRN79MVmg3jAsIy
 Tcv+xcQtg5Rru4YQITi9J6bv34G6nzEYPWIdhdmZtZw/FQY6iu/TSJmq6y2JzC3jnsIMzxP4v
 DZ90s0W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The grafts feature was a convenient way to "stitch together" ancient
history to the fresh start of linux.git.

Its implementation is, however, not up to Git's standards, as there are
too many ways where it can lead to surprising and unwelcome behavior.

For example, when pushing from a repository with active grafts, it is
possible to miss commits that have been "grafted out", resulting in a
broken state on the other side.

Also, the grafts feature is limited to "rewriting" commits' list of
parents, it cannot replace anything else.

The much younger feature implemented as `git replace` set out to remedy
those limitations and dangerous bugs.

Seeing as `git replace` is pretty mature by now (since 4228e8bc98
(replace: add --graft option, 2014-07-19) it can perform the graft
file's duties), it is time to deprecate support for the graft file, and
to retire it eventually.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 advice.c                  |  2 ++
 advice.h                  |  1 +
 commit.c                  | 10 ++++++++++
 t/t6001-rev-list-graft.sh |  9 +++++++++
 4 files changed, 22 insertions(+)

diff --git a/advice.c b/advice.c
index 406efc183ba..4411704fd45 100644
--- a/advice.c
+++ b/advice.c
@@ -19,6 +19,7 @@ int advice_rm_hints = 1;
 int advice_add_embedded_repo = 1;
 int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
+int advice_graft_file_deprecated = 1;
 
 static struct {
 	const char *name;
@@ -42,6 +43,7 @@ static struct {
 	{ "addembeddedrepo", &advice_add_embedded_repo },
 	{ "ignoredhook", &advice_ignored_hook },
 	{ "waitingforeditor", &advice_waiting_for_editor },
+	{ "graftfiledeprecated", &advice_graft_file_deprecated },
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index 70568fa7922..9f5064e82a8 100644
--- a/advice.h
+++ b/advice.h
@@ -21,6 +21,7 @@ extern int advice_rm_hints;
 extern int advice_add_embedded_repo;
 extern int advice_ignored_hook;
 extern int advice_waiting_for_editor;
+extern int advice_graft_file_deprecated;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/commit.c b/commit.c
index 2952ec987c5..451d3ce8dfe 100644
--- a/commit.c
+++ b/commit.c
@@ -12,6 +12,7 @@
 #include "prio-queue.h"
 #include "sha1-lookup.h"
 #include "wt-status.h"
+#include "advice.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -176,6 +177,15 @@ static int read_graft_file(const char *graft_file)
 	struct strbuf buf = STRBUF_INIT;
 	if (!fp)
 		return -1;
+	if (advice_graft_file_deprecated)
+		advise(_("Support for <GIT_DIR>/info/grafts is deprecated\n"
+			 "and will be removed in a future Git version.\n"
+			 "\n"
+			 "Please use \"git replace --convert-graft-file\"\n"
+			 "to convert the grafts into replace refs.\n"
+			 "\n"
+			 "Turn this message off by running\n"
+			 "\"git config advice.graftFileDeprecated false\""));
 	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
 		struct commit_graft *graft = read_graft_line(&buf);
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 05ddc69cf2a..7504ba47511 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -110,4 +110,13 @@ do
 	"
 
 done
+
+test_expect_success 'show advice that grafts are deprecated' '
+	git show HEAD 2>err &&
+	test_i18ngrep "git replace" err &&
+	test_config advice.graftFileDeprecated false &&
+	git show HEAD 2>err &&
+	test_i18ngrep ! "git replace" err
+'
+
 test_done
-- 
2.17.0.windows.1.33.gfcbb1fa0445


