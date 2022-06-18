Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1A1C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383767AbiFRAVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383754AbiFRAVa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692876970B
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g27so864459wrb.10
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SSiRW01ACwOK0LAIQZ5fNsRTzzFu0Gl8U0LeJb+1GHg=;
        b=MLRMTd3rHcAm15I61b7EHh8OwfJQQ4xvhfwG7grCcaynxg4gpxBhJhYoYaDy7OleZI
         BMMiZK7BV6fK1r+r4RDJdg1/YXzSHpxNuBQ5yaXwvva2ZDkWvHQ34ILMBoB71VjfUBWH
         v78yan9xXlQt48EHofHn7HUOzQiG+6v0kChcyMKnADPPeDfG59VH5eM4cyhe+pUIUb8Q
         VosYCxgPDQV5fRlsCIo9UB5iptohLFlVMsgF3ueDGe8t3oLN9d27ANb5bpbk7iRzIN4w
         mzhxopOh4ZbTmpus12oD8lpfyETg8dZg0IcHEBVQdGOPoYF/E1zrIyd/qvA5qBs/60dH
         Y8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SSiRW01ACwOK0LAIQZ5fNsRTzzFu0Gl8U0LeJb+1GHg=;
        b=fMfSyVJL28ltxzwbB8tpw7X2SaQnHjKDvlVIHRYBfMhMweWlpk1wRtfO59c2xkqOMx
         Y0ZQAp615Gfo98b7mLHhZyy4JU3RFRIjqm7Mv/x0ZJEocXNcTxCts+fIWfzamMAfg4dp
         6UZNglf71pGA1mnXTQcyaIq0VkMabt9B/Rtn3QI69hi22JsUA79Vvm8fO/Cwb8AEaPlB
         3U93gBnoAF9YHJi7LdO6Mqm8UHaN9HVP3l0hfurbHeI+WsmzprzFyqmoCab1to89GtvL
         uz6lQxiOlR0Jqkj40jzL7EYLlFF0bd0LU2bgT21uxcdZ5SQajLF3izc6onzHfL5z6m7L
         ld6A==
X-Gm-Message-State: AJIora/mbbwQV6aV8xjqcm8OC1khgn95EuhVshWbDLnyR/anp9jwv2ye
        N36o0qsowj8VX1EKFBDok19Zz3C8hL0pWg==
X-Google-Smtp-Source: AGRyM1sdKo8merGW/hwSwg/bNVa+mVPnKqnoyaI+DrHRYaroe907YMgxmKnJBhqP7gEYeKhHkAdCpw==
X-Received: by 2002:a05:6000:1686:b0:219:b932:ffba with SMTP id y6-20020a056000168600b00219b932ffbamr11715028wrd.227.1655511681548;
        Fri, 17 Jun 2022 17:21:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b003975c7058bfsm7260860wmq.12.2022.06.17.17.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:20 -0700 (PDT)
Message-Id: <b314aa9c436ae8e582f59ab4fb21238934a95d46.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:58 +0000
Subject: [PATCH v7 15/17] merge-tree: allow `ls-files -u` style info to be NUL
 terminated
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

Much as `git ls-files` has a -z option, let's add one to merge-tree so
that the conflict-info section can be NUL terminated (and avoid quoting
of unusual filenames).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 21 +++++++++++++---
 builtin/merge-tree.c             |  4 ++-
 t/t4301-merge-tree-write-tree.sh | 42 ++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index b89aabdb98e..75b57f8abab 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -40,6 +40,12 @@ After the merge completes, a new toplevel tree object is created.  See
 OPTIONS
 -------
 
+-z::
+	Do not quote filenames in the <Conflicted file info> section,
+	and end each filename with a NUL character rather than
+	newline.  Also begin the messages section with a NUL character
+	instead of a newline.  See <<OUTPUT>> below for more information.
+
 --name-only::
 	In the Conflicted file info section, instead of writing a list
 	of (mode, oid, stage, path) tuples to output for conflicted
@@ -76,7 +82,8 @@ OID of toplevel tree
 
 This is a tree object that represents what would be checked out in the
 working tree at the end of `git merge`.  If there were conflicts, then
-files within this tree may have embedded conflict markers.
+files within this tree may have embedded conflict markers.  This section
+is always followed by a newline (or NUL if `-z` is passed).
 
 [[CFI]]
 Conflicted file info
@@ -89,20 +96,26 @@ This is a sequence of lines with the format
 The filename will be quoted as explained for the configuration
 variable `core.quotePath` (see linkgit:git-config[1]).  However, if
 the `--name-only` option is passed, the mode, object, and stage will
-be omitted.
+be omitted.  If `-z` is passed, the "lines" are terminated by a NUL
+character instead of a newline character.
 
 [[IM]]
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
-This always starts with a blank line to separate it from the previous
-sections, and then has free-form messages about the merge, such as:
+This always starts with a blank line (or NUL if `-z` is passed) to
+separate it from the previous sections, and then has free-form
+messages about the merge, such as:
 
   * "Auto-merging <file>"
   * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
   * "Failed to merge submodule <submodule> (<reason>)"
   * "Warning: cannot merge binary files: <filename>"
 
+Note that these free-form messages will never have a NUL character
+in or between them, even if -z is passed.  It is simply a large block
+of text taking up the remainder of the output.
+
 EXIT STATUS
 -----------
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index b3c5692498e..c159e317743 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -445,7 +445,7 @@ static int real_merge(struct merge_tree_options *o,
 	if (o->show_messages == -1)
 		o->show_messages = !result.clean;
 
-	puts(oid_to_hex(&result.tree->object.oid));
+	printf("%s%c", oid_to_hex(&result.tree->object.oid), line_termination);
 	if (!result.clean) {
 		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
 		const char *last = NULL;
@@ -494,6 +494,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			    N_("do a trivial merge only"), MODE_TRIVIAL),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_SET_INT('z', NULL, &line_termination,
+			    N_("separate paths with the NUL character"), '\0'),
 		OPT_BOOL_F(0, "name-only",
 			   &o.name_only,
 			   N_("list filenames without modes/oids/stages"),
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 0ec5f0d3f7e..88e75b18cc5 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -173,4 +173,46 @@ test_expect_success 'Check conflicted oids and modes without messages' '
 	test_cmp conflicted-file-info actual
 '
 
+test_expect_success 'NUL terminated conflicted file "lines"' '
+	git checkout -b tweak1 side1 &&
+	test_write_lines zero 1 2 3 4 5 6 >numbers &&
+	git add numbers &&
+	git mv numbers "Αυτά μου φαίνονται κινέζικα" &&
+	git commit -m "Renamed numbers" &&
+
+	test_expect_code 1 git merge-tree --write-tree -z tweak1 side2 >out &&
+	anonymize_hash out >actual &&
+	printf "\\n" >>actual &&
+
+	# Expected results:
+	#   "greeting" should merge with conflicts
+	#   "whatever" has *both* a modify/delete and a file/directory conflict
+	#   "Αυτά μου φαίνονται κινέζικα" should have a conflict
+	echo HASH | lf_to_nul >expect &&
+
+	q_to_tab <<-EOF | lf_to_nul >>expect &&
+	100644 HASH 1Qgreeting
+	100644 HASH 2Qgreeting
+	100644 HASH 3Qgreeting
+	100644 HASH 1Qwhatever~tweak1
+	100644 HASH 2Qwhatever~tweak1
+	100644 HASH 1QΑυτά μου φαίνονται κινέζικα
+	100644 HASH 2QΑυτά μου φαίνονται κινέζικα
+	100644 HASH 3QΑυτά μου φαίνονται κινέζικα
+
+	EOF
+
+	q_to_nul <<-EOF >>expect &&
+	1QgreetingQAuto-mergingQAuto-merging greeting
+	Q1QgreetingQCONFLICT (contents)QCONFLICT (content): Merge conflict in greeting
+	Q2Qwhatever~tweak1QwhateverQCONFLICT (file/directory)QCONFLICT (file/directory): directory in the way of whatever from tweak1; moving it to whatever~tweak1 instead.
+	Q1Qwhatever~tweak1QCONFLICT (modify/delete)QCONFLICT (modify/delete): whatever~tweak1 deleted in side2 and modified in tweak1.  Version tweak1 of whatever~tweak1 left in tree.
+	Q1QΑυτά μου φαίνονται κινέζικαQAuto-mergingQAuto-merging Αυτά μου φαίνονται κινέζικα
+	Q1QΑυτά μου φαίνονται κινέζικαQCONFLICT (contents)QCONFLICT (content): Merge conflict in Αυτά μου φαίνονται κινέζικα
+	Q
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

