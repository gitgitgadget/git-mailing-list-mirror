Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBDAD1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 20:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeKFF2W (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 00:28:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34582 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeKFF2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 00:28:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id f1-v6so7177367wmg.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 12:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rllfApYB48Rp0Am7DB9kET0PPxBWDZzO+nSg24F8M7E=;
        b=LkKlCGDW/X8tSKJ/m9T4d6umJVHOkH5BN6MRKLuiTCGD9olx5ZuHJqV4SkE/VRIn47
         z0bF9gw7Wcyx8Rrynp4YlrrjWfL8+eAEckOJjIIHG6Tb0I30dZ6I1p8LeX0B7zgp2W3g
         rhj29jluVy2qU0dA0ziCqna9XdGaOleah37vwKCGTLCoZT09BtObkxOJOdPZ5Cv6VcLr
         zEqfXT2RvJ6MEmAuv64GsjmNeLmk25Xx1jMpn9+FxN+0Q8Hb79qh6T0NAHPdn56RrP6I
         SXfOAaYTtwkDjQ2ZNthXAeD+cZ4hG4Jnd3cBXcZw+XLUsvjrfMAE0RkLQcMaGo0u3ljf
         XptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rllfApYB48Rp0Am7DB9kET0PPxBWDZzO+nSg24F8M7E=;
        b=hn/BxeWL4IRGGf76bHs2HgVlZJo/pUF3uxJbHZHoxyY87nGwZ/3L1X+Pnl49kavRcJ
         URCNkOKKhcTXOKuYj2AS8JSydT+9+mLGAQ4W4PPjc2lHNV+uRU9mHQ1UBqtMEFr92xjp
         UgNrDH706tZYOO17/eEQ4CDl8FuBM0Y4XvPvzxcuYfTbkCfmN8UGrUZnn9b1+0ErARmW
         CpNIuVmeisFn2fWG+k2LW/qv4Rljj7An9oWKqQhQInLVeOWVtrP/TvZS7iKwdmHZjZG2
         PzSD7pTMHF00SAS7ug/TyUTRf3R6HmhxW9JiDIIdc3LQiPmS0NGyQiLBojhsGdsgUuwK
         IGcw==
X-Gm-Message-State: AGRZ1gKolU1CFLuvkt850BpwvbXYGjh97NmO3viy2TZqTBXbaJCE5u4g
        EvFM7RoOgDi8bylZksCYoCpMD6PV
X-Google-Smtp-Source: AJdET5fP//5doCcl/Um9LXZJIQk6wYxgob0tGfTQ7y7K0h3K3UnFDEvkVSynyVucsJAA/KPIkTWYWA==
X-Received: by 2002:a1c:98ce:: with SMTP id a197-v6mr3075663wme.135.1541448419996;
        Mon, 05 Nov 2018 12:06:59 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o4-v6sm32449761wrj.45.2018.11.05.12.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:06:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] range-diff: add a --no-patch option to show a summary
Date:   Mon,  5 Nov 2018 20:06:50 +0000
Message-Id: <20181105200650.31177-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --no-patch option which shows which changes got removed, added
or moved etc., without showing the diff associated with them.

This allows for using range-diff as a poor man's "shortlog" for
force-pushed branches to see what changed without getting into the
details of what specifically. E.g. diffing the latest forced-push to
"pu" gives us:

    $ ./git-range-diff --no-patch b58974365b...711aaa392f | head -n 10
     -:  ---------- >  1:  b613de67c4 diff: differentiate error handling in parse_color_moved_ws
    28:  c731affab0 !  2:  23c4bbe28e build: link with curl-defined linker flags
     -:  ---------- >  3:  14f74d5907 git-worktree.txt: correct linkgit command name
     -:  ---------- >  4:  29d51e214c sequencer.c: remove a stray semicolon
     -:  ---------- >  5:  b7845cebc0 tree-walk.c: fix overoptimistic inclusion in :(exclude) matching
     -:  ---------- >  6:  1a550529b1 t/t7510-signed-commit.sh: Add %GP to custom format checks
     -:  ---------- >  7:  1e690847d1 t/t7510-signed-commit.sh: add signing subkey to Eris Discordia key
     9:  d13ecb7d81 !  8:  d8ad847421 Add a base implementation of SHA-256 support
    10:  3f0382eef8 =  9:  cdae1d391c sha256: add an SHA-256 implementation using libgcrypt
    11:  2422fd4227 = 10:  7d81aa0857 hash: add an SHA-256 implementation using OpenSSL

That would print a total of 44 lines of output, but the full
range-diff output with --patch is 460 lines.

I thought of implementing --stat too. It would be neat if passing
DIFF_FORMAT_DIFFSTAT just worked, but using that shows the underlying
implementation details of how range-diff works, instead of a useful
diffstat. So I'll leave that to a future change. Such a feature should
be something like a textual summary of the --patch output itself,
e.g.:

    N hunks, X insertions(+), Y deletions(-)

This change doesn't update git-format-patch with a --no-patch
option. That can be added later similar to how format-patch first
learned --range-diff, and then --creation-factor in
8631bf1cdd ("format-patch: add --creation-factor tweak for
--range-diff", 2018-07-22). I don't see why anyone would want this for
format-patch, it pretty much defeats the point of range-diff.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-range-diff.txt |  4 +++
 builtin/log.c                    |  2 +-
 builtin/range-diff.c             |  5 +++-
 log-tree.c                       |  2 +-
 range-diff.c                     |  6 ++++-
 range-diff.h                     |  1 +
 t/t3206-range-diff.sh            | 45 ++++++++++++++++++++++++++++++++
 7 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index f693930fdb..d0473cbcb1 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -57,6 +57,10 @@ to revert to color all lines according to the outer diff markers
 	See the ``Algorithm`` section below for an explanation why this is
 	needed.
 
+--no-patch::
+	Don't show the range-diff itself, only which patches are the
+	same or were added or removed etc.
+
 <range1> <range2>::
 	Compare the commits specified by the two ranges, where
 	`<range1>` is considered an older version of `<range2>`.
diff --git a/builtin/log.c b/builtin/log.c
index 061d4fd864..e063bcf2dd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1096,7 +1096,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (rev->rdiff1) {
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
 		show_range_diff(rev->rdiff1, rev->rdiff2,
-				rev->creation_factor, 1, &rev->diffopt);
+				rev->creation_factor, 1, 1, &rev->diffopt);
 	}
 }
 
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index f01a0be851..70c2761751 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -16,11 +16,14 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	struct diff_options diffopt = { NULL };
 	int simple_color = -1;
+	int patch = 1;
 	struct option options[] = {
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
+		OPT_BOOL('p', "patch", &patch,
+			 N_("show patch output")),
 		OPT_END()
 	};
 	int i, j, res = 0;
@@ -92,7 +95,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	}
 
 	res = show_range_diff(range1.buf, range2.buf, creation_factor,
-			      simple_color < 1, &diffopt);
+			      simple_color < 1, patch, &diffopt);
 
 	strbuf_release(&range1);
 	strbuf_release(&range2);
diff --git a/log-tree.c b/log-tree.c
index 7a83e99250..843e3ef83b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -762,7 +762,7 @@ void show_log(struct rev_info *opt)
 		next_commentary_block(opt, NULL);
 		fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
 		show_range_diff(opt->rdiff1, opt->rdiff2,
-				opt->creation_factor, 1, &opt->diffopt);
+				opt->creation_factor, 1, 1, &opt->diffopt);
 
 		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
 	}
diff --git a/range-diff.c b/range-diff.c
index bd8083f2d1..c1bfa593ce 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -436,6 +436,7 @@ static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
 
 int show_range_diff(const char *range1, const char *range2,
 		    int creation_factor, int dual_color,
+		    int patch,
 		    struct diff_options *diffopt)
 {
 	int res = 0;
@@ -453,7 +454,10 @@ int show_range_diff(const char *range1, const char *range2,
 		struct strbuf indent = STRBUF_INIT;
 
 		memcpy(&opts, diffopt, sizeof(opts));
-		opts.output_format = DIFF_FORMAT_PATCH;
+		if (patch)
+			opts.output_format = DIFF_FORMAT_PATCH;
+		else
+			opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 		opts.flags.suppress_diff_headers = 1;
 		opts.flags.dual_color_diffed_diffs = dual_color;
 		opts.output_prefix = output_prefix_cb;
diff --git a/range-diff.h b/range-diff.h
index 190593f0c7..99bbc1cd9f 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -7,6 +7,7 @@
 
 int show_range_diff(const char *range1, const char *range2,
 		    int creation_factor, int dual_color,
+		    int patch,
 		    struct diff_options *diffopt);
 
 #endif
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 6aae364171..8f8be0c57f 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -122,6 +122,17 @@ test_expect_success 'changed commit' '
 	test_cmp expected actual
 '
 
+test_expect_success 'changed commit --no-patch' '
+	git range-diff --no-color --no-patch topic...changed >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  a4b3333 s/5/A/
+	2:  fccce22 = 2:  f51d370 s/4/A/
+	3:  147e64e ! 3:  0559556 s/11/B/
+	4:  a63e992 ! 4:  d966c5c s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'changed commit with sm config' '
 	git range-diff --no-color --submodule=log topic...changed >actual &&
 	cat >expected <<-EOF &&
@@ -151,6 +162,17 @@ test_expect_success 'changed commit with sm config' '
 	test_cmp expected actual
 '
 
+test_expect_success 'changed commit with sm config --no-patch' '
+	git range-diff --no-color --no-patch --submodule=log topic...changed >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  a4b3333 s/5/A/
+	2:  fccce22 = 2:  f51d370 s/4/A/
+	3:  147e64e ! 3:  0559556 s/11/B/
+	4:  a63e992 ! 4:  d966c5c s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'no commits on one side' '
 	git commit --amend -m "new message" &&
 	git range-diff master HEAD@{1} HEAD
@@ -176,6 +198,17 @@ test_expect_success 'changed message' '
 	test_cmp expected actual
 '
 
+test_expect_success 'changed message --no-patch' '
+	git range-diff --no-color --no-patch topic...changed-message >actual &&
+	sed s/Z/\ /g >expected <<-EOF &&
+	1:  4de457d = 1:  f686024 s/5/A/
+	2:  fccce22 ! 2:  4ab067d s/4/A/
+	3:  147e64e = 3:  b9cb956 s/11/B/
+	4:  a63e992 = 4:  8add5f1 s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'dual-coloring' '
 	sed -e "s|^:||" >expect <<-\EOF &&
 	:<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
@@ -215,6 +248,18 @@ test_expect_success 'dual-coloring' '
 	test_cmp expect actual
 '
 
+test_expect_success 'dual-coloring --no-patch' '
+	sed -e "s|^:||" >expect <<-\EOF &&
+	:<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
+	:<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
+	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
+	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
+	EOF
+	git range-diff changed...changed-message --color --dual-color --no-patch >actual.raw &&
+	test_decode_color >actual <actual.raw &&
+	test_cmp expect actual
+'
+
 for prev in topic master..topic
 do
 	test_expect_success "format-patch --range-diff=$prev" '
-- 
2.19.1.930.g4563a0d9d0

