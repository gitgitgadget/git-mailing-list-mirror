Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2724B28
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769255730; cv=none; b=Ng/onEjKmAmOpXSRQMDRX/CP73equrR9eBzhDLLXf9yJLvzuKahCWkWWqLQEK1p/ktDpNVpCI8IqmUzU25irQL3BGVj9X/pF7zT5vU/vPsM4e4Yro1RU4jXLho1TDz2r9ng7unCvDYbJUGXWFqn/AU/8j+eADLD8bBQWoTp9KME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769255730; c=relaxed/simple;
	bh=k8qEmOQv69AznZlih66XG3HV99YVYMPfmX1Yaha8q24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GoR0kBCgwdkoUi1BBd60/qq+9OY7Qjq/KJFsXLV9VAoTcjcDNtdDBpXEun0zW/K5cXhO99gPRHENIkLc0+kfXof7je/gNfRJJVzc15WoGfd2xHvsk2q7KQeohCv1RzkQQBXo8z+6Vq2kXwAo2Q7zd5wVKjdivQXqNe5OiOOO3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjvMCF5x; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjvMCF5x"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43246af170aso1723955f8f.0
        for <git@vger.kernel.org>; Sat, 24 Jan 2026 03:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769255726; x=1769860526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRisN4VnO6hvfac59pNnQYr23cseRH2VwRqOMphcsOg=;
        b=jjvMCF5xV2+y/qXX2eCFN4vYTtfipa/Dqg4Otarg1ozVnHY509Q2vSZtZLo7d4zf+K
         QXS+QyLhVl+iSEpTZPTrDqlUkbPC61QWed8BE6Ja8fy7Rq71sNgg3WzqK/WqyKl6wnVH
         p3KaPoLjS6r5w2/W74t2m9QFkJ5vl8/MvHMka4wdXgKaAfLZyH4fvo0VgVa8j2zHqoQ+
         S0qxNhjpLwARRM9r6O7H8OF+T/WG8q9NpXzWnJE8oohZatw618cRECXNqJ3j227ZN4tN
         xcb2ivE3P4231HCqKIBs6YE1h0GIQCtOI8H8GbY5cB60k5SJo+7ufYV3nncpnNAfW5NA
         ed5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769255726; x=1769860526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DRisN4VnO6hvfac59pNnQYr23cseRH2VwRqOMphcsOg=;
        b=R2YiJikirj9ct4ZOoRApQjUcJKyPzmDuONDP3zDp9/0X2g4yKfDOjbKVbdVcsp223V
         vK+QMZdL62WKNaNsuMDxbsA1VNuBjJMmTof7DppGQcCnsQdxoafYjYzT5wS74rxuKUdH
         Hvmka+WV1CZ2KaQz2D4enP9chs39Zc9mA533ctkeh4ea3boB2m7tTlPtWVhBzyZbZd1X
         F0TL5fzFKVB+DZ4vo38DU93FO1OeKlNzmFHBds/9SbTxvytBxPapRMcvV6bVSfJs9aCJ
         BqN6mXhrJIb3x8cQo875twxfKEws13EOdpY77XREYR8EuTryc9wkdMVTf7YcWby5P1go
         0UVg==
X-Gm-Message-State: AOJu0Yyglb6veEA72by+K0UriO0jSSg1/nspXMb9ZqD2ViKvscoijYyI
	FzFiZLXPdE7kn2GfZOAh0NdzZ1MJriguPUamStahjf6p/A8DRDW1gDN5
X-Gm-Gg: AZuq6aJSxUgA8UOhqTBniQ0ARTg5lgww/N/4IMtePC7npS4Nh8eYDYiUy84wrNPxXWM
	+A0a61iqQ04zM67fPF2sNrbFZh4A3tlKkBLou3m3QVVo9ch+ghWuLz/8wi01iiMlT3BMQOzIVQD
	/oPf5ZPyMGmYUODNq/gl6ipTqDlPC6sGXqNxbnJgYjf2aBq2zGQtwpx4tvJzahCyRzZiwbbsdVP
	DU9EDIXQ87HzSq3kQSLkAZnE8NL+g/jhnvkHdMeb7P16mJ5vAqgx3HHou7ha5DJ9x/GDemaONkj
	jU0LpDBoyPZUya01yShLX3LXX8rZxbyFmcSfI4KmUKAgWGMSQIawS90nojwMHqF3YZGlHA3GKdp
	KIIWnlXAjxuOpw5NyG/yO5UuttnCVhJkfpVU1xp4L35rS1PaZAhOe+3kB6W/a5Sx9zim227OUsE
	7hCw==
X-Received: by 2002:a05:6000:26c2:b0:435:97ff:7d35 with SMTP id ffacd0b85a97d-435b1ab8402mr11054998f8f.4.1769255726267;
        Sat, 24 Jan 2026 03:55:26 -0800 (PST)
Received: from ubuntu ([102.88.77.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02f71sm14393707f8f.6.2026.01.24.03.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 03:55:25 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v4 0/3] store repo specific config values in new `struct repo_config_values`
Date: Sat, 24 Jan 2026 12:55:03 +0100
Message-Id: <cover.1769252118.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768681947.git.belkid98@gmail.com>
References: <cover.1768681947.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Git Community,
Over the course of my ongoing internship, which focused on moving repo specific
global variables in environment.h into local scope, I have attempted to move some
variables into the struct repo-settings.
However there has been some design concerns as regards the use of
`prepare_repo_settings()` with respect to when and where to call the
function, and also the change in behaviours when the variable is lazily
loaded as discussed in [1] and [2].

After different deliberations, Phillip Wood proposed creating a new config
struct [3], adding it to the repository struct and passing the repo struct to
`git_default_config()` to store parsed repo specific config values per repo.
This ensures the current behaviours will be retained.

I have experimented with this approach for some values and I would
appreciate feedbacks about this approach before we can move forward
and use it for more variables related to `git_default_config()`.

For now, the parsed value is stored in `the_repository` in
`git_default_*_config()` and further efforts to pass the repository
parameter to `git_default_config()` as the callback parameter will
be looked into later on.
The link to the CI tests can be see in [4]

1. https://lore.kernel.org/git/43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com/
2. https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com/
3. https://lore.kernel.org/git/8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com/
4. https://gitlab.com/gitlab-community/gitlab-org/git/-/pipelines/2266020513

Changes in v4:
==============
- Changed variable name in the struct to attributes_file
- Modified commit messages in all patches to explain how the variable
  being global can be overwritten when the process has multiple
  repositories
- Changed the variable name in patch 2 to apply_sparse_checkout
- Changes the variable name in patch 3 to branch_track


Olamide Caleb Bello (3):
  environment: stop storing `core.attributesFile` globally
  environment: stop using core.sparseCheckout globally
  environment: move "branch.autoSetupMerge" into `struct
    repo_config_values`

 attr.c                      |  7 ++++---
 branch.h                    |  2 --
 builtin/backfill.c          |  2 +-
 builtin/branch.c            |  2 +-
 builtin/checkout.c          |  2 +-
 builtin/clone.c             |  2 +-
 builtin/grep.c              |  2 +-
 builtin/mv.c                |  2 +-
 builtin/push.c              |  2 +-
 builtin/sparse-checkout.c   | 23 ++++++++++++-----------
 builtin/submodule--helper.c |  2 +-
 builtin/worktree.c          |  2 +-
 dir.c                       |  2 +-
 environment.c               | 28 ++++++++++++++++++----------
 environment.h               | 14 ++++++++++++--
 repository.c                |  1 +
 repository.h                |  4 ++++
 sparse-index.c              |  6 ++++--
 unpack-trees.c              |  2 +-
 wt-status.c                 |  3 ++-
 20 files changed, 68 insertions(+), 42 deletions(-)

 Range diff versus v3:
 =====================
1:  1aa41da833 ! 1:  d28850bcdb environment: stop storing `core.attributesFile` globally
    @@ Metadata
      ## Commit message ##
         environment: stop storing `core.attributesFile` globally
     
    -    The config value is parsed in git_default_core_config(), loaded eagerly
    -    and stored in the global variable `git_attributes_file`.
    -    Storing this value in a global variable can lead to unexpected
    -    behaviours when more than one Git repository run in the same Git process.
    +    The `core.attributeFile` config value is parsed in
    +    git_default_core_config(), loaded eagerly and stored in the global
    +    variable `git_attributes_file`. Storing this value in a global variable
    +    can lead to it being overwritten by another repository when more than one
    +    Git repository run in the same Git process.
     
         Create a new struct `repo_config_values` to hold this value and
    -    other repository dependent values parsed by `git_default_config()` and
    -    can be accessed per repository via `git_default_config()`.
    +    other repository dependent values parsed by `git_default_config()`.
    +    For now the value can be accessed via the_repository in
    +    `git_default_config()`.
         This will ensure the current behaviour remains the same while also
         enabling the libification of Git.
     
         It is important to note that `git_default_config()` is a wrapper to other
    -    `git_default_*_config()` such as `git_default_core_config()`.
    +    `git_default_*_config()` functions such as `git_default_core_config()`.
         Therefore to access and modify this global variable,
    -    the change has to be made in the function which parses and
    -    stores the value in the global variable.
    +    the change has to be made `git_default_core_config()`.
     
         Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
         Mentored-by: Christian Couder <christian.couder@gmail.com>
    @@ attr.c: const char *git_attr_system_file(void)
     -	if (!git_attributes_file)
     -		git_attributes_file = xdg_config_home("attributes");
     +	struct repo_config_values *cfg = &the_repository->config_values;
    -+	if (!cfg->attributes_file_path)
    -+		cfg->attributes_file_path = xdg_config_home("attributes");
    ++	if (!cfg->attributes_file)
    ++		cfg->attributes_file = xdg_config_home("attributes");
      
     -	return git_attributes_file;
    -+	return cfg->attributes_file_path;
    ++	return cfg->attributes_file;
      }
      
      int git_attr_system_is_enabled(void)
    @@ environment.c: static int git_default_core_config(const char *var, const char *v
      	if (!strcmp(var, "core.attributesfile")) {
     -		FREE_AND_NULL(git_attributes_file);
     -		return git_config_pathname(&git_attributes_file, var, value);
    -+		FREE_AND_NULL(cfg->attributes_file_path);
    -+		return git_config_pathname(&cfg->attributes_file_path, var, value);
    ++		FREE_AND_NULL(cfg->attributes_file);
    ++		return git_config_pathname(&cfg->attributes_file, var, value);
      	}
      
      	if (!strcmp(var, "core.bare")) {
    @@ environment.c: int git_default_config(const char *var, const char *value,
     +
     +void repo_config_values_init(struct repo_config_values *cfg)
     +{
    -+	cfg->attributes_file_path = NULL;
    ++	cfg->attributes_file = NULL;
     +}
     
      ## environment.h ##
    @@ environment.h: extern const char * const local_repo_env[];
      
      struct strvec;
      
    -+/* Config values parsed by git_default_config() */
     +struct repo_config_values {
    -+	/* core config values */
    -+	char *attributes_file_path;
    ++	/* section "core" config values */
    ++	char *attributes_file;
     +};
     +
      /*
2:  fd95169de4 ! 2:  e44ce7be3d environment: environment: stop using core.sparseCheckout globally
    @@ Metadata
     Author: Olamide Caleb Bello <belkid98@gmail.com>
     
      ## Commit message ##
    -    environment: environment: stop using core.sparseCheckout globally
    +    environment: stop using core.sparseCheckout globally
     
         The config value `core.sparseCheckout` is parsed in
         `git_default_core_config()` and stored globally in
    -    `core_appy_sparse_checkout`. This could cause unintended behaviours
    -    when different Git repositories running in the same process access this
    -    variable.
    +    `core_apply_sparse_checkout`. This could cause it to be overwritten
    +    by another repository when different Git repositories run in the same
    +    process.
     
    -    Move the parsed value into `struct repo_config_values` to retains current
    -    behaviours while achieving the repository scoped access.
    +    Move the parsed value into `struct repo_config_values` in the_repository
    +    to retain current behaviours and move towards libifying Git.
     
         Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
         Mentored-by: Christian Couder <christian.couder@gmail.com>
    @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *pr
      
      	if (ctx.sparse < 0)
     -		ctx.sparse = core_apply_sparse_checkout;
    -+		ctx.sparse = repo->config_values.sparse_checkout;
    ++		ctx.sparse = the_repository->config_values.apply_sparse_checkout;
      
      	result = do_backfill(&ctx);
      	backfill_context_clear(&ctx);
    @@ builtin/clone.c: static int git_sparse_checkout_init(const char *repo)
      	 * for the later checkout to use the sparse-checkout file.
      	 */
     -	core_apply_sparse_checkout = 1;
    -+	the_repository->config_values.sparse_checkout = 1;
    ++	the_repository->config_values.apply_sparse_checkout = 1;
      
      	cmd.git_cmd = 1;
      	if (run_command(&cmd)) {
    @@ builtin/grep.c: static int grep_submodule(struct grep_opt *opt,
      	 *	of these submodules are expanded unexpectedly.
      	 *
     -	 * 2. "core_apply_sparse_checkout"
    -+	 * 2. "sparse_checkout"
    ++	 * 2. "config_values.apply_sparse_checkout"
      	 *	When running `grep` in the superproject, this setting is
      	 *	populated using the superproject's configs. However, once
      	 *	initialized, this config is globally accessible and is read by
    @@ builtin/mv.c: int cmd_mv(int argc,
      
      		if (ignore_sparse &&
     -		    core_apply_sparse_checkout &&
    -+		    the_repository->config_values.sparse_checkout &&
    ++		    the_repository->config_values.apply_sparse_checkout &&
      		    core_sparse_checkout_cone) {
      			/*
      			 * NEEDSWORK: we are *not* paying attention to
    @@ builtin/sparse-checkout.c: static int sparse_checkout_list(int argc, const char
      
      	setup_work_tree();
     -	if (!core_apply_sparse_checkout)
    -+	if (!the_repository->config_values.sparse_checkout)
    ++	if (!the_repository->config_values.apply_sparse_checkout)
      		die(_("this worktree is not sparse"));
      
      	argc = parse_options(argc, argv, prefix,
    @@ builtin/sparse-checkout.c: static int set_config(struct repository *repo,
      static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
      	/* If not specified, use previous definition of cone mode */
     -	if (*cone_mode == -1 && core_apply_sparse_checkout)
    -+	if (*cone_mode == -1 && the_repository->config_values.sparse_checkout)
    ++	if (*cone_mode == -1 && the_repository->config_values.apply_sparse_checkout)
      		*cone_mode = core_sparse_checkout_cone;
      
      	/* Set cone/non-cone mode appropriately */
     -	core_apply_sparse_checkout = 1;
    -+	the_repository->config_values.sparse_checkout = 1;
    ++	the_repository->config_values.apply_sparse_checkout = 1;
      	if (*cone_mode == 1 || *cone_mode == -1) {
      		core_sparse_checkout_cone = 1;


-- 
2.34.1

