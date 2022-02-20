Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B44C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 06:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiBTGzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:55:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiBTGzR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 01:55:17 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B6935DD5
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h6so21514496wrb.9
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qyMp8qLzAwpyXSfXf5fBMSPn1Iu44k0fyZQC+i4XPcM=;
        b=Ir1fBOqrVwM7ii1h/0XWoViBKY2auZjkdZGn7CLCF9cLjvqt/1XtTxdjCuIWtY33Cm
         T6znjixsg+2THGtwSlpTYzqNpYP6xDv86Ut555qPOwuuo/rt0qfkBveazq93t6ySwicm
         QHvcNAPWLpPproXUfRoFQqDjgfGBsrGKOBfITVbUnoO3WrdaYnP6uZYKvZdezVGB7OYe
         gKh6znWU4rk9PS5DiSG8iBjTGSI3a980B/XjH0TNixcEWKZP+qwlS3mtYi1FP6CJashx
         lBwmL3Lrx5Y6YVxyKIlROk+MET8tsAq41EcmSth92xpW9JLouMg22P3YjFLy5oeVifZ5
         8S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qyMp8qLzAwpyXSfXf5fBMSPn1Iu44k0fyZQC+i4XPcM=;
        b=CxWCtZ13Mob+3rUo3vO8UFtfX8kuMECQU6rDOapj4Te/ZXGL8YM3mBEuqQGz0t4Oqa
         jwTPDlAE6Vx/05ZC//q1HUNIUYCixwFC0FgeyknXuxjFTplXwy/sfAl94ZoDA8oNC7am
         pAbI1uOynlEqLbQ+gA4iQW+n9lBs7feSBmuDkyzbVO4B7UZ5bC7/OYU3Mh5M+RNTWojy
         Lc8rlRpWbLdkCrRPrtObmOsACX/ltjGPhxO6CzgR2HoPW15QQGuFAW5LerQUGAy4oBlD
         adumiVzX0vvGlJ75UMDGYL5pHDxvq2wLtR3nYhCFooKfl0p/cY+NROGgMxuAnYOeFnrI
         z9XQ==
X-Gm-Message-State: AOAM5317iiDys/Aml4TCLsoT2d+bcsskWIdpsjPyPWJ3Oj5IaBI1S4Wx
        j33Yzi3SICDFnrx+fuXssOIu/vzVv7c=
X-Google-Smtp-Source: ABdhPJztdyYBJGjmXsP6u/ut5K5A7e+NEWNf2dAIRLAbM2DAu/jeGd1aWBwop55TBB18PrIOdvwa0g==
X-Received: by 2002:a5d:6cd0:0:b0:1e3:11b3:418c with SMTP id c16-20020a5d6cd0000000b001e311b3418cmr11450728wrc.405.1645340090245;
        Sat, 19 Feb 2022 22:54:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm27398640wrv.116.2022.02.19.22.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 22:54:49 -0800 (PST)
Message-Id: <5bb7d3725ad529c36b1bc0367d67dc16a05b14b3.1645340082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
        <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 06:54:38 +0000
Subject: [PATCH v5 08/12] merge-tree: provide a list of which files have
 conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Callers of `git merge-tree --write-tree` will often want to know which
files had conflicts.  While they could potentially attempt to parse the
CONFLICT notices printed, those messages are not meant to be machine
readable.  Provide a simpler mechanism of just printing the files (in
the same format as `git ls-files` with quoting, but restricted to
unmerged files) in the output before the free-form messages.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt |  8 ++++++++
 builtin/merge-tree.c             | 24 ++++++++++++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 11 +++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index f415d6de5a3..deaeb49ae05 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -67,6 +67,7 @@ simply one line:
 Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
+	<Conflicted file list>
 	<Informational messages>
 
 These are discussed individually below.
@@ -78,6 +79,13 @@ This is a tree object that represents what would be checked out in the
 working tree at the end of `git merge`.  If there were conflicts, then
 files within this tree may have embedded conflict markers.
 
+Conflicted file list
+~~~~~~~~~~~~~~~~~~~~
+
+This is a sequence of lines containing a filename on each line, quoted
+as explained for the configuration variable `core.quotePath` (see
+linkgit:git-config[1]).
+
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index d44e8d087b1..cb4169d2271 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -11,6 +11,9 @@
 #include "blob.h"
 #include "exec-cmd.h"
 #include "merge-blobs.h"
+#include "quote.h"
+
+static int line_termination = '\n';
 
 struct merge_list {
 	struct merge_list *next;
@@ -400,7 +403,8 @@ struct merge_tree_options {
 };
 
 static int real_merge(struct merge_tree_options *o,
-		      const char *branch1, const char *branch2)
+		      const char *branch1, const char *branch2,
+		      const char *prefix)
 {
 	struct commit *parent1, *parent2;
 	struct commit_list *common;
@@ -444,6 +448,22 @@ static int real_merge(struct merge_tree_options *o,
 		o->show_messages = !result.clean;
 
 	puts(oid_to_hex(&result.tree->object.oid));
+	if (!result.clean) {
+		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
+		const char *last = NULL;
+		int i;
+
+		merge_get_conflicted_files(&result, &conflicted_files);
+		for (i = 0; i < conflicted_files.nr; i++) {
+			const char *name = conflicted_files.items[i].string;
+			if (last && !strcmp(last, name))
+				continue;
+			write_name_quoted_relative(
+				name, prefix, stdout, line_termination);
+			last = name;
+		}
+		string_list_clear(&conflicted_files, 1);
+	}
 	if (o->show_messages) {
 		printf("\n");
 		merge_display_update_messages(&opt, &result);
@@ -511,7 +531,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 
 	/* Do the relevant type of merge */
 	if (o.mode == MODE_REAL)
-		return real_merge(&o, argv[0], argv[1]);
+		return real_merge(&o, argv[0], argv[1], prefix);
 	else
 		return trivial_merge(argv[0], argv[1], argv[2]);
 }
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 719d81e7173..8e6dba44288 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -117,6 +117,8 @@ test_expect_success 'test conflict notices and such' '
 	#   "whatever" has *both* a modify/delete and a file/directory conflict
 	cat <<-EOF >expect &&
 	HASH
+	greeting
+	whatever~side1
 
 	Auto-merging greeting
 	CONFLICT (content): Merge conflict in greeting
@@ -140,4 +142,13 @@ do
 	'
 done
 
+test_expect_success 'Just the conflicted files without the messages' '
+	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	anonymize_hash out >actual &&
+
+	test_write_lines HASH greeting whatever~side1 >expect &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

