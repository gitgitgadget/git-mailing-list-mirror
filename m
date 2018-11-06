Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5092B1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 16:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389284AbeKGBu1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 20:50:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39378 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbeKGBu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 20:50:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10-v6so14210203wrv.6
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 08:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=boc3Y4E0mZyW7ozU+XNTpRYLntjKRcKchqnB2feqUoY=;
        b=jYa6ZbDyvg+EKvGx8I7g2l+Z5DOmu5+vABa2OyUJZ6Zj2fbaMB5VkrVNBxHr/J4A/l
         o8RGasdAx9S0PQsvUpgkZv8adxJnozaKfx3wkpQUhTJVAzhOPVYxLylwBdrT+U9ISxUz
         5OgMXM91VhBi+7sqcVd0BK8BPNi0HNOOP+J8VeZHmSvMDATzuKynkbWg9O4+BlJWP13s
         aWUGmRxcXhbo6otVXrbWlhXO4hUkRCCQZAcbVWkuNXPi4OYFKss2ykQ0fjKrHN7HNmCH
         QAytgMD8TmIhYVK3QSAje+Ly6XBxPYAQeP8EuOzjt24w/HrvRjJvdFOLycHRoFaSeieQ
         Niag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=boc3Y4E0mZyW7ozU+XNTpRYLntjKRcKchqnB2feqUoY=;
        b=tV2Z3covWQbB7r9tcFcKrwREDYFodBOK2GuCXlQYbR8GIcyAInLaExV8d4wgnkfnx0
         Cp7JWyJIZ7YaQ7gnLR1VZIOFkSunkqZ263p7Y1b1gdtDYceYSF8ZqQsPdxzb+3494c4E
         zqFD8ADK1FjEkNRp/RVodPSt3xrzfmaP3dQCj9kL2L4kRMjNA1Wt5b480ux20pJkFmsu
         NRj0MT54LK8xOmL1HwWLk2ZPt59DhkWmo9Zd8bJhhVBzGWo9E+i9Sdi2HbN3FkgkMrxH
         +2QGogRkEigVbLr0TGl3bg1kaeB7XlPs/g73fLBCphHQbLVO5wHrIffolUlQyzEq5OcE
         Q+7Q==
X-Gm-Message-State: AGRZ1gIO+Wkz+DrWTi+J9kAon9ntKjGmWqoW70xSbUDGwKxtlP39JfEB
        24AS3gJrcxyrED0sZBaIdMs3FvSRAPw=
X-Google-Smtp-Source: AJdET5ehtcD/PcND6EV1gnQH+PLfX0b479z3lM6xIWXvdcv5xCHtkAtOqdDARx0Li0BjypU/ba7GAA==
X-Received: by 2002:adf:e406:: with SMTP id g6-v6mr17291787wrm.277.1541521466918;
        Tue, 06 Nov 2018 08:24:26 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v2-v6sm16960388wru.20.2018.11.06.08.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 08:24:26 -0800 (PST)
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
Subject: [PATCH v2] range-diff: add a --no-patch option to show a summary
Date:   Tue,  6 Nov 2018 16:24:13 +0000
Message-Id: <20181106162413.9785-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <20181105200650.31177-1-avarab@gmail.com>
References: <20181105200650.31177-1-avarab@gmail.com>
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
--range-diff", 2018-07-22). See [1] and related E-Mails for a
discussion about that.

1. https://public-inbox.org/git/87d0ri7gbs.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Range-diff:
1:  6e735e991c ! 1:  fe4e251f26 range-diff: add a --no-patch option to show a summary
    @@ -38,8 +38,10 @@
         option. That can be added later similar to how format-patch first
         learned --range-diff, and then --creation-factor in
         8631bf1cdd ("format-patch: add --creation-factor tweak for
    -    --range-diff", 2018-07-22). I don't see why anyone would want this for
    -    format-patch, it pretty much defeats the point of range-diff.
    +    --range-diff", 2018-07-22). See [1] and related E-Mails for a
    +    discussion about that.
    +
    +    1. https://public-inbox.org/git/87d0ri7gbs.fsf@evledraar.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -50,9 +52,10 @@
      	See the ``Algorithm`` section below for an explanation why this is
      	needed.
      
    ++-s::
     +--no-patch::
    -+	Don't show the range-diff itself, only which patches are the
    -+	same or were added or removed etc.
    ++	Suppress diff output. Only shows how the range has changed at
    ++	a commit-level.
     +
      <range1> <range2>::
      	Compare the commits specified by the two ranges, where
    @@ -78,14 +81,14 @@
      	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
      	struct diff_options diffopt = { NULL };
      	int simple_color = -1;
    -+	int patch = 1;
    ++	int no_patch = 0;
      	struct option options[] = {
      		OPT_INTEGER(0, "creation-factor", &creation_factor,
      			    N_("Percentage by which creation is weighted")),
      		OPT_BOOL(0, "no-dual-color", &simple_color,
      			    N_("use simple diff colors")),
    -+		OPT_BOOL('p', "patch", &patch,
    -+			 N_("show patch output")),
    ++		OPT_BOOL_F('s', "no-patch", &no_patch,
    ++			 N_("show patch output"), PARSE_OPT_NONEG),
      		OPT_END()
      	};
      	int i, j, res = 0;
    @@ -94,7 +97,7 @@
      
      	res = show_range_diff(range1.buf, range2.buf, creation_factor,
     -			      simple_color < 1, &diffopt);
    -+			      simple_color < 1, patch, &diffopt);
    ++			      simple_color < 1, !no_patch, &diffopt);
      
      	strbuf_release(&range1);
      	strbuf_release(&range2);
    @@ -155,7 +158,14 @@
      	test_cmp expected actual
      '
      
    -+test_expect_success 'changed commit --no-patch' '
    ++test_expect_success 'changed commit -p & --patch' '
    ++	git range-diff --no-color -p topic...changed >actual &&
    ++	test_cmp expected actual &&
    ++	git range-diff --no-color --patch topic...changed >actual &&
    ++	test_cmp expected actual
    ++'
    ++
    ++test_expect_success 'changed commit -s & --no-patch' '
     +	git range-diff --no-color --no-patch topic...changed >actual &&
     +	cat >expected <<-EOF &&
     +	1:  4de457d = 1:  a4b3333 s/5/A/
    @@ -163,6 +173,8 @@
     +	3:  147e64e ! 3:  0559556 s/11/B/
     +	4:  a63e992 ! 4:  d966c5c s/12/B/
     +	EOF
    ++	test_cmp expected actual &&
    ++	git range-diff --no-color -s topic...changed >actual &&
     +	test_cmp expected actual
     +'
     +

 Documentation/git-range-diff.txt |  5 +++
 builtin/log.c                    |  2 +-
 builtin/range-diff.c             |  5 ++-
 log-tree.c                       |  2 +-
 range-diff.c                     |  6 +++-
 range-diff.h                     |  1 +
 t/t3206-range-diff.sh            | 54 ++++++++++++++++++++++++++++++++
 7 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index f693930fdb..6c1eb647a1 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -57,6 +57,11 @@ to revert to color all lines according to the outer diff markers
 	See the ``Algorithm`` section below for an explanation why this is
 	needed.
 
+-s::
+--no-patch::
+	Suppress diff output. Only shows how the range has changed at
+	a commit-level.
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
index f01a0be851..05d1f6b6b6 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -16,11 +16,14 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	struct diff_options diffopt = { NULL };
 	int simple_color = -1;
+	int no_patch = 0;
 	struct option options[] = {
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
+		OPT_BOOL_F('s', "no-patch", &no_patch,
+			 N_("show patch output"), PARSE_OPT_NONEG),
 		OPT_END()
 	};
 	int i, j, res = 0;
@@ -92,7 +95,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	}
 
 	res = show_range_diff(range1.buf, range2.buf, creation_factor,
-			      simple_color < 1, &diffopt);
+			      simple_color < 1, !no_patch, &diffopt);
 
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
index 6aae364171..27e071650b 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -122,6 +122,26 @@ test_expect_success 'changed commit' '
 	test_cmp expected actual
 '
 
+test_expect_success 'changed commit -p & --patch' '
+	git range-diff --no-color -p topic...changed >actual &&
+	test_cmp expected actual &&
+	git range-diff --no-color --patch topic...changed >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'changed commit -s & --no-patch' '
+	git range-diff --no-color --no-patch topic...changed >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  a4b3333 s/5/A/
+	2:  fccce22 = 2:  f51d370 s/4/A/
+	3:  147e64e ! 3:  0559556 s/11/B/
+	4:  a63e992 ! 4:  d966c5c s/12/B/
+	EOF
+	test_cmp expected actual &&
+	git range-diff --no-color -s topic...changed >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'changed commit with sm config' '
 	git range-diff --no-color --submodule=log topic...changed >actual &&
 	cat >expected <<-EOF &&
@@ -151,6 +171,17 @@ test_expect_success 'changed commit with sm config' '
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
@@ -176,6 +207,17 @@ test_expect_success 'changed message' '
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
@@ -215,6 +257,18 @@ test_expect_success 'dual-coloring' '
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

