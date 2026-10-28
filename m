Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146535;
	b=K4Y2p/u2C82dr5pYJ67zMSloS1ZBJDtffK7RKl9YtkU8r3qSlFWvkrLVCBe/3/9pQ+BN
	 bY9MPnZ3bkVbG0rG6o980/JOswyj/3hJyuMDJ3v2tsJ83DU8oSJvqZmBVlZk3rX2ljGQm
	 TSYaQVs2owHIb9I1CcEL3PPpbXGgz37U8iY162BMWtTPimZmkRG0z3Xje1VtIH7cRTdJR
	 vHb9x0Knevt8lHQUuhYhaVODIcG6mtBfWd3VMND7K11AFoFGmoPL5jBmynUOOgEtE3ySY
	 LMmLhM/Q6K4QfGVJ3ZwKv5lVM41kXM4USmOPqk2s5csrtkn/uTKSV14DUCmewPO0ONw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f5vIuvlhuyxIgqMlPwagxbk30wmtwR9zG+UkE1IaHGM=;
	b=ej9+AEXMX3YNmrMOyl4ZXUVMTO3T6eA3OkWFApHh3CxcfwbJIb2ARR4v2JAIPoIJvMf2
	 ElPpG+IuYqkWrvZuuJk+KzzwJPakmokLjgqKcpGxm7a+MtWCaITLJF+2kfRRqz5qtlT+I
	 7B4hyQ0J6w3mt8xULquurGu+2JHRaE//t23G/jCLHBLAReELtzNMYD7DTbt1jadrGm5eW
	 1M7FrArG2wysnzzcfJbY8GYhzSTE7NqSZpFOPyUtshznqRiQU7tBqyRhzyQkajA7sUQv4
	 GILzujXNZevZLXSWgJQHe4ZSyvEchB5KrmyfaODshKN1lsZxXwz2zUePhv2wMRfkDOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nTyO1fDQ;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DF606A32F
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 00:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E2DF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nTyO1fDQ
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5364042eecfso7063561cf.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793146534; x=1793751334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f5vIuvlhuyxIgqMlPwagxbk30wmtwR9zG+UkE1IaHGM=;
        b=nTyO1fDQJZVDMQ/WIsi/IGDR5n+KR9hm1IpL1eYn6hhbOeOQGdB5Aa5lUjBl+O4qaG
         PNwVxU+cMi1CVzL7PGAbr0Z21BddAGnDMTgFdjzvDm+yusls43gwwY6B6a4fzKSzzdhX
         VgqK1NxWfAlsip54wW91t1rnQXNOXEvV/a9CUjcm8JhoVu7Q+j4S9WPIEUW05J0tPxpS
         /ZIRWOc45snAiq68pVFovCeqgJd1lIPROiznTsmxuYbCSQLvb/RK5sTJKbKleegkyRDw
         5XF945Jf6sqtMubjSiVsMMw73w0olEH1U54hFBXaFqDQGGgcOX3THFTHKTU/Lr6hEC8l
         4TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793146534; x=1793751334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f5vIuvlhuyxIgqMlPwagxbk30wmtwR9zG+UkE1IaHGM=;
        b=ZIBayyLPzJacwoI4i9Ptxgkd3C5vKbhGz7+xJS4ujgLzIXiGOIa0kh9GNK7zSyKTxD
         3JdZag11bBNyceVkXPFGhcUSuOGMbCRFqgI0elYt+gTgR7w8lxaLnLVwHUcGIHZQpDLY
         Ou+ppCnGfBXhqvPBXR6wU4fx3TtTP4Cx9R2CYwJUmZb6QBhJePMbbXnWFptw7mn/LacS
         IrAPlRTVQ0vo7mDr1XbnIxt0Qw2lW571VtJKiE99osKlJRTqI/Zq/m5RrrFeOoTJ7++1
         Qoh248SQlj+umzDmjdSSOp6IWmqC/9aC7+cUBsAYRtctOFO/kk96myMaOSqx3Ol4TbH7
         Ggtg==
X-Gm-Message-State: AFq9FYLIYgIFT/YWuAbzZTECc4N4zekCm8miDcRGUN+8FMihD0cIQeiS
	WAulToC28AVrTGszVnHDk/SfiLKtOD1ETcvqkkbJsSoiUW/EMHl+b3C9eiuIHA==
X-Gm-Gg: AYBFou3774BJgEyKKSfD5qH15nsWmHsd+hN0ZHikpt3g6i+Uki/02sNjBboAAh60eoa
	wFOCPA9fQnl5jhIjFkfUbzL5NwC5vv9tXxSRx1sy4WxkFV0/5l/GQo5AIb5MDLg2MfSirVWobb7
	LgzZYfyVMfAqgE2lT8fr7Sv7EnTAcb4O6RGzIAwN0XCyRYcGMl0BhgY8lF4j37sR6xcgwHth7Qu
	a5nBGCF2/eXGNTuDbIXVQriHXf+HNQIIpE4e2qLWJukwAHg+3DzvoFKA1J9JMa6PIDRkrbLhKcT
	ZoN1O7qVCnu04DppW3V/f0piSi8XSSkTuZqH2b/JYuyqyttrPu/zObw4BTDUpYe5JRlbpLdIAPa
	WCjIfcGWqStYZcZKRXg85PgrgWvgLeSMygWY0AngpmQutzlb/kGy1X03bxfbkjae/h+pefdxWj/
	vlOHpxE09DfWPX/8FAFYhmVUfjEdq2K7YHmm7sQXJxUlHG4T2phoKwa8TjwHaGwXqEdkQ6mjtCl
	QUHcRuH3sqWB1acQYiQQRhoGTfd4576CURUvXVMDVfNbqUZw4oCLacKYy0GRA+rLnXJ8nOVaoxV
	qLKrseDBgdbLhH5srw4qGBsNddHRsG+5eJ4iNpAS4frAVk+/3cWgNCluELiZ2w==
X-Received: by 2002:ac8:5a93:0:b0:535:bb7a:884b with SMTP id d75a77b69052e-53fcbee41femr17021871cf.27.1793146533893;
        Tue, 27 Oct 2026 17:15:33 -0700 (PDT)
Received: from Williams-MBP.internal ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6e20ba4fsm38666656d6.14.2026.10.27.17.15.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 17:15:33 -0700 (PDT)
From: William Hatfield <whatfield.git@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
	Patrick Steinhardt <ps@pks.im>,
	Glen Choo <glencbz@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	William Hatfield <whatfield.git@gmail.com>
Subject: [PATCH v2 2/3] submodule: add --include-superproject to foreach
Date: Tue, 27 Oct 2026 20:15:28 -0400
Message-ID: <20261028001529.81557-3-whatfield.git@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028001529.81557-1-whatfield.git@gmail.com>
References: <20260131214309.1899376-1-whatfield.git@gmail.com>
 <20261028001529.81557-1-whatfield.git@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some commands, such as committing the changes made in the submodules
of a project, have to be run in the superproject afterwards: its
commit records the state the submodules ended up in. That means running
the same command a second time, outside of "git submodule foreach",
and keeping the two invocations in sync.

Teach "git submodule foreach" an option, --include-superproject, that
evaluates the command in the superproject as well, after all the
submodules. Together with --recursive and --reverse-traversal this
visits each submodule before its superproject, and the top-level
superproject last.

The command is run in the top level of the superproject, wherever
"git submodule foreach" was started in it. The output follows what is
done for submodules and announces the superproject by the name of its
directory, unless given --quiet.

The superproject is the repository "git submodule foreach" itself runs
in, not a different one that is being entered, so, unlike for a
submodule, the environment that selects the repository, such as
GIT_DIR and GIT_INDEX_FILE, is passed on as it is. The command thus
sees the same repository, worktree and index as the one given to
"git submodule foreach", including with a detached worktree or an
alternate index.

Git sets only $displaypath, to the name of the superproject's
directory. $name, $sm_path and $sha1 describe the submodule's entry in
its superproject, which the superproject does not have, and the command
already runs in the top level, which is what $toplevel would tell it.
The other variables are not cleared by this option, though: they are
whatever the environment provides, for instance when this
"git submodule foreach" is itself run by another one.

Signed-off-by: William Hatfield <whatfield.git@gmail.com>
---
 Documentation/git-submodule.adoc       |  20 ++-
 builtin/submodule--helper.c            |  38 ++++-
 contrib/completion/git-completion.bash |   2 +-
 git-submodule.sh                       |   7 +-
 t/t7427-submodule-foreach-reversive.sh | 208 ++++++++++++++++++++++++-
 5 files changed, 265 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 18658ded41..5d4b06cb96 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -18,7 +18,7 @@ git submodule [--quiet] update [<options>] [--] [<path>...]
 git submodule [--quiet] set-branch [<options>] [--] <path>
 git submodule [--quiet] set-url [--] <path> <newurl>
 git submodule [--quiet] summary [<options>] [--] [<path>...]
-git submodule [--quiet] foreach [--recursive] [--reverse-traversal] <command>
+git submodule [--quiet] foreach [--recursive] [--reverse-traversal] [--include-superproject] <command>
 git submodule [--quiet] sync [--recursive] [--] [<path>...]
 git submodule [--quiet] absorbgitdirs [--] [<path>...]
 
@@ -222,7 +222,7 @@ specifications.
 Using the `--submodule=log` option with linkgit:git-diff[1] will provide that
 information too.
 
-`foreach [--recursive] [--reverse-traversal] <command>`::
+`foreach [--recursive] [--reverse-traversal] [--include-superproject] <command>`::
 	Evaluate an arbitrary shell _<command>_ in each checked out submodule.
 	The command has access to the variables `$name`, `$sm_path`, `$displaypath`,
 	`$sha1` and `$toplevel`:
@@ -250,6 +250,11 @@ If `--reverse-traversal` is given, this order is reversed. With
 `--recursive`, each submodule is thus visited after the submodules nested
 in it. Those are looked for before the command runs in the submodule, so
 nested submodules that the command itself checks out are not visited.
+If `--include-superproject` is given, the command is also evaluated in the
+superproject, that is, at the top level of the repository `foreach` was
+started in, after all the submodules. There, Git sets `$displaypath` to
+the name of that directory and sets none of the other variables listed
+above, although they may come from the environment.
 A non-zero return from the command in any submodule causes
 the processing to terminate. This can be overridden by adding ++||:++
 to the end of the command.
@@ -261,11 +266,12 @@ checked out commit for each submodule:
 git submodule foreach 'echo $sm_path `git rev-parse HEAD`'
 --------------
 +
-And this shows the path of each submodule, visiting the submodules nested
-in a submodule before the submodule itself:
+And this shows the path of each submodule and then of the superproject,
+visiting the submodules nested in a submodule before the submodule itself:
 +
 --------------
-git submodule --quiet foreach --recursive --reverse-traversal 'echo $displaypath'
+git submodule --quiet foreach --recursive --reverse-traversal \
+	--include-superproject 'echo $displaypath'
 --------------
 
 `sync [--recursive] [--] [<path>...]`::
@@ -463,6 +469,10 @@ NOTE: See the NOTE above for the `--reference` option.
 	submodule they are nested in; without it, only the order of the
 	submodules directly in the superproject is reversed.
 
+`--include-superproject`::
+	Also evaluate the command in the superproject, after all the
+	submodules. This option is only valid for the `foreach` command.
+
 `--depth=<depth>`::
 	Create a 'shallow' clone with a history truncated to the _<depth>_ revisions.
 	This option is valid for `add` and `update` commands. See linkgit:git-clone[1]
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8a16e1ceae..fff5142eda 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -324,6 +324,7 @@ struct foreach_cb {
 	int quiet;
 	int recursive;
 	int reverse_traversal;
+	int include_superproject;
 };
 #define FOREACH_CB_INIT { 0 }
 
@@ -447,6 +448,36 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	free(displaypath);
 }
 
+/*
+ * Run the command in the repository foreach was started in. The helper runs
+ * in its top level, so the command does too. Unlike for a submodule, the
+ * environment that selects this repository (GIT_DIR, GIT_INDEX_FILE, ...)
+ * is kept. Only $displaypath is set.
+ */
+static void run_command_in_superproject(const struct foreach_cb *info)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	char *toplevel = xgetcwd();
+	const char *slash = find_last_dir_sep(toplevel);
+	const char *name = slash ? slash + 1 : toplevel;
+
+	cp.use_shell = 1;
+	strvec_pushf(&cp.env, "displaypath=%s", name);
+	strvec_pushv(&cp.args, info->argv);
+
+	if (!info->quiet)
+		printf(_("Entering '%s'\n"), name);
+
+	if (info->argv[0]) {
+		if (run_command(&cp))
+			die(_("command failed in the superproject"));
+	} else {
+		child_process_clear(&cp);
+	}
+
+	free(toplevel);
+}
+
 static int module_foreach(int argc, const char **argv, const char *prefix,
 			  struct repository *repo UNUSED)
 {
@@ -461,10 +492,12 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 			 N_("recurse into nested submodules")),
 		OPT_BOOL(0, "reverse-traversal", &info.reverse_traversal,
 			 N_("visit submodules in the reverse of the usual order")),
+		OPT_BOOL(0, "include-superproject", &info.include_superproject,
+			 N_("also run the command in the superproject, last")),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule foreach [--quiet] [--recursive] [--reverse-traversal] [--] <command>"),
+		N_("git submodule foreach [--quiet] [--recursive] [--reverse-traversal] [--include-superproject] [--] <command>"),
 		NULL
 	};
 	int ret = 1;
@@ -485,6 +518,9 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 
 	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
 
+	if (info.include_superproject)
+		run_command_in_superproject(&info);
+
 	ret = 0;
 cleanup:
 	module_list_release(&list);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index be026abcf3..f47459d589 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3645,7 +3645,7 @@ _git_submodule ()
 		__gitcomp "--cached --files --summary-limit"
 		;;
 	foreach,--*)
-		__gitcomp "--recursive --reverse-traversal"
+		__gitcomp "--recursive --reverse-traversal --include-superproject"
 		;;
 	sync,--*)
 		__gitcomp "--recursive"
diff --git a/git-submodule.sh b/git-submodule.sh
index efea4e5400..964f5a8bf0 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -14,7 +14,7 @@ USAGE="[--quiet] [--cached]
    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
    or: $dashless [--quiet] set-url [--] <path> <newurl>
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
-   or: $dashless [--quiet] foreach [--recursive] [--reverse-traversal] <command>
+   or: $dashless [--quiet] foreach [--recursive] [--reverse-traversal] [--include-superproject] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
    or: $dashless [--quiet] absorbgitdirs [--] [<path>...]"
 OPTIONS_SPEC=
@@ -37,6 +37,7 @@ reference=
 cached=
 recursive=
 reverse_traversal=
+include_superproject=
 init=
 require_init=
 files=
@@ -177,6 +178,9 @@ cmd_foreach()
 		--reverse-traversal)
 			reverse_traversal=$1
 			;;
+		--include-superproject)
+			include_superproject=$1
+			;;
 		-*)
 			usage
 			;;
@@ -191,6 +195,7 @@ cmd_foreach()
 		$quiet \
 		$recursive \
 		$reverse_traversal \
+		$include_superproject \
 		-- \
 		"$@"
 }
diff --git a/t/t7427-submodule-foreach-reversive.sh b/t/t7427-submodule-foreach-reversive.sh
index 06e341b075..a53ea0b851 100755
--- a/t/t7427-submodule-foreach-reversive.sh
+++ b/t/t7427-submodule-foreach-reversive.sh
@@ -3,11 +3,13 @@
 # Copyright (c) 2026 William Hatfield
 #
 
-test_description='git submodule foreach --reverse-traversal
+test_description='git submodule foreach --reverse-traversal and --include-superproject
 
 Check that --reverse-traversal visits submodules in the reverse of their
 usual order, and that, together with --recursive, each submodule is
-visited after the submodules nested in it.
+visited after the submodules nested in it. Check that
+--include-superproject also runs the command in the superproject, after
+all the submodules.
 '
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
@@ -212,4 +214,206 @@ test_expect_success 'committing in reverse order leaves nested submodules clean'
 	test_file_not_empty fwd.sub6
 '
 
+test_expect_success '--include-superproject runs the command in the superproject last' '
+	git -C reversive/top submodule --quiet foreach --recursive \
+		--include-superproject "echo \$displaypath" >actual &&
+	cat >expect <<-\EOF &&
+	sub0
+	sub1
+	sub1/sub2
+	sub3
+	sub3/sub4
+	sub3/sub5
+	sub6
+	sub6/sub7
+	sub6/sub7/sub8
+	sub6/sub7/sub9
+	top
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--include-superproject combines with --reverse-traversal' '
+	git -C reversive/top submodule --quiet foreach --recursive \
+		--reverse-traversal --include-superproject \
+		"echo \$displaypath" >actual &&
+	cat >expect <<-\EOF &&
+	sub6/sub7/sub9
+	sub6/sub7/sub8
+	sub6/sub7
+	sub6
+	sub3/sub5
+	sub3/sub4
+	sub3
+	sub1/sub2
+	sub1
+	sub0
+	top
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--include-superproject announces the superproject' '
+	git -C reversive/top submodule foreach --include-superproject \
+		true >out &&
+	test_grep "^Entering .top.$" out &&
+	git -C reversive/top submodule foreach --quiet \
+		--include-superproject true >out &&
+	test_grep ! Entering out
+'
+
+test_expect_success '--include-superproject in a repository without submodules' '
+	test_create_repo "no subs" &&
+	git -C "no subs" submodule --quiet foreach --include-superproject \
+		"echo \"[\$displaypath]\"" >actual &&
+	echo "[no subs]" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--include-superproject uses the repository it is run in' '
+	git -C reversive/top/sub6 submodule --quiet foreach --recursive \
+		--include-superproject "echo \$displaypath" >actual &&
+	cat >expect <<-\EOF &&
+	sub7
+	sub7/sub8
+	sub7/sub9
+	sub6
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--include-superproject runs from a subdirectory at the top level' '
+	mkdir -p reversive/top/dir &&
+	git -C reversive/top/dir submodule --quiet foreach \
+		--include-superproject "pwd -P" >out &&
+	tail -n 1 out >actual &&
+	(cd reversive/top && pwd -P) >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--include-superproject sets only $displaypath and keeps the rest of the environment' '
+	git -C "no subs" submodule --quiet foreach --include-superproject \
+		"echo \"[\$displaypath][\$name][\$sm_path][\$sha1][\$toplevel]\"" \
+		>actual &&
+	echo "[no subs][][][][]" >expect &&
+	test_cmp expect actual &&
+
+	write_script nested-foreach <<-\EOF &&
+	git submodule --quiet foreach --include-superproject \
+		'\''printf "%s|%s|%s|%s\n" "$displaypath" "$sm_path" "$sha1" "$toplevel"'\''
+	EOF
+	git -C reversive/top submodule --quiet foreach \
+		"if test \"\$name\" = sub0; then \"$TRASH_DIRECTORY/nested-foreach\"; fi" \
+		>actual &&
+	sub0_oid=$(git -C reversive/top rev-parse HEAD:sub0) &&
+	top=$(cd reversive/top && pwd -P) &&
+	echo "sub0|sub0|$sub0_oid|$top" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--include-superproject preserves a detached worktree' '
+	git clone --bare reversive/top detached.git &&
+	mkdir detached &&
+	(
+		cd detached &&
+		GIT_DIR="$(pwd)/../detached.git" &&
+		GIT_WORK_TREE="$(pwd)" &&
+		export GIT_DIR GIT_WORK_TREE &&
+		git checkout --quiet &&
+		git submodule update --init &&
+		git submodule --quiet foreach --include-superproject \
+			"git rev-parse --show-toplevel" >../actual
+	) &&
+	(
+		cd detached &&
+		for sub in sub0 sub1 sub3 sub6
+		do
+			(cd "$sub" && pwd -P) || return 1
+		done &&
+		pwd -P
+	) >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--include-superproject preserves the selected index' '
+	git clone --recurse-submodules reversive/top index-super &&
+	cp index-super/.git/index index-super/custom-index &&
+	echo content >index-super/alternate-file &&
+	GIT_INDEX_FILE=custom-index git -C index-super add alternate-file &&
+	mkdir index-super/dir &&
+	for dir in index-super index-super/dir
+	do
+		GIT_INDEX_FILE=custom-index git -C $dir submodule --quiet \
+			foreach --include-superproject \
+			"if test \"\$displaypath\" = index-super; then
+				git ls-files --error-unmatch alternate-file
+			else
+				test -z \"\$GIT_INDEX_FILE\"
+			fi" >actual &&
+		echo alternate-file >expect &&
+		test_cmp expect actual || return 1
+	done &&
+	test_must_fail git -C index-super ls-files --error-unmatch \
+		alternate-file >/dev/null 2>&1
+'
+
+test_expect_success '--include-superproject commits from the selected index' '
+	cp index-super/.git/index default-index-before &&
+	test_tick &&
+	GIT_INDEX_FILE=custom-index git -C index-super submodule --quiet \
+		foreach --include-superproject \
+		"if test \"\$displaypath\" = index-super; then
+			git commit -q -m alternate-index
+		else
+			test -z \"\$GIT_INDEX_FILE\"
+		fi" &&
+	git -C index-super show HEAD:alternate-file >actual &&
+	echo content >expect &&
+	test_cmp expect actual &&
+	test_cmp_bin default-index-before index-super/.git/index
+'
+
+test_expect_success '--include-superproject does not run after a failure' '
+	test_must_fail git -C reversive/top submodule --quiet foreach \
+		--recursive --reverse-traversal --include-superproject \
+		"echo \$displaypath; test \$name != sub8" >actual 2>err &&
+	cat >expect <<-\EOF &&
+	sub6/sub7/sub9
+	sub6/sub7/sub8
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--include-superproject reports a failing superproject' '
+	test_must_fail git -C reversive/top submodule --quiet foreach \
+		--include-superproject "test \$displaypath != top" 2>err &&
+	test_grep "command failed in the superproject" err
+'
+
+test_expect_success 'committing in the submodules and the superproject leaves nothing modified' '
+	git clone --recurse-submodules reversive/top full &&
+	echo changed >full/file &&
+	echo changed >full/sub0/file &&
+	echo changed >full/sub3/sub5/file &&
+	echo changed >full/sub6/sub7/sub9/file &&
+	git -C full submodule foreach --quiet --recursive \
+		--reverse-traversal --include-superproject \
+		"git commit -q -a -m \"update \$displaypath\" || :" &&
+	git -C full status --porcelain >actual &&
+	test_must_be_empty actual &&
+	for path in sub0 sub3/sub5 sub3 sub6/sub7/sub9 sub6/sub7 sub6
+	do
+		case "$path" in
+		*/*) parent=${path%/*} && child=${path##*/} ;;
+		*) parent=. && child=$path ;;
+		esac &&
+		current=$(git -C "full/$path" rev-parse HEAD) &&
+		original=$(git -C "reversive/top/$path" rev-parse HEAD) &&
+		test "$current" != "$original" &&
+		echo "$current" >expect &&
+		git -C "full/$parent" rev-parse "HEAD:$child" >actual &&
+		test_cmp expect actual || return 1
+	done
+'
+
 test_done
-- 
2.56.0

