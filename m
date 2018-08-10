Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C7D1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeHKAqN (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:13 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44656 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeHKAqN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:13 -0400
Received: by mail-pl0-f65.google.com with SMTP id ba4-v6so4566460plb.11
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5Qww44MtTr030IPaFzxckApzZ04mBzTmgOYgahueAQE=;
        b=hN+PemvOdcymLg+RYPDXBOxtVKapXUWGkqg6mRAZG7OWTwdzXeA3L4funnglhnC7Wk
         tw99e2TY2xoe1cVKcbBbPX1q1c+LS3uNj1b5+meyGQYAJl4cmF+M1yG3jtStYAJC7EuO
         2CSmvw4wtq1pOvUuDkDNFSNF/P5XQME4VOjxZ5EsY/Ims99d+YlohoMCSZSu70c4l5zw
         CJpLBeTtUjkhDNvLgE90vKou68pbWdXanIE5MVyBaZzSM0GGWGi5C1Oxildlw+gtvwm3
         PH9iABoT2jWQ226P8yj/AWhDgoWo3IplElmc1nQr/bxXe6II1GmI175EdXvivCUUIQbf
         Zvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5Qww44MtTr030IPaFzxckApzZ04mBzTmgOYgahueAQE=;
        b=umBYOINIiU9YZcwXq2vA/x1BRldKBi7Yw6DD3ZahrXXl9Stt6nCXg2H65MawLntGyX
         SkvFHzA/6kvaYlFTe3OYa1rfimbQEX2aiU9GDDecuzKClaj+TNaz78n7EJJDBk6oBNsX
         gWQvAaJgOfJ0oJ8M9K5T6cG1oWfYNmlh8efYxfod21f+AKRJH8dol1A6VYTVQJ8ofp0H
         oTzS/QfWM1F9BvPQq8iF05d5LK8rq4LiQyFDDFqBwTlSDIAMHNk2r/N2iFFp2ityuuk0
         s0Tvu5cUJDastuihoK4fat84XpHQFgYgTmHeo4u9+wbugda5bZmxideSeN8H7M5mmuX8
         6Jdw==
X-Gm-Message-State: AOUpUlHT2pKDk7X2hPLKO9YQzF7v3bq6XUeS4mF24bdvNKM10Dw5XMHJ
        4i4qydla7uF2MmM7dHiq3yg4yB0T
X-Google-Smtp-Source: AA+uWPyZYS2OrfyAtpABdhssj0PzJgJCFtB/jl5Ipk0NpOVR3PX746SR0izYutLUmT2LdS4ak2ZbQw==
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr7611187plf.320.1533939266447;
        Fri, 10 Aug 2018 15:14:26 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id d34-v6sm12523695pgb.29.2018.08.10.15.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:25 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:25 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:02 GMT
Message-Id: <pull.1.v5.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 00/21] Add range-diff, a tbdiff lookalike
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

The incredibly useful git-tbdiff [https://github.com/trast/tbdiff] tool to
compare patch series (say, to see what changed between two iterations sent
to the Git mailing list) is slightly less useful for this developer due to
the fact that it requires the hungarian and numpy Python packages which are
for some reason really hard to build in MSYS2. So hard that I even had to
give up, because it was simply easier to re-implement the whole shebang as a
builtin command.

The project at https://github.com/trast/tbdiff seems to be dormant, anyway.
Funny (and true) story: I looked at the open Pull Requests to see how active
that project is, only to find to my surprise that I had submitted one in
August 2015, and that it was still unanswered let alone merged.

While at it, I forward-ported AEvar's patch to force --decorate=no because 
git -p tbdiff would fail otherwise.

Side note: I work on implementing range-diff not only to make life easier
for reviewers who have to suffer through v2, v3, ... of my patch series, but
also to verify my changes before submitting a new iteration. And also, maybe
even more importantly, I plan to use it to verify my merging-rebases of Git
for Windows (for which I previously used to redirect the
pre-rebase/post-rebase diffs vs upstream and then compare them using git
diff --no-index). And of course any interested person can see what changes
were necessary e.g. in the merging-rebase of Git for Windows onto v2.17.0 by
running a command like:

        base=^{/Start.the.merging-rebase}
        tag=v2.17.0.windows.1
        pre=$tag$base^2
        git range-diff $pre$base..$pre $tag$base..$tag

The command uses what it calls the "dual color mode" (can be disabled via 
--no-dual-color) which helps identifying what actually changed: it prefixes
lines with a - (and red background) that correspond to the first commit
range, and with a + (and green background) that correspond to the second
range. The rest of the lines will be colored according to the original
diffs.

Changes since v4:

 * Fixed a typo in the commit message of "range-diff: add tests" that was
   introduced in v4.
 * White-space fixes.
 * Fixed the length of the first header underline in the man page.
 * Changed the preprocessor guard in linear-assignment.h to reflect the new
   name (instead of the old name, which was hungarian.h).
 * Likewise, changed the preprocessor guards in range-diff.h to hide the
   history of the thrice-renamed command.
 * Fixed indentation in the completion.
 * Instead of trying to paper over white-space error handling that does not
   apply to "diffs of diffs", dual color mode now simply disables all
   white-space warnings.
 * When showing the "single arg must be symmetric range" error message, git
   range-diff now also shows the usage.
 * Adjusted the commit message of "range-diff: adjust the output of the
   commit pairs" to avoid the surprise of the reviewer when onelines are
   printed all of a sudden, too.
 * "range-diff: adjust the output of the commit pairs" is now using a
   simpler way to print onelines.
 * We are now sandwiching the diff_opt_parse() loop between two 
   parse_options(), to make sure that we caught all options, and that the -- 
   separator is handled.
 * Adjusted the lookup_commit_reference() call to the newest master (it now
   takes a the_repository parameter).

Changes since v3:

 * The cover letter was adjusted to reflect the new reality (the command is
   called range-diff now, not branch-diff, and --dual-color is the default).
 * The documentation was adjusted a bit more in the patch that makes 
   --dual-color the default.
 * Clarified the calculation of the cost matrix, as per Stefan Beller's
   request.
 * The man page now spells out that merge commits are ignored in the commit
   ranges (not merges per se).
 * The code in linear-assignment.c was adjusted to use the SWAP() macro.
 * The commit message of the patch introducing the first rudimentary
   implementation no longer talks about the "Hungarian" algorithm, but about
   the "linear assignment algorithm" instead.
 * A bogus indentation change was backed out from the patch introducing the
   first rudimentary implementation.
 * Instead of merely warning about missing .. in the 2-parameter invocation,
   we now exit with the error message.
 * The diff_opt_parse() function is allowed to return a value larger than 1,
   indicating that more than just one command-line parameter was parsed. We
   now advance by the indicated value instead of always advancing exactly 1
   (which is still correct much of the time).
 * A lengthy if...else if...else if...else was simplified (from a logical
   point of view) by reordering it.
 * The unnecessarily static variable dashes was turned into a local variable
   of the caller.
 * The commit message talking about the new man page still referred to git
   branch --diff, which has been fixed.
 * A forgotten t7910 reference was changed to t3206.
 * An unbalanced double-tick was fixed in the man page.
 * Fixed grammar both of the commit message and the description of the 
   --no-dual-color option.
 * To fix the build, a blank man page is now introduced together with the
   new range-diff command, even if it is populated for real only at a later
   patch (i.e. at the same time as before).
 * The headaches Junio fears would be incurred by that simple workaround to
   avoid bogus white-space error reporting are fended off: a more complex
   patch is now in place that adds (and uses) a new white-space flag. Sadly,
   as is all too common when Junio "encourages" me to replace a simple
   workaround by something "proper", it caused all kinds of headaches to get
   this right, so I am rather less certain that the "proper" fix will cause
   us less headaches than the simple workaround would have done. But
   whatever.
 * The dual color mode now also dims the changes that are exclusively in the
   first specified commit range, and uses bold face on the changes
   exclusively in the second one. This matches the intuition when using 
   range-diff to compare an older iteration of a patch series to a newer
   one: the changes from the previous iteration that were replaced by new
   ones "fade", while the changes that replace them are "shiny new".

Changes since v2:

 * Right-aligned the patch numbers in the commit pairs.
 * Used ALLOC_ARRAY() in hungarian.c instead of xmalloc(sizeof()*size).
 * Changed compute_assignment()s return type from int to void, as it always
   succeeds.
 * Changed the Hungarian Algorithm to use an integer cost matrix.
 * Changed the --creation-weight option to --creation-factor where is an
   integer.
 * Retitled 1/19 and 2/19 to better conform with the current conventions, as
   pointed out (and suggested) by Junio.
 * Shut up Coverity, and at the same time avoided passing the unnecessary i 
   and j parameters to output_pair_header().
 * Removed support for the --no-patches option: we inherit diff_options'
   support for -s already (and much more).
 * Removed the ugly _INV enum values, and introduced a beautiful
   GIT_COLOR_REVERSE instead. This way, whatever the user configured as
   color.diff.new (or .old) will be used in reverse in the dual color mode.
 * Instead of overriding the fragment header color, the dual color mode will
   now reverse the "outer" fragment headers, too.
 * Turned the stand-alone branch-diff command into the --diff option of git
   branch. Adjusted pretty much all commit messages to account for this.
   This change should no longer be visible: see below.
 * Pretty much re-wrote the completion, to support the new --diff mode of
   git-branch. See below: it was reverted for range-diff.
 * Renamed t7910 to t3206, to be closer to the git-branch tests.
 * Ensured that git_diff_ui_config() gets called, and therefore color.diff.*
   respected.
 * Avoided leaking four_spaces.
 * Fixed a declaration in a for (;;) statement (which Junio had as a fixup!
   that I almost missed).
 * Renamed branch --diff, which had been renamed from branch-diff (which was
   picked to avoid re-using tbdiff) to range-diff.
 * Renamed hungarian.c and its header to linear-assignment.c
 * Made --dual-color the default, and changed it to still auto-detect
   whether color should be used rather than forcing it

Johannes Schindelin (20):
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
  range-diff --dual-color: skip white-space warnings
  range-diff: populate the man page
  completion: support `git range-diff`
  range-diff: left-pad patch numbers
  range-diff: make --dual-color the default mode
  range-diff: use dim/bold cues to improve dual color mode

Thomas Rast (1):
  range-diff: add tests

 .gitignore                             |   1 +
 Documentation/config.txt               |   6 +-
 Documentation/git-range-diff.txt       | 252 +++++++++++
 Makefile                               |   3 +
 builtin.h                              |   1 +
 builtin/range-diff.c                   | 114 +++++
 color.h                                |   7 +
 command-list.txt                       |   1 +
 contrib/completion/git-completion.bash |  14 +
 diff.c                                 | 105 ++++-
 diff.h                                 |  10 +-
 git.c                                  |   1 +
 linear-assignment.c                    | 201 ++++++++
 linear-assignment.h                    |  22 +
 range-diff.c                           | 435 ++++++++++++++++++
 range-diff.h                           |   9 +
 t/.gitattributes                       |   1 +
 t/t3206-range-diff.sh                  | 145 ++++++
 t/t3206/history.export                 | 604 +++++++++++++++++++++++++
 19 files changed, 1913 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/git-range-diff.txt
 create mode 100644 builtin/range-diff.c
 create mode 100644 linear-assignment.c
 create mode 100644 linear-assignment.h
 create mode 100644 range-diff.c
 create mode 100644 range-diff.h
 create mode 100755 t/t3206-range-diff.sh
 create mode 100644 t/t3206/history.export


base-commit: 1d89318c48d233d52f1db230cf622935ac3c69fa
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-1%2Fdscho%2Fbranch-diff-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1/dscho/branch-diff-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1

Range-diff vs v4:

  1:  f7e70689e !  1:  f168da3a3 linear-assignment: a function to solve least-cost assignment problems
     @@ -239,8 +239,8 @@
      --- /dev/null
      +++ b/linear-assignment.h
      @@
     -+#ifndef HUNGARIAN_H
     -+#define HUNGARIAN_H
     ++#ifndef LINEAR_ASSIGNMENT_H
     ++#define LINEAR_ASSIGNMENT_H
      +
      +/*
      + * Compute an assignment of columns -> rows (and vice versa) such that every
  2:  88134121d !  2:  33758f361 Introduce `range-diff` to compare iterations of a topic branch
     @@ -34,7 +34,7 @@
      +++ b/Documentation/git-range-diff.txt
      @@
      +git-range-diff(1)
     -+==================
     ++=================
      +
      +NAME
      +----
  3:  4e3fb47a1 !  3:  08b8c3fc4 range-diff: first rudimentary implementation
     @@ -70,8 +70,10 @@
      +		const char *b = strstr(argv[0], "..."), *a = argv[0];
      +		int a_len;
      +
     -+		if (!b)
     -+			die(_("single arg format requires a symmetric range"));
     ++		if (!b) {
     ++			error(_("single arg format must be symmetric range"));
     ++			usage_with_options(builtin_range_diff_usage, options);
     ++		}
      +
      +		a_len = (int)(b - a);
      +		if (!a_len) {
     @@ -418,8 +420,8 @@
      --- /dev/null
      +++ b/range-diff.h
      @@
     -+#ifndef BRANCH_DIFF_H
     -+#define BRANCH_DIFF_H
     ++#ifndef RANGE_DIFF_H
     ++#define RANGE_DIFF_H
      +
      +int show_range_diff(const char *range1, const char *range2,
      +		    int creation_factor);
  4:  47bee09b0 =  4:  7b9091968 range-diff: improve the order of the shown commits
  5:  94afaeaf2 !  5:  9e1e66007 range-diff: also show the diff between patches
     @@ -10,7 +10,7 @@
          diff which is the result of first reverting the old diff and then
          applying the new diff.
      
     -    Especially when rebasing often, an interdiff is often not feasible,
     +    Especially when rebasing frequently, an interdiff is often not feasible,
          though: if the old diff cannot be applied in reverse (due to a moving
          upstream), an interdiff can simply not be inferred.
      
     @@ -25,9 +25,17 @@
          This is left for a later commit.
      
          Note also: while tbdiff accepts the `--no-patches` option to suppress
     -    these diffs between patches, we prefer the `-s` option that is
     -    automatically supported via our use of diff_opt_parse().
     +    these diffs between patches, we prefer the `-s` (or `--no-patch`) option
     +    that is automatically supported via our use of diff_opt_parse().
      
     +    And finally note: to support diff options, we have to call
     +    `parse_options()` such that it keeps unknown options, and then loop over
     +    those and let `diff_opt_parse()` handle them. After that loop, we have
     +    to call `parse_options()` again, to make sure that no unknown options
     +    are left.
     +
     +    Helped-by: Thomas Gummerer <t.gummerer@gmail.com>
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/builtin/range-diff.c b/builtin/range-diff.c
     @@ -61,10 +69,10 @@
      +	diffopt.output_format = DIFF_FORMAT_PATCH;
      +
       	argc = parse_options(argc, argv, NULL, options,
     --			     builtin_range_diff_usage, 0);
     -+			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
     ++			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN |
     ++			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
      +
     -+	for (i = j = 0; i < argc; ) {
     ++	for (i = j = 1; i < argc && strcmp("--", argv[i]); ) {
      +		int c = diff_opt_parse(&diffopt, argv + i, argc - i, prefix);
      +
      +		if (!c)
     @@ -74,9 +82,13 @@
      +	}
      +	argc = j;
      +	diff_setup_done(&diffopt);
     ++
     ++	/* Make sure that there are no unparsed options */
     ++	argc = parse_options(argc, argv, NULL,
     ++			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
     + 			     builtin_range_diff_usage, 0);
       
       	if (argc == 2) {
     - 		if (!strstr(argv[0], ".."))
      @@
       		usage_with_options(builtin_range_diff_usage, options);
       	}
     @@ -165,8 +177,8 @@
      --- a/range-diff.h
      +++ b/range-diff.h
      @@
     - #ifndef BRANCH_DIFF_H
     - #define BRANCH_DIFF_H
     + #ifndef RANGE_DIFF_H
     + #define RANGE_DIFF_H
       
      +#include "diff.h"
      +
  6:  41ab875a3 =  6:  167ca02a3 range-diff: right-trim commit messages
  7:  a3dd99509 !  7:  ca8de8c75 range-diff: indent the diffs just like tbdiff
     @@ -39,7 +39,7 @@
      +	diffopt.output_prefix_data = &four_spaces;
       
       	argc = parse_options(argc, argv, NULL, options,
     - 			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
     + 			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN |
      @@
       
       	strbuf_release(&range1);
  8:  61b2ff2f7 =  8:  eb94d1982 range-diff: suppress the diff headers
  9:  9641ab5c0 !  9:  6330afad9 range-diff: adjust the output of the commit pairs
     @@ -2,6 +2,10 @@
      
          range-diff: adjust the output of the commit pairs
      
     +    This not only uses "dashed stand-ins" for "pairs" where one side is
     +    missing (i.e. unmatched commits that are present only in one of the two
     +    commit ranges), but also adds onelines for the reader's pleasure.
     +
          This change brings `git range-diff` yet another step closer to
          feature parity with tbdiff: it now shows the oneline, too, and indicates
          with `=` when the commits have identical diffs.
     @@ -61,15 +65,10 @@
      +		strbuf_addf(buf, " %d:  %s", b_util->i + 1,
      +			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
      +
     -+	commit = lookup_commit_reference(oid);
     ++	commit = lookup_commit_reference(the_repository, oid);
      +	if (commit) {
     -+		const char *commit_buffer = get_commit_buffer(commit, NULL);
     -+		const char *subject;
     -+
     -+		find_commit_subject(commit_buffer, &subject);
      +		strbuf_addch(buf, ' ');
     -+		format_subject(buf, subject, " ");
     -+		unuse_commit_buffer(commit, commit_buffer);
     ++		pp_commit_easy(CMIT_FMT_ONELINE, commit, buf);
      +	}
      +	strbuf_addch(buf, '\n');
      +
 10:  0a52f8878 = 10:  c296675eb range-diff: do not show "function names" in hunk headers
 11:  2b8d09020 ! 11:  85e0ab82f range-diff: add tests
     @@ -3,7 +3,7 @@
          range-diff: add tests
      
          These are essentially lifted from https://github.com/trast/tbdiff, with
     -    light touch-ups to account for the command now being names `git
     +    light touch-ups to account for the command now being named `git
          range-diff`.
      
          Apart from renaming `tbdiff` to `range-diff`, only one test case needed
 12:  fb83ce71a ! 12:  f48b62644 range-diff: use color for the commit pairs
     @@ -79,16 +79,14 @@
       	if (!b_util)
       		strbuf_addf(buf, " -:  %s", dashes->buf);
      @@
     - 		const char *commit_buffer = get_commit_buffer(commit, NULL);
     - 		const char *subject;
       
     + 	commit = lookup_commit_reference(the_repository, oid);
     + 	if (commit) {
      +		if (status == '!')
      +			strbuf_addf(buf, "%s%s", color_reset, color);
      +
     - 		find_commit_subject(commit_buffer, &subject);
       		strbuf_addch(buf, ' ');
     - 		format_subject(buf, subject, " ");
     - 		unuse_commit_buffer(commit, commit_buffer);
     + 		pp_commit_easy(CMIT_FMT_ONELINE, commit, buf);
       	}
      -	strbuf_addch(buf, '\n');
      +	strbuf_addf(buf, "%s\n", color_reset);
 13:  9ccb9516a = 13:  1ad74f939 color: add the meta color GIT_COLOR_REVERSE
 14:  9de5bd229 = 14:  39a0ecd28 diff: add an internal option to dual-color diffs of diffs
 15:  21b2f9e4b ! 15:  c32a24f6a range-diff: offer to dual-color the diffs
     @@ -30,8 +30,8 @@
       	};
       	int i, j, res = 0;
      @@
     - 	argc = j;
     - 	diff_setup_done(&diffopt);
     + 			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
     + 			     builtin_range_diff_usage, 0);
       
      +	if (dual_color) {
      +		diffopt.use_color = 1;
 16:  f4252f2b2 <  -:  --------- range-diff --dual-color: fix bogus white-space warning
  -:  --------- > 16:  05947781f range-diff --dual-color: skip white-space warnings
 17:  9e09c6be6 = 17:  3147c4440 range-diff: populate the man page
 18:  9b3632324 ! 18:  b08e6d937 completion: support `git range-diff`
     @@ -18,16 +18,16 @@
       
      +_git_range_diff ()
      +{
     -+  case "$cur" in
     -+  --*)
     -+          __gitcomp "
     -+	  	--creation-factor= --dual-color
     -+                  $__git_diff_common_options
     -+                  "
     -+          return
     -+          ;;
     -+  esac
     -+  __git_complete_revlist
     ++	case "$cur" in
     ++	--*)
     ++		__gitcomp "
     ++			--creation-factor= --dual-color
     ++			$__git_diff_common_options
     ++		"
     ++		return
     ++		;;
     ++	esac
     ++	__git_complete_revlist
      +}
      +
       _git_rebase ()
 19:  07ec215e8 ! 19:  19406283e range-diff: left-pad patch numbers
     @@ -48,7 +48,7 @@
      +		strbuf_addf(buf, " %*d:  %s", patch_no_width, b_util->i + 1,
       			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
       
     - 	commit = lookup_commit_reference(oid);
     + 	commit = lookup_commit_reference(the_repository, oid);
      @@
       		   struct diff_options *diffopt)
       {
 20:  b370468e7 ! 20:  6b3552386 range-diff: make --dual-color the default mode
     @@ -87,8 +87,8 @@
       		OPT_END()
       	};
      @@
     - 	argc = j;
     - 	diff_setup_done(&diffopt);
     + 			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
     + 			     builtin_range_diff_usage, 0);
       
      -	if (dual_color) {
      -		diffopt.use_color = 1;
     @@ -104,11 +104,11 @@
      --- a/contrib/completion/git-completion.bash
      +++ b/contrib/completion/git-completion.bash
      @@
     -   case "$cur" in
     -   --*)
     -           __gitcomp "
     --	  	--creation-factor= --dual-color
     -+	  	--creation-factor= --no-dual-color
     -                   $__git_diff_common_options
     -                   "
     -           return
     + 	case "$cur" in
     + 	--*)
     + 		__gitcomp "
     +-			--creation-factor= --dual-color
     ++			--creation-factor= --no-dual-color
     + 			$__git_diff_common_options
     + 		"
     + 		return
 21:  d8498fb32 ! 21:  ccf8c1bb2 range-diff: use dim/bold cues to improve dual color mode
     @@ -144,7 +144,7 @@
      +				set = diff_get_color_opt(o, DIFF_FILE_NEW_BOLD);
      +			else
      +				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
     - 			flags |= WS_IGNORE_FIRST_SPACE;
     + 			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
       		}
       		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
      @@

-- 
gitgitgadget
