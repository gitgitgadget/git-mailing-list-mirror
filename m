Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14698C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 16:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244369AbiHWQPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244355AbiHWQOq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 12:14:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C30411A10
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 05:35:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so9494159wme.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=sMahz/uOsSeehP3gAU3asVNIYUygxG7IYFMC5jM/h5w=;
        b=PaNLw4ciolUiMBR69fpqX3yKZJTFTHhkmwFC2pHtAtZth1+YmgwXFZgyQRgPPlNkBw
         O4JkOv8QqAH+YymPZQ/ftHt56V5cOXV7eJs/CWjYYIp9sVxdcqKqdD/MT53+rTLRiSkK
         wIk7zCkYPqoHJl9ijCbbeZRWAkmNv7DJM8Wt99Qjug1jrBsIpSmPXcqzCRRGo0SbpkC8
         +6oooxQYWmdSB3pkgOT1m3nTgrFoznNhBnGvpzkxf4sNs8kFqQTWD9WCIHTVdfOA2EKu
         4j34eEP5wrizFwHXBkN4V73zYpkuCj8M0Sx7p5CBHxAgKDm9bHTu1fpeaN4S62jwAY+c
         qGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=sMahz/uOsSeehP3gAU3asVNIYUygxG7IYFMC5jM/h5w=;
        b=W7Rl2lw9HiNbB8ZYoUWmLCqJtAJY/vVMDfezrUqKxbJJwLBMYPWBgOvnlfFP8sodRJ
         /ytNFtOab1IBmjpNcVwBcY/MrPZqrOnBV6cd9w+GZr0PAS0GlMK6/6Fbd9NiwJb0nIdH
         AFU/v4OlIvLpOr3jHYmcvHCBhryFN9Tzlmp34LSXk8k121MPNne83PzKTrLt5teZD/ja
         zTw8b2SPRku+5CE4xDQE8cqwCVv9OgFjBWhq+GJ9ozA123M6RUucjFGt0Gveq2CXWTFP
         BrXjGSE63cfRZtxJMeZaPBGIjnP6bHyBzYNz/rjIMIMUUXV0LFFBRkFhjqrDOnSWUNTP
         gfUQ==
X-Gm-Message-State: ACgBeo0hou7Sja/0UwotZzvPD/nZ+N1Xy/Ho7ytv656ruw4wvG/CQHrN
        e6UPzF6l4DbJedyame6h7cVyImHP220=
X-Google-Smtp-Source: AA6agR4pMILrBfqjSCH8eFsXbEy5SyL0GmW3EA5HE3aQRK4Mvq4n8Zl0HjRdcgBzLehggfUnAdMe7A==
X-Received: by 2002:a1c:3b04:0:b0:3a5:487c:6240 with SMTP id i4-20020a1c3b04000000b003a5487c6240mr2090851wma.152.1661258125155;
        Tue, 23 Aug 2022 05:35:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m30-20020a05600c3b1e00b003a6077384ecsm22063921wms.31.2022.08.23.05.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 05:35:24 -0700 (PDT)
Message-Id: <064b147451b04051a413b532cd97ae764ba68027.1661258122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
References: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 12:35:22 +0000
Subject: [PATCH 2/2] range-diff: optionally accept a pathspec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `git range-diff` command can be quite expensive, which is not a
surprise given that the underlying algorithm to match up pairs of
commits between the provided two commit ranges has a cubic runtime.

Therefore it makes sense to restrict the commit ranges as much as
possible, to reduce the amount of input to that O(N^3) algorithm.

In chatty repositories with wide trees, this is not necessarily
possible merely by choosing commit ranges wisely.

Let's give users another option to restrict the commit ranges: by
providing a pathspec. That helps in repositories with wide trees because
it is likely that the user has a good idea which subset of the tree they
are actually interested in.

Example:

	git range-diff upstream/main upstream/seen HEAD -- range-diff.c

This shows commits that are either in the local branch or in `seen`, but
not in `main`, skipping all commits that do not touch `range-diff.c`.

Note: Since we piggy-back the pathspecs onto the `other_arg` mechanism
that was introduced to be able to pass through the `--notes` option to
the revision machinery, we must now ensure that the `other_arg` array is
appended at the end (the revision range must come before the pathspecs,
if any).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-range-diff.txt |  4 ++++
 builtin/range-diff.c             | 30 +++++++++++++++++++++++++++++-
 range-diff.c                     |  2 +-
 t/t3206-range-diff.sh            | 11 +++++++++++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index fe350d7f405..0b393715d70 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 	[--no-dual-color] [--creation-factor=<factor>]
 	[--left-only | --right-only]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
+	[[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -19,6 +20,9 @@ DESCRIPTION
 This command shows the differences between two versions of a patch
 series, or more generally, two commit ranges (ignoring merge commits).
 
+In the presence of `<path>` arguments, these commit ranges are limited
+accordingly.
+
 To that end, it first finds pairs of commits from both commit ranges
 that correspond with each other. Two commits are said to correspond when
 the diff between their patches (i.e. the author information, the commit
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index c8ffcd35aea..9ae95b9c950 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -40,6 +40,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	struct option *options;
 	int res = 0;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
+	struct object_id oid;
+	const char *p;
 
 	git_config(git_diff_ui_config, NULL);
 
@@ -47,7 +49,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	options = parse_options_concat(range_diff_options, diffopt.parseopts);
 	argc = parse_options(argc, argv, prefix, options,
-			     builtin_range_diff_usage, 0);
+			     builtin_range_diff_usage, PARSE_OPT_KEEP_DASHDASH);
 
 	diff_setup_done(&diffopt);
 
@@ -74,6 +76,20 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 			b = "HEAD";
 		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
 		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
+	} else if (argc > 1 && (p = strstr(argv[0], "..."))) {
+		const char *a = argv[0];
+		int a_len = (int)(p - a);
+
+		if (!a_len) {
+			a = "HEAD";
+			a_len = strlen(a);
+		}
+		p += 3;
+		if (!*p)
+			p = "HEAD";
+		strbuf_addf(&range1, "%s..%.*s", p, a_len, a);
+		strbuf_addf(&range2, "%.*s..%s", a_len, a, p);
+		strvec_pushv(&other_arg, argv + 1);
 	} else if (argc == 2) {
 		if (!is_range_diff_range(argv[0]))
 			die(_("not a commit range: '%s'"), argv[0]);
@@ -82,9 +98,21 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		if (!is_range_diff_range(argv[1]))
 			die(_("not a commit range: '%s'"), argv[1]);
 		strbuf_addstr(&range2, argv[1]);
+	} else if (argc > 2 &&
+	    is_range_diff_range(argv[0]) && is_range_diff_range(argv[1])) {
+		strbuf_addstr(&range1, argv[0]);
+		strbuf_addstr(&range2, argv[1]);
+		strvec_pushv(&other_arg, argv + 2);
 	} else if (argc == 3) {
 		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
 		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
+	} else if (argc > 3 &&
+		   get_oid_committish(argv[0], &oid) &&
+		   get_oid_committish(argv[1], &oid) &&
+		   get_oid_committish(argv[2], &oid)) {
+		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
+		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
+		strvec_pushv(&other_arg, argv + 3);
 	} else {
 		error(_("need two commit ranges"));
 		usage_with_options(builtin_range_diff_usage, options);
diff --git a/range-diff.c b/range-diff.c
index f63b3ffc200..124dd678c38 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -57,9 +57,9 @@ static int read_patches(const char *range, struct string_list *list,
 		     "--pretty=medium",
 		     "--notes",
 		     NULL);
+	strvec_push(&cp.args, range);
 	if (other_arg)
 		strvec_pushv(&cp.args, other_arg->v);
-	strvec_push(&cp.args, range);
 	cp.out = -1;
 	cp.no_stdin = 1;
 	cp.git_cmd = 1;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index d12e4e4cc6c..f2821a69b6f 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -772,6 +772,17 @@ test_expect_success '--left-only/--right-only' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ranges with pathspecs' '
+	git range-diff topic...mode-only-change -- other-file >actual &&
+	test_line_count = 2 actual &&
+	topic_oid=$(git rev-parse --short topic) &&
+	mode_change_oid=$(git rev-parse --short mode-only-change^) &&
+	file_change_oid=$(git rev-parse --short mode-only-change) &&
+	grep "$mode_change_oid" actual &&
+	! grep "$file_change_oid" actual &&
+	! grep "$topic_oid" actual
+'
+
 test_expect_success 'submodule changes are shown irrespective of diff.submodule' '
 	git init sub-repo &&
 	test_commit -C sub-repo sub-first &&
-- 
gitgitgadget
