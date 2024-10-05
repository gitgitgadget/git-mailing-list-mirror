Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77D17753
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099049; cv=none; b=sQ3Bp9ju3rds2QthdF3Dcki8sHiX3sTVO7+QChDri51yUgouO03TzxSZbpofuZ2IK7zdT0Jit4OlfOF0JLWecm5DAzrgy2fu6i8IGWESodBM5Iu+7olQ/wVRM9OOztA7VNxr5f+B9t6P3TOqWnJ90VDg4gSUbOWgXp0BlCDi9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099049; c=relaxed/simple;
	bh=Q4R32HivUOBOI4Hi4j+tNxNLZkXbX3hN7ZeTjlc3r2s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qV4qoVm/7UAnKyDh1ankOAEPh3A00eNjo8AxFiU3roie5i75gdXRGtAV0ZDXFrNUodRwmSe59m7Q+n10AUELgdsMp2O8m5ct31fcAkIKkc/MEd41ZG1k0fFfTT+wHAxJsBz5gWz/azac/3Vrw4KWLj3ZDEkuajI5aN77x1BSpBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftFNkuJk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftFNkuJk"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c88d7c8dbaso1532081a12.2
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 20:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728099045; x=1728703845; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/+omgoZsNrHsh8c0UtCkCL1OJ5IDGqEMUwn7nDUAkQ=;
        b=ftFNkuJkL735/n6SVt8xdMYuYzwbrGElflvK8TRsqhjTfk5ux5rjZs7s+RVfpVML0G
         B6wDiu1Ea4WLEvdN9URaMcFWkV4iCOhmT+iTP42lg+jYddrZL+nYadx934o2UbPYlrZ2
         hOJWgfLVFd1NbtaJm0HWwZXYgifgW0v4G2hI2FQHG2zS9fTsHYIJewD4WM7zGHOP256/
         6eq59XI3rz2TDDkAjkuxTlohvkVayTr5QX1/FQ9lfQTQwIFWGHCxwjfgZpbE/uWPeslb
         d/eUgcOlNg8fTlM2Y9k4zssH+11YZMefsV96bm9PEkfgMTbulbQ2G959luChe1ReIx7l
         vUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099045; x=1728703845;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/+omgoZsNrHsh8c0UtCkCL1OJ5IDGqEMUwn7nDUAkQ=;
        b=UYqLqgjY3a0KohQXAiXgs44lb/fcq/mjfTv3PcGhPnX6oCfVjGUsJp1RrmxuzjbBlG
         dWOFyrvOs/D5tOgH4OwcKv6SBXIf6+pmxk+EOFFEgfjcpLQp9T6HjsMOdPPxFc34yb4m
         6m+zrxpRljF+2DvdlR6dya8v8GHWAUQykItnxyLiPQsk6EYi6rwzgrcziZEbAEQdsZdc
         FRxe6LmzumNNyUJawRYIdxRWlSulKXVckYQndVlYSk4rgx9Vg97TboU0DOtKFA/OW9L3
         rFbOMhl5xvyywv96c0kNYWCM0IHjc2hzgwKzt78oc2S7dHvWfbKavJQZLRO0p3+1uDEf
         O0Ew==
X-Gm-Message-State: AOJu0YxWEwOxiD8i2BZaAIhSbWTKTyifSsU0SMzKj8ww9HVkvXZqp2cI
	s8cuwwyEhn4NoEbFVedR7RGMWQPO2ubSAISFaS0lIhqANSsLVbsspHDIRw==
X-Google-Smtp-Source: AGHT+IG1rScXss/G487rrbetIp6vvkOt7aKtQ6sa5tBx7ivq/vnYO8anj3AcGz8T+IjoqUMdX8qQlQ==
X-Received: by 2002:a05:6402:358b:b0:5c8:a01f:bfea with SMTP id 4fb4d7f45d1cf-5c8d2e47de4mr4659049a12.18.1728099045025;
        Fri, 04 Oct 2024 20:30:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05ebac5sm553203a12.62.2024.10.04.20.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 20:30:44 -0700 (PDT)
Message-Id: <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
References: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Oct 2024 03:30:40 +0000
Subject: [PATCH v3 0/3] Remove the_repository global for am, annotate, apply, archive builtins
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
Cc: shejialuo <shejialuo@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>

Remove the_repository global variable for the annotate, apply, and archive
bulitins.

Changes since V1:

 * in patch 1, only pass in repo to the bulitin if the repo exists

Changes since V2:

 * drop patch 3, which is a bit more involved to dis-entangle the_repository
 * use a single variable in run_builtin() to keep track of whether or not we
   are operating in a repository

John Cai (3):
  git: pass in repo to builtin based on setup_git_directory_gently
  annotate: remove usage of the_repository global
  archive: remove the_repository global variable

 builtin/add.c      | 3 ++-
 builtin/annotate.c | 5 ++---
 builtin/archive.c  | 5 ++---
 git.c              | 7 ++++---
 4 files changed, 10 insertions(+), 10 deletions(-)


base-commit: 3857aae53f3633b7de63ad640737c657387ae0c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1788%2Fjohn-cai%2Fjc%2Fremove-global-repo-a-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1788/john-cai/jc/remove-global-repo-a-v3
Pull-Request: https://github.com/git/git/pull/1788

Range-diff vs v2:

 1:  5d72c31c6f3 ! 1:  8009fdb38b0 git: pass in repo for RUN_SETUP_GENTLY
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    git: pass in repo for RUN_SETUP_GENTLY
     +    git: pass in repo to builtin based on setup_git_directory_gently
      
     -    commands that have RUN_SETUP_GENTLY potentially need a repository.
     -    Modify the logic in run_builtin() to pass the repository to the builtin
     -    if a builtin has the RUN_SETUP_GENTLY property.
     +    The current code in run_builtin() passes in a repository to the builtin
     +    based on whether cmd_struct's option flag has RUN_SETUP.
     +
     +    This is incorrect, however, since some builtins that only have
     +    RUN_SETUP_GENTLY can potentially take a repository.
     +    setup_git_directory_gently() tells us whether or not a command is being
     +    run inside of a repository.
     +
     +    Use the output of setup_git_directory_gently() to help determine whether
     +    or not there is a repository to pass to the builtin. If not, then we
     +    just pass NULL.
     +
     +    As part of this patch, we need to modify add to check for a NULL repo
     +    before calling repo_git_config(), since add -h can be run outside of a
     +    repository.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     + ## builtin/add.c ##
     +@@ builtin/add.c: int cmd_add(int argc,
     + 	char *ps_matched = NULL;
     + 	struct lock_file lock_file = LOCK_INIT;
     + 
     +-	repo_config(repo, add_config, NULL);
     ++	if (repo)
     ++		repo_config(repo, add_config, NULL);
     + 
     + 	argc = parse_options(argc, argv, prefix, builtin_add_options,
     + 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
     +
       ## git.c ##
      @@ git.c: static int handle_alias(int *argcp, const char ***argv)
     - 
       static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct repository *repo)
       {
     --	int status, help;
     -+	int status, help, repo_exists;
     + 	int status, help;
     ++	int no_repo = 1;
       	struct stat st;
       	const char *prefix;
       	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
     @@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv,
       
       	if (run_setup & RUN_SETUP) {
       		prefix = setup_git_directory();
     -+		repo_exists = 1;
     ++		no_repo = 0;
       	} else if (run_setup & RUN_SETUP_GENTLY) {
     - 		int nongit_ok;
     - 		prefix = setup_git_directory_gently(&nongit_ok);
     -+
     -+		if (!nongit_ok)
     -+			repo_exists = 1;
     +-		int nongit_ok;
     +-		prefix = setup_git_directory_gently(&nongit_ok);
     ++		prefix = setup_git_directory_gently(&no_repo);
       	} else {
       		prefix = NULL;
       	}
     @@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv,
       
       	validate_cache_entries(repo->index);
      -	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
     -+	status = p->fn(argc,
     -+		       argv,
     -+		       prefix,
     -+		       repo_exists ? repo : NULL);
     ++	status = p->fn(argc, argv, prefix, no_repo ? NULL : repo);
       	validate_cache_entries(repo->index);
       
       	if (status)
 2:  2a29d113815 = 2:  1b82b5dc678 annotate: remove usage of the_repository global
 3:  d64955a2e27 < -:  ----------- apply: remove the_repository global variable
 4:  857291d7f7d = 3:  5d33a375f41 archive: remove the_repository global variable

-- 
gitgitgadget
