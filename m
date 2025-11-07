Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE029E115
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527999; cv=pass; b=fDESyYqM70QI3RmcmHGehUuOLwTBjNI0uaEHIqyxiv1u6Ci5VTKxNW6WVUFgMVtLe5p62iE8w94ALj/Bfmbn7aEVzLcYAMi1rEqw47jYsmH/XZO15yTcA8VF3m3HjyX8NwcR901avxN523PrA/37ArXQMGRnbTWW16B1VZwygIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527999; c=relaxed/simple;
	bh=oZB/M47mf+wMxKkUNhGt6mh8HBkbFgl473i1zSzrTZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOZHqGkt1j373HxbiZro2HFjBxN80abuUcOX/1+nBNqdE9ITLPWNYwfucF+3+0Vi+543b9a2FroEMU+rnwQVkGVbHfMtFUYB00EAZH18MzPKqSVmofSH7SwUlcY2WgJmzXfwe/dO5lJPCpo1ioa5jgifoNV/gjCf0kPgjPH3tsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=W+05b+Gg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="W+05b+Gg"
ARC-Seal: i=1; a=rsa-sha256; t=1762527977; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=drxiHf26adkywja+i3V8FFDDatDwjJUygiPiZn5K2rClJddm8a7VeH4xmc/+E4zzpauYTwxVOTwa5WU7y03FpQkxgVlgDAS2yvcdpuwDpZdeDa9zUaVEN1VjRiLqn5zV5fqtAy879wMj42MATHv0RGknLQ5j6Bh5NKEQUZO5g4I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762527977; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AiaX5RN9eKWs7CNZtRt+Y38F2PIImGpxYhh9TUrDzDg=; 
	b=TEGwM4VZSmnb+Z094GvDQuPAPsAn+NhK4sbbwULw4GIlvQZYsaF3ldFrpdU0qeFfzmwpyVFE+QLBSiRxyK5fk4/azuklgd/195JQdooVEkE283MTeh3YVraUCj+7OaU6W3xKBQtyanlzM9QoyhopinBAEKrEAmoDBftJ8K+HRPs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762527977;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AiaX5RN9eKWs7CNZtRt+Y38F2PIImGpxYhh9TUrDzDg=;
	b=W+05b+GgA06DE/LpTxNJ53pRZ1mqVnCTF3rkDXkBybGT8e9eIeP/tQpuZuHaMlqD
	RU38tmRFpfliWOpQDLGNA8kkFak/xk+JGBmfrOox+DTyVPHN0An1Pc7wSJG0bih43Vy
	rwMiZWKSD+F8tRqznZm/+9OOJB8KD8n4wnr83b44=
Received: by mx.zohomail.com with SMTPS id 1762527975575878.0654023510208;
	Fri, 7 Nov 2025 07:06:15 -0800 (PST)
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
Subject: [PATCH v4 0/4] Encode submodule gitdir names to avoid conflicts
Date: Fri,  7 Nov 2025 17:05:43 +0200
Message-ID: <20251107150547.3272180-1-adrian.ratiu@collabora.com>
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

For those new to this series, we are adding an extension to encode submodule
gitdir paths to avoid filesystem conflicts.

v4 continues with the simplifications started in v3, based on reviewer feedback
(many thanks to everyone, especially to Junio and Patrick).

The biggest design change in v4 is that config submodule.<name>.gitdir becomes
mandatory when extensions.submoduleEncoding is enabled, so instead of being just
an optional override like in previous iterations, in v4 it's the centerpiece of
design, the single point of truth from which submodule gitdir paths are located.

This allows users to not care about the specific encoding being used and also
allows git to improveme the encoding implementation over time: everyone just gets
the submodule gitdirs from the config after the extension is enabled.

Another important change is that we do not encode everything by default when the
extension is enabled: submodule_name_to_gitdir() validates multiple candidates
and picks the best one and encoding only when required.

As always this is based on latest master branch, I've merged into next/seen for
any conflicts, pushed to GitHub [1] and ran the CI with all tests passing [2].

I also added a rangediff between v3 and v4, which might help some reviewers,
though it's rather big because we changed the config/encoding design like I
mentioned above so it might be easier to give it a full review.

Changes between v3 -> v4:
* Replaced bmwill@google.com -> bwilliams.eng@gmail.com (Kristoffer)
* Made the gitdir config the authoritative source of truth for all submodule
  git dirs when the extension is enabled (Junio, Patrick)
* Replaced the "encode everything by default" design with a stepwise/retry
  validation in submodule_name_to_gitdir() to pick the best canditate (Junio)
* Moved is_rfc3986_unreserved() to url.[ch] instead of strbuf (Junio)
* Fixed a parallel job execution bug I introduced with the extension in v3 (Adrian)
* Improved lib-verify-submodule-gitdir-path.sh to handle relative/abs paths (Adrian)
* Fixed submodule.<name>.gitdir documentation vs code mismatch (Junio)
* Defined the config together with the extension by squashing commits (Patrick)
* Removed the A -> _a, B -> _b custom encoding in favor of a simplified percent
  encodin which is only done when case-folding to allow uppercase chars (Junio)
* Dropped patch with pathconf wrapper, as it's not required for basic encoding,
  it can be added back if we implement sharding (Junio, Peff, Patrick)
* Used repo_config_get_string_tmp to avoid a char* free call (Patrick)
* Added comment to document is_rfc3986_unreserved() (Patrick)
* Fixed heredoc body indentation (Patrick)
* Fixed trivial doc markup conflict with upstream commit (Adrian)
* Reworded multiple commits for clarity (Junio)

Please let me know if you have any questions or other feedback.

Thank you,
Adrian

[1] https://github.com/10ne1/git/tree/dev/aratiu/encoding-v4
[2] https://github.com/10ne1/git/actions/runs/19170390360

Range-diff against v3:
1:  b2e317a8f6 ! 1:  7d34507692 submodule--helper: use submodule_name_to_gitdir in add_submodule
    @@ Commit message
         submodule--helper: use submodule_name_to_gitdir in add_submodule
     
         While testing submodule gitdir path encoding, I noticed submodule--helper
    -    is still using a hardcoded name-based path leading to test failures, so
    -    convert it to the common helper function introduced by commit ce125d431a
    -    (submodule: extract path to submodule gitdir func, 2021-09-15)  and used
    -    in other locations across the source tree.
    +    is still using a hardcoded modules gitdir path leading to test failures.
    +
    +    Call the submodule_name_to_gitdir() helper instead, which was invented
    +    exactly for this purpose and is already used by all the other locations
    +    which work on gitdirs.
    +
    +    Also narrow the scope of the submod_gitdir_path variable which is not
    +    used anymore in the updated "else" branch.
     
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
2:  17838ad13f < -:  ---------- submodule: add gitdir path config override
3:  4fc7020f26 < -:  ---------- strbuf: bring back is_rfc3986_unreserved
-:  ---------- > 2:  1e609bdd1a builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
4:  dc6d5069ff ! 3:  c51fd58669 submodule: encode gitdir paths to avoid conflicts
    @@ Metadata
     Author: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Commit message ##
    -    submodule: encode gitdir paths to avoid conflicts
    +    submodule: add extension to encode gitdir paths
     
    -    This adds a new submoduleEncoding extension which encodes gitdir names
    -    to avoid collisions due to nested gitdirs or case insensitive filesystems.
    +    Add a submoduleEncoding extension which fixes filesystem collisions by
    +    encoding gitdir paths. At a high level, this implements a mechanism to
    +    encode -> validate -> retry until a working gitdir path is found.
     
    -    A custom encoding can become unnecessarily complex, while url-encoding is
    -    relatively well-known, however it needs some extending to support case
    -    insensitive filesystems, hence why A is encoded as _a, B as _b and so on.
    +    Credit goes to Junio for coming up with this design: encoding is only
    +    applied when necessary, e.g. uppercase characters are encoded only on
    +    case-folding filesystems and only if a real conflict is detected.
     
    -    Unfortunately encoding A -> _a (...) is not enough to fix the reserved
    -    Windows file names (e.g. COM1) because worktrees still use names like COM1
    -    even if the gitdirs paths are encoded, so future work is needed to fully
    -    address Windows reserved names.
    +    To make this work, we rely on the submodule.<name>.gitdir config as the
    +    single source of truth for gitidir paths: the config is always set when
    +    the extension is enabled. Users who care about gitdir paths are expected
    +    to get/set the config and not the underlying encoding implementation.
     
    -    For now url-encoding is the only option, however in the future we may
    -    add alternatives (other encodings, hashes or even hash_name).
    +    This commit adds the basic encoding logic which addresses nested gitdirs.
    +    The next commit fixes case-folding, the next commit fixes names longer
    +    than NAME_MAX. The idea is the encoding can be improved over time in a
    +    way which is transparent to users.
     
    +    Suggested-by: Junio C Hamano <gitster@pobox.com>
         Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
         Suggested-by: Patrick Steinhardt <ps@pks.im>
    +    Based-on-patch-by: Brandon Williams <bwilliams.eng@gmail.com>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Documentation/config/extensions.adoc ##
    -@@ Documentation/config/extensions.adoc: relativeWorktrees::
    +@@ Documentation/config/extensions.adoc: relativeWorktrees:::
      	repaired with either the `--relative-paths` option or with the
      	`worktree.useRelativePaths` config set to `true`.
      
    -+submoduleEncoding::
    ++submoduleEncoding:::
     +	If enabled, submodule gitdir paths are encoded to avoid filesystem
    -+	conflicts due to nested gitdirs or case insensitivity. For now, only
    -+	url-encoding (rfc3986) is available, with a small addition to encode
    -+	uppercase to lowercase letters (`A  -> _a`, `B -> _b` and so on).
    -+	Other encoding or hashing methods may be added in the future.
    -+	Any preexisting non-encoded submodule gitdirs are used as-is, to
    -+	ease migration and reduce risk of gitdirs not being recognized.
    -+
    - worktreeConfig::
    ++	conflicts due to nested gitdirs, case insensitivity or other issues
    ++	When enabled, the submodule.<name>.gitdir config is always set for
    ++	all submodulesand is the single point of authority for gitdir paths.
    ++
    + worktreeConfig:::
      	If enabled, then worktrees will load config settings from the
      	`$GIT_DIR/config.worktree` file in addition to the
     
      ## Documentation/config/submodule.adoc ##
     @@ Documentation/config/submodule.adoc: submodule.<name>.active::
    - submodule.<name>.gitdir::
    - 	This option sets the gitdir path for submodule <name>, allowing users
    - 	to override the default path or change the default path name encoding.
    -+	Submodule gitdir encoding is enabled via `extensions.submoduleEncoding`
    -+	(see linkgit:git-config[1]). This config works both with the extension
    -+	enabled or disabled.
    + 	submodule.active config option. See linkgit:gitsubmodules[7] for
    + 	details.
      
    ++submodule.<name>.gitdir::
    ++	This option sets the gitdir path for submodule <name>, allowing users to
    ++	override the default path. Only works when `extensions.submoduleEncoding`
    ++	is enabled, otherwise does nothing. See linkgit:git-config[1] for details.
    ++
      submodule.active::
      	A repeated field which contains a pathspec used to match against a
    + 	submodule's path to determine if the submodule is of interest to git
    +
    + ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: static int module_summary(int argc, const char **argv, const char *prefix,
    + 	return ret;
    + }
    + 
    ++static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
    ++			 struct repository *repo)
    ++{
    ++	struct strbuf gitdir = STRBUF_INIT;
    ++
    ++	if (argc != 2)
    ++		usage(_("git submodule--helper gitdir <name>"));
    ++
    ++	submodule_name_to_gitdir(&gitdir, repo, argv[1]);
    ++
    ++	printf("%s\n", gitdir.buf);
    ++
    ++	strbuf_release(&gitdir);
    ++	return 0;
    ++}
    ++
    + struct sync_cb {
    + 	const char *prefix;
    + 	const char *super_prefix;
    +@@ builtin/submodule--helper.c: int cmd_submodule__helper(int argc,
    + 		NULL
    + 	};
    + 	struct option options[] = {
    ++		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
    + 		OPT_SUBCOMMAND("clone", &fn, module_clone),
    + 		OPT_SUBCOMMAND("add", &fn, module_add),
    + 		OPT_SUBCOMMAND("update", &fn, module_update),
    +
    + ## repository.c ##
    +@@ repository.c: int repo_init(struct repository *repo,
    + 	repo->repository_format_worktree_config = format.worktree_config;
    + 	repo->repository_format_relative_worktrees = format.relative_worktrees;
    + 	repo->repository_format_precious_objects = format.precious_objects;
    ++	repo->repository_format_submodule_encoding = format.submodule_encoding;
    + 
    + 	/* take ownership of format.partial_clone */
    + 	repo->repository_format_partial_clone = format.partial_clone;
     
      ## repository.h ##
     @@ repository.h: struct repository {
    @@ setup.h: struct repository_format {
      	int compat_hash_algo;
     
      ## submodule.c ##
    -@@ submodule.c: int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
    - 	char *p;
    +@@
    + #include "commit-reach.h"
    + #include "read-cache-ll.h"
    + #include "setup.h"
    ++#include "url.h"
    + 
    + static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
    + static int initialized_fetch_ref_tips;
    +@@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
    + 	return ret;
    + }
    + 
    ++/*
    ++ * Find the last submodule name in the gitdir path (modules can be nested).
    ++ * Returns a pointer into `path` to the beginning of the name or NULL if not found.
    ++ */
    ++static char *find_last_submodule_name(char *git_dir_path)
    ++{
    ++	const char *modules_marker = "/modules/";
    ++	char *p = git_dir_path;
    ++	char *last = NULL;
    ++
    ++	while ((p = strstr(p, modules_marker))) {
    ++		last = p + strlen(modules_marker);
    ++		p++;
    ++	}
    ++
    ++	return last;
    ++}
    ++
    + int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
    + {
    + 	size_t len = strlen(git_dir), suffix_len = strlen(submodule_name);
    +-	char *p;
    ++	char *p = git_dir + len - suffix_len;
    ++	bool suffixes_match = !strcmp(p, submodule_name);
      	int ret = 0;
      
    -+	/*
    -+	 * Skip these checks when extensions.submoduleEncoding is enabled because
    -+	 * it fixes the nesting issues and the suffixes will not match by design.
    -+	 */
    -+	if (the_repository->repository_format_submodule_encoding)
    +-	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
    +-	    strcmp(p, submodule_name))
    +-		BUG("submodule name '%s' not a suffix of git dir '%s'",
    +-		    submodule_name, git_dir);
    +-
    + 	/*
    + 	 * We prevent the contents of sibling submodules' git directories to
    + 	 * clash.
    +@@ submodule.c: int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
    + 	 * but the latter directory is already designated to contain the hooks
    + 	 * of the former.
    + 	 */
    +-	for (; *p; p++) {
    ++	for (; *p && suffixes_match; p++) {
    + 		if (is_dir_sep(*p)) {
    + 			char c = *p;
    + 
    +@@ submodule.c: int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
    + 		}
    + 	}
    + 
    ++	/* tests after this check are only for encoded names, when the extension is enabled */
    ++	if (!the_repository->repository_format_submodule_encoding)
     +		return 0;
     +
    - 	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
    - 	    strcmp(p, submodule_name))
    - 		BUG("submodule name '%s' not a suffix of git dir '%s'",
    ++	/* Prevent the use of '/' in names */
    ++	p = find_last_submodule_name(git_dir);
    ++	if (p && strchr(p, '/') != NULL)
    ++		return error("submodule gitdir name '%s' contains unexpected '/'", p);
    ++
    + 	return 0;
    + }
    + 
     @@ submodule.c: int submodule_to_gitdir(struct repository *repo,
      	return ret;
      }
      
    -+static void strbuf_addstr_case_encode(struct strbuf *dst, const char *src)
    ++static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
    ++					     const char *submodule_name)
     +{
    -+	for (; *src; src++) {
    -+		unsigned char c = *src;
    -+		if (c >= 'A' && c <= 'Z') {
    -+			strbuf_addch(dst, '_');
    -+			strbuf_addch(dst, c - 'A' + 'a');
    -+		} else {
    -+			strbuf_addch(dst, c);
    -+		}
    -+	}
    ++	char *key;
    ++
    ++	if (validate_submodule_git_dir(gitdir_path->buf, submodule_name))
    ++		return -1;
    ++
    ++	key = xstrfmt("submodule.%s.gitdir", submodule_name);
    ++	repo_config_set_gently(the_repository, key, gitdir_path->buf);
    ++	FREE_AND_NULL(key);
    ++
    ++	return 0;
    ++
     +}
     +
      void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
      			      const char *submodule_name)
      {
    --	/*
    ++	const char *gitdir;
    ++	char *key;
    ++
    ++	repo_git_path_append(r, buf, "modules/");
    ++	strbuf_addstr(buf, submodule_name);
    ++
    ++	/* If extensions.submoduleEncoding is disabled, use the plain path set above */
    ++	if (!r->repository_format_submodule_encoding)
    ++		return;
    ++
    ++	/* Extension is enabled: use the gitdir config if it exists */
    ++	key = xstrfmt("submodule.%s.gitdir", submodule_name);
    ++	if (!repo_config_get_string_tmp(r, key, &gitdir)) {
    ++		strbuf_reset(buf);
    ++		strbuf_addstr(buf, gitdir);
    ++		FREE_AND_NULL(key);
    ++		return;
    ++	}
    ++	FREE_AND_NULL(key);
    ++
    + 	/*
     -	 * NEEDSWORK: The current way of mapping a submodule's name to
     -	 * its location in .git/modules/ has problems with some naming
     -	 * schemes. For example, if a submodule is named "foo" and
    @@ submodule.c: int submodule_to_gitdir(struct repository *repo,
     -	 * submodule.<name>.gitdir config in .gitmodules that repo
     -	 * administrators can explicitly set. Nothing has been decided,
     -	 * so for now, just append the name at the end of the path.
    --	 */
    - 	char *gitdir_path, *key;
    - 
    - 	/* Allow config override. */
    -@@ submodule.c: void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
    - 
    - 	repo_git_path_append(r, buf, "modules/");
    - 	strbuf_addstr(buf, submodule_name);
    ++	 * The gitdir config does not exist, even though the extension is enabled.
    ++	 * Therefore we are in one of the following cases:
    + 	 */
     +
    -+	/* Existing legacy non-encoded names are used as-is */
    -+	if (is_git_directory(buf->buf))
    ++	/* Case 1: legacy migration of valid plain submodule names */
    ++	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
     +		return;
     +
    -+	if (the_repository->repository_format_submodule_encoding) {
    -+		struct strbuf tmp = STRBUF_INIT;
    ++	/* Case 2: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
    ++	strbuf_reset(buf);
    + 	repo_git_path_append(r, buf, "modules/");
    +-	strbuf_addstr(buf, submodule_name);
    ++	strbuf_addstr_urlencode(buf, submodule_name, is_rfc3986_unreserved);
    ++	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
    ++		return;
     +
    -+		strbuf_reset(buf);
    -+		repo_git_path_append(r, buf, "modules/");
    ++	/* Case 3: error out */
    ++	die(_("Cannot construct a valid gitdir path for submodule '%s': "
    ++	      "please set a unique git config for 'submodule.%s.gitdir'."),
    ++	    submodule_name, submodule_name);
    + }
    +
    + ## t/lib-verify-submodule-gitdir-path.sh (new) ##
    +@@
    ++# Helper to verify if repo $1 contains a submodule named $2 with gitdir path $3
     +
    -+		strbuf_addstr_urlencode(&tmp, submodule_name, is_rfc3986_unreserved);
    -+		strbuf_addstr_case_encode(buf, tmp.buf);
    ++# This does not check filesystem existence. That is done in submodule.c via the
    ++# submodule_name_to_gitdir() API which this helper ends up calling. The gitdirs
    ++# might or might not exist (e.g. when adding a new submodule), so this only
    ++# checks the expected configuration path, which might be overridden by the user.
     +
    -+		strbuf_release(&tmp);
    -+	}
    - }
    ++verify_submodule_gitdir_path() {
    ++	repo="$1" &&
    ++	name="$2" &&
    ++	path="$3" &&
    ++	(
    ++		cd "$repo" &&
    ++		# Compute expected absolute path
    ++		expected="$(git rev-parse --git-common-dir)/$path" &&
    ++		expected="$(test-tool path-utils real_path "$expected")" &&
    ++		# Compute actual absolute path
    ++		actual="$(git submodule--helper gitdir "$name")" &&
    ++		actual="$(test-tool path-utils real_path "$actual")" &&
    ++		echo "$expected" >expect &&
    ++		echo "$actual" >actual &&
    ++		test_cmp expect actual
    ++	)
    ++}
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    @@ t/t7425-submodule-encoding.sh (new)
     +
     +test_expect_success 'verify submodule name is properly encoded' '
     +	verify_submodule_gitdir_path main legacy modules/legacy &&
    -+	verify_submodule_gitdir_path main "New Sub" modules/_new%20_sub
    ++	verify_submodule_gitdir_path main "New Sub" "modules/New Sub"
     +'
     +
     +test_expect_success 'clone from repo with both legacy and new-style submodules' '
    @@ t/t7425-submodule-encoding.sh (new)
     +		cd cloned-encoding &&
     +
     +		test_path_is_dir .git/modules/legacy &&
    -+		test_path_is_dir .git/modules/_new%20_sub &&
    ++		test_path_is_dir ".git/modules/New Sub" &&
     +
     +		git submodule status >list &&
     +		test_grep "$legacy_rev legacy" list &&
    @@ t/t7425-submodule-encoding.sh (new)
     +		git submodule update --init --recursive &&
     +
     +		test_path_is_dir .git/modules/legacy &&
    -+		test_path_is_dir .git/modules/_new%20_sub &&
    ++		test_path_is_dir ".git/modules/New Sub" &&
     +
     +		# Verify both submodules are at the expected commits
     +		git submodule status >list &&
    @@ t/t7425-submodule-encoding.sh (new)
     +'
     +
     +test_done
    +
    + ## t/t9902-completion.sh ##
    +@@ t/t9902-completion.sh: test_expect_success 'git config set - variable name - __git_compute_second_level
    + 	submodule.sub.fetchRecurseSubmodules Z
    + 	submodule.sub.ignore Z
    + 	submodule.sub.active Z
    ++	submodule.sub.gitdir Z
    + 	EOF
    + '
    + 
5:  775cf131bf < -:  ---------- submodule: error out if gitdir name is too long
-:  ---------- > 4:  01a5b10d5a submodule: fix case-folding gitdir filesystem colisions

Adrian Ratiu (4):
  submodule--helper: use submodule_name_to_gitdir in add_submodule
  builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
  submodule: add extension to encode gitdir paths
  submodule: fix case-folding gitdir filesystem colisions

 Documentation/config/extensions.adoc  |   6 +
 Documentation/config/submodule.adoc   |   5 +
 builtin/credential-store.c            |   7 +-
 builtin/submodule--helper.c           |  30 ++++-
 repository.c                          |   1 +
 repository.h                          |   1 +
 setup.c                               |   7 ++
 setup.h                               |   1 +
 submodule.c                           | 155 ++++++++++++++++++++-----
 t/lib-verify-submodule-gitdir-path.sh |  24 ++++
 t/meson.build                         |   1 +
 t/t7425-submodule-encoding.sh         | 161 ++++++++++++++++++++++++++
 t/t9902-completion.sh                 |   1 +
 url.c                                 |  23 ++++
 url.h                                 |   3 +
 15 files changed, 387 insertions(+), 39 deletions(-)
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh
 create mode 100755 t/t7425-submodule-encoding.sh

-- 
2.51.0

