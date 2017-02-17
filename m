Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8652F20136
	for <e@80x24.org>; Fri, 17 Feb 2017 16:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934257AbdBQQ7J (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 11:59:09 -0500
Received: from mout.gmx.net ([212.227.17.20]:56216 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934122AbdBQQ7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 11:59:08 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIzGn-1cggcI1kgj-002Vgq; Fri, 17
 Feb 2017 17:59:03 +0100
Date:   Fri, 17 Feb 2017 17:59:02 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Michael Rappazzo <rappazzo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 1/2] rev-parse tests: add tests executed from a
 subdirectory
In-Reply-To: <cover.1487350582.git.johannes.schindelin@gmx.de>
Message-ID: <471f711137c41073e34d8e9ee562fefe95715842.1487350582.git.johannes.schindelin@gmx.de>
References: <cover.1486740772.git.johannes.schindelin@gmx.de> <cover.1487350582.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6lwB/4ahZp249XbFG58RJx3BPP6pJUa+s12JyT2dexTCsjkJhio
 OWJSx/gbJWlJuPvvrrUIpB423BQPlvphCYPnH/AY3wmOGvQFNz3M6TpzH37EzyA+C0o/2R6
 5x38M6FdB2VNK30SPWHsDMNwQftftpY+hD9crAYLqB738kahyptk27Y+fBo4QKoWkY06Vja
 812wD15CFkWNs7JHkuARQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bOacCq4+aO0=:Ae8a9Q9GZcIMJcnKJ1bkeZ
 1nuzns1WLxwpxq1+BANIED4fghB/ylSFfrXRUPipn1UCQmX5MrB5QJg5beFWlXK9pBlRtnHXo
 YqdTQ37gSUg7vjz3hAOUFnqoKkkjUBpGQ0xI1UZWHWVOENwhJdLiRrTJtz3iVtlQqmKChqNLX
 LZPIiognQ3AcEAhYvt+wx+rFQqFZXE8+Zb4J0i4MhGCz6fcMtZVSb4MNJ/lYejyiipa96Cy+P
 sFNpF6XGbbpXxzjLN1wjktrdkd+ttixcC9MPpwaKVhTpZHScgQWd/baL30JQupMbgyRpJh7sT
 3JGbDX16HLhazRl3WBQhuadN3/K6pcgWNXto/J4tD7krjAFERSH92vmDO+SBBvreevL/gPWTC
 tycJt4zjsKED2yWbiFDWtq3gaPBLHgb211E6qUzUtN/ACmlZKOtsNehLc06XH8x6/ybQtXDJl
 MWvemRDhk0hfA3VQuAB3UDMLKdaHGvdrVn9bC9wQJ9ii0f6c1dQliz+8jqQAODNZCrN7Ygqlu
 NWwlY1iE+Wd1TZJwb9GEZZacxfW/4PA1Mwd5d2uqiRYeDpuH7ImFNxdSNCE38SDfzA6Dd4rL+
 jNIdlr7xKgx1OZtTw9ID+tSMuDKj289J6moj/qfWa02w9EqwjziL/SjwSRP4oIVsnGkrir6GO
 uLjm7JBsl42gbvcepnNV2Wh899pbqLhDkLmbIHyVNBnR0EEY3NwBNlBan3hTgtj28NuAYnARh
 Yrob/QpkZ6gdVDfMt0BFCZTwLYvWvp7p5HgzrTpsdwg2BI2OmAtv1iPo3tFrZZ6iw4hr6Wgtc
 5WjdJE4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Rappazzo <rappazzo@gmail.com>

t2027-worktree-list has an incorrect expectation for --git-common-dir
which has been adjusted and marked to expect failure.

Some of the tests added have been marked to expect failure.  These
demonstrate a problem with the way that some options to git rev-parse
behave when executed from a subdirectory of the main worktree.

[jes: fixed incorrect assumption that objects/ lives in the
worktree-specific git-dir (it lives in the common dir instead). Also
adjusted t1700 so that the test case does not *need* to be the last
one in that script.]

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1500-rev-parse.sh     | 28 ++++++++++++++++++++++++++++
 t/t1700-split-index.sh   | 16 ++++++++++++++++
 t/t2027-worktree-list.sh | 12 ++++++++++--
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 038e24c4014..f39f783f2db 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -87,4 +87,32 @@ test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=../repo.git, core.bare = tru
 
 test_rev_parse -C work -g ../repo.git -b u 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
+test_expect_success 'git-common-dir from worktree root' '
+	echo .git >expect &&
+	git rev-parse --git-common-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git-common-dir inside sub-dir' '
+	mkdir -p path/to/child &&
+	test_when_finished "rm -rf path" &&
+	echo "$(git -C path/to/child rev-parse --show-cdup).git" >expect &&
+	git -C path/to/child rev-parse --git-common-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-path from worktree root' '
+	echo .git/objects >expect &&
+	git rev-parse --git-path objects >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git-path inside sub-dir' '
+	mkdir -p path/to/child &&
+	test_when_finished "rm -rf path" &&
+	echo "$(git -C path/to/child rev-parse --show-cdup).git/objects" >expect &&
+	git -C path/to/child rev-parse --git-path objects >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 292a0720fcc..b754865a618 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -200,4 +200,20 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_failure 'rev-parse --shared-index-path' '
+	test_create_repo split-index &&
+	(
+		cd split-index &&
+		git update-index --split-index &&
+		echo .git/sharedindex* >expect &&
+		git rev-parse --shared-index-path >actual &&
+		test_cmp expect actual &&
+		mkdir subdirectory &&
+		cd subdirectory &&
+		echo ../.git/sharedindex* >expect &&
+		git rev-parse --shared-index-path >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 465eeeacd3d..c1a072348e7 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -8,16 +8,24 @@ test_expect_success 'setup' '
 	test_commit init
 '
 
-test_expect_success 'rev-parse --git-common-dir on main worktree' '
+test_expect_failure 'rev-parse --git-common-dir on main worktree' '
 	git rev-parse --git-common-dir >actual &&
 	echo .git >expected &&
 	test_cmp expected actual &&
 	mkdir sub &&
 	git -C sub rev-parse --git-common-dir >actual2 &&
-	echo sub/.git >expected2 &&
+	echo ../.git >expected2 &&
 	test_cmp expected2 actual2
 '
 
+test_expect_failure 'rev-parse --git-path objects linked worktree' '
+	echo "$(git rev-parse --show-toplevel)/.git/objects" >expect &&
+	test_when_finished "rm -rf linked-tree && git worktree prune" &&
+	git worktree add --detach linked-tree master &&
+	git -C linked-tree rev-parse --git-path objects >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '"list" all worktrees from main' '
 	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
 	test_when_finished "rm -rf here && git worktree prune" &&
-- 
2.11.1.windows.1.2.g87ad093.dirty


