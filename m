Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A745318EFB
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259934; cv=none; b=FbKSm7tunUW1dOruZqyz+nTtg5BngDm/mfueyevwnZA72t85mcGWWo2ordWaGgNXKxqKOAIR2veeejWBvQkcf+mL7T0UQxs2XugYLck/olkcrrFhuz6ziVDKFcTUnNTmuI87ampzmI4OkWzE952QvASD/7ioXbXLXR3wxvQWXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259934; c=relaxed/simple;
	bh=St63FK02LQRnU6lM+L4iCAuSOyDE/KGe7yJqcDbMhGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZRlKH8/Hbxb0Lp47hrhMLrwgWBiyhUpFe4NU+c45xQ1KIllT10p+RTUBGmoUWH93JNcV1brlMPdy0kahoD1RuAfUSlBGeNTRQSFcQ34QgZ+7lbOOS4df0T9q/rbTw8STl9IkZp71Kx1z+fOGwMyAWhROIfIRtnVJdH44iyzce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC7IRTE1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC7IRTE1"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65be78011c8so2147891a12.3
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 08:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771259931; x=1771864731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9LCiC9JqR8tQT35s1HSVUpeHVv8Mburr2NKAxU2WZE=;
        b=cC7IRTE1JAhu1EDnu8DkXw6edgLkIZS5cJdwMKnHbn1uaXvz7mD+kap7VgufnBxtQa
         2Z5XzYqvHe176dvFNK0LxuU3THamYYrojj0joaYjB3Hov3qptl+88vB78tvxW624Fclk
         MJljiLzn3Rg2Ubn63YANX803gf9Qn++rXn8gUbBk9giV5nhMQ0b28LZwAwciKkU3PxiL
         TLQbAt0I1Awxl7luKTP0pfWpPFBmbT3ScOlkpsoflJQFBDnzIt4Ss2ooeYkuZBtt8MAt
         uRnD2FBTKkGiwXokJEQnVjpiNUaA5rlxOUyg8wOhKTFi+CEPxGfCIs6LBB5QkQatIy6S
         csYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771259931; x=1771864731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9LCiC9JqR8tQT35s1HSVUpeHVv8Mburr2NKAxU2WZE=;
        b=kuiZVl0UgdnMg6T2Stu03SZBTVdik/+jb2BLzrRU5I8cW3jiPfnR/u2oBvtw+ZdE62
         O262Maace7ftejbJHYujtQnOoFuKsxUgaKeAOP2UUOkbIqCvBC5Jq3lmPbltg0ZRMJxz
         aqFuFTqUpnGmd+u1sp/rM1NJXP4A6oD0j7rpE+wFxtMQD1A/llQiHs75AS87Hi9qp7vW
         zSSKrROSTGDjmtVRRFnZysMdD0pq9LYLLoOr3TsZJD/dyaamo5oJ/CAa9aVh/mrBZpaF
         Q4itz2Nr47mLSzNhnAWNg4vUDT0xFSJ4ClEUrx4okglrsO5RrgucNIRXlwef71SwpBkp
         rzaA==
X-Gm-Message-State: AOJu0YwlqymXw5mB3jjhxatghuhbV5K1kHT5xOn6Fv4VJ9dzDPh4U/cA
	6Bidq/gYMpFhcNgFKIjbrCbtwNZE2S6uotNrI+E2s8JhTAnNFOG7QFUU
X-Gm-Gg: AZuq6aLfG14OqgYundSRSDo7T+rDsk+684ep3rsZaAwbKEOPLuMe9YU0h4IRhdHdtLD
	MpN4hxoadaDP9kYYVWt7sUbSqRwL/S1uI37QEWKVgeVUw2wjYYRwpBkE4KQZD7mOiMVqTQ0CqZL
	Rm2ubNShTO0KsfvAa7/0xAvkhF4f9AYPOVtaFT0rGhI261bP0v5C20T/lj3AATmKGouIcRwXG30
	GoVnkGPJ9r0ONMge5cUzUlv/Teir4StuQhWfNPpD0SXgGPt9HubdAi1cJPHxI5dCg6UUeTEoW6y
	lB4atJ6fhV2VHCPW+9VvfKidVWXcSawSUzFgJzTaIlkSDuXB41rNp70w1XQs+fLRrJ3oEQXVpuW
	QNyypuCczDE4DPlMkZpKTb+7rfkg0MCIwdF204k3Z7k9ZcfL36INI3XEZTYQje6W8Ucdg8Ny7GU
	Q3JswVgyKPXJwFDg==
X-Received: by 2002:a17:907:7fa5:b0:b8e:fe3c:2264 with SMTP id a640c23a62f3a-b8face2498amr568017766b.41.1771259931257;
        Mon, 16 Feb 2026 08:38:51 -0800 (PST)
Received: from ubuntu ([102.88.77.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7385d99sm260394966b.17.2026.02.16.08.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:38:50 -0800 (PST)
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
Subject: [Outreachy PATCH v7 0/3] store repo specific config values in new `struct repo_config_values`
Date: Mon, 16 Feb 2026 17:38:24 +0100
Message-Id: <cover.1771258573.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1769256839.git.belkid98@gmail.com>
References: <cover.1769256839.git.belkid98@gmail.com>
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

In version v6, the fuzz-commit-graph failed due to the test being run
multiples times in the same process. This makes us get a BUG due to
the repository being reinitialized in the same process.
But now resetting the initialization using memset before rerunning
the test, the failure is not longer experienced.

1. https://lore.kernel.org/git/43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com/
2. https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com/
3. https://lore.kernel.org/git/8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com
4. https://github.com/git/git/actions/runs/21633462506/job/62352191148?pr=2166
5. https://gitlab.com/gitlab-community/gitlab-org/git/-/pipelines/2303203992

Changes in v7:
==============
- Added the code to reset the initialization of the_repository
  in the fuzz-commit-graph test in Patch 1.
- Changed the call to rep_config_values_init() in
  initialze_repository() by passing it the repo config_values_private_
  struct instead of the accessor function in Patch 1.
- Modified the commit message in Patch 1
- Added extra lines between variable declarations and code

Olamide Caleb Bello (3):
  environment: stop storing `core.attributesFile` globally
  environment: stop using core.sparseCheckout globally
  environment: move "branch.autoSetupMerge" into `struct
    repo_config_values`

 attr.c                       |  7 ++++---
 branch.h                     |  2 --
 builtin/backfill.c           |  3 ++-
 builtin/branch.c             |  3 ++-
 builtin/checkout.c           |  3 ++-
 builtin/clone.c              |  4 +++-
 builtin/grep.c               |  2 +-
 builtin/mv.c                 |  3 ++-
 builtin/push.c               |  3 ++-
 builtin/sparse-checkout.c    | 31 ++++++++++++++++++++-----------
 builtin/submodule--helper.c  |  3 ++-
 builtin/worktree.c           |  3 ++-
 dir.c                        |  4 +++-
 environment.c                | 28 ++++++++++++++++++----------
 environment.h                | 17 +++++++++++++++--
 oss-fuzz/fuzz-commit-graph.c |  1 +
 repository.c                 | 14 ++++++++++++++
 repository.h                 |  7 +++++++
 sparse-index.c               |  7 +++++--
 unpack-trees.c               |  3 ++-
 wt-status.c                  |  4 +++-
 21 files changed, 110 insertions(+), 42 deletions(-)

Range diff versus v6:
=====================
1:  7e3082125d ! 1:  48821a3848 environment: stop storing `core.attributesFile` globally
    @@ Commit message

         The `core.attributeFile` config value is parsed in
         git_default_core_config(), loaded eagerly and stored in the global
    -    variable `git_attributes_file`. Storing this value in a global variable
    -    can lead to it being overwritten by another repository when more than one
    -    Git repository run in the same Git process.
    +    variable `git_attributes_file`. Storing this value in a global
    +    variable can lead to it being overwritten by another repository when
    +    more than one Git repository run in the same Git process.

         Create a new struct `repo_config_values` to hold this value and
         other repository dependent values parsed by `git_default_config()`.
         This will ensure the current behaviour remains the same while also
         enabling the libification of Git.

    -    An accessor function 'repo_config_values()' is created and used to access
    -    the new struct member of the repository struct.
    -    This is to ensure that we detect if the struct repository has been
    -    initialized and also prevent double initialization of the repository.
    -
    -    It is important to note that `git_default_config()` is a wrapper to other
    -    `git_default_*_config()` functions such as `git_default_core_config()`.
    -    Therefore to access and modify this global variable,
    -    the change has to be made `git_default_core_config()`.
    +    An accessor function 'repo_config_values()' to ensure that we do not
    +    access an uninitialized repository, or an instance of a different
    +    repository than the current one.

         Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
         Mentored-by: Christian Couder <christian.couder@gmail.com>
    @@ environment.h: extern int assume_unchanged;
      extern int pack_compression_level;
      extern unsigned long pack_size_limit_cfg;

    + ## oss-fuzz/fuzz-commit-graph.c ##
    +@@ oss-fuzz/fuzz-commit-graph.c: int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
    + {
    + 	struct commit_graph *g;
    +
    ++	memset(the_repository, 0, sizeof(*the_repository));
    + 	initialize_repository(the_repository);
    +
    + 	/*
    +
      ## repository.c ##
     @@ repository.c: static void set_default_hash_algo(struct repository *repo)
      	repo_set_hash_algo(repo, algo);
    @@ repository.c: static void set_default_hash_algo(struct repository *repo)

     +struct repo_config_values *repo_config_values(struct repository *repo)
     +{
    ++	if (repo != the_repository)
    ++		BUG("trying to read config from wrong repository instance");
     +	if(!repo->initialized)
     +		BUG("config values from uninitialized repository");
     +	return &repo->config_values_private_;
    @@ repository.c: static void set_default_hash_algo(struct repository *repo)
      	ALLOC_ARRAY(repo->index, 1);
      	index_state_init(repo->index, repo);
      	repo->check_deprecated_config = true;
    -+	repo_config_values_init(repo_config_values(repo));
    ++	repo_config_values_init(&repo->config_values_private_);

      	/*
      	 * When a command runs inside a repository, it learns what
2:  8645b4f595 ! 2:  7d33f1ef0f environment: stop using core.sparseCheckout globally
    @@ builtin/clone.c: static int git_sparse_checkout_init(const char *repo)
      	struct child_process cmd = CHILD_PROCESS_INIT;
      	int result = 0;
     +	struct repo_config_values *cfg = repo_config_values(the_repository);
    ++
      	strvec_pushl(&cmd.args, "-C", repo, "sparse-checkout", "set", NULL);

      	/*
    @@ dir.c: enum pattern_match_result path_matches_pattern_list(
      {
     -	if (!core_apply_sparse_checkout)
     +	struct repo_config_values *cfg = repo_config_values(the_repository);
    ++
     +	if (!cfg->apply_sparse_checkout)
      		return 1;
      	if (istate->sparse_checkout_patterns)
    @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate
      {
     -	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
     +	struct repo_config_values *cfg = repo_config_values(the_repository);
    ++
     +	if (!cfg->apply_sparse_checkout || !core_sparse_checkout_cone)
      		return 0;

3:  60451b93a5 = 3:  c3ecfa63b9 environment: move "branch.autoSetupMerge" into `struct repo_config_values`


-- 
2.34.1

