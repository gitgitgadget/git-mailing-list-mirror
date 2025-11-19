Received: from sender3-op-o12.zoho.com (sender3-op-o12.zoho.com [136.143.184.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E4C2EBBBC
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586714; cv=pass; b=EqIZckf7hLp88ExDRGplsNfGQtfql0EvpvHIEqal5M0zxxE+EXJ6vr2CsQ/u89QNLS1TsBBlFkkoWqu5SMFGtr6SJ6Cea7MVe27yJizTPLiPrdoTnn8F79Ql5Qq5YAdvSw7w5UcgM1UF8AL/wbhBFAuc/0KL5X75fIQmYU2bEmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586714; c=relaxed/simple;
	bh=K8+cLvNARkpBxu07r29GcC088INcWDQj/NglyA/sZG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdw6JcODCRBpMSwBj0x5ew+jw/AyapynX60Xx+iyiw5NC2nRAZzz+eUHai9OZ7VfLV6CNEcVlm1IG64jgpZPFYo4YieQT1rA1X8JvQuMN4ny7kYVxY0+ePiq1BLVtzN7kabavzrF4EuHyIIsMYeb4Rhxf35Me8ZwJMUibFYraBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=YasxSq6h; arc=pass smtp.client-ip=136.143.184.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="YasxSq6h"
ARC-Seal: i=1; a=rsa-sha256; t=1763586672; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lScn6JfkHdI8HiWqSur40u0YYrBa3WMBhFCE5eJTXh3pZiKGGIGDveB7M67xZQcyPy0WGEoMdp+x2s4AhdaWAzAbmGnKmnyoJEeZYWDceyUP7a3vxW0owECRm0JQzLPvEm2weKdrhgHTCXU49wu3F2BbkmGxqGN64RGGi7osmQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763586672; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l5XTZ+/gt/tHJv7KgNa2SCSsqmuEEL/4HkQGUy5QqpY=; 
	b=cacjnRx9sS/u23uUbqj6Tb6gNz53lxN+STXEJ8KB5SwBkZVGDYaeYnaXRok7iu4equ7rrLBGv+MuZJtfQFhNRA4ylugMBloaT6GCyYFcue0TQkSJSkmMFYkU2wIVCAWV/UwCD1eMk7Yj7nWnlZatDxYmL22sfwwfJnFilpZ2Dpw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763586672;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=l5XTZ+/gt/tHJv7KgNa2SCSsqmuEEL/4HkQGUy5QqpY=;
	b=YasxSq6hPu/XvbdoZbii9xesHGkhkNZOF058xUzxc4Uon8Nm/rlknDfbMZDHohjX
	no6oU58Mo307KzSii5m8XhdqJq2wPvyVvLZXht/y5b0z+/6BEek+BJGNTMAf5crSE8i
	qRuv88KvN0coz4sRuRgr48C/sSt2OJEcAsS4vTyQ=
Received: by mx.zohomail.com with SMTPS id 1763586669773102.62214445241796;
	Wed, 19 Nov 2025 13:11:09 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v5 0/7] Encode submodule gitdir names to avoid conflicts
Date: Wed, 19 Nov 2025 23:10:23 +0200
Message-ID: <20251119211030.2008441-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

For those new to the series, we are adding an extension to fix submodule
gitdir path conflicts due to nested gitdirs or case-folding filesystems.

v5 contains code cleanups, more corner-case fixes and a few new commits
briefly described below, after which a range-diff follows.

As always this is based on the latest master, I've checked for conflicts
with the next/seen branches, pushed to GitHub [1] and CI passes [2].

Many thanks to all reviewers!

1: https://github.com/10ne1/git/tree/dev/aratiu/encoding-v5
2: https://github.com/10ne1/git/actions/runs/19515373994

Changes between v4 -> v5:
* Derive some new gitdir names in case the uppercase-extended encoding fails. (Aaron)
* Add more case-folding and extension disabling / cloning test corner-cases. (Aaron, Junio & Josh)
* Run the gitdir validation on the submodules.<name>.gitdir config after reading it. (Adrian)
* New commit: add a build-time option to enable the extension. (Josh)
* New commit: fallback to hashing if all encoding attempts fail. (Adrian)
* New commit: always validate the gitdir in submodule_name_to_git_dir. (Adrian)
* Split encoding validation in a separate function and leave non-enc validation intact. (Adrian)
* Add a CASE_INSENSITIVE_FS prereq for the case-folding tests. This will also significantly
  simplify case-folding validation, by not attempting to run on case-sensitive FS. (Adrian)
* Improve case-folding conflict detection by making validation more robust. (Adrian)
* Minor code fixes and improvements (spelling, error checking, indentation). (Adrian)

Range-diff between v4 -> v5:
1:  7d34507692 = 1:  9d5855f3bf submodule--helper: use submodule_name_to_gitdir in add_submodule
2:  1e609bdd1a = 2:  8cfa970a9d builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
-:  ---------- > 3:  7bcadf1116 submodule: always validate gitdirs inside submodule_name_to_gitdir
3:  c51fd58669 ! 4:  1b5d0b50ef submodule: add extension to encode gitdir paths
    @@ Documentation/config/extensions.adoc: relativeWorktrees:::
      
     +submoduleEncoding:::
     +	If enabled, submodule gitdir paths are encoded to avoid filesystem
    -+	conflicts due to nested gitdirs, case insensitivity or other issues
    ++	conflicts due to nested gitdirs, case insensitivity or other issues.
     +	When enabled, the submodule.<name>.gitdir config is always set for
    -+	all submodulesand is the single point of authority for gitdir paths.
    ++	all submodules and is the single point of authority for gitdir paths.
     +
      worktreeConfig:::
      	If enabled, then worktrees will load config settings from the
    @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
      }
      
     +/*
    -+ * Find the last submodule name in the gitdir path (modules can be nested).
    -+ * Returns a pointer into `path` to the beginning of the name or NULL if not found.
    ++ * Encoded gitdir validation function used when extensions.submoduleEncoding is enabled.
    ++ * This does not print errors like the non-encoded version, because encoding is supposed
    ++ * to mitigate / fix all these.
     + */
    -+static char *find_last_submodule_name(char *git_dir_path)
    ++static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodule_name UNUSED)
     +{
     +	const char *modules_marker = "/modules/";
    -+	char *p = git_dir_path;
    -+	char *last = NULL;
    ++	char *p = git_dir, *last_submodule_name = NULL;
     +
    ++	if (!the_repository->repository_format_submodule_encoding)
    ++		BUG("validate_submodule_encoded_git_dir() must be called with "
    ++		    "extensions.submoduleEncoding enabled.");
    ++
    ++	/* Find the last submodule name in the gitdir path (modules can be nested). */
     +	while ((p = strstr(p, modules_marker))) {
    -+		last = p + strlen(modules_marker);
    ++		last_submodule_name = p + strlen(modules_marker);
     +		p++;
     +	}
     +
    -+	return last;
    ++	/* Prevent the use of '/' in encoded names */
    ++	if (!last_submodule_name || strchr(last_submodule_name, '/'))
    ++		return -1;
    ++
    ++	return 0;
     +}
     +
    - int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
    + static int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
      {
      	size_t len = strlen(git_dir), suffix_len = strlen(submodule_name);
    --	char *p;
    -+	char *p = git_dir + len - suffix_len;
    -+	bool suffixes_match = !strcmp(p, submodule_name);
    + 	char *p;
      	int ret = 0;
      
    --	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
    --	    strcmp(p, submodule_name))
    --		BUG("submodule name '%s' not a suffix of git dir '%s'",
    --		    submodule_name, git_dir);
    --
    - 	/*
    - 	 * We prevent the contents of sibling submodules' git directories to
    - 	 * clash.
    -@@ submodule.c: int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
    - 	 * but the latter directory is already designated to contain the hooks
    - 	 * of the former.
    - 	 */
    --	for (; *p; p++) {
    -+	for (; *p && suffixes_match; p++) {
    - 		if (is_dir_sep(*p)) {
    - 			char c = *p;
    - 
    -@@ submodule.c: int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
    - 		}
    - 	}
    - 
    -+	/* tests after this check are only for encoded names, when the extension is enabled */
    -+	if (!the_repository->repository_format_submodule_encoding)
    -+		return 0;
    -+
    -+	/* Prevent the use of '/' in names */
    -+	p = find_last_submodule_name(git_dir);
    -+	if (p && strchr(p, '/') != NULL)
    -+		return error("submodule gitdir name '%s' contains unexpected '/'", p);
    ++	if (the_repository->repository_format_submodule_encoding)
    ++		BUG("validate_submodule_git_dir() must be called with "
    ++		    "extensions.submoduleEncoding disabled.");
     +
    - 	return 0;
    - }
    - 
    + 	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
    + 	    strcmp(p, submodule_name))
    + 		BUG("submodule name '%s' not a suffix of git dir '%s'",
     @@ submodule.c: int submodule_to_gitdir(struct repository *repo,
      	return ret;
      }
    @@ submodule.c: int submodule_to_gitdir(struct repository *repo,
     +{
     +	char *key;
     +
    -+	if (validate_submodule_git_dir(gitdir_path->buf, submodule_name))
    ++	if (validate_submodule_encoded_git_dir(gitdir_path->buf, submodule_name))
     +		return -1;
     +
     +	key = xstrfmt("submodule.%s.gitdir", submodule_name);
    @@ submodule.c: int submodule_to_gitdir(struct repository *repo,
     +	FREE_AND_NULL(key);
     +
     +	return 0;
    -+
     +}
     +
      void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
    @@ submodule.c: int submodule_to_gitdir(struct repository *repo,
     +	strbuf_addstr(buf, submodule_name);
     +
     +	/* If extensions.submoduleEncoding is disabled, use the plain path set above */
    -+	if (!r->repository_format_submodule_encoding)
    -+		return;
    ++	if (!r->repository_format_submodule_encoding) {
    ++		if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
    ++			die(_("refusing to create/use '%s' in another submodule's "
    ++			      "git dir"), buf->buf);
    ++
    ++		return; /* plain gitdir is valid for use */
    ++	}
     +
     +	/* Extension is enabled: use the gitdir config if it exists */
     +	key = xstrfmt("submodule.%s.gitdir", submodule_name);
    @@ submodule.c: int submodule_to_gitdir(struct repository *repo,
     +		strbuf_reset(buf);
     +		strbuf_addstr(buf, gitdir);
     +		FREE_AND_NULL(key);
    ++
    ++		/* validate because users might have modified the config */
    ++		if (validate_submodule_encoded_git_dir(buf->buf, submodule_name))
    ++			die(_("Invalid 'submodule.%s.gitdir' config: '%s' please check "
    ++			      "if it is unique or conflicts with another module"),
    ++			    submodule_name, gitdir);
    ++
     +		return;
     +	}
     +	FREE_AND_NULL(key);
    @@ submodule.c: int submodule_to_gitdir(struct repository *repo,
     +	strbuf_addstr_urlencode(buf, submodule_name, is_rfc3986_unreserved);
     +	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
     +		return;
    -+
    -+	/* Case 3: error out */
    + 
    +-	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
    +-		die(_("refusing to create/use '%s' in another submodule's "
    +-		      "git dir"), buf->buf);
    ++	/* Case 3: Nothing worked: error out */
     +	die(_("Cannot construct a valid gitdir path for submodule '%s': "
     +	      "please set a unique git config for 'submodule.%s.gitdir'."),
     +	    submodule_name, submodule_name);
    @@ t/t7425-submodule-encoding.sh (new)
     +		git submodule add ../legacy-sub legacy &&
     +		test_commit legacy-sub &&
     +
    ++		# trigger the "die_path_inside_submodule" check
    ++		test_must_fail git submodule add ../new-sub "legacy/nested" &&
    ++
     +		git config core.repositoryformatversion 1 &&
     +		git config extensions.submoduleEncoding true &&
     +
     +		git submodule add ../new-sub "New Sub" &&
    -+		test_commit new
    ++		test_commit new &&
    ++
    ++		# retrigger the "die_path_inside_submodule" check with encoding
    ++		test_must_fail git submodule add ../new-sub "New Sub/nested2"
     +	)
     +'
     +
    @@ t/t7425-submodule-encoding.sh (new)
     +	verify_submodule_gitdir_path clone_parallel hippo/hooks modules/hippo%2fhooks
     +'
     +
    ++test_expect_success 'disabling extensions.submoduleEncoding prevents nested submodules' '
    ++	(
    ++		cd clone_nested &&
    ++		# disable extension and verify failure
    ++		git config extensions.submoduleEncoding false &&
    ++		test_must_fail git submodule add ./thing2 hippo/foobar &&
    ++		# re-enable extension and verify it works
    ++		git config extensions.submoduleEncoding true &&
    ++		git submodule add ./thing2 hippo/foobar
    ++	)
    ++'
    ++
     +test_done
     
      ## t/t9902-completion.sh ##
4:  01a5b10d5a < -:  ---------- submodule: fix case-folding gitdir filesystem colisions
-:  ---------- > 5:  2bf1c116a2 submodule: fix case-folding gitdir filesystem colisions
-:  ---------- > 6:  b607d7ca39 submodule: use hashed name for gitdir
-:  ---------- > 7:  9b4890cfd2 meson/Makefile: allow setting submodule encoding at build time

Adrian Ratiu (7):
  submodule--helper: use submodule_name_to_gitdir in add_submodule
  builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
  submodule: always validate gitdirs inside submodule_name_to_gitdir
  submodule: add extension to encode gitdir paths
  submodule: fix case-folding gitdir filesystem colisions
  submodule: use hashed name for gitdir
  meson/Makefile: allow setting submodule encoding at build time

 Documentation/config/extensions.adoc  |   8 +
 Documentation/config/submodule.adoc   |   5 +
 Makefile                              |   5 +
 builtin/credential-store.c            |   7 +-
 builtin/submodule--helper.c           |  51 +++--
 configure.ac                          |  23 +++
 meson.build                           |   4 +
 meson_options.txt                     |   2 +
 repository.c                          |   1 +
 repository.h                          |   1 +
 setup.c                               |  15 ++
 setup.h                               |   1 +
 submodule.c                           | 234 ++++++++++++++++++-----
 submodule.h                           |   5 -
 t/lib-verify-submodule-gitdir-path.sh |  24 +++
 t/meson.build                         |   1 +
 t/t7425-submodule-encoding.sh         | 258 ++++++++++++++++++++++++++
 t/t9902-completion.sh                 |   1 +
 url.c                                 |  23 +++
 url.h                                 |   3 +
 20 files changed, 591 insertions(+), 81 deletions(-)
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh
 create mode 100755 t/t7425-submodule-encoding.sh

-- 
2.51.0

