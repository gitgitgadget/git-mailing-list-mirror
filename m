Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A8CC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbiBBHf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239775AbiBBHfI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:35:08 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B4CC06175C
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso3262998wms.2
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4vpK7gvSSTnnlTHW028zn/66BNp2/IopKxZgoFX/3Ek=;
        b=m9zIqm9GYNfkjsOB2hqOSbb/Y0GE/saa5LcIlOcZG0dSHzf88hZZlXQ30+IkJOwPMb
         x5zWGwouk5WadZj/CvkO8Vml1/1SzqDqJcQgR4zJ5S1B7Yv3/YHJOrrvjtk9tG8by3n7
         tPGcj3rfq8Yx1Hx8Msv6ay5NgomDWdsAV/dIJsp9nbW3VtEOISaBmenMna5x4NbmTYF4
         VEZbbbqXC+C7eqMnYD36NZoJ54iYDcEeL4UkBGT16Rvr9MjWodfgZBbhhG54nPNUgvuD
         vCMrz507A2qtf7aZslbmcclhhG1/5KaaEmfzY8pkGgzV5IVb2bOg8Femg5WwSGjbjy5V
         Hk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4vpK7gvSSTnnlTHW028zn/66BNp2/IopKxZgoFX/3Ek=;
        b=T1QejF9c13eB9fqtNcaA96rtGVuKr5MvTbz5QV/ID/15vTlKKPYhdizquWWFnDd4ZG
         5n4jsBYWRi+QK36JWL0tRkSiwxYuZeqjLBur0J4s8qK2LORnixAUdLoHmWeDsxiR0doy
         54DwH7KQovwlFjvNZR0UEYjxbgGanUUjwv/MDqjdK8A4eIvi793aVhDe/JK5lbg6RriX
         kEKaU7zrnpt5PkV8oCEh3GpnFve4BGv2hClWS6ituGNfQxSELtAuPNqaKYg2EKzqRCPP
         Xu+Qb1adE9oITH1btjHejAVbKSQFkjbUpGk/WIzPb3XXfTh4XUTDCKaoEPwUAkv/HhJx
         yZyQ==
X-Gm-Message-State: AOAM532C4i9uvVt7j68tMVcrZn/T73dV0FWr5CGFuiMVyxC3tFvxMkbg
        MWwJODtbF9wWTMwcKg6KbWCLt+xi9k4=
X-Google-Smtp-Source: ABdhPJxVmqV9/4EVogYJQIVK0wR+2uk4gEBAybkAp49SbNzk90yA+wYTop6F78DU0TyeYsrsVlISAQ==
X-Received: by 2002:a1c:7416:: with SMTP id p22mr4945718wmc.30.1643787293332;
        Tue, 01 Feb 2022 23:34:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2sm4148212wmq.21.2022.02.01.23.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:52 -0800 (PST)
Message-Id: <2188a8ca1e77f2f5f8249f8b810775205ad529a6.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:38 +0000
Subject: [PATCH v3 12/15] merge-tree: provide easy access to `ls-files -u`
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
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Much like `git merge` updates the index with information of the form
    (mode, oid, stage, name)
provide this output for conflicted files for merge-tree as well.
Provide an --exclude-modes-oids-stages/-l option for users to exclude
the mode, oid, and stage and only get the list of conflicted filenames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 30 ++++++++++++++++++++++++------
 builtin/merge-tree.c             | 11 ++++++++++-
 t/t4301-merge-tree-write-tree.sh | 26 ++++++++++++++++++++++++--
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 160e8f44b62..55bb7bc61c1 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -38,6 +38,11 @@ See `OUTPUT` below for details.
 OPTIONS
 -------
 
+--exclude-oids-and-modes::
+	Instead of writing a list of (mode, oid, stage, path) tuples
+	to output for conflicted files, just provide a list of
+	filenames with conflicts.
+
 --[no-]messages::
 	Write any informational messages such as "Auto-merging <path>"
 	or CONFLICT notices to the end of stdout.  If unspecified, the
@@ -55,7 +60,7 @@ simply one line:
 Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
-	<Conflicted file list>
+	<Conflicted file info>
 	<Informational messages>
 
 These are discussed individually below.
@@ -67,18 +72,23 @@ This is a tree object that represents what would be checked out in the
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
+the `--exclude-oids-and-modes` option is passed, the mode, object, and
+stage will be omitted.
 
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
 This always starts with a blank line to separate it from the previous
-section, and then has free-form messages about the merge, such as:
+sections, and then has free-form messages about the merge, such as:
 
   * "Auto-merging <file>"
   * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
@@ -110,6 +120,14 @@ plumbing commands since the possibility of merge conflicts give it a
 much higher chance of the command not succeeding (and NEWTREE containing
 a bunch of stuff other than just a toplevel tree).
 
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
index 54dae018203..dc52cd02dce 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -394,6 +394,7 @@ static int trivial_merge(const char *base,
 struct merge_tree_options {
 	int mode;
 	int show_messages;
+	int exclude_modes_oids_stages;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -450,7 +451,11 @@ static int real_merge(struct merge_tree_options *o,
 		merge_get_conflicted_files(&result, &conflicted_files);
 		for (i = 0; i < conflicted_files.nr; i++) {
 			const char *name = conflicted_files.items[i].string;
-			if (last && !strcmp(last, name))
+			struct stage_info *c = conflicted_files.items[i].util;
+			if (!o->exclude_modes_oids_stages)
+				printf("%06o %s %d\t",
+				       c->mode, oid_to_hex(&c->oid), c->stage);
+			else if (last && !strcmp(last, name))
 				continue;
 			write_name_quoted_relative(
 				name, prefix, stdout, line_termination);
@@ -485,6 +490,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			    N_("do a trivial merge only"), 't'),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_BOOL_F('l', "exclude-modes-oids-stages",
+			   &o.exclude_modes_oids_stages,
+			   N_("list conflicted files without modes/oids/stages"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 7113d060bc5..1572f460da0 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -47,6 +47,7 @@ test_expect_success 'Content merge and a few conflicts' '
 	expected_tree=$(cat .git/AUTO_MERGE) &&
 
 	# We will redo the merge, while we are still in a conflicted state!
+	git ls-files -u >conflicted-file-info &&
 	test_when_finished "git reset --hard" &&
 
 	test_expect_code 1 git merge-tree --write-tree side1 side2 >RESULT &&
@@ -86,7 +87,7 @@ test_expect_success 'Barf on too many arguments' '
 '
 
 test_expect_success 'test conflict notices and such' '
-	test_expect_code 1 git merge-tree --write-tree side1 side2 >out &&
+	test_expect_code 1 git merge-tree --write-tree --exclude-modes-oids-stages side1 side2 >out &&
 	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
 
 	# Expected results:
@@ -109,7 +110,7 @@ test_expect_success 'test conflict notices and such' '
 '
 
 test_expect_success 'Just the conflicted files without the messages' '
-	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	test_expect_code 1 git merge-tree --write-tree --no-messages --exclude-modes-oids-stages side1 side2 >out &&
 	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
 
 	test_write_lines HASH greeting whatever~side1 >expect &&
@@ -117,4 +118,25 @@ test_expect_success 'Just the conflicted files without the messages' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Check conflicted oids and modes without messages' '
+	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
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

