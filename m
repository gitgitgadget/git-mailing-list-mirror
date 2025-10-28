Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB622C3244
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690465; cv=none; b=rbcgmWYdUF4jS2cnEFexN2vIkYo6v1Ec6o+6y4psMoPdIwzd2PmJEZnKMVsFA8YaRbknuzAPCloDSS0Ok5cDT+ERKYOqgrpQTrlG3/Rmyt5BqgxNve24MMeKJXxPgbmGfgdsLl2g8+EkfHpPOP2PYwbQqr1YJ1z7d5VCi15+VEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690465; c=relaxed/simple;
	bh=jJupSN3HENmqe1pBiJhNXieGyDu4b/0Sqnt7GdNQl6g=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=PE2zQkt1s4CIlxi/9SAigK0a+HiiHjIFMihuSWwYBPP0UD7jLiBC8piXq0bNa5kjSB1YZjaI0qNOwKrNBb1ZAUiiT5piW/F3kGF/43aEQSG9jXYNSloo3yKPXlMGUDqtxaLqn/jDBVrDX6xbS13XkKLeKbfBf8RCI1GUKw/4UII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOGqEXES; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOGqEXES"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so5062463a91.2
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761690463; x=1762295263; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JUtAZAlXgF/Lo8ooSz3c8448MleXWGcbmLJPDBD+yw8=;
        b=OOGqEXESo2gglvK/a4JzyQ0gAVVt8nxu9XlOmW82sJ9kblkOpwSr4o6HH22EMWlq5l
         eWrrUkjZUhdPU6DPzo/8aG1W6kM7dsGW2gfCfIcD5KWPZmI5ELt9ctYv6OXj+RN7cm4n
         4qArr/vAnyumyWk+QouKWcizUMizAZJgreoJbrVaLShMfZJKdAI6Cl6hod5BJW2d221I
         4fmaviuG196/tioqBo5kDapoT5gSpywSLCzu/6/2HI9KYHWWBF9cWtd3lbIUZZPkp8eA
         Bd4++PYtXvx9lIx8YgnHt+IrptVmyApggZj4lkmZf5/HWFlhFnBfHpIxfczaAaq6KKED
         +jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761690463; x=1762295263;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUtAZAlXgF/Lo8ooSz3c8448MleXWGcbmLJPDBD+yw8=;
        b=MqLhuabC3zP3BkDnuwY38cdKZ5FAkjKlYHyAMhJdNkasywOpfzlbwl9M09HFa2fgKW
         W8OcYEKwC48K4/frpFKuMw/UUymBtYsXSr4KLl2iAwxWGi7dzwRS9stdOZgKibcaUwS3
         6t7L7IdusbkVysH4rPzJr3HQj5pj53Grw9hi3TeCs2XtqjnWr9QwM8WbCgfrN1w14nEo
         ajDQ/spGPpqTNZGEW4OMn41GNLDibE+5RekTRX4NBSs9vlZak9RcZv9jjrKHd2vLBol1
         SQg6JVwDoG6FhsdCVDwN0+NxPH2xtU3BZENddRdz3NazhQh49HNBkWcruO8tu4qtGlNz
         nFiQ==
X-Gm-Message-State: AOJu0Yx9gnP3VyRP1d2jW/PSFmZ4w06Yb0X/k1B3y+fgfiyUHAZQyOoJ
	71LzeRrPIF8WH/WXILk2u+IwudhY52kJfbpcsu9BpT/Fc+bnWpqtgwF+Jo419w==
X-Gm-Gg: ASbGnctnkBN9PTV74jkb5LVhvXZKeVRHqLQBHCaoTETeCEsXfX8zg2eA4ZVbvagabvL
	qNnmdV8DJIcNd1k16v9LCFQXSGfBWZYs3Dzg8/UutBgn9LDYorZkDD5s+NGSAmXALomSfjq1VZh
	v7KPMkxH3KG6QthNUvmVaA+SXyWgXzchC8LL8BDgjbJrw/2T9Cxk0Olu9CHBIJuGxo+aFJu3txd
	XYu+kDoZD08q85IxymvfZvOWXM6anhP5wdrGswLFEvtKqR6x7+nTiDTBPuHTz+dwxfxaZf95exh
	rA3VG1YqqjeMZv5GCdJ6juerdFH4JYhSR2V/vDbGmMKdGqaI6tKBAUEZHcFv69rTxB8qrpkcwVp
	AYPZflZYsQvkgylolJ+yqzzNVO0F+GpqhJd8xJuli3HeniZwhJoQL01OyRh+Qux1jE2oXFPmhx5
	vP/Ou9
X-Google-Smtp-Source: AGHT+IFFYEQJO4sgGgHgKMImS5oigB0LtMwp1bAwkq/nVTLnVMGqYwYcgfMOBnkCVgyEwKqV8vvG8Q==
X-Received: by 2002:a17:90b:2801:b0:338:3cea:6089 with SMTP id 98e67ed59e1d1-3403a265513mr773038a91.14.1761690462852;
        Tue, 28 Oct 2025 15:27:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.213.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712ce3a90bsm12016551a12.25.2025.10.28.15.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 15:27:42 -0700 (PDT)
Message-Id: <pull.2084.git.git.1761690461697.gitgitgadget@gmail.com>
From: "Ruoyu Zhong via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Oct 2025 22:27:41 +0000
Subject: [PATCH] bisect: update usage and docs to match each other
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Ruoyu Zhong <zhongruoyu@outlook.com>,
    Ruoyu Zhong <zhongruoyu@outlook.com>

From: Ruoyu Zhong <zhongruoyu@outlook.com>

Update the usage string of `git bisect` and documentation to match each
other. While at it, also:

1. Move the synopsis of `git bisect` subcommands to the synopsis
   section, so that the test `t0450-txt-doc-vs-help.sh` can pass.

2. Document the `git bisect next` subcommand, which exists in the code
   but is missing from the documentation.

See also: [1].

[1]: https://lore.kernel.org/git/3DA38465-7636-4EEF-B074-53E4628F5355@gmail.com/

Suggested-by: Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Ruoyu Zhong <zhongruoyu@outlook.com>
---
    bisect: update usage and docs to match each other

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2084%2FZhongRuoyu%2Fgit-bisect-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2084/ZhongRuoyu/git-bisect-docs-v1
Pull-Request: https://github.com/git/git/pull/2084

 Documentation/git-bisect.adoc | 43 +++++++++++++++++++++--------------
 builtin/bisect.c              | 21 ++++++++++-------
 t/t0450/adoc-help-mismatches  |  1 -
 3 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-bisect.adoc b/Documentation/git-bisect.adoc
index 58dbb74a15..b0078dda0e 100644
--- a/Documentation/git-bisect.adoc
+++ b/Documentation/git-bisect.adoc
@@ -9,26 +9,22 @@ git-bisect - Use binary search to find the commit that introduced a bug
 SYNOPSIS
 --------
 [verse]
-'git bisect' <subcommand> <options>
+'git bisect' start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
+		   [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
+'git bisect' (bad|new|<term-new>) [<rev>]
+'git bisect' (good|old|<term-old>) [<rev>...]
+'git bisect' terms [--term-(good|old) | --term-(bad|new)]
+'git bisect' skip [(<rev>|<range>)...]
+'git bisect' next
+'git bisect' reset [<commit>]
+'git bisect' (visualize|view)
+'git bisect' replay <logfile>
+'git bisect' log
+'git bisect' run <cmd> [<arg>...]
+'git bisect' help
 
 DESCRIPTION
 -----------
-The command takes various subcommands, and different options depending
-on the subcommand:
-
- git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
-		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
- git bisect (bad|new|<term-new>) [<rev>]
- git bisect (good|old|<term-old>) [<rev>...]
- git bisect terms [--term-(good|old) | --term-(bad|new)]
- git bisect skip [(<rev>|<range>)...]
- git bisect reset [<commit>]
- git bisect (visualize|view)
- git bisect replay <logfile>
- git bisect log
- git bisect run <cmd> [<arg>...]
- git bisect help
-
 This command uses a binary search algorithm to find which commit in
 your project's history introduced a bug. You use it by first telling
 it a "bad" commit that is known to contain the bug, and a "good"
@@ -295,6 +291,19 @@ $ git bisect skip v2.5 v2.5..v2.6
 This tells the bisect process that the commits between `v2.5` and
 `v2.6` (inclusive) should be skipped.
 
+Bisect next
+~~~~~~~~~~~
+
+Normally, after marking a revision as good or bad, Git automatically
+computes and checks out the next revision to test. However, if you need to
+explicitly request the next bisection step, you can use:
+
+------------
+$ git bisect next
+------------
+
+You might use this to resume the bisection process after interrupting it
+by checking out a different revision.
 
 Cutting down bisection by giving more parameters to bisect start
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 8b8d870cd1..a500993bcb 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -27,13 +27,14 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 #define BUILTIN_GIT_BISECT_START_USAGE \
-	N_("git bisect start [--term-(new|bad)=<term> --term-(old|good)=<term>]" \
-	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]" \
-	   "    [<pathspec>...]")
-#define BUILTIN_GIT_BISECT_STATE_USAGE \
-	N_("git bisect (good|bad) [<rev>...]")
+	N_("git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]\n" \
+	   "                 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]")
+#define BUILTIN_GIT_BISECT_BAD_USAGE \
+	N_("git bisect (bad|new|<term-new>) [<rev>]")
+#define BUILTIN_GIT_BISECT_GOOD_USAGE \
+	N_("git bisect (good|old|<term-old>) [<rev>...]")
 #define BUILTIN_GIT_BISECT_TERMS_USAGE \
-	"git bisect terms [--term-good | --term-bad]"
+	"git bisect terms [--term-(good|old) | --term-(bad|new)]"
 #define BUILTIN_GIT_BISECT_SKIP_USAGE \
 	N_("git bisect skip [(<rev>|<range>)...]")
 #define BUILTIN_GIT_BISECT_NEXT_USAGE \
@@ -41,17 +42,20 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 #define BUILTIN_GIT_BISECT_RESET_USAGE \
 	N_("git bisect reset [<commit>]")
 #define BUILTIN_GIT_BISECT_VISUALIZE_USAGE \
-	"git bisect visualize"
+	"git bisect (visualize|view)"
 #define BUILTIN_GIT_BISECT_REPLAY_USAGE \
 	N_("git bisect replay <logfile>")
 #define BUILTIN_GIT_BISECT_LOG_USAGE \
 	"git bisect log"
 #define BUILTIN_GIT_BISECT_RUN_USAGE \
 	N_("git bisect run <cmd> [<arg>...]")
+#define BUILTIN_GIT_BISECT_HELP_USAGE \
+	"git bisect help"
 
 static const char * const git_bisect_usage[] = {
 	BUILTIN_GIT_BISECT_START_USAGE,
-	BUILTIN_GIT_BISECT_STATE_USAGE,
+	BUILTIN_GIT_BISECT_BAD_USAGE,
+	BUILTIN_GIT_BISECT_GOOD_USAGE,
 	BUILTIN_GIT_BISECT_TERMS_USAGE,
 	BUILTIN_GIT_BISECT_SKIP_USAGE,
 	BUILTIN_GIT_BISECT_NEXT_USAGE,
@@ -60,6 +64,7 @@ static const char * const git_bisect_usage[] = {
 	BUILTIN_GIT_BISECT_REPLAY_USAGE,
 	BUILTIN_GIT_BISECT_LOG_USAGE,
 	BUILTIN_GIT_BISECT_RUN_USAGE,
+	BUILTIN_GIT_BISECT_HELP_USAGE,
 	NULL
 };
 
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index 2c6ecd5fc8..8ee2d3f7c8 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -2,7 +2,6 @@ add
 am
 apply
 archive
-bisect
 blame
 branch
 check-ref-format

base-commit: 57da342c786f59eaeb436c18635cc1c7597733d9
-- 
gitgitgadget
