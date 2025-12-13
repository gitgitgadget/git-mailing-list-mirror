Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B662673AA
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765613353; cv=pass; b=nb6goysqWzSy7qbwHwFPh4UsO5Yd5H4qV2PSW1f7mDEaa3m3KY4N1RQR8Hl7PqUguKxhAl4nx+jATXHXduLn68VFUlATUniQXffHzit1F/ORcYzJPxxgDmLansL+gLIS9IMxDkisaTlZ/CRdEbKL54b5Et7MFj6cKbImD0ZVw34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765613353; c=relaxed/simple;
	bh=lpmzRoycewTGfneX9FQjpXREVLSlNPqXtHNOr8ng82Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaDeIMTv2lKrVIZ/OVA1kxJnt0UKRC90poltDk7gpaW8JkKw399KAEM+ND/6bg9bdgiRwxJQZhPqgPgSLguxqcWshya6DxJrIl05YIhuRxZ9SlQYABJnuLYd9i3STTkkOlM2gPFVOCyFq5BqA6SEgNoGi3Y7sEoyMUwyBbTHe0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=gZlsST4M; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="gZlsST4M"
ARC-Seal: i=1; a=rsa-sha256; t=1765613331; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TXD5wrL3suA7oklpk0Mrkj/jn/HpfeUhJnAVplec5neDGUd9yi47Golc/q5LEbrwAWjznrKHAxpmdinHQcyeBYv5mUNUyhudziQD+eUHfAt99/19yXrN0PCki9AXdHE8zLzKfY7ZEU2Bc9BGL7DFJ8lDnbmQX1nz/y07qxHLel4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765613331; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wUHq54J8dIv9tYrAg1/PPASdjpcu5/CpJk4SY6ilUa8=; 
	b=EY8kK/ia8glrgqsF06ssJmYtWjlBTkWnQjEcRsrOqjemSbSFONJV03XDTA9vtnTEFRhcnL2pnaKaYXChbNELikWjrF155WDdkDXGXwoDNybgt1jLqyMX2+FNqjk7ScFQAQtHPEwa+lSlsxNH3L5+/ln1hEGhHZIl8plu5Lsvcy4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765613331;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wUHq54J8dIv9tYrAg1/PPASdjpcu5/CpJk4SY6ilUa8=;
	b=gZlsST4MaPHxet8nHkYklmhTacANa0V6ieg0gCIckJ3T6z2zZvacMdHh9YGRehXC
	qLtQB9J61dp+emt2jmY4ni+trIjyVT18rMipink6Ymyn5XwMV3asN5ROCoSGDnxUeBU
	fgdn4yy8+Bx4iMc0zDHpcHKL+OftYwtiK9d/Jmp8=
Received: by mx.zohomail.com with SMTPS id 1765613328200398.53474488948336;
	Sat, 13 Dec 2025 00:08:48 -0800 (PST)
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
Subject: [PATCH v6 00/10] Add submodulePathConfig extension and gitdir encoding
Date: Sat, 13 Dec 2025 10:08:06 +0200
Message-ID: <20251213080817.347922-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
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

For those new to the series, we're implementing a submodule gitdir
extension which allows us to have a unified way to determine gitdirs
and do things like encode submodule paths to avoid FS conflicts.

I debated with myself whether to split this into 2 separate series,
because after the latest redesign, our logic is cleanly split in 2:

Patches 1-6 implement the basic mechanisms of the new extension.
Patches 7-10 add submodule encoding on top.

Considering that all patches depend upon another and I'd be breaking
review continuity and range-diffs, I opted to send v6 as one series.
If anyone feels strongly about this, we could split in 2 series or
even land the patches 1-6 and 7-10 separately.

As always, this is based on the latest master branch, I've checkd
for conflicts with next/seen, pushed to Github [1] and succesfully
ran the CI [2].

1: https://github.com/10ne1/git/tree/dev/aratiu/encoding-v6
2: https://github.com/10ne1/git/actions/runs/20188634517

Changes in v6:
* Renamed the extension from submoduleEncoding to submodulePathConfig (Patrick)
* Decoupled the extension from the encoding conflict resolution (Patrick)
* Simplified submodule_name_to_gitdir() to error out if gitdir config is missing (Patrick)
* Not doing automated gitdir fallback migration anymore (Patrick)
* Added a global config (not repo config) for enabling the extension (Patrick)
* Added a migration command to submodule--helper (Patrick, Junio)
* Removed the build-time configuration option (Adrian, Patrick, Junio)
* Fixed a parallel clone race I introduced while moving gitdir validation (Peff)
  Was able to reproduce this race when using stress-limit > 30 like the following:
  make && (cd t && ./t7450-bad-git-dotfiles.sh --stress-limit=50)
* Added back an extra validation in submodule_move_head() for logic consistency (Patrick)
* Fixed minor nits, moved function comments to header files and so on (Patrick & Adrian)

v5 -> v6 range-diff:
 1:  9d5855f3bf =  1:  9d5855f3bf submodule--helper: use submodule_name_to_gitdir in add_submodule
 3:  7bcadf1116 !  2:  df2d7703f1 submodule: always validate gitdirs inside submodule_name_to_gitdir
    @@ Commit message
         after calling submodule_name_to_gitdir() into the function proper,
         which now always validates the gitdir before returning it.
     
    -    This also makes parallel operations a bit safer due to checking and
    -    erroring out each time the unified API detects a problem instead of
    -    having one extra hardcoded validation check in submodule--helper.c.
    +    This simplifies the API and helps to:
    +    1. Avoid redundant validation calls after submodule_name_to_gitdir().
    +    2. Avoid the risk of callers forgetting to validate.
    +    3. Ensure gitdir paths provided by users via configs are always valid
    +       (config gitdir paths are added in a subsequent commit).
     
    -    It simplifies the API usage as well since users who don't have to
    -    validate the submodule_name_to_gitdir() result themselves anymore
    -    and reduces the risks of API users forgetting to validate.
    +    The validation function can still be called as many times as needed
    +    outside submodule_name_to_gitdir(), for example we keep two calls
    +    which are still required, to avoid parallel clone races by re-running
    +    the validation in builtin/submodule-helper.c.
     
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
    @@ builtin/submodule--helper.c: static int clone_submodule(const struct module_clon
      	if (!file_exists(sm_gitdir)) {
      		if (clone_data->require_init && !stat(clone_data_path, &st) &&
      		    !is_empty_dir(clone_data_path))
    -@@ builtin/submodule--helper.c: static int clone_submodule(const struct module_clone_data *clone_data,
    - 		free(path);
    - 	}
    - 
    --	/*
    --	 * We already performed this check at the beginning of this function,
    --	 * before cloning the objects. This tries to detect racy behavior e.g.
    --	 * in parallel clones, where another process could easily have made the
    --	 * gitdir nested _after_ it was created.
    --	 *
    --	 * To prevent further harm coming from this unintentionally-nested
    --	 * gitdir, let's disable it by deleting the `HEAD` file.
    --	 */
    --	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0) {
    --		char *head = xstrfmt("%s/HEAD", sm_gitdir);
    --		unlink(head);
    --		free(head);
    --		die(_("refusing to create/use '%s' in another submodule's "
    --		      "git dir"), sm_gitdir);
    --	}
    --
    - 	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
    - 
    - 	p = repo_submodule_path(the_repository, clone_data_path, "config");
     
      ## submodule.c ##
     @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
    - 
    - 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
    - 		if (old_head) {
    --			if (!submodule_uses_gitfile(path))
    --				absorb_git_dir_into_superproject(path,
    --								 super_prefix);
    --			else {
    --				char *dotgit = xstrfmt("%s/.git", path);
    --				char *git_dir = xstrdup(read_gitfile(dotgit));
    --
    --				free(dotgit);
    --				if (validate_submodule_git_dir(git_dir,
    --							       sub->name) < 0)
    --					die(_("refusing to create/use '%s' in "
    --					      "another submodule's git dir"),
    --					    git_dir);
    --				free(git_dir);
    --			}
    -+			absorb_git_dir_into_superproject(path, super_prefix);
    - 		} else {
      			struct strbuf gitdir = STRBUF_INIT;
      			submodule_name_to_gitdir(&gitdir, the_repository,
      						 sub->name);
    @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
      			connect_work_tree_and_git_dir(path, gitdir.buf, 0);
      			strbuf_release(&gitdir);
      
    -@@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
    - 	return ret;
    - }
    - 
    --int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
    -+static int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
    - {
    - 	size_t len = strlen(git_dir), suffix_len = strlen(submodule_name);
    - 	char *p;
     @@ submodule.c: static void relocate_single_git_dir_into_superproject(const char *path,
      		die(_("could not lookup name for submodule '%s'"), path);
      
    @@ submodule.c: void submodule_name_to_gitdir(struct strbuf *buf, struct repository
     +		die(_("refusing to create/use '%s' in another submodule's "
     +		      "git dir"), buf->buf);
      }
    -
    - ## submodule.h ##
    -@@ submodule.h: int submodule_to_gitdir(struct repository *repo,
    - void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
    - 			      const char *submodule_name);
    - 
    --/*
    -- * Make sure that no submodule's git dir is nested in a sibling submodule's.
    -- */
    --int validate_submodule_git_dir(char *git_dir, const char *submodule_name);
    --
    - /*
    -  * Make sure that the given submodule path does not follow symlinks.
    -  */
 -:  ---------- >  3:  fb5e6aec6a builtin/submodule--helper: add gitdir command
 -:  ---------- >  4:  d3f5cf47bd submodule: introduce extensions.submodulePathConfig
 -:  ---------- >  5:  131cf17a80 submodule: allow runtime enabling extensions.submodulePathConfig
 -:  ---------- >  6:  529c8f0618 submodule--helper: add gitdir migration command
 2:  8cfa970a9d !  7:  66a7973f39 builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
    @@ Commit message
         public function exposed via url.h, instead of the old helper path
         (strbuf), which has nothing to do with 3986 encoding/decoding anymore.
     
    -    This function will be used by submodule.c in the next commit.
    +    This function will be used in subsequent commits which do the encoding.
     
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
    @@ url.c
      #include "strbuf.h"
      #include "url.h"
      
    -+/*
    -+ * The set of unreserved characters as per STD66 (RFC3986) is
    -+ * '[A-Za-z0-9-._~]'. These characters are safe to appear in URI
    -+ * components without percent-encoding.
    -+ */
     +int is_rfc3986_unreserved(char ch)
     +{
     +	return isalnum(ch) ||
    @@ url.h: char *url_decode_parameter_value(const char **query);
      void end_url_with_slash(struct strbuf *buf, const char *url);
      void str_end_url_with_slash(const char *url, char **dest);
      
    ++/*
    ++ * The set of unreserved characters as per STD66 (RFC3986) is
    ++ * '[A-Za-z0-9-._~]'. These characters are safe to appear in URI
    ++ * components without percent-encoding.
    ++ */
     +int is_rfc3986_unreserved(char ch);
     +
      #endif /* URL_H */
 4:  1b5d0b50ef <  -:  ---------- submodule: add extension to encode gitdir paths
 -:  ---------- >  8:  d8789b3d8f submodule--helper: fix filesystem collisions by encoding gitdir paths
 5:  2bf1c116a2 !  9:  426c610fe1 submodule: fix case-folding gitdir filesystem colisions
    @@ Metadata
     Author: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Commit message ##
    -    submodule: fix case-folding gitdir filesystem colisions
    +    submodule: fix case-folding gitdir filesystem collisions
     
    -    Add a new check when extension.submoduleEncoding is enabled to
    +    Add a new check when extension.submodulePathConfig is enabled, to
         detect and prevent case-folding filesystem colisions. When this
         new check is triggered, a stricter casefolding aware URI encoding
         is used to percent-encode uppercase characters.
    @@ Commit message
     
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
    + ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: static void create_default_gitdir_config(const char *submodule_name)
    + 		return;
    + 	}
    + 
    +-	/* Case 2: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
    ++	/* Case 2.1: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
    + 	strbuf_reset(&gitdir_path);
    + 	repo_git_path_append(the_repository, &gitdir_path, "modules/");
    + 	strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_rfc3986_unreserved);
    +@@ builtin/submodule--helper.c: static void create_default_gitdir_config(const char *submodule_name)
    + 		return;
    + 	}
    + 
    ++	/* Case 2.2: Try extended uppercase URI (RFC3986) encoding, to fix case-folding */
    ++	strbuf_reset(&gitdir_path);
    ++	repo_git_path_append(the_repository, &gitdir_path, "modules/");
    ++	strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_casefolding_rfc3986_unreserved);
    ++	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name))
    ++		return;
    ++
    ++	/* Case 2.3: Try some derived gitdir names, see if one sticks */
    ++	for (char c = '0'; c <= '9'; c++) {
    ++		strbuf_reset(&gitdir_path);
    ++		repo_git_path_append(the_repository, &gitdir_path, "modules/");
    ++		strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_rfc3986_unreserved);
    ++		strbuf_addch(&gitdir_path, c);
    ++		if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name))
    ++			return;
    ++
    ++		strbuf_reset(&gitdir_path);
    ++		repo_git_path_append(the_repository, &gitdir_path, "modules/");
    ++		strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_casefolding_rfc3986_unreserved);
    ++		strbuf_addch(&gitdir_path, c);
    ++		if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name))
    ++			return;
    ++	}
    ++
    + 	/* Case 3: nothing worked, error out */
    + 	die(_("failed to set a valid default config for 'submodule.%s.gitdir'. "
    + 	      "Please ensure it is set, for example by running something like: "
    +
      ## submodule.c ##
     @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
      	return ret;
    @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
     +cleanup:
     +	if (dir)
     +		closedir(dir);
    -+	FREE_AND_NULL(modules_dir);
    ++	free(modules_dir);
     +	return ret;
     +}
     +
      /*
    -  * Encoded gitdir validation function used when extensions.submoduleEncoding is enabled.
    +  * Encoded gitdir validation, only used when extensions.submodulePathConfig is enabled.
       * This does not print errors like the non-encoded version, because encoding is supposed
       * to mitigate / fix all these.
       */
    @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
      	char *p = git_dir, *last_submodule_name = NULL;
     +	int config_ignorecase = 0;
      
    - 	if (!the_repository->repository_format_submodule_encoding)
    + 	if (!the_repository->repository_format_submodule_path_cfg)
      		BUG("validate_submodule_encoded_git_dir() must be called with "
     @@ submodule.c: static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodu
      	if (!last_submodule_name || strchr(last_submodule_name, '/'))
    @@ submodule.c: static int validate_submodule_encoded_git_dir(char *git_dir, const
      	return 0;
      }
      
    -@@ submodule.c: void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
    - 	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
    - 		return;
    - 
    --	/* Case 2: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
    -+	/* Case 2.1: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
    - 	strbuf_reset(buf);
    - 	repo_git_path_append(r, buf, "modules/");
    - 	strbuf_addstr_urlencode(buf, submodule_name, is_rfc3986_unreserved);
    - 	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
    - 		return;
    - 
    -+	/* Case 2.2: Try extended uppercase URI (RFC3986) encoding, to fix case-folding */
    -+	strbuf_reset(buf);
    -+	repo_git_path_append(r, buf, "modules/");
    -+	strbuf_addstr_urlencode(buf, submodule_name, is_casefolding_rfc3986_unreserved);
    -+	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
    -+		return;
    -+
    -+	/* Case 2.3: Try some derived gitdir names, see if one sticks */
    -+	for (char c = '0'; c <= '9'; c++) {
    -+		strbuf_reset(buf);
    -+		repo_git_path_append(r, buf, "modules/");
    -+		strbuf_addstr_urlencode(buf, submodule_name, is_rfc3986_unreserved);
    -+		strbuf_addch(buf, c);
    -+		if (!validate_and_set_submodule_gitdir(buf, submodule_name))
    -+			return;
    -+
    -+		strbuf_reset(buf);
    -+		repo_git_path_append(r, buf, "modules/");
    -+		strbuf_addstr_urlencode(buf, submodule_name, is_casefolding_rfc3986_unreserved);
    -+		strbuf_addch(buf, c);
    -+		if (!validate_and_set_submodule_gitdir(buf, submodule_name))
    -+			return;
    -+	}
    -+
    - 	/* Case 3: Nothing worked: error out */
    - 	die(_("Cannot construct a valid gitdir path for submodule '%s': "
    - 	      "please set a unique git config for 'submodule.%s.gitdir'."),
     
    - ## t/t7425-submodule-encoding.sh ##
    -@@ t/t7425-submodule-encoding.sh: test_expect_success 'disabling extensions.submoduleEncoding prevents nested subm
    + ## t/t7425-submodule-gitdir-path-extension.sh ##
    +@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'disabling extensions.submodulePathConfig prevents nested su
      	)
      '
      
     +test_expect_success CASE_INSENSITIVE_FS 'verify case-folding conflicts are correctly encoded' '
    -+	git clone -c extensions.submoduleEncoding=true main cloned-folding &&
    ++	git clone -c extensions.submodulePathConfig=true main cloned-folding &&
     +	(
     +		cd cloned-folding &&
     +
    @@ url.c: int is_rfc3986_unreserved(char ch)
      		ch == '-' || ch == '_' || ch == '.' || ch == '~';
      }
      
    -+/*
    -+ * This is a variant of is_rfc3986_unreserved() that treats uppercase
    -+ * letters as "reserved". This forces them to be percent-encoded, allowing
    -+ * 'Foo' (%46oo) and 'foo' (foo) to be distinct on case-folding filesystems.
    -+ */
     +int is_casefolding_rfc3986_unreserved(char c)
     +{
     +	return (c >= 'a' && c <= 'z') ||
    @@ url.c: int is_rfc3986_unreserved(char ch)
      	/*
     
      ## url.h ##
    -@@ url.h: void end_url_with_slash(struct strbuf *buf, const char *url);
    - void str_end_url_with_slash(const char *url, char **dest);
    - 
    +@@ url.h: void str_end_url_with_slash(const char *url, char **dest);
    +  */
      int is_rfc3986_unreserved(char ch);
    -+int is_casefolding_rfc3986_unreserved(char c);
      
    ++/*
    ++ * This is a variant of is_rfc3986_unreserved() that treats uppercase
    ++ * letters as "reserved". This forces them to be percent-encoded, allowing
    ++ * 'Foo' (%46oo) and 'foo' (foo) to be distinct on case-folding filesystems.
    ++ */
    ++int is_casefolding_rfc3986_unreserved(char c);
    ++
      #endif /* URL_H */
 6:  b607d7ca39 ! 10:  80b1c1fb59 submodule: use hashed name for gitdir
    @@ Metadata
     Author: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Commit message ##
    -    submodule: use hashed name for gitdir
    +    submodule: hash the submodule name for the gitdir path
     
    -    If none of the previous steps work and we reach case 2.4, try to
    -    hash the submodule name and see if that can be a valid gitdir
    -    before giving up and throwing an error.
    +    If none of the previous plain-text / encoding / derivation steps work
    +    and case 2.4 is reached, then try a hash of the submodule name to see
    +    if that can be a valid gitdir before giving up and throwing an error.
     
    -    This is a "last resort" type of measure to avoid conflicts since
    -    it loses the gitdir human readability. Itis not such a big deal
    -    because users are now supposed to use the submodule.<name>.gitdir
    -    config as the single source of truth for gitdir paths.
    -
    -    This logic will be reached in very rare cases, as can be seen in
    -    the test we added.
    +    This is a "last resort" type of measure to avoid conflicts since it
    +    loses the human readability of the gitdir path. This logic will be
    +    reached in rare cases, as can be seen in the test we added.
     
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
    - ## submodule.c ##
    -@@ submodule.c: static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
    - void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
    - 			      const char *submodule_name)
    + ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
    + static void create_default_gitdir_config(const char *submodule_name)
      {
    -+	unsigned char raw_name_hash[GIT_MAX_RAWSZ];
    -+	char hex_name_hash[GIT_MAX_HEXSZ + 1];
    + 	struct strbuf gitdir_path = STRBUF_INIT;
     +	struct git_hash_ctx ctx;
    - 	const char *gitdir;
    --	char *key;
    -+	char *key, header[128];
    ++	char hex_name_hash[GIT_MAX_HEXSZ + 1], header[128];
    ++	unsigned char raw_name_hash[GIT_MAX_RAWSZ];
     +	int header_len;
      
    - 	repo_git_path_append(r, buf, "modules/");
    - 	strbuf_addstr(buf, submodule_name);
    -@@ submodule.c: void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
    + 	/* The config is set only when extensions.submodulePathConfig is enabled */
    + 	if (!the_repository->repository_format_submodule_path_cfg &&
    +@@ builtin/submodule--helper.c: static void create_default_gitdir_config(const char *submodule_name)
      			return;
      	}
      
    @@ submodule.c: void submodule_name_to_gitdir(struct strbuf *buf, struct repository
     +	the_hash_algo->update_fn(&ctx, submodule_name, strlen(submodule_name));
     +	the_hash_algo->final_fn(raw_name_hash, &ctx);
     +	hash_to_hex_algop_r(hex_name_hash, raw_name_hash, the_hash_algo);
    -+	strbuf_reset(buf);
    -+	repo_git_path_append(r, buf, "modules/");
    -+	strbuf_addstr(buf, hex_name_hash);
    -+	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
    ++	strbuf_reset(&gitdir_path);
    ++	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", hex_name_hash);
    ++	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name)) {
    ++		strbuf_release(&gitdir_path);
     +		return;
    ++	}
     +
    - 	/* Case 3: Nothing worked: error out */
    - 	die(_("Cannot construct a valid gitdir path for submodule '%s': "
    - 	      "please set a unique git config for 'submodule.%s.gitdir'."),
    + 	/* Case 3: nothing worked, error out */
    + 	die(_("failed to set a valid default config for 'submodule.%s.gitdir'. "
    + 	      "Please ensure it is set, for example by running something like: "
     
    - ## t/t7425-submodule-encoding.sh ##
    -@@ t/t7425-submodule-encoding.sh: test_expect_success CASE_INSENSITIVE_FS 'verify case-folding conflicts are corre
    + ## t/t7425-submodule-gitdir-path-extension.sh ##
    +@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success CASE_INSENSITIVE_FS 'verify case-folding conflicts are corre
      	verify_submodule_gitdir_path cloned-folding "fooBar" "modules/fooBar0"
      '
      
     +test_expect_success CASE_INSENSITIVE_FS 'verify hashing conflict resolution as a last resort' '
    -+	git clone -c extensions.submoduleEncoding=true main cloned-hash &&
    ++	git clone -c extensions.submodulePathConfig=true main cloned-hash &&
     +	(
     +		cd cloned-hash &&
     +
 7:  9b4890cfd2 <  -:  ---------- meson/Makefile: allow setting submodule encoding at build time

Adrian Ratiu (10):
  submodule--helper: use submodule_name_to_gitdir in add_submodule
  submodule: always validate gitdirs inside submodule_name_to_gitdir
  builtin/submodule--helper: add gitdir command
  submodule: introduce extensions.submodulePathConfig
  submodule: allow runtime enabling extensions.submodulePathConfig
  submodule--helper: add gitdir migration command
  builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
  submodule--helper: fix filesystem collisions by encoding gitdir paths
  submodule: fix case-folding gitdir filesystem collisions
  submodule: hash the submodule name for the gitdir path

 Documentation/config/extensions.adoc       |  12 +
 Documentation/config/submodule.adoc        |   7 +
 builtin/credential-store.c                 |   7 +-
 builtin/submodule--helper.c                | 204 +++++++++++-
 repository.c                               |   1 +
 repository.h                               |   1 +
 setup.c                                    |   7 +
 setup.h                                    |   1 +
 submodule.c                                | 160 +++++++--
 submodule.h                                |   2 +
 t/lib-verify-submodule-gitdir-path.sh      |  24 ++
 t/meson.build                              |   1 +
 t/t7425-submodule-gitdir-path-extension.sh | 369 +++++++++++++++++++++
 t/t9902-completion.sh                      |   1 +
 url.c                                      |  13 +
 url.h                                      |  14 +
 16 files changed, 776 insertions(+), 48 deletions(-)
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh
 create mode 100755 t/t7425-submodule-gitdir-path-extension.sh

-- 
2.51.2

