From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: [ANNOUNCE] tig-2.0.3
Date: Thu, 28 Aug 2014 22:32:28 -0400
Message-ID: <CAFuPQ1JJVUM2qyD3Z8bCgEr5jotU-ORe+eS_FUvLpiqok7MqEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 04:32:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNBzi-0000wf-Ic
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 04:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbaH2Ccu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 22:32:50 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:56451 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbaH2Cct (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 22:32:49 -0400
Received: by mail-ie0-f178.google.com with SMTP id at1so2080304iec.9
        for <git@vger.kernel.org>; Thu, 28 Aug 2014 19:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=ib3Pm04ba3yz+eq2bpc9WMKZkmcYdK7lgCjIq8mYOxA=;
        b=cerlemtLbUV6XRx3zW0FkpbJlXJSRiGyj215BHMnlLQiU4ML1Cq/3mHV2VuqZFnOUA
         nzlhBCo/LT3s8DZFC04zxlQAlFmye2CUDr+NjaEAwTSESpVf28iUomDXKZshwo8/oBQ/
         gFdvuNPudKTdcIwSuLxuX6mIABWlFSa6t/NLJUsLD2J3dEZW0T69YsEXAsDTJXGOwpNV
         Y6a6QAGFcj2lXrWcdP8qcHbyriHOlZciyyqPEFut5b602PZ10A7GzQqxaIQ92VYDCLJE
         v9E0WJu6rT6B+bXSgUKklIAQDec/Z7IrLhmPidkbxJVfI8gIw45Ce99+i1WtGVtnX50E
         EFfA==
X-Received: by 10.50.128.46 with SMTP id nl14mr933515igb.48.1409279568197;
 Thu, 28 Aug 2014 19:32:48 -0700 (PDT)
Received: by 10.107.136.165 with HTTP; Thu, 28 Aug 2014 19:32:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256137>

Hello,

I am very happy to announce that another bug fix release of Tig is now
available. Among the most prominent fixes are readline completion and
srefreshing of view after returning from commands when refresh-mode is
set to after-command. This release also improves testing so that Tig now
has an actual test suite, which although being far from complete has
already help to ensure more consistency and avoid regressions. For a
complete list of fixes and improvements see the release notes below.

With this maintainance release out of the way I plan to merge some of
the experimental features such as support for key combos that didn't get
finalized for the 2.0 release.

What is Tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

Resources
---------
 - Homepage: http://jonas.nitro.dk/tig/
 - Manual: http://jonas.nitro.dk/tig/manual.html
 - Tarballs: http://jonas.nitro.dk/tig/releases/
 - Git URL: git://github.com/jonas/tig.git
 - Gitweb: http://repo.or.cz/w/tig.git
 - Q&A: http://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Improvement:

 - Add `:save-display <file>` prompt command to save the current display.
 - Add `:script <file>` prompt command for scripting the Tig UI.
 - Add test framework and convert existing tests to use it.
 - Add command-line option for starting in refs view: `tig refs`. (GH #309)
 - Make blame commit ID colors stable across reloads. (GH #303)
 - Increase blame ID and graph rendering color palette to 14 colors.
 - New setting 'split-view-width' controls the width for vertical splits. It
   takes the width of the right-most view either as a number or a percentage.
 - Expose settings holding command line argument lists: `file-args`, `rev-args`,
   and `cmdline-args`. They are mainly intended for testing purposes but also
   allows to change the filtering arguments dynamically. (GH #306)
 - Add `log-options` setting for specifying default log view options.
   Example: `set log-options = --pretty=fuller`.
 - Use option specific view flags to reload view after `:set` commands.

Bug fixes:

 - Refresh the current view when returning from an external command and
   `refresh-mode=after-command`. (GH #289)
 - Fix readline completion.
 - Fix '/' to `find-next` when readline support is enabled. (GH #302)
 - Fix readline prompt to correctly handle UTF-8 characters.
 - Add warnings for more obsolete actions and colors.
 - Fix passing of commit IDS via stdin to the main view.
 - Fix commit title overflow drawing for multibyte text. (GH #307)
 - Fix installation directory permissions.
 - Handle binary files matches reported by git-grep.
 - Toggling of "args"-typed options without any arguments will clear the current
   arguments. Example: `:toggle blame-options`.
 - Detect custom `pretty.format` settings that break the log view and fallback
   to use the `medium` format. (GH #225)
 - Fix invocation of git-diff for the blame view's line tracking. (GH #316)
 - Fix blame completion of directory names. (GH #317)
 - Fix display of conflicts in the main view when 'show-changes' is enabled.
 - Fix off-by-one error when displaying line numbers in the grep view.
 - When showing the commit graph ensure that either topo, date or author-date
   commit order is used. (Debian #757692) (GH #238)

Change summary
--------------
The diffstat and log summary for changes made in this release.

 .gitignore                                    |     3 +-
 .travis.yml                                   |     4 +-
 Makefile                                      |    30 +-
 NEWS.adoc                                     |    43 +
 contrib/tig-completion.bash                   |    38 +-
 doc/manual.adoc                               |     2 +-
 doc/tig.1.adoc                                |    19 +
 doc/tigrc.5.adoc                              |    74 +-
 include/tig/display.h                         |    18 +-
 include/tig/graph.h                           |     2 +-
 include/tig/io.h                              |     4 +-
 include/tig/keys.h                            |     1 +
 include/tig/line.h                            |     7 +
 include/tig/options.h                         |    15 +-
 include/tig/prompt.h                          |     8 +
 include/tig/refdb.h                           |     1 +
 include/tig/watch.h                           |     2 +-
 src/argv.c                                    |    22 +-
 src/blame.c                                   |    16 +-
 src/diff.c                                    |     4 +-
 src/display.c                                 |   206 +-
 src/draw.c                                    |    56 +-
 src/grep.c                                    |    36 +-
 src/keys.c                                    |     1 -
 src/line.c                                    |     7 +
 src/log.c                                     |     4 +-
 src/main.c                                    |    27 +-
 src/options.c                                 |    66 +-
 src/parse.c                                   |     1 -
 src/prompt.c                                  |   106 +-
 src/refdb.c                                   |     7 +-
 src/refs.c                                    |     2 +-
 src/repo.c                                    |     3 +-
 src/status.c                                  |     2 +-
 src/tig.c                                     |    42 +-
 src/view.c                                    |   109 +-
 src/watch.c                                   |    33 +-
 test/README.adoc                              |    39 +
 test/blame/default-test                       |   125 +
 test/builtin-config.sh                        |    18 -
 test/files/scala-js-benchmarks.tgz            |   Bin 0 -> 91452 bytes
 .../simple.in => graph/00-simple-test}        |    17 +
 test/graph/01-merge-from-left-test            |    26 +
 test/graph/02-duplicate-parent-test           |    38 +
 test/graph/03-octo-merge-test                 |    26 +
 test/graph/04-missing-bar-test                |    32 +
 test/graph/05-extra-pipe-test                 |    29 +
 .../06-extra-bars-test}                       |   125 +
 test/graph/07-multi-collapse-test             |    35 +
 test/graph/08-multi-collapse-2-test           |    38 +
 test/graph/09-parallel-siblings-test          |    38 +
 test/graph/10-shorter-merge-than-branch-test  |    44 +
 test/graph/11-new-branch-in-middle-test       |    38 +
 test/graph/12-cross-over-collapse-test        |    38 +
 ...branches-with-different-middle-branch-test |    41 +
 .../14-long-collapse-line-test}               |    51 +
 .../15-many-merges-test}                      |    31 +
 .../16_changes.in => graph/16-changes-test}   |    15 +
 .../more.out => graph/17-more-merges-test}    |    83 +
 .../tig.in => graph/18-tig-test}              |    19 +
 .../tig-all.in => graph/19-tig-all-test}      |    47 +-
 .../20-tig-all-long-test}                     |   604 +-
 test/graph/20-tig-all-long-test.in            |   Bin 0 -> 262208 bytes
 test/grep/default-test                        |   249 +
 test/log/pretty-format-test                   |   123 +
 test/log/submodule-test                       |   127 +
 test/main/commit-order-edge-case-test         |    47 +
 test/main/commit-order-edge-case-test.tgz     |   Bin 0 -> 2728 bytes
 test/main/commit-title-overflow-test          |   114 +
 test/main/default-test                        |   144 +
 test/main/pretty-raw-test                     |    38 +
 test/main/refresh-test                        |    98 +
 test/main/search-test                         |   160 +
 test/main/show-changes-test                   |   151 +
 test/main/stdin-test                          |    38 +
 test/main/submodule-test                      |   130 +
 test/main/util.sh                             |    16 +
 test/main/view-split-test                     |   110 +
 test/refs/branch-checkout-test                |   106 +
 test/refs/default-test                        |    60 +
 test/refs/util.sh                             |    13 +
 test/script/default-test                      |    40 +
 test/status/file-name-test                    |   122 +
 test/status/refresh-test                      |   251 +
 .../10_shorter_merge_than_branch.in           |    22 -
 .../10_shorter_merge_than_branch.out          |    11 -
 .../11_new_branch_in_middle.in                |    18 -
 .../11_new_branch_in_middle.out               |     9 -
 .../12_cross_over_collapse.in                 |    18 -
 .../12_cross_over_collapse.out                |     9 -
 ...l_branches_with_different_middle_branch.in |    20 -
 ..._branches_with_different_middle_branch.out |    10 -
 .../14_long_collapse_line.in                  |    40 -
 test/test-graph-samples/16_changes.out        |     4 -
 test/test-graph-samples/1_merge_from_left.in  |    10 -
 test/test-graph-samples/1_merge_from_left.out |     5 -
 test/test-graph-samples/2_duplicate_parent.in |    18 -
 .../test-graph-samples/2_duplicate_parent.out |     9 -
 test/test-graph-samples/3_octo_merge.in       |    10 -
 test/test-graph-samples/3_octo_merge.out      |     5 -
 test/test-graph-samples/4_missing_bar.in      |    14 -
 test/test-graph-samples/4_missing_bar.out     |     7 -
 test/test-graph-samples/5_extra_pipe.in       |    12 -
 test/test-graph-samples/5_extra_pipe.out      |     6 -
 test/test-graph-samples/6_extra_bars.in       |   115 -
 test/test-graph-samples/7_multi_collapse.in   |    16 -
 test/test-graph-samples/7_multi_collapse.out  |     8 -
 test/test-graph-samples/8_multi_collapse_2.in |    18 -
 .../test-graph-samples/8_multi_collapse_2.out |     9 -
 .../test-graph-samples/9_parallel_siblings.in |    18 -
 .../9_parallel_siblings.out                   |     9 -
 test/test-graph-samples/many_merges.out       |    20 -
 test/test-graph-samples/more.in               |    72 -
 test/test-graph-samples/simple.out            |     6 -
 test/test-graph-samples/tig-all-long.in       | 14986 ----------------
 test/test-graph-samples/tig-all.out           |    35 -
 test/test-graph-samples/tig.out               |     8 -
 test/tigrc/builtin-error-test                 |    12 +
 test/tigrc/compat-error-test                  |   125 +
 test/tigrc/env-vars-test                      |    39 +
 test/tigrc/parse-test                         |   125 +
 test/tigrc/tigrc-manpage-examples-test        |    49 +
 test/tools/libgit.sh                          |   242 +
 test/tools/libtest.sh                         |   228 +
 test/tools/setup-conflict.sh                  |    22 +
 test/tools/show-results.sh                    |    34 +
 test/{ => tools}/test-graph.c                 |    36 +-
 test/tree/default-test                        |   165 +
 test/unit-test-graph.sh                       |    19 -
 tigrc                                         |    12 +-
 tools/aspell.dict                             |    11 +-
 tools/install.sh                              |     2 +-
 tools/release.sh                              |     7 +-
 133 files changed, 5456 insertions(+), 16004 deletions(-)

     1 Alexander Myltsev
     3 John Keeping
    64 Jonas Fonseca
     1 Olof-Joachim Frahm
     1 Sven Wegener
     2 Vivien Didelot
     1 hamaco


-- 
Jonas Fonseca
