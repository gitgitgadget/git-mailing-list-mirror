Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11DEA1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 15:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbdBJPmB (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 10:42:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:55539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752078AbdBJPla (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 10:41:30 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnlmV-1bvQLP0tW3-00hwof; Fri, 10
 Feb 2017 16:33:52 +0100
Date:   Fri, 10 Feb 2017 16:33:46 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 2/2] rev-parse: fix several options when running in a
 subdirectory
In-Reply-To: <cover.1486740772.git.johannes.schindelin@gmx.de>
Message-ID: <9242ee9717dcec95351b356070102f198eeb2537.1486740772.git.johannes.schindelin@gmx.de>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de> <cover.1486740772.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:afFDj8XPWVH7S38YvI3dTNr/GtZz76yeg4eWOcdA6DAb+Sm9702
 Ijz/Ibu6ZR++JcCUm4GzqUv2pMlpyFg0eRUSd+CLlBqwn8rsd9IN9FVlZ8K4DVU8FwC42v5
 Fxdx+e/cR7cZNNv8xlgwkSkCQv0E24mGXzQguxRCh+KbSTXznFfT6+v3IpN1SMCEVOR18kM
 E4AUwc8/OqlvlaRTJ5UXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LyxsPnOiwZg=:63flcVqdPFkV4+VezGXs8E
 q/JjWAOwqTEGSTYMMrqsxNr126GsdDv4e05fAEl521v6mMyN56aZAQj1auzBLmOOKHFKAZWQr
 4osAmKXREEWyhP0YoZYGgYg9E7i+3rcqcmOgyA8KOLZsdRXR2AAIxKf+aGD/lQIKAlIPMWzTy
 aeO+rqFEuyng3/M3THBX1aG2a+8JpZzFMyea2Q2idxZ8LgKJVi4nHAeD5wT/R9MZ5Fr+QuRmT
 ayAL7fYqoBOk36RPO8IwJkzjxJKH6m8tn8KDq6VwlXww7uKwFc5k5Mpf299v34ibR2LCDQq5x
 5TDQrJNGvHSEcvoPLO6h196ZIvGA8dzuWfa9jGivhz//KkfVjW3yanXFBK+NEzyJweY2+oGfW
 R5Rz5pxHRRk3xQF9ZU0G2yV2Nh7wTlbee4ILiVglLv3jI4Vx4sOmVArBHDD0wzwS0xbkQPpVx
 p1dzJSejsNthhQwPlvy8fyHgJHBWWm65v4vo1VOgnieUJGjGCIT1dyIYxLcawhU9Y40l8byUO
 srtMVioFxQBim2ja2r/zR2cd5CHLna6qLNYMkc6o9jpFBS2kme2DcijPs1iUShbcob2V3ORYX
 mgcBFZm2HszfpDvDRXEvgKDMmcgs0lbO4/3ykg1ZMEfNiqikxKDtDEn6E9d+BrTh/oqNTnrgH
 +kFQ/U7EopXmkAn/xmvlOppn9g9Bv9EeO++5pCmMNsfMZOJsNM8dSe7zTSsZyhZtAeSSnr8MH
 qiJEFN4DCi5HMU42zdOSEqUO7R4bRehw1XDQ6ENwIeNIJbjMckNvuTFcSfuvh/Rx3DphI3+Se
 +UqSy6VGZNtNRm87T5fpe3OiUqm2d/zCHLJDdl2r0BWEyBeP6Gpi7kzUDIY4Wz4c1tsf5felK
 K1XDmHfaMBCYooOyzmrT0FWxGBTHr863p+fPSDwbyZDfBAv51cj+O/upH9eVW5wOGsT44xlbL
 i7f4P7v63c8f29CtW9xe2SLhgEfqUu+YBM2dL7tBi1rgoOS7jNQJOXYUGIKD+TlIRMqO6fh6U
 FM5A0r/nsJlfLhcdS9zdMmg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In addition to making git_path() aware of certain file names that need
to be handled differently e.g. when running in worktrees, the commit
557bd833bb (git_path(): be aware of file relocation in $GIT_DIR,
2014-11-30) also snuck in a new option for `git rev-parse`:
`--git-path`.

On the face of it, there is no obvious bug in that commit's diff: it
faithfully calls git_path() on the argument and prints it out, i.e. `git
rev-parse --git-path <filename>` has the same precise behavior as
calling `git_path("<filename>")` in C.

The problem lies deeper, much deeper. In hindsight (which is always
unfair), implementing the .git/ directory discovery in
`setup_git_directory()` by changing the working directory may have
allowed us to avoid passing around a struct that contains information
about the current repository, but it bought us many, many problems.

In this case, when being called in a subdirectory, `git rev-parse`
changes the working directory to the top-level directory before calling
`git_path()`. In the new working directory, the result is correct. But
in the working directory of the calling script, it is incorrect.

Example: when calling `git rev-parse --git-path HEAD` in, say, the
Documentation/ subdirectory of Git's own source code, the string
`.git/HEAD` is printed.

Side note: that bug is hidden when running in a subdirectory of a
worktree that was added by the `git worktree` command: in that case, the
(correct) absolute path of the `HEAD` file is printed.

In the interest of time, this patch does not go the "correct" route to
introduce a struct with repository information (and removing global
state in the process), instead this patch chooses to detect when the
command was called in a subdirectory and forces the result to be an
absolute path.

While at it, we are also fixing the output of --git-common-dir and
--shared-index-path.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rev-parse.c      | 15 +++++++++++----
 t/t1500-rev-parse.sh     |  4 ++--
 t/t1700-split-index.sh   |  2 +-
 t/t2027-worktree-list.sh |  4 ++--
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ff13e59e1db..84af2802f6f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -545,6 +545,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	unsigned int flags = 0;
 	const char *name = NULL;
 	struct object_context unused;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
@@ -599,7 +600,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--git-path")) {
 			if (!argv[i + 1])
 				die("--git-path requires an argument");
-			puts(git_path("%s", argv[i + 1]));
+			strbuf_reset(&buf);
+			puts(relative_path(git_path("%s", argv[i + 1]),
+					   prefix, &buf));
 			i++;
 			continue;
 		}
@@ -821,8 +824,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--git-common-dir")) {
-				const char *pfx = prefix ? prefix : "";
-				puts(prefix_filename(pfx, strlen(pfx), get_git_common_dir()));
+				strbuf_reset(&buf);
+				puts(relative_path(get_git_common_dir(),
+						   prefix, &buf));
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
@@ -845,7 +849,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					die(_("Could not read the index"));
 				if (the_index.split_index) {
 					const unsigned char *sha1 = the_index.split_index->base_sha1;
-					puts(git_path("sharedindex.%s", sha1_to_hex(sha1)));
+					const char *path = git_path("sharedindex.%s", sha1_to_hex(sha1));
+					strbuf_reset(&buf);
+					puts(relative_path(path, prefix, &buf));
 				}
 				continue;
 			}
@@ -906,5 +912,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		die_no_single_rev(quiet);
 	} else
 		show_default();
+	strbuf_release(&buf);
 	return 0;
 }
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index f39f783f2db..d74f09ad93e 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -93,7 +93,7 @@ test_expect_success 'git-common-dir from worktree root' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git-common-dir inside sub-dir' '
+test_expect_success 'git-common-dir inside sub-dir' '
 	mkdir -p path/to/child &&
 	test_when_finished "rm -rf path" &&
 	echo "$(git -C path/to/child rev-parse --show-cdup).git" >expect &&
@@ -107,7 +107,7 @@ test_expect_success 'git-path from worktree root' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git-path inside sub-dir' '
+test_expect_success 'git-path inside sub-dir' '
 	mkdir -p path/to/child &&
 	test_when_finished "rm -rf path" &&
 	echo "$(git -C path/to/child rev-parse --show-cdup).git/objects" >expect &&
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 1d6e27a09d8..446ff34f966 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -200,7 +200,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure 'rev-parse --shared-index-path' '
+test_expect_success 'rev-parse --shared-index-path' '
 	rm -rf .git &&
 	test_create_repo . &&
 	git update-index --split-index &&
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index c1a072348e7..848da5f3684 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -8,7 +8,7 @@ test_expect_success 'setup' '
 	test_commit init
 '
 
-test_expect_failure 'rev-parse --git-common-dir on main worktree' '
+test_expect_success 'rev-parse --git-common-dir on main worktree' '
 	git rev-parse --git-common-dir >actual &&
 	echo .git >expected &&
 	test_cmp expected actual &&
@@ -18,7 +18,7 @@ test_expect_failure 'rev-parse --git-common-dir on main worktree' '
 	test_cmp expected2 actual2
 '
 
-test_expect_failure 'rev-parse --git-path objects linked worktree' '
+test_expect_success 'rev-parse --git-path objects linked worktree' '
 	echo "$(git rev-parse --show-toplevel)/.git/objects" >expect &&
 	test_when_finished "rm -rf linked-tree && git worktree prune" &&
 	git worktree add --detach linked-tree master &&
-- 
2.11.1.windows.1
