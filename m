Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C18C433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiBLUfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:35:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiBLUfK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:35:10 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61CD606E3
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:03 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso9267660wme.5
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ViCfsVymSZrhniztwUknZo7RBG/QJEPkCxLJ9NoEmlI=;
        b=G8BoKDJrO3lZSrgRCFmBBZACTXhyNaXjqaEL2w4cvJE/v44EfmfwFsAVsaV1JSq53K
         JO8DvNsD4NDSBttD/cOIXa7XA37VLGV3WdFNokQ4wPVriJLd07zBfRsmr/NVOLoUnOUq
         gPtYqxmjWpfUNaAS7lsBJnX/UZ+NxpeRIp24boPmt/rosbGzzk3kYgWpLyQM+kpjA8wz
         Tpd5HTofaVTJ2oZF7C8xEZWIw3bK+Naac/PnXf2hbIYkMUBbz28PBSXR661vAkw0w7gf
         wehh/zI9NJSZkB0+3/CKF2MZXoHQjd88exDE9Mvt+wBWLXPGrg86MsQt01GzQjYt69Mg
         y2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ViCfsVymSZrhniztwUknZo7RBG/QJEPkCxLJ9NoEmlI=;
        b=DXmf+DNPeMlE+CZRnMOqk4F/oX0krxQKC74+Z7SgmgK0f9MbSeJr11ifB3i433ZAUo
         YnCG2/+oEN2v/+WzpAFLKt3DkpWLSNJnTG5M1sWxV/HG3gy8pdcy+oguSXJ/8CY7sRK3
         dPfmbhC9868QcZYG4z2CWN4zTZXKtzHiR7fF9s8nLddfj4huTjfkxSWTfGk4LfIhqCIh
         B1vLWQz3hMR06ILUBcMhPI+oDurN84ydiS4k+NWw7iZCyZyWqx09BZVxCEKr9k09XEI3
         Yg0ALhHKPLb+3b5qpQWEo/Rc5uRiMa5Y29tHScGpUA5Cfynfn+QgC+yCoqIvXRcPIdsd
         ZrQQ==
X-Gm-Message-State: AOAM53276yRGzVx+wJqFNPrfSG47+cR04nvKFTXDqnIpnizGkpmSDtOr
        XsjbZCdv8jpYa14nK8vuhUGjVTV+X6s=
X-Google-Smtp-Source: ABdhPJwWZFbXSYnb5J9yoKWfbVc8XsVecvj32gluRomJvNw2IkgelG7xjmAhSVR23Ev5VK/p42NA0Q==
X-Received: by 2002:a05:600c:1c88:: with SMTP id k8mr5440311wms.60.1644698102123;
        Sat, 12 Feb 2022 12:35:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18sm7371893wmi.30.2022.02.12.12.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:35:01 -0800 (PST)
Message-Id: <435f66ea699ff0ff553350bb5c9d6097940794e9.1644698093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Feb 2022 20:34:50 +0000
Subject: [PATCH v4 09/12] merge-tree: provide easy access to `ls-files -u`
 style info
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

Much like `git merge` updates the index with information of the form
    (mode, oid, stage, name)
provide this output for conflicted files for merge-tree as well.
Provide a --name-only option for users to exclude the mode, oid, and
stage and only get the list of conflicted filenames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 32 ++++++++++++++++++++++++++------
 builtin/merge-tree.c             | 11 ++++++++++-
 t/t4301-merge-tree-write-tree.sh | 26 ++++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 9f7eb03c6eb..6502ee0669e 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -50,6 +50,13 @@ discuss the first form.
 OPTIONS
 -------
 
+--name-only::
+	In the Conflicted file info section, instead of writing a list
+	of (mode, oid, stage, path) tuples to output for conflicted
+	files, just provide a list of filenames with conflicts (and
+	do not list filenames multiple times if they have multiple
+	conflicting stages).
+
 --[no-]messages::
 	Write any informational messages such as "Auto-merging <path>"
 	or CONFLICT notices to the end of stdout.  If unspecified, the
@@ -67,7 +74,7 @@ simply one line:
 Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
-	<Conflicted file list>
+	<Conflicted file info>
 	<Informational messages>
 
 These are discussed individually below.
@@ -79,18 +86,23 @@ This is a tree object that represents what would be checked out in the
 working tree at the end of `git merge`.  If there were conflicts, then
 files within this tree may have embedded conflict markers.
 
-Conflicted file list
+Conflicted file info
 ~~~~~~~~~~~~~~~~~~~~
 
-This is a sequence of lines containing a filename on each line, quoted
-as explained for the configuration variable `core.quotePath` (see
-linkgit:git-config[1]).
+This is a sequence of lines with the format
+
+	<mode> <object> <stage> <filename>
+
+The filename will be quoted as explained for the configuration
+variable `core.quotePath` (see linkgit:git-config[1]).  However, if
+the `--name-only` option is passed, the mode, object, and stage will
+be omitted.
 
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
 This always starts with a blank line to separate it from the previous
-section, and then has free-form messages about the merge, such as:
+sections, and then has free-form messages about the merge, such as:
 
   * "Auto-merging <file>"
   * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
@@ -120,6 +132,14 @@ Thus, it could be used as a part of a series of steps such as
 Note that when the exit status is non-zero, NEWTREE in this sequence
 will contain a lot more output than just a tree.
 
+git-merge-tree was written to provide users with the same information
+that they'd have access to if using `git merge`:
+  * what would be written to the working tree (the <OID of toplevel tree>)
+  * the higher order stages that would be written to the index (the
+    <Conflicted file info>)
+  * any messages that would have been printed to stdout (the <Informational
+    messages>)
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index cb4169d2271..1d4d6637b90 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -400,6 +400,7 @@ enum mode {
 struct merge_tree_options {
 	int mode;
 	int show_messages;
+	int name_only;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -456,7 +457,11 @@ static int real_merge(struct merge_tree_options *o,
 		merge_get_conflicted_files(&result, &conflicted_files);
 		for (i = 0; i < conflicted_files.nr; i++) {
 			const char *name = conflicted_files.items[i].string;
-			if (last && !strcmp(last, name))
+			struct stage_info *c = conflicted_files.items[i].util;
+			if (!o->name_only)
+				printf("%06o %s %d\t",
+				       c->mode, oid_to_hex(&c->oid), c->stage);
+			else if (last && !strcmp(last, name))
 				continue;
 			write_name_quoted_relative(
 				name, prefix, stdout, line_termination);
@@ -491,6 +496,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			    N_("do a trivial merge only"), MODE_TRIVIAL),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_BOOL_F(0, "name-only",
+			   &o.name_only,
+			   N_("list filenames without modes/oids/stages"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 0964c1145e6..4ee85439372 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -65,6 +65,7 @@ test_expect_success 'Content merge and a few conflicts' '
 	expected_tree=$(cat .git/AUTO_MERGE) &&
 
 	# We will redo the merge, while we are still in a conflicted state!
+	git ls-files -u >conflicted-file-info &&
 	test_when_finished "git reset --hard" &&
 
 	test_expect_code 1 git merge-tree --write-tree side1 side2 >RESULT &&
@@ -108,7 +109,7 @@ anonymize_hash() {
 }
 
 test_expect_success 'test conflict notices and such' '
-	test_expect_code 1 git merge-tree --write-tree side1 side2 >out &&
+	test_expect_code 1 git merge-tree --write-tree --name-only side1 side2 >out &&
 	anonymize_hash out >actual &&
 
 	# Expected results:
@@ -143,7 +144,7 @@ do
 done
 
 test_expect_success 'Just the conflicted files without the messages' '
-	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	test_expect_code 1 git merge-tree --write-tree --no-messages --name-only side1 side2 >out &&
 	anonymize_hash out >actual &&
 
 	test_write_lines HASH greeting whatever~side1 >expect &&
@@ -151,4 +152,25 @@ test_expect_success 'Just the conflicted files without the messages' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Check conflicted oids and modes without messages' '
+	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	anonymize_hash out >actual &&
+
+	# Compare the basic output format
+	q_to_tab >expect <<-\EOF &&
+	HASH
+	100644 HASH 1Qgreeting
+	100644 HASH 2Qgreeting
+	100644 HASH 3Qgreeting
+	100644 HASH 1Qwhatever~side1
+	100644 HASH 2Qwhatever~side1
+	EOF
+
+	test_cmp expect actual &&
+
+	# Check the actual hashes against the `ls-files -u` output too
+	tail -n +2 out | sed -e s/side1/HEAD/ >actual &&
+	test_cmp conflicted-file-info actual
+'
+
 test_done
-- 
gitgitgadget

