Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D819A21D3F3
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802878; cv=none; b=mAKy0TW18EaF51ey9WQTg1lHUcOCJ9QcmXwbRjDTufeRr3pr7m9omtn7c1PTp1kKZKod74wS77PV9928hTHiTTWksJG5tuXrAOuF5PIc3xrXW+hhLZhLEm8Heb9g9QXaJYR6cgF7qC/+IU0G4gW9CSHx7aVnbdMdvGvmVT7uFTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802878; c=relaxed/simple;
	bh=NzLO2l5/Fm/ZfNRHP7up7NSYq4fFjiZ0f4EDkpOVbC0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RG1p3Q01H1iZtRWH58q7rduxAiV/WVuL/ub/9Siu7+YNXqUPOHUtr+XbKZJq6eA4P6xDPr2dKbiDvPI4ISuYja+owT3rGLLPdMw5tlfVKxOHdCwbfgWvEf9mB7WASUCSJ3BZIABm2zppb+R3aNdOl8AyXifDUzg9S8y7vCcgzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBHy6e7x; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBHy6e7x"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bdfd129c52so5832719eec.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 05:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772802875; x=1773407675; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0yyR3ZZtag82JIMyJweH9HwQxNXN9KDbvvQ35+d7DM=;
        b=kBHy6e7xSRyTZjrGVGvGHChuBmnLvcIJWrTZJOyBn5pMYE83+hFoP1IilWiVyZ/gor
         kFoEsWGYlyf3H4XOm9Xlx9niKKkyjysJNMz5GiNDCcOe25qO3wI3cD9VHU8LwamdNTvx
         3XP28/OXG/HgIhQNx2wJc+2v8NwttlX6tG+CyV+ACKEkRgkJNEctqnsA4MTLDsbUVdEr
         Xp4p7BuyLSvW+ZU8gNceRDUh8/veKYqCj9hlyeTBWoUobAiH/rmZQXh8fge8gdzleWF1
         RK9rxzaIoFMtnq6Y07goqVWN1XSvyQd49ca0XshCrQ0JXZ5rpwg8APm8QyNJctQTeGpl
         sMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772802875; x=1773407675;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k0yyR3ZZtag82JIMyJweH9HwQxNXN9KDbvvQ35+d7DM=;
        b=UQNl7p60XDTALjUcmAK3XDlhGzIeJ2sjr2OvwZamdkvxvFoo1nanWfv4+Kgni7Qnxd
         ZYvMt22lJ5+mmKULu7J1eiWg0oBe9FsbU1n4SUgFC2eJB2JXU02v2oT/Atg+6ilCjOXY
         fMJhEx/OhM164j1XnyDGdStyszVtMHFeDZUW0jgbTYxFOOhVKH2gYXGWVnXiClmxHOjr
         SAIlgq1oG6wIC389FiklIdxJp0h9lHaVIagN0tBSr327kRAIy2Rs6jzeIBjUYYXRw7cW
         0VHslSj8knQm3kqv2JH9e8jJDNCBTJ8wGuOW9W/NcgHVqvi1CNyWjmeFBWd2Qro+/kq0
         tkIg==
X-Gm-Message-State: AOJu0YwvyjFuJL37PLDbskiTxbqWCIgiA49S68lEV3zRc6FWPhvD23nq
	0yAoBzBA/uj2JlWBVLONGdXIM7Ya/bUVP4CUe0S80P0YWUpO6jOThiFzF66MIw==
X-Gm-Gg: ATEYQzwDvxbOdQ3CZ1FrgyX+QR050P89srxZEDO7Yonibu95L+UisaNPexe+GzqiKa0
	0jlMuY7TpNpHloDXMVyxB7AwY9aDHDeKvcXyzXow6ngkGbYKe2Z89wuK2fJEmepN8zxcZ0uG3UZ
	v7tozSYxjl90LBG/+xijVUTh40DOPRhLT6GNv0NCrlXER8BKlkyWy9jb1pFWTz4pDc2s4QMi/GF
	uNpM35tIyREITAshBEmTpSZ/PU9cj6BkHs+I5o75eAIjBFb2/Bf9QZhA/leFX5pvGCMtpHtHVlY
	nzMIp2hqvRoprrXqPYabO3whz1kJAWiWExbuHY+xVnVLDqxfH8xtx8NIsD94TiP3JBmUeZni6pY
	oD9UOSZ9jm5qP97FI3ISKklQEjyosCEvVjzA8EltQcJTEr3vVpt8mrpjVwYRDhLchYd3jd+04b5
	cOxk9G5uBxEK5bhjeviqUHhE0qFA==
X-Received: by 2002:a05:7300:8801:b0:2be:56d8:ce5c with SMTP id 5a478bee46e88-2be56d8f75bmr114126eec.16.1772802875309;
        Fri, 06 Mar 2026 05:14:35 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be56d73a20sm256118eec.8.2026.03.06.05.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 05:14:34 -0800 (PST)
Message-Id: <6cbb950d8bc3b647d7fff72a72f938ee369b552c.1772802872.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
References: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
	<pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
From: "VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Mar 2026 13:14:30 +0000
Subject: [PATCH v3 1/3] branch: add '--name-prefix' option
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    VALERI Yoann <yoann.valeri@cea.fr>

From: VALERI Yoann <yoann.valeri@cea.fr>

This patch adds a '--name-prefix' option to add a prefix to a newly
created branch. It can use a regular string or a token as prefix. The
only token currently handled is '@{current}', which is substituted for
the current branch's name.

Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
---
 Documentation/git-branch.adoc | 11 ++++++++++-
 branch.c                      | 17 +++++++++++++++++
 branch.h                      | 12 ++++++++++++
 builtin/branch.c              | 20 +++++++++++++-------
 t/t3200-branch.sh             | 18 ++++++++++++++++++
 5 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index c0afddc424..00967fa758 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -17,7 +17,8 @@ git branch [--color[=<when>] | --no-color] [--show-current]
 	   [(-r|--remotes) | (-a|--all)]
 	   [--list] [<pattern>...]
 git branch [--track[=(direct|inherit)] | --no-track] [-f]
-	   [--recurse-submodules] <branch-name> [<start-point>]
+	   [--recurse-submodules] [--name-prefix=<token>]
+           <branch-name> [<start-point>]
 git branch (--set-upstream-to=<upstream>|-u <upstream>) [<branch-name>]
 git branch --unset-upstream [<branch-name>]
 git branch (-m|-M) [<old-branch>] <new-branch>
@@ -64,6 +65,10 @@ Note that this will create the new branch, but it will not switch the
 working tree to it; use `git switch <new-branch>` to switch to the
 new branch.
 
+With a `--name-prefix` option, you can add a prefix to the branch to create.
+This can either a simple name, or a token. Currently, only '@{current}' is
+managed as token, and will use the current branch name as prefix.
+
 When a local branch is started off a remote-tracking branch, Git sets up the
 branch (specifically the `branch.<name>.remote` and `branch.<name>.merge`
 configuration entries) so that `git pull` will appropriately merge from
@@ -319,6 +324,10 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	and the object it points at.  _<format>_ is the same as
 	that of linkgit:git-for-each-ref[1].
 
+`--name-prefix <token>`::
+	A string that will be used as prefix to the name of the new branch to
+        create. Can be '@{current}' to use the current branch's name.
+
 _<branch-name>_::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
diff --git a/branch.c b/branch.c
index 243db7d0fc..c24d7ce823 100644
--- a/branch.c
+++ b/branch.c
@@ -365,6 +365,23 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	return 0;
 }
 
+void add_branch_prefix(const char *name_prefix,
+					   const char *current_branch, struct strbuf *buf)
+{
+	int value = 0;
+
+	if (!name_prefix)
+		return;
+
+	if (name_prefix[0] != '@') {
+		strbuf_addstr(buf, name_prefix);
+		return;
+	}
+
+	if (strcmp(name_prefix, "@{current}") == 0)
+		strbuf_addstr(buf, current_branch);
+}
+
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
diff --git a/branch.h b/branch.h
index ec2f35fda4..f4ac1e9bbd 100644
--- a/branch.h
+++ b/branch.h
@@ -148,6 +148,18 @@ int install_branch_config(int flag, const char *local, const char *origin, const
  */
 int read_branch_desc(struct strbuf *, const char *branch_name);
 
+/*
+ * Store in 'buf' a prefix to the name of a branch to create by using the given
+ * string 'name_prefix'. It can either be a simple string to a shorthand
+ * starting with '@'.
+ *
+ * Currently, only '@{current}' is managed, and will use 'current_branch' as
+ * prefix.
+ */
+void add_branch_prefix(const char *name_prefix, const char *current_branch,
+					   struct strbuf *buf);
+
+
 /*
  * Check if a branch is checked out in the main worktree or any linked
  * worktree and die (with a message describing its checkout location) if
diff --git a/builtin/branch.c b/builtin/branch.c
index c577b5d20f..58631913c7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -725,6 +725,7 @@ int cmd_branch(int argc,
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
 	int ret;
+	const char *name_prefix = NULL;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -776,6 +777,7 @@ int cmd_branch(int argc,
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules_explicit, N_("recurse through submodules")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
+		OPT_STRING(0, "name-prefix", &name_prefix, N_("name"), N_("prefix for the branch to create")),
 		OPT_END(),
 	};
 
@@ -995,6 +997,7 @@ int cmd_branch(int argc,
 	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
 		const char *branch_name = argv[0];
 		const char *start_name = argc == 2 ? argv[1] : head;
+		struct strbuf new_branch_name = STRBUF_INIT;
 
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("the -a, and -r, options to 'git branch' do not take a branch name.\n"
@@ -1003,15 +1006,18 @@ int cmd_branch(int argc,
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead"));
 
-		if (recurse_submodules) {
-			create_branches_recursively(the_repository, branch_name,
+		add_branch_prefix(name_prefix, start_name, &new_branch_name);
+		strbuf_addstr(&new_branch_name, branch_name);
+
+		if (recurse_submodules)
+			create_branches_recursively(the_repository, new_branch_name.buf,
 						    start_name, NULL, force,
 						    reflog, quiet, track, 0);
-			ret = 0;
-			goto out;
-		}
-		create_branch(the_repository, branch_name, start_name, force, 0,
-			      reflog, quiet, track, 0);
+		else
+			create_branch(the_repository, new_branch_name.buf, start_name,
+						  force, 0, reflog, quiet, track, 0);
+
+		strbuf_release(&new_branch_name);
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c58e505c43..550989a2bb 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1716,4 +1716,22 @@ test_expect_success 'errors if given a bad branch name' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create branch with --name-prefix' '
+	git config branch.autosetupmerge false &&
+	git branch branch-with-prefix &&
+	git branch --name-prefix "blob" -- -with-prefix &&
+	test_must_fail git branch --name-prefix "blob" -- -with-prefix &&
+	git branch --name-prefix "@{current}" -- -with-prefix &&
+	git switch blob-with-prefix &&
+	git branch --name-prefix "@{current}" -- -with-prefix &&
+	test_must_fail git branch --name-prefix "@{current}" -- -with-prefix &&
+	test_ref_exists refs/heads/branch-with-prefix &&
+	test_ref_exists refs/heads/main-with-prefix &&
+	test_ref_exists refs/heads/blob-with-prefix &&
+	test_ref_exists refs/heads/blob-with-prefix-with-prefix &&
+	git checkout main &&
+	git branch -D branch-with-prefix main-with-prefix blob-with-prefix &&
+	git branch -D blob-with-prefix-with-prefix
+'
+
 test_done
-- 
gitgitgadget

