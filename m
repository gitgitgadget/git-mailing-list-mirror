Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77006200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeEDPel (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:34:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:39041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbeEDPei (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:34:38 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MU0pN-1eoOe53No1-00QnKd; Fri, 04 May 2018 17:34:28 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/18] Add `branch-diff`, a `tbdiff` lookalike
Date:   Fri,  4 May 2018 17:34:27 +0200
Message-Id: <cover.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PMyXNe+E9jgiKfKrGUdJHVTm5KBOM7zErkUisuQGSRwrNZFKdUe
 O57XBSKXCJNiu0iNlCPTNKMS0wYn1f3ZQ9x9CgpoMqJzXk63WRg3c92jxyQVzWfaSF6/ICX
 HGD73RC99HDQPjgcqmK6XoWgGE42YU/s2peU93XhE2Bb5v5yYW/FvRK9tugxOBhBEFzimaz
 L/U/nQAZ6Fr4teSr4iGeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x4XnfNTK7Nk=:DD/FXSE85i+YJE3dyvecgy
 N0VcWqZAngqmZONeTPN9ReQrQPwtpfC4oQkNj3FZiDBhZj7Nm1geEi3ItCjdcd6bjHCTCDsBQ
 okb2TNZ8c6JQDkD6tt7s6rP4q9qMaPGPRit0ALHM5RSufw/qZhyfoB0F5AN6jV2pv6jdzeR+2
 rzQ8XcstiUB1ysjjMvthXTh5Vfue1IVoNckl8S0cfQZ1pe0kLnVeBUx2ZRNGTYWdRZId4Zmom
 i0w0Qk42ZNsQ/SUMjaZ5NbVa8JiJtRTuh52eog7YSNGj74X3q+9LFCPQ8lmYtzsrjoYWfTEjq
 /qmyJzdK5ZckSYeM/du6zhhbARkosckKwHbi0ecJRo8ngAofXk07JHARWXtPRK0+D8kD4ttzZ
 Zv55cuoM9VNhAU9V06a9Cq+6zVScB2bR2zfYRRJJ+aV9+LQKOkFBw8HgWnILQWCXbOj3wofg/
 eT6srvDC1De6j5QpQyZyCEkjRCiPPspK5oX4hK9ozYLZWpWHfKj1VVnBpanIsLY5LXlri/guT
 1R4Tbz/e4ExxS8wxKelRnxZvYHjJozVjP7eDZCBOIgKUWp3VKvJyt9GquvlypKQ1kGfi4clMR
 gEDpRiU6di1aRFUPsg1oRFe4HLzocNA6sYQ4f7Jl91Viu3fLpUmejfhwYt8HdhjnHmtYd6860
 O8C106PXCrMJAu3AlAZLdISUb7khoMoacoH+3zN1OJ26lYcHCexQLDJ0Ce3GYJvKqit+8ipwq
 edqm0OzxWGnq5vXhB+mCdf6QSyKC1znUQJBntA1n+Q3NRj/pqD+AlRa7PupxzR/oTeovj2uvJ
 VDXsftq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The incredibly useful `git-tbdiff` tool to compare patch series (say, to see
what changed between two iterations sent to the Git mailing list) is slightly
less useful for this developer due to the fact that it requires the `hungarian`
and `numpy` Python packages which are for some reason really hard to build in
MSYS2. So hard that I even had to give up, because it was simply easier to
reimplement the whole shebang as a builtin command.

The project at https://github.com/trast/tbdiff seems to be dormant, anyway.
Funny (and true) story: I looked at the open Pull Requests to see how active
that project is, only to find to my surprise that I had submitted one in August
2015, and that it was still unanswered let alone merged.

While at it, I forward-ported AEvar's patch to force `--decorate=no` because
`git -p tbdiff` would fail otherwise.

Side note: I work on implementing branch-diff not only to make life easier for
reviewers who have to suffer through v2, v3, ... of my patch series, but also
to verify my changes before submitting a new iteraion. And also, maybe even
more importantly, I plan to use it to verify my merging-rebases of Git for
Windows (for which I previously used to redirect the pre-rebase/post-rebase
diffs vs upstream and then compare them using `git diff --no-index`). And of
course any interested person can see what changes were necessary e.g. in the
merging-rebase of Git for Windows onto v2.17.0 by running a command like:

	base=^{/Start.the.merging-rebase}
	tag=v2.17.0.windows.1
	pre=$tag$base^2
	git branch-diff --dual-color $pre$base..$pre $tag$base..$tag

The --dual-color mode will identify the many changes that are solely due to
different diff context lines (where otherwise uncolored lines start with a
background-colored -/+ marker), i.e. merge conflicts I had to resolve.

Changes since v1:

- Fixed the usage to *not* say "rebase--helper" (oops, now everybody knows that
  I copy-edited that code... ;-))

- Removed `branch-diff` from the `git help` output for now, by removing the
  `info` keyword from the respective line in command-list.txt.

- Removed the bogus `COLOR_DUAL_MODE` constant that was introduced in one
  patch, only to be removed in the next one.

- Fixed typo "emtpy".

- Fixed `make sparse` warnings.

- Changed the usage string to avoid the confusing lower-case bare `base`.

- Fixed tyop in commit message: "Pythong".

- Removed an awkward empty line before a `continue;` statement.

- Released the `line` strbuf after use.

- Fixed a typo and some "foreigner's English" in the commit message of
  "branch-diff: also show the diff between patches".

- Avoided introducing --no-patches too early and then replacing it by the
  version that uses the diff_options.

- Fixed the man page to continue with upper-case after a colon.

The branch-diff of v1 vs 2 is best viewed with --dual-color; This helps e.g.
with identifying changed *context* lines in the diff:

git branch-diff --dual-color origin/master branch-diff-v1 branch-diff-v2

(assuming that your `origin` points to git.git and that you fetched the tags
from https://github.com/dscho/git). For example, you will see that the only
change in patch #10 is a change in the diff context (due to the change of the
usage string in patch #2):

10:  9810869ced9 ! 10:  2695a6abc46 branch-diff: do not show "function names" in hunk headers
    @@ -17,7 +17,7 @@
     +#include "userdiff.h"

      static const char * const builtin_branch_diff_usage[] = {
    -   N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
    + N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
     @@
        return data;
      }


Johannes Schindelin (17):
  Add a function to solve least-cost assignment problems
  Add a new builtin: branch-diff
  branch-diff: first rudimentary implementation
  branch-diff: improve the order of the shown commits
  branch-diff: also show the diff between patches
  branch-diff: right-trim commit messages
  branch-diff: indent the diffs just like tbdiff
  branch-diff: suppress the diff headers
  branch-diff: adjust the output of the commit pairs
  branch-diff: do not show "function names" in hunk headers
  branch-diff: use color for the commit pairs
  color: provide inverted colors, too
  diff: add an internal option to dual-color diffs of diffs
  branch-diff: offer to dual-color the diffs
  branch-diff --dual-color: work around bogus white-space warning
  branch-diff: add a man page
  completion: support branch-diff

Thomas Rast (1):
  branch-diff: add tests

 .gitignore                             |   1 +
 Documentation/git-branch-diff.txt      | 239 ++++++++++
 Makefile                               |   2 +
 builtin.h                              |   1 +
 builtin/branch-diff.c                  | 534 ++++++++++++++++++++++
 color.h                                |   6 +
 command-list.txt                       |   1 +
 contrib/completion/git-completion.bash |  18 +
 diff.c                                 |  76 +++-
 diff.h                                 |   6 +-
 git.c                                  |   1 +
 hungarian.c                            | 205 +++++++++
 hungarian.h                            |  19 +
 t/.gitattributes                       |   1 +
 t/t7910-branch-diff.sh                 | 144 ++++++
 t/t7910/history.export                 | 604 +++++++++++++++++++++++++
 16 files changed, 1846 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/git-branch-diff.txt
 create mode 100644 builtin/branch-diff.c
 create mode 100644 hungarian.c
 create mode 100644 hungarian.h
 create mode 100755 t/t7910-branch-diff.sh
 create mode 100644 t/t7910/history.export


base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
Published-As: https://github.com/dscho/git/releases/tag/branch-diff-v2
Fetch-It-Via: git fetch https://github.com/dscho/git branch-diff-v2

Branch-diff vs v1:
  1: 8bc517e35d4 !  1: a1ea0320b64 Add a new builtin: branch-diff
     @@ -7,8 +7,9 @@
          the next commits will turn `branch-diff` into a full-blown replacement
          for `tbdiff`.
          
     -    At this point, we ignore tbdiff's color options, as they will all be
     -    implemented later and require some patches to the diff machinery.
     +    At this point, we ignore tbdiff's color options as well as the
     +    --no-patches option, as they will all be implemented later using
     +    diff_options.
          
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -54,14 +55,15 @@
      +++ b/builtin/branch-diff.c
      @@
      +#include "cache.h"
     ++#include "builtin.h"
      +#include "parse-options.h"
      +
      +static const char * const builtin_branch_diff_usage[] = {
     -+	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
     -+	NULL
     ++N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
     ++N_("git branch-diff [<options>] <old-tip>...<new-tip>"),
     ++N_("git branch-diff [<options>] <base> <old-tip> <new-tip>"),
     ++NULL
      +};
     -+
     -+#define COLOR_DUAL_MODE 2
      +
      +static int parse_creation_weight(const struct option *opt, const char *arg,
      +				 int unset)
     @@ -76,11 +78,8 @@
      +
      +int cmd_branch_diff(int argc, const char **argv, const char *prefix)
      +{
     -+	int no_patches = 0;
      +	double creation_weight = 0.6;
      +	struct option options[] = {
     -+		OPT_BOOL(0, "no-patches", &no_patches,
     -+			 N_("short format (no diffs)")),
      +		{ OPTION_CALLBACK,
      +			0, "creation-weight", &creation_weight, N_("factor"),
      +			N_("Fudge factor by which creation is weighted [0.6]"),
     @@ -101,7 +100,7 @@
       git-bisect                              mainporcelain           info
       git-blame                               ancillaryinterrogators
       git-branch                              mainporcelain           history
     -+git-branch-diff                         mainporcelain           info
     ++git-branch-diff                         mainporcelain
       git-bundle                              mainporcelain
       git-cat-file                            plumbinginterrogators
       git-check-attr                          purehelpers
  2: ec51c71779a !  2: e530e450ebd branch-diff: first rudimentary implementation
     @@ -13,7 +13,7 @@
          really concentrates on getting the patch matching part right.
          
          Note: due to differences in the diff algorithm (`tbdiff` uses the
     -    Pythong module `difflib`, Git uses its xdiff fork), the cost matrix
     +    Python module `difflib`, Git uses its xdiff fork), the cost matrix
          calculated by `branch-diff` is different (but very similar) to the one
          calculated by `tbdiff`. Therefore, it is possible that they find
          different matching commits in corner cases (e.g. when a patch was split
     @@ -26,6 +26,7 @@
      +++ b/builtin/branch-diff.c
      @@
       #include "cache.h"
     + #include "builtin.h"
       #include "parse-options.h"
      +#include "string-list.h"
      +#include "run-command.h"
     @@ -35,15 +36,7 @@
      +#include "hungarian.h"
       
       static const char * const builtin_branch_diff_usage[] = {
     - 	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
     - 	NULL
     - };
     - 
     --#define COLOR_DUAL_MODE 2
     --
     - static int parse_creation_weight(const struct option *opt, const char *arg,
     - 				 int unset)
     - {
     + N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
      @@
       	return 0;
       }
     @@ -128,7 +121,6 @@
      +				strbuf_addbuf(&buf, &line);
      +				strbuf_addch(&buf, '\n');
      +			}
     -+
      +			continue;
      +		} else if (starts_with(line.buf, "@@ "))
      +			strbuf_addstr(&buf, "@@");
     @@ -148,6 +140,7 @@
      +		util->diffsize++;
      +	}
      +	fclose(in);
     ++	strbuf_release(&line);
      +
      +	if (util)
      +		string_list_append(list, buf.buf)->util = util;
     @@ -323,7 +316,7 @@
      +
       int cmd_branch_diff(int argc, const char **argv, const char *prefix)
       {
     - 	int no_patches = 0;
     + 	double creation_weight = 0.6;
      @@
       			0, parse_creation_weight },
       		OPT_END()
     @@ -366,7 +359,7 @@
      +		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
      +		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
      +	} else {
     -+		error("Need two commit ranges");
     ++		error(_("need two commit ranges"));
      +		usage_with_options(builtin_branch_diff_usage, options);
      +	}
      +
  3: 6a618d6010f =  3: 3032e2709b8 branch-diff: improve the order of the shown commits
  4: 141e5b63e45 !  4: 12d9c7977fd branch-diff: also show the diff between patches
     @@ -4,10 +4,12 @@
          
          Just like tbdiff, we now show the diff between matching patches. This is
          a "diff of two diffs", so it can be a bit daunting to read for the
     -    beginnger.
     +    beginner.
          
     -    This brings branch-diff closer to be feature-complete with regard to
     -    tbdiff.
     +    And just like tbdiff, we now also accept the `--no-patches` option
     +    (which is actually equivalent to the diff option `-s`).
     +    
     +    This brings branch-diff closer to feature parity with regard to tbdiff.
          
          An alternative would be to display an interdiff, i.e. the hypothetical
          diff which is the result of first reverting the old diff and then
     @@ -34,7 +36,7 @@
      +#include "diffcore.h"
       
       static const char * const builtin_branch_diff_usage[] = {
     - 	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
     + N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
      @@
       	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
       }
     @@ -82,12 +84,9 @@
       
       int cmd_branch_diff(int argc, const char **argv, const char *prefix)
       {
     --	int no_patches = 0;
     -+	struct diff_options diffopt = { 0 };
     ++	struct diff_options diffopt = { NULL };
       	double creation_weight = 0.6;
       	struct option options[] = {
     --		OPT_BOOL(0, "no-patches", &no_patches,
     --			 N_("short format (no diffs)")),
      +		OPT_SET_INT(0, "no-patches", &diffopt.output_format,
      +			    N_("short format (no diffs)"),
      +			    DIFF_FORMAT_NO_OUTPUT),
  5: 303419c56c4 =  5: 53ee6ba3873 branch-diff: right-trim commit messages
  6: 218e56a69e0 !  6: c856c460a47 branch-diff: indent the diffs just like tbdiff
     @@ -26,7 +26,7 @@
      @@
       int cmd_branch_diff(int argc, const char **argv, const char *prefix)
       {
     - 	struct diff_options diffopt = { 0 };
     + 	struct diff_options diffopt = { NULL };
      +	struct strbuf four_spaces = STRBUF_INIT;
       	double creation_weight = 0.6;
       	struct option options[] = {
  7: 00ea45123ae =  7: 35a9681a192 branch-diff: suppress the diff headers
  8: 40471263d3c !  8: 0e4c8279e46 branch-diff: adjust the output of the commit pairs
     @@ -19,7 +19,7 @@
      +#include "pretty.h"
       
       static const char * const builtin_branch_diff_usage[] = {
     - 	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
     + N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
      @@
       	return res;
       }
  9: 9810869ced9 !  9: 2695a6abc46 branch-diff: do not show "function names" in hunk headers
     @@ -17,7 +17,7 @@
      +#include "userdiff.h"
       
       static const char * const builtin_branch_diff_usage[] = {
     - 	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
     + N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
      @@
       	return data;
       }
 10: fe12b99a0b4 ! 10: 313beeed3d1 branch-diff: add tests
     @@ -12,7 +12,7 @@
          sometimes ambiguous. In this case, a comment line and an empty line are
          added, but it is ambiguous whether they were added after the existing
          empty line, or whether an empty line and the comment line are added
     -    *before* the existing emtpy line. And apparently xdiff picks a different
     +    *before* the existing empty line. And apparently xdiff picks a different
          option here than Python's difflib.
          
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
 11: c89937afc28 = 11: ba4791918c7 branch-diff: use color for the commit pairs
 12: a94e94edf65 = 12: 1ebbe359547 color: provide inverted colors, too
 13: 153425de2df = 13: ae0ea5dfca5 diff: add an internal option to dual-color diffs of diffs
 14: 2f8017c732f ! 14: b9be01705d6 branch-diff: offer to dual-color the diffs
     @@ -18,7 +18,7 @@
      +++ b/builtin/branch-diff.c
      @@
       {
     - 	struct diff_options diffopt = { 0 };
     + 	struct diff_options diffopt = { NULL };
       	struct strbuf four_spaces = STRBUF_INIT;
      +	int dual_color = 0;
       	double creation_weight = 0.6;
 15: 62f0e2cf73f = 15: b99ab186c4f branch-diff --dual-color: work around bogus white-space warning
 16: edb34bd4f8d ! 16: 950c7537701 branch-diff: add a man page
     @@ -158,7 +158,7 @@
      +series), the cost matrix is extended to allow for that, by adding
      +fixed-cost entries for wholesale deletes/adds.
      +
     -+Example: let commits `1--2` be the first iteration of a patch series and
     ++Example: Let commits `1--2` be the first iteration of a patch series and
      +`A--C` the second iteration. Let's assume that `A` is a cherry-pick of
      +`2,` and `C` is a cherry-pick of `1` but with a small modification (say,
      +a fixed typo). Visualize the commits as a bipartite graph:
 17: 5d047a830f1 = 17: 71698f11835 completion: support branch-diff
-- 
2.17.0.409.g71698f11835

