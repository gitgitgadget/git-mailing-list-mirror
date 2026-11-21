Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795273859;
	b=V98jcAK3v+6y7XePVUIbrFWXOsrv+uSaIo27DRHGpe3qU6165CJaH+96rgmJFe+9/Z+m
	 ggn0LDVE6prI8KwOudfEW8kE08nRKCLFXMnxrgPqXWpHGaWUWNN9VUEsEOZMdC3mGN5yF
	 pgltmZm8Nd/DwS1iiPZowpaNUBAwRJGrZDW8K9XRGRuENHVCbrdbyh62AxH2/03/j7xAa
	 qZaU5ktqh4KeBWg2QMEN9QcZAdlTR0WEHPbmxkThPvo8ObBsmdqFhybyO9z/ejq1lkI9m
	 ojwOwlDz+9WvbSZ4K4xPgnPe7Gm7p5ovE6oa5ziPcs52NqxQ+CLIfPzE3Xe3X1//o2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795273859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=NQiSdHRd/X1AR+SA5XBBKpoP0KkPmUhOcLbgGBXN4iY=;
	b=nOX1UXmWUtrxa4E8TV6Mv5KCE+2S3wW87KFPtRSltgB9s0btSp+mdJ+kusmjbP5kj6P1
	 rZwnjryR9hwRf+0+kOeysvoYXkdJjt6AF9hHI2kHJnx93jF1vbIeCf+CvgCL9f2wKm1Bn
	 IkGJ2gTTDGC23/HwiFZrh7jRyLk5HGHRpYg/PWIkgH/mpsjBMMlauBlUH8x0hghEm5W4h
	 GVIgWa9VmnG9cfT/L4bajHqJ2HAMrPwZ+uojhix7DeB9rfzqGzfTPwZHE66MPzQ9UQaC6
	 MI8gP+HZOXZEctgMD7O+oz4zRJRiibIZbewjlzdOQ4BX+ZIt3YzYcGVi2PIEbLNU9kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0X6uhd+v;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED6606A33A
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 15:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67ED6606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0X6uhd+v
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4a76f0cce5fso896734fac.2
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 07:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795273856; x=1795878656; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NQiSdHRd/X1AR+SA5XBBKpoP0KkPmUhOcLbgGBXN4iY=;
        b=0X6uhd+vZIi7rlpU8ZyDH9eNjZ7k3Wf1+x2AzkKFUPnZU6nldJ0kubSODvBzP2Jr8X
         02LioBa7av3jnCKYLEvppuVZqxWEiBkfMg0Q4BGeX+LmNCFoCfdkIqiGVrKx/v+VPPsp
         mQIygFfsSEIhdW+RK+XFCKx2zXkWbiXDezcusuGKFaHvahvxTbtppnz8YC9wNRhIwT3Z
         oJxv3H7y3vCHWwtRtFpK1DUgOtvrWikLkXP4GqCa8iKRjzLB1/tHKVzqI63cPxbgTgBw
         fxS2ZEOhT29uOWHuvn8PN7DwuoCELeLi3B0kKG9onBwi7kLsBE5uslPXSfYQ8D51whXj
         roJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795273856; x=1795878656;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NQiSdHRd/X1AR+SA5XBBKpoP0KkPmUhOcLbgGBXN4iY=;
        b=a3FN6Qw36PGMjZ9SUMOvbaqlwTEJTBxpc99brWt1q9NXsx7tIR4NTk6FUvdOcc5Lt/
         MNqKdhnO1afsAce85KFQ51OvupLjAU1fxIzts32H2aNGsa4VayfywFKD1JrsyMyz5Mjx
         uEbwkGq/qsYgbGoPk0ddzoiz5nlvh+w45ifCMb0EEN8WblxCuI9zxFwLeLcTkEHy0Ikv
         dVjkAqisU75/6t2gDrZXmM8n1IeYfThL4ngv2CZdbGPfbTMK/nxXFVplD5OtpUffaigZ
         rdHW71Wi1fF9cEfFUPh946fkEe5IlSfAVbXufZbqrj1nl00Z99Pcagk8j48DWoHS11CA
         OHzQ==
X-Gm-Message-State: APuU4Z//+pWZ85zTy45TJXd05rndZQ2NJ2Q4BExRi03TUFRWkBS7EXrh
	zlhGvESniyYs1yqvim6jRPoXlDHdTRtmgPV9pk4TMuILvcmqO16Q5W3dSXH0Dlfp
X-Gm-Gg: AZFdTZcF75u3exTSqNuilgXK+yWkbakTN0twU1dTTz2R12lF/etqYAnfXpAmUjOf7wR
	+AIwqa9Hfr0G1YL8Euj/BAFoWFwh0MkcShDIqGHQo2yDkqavnYWpLk80gqodSqLqmRs0ACQtkS0
	J0ykWOBoNYZz2m76Re5sZnSTDuq4eoSIgRGE3E9NwP8fZCTzfp5t4mBx02R1Qdy/WWOh10jE3q4
	L/WUFo2gloe7ovOTayeR6rkyb4KQd/BDjns+G6LmLnXvcdzpUWx/ighNfyVVl3o+dLQyA+CHPqu
	oD+Y3uuFmkinRwQgJep7t51YghiiN0R5sRWmnZn4zscxIt9AtPG/LUd6R0zJIN3WTkyIIYWeHao
	kAprzKbIuE6Y20q+X2mgnfrc1lAKHDs58MfAdw7BKoTpfwr+p2NJUTd0/gU+ElijlZzNJ1r7fcz
	0Sa8JeKQZvmOwswNjDIDtyNbUdBx0zcPImCvgszIScPH7Xa4apmggqxHVWCV3jGnD7BnLjcP447
	j2Wus75cRp86N1yZ/S/ACPEs4SOIIO0eP+VgYvlsLsZoN2bpO5dibxRlgvEWpW0ee9JWN0USyug
	KQl/dvSB8B+vJxfrwoAVpkNIrANDJcY=
X-Received: by 2002:a05:6870:2485:b0:4ad:514d:b19c with SMTP id 586e51a60fabf-4bc81aa23d1mr6143900fac.11.1795273856102;
        Sat, 21 Nov 2026 07:10:56 -0800 (PST)
Received: from [127.0.0.1] ([9.234.15.210])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5edc52aasm6488244fac.4.2026.11.21.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 07:10:55 -0800 (PST)
Message-Id: <pull.2306.v2.git.1795273853.gitgitgadget@gmail.com>
In-Reply-To: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 15:10:50 +0000
Subject: [PATCH v2 0/3] submodule: support worktree-specific configuration
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

When using multiple worktrees, submodule settings stored in the repository
config are shared between all worktrees, even when they need to differ.

For example, different branches may use different URLs for the same
submodule. More importantly, sharing submodule.<name>.gitdir causes
submodule worktrees to share the same HEAD and index, even when the
corresponding superproject worktrees record different commits for the
submodule.

This series makes submodule settings worktree-specific when
extensions.worktreeConfig is enabled. It also keeps submodule.<name>.gitdir
relative for linked worktrees, so it continues to work when the worktree is
moved along with the main worktree.

The changes include:

 * [1/3] Keep submodule.<name>.gitdir relative for linked worktrees.
 * [2/3] Store submodule settings in the worktree config when
   extensions.worktreeConfig is enabled.
 * [3/3] Make git submodule init copy an existing gitdir setting to the
   current worktree config only when it belongs to that worktree.


Changes in v2
=============

 * Update the cover letter to better explain the problems this series
   addresses.
 * [1/3] Copy the string returned by worktree_git_path() early.
 * [2/3] Expand the explanation in the commit message for why the gitdir
   config is excluded from worktree add.
 * [3/3] Explain the case where the repository config contains a gitdir
   setting for another worktree, and warn when the setting is not copied.

Yoichi NAKAYAMA (3):
  submodule: make submodule.<name>.gitdir relative for worktrees
  submodule: store settings in worktree config when enabled
  submodule init: copy submodule.<name>.gitdir to config.worktree

 Documentation/config/submodule.adoc        |   3 +-
 builtin/submodule--helper.c                | 213 ++++++++++++++++-----
 builtin/worktree.c                         |  23 +++
 t/t2405-worktree-submodule.sh              | 129 +++++++++++++
 t/t7425-submodule-gitdir-path-extension.sh | 135 +++++++++++++
 5 files changed, 451 insertions(+), 52 deletions(-)


base-commit: f7de81456940dd6f3274e461149bba12965de609
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2306%2Fyoichi%2Fsubmodule-with-worktree-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2306/yoichi/submodule-with-worktree-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2306

Range-diff vs v1:

 1:  f9adc6c85c ! 1:  435ca42ec9 submodule: make submodule.<name>.gitdir relative for worktrees
     @@ builtin/submodule--helper.c: static int validate_and_set_submodule_gitdir(struct
      +	modules_dir = worktree_git_path(wt, "modules/");
      +	if (is_absolute_path(modules_dir)) {
      +		modules_dir = relative_path(modules_dir, wt->path, &tmp);
     ++	} else {
     ++		strbuf_addstr(&tmp, modules_dir);
     ++		modules_dir = tmp.buf;
       	}
       
      +	/* Case 1: try the plain module name */
 2:  14b156bc42 ! 2:  e816484923 submodule: store settings in worktree config when enabled
     @@ Commit message
          `submodule.<name>.active` to false in the worktree config to
          unregister the submodule.
      
     -    Unlike other settings, `submodule.<name>.gitdir` should not be shared
     -    between worktrees, so exclude it from the config copied by 'git
     +    Unlike other settings, `submodule.<name>.gitdir` must not be shared
     +    between worktrees. Different commits in the superproject may record
     +    different commits for the same submodule. If the gitdir is shared, the
     +    submodule worktrees end up sharing the same `HEAD` and index, causing
     +    Git commands to behave incorrectly. Therefore, store this setting in
     +    the worktree config and exclude it from the config copied by 'git
          worktree add'.
      
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
 3:  cdf089b635 ! 3:  b5d203d014 submodule init: copy submodule.<name>.gitdir to config.worktree
     @@ Metadata
       ## Commit message ##
          submodule init: copy submodule.<name>.gitdir to config.worktree
      
     -    If a repository already has gitdir settings in its repository config
     -    when extensions.worktreeConfig is enabled, those settings belong to a
     -    particular worktree. Make 'git submodule init' copy an existing
     -    setting to the worktree config if it belongs to the current worktree;
     -    otherwise, generate a new setting.
     +    When extensions.worktreeConfig is enabled, an existing
     +    `submodule.<name>.gitdir` setting in the repository config may have
     +    been written by 'git submodule init' in another worktree. Reusing
     +    that setting would cause the current worktree to use the submodule
     +    gitdir of the other worktree.
     +
     +    Make 'git submodule init' copy an existing setting to the worktree
     +    config only if it belongs to the current worktree; otherwise, generate
     +    a new setting.
     +
     +    Warn when an existing setting does not match the current worktree and
     +    is not copied to the worktree config.
      
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
     @@ builtin/submodule--helper.c: struct init_cb {
       };
       #define INIT_CB_INIT { 0 }
       
     -+static int validate_submodule_git_dir_with_worktree(const char *gitdir)
     ++static bool submodule_git_dir_matches_current_worktree(const char *gitdir)
      +{
      +	struct strbuf tmp = STRBUF_INIT;
      +	struct strbuf submodule = STRBUF_INIT;
      +	char *super;
     -+	int ret = 1;
     ++	bool matches;
      +
      +	if (is_absolute_path(gitdir))
      +		strbuf_addstr(&submodule, gitdir);
      +	else if (!repo_worktree_path_append(the_repository, &submodule,
      +					    "%s", gitdir))
     -+		return -1;
     ++		return false;
      +
      +	if (strbuf_normalize_path(&submodule)) {
      +		strbuf_release(&submodule);
     -+		return -1;
     ++		return false;
      +	}
      +
      +	super = absolute_pathdup(repo_get_git_dir(the_repository));
     -+
     -+	if (starts_with(relative_path(submodule.buf, super, &tmp), "modules/"))
     -+		ret = 0;
     ++	matches = starts_with(relative_path(submodule.buf, super, &tmp),
     ++			      "modules/");
      +
      +	strbuf_release(&submodule);
      +	strbuf_release(&tmp);
      +	free(super);
     -+	return ret;
     ++	return matches;
      +}
     ++
     ++static const char submodule_mismatch_warning[] = N_(
     ++"config '%s' exists but was not copied to the worktree config because "
     ++"it does not point to a gitdir for the current worktree. If you want "
     ++"to keep using this setting, copy it to the worktree config."
     ++);
      +
       static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
      -					     const char *submodule_name)
     @@ builtin/submodule--helper.c: struct init_cb {
      +					     struct worktree *wt)
       {
      -	const char *value;
     -+	const char *value = gitdir_path->buf;
     -+	char *value_to_free = NULL;
     ++	char *value = NULL;
       	char *key;
       
       	if (validate_submodule_git_dir(gitdir_path->buf, submodule_name))
     @@ builtin/submodule--helper.c: static int validate_and_set_submodule_gitdir(struct
      +		 * worktree.
      +		 */
      +		if (!repo_config_get_string(the_repository, key, &tmp)) {
     -+			if (validate_submodule_git_dir_with_worktree(tmp) ||
     -+			    validate_submodule_git_dir(tmp, submodule_name))
     ++			bool matches =
     ++			  submodule_git_dir_matches_current_worktree(tmp);
     ++
     ++			if (!matches ||
     ++			    validate_submodule_git_dir(tmp, submodule_name)) {
     ++				if (!matches)
     ++					warning(submodule_mismatch_warning, key);
      +				free(tmp);
     -+			else
     -+				value = value_to_free = tmp;
     ++			} else {
     ++				value = tmp;
     ++			}
      +		}
      +	} else {
     ++		const char *value_;
     ++
      +		/* Nothing to do if the config already exists. */
     -+		if (!repo_config_get_string_tmp(the_repository, key, &value)) {
     ++		if (!repo_config_get_string_tmp(the_repository, key, &value_)) {
      +			free(key);
      +			return 0;
      +		}
       	}
       
      -	if (repo_config_set_worktree_gently(the_repository, key, gitdir_path->buf)) {
     -+	if (repo_config_set_worktree_gently(the_repository, key, value)) {
     ++	if (repo_config_set_worktree_gently(the_repository, key,
     ++					    value ? value : gitdir_path->buf)) {
       		free(key);
     -+		free(value_to_free);
     ++		free(value);
       		return -1;
       	}
       
       	free(key);
     -+	free(value_to_free);
     ++	free(value);
       	return 0;
       }
       
     @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --re
      +		git config submodule.sub2.gitdir .git/modules/sub2_custom &&
      +
      +		git config extensions.worktreeConfig true &&
     -+		git submodule init &&
     ++		git submodule init 2>err &&
     ++		test_must_be_empty err &&
      +		git config --worktree submodule.sub1.gitdir >actual &&
      +		echo ".git/modules/sub1_custom" >expect &&
      +		test_cmp expect actual &&
     @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --re
      +
      +		git worktree add wt &&
      +		cd wt &&
     -+		git submodule init &&
     ++		git submodule init 2>err &&
     ++		test_grep "does not point to a gitdir for the current worktree" err &&
      +		git config --worktree submodule.sub1.gitdir >actual &&
      +		echo "../.git/worktrees/wt/modules/sub1" >expect &&
      +		test_cmp expect actual &&
     @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'git submodule i
      +		git config submodule.sub2.gitdir "$(cd .. && pwd -P)/.git/worktrees/wt/modules/sub2_custom" &&
      +
      +		git config extensions.worktreeConfig true &&
     -+		git submodule init &&
     ++		git submodule init 2>err &&
     ++		test_must_be_empty err &&
      +		git config --worktree submodule.sub1.gitdir >actual &&
      +		echo "../.git/worktrees/wt/modules/sub1_custom" >expect &&
      +		test_cmp expect actual &&
     @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'git submodule i
      +		test_cmp expect actual &&
      +
      +		cd .. &&
     -+		git submodule init &&
     ++		git submodule init 2>err &&
     ++		test_grep "does not point to a gitdir for the current worktree" err &&
      +		git config --worktree submodule.sub1.gitdir >actual &&
      +		echo ".git/modules/sub1" >expect &&
      +		test_cmp expect actual &&

-- 
gitgitgadget
