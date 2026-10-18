Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078E494267
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792348048; cv=none; b=ksf1FHKlE/uC3Amq3r4RGuvwM5aNwaTR+aLJ3k5kwfP00Hqe2dVJMkVxy41wkrop6mnTAoflM7gZa2M3S/LtlN48glhGjNS6JigU54VMx0v71LPaOWAkgbY4elSw3nTaXq2+Kk6jBOyxoDdO1GkvFvq/TBNxhKFJrcdQnmeFvH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792348048; c=relaxed/simple;
	bh=sU9/TeoQnUM4OwUKjbjoPnXnfOgvmuTAuRR08Qcm/CY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P4US+qE4x7b0EfhvFV6qnRGb7hCS7V4ZYoLOPrKhAQbd+umyKlLugjZkOPXIfvJ7FFZ4KYcuaRU9CGZVBPqVTS2sa2cHR2gyJwiT4GilQoZSL/jIPf+Eubob321zGthR1ZZnRll/nCvq/5JrS/ccOAy5kbCh48STnmwlZT/RGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo12vgEf; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo12vgEf"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35f036b17easo3347052eec.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792348039; x=1792952839; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mf6dSrj9qunmKcoa/CAYyy3JRhvmv9wXNDFKFrwpvkA=;
        b=fo12vgEfF/6vw5EWP4WocMEYRqMiaNNIBnd9CityMHqlX3GADloAp+P7BqZS0mRIa1
         OkS0aD8yHdGowJEacsMJXhItpGMOKXdrLY8qaOytWiQ4WN07FoZ/4z4LDrQnyfZNTwD2
         aGAiT+Bokq5HwNUThplmRm1+6rl0tDlJVdt/xGVRzEV6uN8tSMeCItTrv0XmlFhNjT5j
         FXAjy7WOLbusPWF6fzb19lCuCIiKebLFHFOKcnnxjonfsEXb3ye4iqm2gIR/NhxaNIai
         1EF++Mclh1QFQ4fHCiciUo9DfCaZ9iiZNE0dzE9r5imCCdkkZJc0indbYB+alK24g3CZ
         RHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792348039; x=1792952839;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mf6dSrj9qunmKcoa/CAYyy3JRhvmv9wXNDFKFrwpvkA=;
        b=VwNv/EWIfooNchDoreJHXPtlsfTG6NqSJha5clsDJSSD1kzYtA4cLvuBSd93oLKGIV
         L5Sj5urFlCbwVx26HpCFFOisSDQ/uPrprEH1SKpSfsXj9TM6PYMDbtZmhZ8M39D0/Y2r
         j92834BNoGsdraU0pIpBgWa28My9A+1foYZKY956ci8RK6E+jywZtYMK+U1AT0u/BTzw
         vmU9+oz8EaOIwl+QPQN8flgbWBR8rXFYbHf0c+090xCzSq3Cr8g+EfTVZfssueKFhCo2
         8r2Wv/v6y3YGepvrLZigMc2MUVHOjuLqQVCvS5DZ+iARIOj/ndVa3VANbg28sRyhM0w1
         eGWw==
X-Gm-Message-State: AFq9FYJvkpOuLpobYGdS6rRgXid18s9cIVoHXEsw3exWAZTTtrIRFpVT
	KLJVCTItWEIP/eZTUy+BQI7kYkg9YcTgd4yRvd7si4zxfBml18Wp3eyQ/fkD+A==
X-Gm-Gg: AYBFou3ehbDxyVfMdCgACu2wi7mbfepu7HEPj+09Sbsy2zJ6GNBYMmFeHA4YxgI184X
	DaYX613+0zqjlXMWH34gdw++Sgl3knwX2C6vOU9VRvtm/7jbKh9a34I+F6s+Whb3bPevRPg/1+1
	9VxlmACfmM9CFYbjGAbScSvtJcxXzJJ8TMpgl1p+gagHozDskC3fZOEvvpGDch1yDrHarH8Zler
	mdoqopfaeVejTQI9egshGrmbXatfuyFSStL8rOexspu0zhMtUvdFVXH46oIUW3Mj7Qn2YgzvGCx
	btFkDoc1QO7RJXeZLHcjwv+EQOUgm5PzYl+n6+fjsYr15JO8WDSe3s2mlF6+yJGYeuBN4yU40sz
	oMo435xTW5k3T/syLGCaCWQn72DDsTN+cIBImHI8VpEt1z2qwhvhXv3D0iXDkc2RVdsi864nfFB
	9hmyarq4r/nWP+E4+sUQzUqr9ITrorGZn9US8pteujdrjz5zVEVERVjmjLYE4wxJcdvhFUzOI20
	KZuVN+057J4
X-Received: by 2002:a05:7301:1748:b0:350:2a5c:56c with SMTP id 5a478bee46e88-361a1862b4dmr7464662eec.20.1792348039306;
        Sun, 18 Oct 2026 11:27:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.179.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a79c7sm25213181eec.18.2026.10.18.11.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 11:27:18 -0700 (PDT)
Message-Id: <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 18:27:14 +0000
Subject: [PATCH v2 0/3] reflog: add --operations and --historical-branch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Create a better reflog. Follows the discussion in
https://lore.kernel.org/git/akZfm-igZKeHaDST@pks.im/.

"git reflog" lists every step of a rebase and every branch switch, which
makes it hard to see what was done and on which branch. This adds two
options to "git reflog" and "git log -g":

 * --operations shows one entry per command, folding a rebase into the entry
   that finished or aborted it, and leaves out entries that change no
   branch.
 * --historical-branch decorates each entry with the branch HEAD was on when
   it was recorded.

Changes in v2:

 * Move the "historical branch" rightward in the display for cleaner
   alignment.
 * Improve commit messages.

Harald Nordgren (3):
  reflog: name the strings that mark switches, renames and rebase steps
  reflog: add --operations to show one entry per command
  reflog: add --historical-branch to name the branch of each entry

 Documentation/git-reflog.adoc       |   4 +
 Documentation/rev-list-options.adoc |  21 +++
 builtin/branch.c                    |   3 +-
 builtin/checkout.c                  |   3 +-
 builtin/rebase.c                    |  17 +--
 log-tree.c                          |  28 +++-
 object-name.c                       |   3 +-
 reflog-walk.c                       | 183 +++++++++++++++++++++++--
 reflog-walk.h                       |   6 +-
 reflog.h                            |   6 +
 revision.c                          |  14 ++
 revision.h                          |   2 +
 sequencer.c                         |  13 +-
 t/t1414-reflog-walk.sh              | 198 ++++++++++++++++++++++++++++
 wt-status.c                         |   3 +-
 15 files changed, 471 insertions(+), 33 deletions(-)


base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2448%2FHaraldNordgren%2Freflog-operations-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2448/HaraldNordgren/reflog-operations-v2
Pull-Request: https://github.com/git/git/pull/2448

Range-diff vs v1:

 1:  d95ed5bd67 ! 1:  745929bd80 reflog: name the strings that mark switches, renames and rebase steps
     @@ Metadata
       ## Commit message ##
          reflog: name the strings that mark switches, renames and rebase steps
      
     -    "git checkout" records a move of HEAD in the reflog as "checkout:
     -    moving from <old> to <new>", "git branch -m" records a rename of the
     -    current branch as "Branch: renamed <old> to <new>", and "git rebase"
     -    marks where it starts and ends with steps like "rebase (start)" and
     -    "rebase (finish)". "@{-<n>}" and "git status" read the switch message
     -    back, each with its own copy of the prefix, and a later commit adds a
     -    reader for all of them.
     +    The next commit adds "git reflog --operations", which finds branch
     +    switches, branch renames and the start and end of a rebase by the
     +    messages they leave in the reflog. The commands that write these
     +    messages spell out the strings by hand, and "@{-<n>}" and "git status"
     +    each keep their own copy of the switch prefix to read it back. Reading
     +    them in one more place would add yet another copy that has to stay in
     +    sync.
      
     -    Name these strings in reflog.h and use them where the messages are
     -    written and read, so they cannot drift apart.
     +    Name the strings once in reflog.h and use the names wherever the
     +    messages are written or read: the "checkout: moving from " prefix
     +    written by "git checkout", the "Branch: renamed " prefix written by
     +    "git branch -m", and the "start", "finish" and "abort" steps written
     +    by "git rebase".
     +
     +    No change in behavior.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
 2:  579e13b36a = 2:  1c47ba225e reflog: add --operations to show one entry per command
 3:  4efe74b04e ! 3:  aa5a98b80d reflog: add --historical-branch to name the branch of each entry
     @@ Commit message
          still point at that commit, and a rebased or amended commit has none.
      
          Teach "git reflog" and "git log -g" a "--historical-branch" option
     -    that decorates each entry with the branch it was made on, in place of
     -    the refs that point at the commit now. The name is colored like a
     -    branch decoration:
     +    that shows the branch each entry was made on before its message, in
     +    place of the refs that point at the commit now. The hashes and
     +    selectors stay lined up in their columns, and the name is colored like
     +    a branch decoration:
      
            $ git reflog --historical-branch
     -      4e5f6a7 (topic) HEAD@{0}: commit: add tests
     -      1a2b3c4 (topic) HEAD@{1}: checkout: moving from main to topic
     -      8c9d0e1 (main) HEAD@{2}: commit: fix typo
     +      4e5f6a7 HEAD@{0}: (topic) commit: add tests
     +      1a2b3c4 HEAD@{1}: (topic) checkout: moving from main to topic
     +      8c9d0e1 HEAD@{2}: (main) commit: fix typo
      
          Every entry gets a name, including ones whose commits are no longer on
          any branch. Entries from before a branch was renamed show its old name,
     @@ Documentation/git-reflog.adoc: actions, and in addition the `HEAD` reflog record
       branch are left out, and a rebase is shown as a single entry instead
      -of one entry for each commit it replayed.
      +of one entry for each commit it replayed. With `--historical-branch`,
     -+each entry is decorated with the branch it was made on.
     ++each entry shows the branch it was made on before its message.
       
       The "list" subcommand lists all refs which have a corresponding reflog.
       
     @@ Documentation/rev-list-options.adoc: Under `--pretty=reference`, this informatio
       	rebase started. It is an error to use this option unless
       	`--walk-reflogs` is in use.
       
     ++ifndef::git-rev-list[]
      +`--historical-branch`::
     -+	Decorate each reflog entry with the branch `HEAD` was on when
     -+	the entry was recorded, such as `(topic)`, in place of the refs
     -+	that point at the commit now. When `HEAD` was detached, the
     -+	entry shows `(detached at <commit>)`. For the reflog of any
     -+	other ref, the name of that ref is shown. It is an error to use
     -+	this option unless `--walk-reflogs` is in use.
     ++	Show the branch `HEAD` was on when each reflog entry was
     ++	recorded, such as `(topic)`, before the reflog message, in
     ++	place of the refs that point at the commit now. When `HEAD` was
     ++	detached, the entry shows `(detached at <commit>)`. For the
     ++	reflog of any other ref, the name of that ref is shown. It is
     ++	an error to use this option unless `--walk-reflogs` is in use.
     ++endif::git-rev-list[]
      +
       `--merge`::
       	Show commits touching conflicted paths in the range `HEAD...<other>`,
     @@ log-tree.c: void format_decorations(struct strbuf *sb,
       	}
       }
       
     -+static void show_historical_branch(struct rev_info *opt)
     ++static void format_historical_branch(struct strbuf *sb,
     ++				     struct rev_info *opt)
      +{
      +	const char *branch = get_reflog_branch(opt->reflog_info);
      +	enum git_colorbool use_color = opt->diffopt.use_color;
     @@ log-tree.c: void format_decorations(struct strbuf *sb,
      +
      +	color_commit = diff_get_color(use_color, DIFF_COMMIT);
      +	color_reset = decorate_get_color(use_color, DECORATION_NONE);
     -+	fprintf(opt->diffopt.file, "%s (%s%s%s%s%s)%s",
     -+		color_commit, color_reset,
     -+		decorate_get_color(use_color, DECORATION_REF_LOCAL),
     -+		branch, color_reset, color_commit, color_reset);
     ++	strbuf_addf(sb, "%s(%s%s%s%s%s)%s ",
     ++		    color_commit, color_reset,
     ++		    decorate_get_color(use_color, DECORATION_REF_LOCAL),
     ++		    branch, color_reset, color_commit, color_reset);
      +}
      +
       void show_decorations(struct rev_info *opt, struct commit *commit)
     @@ log-tree.c: void show_decorations(struct rev_info *opt, struct commit *commit)
       		if (slot && *slot)
       			fprintf(opt->diffopt.file, "\t%s", *slot);
       	}
     -+	if (opt->historical_branch) {
     -+		show_historical_branch(opt);
     -+		return;
     -+	}
     - 	if (!opt->show_decorations)
     +-	if (!opt->show_decorations)
     ++	if (!opt->show_decorations || opt->historical_branch)
       		return;
       	format_decorations(&sb, commit, opt->diffopt.use_color, NULL);
     + 	fputs(sb.buf, opt->diffopt.file);
     +@@ log-tree.c: void show_log(struct rev_info *opt)
     + 			graph_show_oneline(opt->graph);
     + 		}
     + 		if (opt->reflog_info) {
     ++			struct strbuf branch = STRBUF_INIT;
     ++
     + 			/*
     + 			 * setup_revisions() ensures that opt->reflog_info
     + 			 * and opt->graph cannot both be set,
     + 			 * so we don't need to worry about printing the
     + 			 * graph info here.
     + 			 */
     ++			if (opt->historical_branch)
     ++				format_historical_branch(&branch, opt);
     + 			show_reflog_message(opt->reflog_info,
     + 					    opt->commit_format == CMIT_FMT_ONELINE,
     + 					    opt->date_mode,
     +-					    opt->date_mode_explicit);
     ++					    opt->date_mode_explicit,
     ++					    branch.buf);
     ++			strbuf_release(&branch);
     + 			if (opt->commit_format == CMIT_FMT_ONELINE)
     + 				return;
     + 		}
      
       ## reflog-walk.c ##
      @@
     @@ reflog-walk.c: void get_reflog_message(struct strbuf *sb,
       const char *get_reflog_ident(struct reflog_walk_info *reflog_info)
       {
       	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
     +@@ reflog-walk.c: timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info)
     + }
     + 
     + void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
     +-			 struct date_mode dmode, int force_date)
     ++			 struct date_mode dmode, int force_date,
     ++			 const char *branch)
     + {
     + 	if (reflog_info && reflog_info->last_commit_reflog) {
     + 		struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
     +@@ reflog-walk.c: void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
     + 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
     + 		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
     + 		if (oneline) {
     +-			printf("%s: %s", selector.buf, info->message);
     ++			printf("%s: %s%s", selector.buf, branch,
     ++			       info->message);
     + 		}
     + 		else {
     +-			printf("Reflog: %s (%s)\nReflog message: %s",
     +-			       selector.buf, info->email, info->message);
     ++			printf("Reflog: %s (%s)\nReflog message: %s%s",
     ++			       selector.buf, info->email, branch,
     ++			       info->message);
     + 		}
     + 
     + 		strbuf_release(&selector);
      
       ## reflog-walk.h ##
      @@ reflog-walk.h: struct date_mode;
     @@ reflog-walk.h: struct date_mode;
       int add_reflog_for_walk(struct reflog_walk_info *info,
       			struct commit *commit, const char *name);
       void show_reflog_message(struct reflog_walk_info *info, int,
     - 			 struct date_mode, int force_date);
     +-			 struct date_mode, int force_date);
     ++			 struct date_mode, int force_date,
     ++			 const char *branch);
       void get_reflog_message(struct strbuf *sb,
       			struct reflog_walk_info *reflog_info);
      +const char *get_reflog_branch(struct reflog_walk_info *reflog_info);
     @@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a rebase as one
      +		cd operations &&
      +
      +		cat >expect <<-\EOF &&
     -+		(topic) HEAD@{0}: rebase (finish): returning to refs/heads/topic
     -+		(topic) HEAD@{1}: rebase (pick): C
     -+		(topic) HEAD@{2}: rebase (pick): B
     -+		(topic) HEAD@{3}: rebase (pick): A
     -+		(topic) HEAD@{4}: rebase (start): checkout main
     -+		(topic) HEAD@{5}: checkout: moving from main to topic
     -+		(main) HEAD@{6}: commit: upstream
     -+		(main) HEAD@{7}: checkout: moving from topic to main
     -+		(topic) HEAD@{8}: commit: C
     -+		(topic) HEAD@{9}: commit: B
     -+		(topic) HEAD@{10}: commit: A
     -+		(topic) HEAD@{11}: checkout: moving from main to topic
     -+		(main) HEAD@{12}: commit (initial): base
     ++		HEAD@{0}: (topic) rebase (finish): returning to refs/heads/topic
     ++		HEAD@{1}: (topic) rebase (pick): C
     ++		HEAD@{2}: (topic) rebase (pick): B
     ++		HEAD@{3}: (topic) rebase (pick): A
     ++		HEAD@{4}: (topic) rebase (start): checkout main
     ++		HEAD@{5}: (topic) checkout: moving from main to topic
     ++		HEAD@{6}: (main) commit: upstream
     ++		HEAD@{7}: (main) checkout: moving from topic to main
     ++		HEAD@{8}: (topic) commit: C
     ++		HEAD@{9}: (topic) commit: B
     ++		HEAD@{10}: (topic) commit: A
     ++		HEAD@{11}: (topic) checkout: moving from main to topic
     ++		HEAD@{12}: (main) commit (initial): base
      +		EOF
      +		git reflog --historical-branch >out &&
      +		cut -d " " -f 2- out >actual &&
     @@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a rebase as one
      +	(
      +		cd operations &&
      +		hash=$(git rev-parse --short HEAD) &&
     -+		echo "<YELLOW>$hash<RESET><YELLOW> (<RESET><BOLD;GREEN>topic<RESET><YELLOW>)<RESET>" >expect &&
     ++		echo "<YELLOW>$hash<RESET> HEAD@{0}: <YELLOW>(<RESET><BOLD;GREEN>topic<RESET><YELLOW>)<RESET> rebase (finish): returning to refs/heads/topic" >expect &&
      +		git reflog --historical-branch --decorate --color -1 >out &&
     -+		test_decode_color <out | sed "s/ HEAD@.*//" >actual &&
     ++		test_decode_color <out >actual &&
      +		test_cmp expect actual
      +	)
      +'
     @@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a rebase as one
      +test_expect_success '--historical-branch names the ref of other reflogs' '
      +	(
      +		cd operations &&
     -+		echo "(main) main@{0}: commit: upstream" >expect &&
     ++		echo "main@{0}: (main) commit: upstream" >expect &&
      +		git reflog -1 main --historical-branch >out &&
      +		cut -d " " -f 2- out >actual &&
      +		test_cmp expect actual
     @@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a pull --rebase
      +		cd downstream &&
      +		echo "(topic)" >expect &&
      +		git reflog --historical-branch >out &&
     -+		cut -d " " -f 2 out | sort -u >actual &&
     ++		cut -d " " -f 3 out | sort -u >actual &&
      +		test_cmp expect actual
      +	)
      +'
     @@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a pull --rebase
      +		test_commit E &&
      +
      +		cat >expect <<-\EOF &&
     -+		(renamed) HEAD@{0}: commit: E
     -+		(renamed) HEAD@{1}: Branch: renamed refs/heads/topic to refs/heads/renamed
     -+		(topic) HEAD@{3}: commit: D
     ++		HEAD@{0}: (renamed) commit: E
     ++		HEAD@{1}: (renamed) Branch: renamed refs/heads/topic to refs/heads/renamed
     ++		HEAD@{3}: (topic) commit: D
      +		EOF
      +		git reflog --historical-branch -3 >out &&
      +		cut -d " " -f 2- out >actual &&
     @@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a pull --rebase
      +		git checkout renamed &&
      +
      +		cat >expect <<-EOF &&
     -+		(renamed) HEAD@{0}: checkout: moving from $(git rev-parse F) to renamed
     -+		(detached at $(git rev-parse --short F)) HEAD@{1}: commit: F
     ++		HEAD@{0}: (renamed) checkout: moving from $(git rev-parse F) to renamed
     ++		HEAD@{1}: (detached at $(git rev-parse --short F)) commit: F
      +		EOF
      +		git reflog --historical-branch -2 >out &&
      +		cut -d " " -f 2- out >actual &&

-- 
gitgitgadget
