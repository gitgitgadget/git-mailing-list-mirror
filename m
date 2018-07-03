Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A761F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeGCL0O (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:14 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:36696 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753161AbeGCL0L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:11 -0400
Received: by mail-pl0-f41.google.com with SMTP id a7-v6so900513plp.3
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cTHw5847Ehnq1TYftDtLP2+2mjnXkqaxwRDxIFHNyj4=;
        b=P6UCqdcQgxp7EAOtO75Alr+LYKb2cyohqFi25FsJl6sH2x51x3alptmbCribAMKxg6
         vWTAs2JbE2kGdGDsRGtYGjaEvzjXOiIZqXBEo+X72osERViUX+/LrGebpxP5YrZRctHu
         mV1msZrmvnkxl2IfDirrGfw6Nz4cHHxifSBW/ActJvldrLDKZpnXgu5Pm1Q85fJbqrpd
         wkRSJQzRQ9DAmV8PB7FnpdttMp+nAJnYE1dnBdsw19FovYb0diUNujgTQvriueI/YVJE
         XrpSeb0Q6iShdqdytEhTJpA6L1FzzKkxOOzX9xWgABSwjHKYx1SY2ZRMMOsbaovEN0U2
         dFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cTHw5847Ehnq1TYftDtLP2+2mjnXkqaxwRDxIFHNyj4=;
        b=e6QMrAShh3v6syob1/cVmfw/aeKM2hUDtjRadd0JGVfa/C/CRziOrsVO/dNGSO7m2W
         HHTvZ9lY6WabB9WhRUWwHjzq749jbIM9xSTu1zT4oNlyn/4woDT76lnmEy8rrEVWdxGW
         4womvB5gZ/aRfWzx6f+DFCUy2Qlwc4rMLm2NIeZcKu2OyTWCjxgKYh2DYiO+r1RhLefe
         1a+6jBsOQAVXjimpFF9vNqIsKbFCcS9xEYsWuPDnHYqqGCfv+ODjGlDFCM0pisaHnZ+I
         Q5ZrZIN8mQ4DAkN4DxzOwhXo+os2QDIbWJwNFQFJC0JQRZoLGNicZ9jEP8oWNdE8etbR
         RNxg==
X-Gm-Message-State: APt69E3Q4AyYxGysxABelHG+YRYQF50i97j6PK3ug6hXuaL0JPLqaSgu
        TWleYkGYw8mC/MD6PeQAXwRGkQ==
X-Google-Smtp-Source: AAOMgpd4z1E9SyQoJi7hNdAtMtjJbh9jjhqs5baenhGntfVYA/6/tvWvFk4PTeRZyH8HL2d6lHBJyw==
X-Received: by 2002:a17:902:b785:: with SMTP id e5-v6mr22112328pls.339.1530617169457;
        Tue, 03 Jul 2018 04:26:09 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id x2-v6sm2099798pgq.33.2018.07.03.04.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:08 -0700 (PDT)
Message-Id: <pull.1.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 3 Jul 2018 11:26:06 +0000
Subject: [PATCH v3 00/20] Add `range-diff`, a `tbdiff` lookalike
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The incredibly useful `git-tbdiff` tool to compare patch series (say, to see what changed between two iterations sent to the Git mailing list) is slightly less useful for this developer due to the fact that it requires the `hungarian` and `numpy` Python packages which are for some reason really hard to build in MSYS2. So hard that I even had to give up, because it was simply easier to reimplement the whole shebang as a builtin command.

The project at https://github.com/trast/tbdiff seems to be dormant, anyway. Funny (and true) story: I looked at the open Pull Requests to see how active that project is, only to find to my surprise that I had submitted one in August 2015, and that it was still unanswered let alone merged.

While at it, I forward-ported AEvar's patch to force `--decorate=no` because `git -p tbdiff` would fail otherwise.

Side note: I work on implementing branch-diff not only to make life easier for reviewers who have to suffer through v2, v3, ... of my patch series, but also to verify my changes before submitting a new iteraion. And also, maybe even more importantly, I plan to use it to verify my merging-rebases of Git for
Windows (for which I previously used to redirect the pre-rebase/post-rebase diffs vs upstream and then compare them using `git diff --no-index`). And of course any interested person can see what changes were necessary e.g. in the merging-rebase of Git for Windows onto v2.17.0 by running a command like:

```sh
        base=^{/Start.the.merging-rebase}
        tag=v2.17.0.windows.1
        pre=$tag$base^2
        git branch-diff --dual-color $pre$base..$pre $tag$base..$tag
```

The --dual-color mode will identify the many changes that are solely due to different diff context lines (where otherwise uncolored lines start with a background-colored -/+ marker), i.e. merge conflicts I had to resolve.

Changes since v2:

- Right-aligned the patch numbers in the commit pairs.
- Used ALLOC_ARRAY() in hungarian.c instead of xmalloc(sizeof()*size).
- Changed compute_assignment()s return type from int to void, as it always succeeds.
- Changed the Hungarian Algorithm to use an integer cost matrix.
- Changed the --creation-weight <double> option to --creation-factor <percent> where <percent> is an integer.
- Retitled 1/19 and 2/19 to better conform with the current conventions, as pointed out (and suggested) by Junio.
- Shut up Coverity, and at the same time avoided passing the unnecessary `i` and `j` parameters to output_pair_header().
- Removed support for the `--no-patches` option: we inherit diff_options' support for `-s` already (and much more).
- Removed the ugly `_INV` enum values, and introduced a beautiful GIT_COLOR_REVERSE instead. This way, whatever the user configured as color.diff.new (or .old) will be used in reverse in the dual color mode.
- Instead of overriding the fragment header color, the dual color mode will now reverse the "outer" fragment headers, too.
- Turned the stand-alone branch-diff command into the `--diff` option of `git branch`. Adjusted pretty much *all* commit messages to account for this. This change should no longer be visible: see below.
- Pretty much re-wrote the completion, to support the new --diff mode of git-branch. See below: it was reverted for range-diff.
- Renamed t7910 to t3206, to be closer to the git-branch tests.
- Ensured that git_diff_ui_config() gets called, and therefore color.diff.* respected.
- Avoided leaking `four_spaces`.
- Fixed a declaration in a for (;;) statement (which Junio had as a fixup! that I almost missed).
- Renamed `branch --diff`, which had been renamed from `branch-diff` (which was picked to avoid re-using `tbdiff`) to `range-diff`.
- Renamed `hungarian.c` and its header to `linear-assignment.c`
- Made `--dual-color` the default, and changed it to still auto-detect whether color should be used rather than forcing it

Johannes Schindelin (19):
  linear-assignment: a function to solve least-cost assignment problems
  Introduce `range-diff` to compare iterations of a topic branch
  range-diff: first rudimentary implementation
  range-diff: improve the order of the shown commits
  range-diff: also show the diff between patches
  range-diff: right-trim commit messages
  range-diff: indent the diffs just like tbdiff
  range-diff: suppress the diff headers
  range-diff: adjust the output of the commit pairs
  range-diff: do not show "function names" in hunk headers
  range-diff: use color for the commit pairs
  color: add the meta color GIT_COLOR_REVERSE
  diff: add an internal option to dual-color diffs of diffs
  range-diff: offer to dual-color the diffs
  range-diff --dual-color: work around bogus white-space warning
  range-diff: add a man page
  completion: support `git range-diff`
  range-diff: left-pad patch numbers
  range-diff: make --dual-color the default mode

Thomas Rast (1):
  range-diff: add tests

 .gitignore                             |   1 +
 Documentation/git-range-diff.txt       | 238 ++++++++++
 Makefile                               |   3 +
 builtin.h                              |   1 +
 builtin/range-diff.c                   | 104 +++++
 color.h                                |   1 +
 command-list.txt                       |   1 +
 contrib/completion/git-completion.bash |  14 +
 diff.c                                 |  94 +++-
 diff.h                                 |   2 +
 git.c                                  |   1 +
 linear-assignment.c                    | 203 +++++++++
 linear-assignment.h                    |  22 +
 range-diff.c                           | 437 ++++++++++++++++++
 range-diff.h                           |   9 +
 t/.gitattributes                       |   1 +
 t/t3206-range-diff.sh                  | 145 ++++++
 t/t3206/history.export                 | 604 +++++++++++++++++++++++++
 18 files changed, 1865 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/git-range-diff.txt
 create mode 100644 builtin/range-diff.c
 create mode 100644 linear-assignment.c
 create mode 100644 linear-assignment.h
 create mode 100644 range-diff.c
 create mode 100644 range-diff.h
 create mode 100755 t/t3206-range-diff.sh
 create mode 100644 t/t3206/history.export


base-commit: e3331758f12da22f4103eec7efe1b5304a9be5e9
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-1%2Fdscho%2Fbranch-diff-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1/dscho/branch-diff-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1

Range-diff vs v2:

  1:  3f51970cb !  1:  39272eefc Add a function to solve least-cost assignment problems
     @@ -1,11 +1,17 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    Add a function to solve least-cost assignment problems
     +    linear-assignment: a function to solve least-cost assignment problems
      
     -    The Jonker-Volgenant algorithm was implemented to answer questions such
     -    as: given two different versions of a topic branch (or iterations of a
     -    patch series), what is the best pairing of commits/patches between the
     -    different versions?
     +    The problem solved by the code introduced in this commit goes like this:
     +    given two sets of items, and a cost matrix which says how much it
     +    "costs" to assign any given item of the first set to any given item of
     +    the second, assign all items (except when the sets have different size)
     +    in the cheapest way.
     +
     +    We use the Jonker-Volgenant algorithm to solve the assignment problem to
     +    answer questions such as: given two different versions of a topic branch
     +    (or iterations of a patch series), what is the best pairing of
     +    commits/patches between the different versions?
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -16,15 +22,15 @@
       LIB_OBJS += graph.o
       LIB_OBJS += grep.o
       LIB_OBJS += hashmap.o
     -+LIB_OBJS += hungarian.o
     ++LIB_OBJS += linear-assignment.o
       LIB_OBJS += help.o
       LIB_OBJS += hex.o
       LIB_OBJS += ident.o
      
     -diff --git a/hungarian.c b/hungarian.c
     +diff --git a/linear-assignment.c b/linear-assignment.c
      new file mode 100644
      --- /dev/null
     -+++ b/hungarian.c
     ++++ b/linear-assignment.c
      @@
      +/*
      + * Based on: Jonker, R., & Volgenant, A. (1987). <i>A shortest augmenting path
     @@ -32,8 +38,7 @@
      + * 38(4), 325-340.
      + */
      +#include "cache.h"
     -+#include "hungarian.h"
     -+#include <float.h>
     ++#include "linear-assignment.h"
      +
      +#define COST(column, row) cost[(column) + column_count * (row)]
      +
     @@ -41,15 +46,16 @@
      + * The parameter `cost` is the cost matrix: the cost to assign column j to row
      + * i is `cost[j + column_count * i].
      + */
     -+int compute_assignment(int column_count, int row_count, double *cost,
     -+		       int *column2row, int *row2column)
     ++void compute_assignment(int column_count, int row_count, int *cost,
     ++			int *column2row, int *row2column)
      +{
     -+	double *v = xmalloc(sizeof(double) * column_count), *d;
     ++	int *v, *d;
      +	int *free_row, free_count = 0, saved_free_count, *pred, *col;
      +	int i, j, phase;
      +
      +	memset(column2row, -1, sizeof(int) * column_count);
      +	memset(row2column, -1, sizeof(int) * row_count);
     ++	ALLOC_ARRAY(v, column_count);
      +
      +	/* column reduction */
      +	for (j = column_count - 1; j >= 0; j--) {
     @@ -71,15 +77,15 @@
      +	}
      +
      +	/* reduction transfer */
     -+	free_row = xmalloc(sizeof(int) * row_count);
     -+	for (int i = 0; i < row_count; i++) {
     ++	ALLOC_ARRAY(free_row, row_count);
     ++	for (i = 0; i < row_count; i++) {
      +		int j1 = row2column[i];
      +		if (j1 == -1)
      +			free_row[free_count++] = i;
      +		else if (j1 < -1)
      +			row2column[i] = -2 - j1;
      +		else {
     -+			double min = COST(!j1, i) - v[!j1];
     ++			int min = COST(!j1, i) - v[!j1];
      +			for (j = 1; j < column_count; j++)
      +				if (j != j1 && min > COST(j, i) - v[j])
      +					min = COST(j, i) - v[j];
     @@ -91,7 +97,7 @@
      +	    (column_count < row_count ? row_count - column_count : 0)) {
      +		free(v);
      +		free(free_row);
     -+		return 0;
     ++		return;
      +	}
      +
      +	/* augmenting row reduction */
     @@ -101,15 +107,15 @@
      +		saved_free_count = free_count;
      +		free_count = 0;
      +		while (k < saved_free_count) {
     -+			double u1, u2;
     ++			int u1, u2;
      +			int j1 = 0, j2, i0;
      +
      +			i = free_row[k++];
      +			u1 = COST(j1, i) - v[j1];
      +			j2 = -1;
     -+			u2 = DBL_MAX;
     ++			u2 = INT_MAX;
      +			for (j = 1; j < column_count; j++) {
     -+				double c = COST(j, i) - v[j];
     ++				int c = COST(j, i) - v[j];
      +				if (u2 > c) {
      +					if (u1 < c) {
      +						u2 = c;
     @@ -148,12 +154,12 @@
      +
      +	/* augmentation */
      +	saved_free_count = free_count;
     -+	d = xmalloc(sizeof(double) * column_count);
     -+	pred = xmalloc(sizeof(int) * column_count);
     -+	col = xmalloc(sizeof(int) * column_count);
     ++	ALLOC_ARRAY(d, column_count);
     ++	ALLOC_ARRAY(pred, column_count);
     ++	ALLOC_ARRAY(col, column_count);
      +	for (free_count = 0; free_count < saved_free_count; free_count++) {
      +		int i1 = free_row[free_count], low = 0, up = 0, last, k;
     -+		double min, c, u1;
     ++		int min, c, u1;
      +
      +		for (j = 0; j < column_count; j++) {
      +			d[j] = COST(j, i1) - v[j];
     @@ -228,14 +234,12 @@
      +	free(d);
      +	free(v);
      +	free(free_row);
     -+
     -+	return 0;
      +}
      
     -diff --git a/hungarian.h b/hungarian.h
     +diff --git a/linear-assignment.h b/linear-assignment.h
      new file mode 100644
      --- /dev/null
     -+++ b/hungarian.h
     ++++ b/linear-assignment.h
      @@
      +#ifndef HUNGARIAN_H
      +#define HUNGARIAN_H
     @@ -252,7 +256,10 @@
      + * assignments (-1 for unassigned, which can happen only if column_count !=
      + * row_count).
      + */
     -+int compute_assignment(int column_count, int row_count, double *cost,
     -+		       int *column2row, int *row2column);
     ++void compute_assignment(int column_count, int row_count, int *cost,
     ++			int *column2row, int *row2column);
     ++
     ++/* The maximal cost in the cost matrix (to prevent integer overflows). */
     ++#define COST_MAX (1<<16)
      +
      +#endif
  2:  a1ea0320b <  -:  --------- Add a new builtin: branch-diff
  -:  --------- >  2:  7f15b26d4 Introduce `range-diff` to compare iterations of a topic branch
  3:  e530e450e !  3:  076e1192d branch-diff: first rudimentary implementation
     @@ -1,46 +1,117 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    branch-diff: first rudimentary implementation
     +    range-diff: first rudimentary implementation
      
     -    At this stage, `git branch-diff` can determine corresponding commits of
     -    two related commit ranges. This makes use of the recently introduced
     +    At this stage, `git range-diff` can determine corresponding commits
     +    of two related commit ranges. This makes use of the recently introduced
          implementation of the Hungarian algorithm.
      
          The core of this patch is a straight port of the ideas of tbdiff, the
     -    seemingly dormant project at https://github.com/trast/tbdiff.
     +    apparently dormant project at https://github.com/trast/tbdiff.
      
          The output does not at all match `tbdiff`'s output yet, as this patch
          really concentrates on getting the patch matching part right.
      
     -    Note: due to differences in the diff algorithm (`tbdiff` uses the
     -    Python module `difflib`, Git uses its xdiff fork), the cost matrix
     -    calculated by `branch-diff` is different (but very similar) to the one
     -    calculated by `tbdiff`. Therefore, it is possible that they find
     -    different matching commits in corner cases (e.g. when a patch was split
     -    into two patches of roughly equal length).
     +    Note: due to differences in the diff algorithm (`tbdiff` uses the Python
     +    module `difflib`, Git uses its xdiff fork), the cost matrix calculated
     +    by `range-diff` is different (but very similar) to the one calculated
     +    by `tbdiff`. Therefore, it is possible that they find different matching
     +    commits in corner cases (e.g. when a patch was split into two patches of
     +    roughly equal length).
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
     ---- a/builtin/branch-diff.c
     -+++ b/builtin/branch-diff.c
     +diff --git a/Makefile b/Makefile
     +--- a/Makefile
     ++++ b/Makefile
     +@@
     + LIB_OBJS += prompt.o
     + LIB_OBJS += protocol.o
     + LIB_OBJS += quote.o
     ++LIB_OBJS += range-diff.o
     + LIB_OBJS += reachable.o
     + LIB_OBJS += read-cache.o
     + LIB_OBJS += reflog-walk.o
     +
     +diff --git a/builtin/range-diff.c b/builtin/range-diff.c
     +--- a/builtin/range-diff.c
     ++++ b/builtin/range-diff.c
      @@
       #include "cache.h"
       #include "builtin.h"
       #include "parse-options.h"
     ++#include "range-diff.h"
     + 
     + static const char * const builtin_range_diff_usage[] = {
     + N_("git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
     +@@
     + 			    N_("Percentage by which creation is weighted")),
     + 		OPT_END()
     + 	};
     ++	int res = 0;
     ++	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
     + 
     +-	argc = parse_options(argc, argv, NULL, options,
     +-			     builtin_range_diff_usage, 0);
     ++	argc = parse_options(argc, argv, NULL, options, builtin_range_diff_usage,
     ++			     0);
     + 
     +-	return 0;
     ++	if (argc == 2) {
     ++		if (!strstr(argv[0], ".."))
     ++			warning(_("no .. in range: '%s'"), argv[0]);
     ++		strbuf_addstr(&range1, argv[0]);
     ++
     ++		if (!strstr(argv[1], ".."))
     ++			warning(_("no .. in range: '%s'"), argv[1]);
     ++		strbuf_addstr(&range2, argv[1]);
     ++	} else if (argc == 3) {
     ++		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
     ++		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
     ++	} else if (argc == 1) {
     ++		const char *b = strstr(argv[0], "..."), *a = argv[0];
     ++		int a_len;
     ++
     ++		if (!b)
     ++			die(_("single arg format requires a symmetric range"));
     ++
     ++		a_len = (int)(b - a);
     ++		if (!a_len) {
     ++			a = "HEAD";
     ++			a_len = strlen(a);
     ++		}
     ++		b += 3;
     ++		if (!*b)
     ++			b = "HEAD";
     ++		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
     ++		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
     ++	} else {
     ++		error(_("need two commit ranges"));
     ++		usage_with_options(builtin_range_diff_usage, options);
     ++	}
     ++
     ++	res = show_range_diff(range1.buf, range2.buf, creation_factor);
     ++
     ++	strbuf_release(&range1);
     ++	strbuf_release(&range2);
     ++
     ++	return res;
     + }
     +
     +diff --git a/range-diff.c b/range-diff.c
     +new file mode 100644
     +--- /dev/null
     ++++ b/range-diff.c
     +@@
     ++#include "cache.h"
     ++#include "range-diff.h"
      +#include "string-list.h"
      +#include "run-command.h"
      +#include "argv-array.h"
      +#include "hashmap.h"
      +#include "xdiff-interface.h"
     -+#include "hungarian.h"
     - 
     - static const char * const builtin_branch_diff_usage[] = {
     - N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
     -@@
     - 	return 0;
     - }
     - 
     ++#include "linear-assignment.h"
     ++
      +struct patch_util {
      +	/* For the search for an exact match */
      +	struct hashmap_entry e;
     @@ -219,16 +290,19 @@
      +		return count;
      +
      +	error(_("failed to generate diff"));
     -+	return INT_MAX;
     ++	return COST_MAX;
      +}
      +
     -+static int get_correspondences(struct string_list *a, struct string_list *b,
     -+			       double creation_weight)
     ++static void get_correspondences(struct string_list *a, struct string_list *b,
     ++				int creation_factor)
      +{
      +	int n = a->nr + b->nr;
     -+	double *cost = xmalloc(sizeof(double) * n * n), c;
     -+	int *a2b = xmalloc(sizeof(int) * n), *b2a = xmalloc(sizeof(int) * n);
     -+	int i, j, res;
     ++	int *cost, c, *a2b, *b2a;
     ++	int i, j;
     ++
     ++	ALLOC_ARRAY(cost, st_mult(n, n));
     ++	ALLOC_ARRAY(a2b, n);
     ++	ALLOC_ARRAY(b2a, n);
      +
      +	for (i = 0; i < a->nr; i++) {
      +		struct patch_util *a_util = a->items[i].util;
     @@ -241,12 +315,12 @@
      +			else if (a_util->matching < 0 && b_util->matching < 0)
      +				c = diffsize(a_util->diff, b_util->diff);
      +			else
     -+				c = INT_MAX;
     ++				c = COST_MAX;
      +			cost[i + n * j] = c;
      +		}
      +
      +		c = a_util->matching < 0 ?
     -+			a_util->diffsize * creation_weight : INT_MAX;
     ++			a_util->diffsize * creation_factor / 100 : COST_MAX;
      +		for (j = b->nr; j < n; j++)
      +			cost[i + n * j] = c;
      +	}
     @@ -255,7 +329,7 @@
      +		struct patch_util *util = b->items[j].util;
      +
      +		c = util->matching < 0 ?
     -+			util->diffsize * creation_weight : INT_MAX;
     ++			util->diffsize * creation_factor / 100 : COST_MAX;
      +		for (i = a->nr; i < n; i++)
      +			cost[i + n * j] = c;
      +	}
     @@ -264,7 +338,7 @@
      +		for (j = b->nr; j < n; j++)
      +			cost[i + n * j] = 0;
      +
     -+	res = compute_assignment(n, n, cost, a2b, b2a);
     ++	compute_assignment(n, n, cost, a2b, b2a);
      +
      +	for (i = 0; i < a->nr; i++)
      +		if (a2b[i] >= 0 && a2b[i] < b->nr) {
     @@ -278,8 +352,6 @@
      +	free(cost);
      +	free(a2b);
      +	free(b2a);
     -+
     -+	return res;
      +}
      +
      +static const char *short_oid(struct patch_util *util)
     @@ -314,71 +386,40 @@
      +	}
      +}
      +
     - int cmd_branch_diff(int argc, const char **argv, const char *prefix)
     - {
     - 	double creation_weight = 0.6;
     -@@
     - 			0, parse_creation_weight },
     - 		OPT_END()
     - 	};
     ++int show_range_diff(const char *range1, const char *range2,
     ++		    int creation_factor)
     ++{
      +	int res = 0;
     -+	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
     ++
      +	struct string_list branch1 = STRING_LIST_INIT_DUP;
      +	struct string_list branch2 = STRING_LIST_INIT_DUP;
     - 
     - 	argc = parse_options(argc, argv, NULL, options,
     - 			builtin_branch_diff_usage, 0);
     - 
     --	return 0;
     -+	if (argc == 2) {
     -+		if (!strstr(argv[0], ".."))
     -+			warning(_("no .. in range: '%s'"), argv[0]);
     -+		strbuf_addstr(&range1, argv[0]);
     -+
     -+		if (!strstr(argv[1], ".."))
     -+			warning(_("no .. in range: '%s'"), argv[1]);
     -+		strbuf_addstr(&range2, argv[1]);
     -+	} else if (argc == 3) {
     -+		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
     -+		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
     -+	} else if (argc == 1) {
     -+		const char *b = strstr(argv[0], "..."), *a = argv[0];
     -+		int a_len;
      +
     -+		if (!b)
     -+			die(_("single arg format requires a symmetric range"));
     -+
     -+		a_len = (int)(b - a);
     -+		if (!a_len) {
     -+			a = "HEAD";
     -+			a_len = strlen(a);
     -+		}
     -+		b += 3;
     -+		if (!*b)
     -+			b = "HEAD";
     -+		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
     -+		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
     -+	} else {
     -+		error(_("need two commit ranges"));
     -+		usage_with_options(builtin_branch_diff_usage, options);
     -+	}
     -+
     -+	if (read_patches(range1.buf, &branch1))
     -+		res = error(_("could not parse log for '%s'"), range1.buf);
     -+	if (!res && read_patches(range2.buf, &branch2))
     -+		res = error(_("could not parse log for '%s'"), range2.buf);
     ++	if (read_patches(range1, &branch1))
     ++		res = error(_("could not parse log for '%s'"), range1);
     ++	if (!res && read_patches(range2, &branch2))
     ++		res = error(_("could not parse log for '%s'"), range2);
      +
      +	if (!res) {
      +		find_exact_matches(&branch1, &branch2);
     -+		res = get_correspondences(&branch1, &branch2, creation_weight);
     -+		if (!res)
     -+			output(&branch1, &branch2);
     ++		get_correspondences(&branch1, &branch2, creation_factor);
     ++		output(&branch1, &branch2);
      +	}
      +
     -+	strbuf_release(&range1);
     -+	strbuf_release(&range2);
      +	string_list_clear(&branch1, 1);
      +	string_list_clear(&branch2, 1);
      +
     -+	return !!res;
     - }
     ++	return res;
     ++}
     +
     +diff --git a/range-diff.h b/range-diff.h
     +new file mode 100644
     +--- /dev/null
     ++++ b/range-diff.h
     +@@
     ++#ifndef BRANCH_DIFF_H
     ++#define BRANCH_DIFF_H
     ++
     ++int show_range_diff(const char *range1, const char *range2,
     ++		    int creation_factor);
     ++
     ++#endif
  4:  3032e2709 !  4:  e98489c8c branch-diff: improve the order of the shown commits
     @@ -1,13 +1,13 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    branch-diff: improve the order of the shown commits
     +    range-diff: improve the order of the shown commits
      
     -    This patch lets branch-diff use the same order as tbdiff.
     +    This patch lets `git range-diff` use the same order as tbdiff.
      
          The idea is simple: for left-to-right readers, it is natural to assume
     -    that the branch-diff is performed between an older vs a newer version of
     -    the branch. As such, the user is probably more interested in the
     -    question "where did this come from?" rather than "where did that one
     +    that the `git range-diff` is performed between an older vs a newer
     +    version of the branch. As such, the user is probably more interested in
     +    the question "where did this come from?" rather than "where did that one
          go?".
      
          To that end, we list the commits in the order of the second commit range
     @@ -16,9 +16,9 @@
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
     ---- a/builtin/branch-diff.c
     -+++ b/builtin/branch-diff.c
     +diff --git a/range-diff.c b/range-diff.c
     +--- a/range-diff.c
     ++++ b/range-diff.c
      @@
       	struct hashmap_entry e;
       	const char *diff, *patch;
  5:  12d9c7977 <  -:  --------- branch-diff: also show the diff between patches
  -:  --------- >  5:  935cad180 range-diff: also show the diff between patches
  6:  53ee6ba38 !  6:  93ac1931d branch-diff: right-trim commit messages
     @@ -1,6 +1,6 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    branch-diff: right-trim commit messages
     +    range-diff: right-trim commit messages
      
          When comparing commit messages, we need to keep in mind that they are
          indented by four spaces. That is, empty lines are no longer empty, but
     @@ -9,13 +9,13 @@
      
          Let's just right-trim the lines in the commit message, it's not like
          trailing white-space in the commit messages are important enough to care
     -    about in branch-diff.
     +    about in `git range-diff`.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
     ---- a/builtin/branch-diff.c
     -+++ b/builtin/branch-diff.c
     +diff --git a/range-diff.c b/range-diff.c
     +--- a/range-diff.c
     ++++ b/range-diff.c
      @@
       				strbuf_addbuf(&buf, &line);
       				strbuf_addstr(&buf, "\n\n");
  7:  c856c460a <  -:  --------- branch-diff: indent the diffs just like tbdiff
  -:  --------- >  7:  ca5282815 range-diff: indent the diffs just like tbdiff
  8:  35a9681a1 !  8:  80622685f branch-diff: suppress the diff headers
     @@ -1,6 +1,6 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    branch-diff: suppress the diff headers
     +    range-diff: suppress the diff headers
      
          When showing the diff between corresponding patches of the two branch
          versions, we have to make up a fake filename to run the diff machinery.
     @@ -10,9 +10,9 @@
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
     ---- a/builtin/branch-diff.c
     -+++ b/builtin/branch-diff.c
     +diff --git a/builtin/range-diff.c b/builtin/range-diff.c
     +--- a/builtin/range-diff.c
     ++++ b/builtin/range-diff.c
      @@
       
       	diff_setup(&diffopt);
  9:  0e4c8279e !  9:  6b31cbf72 branch-diff: adjust the output of the commit pairs
     @@ -1,33 +1,33 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    branch-diff: adjust the output of the commit pairs
     +    range-diff: adjust the output of the commit pairs
      
     -    This change brings branch-diff yet another step closer to feature parity
     -    with tbdiff: it now shows the oneline, too, and indicates with `=` when
     -    the commits have identical diffs.
     +    This change brings `git range-diff` yet another step closer to
     +    feature parity with tbdiff: it now shows the oneline, too, and indicates
     +    with `=` when the commits have identical diffs.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
     ---- a/builtin/branch-diff.c
     -+++ b/builtin/branch-diff.c
     +diff --git a/range-diff.c b/range-diff.c
     +--- a/range-diff.c
     ++++ b/range-diff.c
      @@
     - #include "hungarian.h"
     - #include "diff.h"
     + #include "xdiff-interface.h"
     + #include "linear-assignment.h"
       #include "diffcore.h"
      +#include "commit.h"
      +#include "pretty.h"
       
     - static const char * const builtin_branch_diff_usage[] = {
     - N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
     + struct patch_util {
     + 	/* For the search for an exact match */
      @@
     - 	return res;
     + 	free(b2a);
       }
       
      -static const char *short_oid(struct patch_util *util)
      +static void output_pair_header(struct strbuf *buf,
     -+			       int i, struct patch_util *a_util,
     -+			       int j, struct patch_util *b_util)
     ++			       struct patch_util *a_util,
     ++			       struct patch_util *b_util)
       {
      -	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
      +	static char *dashes;
     @@ -43,25 +43,25 @@
      +	}
      +
      +	strbuf_reset(buf);
     -+	if (i < 0)
     ++	if (!a_util)
      +		strbuf_addf(buf, "-:  %s ", dashes);
      +	else
     -+		strbuf_addf(buf, "%d:  %s ", i + 1,
     ++		strbuf_addf(buf, "%d:  %s ", a_util->i + 1,
      +			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
      +
     -+	if (i < 0)
     ++	if (!a_util)
      +		strbuf_addch(buf, '>');
     -+	else if (j < 0)
     ++	else if (!b_util)
      +		strbuf_addch(buf, '<');
      +	else if (strcmp(a_util->patch, b_util->patch))
      +		strbuf_addch(buf, '!');
      +	else
      +		strbuf_addch(buf, '=');
      +
     -+	if (j < 0)
     ++	if (!b_util)
      +		strbuf_addf(buf, " -:  %s", dashes);
      +	else
     -+		strbuf_addf(buf, " %d:  %s", j + 1,
     ++		strbuf_addf(buf, " %d:  %s", b_util->i + 1,
      +			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
      +
      +	commit = lookup_commit_reference(oid);
     @@ -79,7 +79,7 @@
      +	fwrite(buf->buf, buf->len, 1, stdout);
       }
       
     - static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
     + static struct diff_filespec *get_filespec(const char *name, const char *p)
      @@
       static void output(struct string_list *a, struct string_list *b,
       		   struct diff_options *diffopt)
     @@ -94,7 +94,7 @@
       		if (i < a->nr && a_util->matching < 0) {
      -			printf("%d: %s < -: --------\n",
      -			       i + 1, short_oid(a_util));
     -+			output_pair_header(&buf, i, a_util, -1, NULL);
     ++			output_pair_header(&buf, a_util, NULL);
       			i++;
       			continue;
       		}
     @@ -103,7 +103,7 @@
       		while (j < b->nr && b_util->matching < 0) {
      -			printf("-: -------- > %d: %s\n",
      -			       j + 1, short_oid(b_util));
     -+			output_pair_header(&buf, -1, NULL, j, b_util);
     ++			output_pair_header(&buf, NULL, b_util);
       			b_util = ++j < b->nr ? b->items[j].util : NULL;
       		}
       
     @@ -113,8 +113,7 @@
      -			printf("%d: %s ! %d: %s\n",
      -			       b_util->matching + 1, short_oid(a_util),
      -			       j + 1, short_oid(b_util));
     -+			output_pair_header(&buf,
     -+					   b_util->matching, a_util, j, b_util);
     ++			output_pair_header(&buf, a_util, b_util);
       			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
       				patch_diff(a->items[b_util->matching].string,
       					   b->items[j].string, diffopt);
     @@ -125,4 +124,4 @@
      +	strbuf_release(&buf);
       }
       
     - int cmd_branch_diff(int argc, const char **argv, const char *prefix)
     + int show_range_diff(const char *range1, const char *range2,
 10:  2695a6abc ! 10:  ef997bb8b branch-diff: do not show "function names" in hunk headers
     @@ -1,25 +1,25 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    branch-diff: do not show "function names" in hunk headers
     +    range-diff: do not show "function names" in hunk headers
      
          We are comparing complete, formatted commit messages with patches. There
          are no function names here, so stop looking for them.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
     ---- a/builtin/branch-diff.c
     -+++ b/builtin/branch-diff.c
     +diff --git a/range-diff.c b/range-diff.c
     +--- a/range-diff.c
     ++++ b/range-diff.c
      @@
       #include "diffcore.h"
       #include "commit.h"
       #include "pretty.h"
      +#include "userdiff.h"
       
     - static const char * const builtin_branch_diff_usage[] = {
     - N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
     + struct patch_util {
     + 	/* For the search for an exact match */
      @@
     - 	return data;
     + 	fwrite(buf->buf, buf->len, 1, stdout);
       }
       
      +static struct userdiff_driver no_func_name = {
 11:  313beeed3 ! 11:  3d9e5b0ba branch-diff: add tests
     @@ -1,11 +1,12 @@
      Author: Thomas Rast <tr@thomasrast.ch>
      
     -    branch-diff: add tests
     +    range-diff: add tests
      
          These are essentially lifted from https://github.com/trast/tbdiff, with
     -    light touch-ups to account for the new command name.
     +    light touch-ups to account for the command now being an option of `git
     +    branch`.
      
     -    Apart from renaming `tbdiff` to `branch-diff`, only one test case needed
     +    Apart from renaming `tbdiff` to `range-diff`, only one test case needed
          to be adjusted: 11 - 'changed message'.
      
          The underlying reason it had to be adjusted is that diff generation is
     @@ -28,26 +29,27 @@
       /t8005/*.txt eol=lf
       /t9*/*.dump eol=lf
      
     -diff --git a/t/t7910-branch-diff.sh b/t/t7910-branch-diff.sh
     +diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
      new file mode 100755
      --- /dev/null
     -+++ b/t/t7910-branch-diff.sh
     ++++ b/t/t3206-range-diff.sh
      @@
      +#!/bin/sh
      +
     -+test_description='branch-diff tests'
     ++test_description='range-diff tests'
      +
      +. ./test-lib.sh
      +
     -+# Note that because of git-branch-diff's heuristics, test_commit does more
     ++# Note that because of the range-diff's heuristics, test_commit does more
      +# harm than good.  We need some real history.
      +
      +test_expect_success 'setup' '
     -+	git fast-import < "$TEST_DIRECTORY"/t7910/history.export
     ++	git fast-import < "$TEST_DIRECTORY"/t3206/history.export
      +'
      +
      +test_expect_success 'simple A..B A..C (unmodified)' '
     -+	git branch-diff --no-color master..topic master..unmodified >actual &&
     ++	git range-diff --no-color master..topic master..unmodified \
     ++		>actual &&
      +	cat >expected <<-EOF &&
      +	1:  4de457d = 1:  35b9b25 s/5/A/
      +	2:  fccce22 = 2:  de345ab s/4/A/
     @@ -58,19 +60,19 @@
      +'
      +
      +test_expect_success 'simple B...C (unmodified)' '
     -+	git branch-diff --no-color topic...unmodified >actual &&
     ++	git range-diff --no-color topic...unmodified >actual &&
      +	# same "expected" as above
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'simple A B C (unmodified)' '
     -+	git branch-diff --no-color master topic unmodified >actual &&
     ++	git range-diff --no-color master topic unmodified >actual &&
      +	# same "expected" as above
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'trivial reordering' '
     -+	git branch-diff --no-color master topic reordered >actual &&
     ++	git range-diff --no-color master topic reordered >actual &&
      +	cat >expected <<-EOF &&
      +	1:  4de457d = 1:  aca177a s/5/A/
      +	3:  147e64e = 2:  14ad629 s/11/B/
     @@ -81,7 +83,7 @@
      +'
      +
      +test_expect_success 'removed a commit' '
     -+	git branch-diff --no-color master topic removed >actual &&
     ++	git range-diff --no-color master topic removed >actual &&
      +	cat >expected <<-EOF &&
      +	1:  4de457d = 1:  7657159 s/5/A/
      +	2:  fccce22 < -:  ------- s/4/A/
     @@ -92,7 +94,7 @@
      +'
      +
      +test_expect_success 'added a commit' '
     -+	git branch-diff --no-color master topic added >actual &&
     ++	git range-diff --no-color master topic added >actual &&
      +	cat >expected <<-EOF &&
      +	1:  4de457d = 1:  2716022 s/5/A/
      +	2:  fccce22 = 2:  b62accd s/4/A/
     @@ -104,7 +106,7 @@
      +'
      +
      +test_expect_success 'new base, A B C' '
     -+	git branch-diff --no-color master topic rebased >actual &&
     ++	git range-diff --no-color master topic rebased >actual &&
      +	cat >expected <<-EOF &&
      +	1:  4de457d = 1:  cc9c443 s/5/A/
      +	2:  fccce22 = 2:  c5d9641 s/4/A/
     @@ -116,7 +118,7 @@
      +
      +test_expect_success 'new base, B...C' '
      +	# this syntax includes the commits from master!
     -+	git branch-diff --no-color topic...rebased >actual &&
     ++	git range-diff --no-color topic...rebased >actual &&
      +	cat >expected <<-EOF &&
      +	-:  ------- > 1:  a31b12e unrelated
      +	1:  4de457d = 2:  cc9c443 s/5/A/
     @@ -128,7 +130,7 @@
      +'
      +
      +test_expect_success 'changed commit' '
     -+	git branch-diff --no-color topic...changed >actual &&
     ++	git range-diff --no-color topic...changed >actual &&
      +	cat >expected <<-EOF &&
      +	1:  4de457d = 1:  a4b3333 s/5/A/
      +	2:  fccce22 = 2:  f51d370 s/4/A/
     @@ -157,7 +159,7 @@
      +'
      +
      +test_expect_success 'changed message' '
     -+	git branch-diff --no-color topic...changed-message >actual &&
     ++	git range-diff --no-color topic...changed-message >actual &&
      +	sed s/Z/\ /g >expected <<-EOF &&
      +	1:  4de457d = 1:  f686024 s/5/A/
      +	2:  fccce22 ! 2:  4ab067d s/4/A/
     @@ -178,10 +180,10 @@
      +
      +test_done
      
     -diff --git a/t/t7910/history.export b/t/t7910/history.export
     +diff --git a/t/t3206/history.export b/t/t3206/history.export
      new file mode 100644
      --- /dev/null
     -+++ b/t/t7910/history.export
     ++++ b/t/t3206/history.export
      @@
      +blob
      +mark :1
 12:  ba4791918 ! 12:  7273cc647 branch-diff: use color for the commit pairs
     @@ -1,30 +1,28 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    branch-diff: use color for the commit pairs
     +    range-diff: use color for the commit pairs
      
     -    Arguably the most important part of branch-diff's output is the list of
     -    commits in the two branches, together with their relationships.
     +    Arguably the most important part of `git range-diff`'s output is the
     +    list of commits in the two branches, together with their relationships.
      
          For that reason, tbdiff introduced color-coding that is pretty
          intuitive, especially for unchanged patches (all dim yellow, like the
          first line in `git show`'s output) vs modified patches (old commit is
          red, new commit is green). Let's imitate that color scheme.
      
     -    While at it, also copy tbdiff's change of the fragment color to magenta.
     -
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
     ---- a/builtin/branch-diff.c
     -+++ b/builtin/branch-diff.c
     +diff --git a/range-diff.c b/range-diff.c
     +--- a/range-diff.c
     ++++ b/range-diff.c
      @@
     - 	return res;
     + 	free(b2a);
       }
       
      -static void output_pair_header(struct strbuf *buf,
      +static void output_pair_header(struct diff_options *diffopt, struct strbuf *buf,
     - 			       int i, struct patch_util *a_util,
     - 			       int j, struct patch_util *b_util)
     + 			       struct patch_util *a_util,
     + 			       struct patch_util *b_util)
       {
       	static char *dashes;
       	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
     @@ -42,10 +40,10 @@
       			*p = '-';
       	}
       
     -+	if (j < 0) {
     ++	if (!b_util) {
      +		color = color_old;
      +		status = '<';
     -+	} else if (i < 0) {
     ++	} else if (!a_util) {
      +		color = color_new;
      +		status = '>';
      +	} else if (strcmp(a_util->patch, b_util->patch)) {
     @@ -58,15 +56,15 @@
      +
       	strbuf_reset(buf);
      +	strbuf_addstr(buf, status == '!' ? color_old : color);
     - 	if (i < 0)
     + 	if (!a_util)
       		strbuf_addf(buf, "-:  %s ", dashes);
       	else
     - 		strbuf_addf(buf, "%d:  %s ", i + 1,
     + 		strbuf_addf(buf, "%d:  %s ", a_util->i + 1,
       			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
       
     --	if (i < 0)
     +-	if (!a_util)
      -		strbuf_addch(buf, '>');
     --	else if (j < 0)
     +-	else if (!b_util)
      -		strbuf_addch(buf, '<');
      -	else if (strcmp(a_util->patch, b_util->patch))
      -		strbuf_addch(buf, '!');
     @@ -78,7 +76,7 @@
      +	if (status == '!')
      +		strbuf_addf(buf, "%s%s", color_reset, color_new);
       
     - 	if (j < 0)
     + 	if (!b_util)
       		strbuf_addf(buf, " -:  %s", dashes);
      @@
       		const char *commit_buffer = get_commit_buffer(commit, NULL);
     @@ -101,33 +99,24 @@
       
       		/* Show unmatched LHS commit whose predecessors were shown. */
       		if (i < a->nr && a_util->matching < 0) {
     --			output_pair_header(&buf, i, a_util, -1, NULL);
     -+			output_pair_header(diffopt, &buf, i, a_util, -1, NULL);
     +-			output_pair_header(&buf, a_util, NULL);
     ++			output_pair_header(diffopt, &buf, a_util, NULL);
       			i++;
       			continue;
       		}
       
       		/* Show unmatched RHS commits. */
       		while (j < b->nr && b_util->matching < 0) {
     --			output_pair_header(&buf, -1, NULL, j, b_util);
     -+			output_pair_header(diffopt, &buf, -1, NULL, j, b_util);
     +-			output_pair_header(&buf, NULL, b_util);
     ++			output_pair_header(diffopt, &buf, NULL, b_util);
       			b_util = ++j < b->nr ? b->items[j].util : NULL;
       		}
       
       		/* Show matching LHS/RHS pair. */
       		if (j < b->nr) {
       			a_util = a->items[b_util->matching].util;
     --			output_pair_header(&buf,
     -+			output_pair_header(diffopt, &buf,
     - 					   b_util->matching, a_util, j, b_util);
     +-			output_pair_header(&buf, a_util, b_util);
     ++			output_pair_header(diffopt, &buf, a_util, b_util);
       			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
       				patch_diff(a->items[b_util->matching].string,
     -@@
     - 	struct string_list branch1 = STRING_LIST_INIT_DUP;
     - 	struct string_list branch2 = STRING_LIST_INIT_DUP;
     - 
     -+	git_diff_basic_config("diff.color.frag", "magenta", NULL);
     -+
     - 	diff_setup(&diffopt);
     - 	diffopt.output_format = DIFF_FORMAT_PATCH;
     - 	diffopt.flags.suppress_diff_headers = 1;
     + 					   b->items[j].string, diffopt);
 13:  1ebbe3595 <  -:  --------- color: provide inverted colors, too
  -:  --------- > 13:  96a3073fb color: add the meta color GIT_COLOR_REVERSE
 14:  ae0ea5dfc ! 14:  6be4baf60 diff: add an internal option to dual-color diffs of diffs
     @@ -14,7 +14,8 @@
          now.
      
          This is a feature that was invented by git-tbdiff, and it will be used
     -    in `branch-diff` in the next commit.
     +    by `git range-diff` in the next commit, by offering it via a new option:
     +    `--dual-color`.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -22,26 +23,15 @@
      --- a/diff.c
      +++ b/diff.c
      @@
     - 	GIT_COLOR_BOLD_YELLOW,	/* NEW_MOVED ALTERNATIVE */
     - 	GIT_COLOR_FAINT,	/* NEW_MOVED_DIM */
     - 	GIT_COLOR_FAINT_ITALIC,	/* NEW_MOVED_ALTERNATIVE_DIM */
     -+	GIT_COLOR_INV_RED,	/* OLD_INV */
     -+	GIT_COLOR_INV_GREEN,	/* NEW_INV */
     - };
     - 
     - static NORETURN void die_want_option(const char *option_name)
     -@@
     - 		return DIFF_FILE_NEW_MOVED_DIM;
     - 	if (!strcasecmp(var, "newmovedalternativedimmed"))
     - 		return DIFF_FILE_NEW_MOVED_ALT_DIM;
     -+	if (!strcasecmp(var, "oldinv"))
     -+		return DIFF_FILE_OLD_INV;
     -+	if (!strcasecmp(var, "newinv"))
     -+		return DIFF_FILE_NEW_INV;
     - 	return -1;
     + 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
       }
       
     -@@
     +-static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
     ++static void emit_line_0(struct diff_options *o,
     ++			const char *set, unsigned reverse, const char *reset,
     + 			int first, const char *line, int len)
     + {
     + 	int has_trailing_newline, has_trailing_carriage_return;
       	int nofirst;
       	FILE *file = o->file;
       
     @@ -54,8 +44,11 @@
       	if (len == 0) {
       		has_trailing_newline = (first == '\n');
      @@
     + 	}
       
       	if (len || !nofirst) {
     ++		if (reverse && want_color(o->use_color))
     ++			fputs(GIT_COLOR_REVERSE, file);
       		fputs(set, file);
      -		if (!nofirst)
      +		if (first && !nofirst)
     @@ -63,6 +56,15 @@
       		fwrite(line, len, 1, file);
       		fputs(reset, file);
      @@
     + static void emit_line(struct diff_options *o, const char *set, const char *reset,
     + 		      const char *line, int len)
     + {
     +-	emit_line_0(o, set, reset, line[0], line+1, len-1);
     ++	emit_line_0(o, set, 0, reset, line[0], line+1, len-1);
     + }
     + 
     + enum diff_symbol {
     +@@
       
       static void emit_line_ws_markup(struct diff_options *o,
       				const char *set, const char *reset,
     @@ -77,20 +79,24 @@
       	}
       
      -	if (!ws)
     -+	if (!ws && set_sign == set)
     - 		emit_line_0(o, set, reset, sign, line, len);
     +-		emit_line_0(o, set, reset, sign, line, len);
      -	else if (blank_at_eof)
     ++	if (!ws && !set_sign)
     ++		emit_line_0(o, set, 0, reset, sign, line, len);
      +	else if (!ws) {
      +		/* Emit just the prefix, then the rest. */
     -+		emit_line_0(o, set_sign, reset, sign, "", 0);
     -+		emit_line_0(o, set, reset, 0, line, len);
     ++		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
     ++			    sign, "", 0);
     ++		emit_line_0(o, set, 0, reset, 0, line, len);
      +	} else if (blank_at_eof)
       		/* Blank line at EOF - paint '+' as well */
     - 		emit_line_0(o, ws, reset, sign, line, len);
     +-		emit_line_0(o, ws, reset, sign, line, len);
     ++		emit_line_0(o, ws, 0, reset, sign, line, len);
       	else {
       		/* Emit just the prefix, then the rest. */
      -		emit_line_0(o, set, reset, sign, "", 0);
     -+		emit_line_0(o, set_sign, reset, sign, "", 0);
     ++		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
     ++			    sign, "", 0);
       		ws_check_emit(line, len, ws_rule,
       			      o->file, set, reset, ws);
       	}
     @@ -103,17 +109,28 @@
       	struct strbuf sb = STRBUF_INIT;
       
       	enum diff_symbol s = eds->s;
     +@@
     + 		context = diff_get_color_opt(o, DIFF_CONTEXT);
     + 		reset = diff_get_color_opt(o, DIFF_RESET);
     + 		putc('\n', o->file);
     +-		emit_line_0(o, context, reset, '\\',
     ++		emit_line_0(o, context, 0, reset, '\\',
     + 			    nneof, strlen(nneof));
     + 		break;
     + 	case DIFF_SYMBOL_SUBMODULE_HEADER:
      @@
       	case DIFF_SYMBOL_CONTEXT:
       		set = diff_get_color_opt(o, DIFF_CONTEXT);
       		reset = diff_get_color_opt(o, DIFF_RESET);
      -		emit_line_ws_markup(o, set, reset, line, len, ' ',
     -+		set_sign = set;
     ++		set_sign = NULL;
      +		if (o->flags.dual_color_diffed_diffs) {
      +			char c = !len ? 0 : line[0];
      +
      +			if (c == '+')
      +				set = diff_get_color_opt(o, DIFF_FILE_NEW);
     ++			else if (c == '@')
     ++				set = diff_get_color_opt(o, DIFF_FRAGINFO);
      +			else if (c == '-')
      +				set = diff_get_color_opt(o, DIFF_FILE_OLD);
      +		}
     @@ -127,13 +144,15 @@
       		reset = diff_get_color_opt(o, DIFF_RESET);
      -		emit_line_ws_markup(o, set, reset, line, len, '+',
      +		if (!o->flags.dual_color_diffed_diffs)
     -+			set_sign = set;
     ++			set_sign = NULL;
      +		else {
      +			char c = !len ? 0 : line[0];
      +
     -+			set_sign = diff_get_color_opt(o, DIFF_FILE_NEW_INV);
     ++			set_sign = set;
      +			if (c == '-')
      +				set = diff_get_color_opt(o, DIFF_FILE_OLD);
     ++			else if (c == '@')
     ++				set = diff_get_color_opt(o, DIFF_FRAGINFO);
      +			else if (c != '+')
      +				set = diff_get_color_opt(o, DIFF_CONTEXT);
      +		}
     @@ -147,13 +166,15 @@
       		reset = diff_get_color_opt(o, DIFF_RESET);
      -		emit_line_ws_markup(o, set, reset, line, len, '-',
      +		if (!o->flags.dual_color_diffed_diffs)
     -+			set_sign = set;
     ++			set_sign = NULL;
      +		else {
      +			char c = !len ? 0 : line[0];
      +
     -+			set_sign = diff_get_color_opt(o, DIFF_FILE_OLD_INV);
     ++			set_sign = set;
      +			if (c == '+')
      +				set = diff_get_color_opt(o, DIFF_FILE_NEW);
     ++			else if (c == '@')
     ++				set = diff_get_color_opt(o, DIFF_FRAGINFO);
      +			else if (c != '-')
      +				set = diff_get_color_opt(o, DIFF_CONTEXT);
      +		}
     @@ -161,6 +182,23 @@
       				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
       		break;
       	case DIFF_SYMBOL_WORDS_PORCELAIN:
     +@@
     + 	const char *frag = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
     + 	const char *func = diff_get_color(ecbdata->color_diff, DIFF_FUNCINFO);
     + 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
     ++	const char *reverse = ecbdata->color_diff ? GIT_COLOR_REVERSE : "";
     + 	static const char atat[2] = { '@', '@' };
     + 	const char *cp, *ep;
     + 	struct strbuf msgbuf = STRBUF_INIT;
     +@@
     + 	ep += 2; /* skip over @@ */
     + 
     + 	/* The hunk header in fraginfo color */
     ++	if (ecbdata->opt->flags.dual_color_diffed_diffs)
     ++		strbuf_addstr(&msgbuf, reverse);
     + 	strbuf_addstr(&msgbuf, frag);
     + 	strbuf_add(&msgbuf, line, ep - line);
     + 	strbuf_addstr(&msgbuf, reset);
      
      diff --git a/diff.h b/diff.h
      --- a/diff.h
     @@ -173,14 +211,3 @@
       };
       
       static inline void diff_flags_or(struct diff_flags *a,
     -@@
     - 	DIFF_FILE_NEW_MOVED = 13,
     - 	DIFF_FILE_NEW_MOVED_ALT = 14,
     - 	DIFF_FILE_NEW_MOVED_DIM = 15,
     --	DIFF_FILE_NEW_MOVED_ALT_DIM = 16
     -+	DIFF_FILE_NEW_MOVED_ALT_DIM = 16,
     -+	DIFF_FILE_OLD_INV = 17,
     -+	DIFF_FILE_NEW_INV = 18
     - };
     - const char *diff_get_color(int diff_use_color, enum color_diff ix);
     - #define diff_get_color_opt(o, ix) \
 15:  b9be01705 ! 15:  02e13c0c6 branch-diff: offer to dual-color the diffs
     @@ -1,6 +1,6 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    branch-diff: offer to dual-color the diffs
     +    range-diff: offer to dual-color the diffs
      
          When showing what changed between old and new commits, we show a diff of
          the patches. This diff is a diff between diffs, therefore there are
     @@ -13,21 +13,22 @@
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
     ---- a/builtin/branch-diff.c
     -+++ b/builtin/branch-diff.c
     +diff --git a/builtin/range-diff.c b/builtin/range-diff.c
     +--- a/builtin/range-diff.c
     ++++ b/builtin/range-diff.c
      @@
       {
     + 	int creation_factor = 60;
       	struct diff_options diffopt = { NULL };
     - 	struct strbuf four_spaces = STRBUF_INIT;
      +	int dual_color = 0;
     - 	double creation_weight = 0.6;
       	struct option options[] = {
     + 		OPT_INTEGER(0, "creation-factor", &creation_factor,
     + 			    N_("Percentage by which creation is weighted")),
      +		OPT_BOOL(0, "dual-color", &dual_color,
      +			    N_("color both diff and diff-between-diffs")),
     - 		OPT_SET_INT(0, "no-patches", &diffopt.output_format,
     - 			    N_("short format (no diffs)"),
     - 			    DIFF_FORMAT_NO_OUTPUT),
     + 		OPT_END()
     + 	};
     + 	int i, j, res = 0;
      @@
       	argc = j;
       	diff_setup_done(&diffopt);
 16:  b99ab186c ! 16:  dfa7b1e71 branch-diff --dual-color: work around bogus white-space warning
     @@ -1,6 +1,6 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    branch-diff --dual-color: work around bogus white-space warning
     +    range-diff --dual-color: work around bogus white-space warning
      
          When displaying a diff of diffs, it is possible that there is an outer
          `+` before a context line. That happens when the context changed between
     @@ -20,8 +20,9 @@
          However, the proper fix would be relatively ugly and intrusive because
          it would have to *weaken* the WS_SPACE_BEFORE_TAB option in ws.c.
          Besides, we do not expose the --dual-color option in cases other than
     -    the `branch-diff` command, which only uses a hard-coded output_prefix of
     -    four spaces (which misses the problem by one column ;-)).
     +    the `git range-diff` command, which only uses a hard-coded
     +    output_prefix of four spaces (which misses the problem by one
     +    column... ;-)).
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -29,7 +30,7 @@
      --- a/diff.c
      +++ b/diff.c
      @@
     - 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
     + 				set = diff_get_color_opt(o, DIFF_FRAGINFO);
       			else if (c != '+')
       				set = diff_get_color_opt(o, DIFF_CONTEXT);
      +			/* Avoid space-before-tab warning */
 17:  950c75377 ! 17:  799da25ef branch-diff: add a man page
     @@ -1,29 +1,30 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    branch-diff: add a man page
     +    range-diff: add a man page
      
     -    This is a heavily butchered version of the README written by Thomas
     -    Rast and Thomas Gummerer, lifted from https://github.com/trast/tbdiff.
     +    The bulk of this patch consists of a heavily butchered version of
     +    tbdiff's README written by Thomas Rast and Thomas Gummerer, lifted from
     +    https://github.com/trast/tbdiff.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -diff --git a/Documentation/git-branch-diff.txt b/Documentation/git-branch-diff.txt
     +diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
      new file mode 100644
      --- /dev/null
     -+++ b/Documentation/git-branch-diff.txt
     ++++ b/Documentation/git-range-diff.txt
      @@
     -+git-branch-diff(1)
     ++git-range-diff(1)
      +==================
      +
      +NAME
      +----
     -+git-branch-diff - Compare two versions of a branch
     ++git-range-diff - Compare two commit ranges (e.g. two versions of a branch)
      +
      +SYNOPSIS
      +--------
      +[verse]
     -+'git branch-diff' [--color=[<when>]] [--no-color] [<diff-options>]
     -+	[--dual-color] [--no-patches] [--creation-weight=<weight>]
     ++'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
     ++	[--dual-color] [--creation-factor=<factor>]
      +	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
      +
      +DESCRIPTION
     @@ -45,23 +46,19 @@
      +
      +OPTIONS
      +-------
     -+--no-patches::
     -+	Suppress the diffs between commit pairs that were deemed to
     -+	correspond; only show the pairings.
     -+
      +--dual-color::
      +	When the commit diffs differ, recreate the original diffs'
      +	coloring, and add outer -/+ diff markers with the *background*
      +	being red/green to make it easier to see e.g. when there was a
      +	change in what exact lines were added.
      +
     -+--creation-weight=<factor>::
     -+	Set the creation/deletion cost fudge factor to `<factor>`.
     -+	Defaults to 0.6. Try a larger value if `git branch-diff`
     -+	erroneously considers a large change a total rewrite (deletion
     -+	of one commit and addition of another), and a smaller one in
     -+	the reverse case. See the ``Algorithm`` section below for an
     -+	explanation why this is needed.
     ++--creation-factor=<percent>::
     ++	Set the creation/deletion cost fudge factor to `<percent>`.
     ++	Defaults to 60. Try a larger value if `git range-diff` erroneously
     ++	considers a large change a total rewrite (deletion of one commit
     ++	and addition of another), and a smaller one in the reverse case.
     ++	See the ``Algorithm`` section below for an explanation why this is
     ++	needed.
      +
      +<range1> <range2>::
      +	Compare the commits specified by the two ranges, where
     @@ -74,10 +71,10 @@
      +	Equivalent to passing `<base>..<rev1>` and `<base>..<rev2>`.
      +	Note that `<base>` does not need to be the exact branch point
      +	of the branches. Example: after rebasing a branch `my-topic`,
     -+	`git branch-diff my-topic@{u} my-topic@{1} my-topic` would
     ++	`git range-diff my-topic@{u} my-topic@{1} my-topic` would
      +	show the differences introduced by the rebase.
      +
     -+`git branch-diff` also accepts the regular diff options (see
     ++`git range-diff` also accepts the regular diff options (see
      +linkgit:git-diff[1]), most notably the `--color=[<when>]` and
      +`--no-color` options. These options are used when generating the "diff
      +between patches", i.e. to compare the author, commit message and diff of
     @@ -87,23 +84,23 @@
      +
      +CONFIGURATION
      +-------------
     -+This command uses the `diff.color.*` and `pager.branch-diff` settings
     ++This command uses the `diff.color.*` and `pager.range-diff` settings
      +(the latter is on by default).
      +See linkgit:git-config[1].
      +
      +
     -+Examples
     ++EXAMPLES
      +--------
      +
      +When a rebase required merge conflicts to be resolved, compare the changes
      +introduced by the rebase directly afterwards using:
      +
      +------------
     -+$ git branch-diff @{u} @{1} @
     ++$ git range-diff @{u} @{1} @
      +------------
      +
      +
     -+A typical output of `git branch-diff` would look like this:
     ++A typical output of `git range-diff` would look like this:
      +
      +------------
      +-:  ------- > 1:  0ddba11 Prepare for the inevitable!
     @@ -216,11 +213,11 @@
      +------------
      +
      +The cost of an edge `o--C` is the size of `C`'s diff, modified by a
     -+fudge factor that should be smaller than 1.0. The cost of an edge `o--o`
     -+is free. The fudge factor is necessary because even if `1` and `C` have
     -+nothing in common, they may still share a few empty lines and such,
     -+possibly making the assignment `1--C`, `o--o` slightly cheaper than
     -+`1--o`, `o--C` even if `1` and `C` have nothing in common. With the
     ++fudge factor that should be smaller than 100%. The cost of an edge
     ++`o--o` is free. The fudge factor is necessary because even if `1` and
     ++`C` have nothing in common, they may still share a few empty lines and
     ++such, possibly making the assignment `1--C`, `o--o` slightly cheaper
     ++than `1--o`, `o--C` even if `1` and `C` have nothing in common. With the
      +fudge factor we require a much larger common part to consider patches as
      +corresponding.
      +
 18:  71698f118 <  -:  --------- completion: support branch-diff
  -:  --------- > 18:  d05b54c60 completion: support `git range-diff`
  -:  --------- > 19:  144363006 range-diff: left-pad patch numbers
  -:  --------- > 20:  4a68b95ce range-diff: make --dual-color the default mode

-- 
gitgitgadget
