Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146534;
	b=KHAzC9FdbV3LTTcZOtG8Tdij+h8+rGHR8ZvR1lLmOGixlrYxeT9VeUav7MLxDr57pqoJ
	 vTNryFHwK7I6cUr/ZbtFc0jVGm3GvvN9gRgXc7OPl4G/j8Wk8DKHO7WdwGUXB/cFUTlOK
	 Z+el1O043ZRJMQrRs2eTjKeqYWiQ3fMg/9h5iXg+B1AG9ooJJzVyifmBejfZOI0UKMKIN
	 nIauY4gmXI3gNu4IT4MBTkjPkv0Ow3r58enOpw6QoWxl1BA3sAYoSu95a4EEvNbz9wyfU
	 JhjGInSf2dn7PTkfY2nT/zuUW4JYO9SnJH30ZxWtLpqJr7aTJzFhQfI5sFgyAkQeYaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+n/3kdKXpdx0uembxzzDchMti8s2bkG2IK49RNFDEu8=;
	b=xF17L9NmhcT+URsIQUPhGzyRUIOAPp0UM/bL88joce/JO+74zwocdbwdNEHm8WrQPD2c
	 7PvpODSS7XmntGcBJcrdpDuR4TOYaHmU578XACF4VtcDA4t5u9BtDyNR72yIK5MRWMcgW
	 TwGutY/t54ozLTk750P8CxPWulbiZmTjiuINJZJsh/IJMrnz7rs5F+bJQKUesxFcqdXeO
	 XVzhv4CmzuNNQ0aaMQEc+mSUlKA3Ik9CN5vQlKL2+txJSfGgFDAZnRorsvpBwZ56/v39o
	 XxRD8uJusfFFeYYWR85NUyS6gLZ1ac0+tZAXT3F2kR/8uuxDLCB2Rk1AtWlKYNKpMdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRfjumeR;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F61606A322
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 00:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1F61606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRfjumeR
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c5e31bea9so6425356d6.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793146533; x=1793751333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+n/3kdKXpdx0uembxzzDchMti8s2bkG2IK49RNFDEu8=;
        b=HRfjumeR65pW5vBlkH/Tgm+3nM5qA0nWv4tgkj7yDKbfIU9AOJjH/VuB4BdUZp0tAu
         01or4GVC1mCk6EuOpJE97Uqgwa3Aub296ovyrqxt84x5kZ3x6ySl1In6VHbxH5va5Nnh
         3ds7B5fyZwYPsvDXWO2uHwTicHv8wIroOpgcbHcpropBpDIsWXqWhOt41xUysFQysTx4
         kAhEJHFZ7jT1J3R0oLYwr+JDy+7ufE/0hs+VMXJiBNIdn9/Bb7oRvireU+8NH2a3F6iy
         FEA4CkgUjE0GBEbIrsufQhodrv+ugUgXaVxrQEutxYYe+bJyhHsewFHiWkATDVgVsZeo
         l/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793146533; x=1793751333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+n/3kdKXpdx0uembxzzDchMti8s2bkG2IK49RNFDEu8=;
        b=tqbpzC9RTGljvFakNn4s3rF9lPugS9pvAy+vjmUB1CEytAuJE4L0VGJDpehEVmcw7D
         0w9sLP/AIPoN0pbLLIU3McMdYVQeKzfKAMlEFG/LbHQXNiLODGAPIBXttINaICSzmDN3
         qQVFSj0muTSVYuIgsiZkvcn1HPnNWHGMOd8EYanIQJDTaUoZHa9gSHa075fvEq+GY5x1
         K2n61NEh/Hr9SRDmAQhSESYRtF8e1yzu6ZAWjMvH3WovjANz/hVyi5O1LZpeIfw2Qm5+
         +3vbwjwhMQ32XuXNKZCLS4D6+TMVky1vKgnKKExbJe+bX8Alci1IEgQlTMT1MpgpTOCz
         6WLg==
X-Gm-Message-State: AFq9FYJyaxU7aPpN9GcmcglJDupjrItPOlIfRzmqwS2j/my594Pnb7Sn
	FcvNekqIhgaNosSuPOZ0bvZRDaEPt4U/zTb8JmPSH7MuBAlumAQhYs3VlK1sfQ==
X-Gm-Gg: AYBFou2XaxMxUnoyBYhOiohxAhDBLw+/Hc4eC9TeGm/9LOsJBax2E5kYPTxBbkEtT0P
	OcSN7M8s7jzgWh0tD3X3Al3R5kVGEzcZRmNeDpslJD1nDRJXEoNmFwSceAxoqG6PKfn0hf+q8Fq
	/3yOk/Xj4tWiQKOaBGgvT3dYs997pKjeJ9itG4CppLrQntn6Qs/reY2otK+eW/yARMI8HG5Kr4H
	JaGbJQaNLxuMLrg9/zLZX7Z7lM6FNeTx15Ivbcx7/yZlbGBdsbGBiL5V7CRt+Ce2MGEYMSZsTMf
	OqtgJNok9yXCIOp1r9Hc/vbZox7LHe2zJIKIKW81mINhlnhpdYJLiLY5xdkB4Ty+61MuGRyoKiw
	P2tlR235ryfW1+vxR09x5ANYuwCcbXZL3Y5XraYc9blezI2Ec+FL8yykofWGQCAcSuN64YLW8XY
	tV6JAbJZFGmdb+dx4o39N93ka/b5ABk7JV9t1DeFkIeDtsqxUeSByR9nP5P/L06h41Kg1a1sZUP
	N0TeARb5EcQdh6AoU2YtCnhQooblIipDcUSWKZufWBNxLEy0w3JcEig4mwEX3m8qkFOZzSwt1fv
	+d0cCpUkztmD
X-Received: by 2002:a05:620a:460f:b0:93e:ce12:aadd with SMTP id af79cd13be357-94408db358bmr95927685a.58.1793146532751;
        Tue, 27 Oct 2026 17:15:32 -0700 (PDT)
Received: from Williams-MBP.internal ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6e20ba4fsm38666656d6.14.2026.10.27.17.15.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 17:15:32 -0700 (PDT)
From: William Hatfield <whatfield.git@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
	Patrick Steinhardt <ps@pks.im>,
	Glen Choo <glencbz@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	William Hatfield <whatfield.git@gmail.com>
Subject: [PATCH v2 1/3] submodule: add --reverse-traversal to foreach
Date: Tue, 27 Oct 2026 20:15:27 -0400
Message-ID: <20261028001529.81557-2-whatfield.git@gmail.com>
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

When a project has submodules nested in other submodules, and there are
changes in several of them, committing everything with "git submodule
foreach --recursive" does not work in one pass: the command runs in each
submodule before it runs in the submodules nested in it. A nested
submodule thus gets its new commit after its superproject has already
been committed, and the superproject does not record it. To get a clean
working tree, each submodule has to be visited before its superproject,
which today needs a script that lists the submodules and walks the list
backwards.

Teach "git submodule foreach" an option, --reverse-traversal, that
visits the submodules in the reverse of the order it uses otherwise.
With --recursive this is the usual sequence read backwards, so each
submodule is visited after the submodules nested in it, and so before
its superproject. Without --recursive, the order of the submodules
directly in the superproject is reversed.

"Reverse" is meant literally. It does not describe a tree walk
(bottom-up, post-order) that would mean nothing without --recursive,
but the order that "foreach" and "foreach --recursive" currently use,
read backwards. As that order was not written down, document it: the
submodules in the order of their paths, each one followed by the
submodules nested in it.

The submodules of a repository are looked for when it is reached. With
--recursive and --reverse-traversal the nested submodules are therefore
looked for before the command runs in a submodule, not after it, and a
command that checks out nested submodules itself does not get them
visited, unlike in the usual order. This is documented and tested.

Implement it by reversing the list of submodules before walking it,
and by recursing into the nested submodules before, instead of after,
running the command in a submodule.

Signed-off-by: William Hatfield <whatfield.git@gmail.com>
---
 Documentation/git-submodule.adoc       |  25 ++-
 builtin/submodule--helper.c            |  66 +++++---
 contrib/completion/git-completion.bash |   5 +-
 git-submodule.sh                       |   7 +-
 t/meson.build                          |   1 +
 t/t7427-submodule-foreach-reversive.sh | 215 +++++++++++++++++++++++++
 6 files changed, 292 insertions(+), 27 deletions(-)
 create mode 100755 t/t7427-submodule-foreach-reversive.sh

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index e9c81a7170..18658ded41 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -18,7 +18,7 @@ git submodule [--quiet] update [<options>] [--] [<path>...]
 git submodule [--quiet] set-branch [<options>] [--] <path>
 git submodule [--quiet] set-url [--] <path> <newurl>
 git submodule [--quiet] summary [<options>] [--] [<path>...]
-git submodule [--quiet] foreach [--recursive] <command>
+git submodule [--quiet] foreach [--recursive] [--reverse-traversal] <command>
 git submodule [--quiet] sync [--recursive] [--] [<path>...]
 git submodule [--quiet] absorbgitdirs [--] [<path>...]
 
@@ -222,7 +222,7 @@ specifications.
 Using the `--submodule=log` option with linkgit:git-diff[1] will provide that
 information too.
 
-`foreach [--recursive] <command>`::
+`foreach [--recursive] [--reverse-traversal] <command>`::
 	Evaluate an arbitrary shell _<command>_ in each checked out submodule.
 	The command has access to the variables `$name`, `$sm_path`, `$displaypath`,
 	`$sha1` and `$toplevel`:
@@ -244,6 +244,12 @@ ignored by this command. Unless given `--quiet`, foreach prints the name
 of each submodule before evaluating the command.
 If `--recursive` is given, submodules are traversed recursively (i.e.
 the given shell command is evaluated in nested submodules as well).
+Submodules are visited in the order of their paths, and with `--recursive`
+each one is immediately followed by the submodules nested in it.
+If `--reverse-traversal` is given, this order is reversed. With
+`--recursive`, each submodule is thus visited after the submodules nested
+in it. Those are looked for before the command runs in the submodule, so
+nested submodules that the command itself checks out are not visited.
 A non-zero return from the command in any submodule causes
 the processing to terminate. This can be overridden by adding ++||:++
 to the end of the command.
@@ -254,6 +260,13 @@ checked out commit for each submodule:
 --------------
 git submodule foreach 'echo $sm_path `git rev-parse HEAD`'
 --------------
++
+And this shows the path of each submodule, visiting the submodules nested
+in a submodule before the submodule itself:
++
+--------------
+git submodule --quiet foreach --recursive --reverse-traversal 'echo $displaypath'
+--------------
 
 `sync [--recursive] [--] [<path>...]`::
 	Synchronize submodules' remote URL configuration setting
@@ -442,6 +455,14 @@ NOTE: See the NOTE above for the `--reference` option.
 	only in the submodules of the current repo, but also
 	in any nested submodules inside those submodules (and so on).
 
+`--reverse-traversal`::
+	Visit the submodules in the reverse of the order they would otherwise
+	be visited in, which is described for `foreach` above. This option is
+	only valid for the `foreach` command.
+	With `--recursive`, nested submodules are visited before the
+	submodule they are nested in; without it, only the order of the
+	submodules directly in the superproject is reversed.
+
 `--depth=<depth>`::
 	Create a 'shallow' clone with a history truncated to the _<depth>_ revisions.
 	This option is valid for `add` and `update` commands. See linkgit:git-clone[1]
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 64412adf9f..8a16e1ceae 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -323,9 +323,38 @@ struct foreach_cb {
 	const char *super_prefix;
 	int quiet;
 	int recursive;
+	int reverse_traversal;
 };
 #define FOREACH_CB_INIT { 0 }
 
+static void recurse_into_nested_submodules(const struct foreach_cb *info,
+					   const char *path,
+					   const char *displaypath)
+{
+	struct child_process cpr = CHILD_PROCESS_INIT;
+
+	cpr.git_cmd = 1;
+	cpr.dir = path;
+	prepare_submodule_repo_env(&cpr.env);
+
+	strvec_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
+		     NULL);
+	if (info->reverse_traversal)
+		strvec_push(&cpr.args, "--reverse-traversal");
+	strvec_pushf(&cpr.args, "--super-prefix=%s/", displaypath);
+
+	if (info->quiet)
+		strvec_push(&cpr.args, "--quiet");
+
+	strvec_push(&cpr.args, "--");
+	strvec_pushv(&cpr.args, info->argv);
+
+	if (run_command(&cpr))
+		die(_("run_command returned non-zero status while "
+			"recursing in the nested submodules of %s\n."),
+			displaypath);
+}
+
 static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 				       void *cb_data)
 {
@@ -396,6 +425,10 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		strvec_pushv(&cp.args, info->argv);
 	}
 
+	/* With reverse traversal, visit nested submodules first. */
+	if (info->recursive && info->reverse_traversal)
+		recurse_into_nested_submodules(info, path, displaypath);
+
 	if (!info->quiet)
 		printf(_("Entering '%s'\n"), displaypath);
 
@@ -407,28 +440,8 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		child_process_clear(&cp);
 	}
 
-	if (info->recursive) {
-		struct child_process cpr = CHILD_PROCESS_INIT;
-
-		cpr.git_cmd = 1;
-		cpr.dir = path;
-		prepare_submodule_repo_env(&cpr.env);
-
-		strvec_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
-			     NULL);
-		strvec_pushf(&cpr.args, "--super-prefix=%s/", displaypath);
-
-		if (info->quiet)
-			strvec_push(&cpr.args, "--quiet");
-
-		strvec_push(&cpr.args, "--");
-		strvec_pushv(&cpr.args, info->argv);
-
-		if (run_command(&cpr))
-			die(_("run_command returned non-zero status while "
-				"recursing in the nested submodules of %s\n."),
-				displaypath);
-	}
+	if (info->recursive && !info->reverse_traversal)
+		recurse_into_nested_submodules(info, path, displaypath);
 
 cleanup:
 	free(displaypath);
@@ -440,15 +453,18 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 	struct foreach_cb info = FOREACH_CB_INIT;
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
+	int i, j;
 	struct option module_foreach_options[] = {
 		OPT__SUPER_PREFIX(&info.super_prefix),
 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
 		OPT_BOOL(0, "recursive", &info.recursive,
 			 N_("recurse into nested submodules")),
+		OPT_BOOL(0, "reverse-traversal", &info.reverse_traversal,
+			 N_("visit submodules in the reverse of the usual order")),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
+		N_("git submodule foreach [--quiet] [--recursive] [--reverse-traversal] [--] <command>"),
 		NULL
 	};
 	int ret = 1;
@@ -463,6 +479,10 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 	info.argv = argv;
 	info.prefix = prefix;
 
+	if (info.reverse_traversal)
+		for (i = 0, j = list.nr - 1; i < j; i++, j--)
+			SWAP(list.entries[i], list.entries[j]);
+
 	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
 
 	ret = 0;
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c3a49e2e22..be026abcf3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3644,7 +3644,10 @@ _git_submodule ()
 	summary,--*)
 		__gitcomp "--cached --files --summary-limit"
 		;;
-	foreach,--*|sync,--*)
+	foreach,--*)
+		__gitcomp "--recursive --reverse-traversal"
+		;;
+	sync,--*)
 		__gitcomp "--recursive"
 		;;
 	*)
diff --git a/git-submodule.sh b/git-submodule.sh
index 8632194138..efea4e5400 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -14,7 +14,7 @@ USAGE="[--quiet] [--cached]
    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
    or: $dashless [--quiet] set-url [--] <path> <newurl>
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
-   or: $dashless [--quiet] foreach [--recursive] <command>
+   or: $dashless [--quiet] foreach [--recursive] [--reverse-traversal] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
    or: $dashless [--quiet] absorbgitdirs [--] [<path>...]"
 OPTIONS_SPEC=
@@ -36,6 +36,7 @@ force=
 reference=
 cached=
 recursive=
+reverse_traversal=
 init=
 require_init=
 files=
@@ -173,6 +174,9 @@ cmd_foreach()
 		--recursive)
 			recursive=$1
 			;;
+		--reverse-traversal)
+			reverse_traversal=$1
+			;;
 		-*)
 			usage
 			;;
@@ -186,6 +190,7 @@ cmd_foreach()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach \
 		$quiet \
 		$recursive \
+		$reverse_traversal \
 		-- \
 		"$@"
 }
diff --git a/t/meson.build b/t/meson.build
index 11b3752f00..31a57b85d3 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -926,6 +926,7 @@ integration_tests = [
   't7424-submodule-mixed-ref-formats.sh',
   't7425-submodule-gitdir-path-extension.sh',
   't7426-submodule-get-default-remote.sh',
+  't7427-submodule-foreach-reversive.sh',
   't7450-bad-git-dotfiles.sh',
   't7500-commit-template-squash-signoff.sh',
   't7501-commit-basic-functionality.sh',
diff --git a/t/t7427-submodule-foreach-reversive.sh b/t/t7427-submodule-foreach-reversive.sh
new file mode 100755
index 0000000000..06e341b075
--- /dev/null
+++ b/t/t7427-submodule-foreach-reversive.sh
@@ -0,0 +1,215 @@
+#!/bin/sh
+#
+# Copyright (c) 2026 William Hatfield
+#
+
+test_description='git submodule foreach --reverse-traversal
+
+Check that --reverse-traversal visits submodules in the reverse of their
+usual order, and that, together with --recursive, each submodule is
+visited after the submodules nested in it.
+'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Create a commit with some content in repository $1.
+create_content () {
+	echo "$2" >"$1/file" &&
+	git -C "$1" add file &&
+	test_tick &&
+	git -C "$1" commit -m "$1 commit"
+}
+
+# Add submodules $2... to repository $1 and commit.
+add_submodules () {
+	parent=$1 &&
+	shift &&
+	for child in "$@"
+	do
+		git -C "$parent" submodule add ../"$child" "$child" ||
+		return 1
+	done &&
+	test_tick &&
+	git -C "$parent" commit -m "add $*"
+}
+
+test_expect_success 'setup' '
+	git config --global protocol.file.allow always &&
+	#
+	# Resulting layout:
+	#
+	#   top
+	#   +-- sub0
+	#   +-- sub1
+	#   |   `-- sub2
+	#   +-- sub3
+	#   |   +-- sub4
+	#   |   `-- sub5
+	#   `-- sub6
+	#       `-- sub7
+	#           +-- sub8
+	#           `-- sub9
+	#
+	mkdir reversive &&
+	(
+		cd reversive &&
+		for r in top sub0 sub1 sub2 sub3 sub4 sub5 sub6 sub7 sub8 sub9
+		do
+			test_create_repo $r &&
+			create_content $r $r || return 1
+		done &&
+		add_submodules sub1 sub2 &&
+		add_submodules sub3 sub4 sub5 &&
+		add_submodules sub7 sub8 sub9 &&
+		add_submodules sub6 sub7 &&
+		add_submodules top sub0 sub1 sub3 sub6 &&
+		git -C top submodule update --init --recursive
+	)
+'
+
+test_expect_success 'default order is unchanged' '
+	git -C reversive/top submodule --quiet foreach --recursive \
+		"echo \$displaypath" >actual &&
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
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--recursive --reverse-traversal visits each submodule before its superproject' '
+	git -C reversive/top submodule --quiet foreach --recursive \
+		--reverse-traversal "echo \$displaypath" >actual &&
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
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--reverse-traversal without --recursive only reverses the top level' '
+	git -C reversive/top submodule --quiet foreach \
+		--reverse-traversal "echo \$displaypath" >actual &&
+	cat >expect <<-\EOF &&
+	sub6
+	sub3
+	sub1
+	sub0
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--reverse-traversal announces each submodule after the submodules nested in it' '
+	git -C reversive/top submodule foreach --recursive \
+		--reverse-traversal true >out &&
+	sed -n -e "s/^Entering .\(.*\).\$/\1/p" out >actual &&
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
+	EOF
+	test_cmp expect actual &&
+	git -C reversive/top submodule foreach --quiet --recursive \
+		--reverse-traversal true >out 2>&1 &&
+	test_must_be_empty out
+'
+
+test_expect_success 'a failure stops the traversal' '
+	test_must_fail git -C reversive/top submodule --quiet foreach \
+		--recursive --reverse-traversal \
+		"echo \$displaypath; test \$name != sub8" >actual 2>err &&
+	cat >expect <<-\EOF &&
+	sub6/sub7/sub9
+	sub6/sub7/sub8
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'submodules that are not checked out are skipped' '
+	git clone reversive/top partial &&
+	git -C partial submodule update --init sub3 sub6 &&
+	git -C partial/sub6 submodule update --init sub7 &&
+	git -C partial submodule --quiet foreach --recursive \
+		--reverse-traversal "echo \$displaypath" >actual &&
+	cat >expect <<-\EOF &&
+	sub6/sub7
+	sub6
+	sub3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'submodules checked out by the command are not visited' '
+	git clone reversive/top dynamic &&
+	git -C dynamic submodule update --init sub1 &&
+	git -C dynamic submodule --quiet foreach --recursive \
+		--reverse-traversal \
+		"echo \$displaypath; git submodule update --init --quiet" \
+		>actual &&
+	echo sub1 >expect &&
+	test_cmp expect actual &&
+	git -C dynamic/sub1/sub2 rev-parse --show-toplevel >actual &&
+	(cd dynamic/sub1/sub2 && pwd -P) >expect &&
+	test_cmp expect actual &&
+
+	git clone reversive/top dynamic-usual &&
+	git -C dynamic-usual submodule update --init sub1 &&
+	git -C dynamic-usual submodule --quiet foreach --recursive \
+		"echo \$displaypath; git submodule update --init --quiet" \
+		>actual &&
+	cat >expect <<-\EOF &&
+	sub1
+	sub1/sub2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'committing in reverse order leaves nested submodules clean' '
+	git clone --recurse-submodules reversive/top rev &&
+	git clone --recurse-submodules reversive/top fwd &&
+	for d in rev fwd
+	do
+		echo changed >$d/sub6/sub7/sub9/file &&
+		echo changed >$d/sub6/sub7/file || return 1
+	done &&
+
+	git -C rev submodule foreach --quiet --recursive \
+		--reverse-traversal "git commit -q -a -m update || :" &&
+	git -C rev/sub6 status --porcelain >rev.sub6 &&
+	git -C rev/sub6/sub7 status --porcelain >rev.sub7 &&
+	test_must_be_empty rev.sub6 &&
+	test_must_be_empty rev.sub7 &&
+
+	git -C fwd submodule foreach --quiet --recursive \
+		"git commit -q -a -m update || :" &&
+	git -C fwd/sub6 status --porcelain >fwd.sub6 &&
+	test_file_not_empty fwd.sub6
+'
+
+test_done
-- 
2.56.0

