Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB2C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 21:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351471AbiE0VJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 17:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiE0VJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 17:09:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500801269B9
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:09:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d5-20020a05600c34c500b0039776acee62so2702802wmq.1
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ejGDoUxhHLDw+2TqgL9AvZCkASPBjKRoGgF9ckMjv5M=;
        b=gHUqN3dVnRnxqSBgRBxRgFlSRO/Th2tqxT6yNEqJ6v1YL+WP2MAGe1FRYn0moUyVYQ
         IHhdqpDyE6P6c0BbFPf8FM3YAhS6EE0A3kzrmHezIasgsp+3M6XmwpOzzy9SGccEM+YA
         vuetIWvezZdDsXizO588x8mqbBcdQW5M+5rS2pwg62Gu556g57l21LTyJ5bLIdc85K3v
         iU5eJcDRSEHLRxFWYFPN6hq139XSYQ6bfFV7Nmho0Qq4oNPr+3C+vcyR3HL6R1NMKps1
         docDVAXmAzZjrW02UHFt9eiJeKEJLwkfDF1ejM0vt7VfYuQlP+ItSFeJ3HxaI/zXj8hp
         RAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ejGDoUxhHLDw+2TqgL9AvZCkASPBjKRoGgF9ckMjv5M=;
        b=VwTZOPusnWCJIA20pWv+qmCkiaLGK+0CL++K5CVPd6d6DquYc0pBOxGTGByUwaRQ5L
         MozPcrjfuQtoZgV263/0gM4tUrItHRuUbTjDkXYc1tnLBc+oaByG4MRrUzZZVIn1nMNP
         D098+2xWjRkWGj/xKNsLmLdLMK7CyCjpcM+QHsq3XV4Pe1RNEm+KduEklrQjYIkXnG3U
         ZadXhqX0gWJPE/86CmdqbhKjJWRdU/xbg4nzVIz2ZlJeJLvAE000RZvwwUgdN6N3HrNb
         7TPluqAQT9s9YYIm84Pk6XyO0+52OBMVejPkJQO+orOjicxlS/5kMWuevSFMGnqxtxzg
         9oug==
X-Gm-Message-State: AOAM533bSHgC69KayeSqyc2ne1q6QX0vUKbFy0k0K1GF+dbSrsrX2JXh
        ncetslAUynwDmwFgXPox2OIvUNJKNVk=
X-Google-Smtp-Source: ABdhPJyYtL/Ha+oxQp7bFU4RpyY7dpT9pi2gSyMkAdObnAFo1kf6HgIb00TKOipcG9lg9CUPnPGdwQ==
X-Received: by 2002:a05:600c:198f:b0:394:952d:9a72 with SMTP id t15-20020a05600c198f00b00394952d9a72mr8456309wmq.72.1653685763255;
        Fri, 27 May 2022 14:09:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v26-20020a05600c215a00b003974b80a98bsm3012770wml.26.2022.05.27.14.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 14:09:22 -0700 (PDT)
Message-Id: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 21:09:16 +0000
Subject: [PATCH v3 0/5] config: introduce discovery.bare and protected config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for the feedback. This round has two major changes compared
to the last:

 * This feature is now purely motivated by the embedded bare repo attack;
   I've dropped all of language pertaining to 'simplifying' bare repository
   discovery.

 * Protected config gets a formal definition and is implemented using a
   config_set, which should hopefully address most of the performance
   concerns of using read_very_early_config() (see 2/5 for more discussion).
   
   With this new implementation, it's easy to teach protected config to
   include "-c". This round includes some patches (4-5/5) that do this but
   I'm ok to drop them if we don't agree that they are a good idea.

This round is newly rebased onto master because
sg/safe-directory-tests-and-docs has been recently integrated and the "-c"
patches directly contradict that.

= Description

There is a known social engineering attack that takes advantage of the fact
that a working tree can include an entire bare repository, including a
config file. A user could run a Git command inside the bare repository
thinking that the config file of the 'outer' repository would be used, but
in reality, the bare repository's config file (which is attacker-controlled)
is used, which may result in arbitrary code execution. See [1] for a fuller
description and deeper discussion.

This series implements a simple way of preventing such attacks: create a
config option, discovery.bare, that tells Git whether or not to die when it
finds a bare repository. discovery.bare has two values:

 * "always": always allow bare repositories (default), identical to current
   behavior
 * "never": never allow bare repositories

and users/system administrators who never expect to work with bare
repositories can secure their environments using "never". discovery.bare has
no effect if --git-dir or GIT_DIR is passed because we are confident that
the user is not confused about which repository is being used.

This series does not change the default behavior, but in the long-run, a
"no-embedded" option might be a safe and usable default [2]. "never" is too
restrictive and unlikely to be the default.

For security reasons, discovery.bare cannot be read from repository-level
config (because we would end up trusting the embedded bare repository that
we aren't supposed to trust to begin with). Since this would introduce a 3rd
variable that is only read from 'protected/trusted config' (the others are
safe.directory and uploadpack.packObjectsHook) this series also defines and
creates a shared implementation for 'protected config'

= Patch organization

 * Patches 1-2 define "protected config" and create a shared implementation.
 * Patch 3 introduces discovery.bare.
 * Patches 4-5 expand the definition of "protected config" to include the
   CLI option "-c" [3]. Since this is identical to how
   uploadpack.packObjectsHook currently behaves, it is refactored to a
   "protected config only" variable.

= Series history

Changes in v3:

 * Rebase onto a more recent 'master'
 * Reframe this feature in only in terms of the 'embedded bare repo' attack.
 * Other docs improvements (thanks Stolee in particular!)
 * Protected config no longer uses read_very_early_config() and is only read
   once
 * Protected config now includes "-c"
 * uploadpack.packObjectsHook now uses protected config instead of ignoring
   repo config using config scopes

Changes in v2:

 * Rename safe.barerepository to discovery.bare and make it die()
 * Move tests into t/t0034-discovery-bare.sh
 * Avoid unnecessary config reading by using a static variable
 * Add discovery.bare=cwd
 * Fix typos

= Future work

 * This series does not implement the "no-embedded" option [2] and I won't
   work on it any time soon, but I'd be more than happy to review if someone
   sends patches.
 * With discovery.bare, if a builtin is marked RUN_SETUP_GENTLY, setup.c
   doesn't die() and we don't tell users why their repository was rejected,
   e.g. "git config" gives an opaque "fatal: not in a git directory". This
   isn't a new problem though, since safe.directory has the same issue.

[1]
https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com
[2] This was first suggested in
https://lore.kernel.org/git/5b969c5e-e802-c447-ad25-6acc0b784582@github.com
[3] https://lore.kernel.org/git/xmqqlevabcsu.fsf@gitster.g/ suggests that
safe.directory doesn't need to ignore "-c", it just happened to be
implemented that way.

Glen Choo (5):
  Documentation: define protected configuration
  config: read protected config with `git_protected_config()`
  setup.c: create `discovery.bare`
  config: include "-c" in protected config
  upload-pack: make uploadpack.packObjectsHook protected

 Documentation/config.txt            |  8 ++++
 Documentation/config/discovery.txt  | 19 ++++++++
 Documentation/config/safe.txt       | 19 ++++----
 Documentation/config/uploadpack.txt | 22 ++++------
 Documentation/glossary-content.txt  | 18 ++++++++
 config.c                            | 41 +++++++++++++++++
 config.h                            | 17 ++++++++
 repository.c                        |  5 +++
 repository.h                        |  8 ++++
 setup.c                             | 68 ++++++++++++++++++++++++++++-
 t/t0033-safe-directory.sh           | 24 +++++-----
 t/t0035-discovery-bare.sh           | 63 ++++++++++++++++++++++++++
 upload-pack.c                       | 17 +++++---
 13 files changed, 283 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/config/discovery.txt
 create mode 100755 t/t0035-discovery-bare.sh


base-commit: f9b95943b68b6b8ca5a6072f50a08411c6449b55
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1261%2Fchooglen%2Fsetup%2Fdisable-bare-repo-config-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1261/chooglen/setup/disable-bare-repo-config-v3
Pull-Request: https://github.com/git/git/pull/1261

Range-diff vs v2:

 -:  ----------- > 1:  575676c760d Documentation: define protected configuration
 -:  ----------- > 2:  7499a280961 config: read protected config with `git_protected_config()`
 1:  22b10bf9da8 ! 3:  d5a3e9f9845 setup.c: make bare repo discovery optional
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    setup.c: make bare repo discovery optional
     +    setup.c: create `discovery.bare`
      
     -    Add a config variable, `discovery.bare`, that tells Git whether or not
     -    it should work with the bare repository it has discovered i.e. Git will
     -    die() if it discovers a bare repository, but it is not allowed by
     -    `discovery.bare`. This only affects repository discovery, thus it has no
     -    effect if discovery was not done (e.g. `--git-dir` was passed).
     +    There is a known social engineering attack that takes advantage of the
     +    fact that a working tree can include an entire bare repository,
     +    including a config file. A user could run a Git command inside the bare
     +    repository thinking that the config file of the 'outer' repository would
     +    be used, but in reality, the bare repository's config file (which is
     +    attacker-controlled) is used, which may result in arbitrary code
     +    execution. See [1] for a fuller description and deeper discussion.
      
     -    This is motivated by the fact that some workflows don't use bare
     -    repositories at all, and users may prefer to opt out of bare repository
     -    discovery altogether:
     +    A simple mitigation is to forbid bare repositories unless specified via
     +    `--git-dir` or `GIT_DIR`. In environments that don't use bare
     +    repositories, this would be minimally disruptive.
      
     -    - An easy assumption for a user to make is that Git commands run
     -      anywhere inside a repository's working tree will use the same
     -      repository. However, if the working tree contains a bare repository
     -      below the root-level (".git" is preferred at the root-level), any
     -      operations inside that bare repository use the bare repository
     -      instead.
     -
     -      In the worst case, attackers can use this confusion to trick users
     -      into running arbitrary code (see [1] for a deeper discussion). But
     -      even in benign situations (e.g. a user renames ".git/" to ".git.old/"
     -      and commits it for archival purposes), disabling bare repository
     -      discovery can be a simpler mode of operation (e.g. because the user
     -      doesn't actually want to use ".git.old/") [2].
     -
     -    - Git won't "accidentally" recognize a directory that wasn't meant to be
     -      a bare repository, but happens to resemble one. While such accidents
     -      are probably very rare in practice, this lets users reduce the chance
     -      to zero.
     +    Create a config variable, `discovery.bare`, that tells Git whether or
     +    not to die() when it discovers a bare repository. This only affects
     +    repository discovery, thus it has no effect if discovery was not
     +    done (e.g. `--git-dir` was passed).
      
          This config is an enum of:
      
     -    - ["always"|(unset)]: always recognize bare repositories (like Git does
     -      today)
     -    - "never": never recognize bare repositories
     +    - "always": always allow bare repositories (this is the default)
     +    - "never": never allow bare repositories
      
     -    More values are expected to be added later, and the default is expected
     -    to change (i.e. to something other than "always").
     +    If we want to protect users from such attacks by default, neither value
     +    will suffice - "always" provides no protection, but "never" is
     +    impractical for bare repository users. A more usable default would be to
     +    allow only non-embedded bare repositories ([2] contains one such
     +    proposal), but detecting if a repository is embedded is potentially
     +    non-trivial, so this work is not implemented in this series.
      
          [1]: https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com
     -    [2]: I don't personally know anyone who does this as part of their
     -    normal workflow, but a cursory search on GitHub suggests that there is a
     -    not insubstantial number of people who munge ".git" in order to store
     -    its contents.
     -
     -    https://github.com/search?l=&o=desc&p=1&q=ref+size%3A%3C1000+filename%3AHEAD&s=indexed&type=Code
     -    (aka search for the text "ref", size:<1000, filename:HEAD)
     +    [2]: https://lore.kernel.org/git/5b969c5e-e802-c447-ad25-6acc0b784582@github.com
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     -    WIP setup.c: make discovery.bare die on failure
     -
     -    Signed-off-by: Glen Choo <chooglen@google.com>
     + ## Documentation/config.txt ##
     +@@ Documentation/config.txt: include::config/diff.txt[]
     + 
     + include::config/difftool.txt[]
     + 
     ++include::config/discovery.txt[]
     ++
     + include::config/extensions.txt[]
     + 
     + include::config/fastimport.txt[]
      
       ## Documentation/config/discovery.txt (new) ##
      @@
      +discovery.bare::
     -+	Specifies what kinds of directories Git can recognize as a bare
     -+	repository when looking for the repository (aka repository
     -+	discovery). This has no effect if repository discovery is not
     -+	performed e.g. the path to the repository is set via `--git-dir`
     -+	(see linkgit:git[1]).
     ++	'(Protected config only)' Specifies whether Git will work with a
     ++	bare repository that it found during repository discovery. This
     ++	has no effect if the repository is specified directly via the
     ++	--git-dir command-line option or the GIT_DIR environment
     ++	variable (see linkgit:git[1]).
      ++
     -+This config setting is only respected when specified in a system or global
     -+config, not when it is specified in a repository config or via the command
     -+line option `-c discovery.bare=<value>`.
     ++The currently supported values are:
      ++
     -+The currently supported values are `always` (Git always recognizes bare
     -+repositories) and `never` (Git never recognizes bare repositories).
     -+This defaults to `always`, but this default is likely to change.
     ++* `always`: Git always works with bare repositories
     ++* `never`: Git never works with bare repositories
      ++
     -+If your workflow does not rely on bare repositories, it is recommended that
     -+you set this value to `never`. This makes repository discovery easier to
     -+reason about and prevents certain types of security and non-security
     -+problems, such as:
     -+
     -+* `git clone`-ing a repository containing a malicious bare repository
     -+  inside it.
     -+* Git recognizing a directory that isn't meant to be a bare repository,
     -+  but happens to look like one.
     ++This defaults to `always`, but this default may change in the future.
     +++
     ++If you do not use bare repositories in your workflow, then it may be
     ++beneficial to set `discovery.bare` to `never` in your global config.
     ++This will protect you from attacks that involve cloning a repository
     ++that contains a bare repository and running a Git command within that
     ++directory.
      
       ## setup.c ##
      @@
     @@ setup.c: static int ensure_valid_ownership(const char *path)
      +static int check_bare_repo_allowed(void)
      +{
      +	if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN) {
     -+		read_very_early_config(discovery_bare_cb, NULL);
     -+		/* We didn't find a value; use the default. */
     -+		if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN)
     -+			discovery_bare_config = DISCOVERY_BARE_ALWAYS;
     ++		discovery_bare_config = DISCOVERY_BARE_ALWAYS;
     ++		git_protected_config(discovery_bare_cb, NULL);
      +	}
      +	switch (discovery_bare_config) {
      +	case DISCOVERY_BARE_NEVER:
      +		return 0;
      +	case DISCOVERY_BARE_ALWAYS:
      +		return 1;
     -+	default:
     ++	case DISCOVERY_BARE_UNKNOWN:
      +		BUG("invalid discovery_bare_config %d", discovery_bare_config);
      +	}
     ++	return 0;
      +}
      +
      +static const char *discovery_bare_config_to_string(void)
     @@ setup.c: static int ensure_valid_ownership(const char *path)
      +		return "never";
      +	case DISCOVERY_BARE_ALWAYS:
      +		return "always";
     -+	default:
     ++	case DISCOVERY_BARE_UNKNOWN:
      +		BUG("invalid discovery_bare_config %d", discovery_bare_config);
      +	}
     ++	return NULL;
      +}
      +
       enum discovery_result {
     @@ setup.c: enum discovery_result {
       	GIT_DIR_INVALID_GITFILE = -3,
      -	GIT_DIR_INVALID_OWNERSHIP = -4
      +	GIT_DIR_INVALID_OWNERSHIP = -4,
     -+	GIT_DIR_DISALLOWED_BARE = -5
     ++	GIT_DIR_DISALLOWED_BARE = -5,
       };
       
       /*
     @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
       		/*
       		 * As a safeguard against setup_git_directory_gently_1 returning
      
     - ## t/t0034-discovery-bare.sh (new) ##
     + ## t/t0035-discovery-bare.sh (new) ##
      @@
      +#!/bin/sh
      +
     @@ t/t0034-discovery-bare.sh (new)
      +
      +pwd="$(pwd)"
      +
     -+expect_allowed () {
     -+	git rev-parse --absolute-git-dir >actual &&
     -+	echo "$pwd/outer-repo/bare-repo" >expected &&
     -+	test_cmp expected actual
     -+}
     -+
      +expect_rejected () {
     -+	test_must_fail git rev-parse --absolute-git-dir 2>err &&
     ++	test_must_fail git rev-parse --git-dir 2>err &&
      +	grep "discovery.bare" err
      +}
      +
     @@ t/t0034-discovery-bare.sh (new)
      +test_expect_success 'discovery.bare unset' '
      +	(
      +		cd outer-repo/bare-repo &&
     -+		expect_allowed &&
     -+		cd refs/ &&
     -+		expect_allowed
     ++		git rev-parse --git-dir
      +	)
      +'
      +
     @@ t/t0034-discovery-bare.sh (new)
      +	git config --global discovery.bare always &&
      +	(
      +		cd outer-repo/bare-repo &&
     -+		expect_allowed &&
     -+		cd refs/ &&
     -+		expect_allowed
     ++		git rev-parse --git-dir
      +	)
      +'
      +
     @@ t/t0034-discovery-bare.sh (new)
      +	git config --global discovery.bare never &&
      +	(
      +		cd outer-repo/bare-repo &&
     -+		expect_rejected &&
     -+		cd refs/ &&
      +		expect_rejected
     -+	) &&
     ++	)
     ++'
     ++
     ++test_expect_success 'discovery.bare in the repository' '
     ++	(
     ++		cd outer-repo/bare-repo &&
     ++		# Temporarily set discovery.bare=always, otherwise git
     ++		# config fails with "fatal: not in a git directory"
     ++		# (like safe.directory)
     ++		git config --global discovery.bare always &&
     ++		git config discovery.bare always &&
     ++		git config --global discovery.bare never &&
     ++		expect_rejected
     ++	)
     ++'
     ++
     ++test_expect_success 'discovery.bare on the command line' '
     ++	git config --global discovery.bare never &&
      +	(
     -+		GIT_DIR=outer-repo/bare-repo &&
     -+		export GIT_DIR &&
     -+		expect_allowed
     ++		cd outer-repo/bare-repo &&
     ++		test_must_fail git -c discovery.bare=always rev-parse --git-dir 2>err &&
     ++		grep "discovery.bare" err
      +	)
      +'
      +
 2:  62070aab7eb < -:  ----------- setup.c: learn discovery.bareRepository=cwd
 -:  ----------- > 4:  66a0a208176 config: include "-c" in protected config
 -:  ----------- > 5:  e25d5907cd1 upload-pack: make uploadpack.packObjectsHook protected

-- 
gitgitgadget
