Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EFBE20248
	for <e@80x24.org>; Thu, 21 Mar 2019 06:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfCUGxj (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 02:53:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43270 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUGxj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 02:53:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so3679284pfd.10
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 23:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mff12IhHoZXXATxNndLLdglamFr2iAvA99KSpaoPafY=;
        b=G5Dhn4zfQoJYtLWtk/eGJC1jRmWykHzaWghAg41v5S7Sjml7BP6F+eTfwGrKv9K5Do
         gNmZ1OWXE2skipii3n3ZjRgSqF02pGQrQy/1DW5QbEX/1QOo+FpZHr3Jsugjb7oBRz3b
         jGEddi5+s4AiElIpfCN8BI8qGZiSu9w9ULNT+zmkWArMfYwKyqEoaFdVKpPc9RTiNz44
         EL4T87NkBu6ieRrnUa1Y62Ae3lcV4Pthl3MMkKP6i19O/956IoGo6eOzIql+nRClSdnY
         f5QeQTn2IUXg0WTG3MaFWUPzFrMx27HR+oAvUJDdivD4uZSffB2RNCgI8KJAgWxIZ+o4
         ddJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mff12IhHoZXXATxNndLLdglamFr2iAvA99KSpaoPafY=;
        b=W8dlvaoNuY2cuBAm5Fp1mUI/sIWHG9dU8R/6EkPgp1U2i9lZx++o7XHZCtRBjyNScJ
         N6ZQG3j9KCpOVQjCUrBalP9vzCFUuktl4ppDHiTSi5Tl0ul9h3X4Ficao3HDrDDein3g
         42Gd1a79SYq4RG8Tk6cpG1gz0Ayt8rmMUDjw3SCSjbskr7/i7CWbNY7KplMC6XZmzmcS
         um7G0nmJkea3MLuq6pU8Sr5/8kdCjr2h42trpurdr2Ky3gHYKib5JP7Vyuv6Cxz8TRvC
         ocx4Yyrj4HJxlSBMJoi0XDgyFE27jT1qETjScuuXZnfB3KqncPrITQV+/ReC6ch1QIcQ
         QB3Q==
X-Gm-Message-State: APjAAAUObJ0HvpZXz0Ns7TXzvTo6UhJmUoDlTdfNm0pD9fP+vQYZeKd+
        oBK7yVFC7GFk8RIJFTXj8NKqr3D2UvA=
X-Google-Smtp-Source: APXvYqzIlmzP4KQRDlCTFRJ85wt8yjGo3cDbUTj1kgc2XIdI4A25pW2YKMtdP/Lzrv4OiCTW3JfLCg==
X-Received: by 2002:a17:902:8b83:: with SMTP id ay3mr1881511plb.1.1553151217426;
        Wed, 20 Mar 2019 23:53:37 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id e184sm6266868pfc.143.2019.03.20.23.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 23:53:36 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:53:34 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v9 00/11] Fix scissors bug during conflict
Message-ID: <cover.1553150827.git.liu.denton@gmail.com>
References: <cover.1552817044.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552817044.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks again for the reviews, everyone.

We're slowly making it there ;)



Previous discussion on the cherry-pick/revert changes can be found here[1].

Changes since revert/cherry-pick v3:

* Rebased on top of latest master
* Reordered and squashed patches
* Added populate_opts_cb and save_opts to save default_msg_cleanup at Phillip's suggestion

Changes since v7:

* Cleaned up more tests according to Eric's advice (and added some more cleanup patches!)
* Clarify meaning of "passed on" in documentation
* Consolidate common options into OPT_CLEANUP macro in parse-options.h
* Fix space indent to tabs in sequencer.c
* Shorten variable names for readability
* Make comment about 0th element in array being default more assertive
* Remove unnecessary braces around if/for statements
* Lowercase warning/error messages
* Unmark BUG messages for translation
* Rename get_config_from_cleanup -> describe_cleanup_mode
* Change PARSE_OPT_NOARG to 0 for --cleanup in git-pull
* Squashed in Ramsay's static patch

Changes since v8:

* More test cleanup
* Changed Reviewed-by: to Helped-by: in commit messages
* Check validity of --cleanup arg in git-pull
* Revised documentation to make "passed on" more clear (I hope!)
* Restore merge message to original text in the case of non-scissors

[1]: https://public-inbox.org/git/cover.1551867827.git.liu.denton@gmail.com/T/#u


Denton Liu (11):
  t7600: clean up style
  t3507: clean up style
  t7604: clean up style
  t7502: clean up style
  commit: extract cleanup_mode functions to sequencer
  parse-options.h: extract common --cleanup option
  sequencer.c: remove duplicate code
  merge: cleanup messages like commit
  merge: add scissors line on merge conflict
  sequencer.c: define describe_cleanup_mode
  cherry-pick/revert: add scissors line on merge conflict

 Documentation/git-cherry-pick.txt |   7 ++
 Documentation/git-revert.txt      |   7 ++
 Documentation/merge-options.txt   |   7 ++
 builtin/commit.c                  |  47 +++++------
 builtin/merge.c                   |  44 ++++++++--
 builtin/pull.c                    |  23 ++++++
 builtin/rebase--interactive.c     |   2 +-
 builtin/revert.c                  |   5 ++
 builtin/tag.c                     |   3 +-
 parse-options.h                   |   1 +
 sequencer.c                       |  97 +++++++++++++++++-----
 sequencer.h                       |   9 ++-
 t/t3507-cherry-pick-conflict.sh   | 128 +++++++++++++++++++++++++-----
 t/t5521-pull-options.sh           |   8 ++
 t/t7502-commit-porcelain.sh       |  93 ++++++++++++----------
 t/t7600-merge.sh                  |  73 +++++++++++++----
 t/t7604-merge-custom-message.sh   |  75 +++++++++++++++--
 wt-status.c                       |  12 ++-
 wt-status.h                       |   1 +
 19 files changed, 500 insertions(+), 142 deletions(-)

Interdiff against v8:
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 2601e1868e..cbb663a843 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -59,10 +59,10 @@ OPTIONS
 
 --cleanup=<mode>::
 	This option determines how the commit message will be cleaned up before
-	being passed on. See linkgit:git-commit[1] for more details. In
-	particular, if the '<mode>' is given a value of `scissors`, scissors
-	will be appended to `MERGE_MSG` before being passed on to the commit
-	machinery in the case of a conflict.
+	being passed on to the commit machinery. See linkgit:git-commit[1] for more
+	details. In particular, if the '<mode>' is given a value of `scissors`,
+	scissors will be appended to `MERGE_MSG` before being passed on in the case
+	of a conflict.
 
 -x::
 	When recording the commit, append a line that says
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index cabeb9df2c..7fd254df92 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -68,10 +68,10 @@ more details.
 
 --cleanup=<mode>::
 	This option determines how the commit message will be cleaned up before
-	being passed on. See linkgit:git-commit[1] for more details. In
-	particular, if the '<mode>' is given a value of `scissors`, scissors
-	will be appended to `MERGE_MSG` before being passed on to the commit
-	machinery in the case of a conflict.
+	being passed on to the commit machinery. See linkgit:git-commit[1] for more
+	details. In particular, if the '<mode>' is given a value of `scissors`,
+	scissors will be appended to `MERGE_MSG` before being passed on in the case
+	of a conflict.
 
 -n::
 --no-commit::
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 405e16c617..61876dbc33 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -33,11 +33,11 @@ updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
 set to `no` at the beginning of them.
 
 --cleanup=<mode>::
-	This option determines how the merge message will be cleaned up
-	before commiting or being passed on. See linkgit:git-commit[1] for more
-	details. In addition, if the '<mode>' is given a value of `scissors`,
-	scissors will be appended to `MERGE_MSG` before being passed on to the
-	commit machinery in the case of a merge conflict.
+	This option determines how the merge message will be cleaned up before
+	commiting. See linkgit:git-commit[1] for more details. In addition, if
+	the '<mode>' is given a value of `scissors`, scissors will be appended
+	to `MERGE_MSG` before being passed on to the commit machinery in the
+	case of a merge conflict.
 
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
diff --git a/builtin/merge.c b/builtin/merge.c
index 90c64346e9..235cd3b2e1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -804,14 +804,17 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
 	exit(1);
 }
 
-static const char comment_line_explanation[] =
-N_("Lines starting with '%c' will be ignored.\n");
-
 static const char merge_editor_comment[] =
 N_("Please enter a commit message to explain why this merge is necessary,\n"
    "especially if it merges an updated upstream into a topic branch.\n"
-   "\n"
-   "An empty message aborts the commit.\n");
+   "\n");
+
+static const char scissors_editor_comment[] =
+N_("An empty message aborts the commit.\n");
+
+static const char no_scissors_editor_comment[] =
+N_("Lines starting with '%c' will be ignored, and an empty message aborts\n"
+   "the commit.\n");
 
 static void write_merge_heads(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
@@ -824,11 +827,12 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		strbuf_addch(&msg, '\n');
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
 			wt_status_append_cut_line(&msg);
-		else
-			strbuf_commented_addf(&msg, _(comment_line_explanation), comment_line_char);
 
 		strbuf_commented_addf(&msg, "\n");
 		strbuf_commented_addf(&msg, _(merge_editor_comment));
+		strbuf_commented_addf(&msg, _(cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS ?
+			scissors_editor_comment :
+			no_scissors_editor_comment), comment_line_char);
 	}
 	if (signoff)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
diff --git a/builtin/pull.c b/builtin/pull.c
index 292c1dac27..55ebb5808e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -24,6 +24,7 @@
 #include "lockfile.h"
 #include "wt-status.h"
 #include "commit-reach.h"
+#include "sequencer.h"
 
 enum rebase_type {
 	REBASE_INVALID = -1,
@@ -881,6 +882,22 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
+	if (opt_cleanup) {
+		const char *prefix = "--cleanup=";
+		const char *cleanup_arg;
+
+		if (strncmp(opt_cleanup, prefix, strlen(prefix)))
+			BUG("expecting prefix %s, argument is %s", prefix, opt_cleanup);
+
+		cleanup_arg = &opt_cleanup[strlen(prefix)];
+
+		/*
+		 * this only checks the validity of cleanup_arg; we don't need
+		 * a valid value for use_editor
+		 */
+		get_cleanup_mode(cleanup_arg, 0, 1);
+	}
+
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
 	if (!opt_ff)
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index c3894ca9d6..a584b11c98 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -180,7 +180,7 @@ test_expect_success 'failed cherry-pick registers participants in index' '
 		1 s/ 0	/ 1	/
 		2 s/ 0	/ 2	/
 		3 s/ 0	/ 3	/
-	" <stages >expected &&
+	" stages >expected &&
 	git read-tree -u --reset HEAD &&
 
 	test_must_fail git cherry-pick picked &&
@@ -286,7 +286,7 @@ test_expect_success 'revert also handles conflicts sanely' '
 		1 s/ 0	/ 1	/
 		2 s/ 0	/ 2	/
 		3 s/ 0	/ 3	/
-	" <stages >expected-stages &&
+	" stages >expected-stages &&
 	git read-tree -u --reset HEAD &&
 
 	head=$(git rev-parse HEAD) &&
@@ -431,7 +431,7 @@ test_expect_success 'commit after failed cherry-pick does not add duplicated -s'
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s picked-signed &&
 	git commit -a -s &&
-	test $(git show -s |grep -c "Signed-off-by") = 1
+	test $(git show -s >tmp && grep -c "Signed-off-by" tmp && rm tmp) = 1
 '
 
 test_expect_success 'commit after failed cherry-pick adds -s at the right place' '
@@ -445,7 +445,7 @@ test_expect_success 'commit after failed cherry-pick adds -s at the right place'
 	Signed-off-by: C O Mitter <committer@example.com>
 	# Conflicts:
 	EOF
-	grep -e "^# Conflicts:" -e '^Signed-off-by' <.git/COMMIT_EDITMSG >actual &&
+	grep -e "^# Conflicts:" -e '^Signed-off-by' .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual &&
 
 	cat <<-\EOF >expected &&
@@ -464,7 +464,7 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
 
 	# emulate old-style conflicts block
 	mv .git/MERGE_MSG .git/MERGE_MSG+ &&
-	sed -e "/^# Conflicts:/,\$s/^# *//" <.git/MERGE_MSG+ >.git/MERGE_MSG &&
+	sed -e "/^# Conflicts:/,\$s/^# *//" .git/MERGE_MSG+ >.git/MERGE_MSG &&
 
 	git commit -a &&
 	git commit --amend -s &&
@@ -474,7 +474,7 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
 	Signed-off-by: C O Mitter <committer@example.com>
 	Conflicts:
 	EOF
-	grep -e "^Conflicts:" -e '^Signed-off-by' <.git/COMMIT_EDITMSG >actual &&
+	grep -e "^Conflicts:" -e '^Signed-off-by' .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index c19d8dbc9d..ccde8ba491 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -77,6 +77,14 @@ test_expect_success 'git pull -q -v' '
 	test_must_be_empty out &&
 	test -s err)
 '
+test_expect_success 'git pull --cleanup errors early on invalid argument' '
+	mkdir clonedcleanup &&
+	(cd clonedcleanup && git init &&
+	test_must_fail git pull --cleanup invalid "../parent" >out 2>err &&
+	test_must_be_empty out &&
+	test -s err)
+'
+
 
 test_expect_success 'git pull --force' '
 	mkdir clonedoldstyle &&
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index f035e4a507..5733d9cd34 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -16,9 +16,8 @@ commit_msg_is () {
 # Arguments: [<prefix] [<commit message>] [<commit options>]
 check_summary_oneline() {
 	test_tick &&
-	git commit ${3+"$3"} -m "$2" >act &&
-	head -1 <act >tmp &&
-	mv tmp act &&
+	git commit ${3+"$3"} -m "$2" >raw &&
+	head -n 1 raw >act &&
 
 	# branch name
 	SUMMARY_PREFIX="$(git name-rev --name-only HEAD)" &&
@@ -144,9 +143,11 @@ test_expect_success 'sign off' '
 	>positive &&
 	git add positive &&
 	git commit -s -m "thank you" &&
-	actual=$(git cat-file commit HEAD >tmp && sed -ne "s/Signed-off-by: //p" <tmp && rm tmp) &&
-	expected=$(git var GIT_COMMITTER_IDENT >tmp && sed -e "s/>.*/>/" <tmp && rm tmp) &&
-	test "z$actual" = "z$expected"
+	git cat-file commit HEAD >commit.msg &&
+	sed -ne "s/Signed-off-by: //p" commit.msg >actual &&
+	git var GIT_COMMITTER_IDENT >ident &&
+	sed -e "s/>.*/>/" ident >expected &&
+	test_cmp expected actual
 
 '
 
@@ -155,7 +156,7 @@ test_expect_success 'multiple -m' '
 	>negative &&
 	git add negative &&
 	git commit -m "one" -m "two" -m "three" &&
-	actual=$(git cat-file commit HEAD >tmp && sed -e "1,/^\$/d" <tmp && rm tmp) &&
+	actual=$(git cat-file commit HEAD >tmp && sed -e "1,/^\$/d" tmp && rm tmp) &&
 	expected=$(test_write_lines "one" "" "two" "" "three") &&
 	test "z$actual" = "z$expected"
 
@@ -165,9 +166,8 @@ test_expect_success 'verbose' '
 
 	echo minus >negative &&
 	git add negative &&
-	git status -v >actual &&
-	sed -ne "/^diff --git /p" <actual >tmp &&
-	mv tmp actual &&
+	git status -v >raw &&
+	sed -ne "/^diff --git /p" raw >actual &&
 	echo "diff --git a/negative b/negative" >expect &&
 	test_cmp expect actual
 
@@ -193,9 +193,8 @@ test_expect_success 'cleanup commit messages (verbatim option,-t)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim --no-status -t expect -a &&
-	git cat-file -p HEAD >actual &&
-	sed -e "1,/^\$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -204,9 +203,8 @@ test_expect_success 'cleanup commit messages (verbatim option,-F)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -F expect -a &&
-	git cat-file -p HEAD >actual &&
-	sed -e "1,/^\$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -215,9 +213,8 @@ test_expect_success 'cleanup commit messages (verbatim option,-m)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -m "$mesg_with_comment_and_newlines" -a &&
-	git cat-file -p HEAD >actual &&
-	sed -e "1,/^\$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -228,9 +225,8 @@ test_expect_success 'cleanup commit messages (whitespace option,-F)' '
 	test_write_lines "" "# text" "" >text &&
 	echo "# text" >expect &&
 	git commit --cleanup=whitespace -F text -a &&
-	git cat-file -p HEAD >actual &&
-	sed -e "1,/^\$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -257,9 +253,8 @@ test_expect_success 'cleanup commit messages (scissors option,-F,-e)' '
 	# to be kept, too
 	EOF
 	git commit --cleanup=scissors -e -F text -a &&
-	git cat-file -p HEAD >actual &&
-	sed -e "1,/^\$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 '
 
@@ -271,9 +266,8 @@ test_expect_success 'cleanup commit messages (scissors option,-F,-e, scissors on
 	to be removed
 	EOF
 	git commit --cleanup=scissors -e -F text -a --allow-empty-message &&
-	git cat-file -p HEAD >actual &&
-	sed -e "1,/^\$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_must_be_empty actual
 '
 
@@ -283,9 +277,8 @@ test_expect_success 'cleanup commit messages (strip option,-F)' '
 	test_write_lines "" "# text" "sample" "" >text &&
 	echo sample >expect &&
 	git commit --cleanup=strip -F text -a &&
-	git cat-file -p HEAD >actual &&
-	sed -e "1,/^\$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -489,9 +482,8 @@ test_expect_success 'Hand committing of a redundant merge removes dups' '
 	test_must_fail git merge second master &&
 	git checkout master g &&
 	EDITOR=: git commit -a &&
-	git cat-file commit HEAD >actual &&
-	sed -n -e "s/^parent //p" -e "/^$/q" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file commit HEAD >raw &&
+	sed -n -e "s/^parent //p" -e "/^$/q" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -500,9 +492,8 @@ test_expect_success 'A single-liner subject with a token plus colon is not a foo
 
 	git reset --hard &&
 	git commit -s -m "hello: kitty" --allow-empty &&
-	git cat-file commit HEAD >actual &&
-	sed -e "1,/^$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_line_count = 3 actual
 
 '
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index ed11b08db2..7f9c68cbe7 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -241,9 +241,8 @@ test_expect_success 'merge --squash c3 with c7' '
 	# Conflicts:
 	#	file
 	EOF
-	git cat-file commit HEAD >actual &&
-	sed -e '1,/^$/d' <actual >tmp &&
-	mv tmp actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e '1,/^$/d' raw >actual &&
 	test_cmp expect actual
 '
 
@@ -264,9 +263,8 @@ test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
 	# Conflicts:
 	#	file
 	EOF
-	git cat-file commit HEAD >actual &&
-	sed -e '1,/^$/d' <actual >tmp &&
-	mv tmp actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e '1,/^$/d' raw >actual &&
 	test_i18ncmp expect actual
 '
 
@@ -289,9 +287,8 @@ test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
 	# Conflicts:
 	#	file
 	EOF
-	git cat-file commit HEAD >actual &&
-	sed -e '1,/^$/d' <actual >tmp &&
-	mv tmp actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e '1,/^$/d' raw >actual &&
 	test_i18ncmp expect actual
 '
 
@@ -728,10 +725,10 @@ cat >editor <<\EOF
 (
 	echo "Merge work done on the side branch c1"
 	echo
-	cat <"$1"
+	cat "$1"
 ) >"$1.tmp" && mv "$1.tmp" "$1"
 # strip comments and blank lines from end of message
-sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' >expected
+sed -e '/^#/d' "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' >expected
 EOF
 chmod 755 editor
 
@@ -816,14 +813,14 @@ test_expect_success 'set up mod-256 conflict scenario' '
 	git commit -m base &&
 
 	# one side changes the first line of each to "master"
-	sed s/-1/-master/ <file >tmp &&
+	sed s/-1/-master/ file >tmp &&
 	mv tmp file &&
 	git commit -am master &&
 
 	# and the other to "side"; merging the two will
 	# yield 256 separate conflicts
 	git checkout -b side HEAD^ &&
-	sed s/-1/-side/ <file >tmp &&
+	sed s/-1/-side/ file >tmp &&
 	mv tmp file &&
 	git commit -am side
 '
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index c9685a318d..cd4f9607dc 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -16,16 +16,16 @@ create_merge_msgs() {
 }
 
 test_expect_success 'setup' '
-	echo c0 > c0.c &&
+	echo c0 >c0.c &&
 	git add c0.c &&
 	git commit -m c0 &&
 	git tag c0 &&
-	echo c1 > c1.c &&
+	echo c1 >c1.c &&
 	git add c1.c &&
 	git commit -m c1 &&
 	git tag c1 &&
 	git reset --hard c0 &&
-	echo c2 > c2.c &&
+	echo c2 >c2.c &&
 	git add c2.c &&
 	git commit -m c2 &&
 	git tag c2 &&
@@ -36,18 +36,16 @@ test_expect_success 'setup' '
 test_expect_success 'merge c2 with a custom message' '
 	git reset --hard c1 &&
 	git merge -m "$(cat exp.subject)" c2 &&
-	git cat-file commit HEAD >actual &&
-	sed -e "1,/^$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_cmp exp.subject actual
 '
 
 test_expect_success 'merge --log appends to custom message' '
 	git reset --hard c1 &&
 	git merge --log -m "$(cat exp.subject)" c2 &&
-	git cat-file commit HEAD >actual &&
-	sed -e "1,/^$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_cmp exp.log actual
 '
 
@@ -63,9 +61,8 @@ test_expect_success 'prepare file with comment line and trailing newlines'  '
 test_expect_success 'cleanup commit messages (verbatim option)' '
 	git reset --hard c1 &&
 	git merge --cleanup=verbatim -F expect c2 &&
-	git cat-file commit HEAD >actual &&
-	sed -e "1,/^$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_cmp expect actual
 '
 
@@ -74,9 +71,8 @@ test_expect_success 'cleanup commit messages (whitespace option)' '
 	test_write_lines "" "# text" "" >text &&
 	echo "# text" >expect &&
 	git merge --cleanup=whitespace -F text c2 &&
-	git cat-file commit HEAD >actual &&
-	sed -e "1,/^$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_cmp expect actual
 '
 
@@ -101,9 +97,8 @@ test_expect_success 'cleanup merge messages (scissors option)' '
 	# to be kept, too
 	EOF
 	git merge --cleanup=scissors -e -F text c2 &&
-	git cat-file commit HEAD >actual &&
-	sed -e "1,/^$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_cmp expect actual
 '
 
@@ -112,9 +107,8 @@ test_expect_success 'cleanup commit messages (strip option)' '
 	test_write_lines "" "# text" "sample" "" >text &&
 	echo sample >expect &&
 	git merge --cleanup=strip -F text c2 &&
-	git cat-file commit HEAD >actual &&
-	sed -e "1,/^$/d" <actual >tmp &&
-	mv tmp actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_cmp expect actual
 '
 
-- 
2.21.0.512.g57bf1b23e1

