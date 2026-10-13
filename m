Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154443BCD28
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902183; cv=none; b=px2BlEsF7jyDz8sv9bAAo+PZbZaGqWNWg9/d85gfhy8dG3copia0FFDTTq9bn4YKJO0Q4ntocvqLbOMBduwKCay4/N4twX/0w5HLk73Ld1Wv9VZmXgr9jbIMLMmU3aFxPk+WrOdOHBnEeunFH03SomzElyCoqw1xm5MVSjofcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902183; c=relaxed/simple;
	bh=MpEhFKuFFPSIP2ZgyG58fgUwXTbYSMB3+2RCWB5WbBU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OI/rq7BhVywlOH+W0U6SlrpF0m0vugU+GFPAfVJVtpa8kT77z2+zDN5dLtOnwhkajD0A7qvvsk+zefWg7R9g4dIlDZ4Kh6Oi4m0q7zIrzdpVApKQBNO+iz4f94CgJPuTJ/Fg7FNYAW6XDuqghN6P79fPDvEv863b40/1t8kvhvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRLEkOSF; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRLEkOSF"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-823b938464fso2309637a34.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902180; x=1792506980; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wZxBlb0PSuyYkbS9GkD2iDqdjpCkb8XpvfPYElwlueA=;
        b=YRLEkOSFGKoADsTs6L5XZN3gnicY3oYaTzTteUYxEQ0Tms0Vb3sWhq1I35FoaTcv2v
         PtO4kG/LslSulopvHM0LAG8tMVBnJ7mOT4GrEtECKYkm32U0mkzjG3RsIcWXPb1Y8Mrz
         1PtX5tpTMStqYCW7VhyhAGKM+VfSPdRq/XqcCLsPD6ArxM70ZL+xD+ez1STJ2tSf0nCW
         u7CaMCQhwnUxIni03QHCaAzzVGaGUn9MFQk4CFIaqailMR/63Uv1zFkby/TPMMUcJylX
         t3IY6uSNY+txgoDA2TdAR1rv+lUqoKKcWYMWzYuqEKyZJ4YVhuWHAAPWC6sUwk2vuSrI
         jmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902180; x=1792506980;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZxBlb0PSuyYkbS9GkD2iDqdjpCkb8XpvfPYElwlueA=;
        b=TJvbUoAF8w7y5zwqtnFBsy8V3VrdFg8NQNNS+zicCisXpzSY8684UCkqTSzLvhCiTU
         7+ViINZSmZl/Z6mQwr7o/spYfQtPVKEzQ+zf67vubdElEBFmgZIGmjR3PCkdPRJI33J9
         eJHxhJV//6PWBeuiWkxpscXgpcgX0dOYDZFrUg/haiM+ITkfCCnIAjJQkkqLVMsXP1WC
         9U0wNQiRODYY1QuPEfnhcYTE1n3Smxezj62/Jk0svjps4fBI4j+CvTt972zmAai4ya5b
         g3Z02KdyVDjs8+xVNCYBiEEMrSQaZvCjuhGnLZNGCE4iwBX40wwarm7NrVYlYE8dajb0
         sAQw==
X-Gm-Message-State: AFq9FYJhYpjOyYa3I2EnbuM9I8e99QYOjloC1+swj6YB174N7xhkbwR6
	mAR/EqwULMAgXAXSRwyTwEG8kO1Y0YbLzS+ZK9oLn+hVRUzARhSMwBY8Q7pEJg==
X-Gm-Gg: AYBFou0ZImilHyy5cOC4mQm3KkJRiKhf5fZ3EKeMjvM9KM95h/pwD4rmvaK5AhW3HI5
	+cP2BaD6e98etCCDYENeeW20pHCTEAxhIWTJlPCfUZzRF2VZXJ9OK32iPQwQWHKJMAGP275rkL9
	7kl0i6rnulFZkSLyOaKVYv6rFpXdFz0DsvKfo1kh/jy90UXs/esqSSCIr7wuR8ZnkMNt4Alvk7G
	F3EOGNWP4algk5TuNJ6YQbS8OS3wTh/EgkBqsyKEmghmvm8Q/QcyDKSMNXjk+n8uc0JqV4pVRfE
	vsIyzS73z59+VkHp/UYraX6mv0GnpAMDrSQXxTukkEnz1TvH7An8lDQRTPY3UIXUfV3yPgOkHlS
	/kSA2k9j84wjk8QC16qLSNoX5GDcDGcvVxCzmZe/2eeTr+mKBVqm4R6iBNWnCwHgqlzFt2qNDPd
	wXq3x5iSTAdjWJKk74OtjCpLSnT8cbhc6mLewKYJBIb0YBALZWjmapFe41FTZfn7MWt4qOeFPsS
	MAb
X-Received: by 2002:a05:6830:6514:b0:815:cdb4:4a7 with SMTP id 46e09a7af769-83090934a81mr12265547a34.3.1791902179659;
        Tue, 13 Oct 2026 07:36:19 -0700 (PDT)
Received: from [127.0.0.1] ([48.221.153.206])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303494f76fsm12476633a34.2.2026.10.13.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:36:18 -0700 (PDT)
Message-Id: <pull.2224.v5.git.1791902175.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Oct 2026 14:36:13 +0000
Subject: [PATCH v5 0/2] blame: ignore revs in .git-blame-ignore-revs by default
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Abhijeetsingh Meena <abhijeet040403@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ravi Mistry <rmistry@google.com>

This series teaches git-blame(1) and git-annotate(1) to automatically use
.git-blame-ignore-revs at the root of the working tree (or
HEAD:.git-blame-ignore-revs in bare repositories) by default if it exists,
without requiring manual blame.ignoreRevsFile configuration in every clone.
This restarts the stalled attempt in PR
https://github.com/gitgitgadget/git/pull/1809
(https://lore.kernel.org/git/pull.1809.v2.git.1728707867.gitgitgadget@gmail.com/)
and addresses https://github.com/gitgitgadget/git/issues/1494.

Changes since v4:

 * In non-bare repositories, Patch 2/2 now reads .git-blame-ignore-revs from
   the root of the working tree (using open_nofollow(), S_ISREG(), and
   IGNORE_REVS_MAX_FILE_SIZE) instead of HEAD:.git-blame-ignore-revs, while
   continuing to use HEAD:.git-blame-ignore-revs in bare repositories
   (matching the .mailmap model in read_mailmap()). This makes it ergonomic
   to test uncommitted or untracked changes to .git-blame-ignore-revs
   locally before committing.
 * Updated the commit messages and documentation to justify the default
   lookup and working-tree behavior on ergonomic grounds.

Changes since v3:

 * Patch 2/2 caps the size of the default HEAD:.git-blame-ignore-revs blob
   at IGNORE_REVS_MAX_FILE_SIZE (100MB, matching ATTR_MAX_FILE_SIZE from
   3c50032ff5 ("attr: ignore overly large gitattributes files", 2022-12-01))
   via odb_read_object_info() before calling odb_read_object(), skipping
   oversized blobs with a warning without loading them into memory.

Changes since v2:

 * Patch 2/2 uses sb->repo instead of the_repository in
   parse_default_ignore_revs_blob().

Changes since v1:

 * Split the series into two commits.
 * Patch 1/2 hardens oidset_parse_file_carefully() in oidset.c and
   peel_to_commit_oid() in builtin/blame.c before exposing them to
   upstream-controlled content at a well-known path:
   * Reject lines containing embedded NUL bytes via memchr() so trailing
     bytes after a NUL cannot be silently ignored.
   * Pass OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT |
     OBJECT_INFO_QUICK to odb_read_object_info_extended() and peel tags one
     layer per iteration so missing OIDs or tag targets do not trigger lazy
     promisor fetches or pack directory rescans in partial clones, and
     verify that each peeled target matches the tag's declared type.
 * Patch 2/2 reads the committed HEAD:.git-blame-ignore-revs blob (in both
   bare and non-bare repositories) instead of reading a file from the
   working tree, matching hosting platforms even when an untracked file is
   present or a tracked one has local modifications. The tree entry is
   checked with S_ISREG() so non-regular entries (such as committed
   symlinks) are skipped, parsed in memory via
   oidset_parse_buffer_carefully(), and bypassed without reading if cleared
   via blame.ignoreRevsFile="" or --no-ignore-revs-file.

Ravi Mistry (2):
  blame: harden ignore-revs parser and tag peeling
  blame: ignore revs in .git-blame-ignore-revs by default

 Documentation/blame-options.adoc |   9 +-
 Documentation/config/blame.adoc  |  10 +-
 builtin/blame.c                  | 115 ++++++++++++-
 oidset.c                         |  81 ++++++---
 oidset.h                         |   9 +
 t/t8013-blame-ignore-revs.sh     | 271 +++++++++++++++++++++++++++++++
 6 files changed, 460 insertions(+), 35 deletions(-)


base-commit: fa7f9290efe2bd22dd736689597b474b93798e11
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2224%2Frmistry%2Fblame-default-ignore-revs-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2224/rmistry/blame-default-ignore-revs-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2224

Range-diff vs v4:

 1:  2e12486c0d ! 1:  e9b2c1dae2 blame: harden ignore-revs parser and tag peeling
     @@ Commit message
          Currently, blame.ignoreRevsFile and --ignore-revs-file only read paths
          explicitly configured by the user, which cannot point to an
          attacker-controlled file under Git's threat model. An upcoming commit
     -    will teach git-blame(1) and git-annotate(1) to automatically read the
     -    HEAD:.git-blame-ignore-revs blob by default if it exists, exposing the
     +    will teach git-blame(1) and git-annotate(1) to automatically read
     +    .git-blame-ignore-revs by default if it exists, exposing the
          ignore-revs parser (oidset_parse_file_carefully() in oidset.c) and its
          tag-peeling callback (peel_to_commit_oid() in builtin/blame.c) to
          upstream-controlled content at a well-known path.
      
     -    Harden both code paths before enabling the default blob:
     +    Harden both code paths before enabling the default ignore-revs file:
      
          - In oidset_parse_file_carefully(), strbuf_getline() reads up to the
            next newline and records the full line length in sb.len, including
 2:  76d597dfa8 ! 2:  605eb049a1 blame: ignore revs in HEAD:.git-blame-ignore-revs
     @@ Metadata
      Author: Ravi Mistry <rmistry@google.com>
      
       ## Commit message ##
     -    blame: ignore revs in HEAD:.git-blame-ignore-revs
     +    blame: ignore revs in .git-blame-ignore-revs by default
      
          git-blame(1) can ignore a list of commits specified via
          --ignore-revs-file or the blame.ignoreRevsFile configuration option.
     @@ Commit message
          attribution shifts took priority over a project-wide default.
          Requiring explicit opt-in per clone was therefore the prudent design.
      
     -    Since then, maintaining a .git-blame-ignore-revs file in the repository
     -    root has become the de facto standard across the Git ecosystem, adopted
     -    by major hosting platforms (GitHub, GitLab, Gerrit) and prominent open
     -    source projects (such as Chromium and LLVM). As a consequence,
     -    developers frequently encounter a jarring mismatch: web interfaces
     -    seamlessly ignore formatting commits, but local git-blame(1) and
     -    git-annotate(1) runs do not, unless each user manually configures
     -    blame.ignoreRevsFile for every local checkout.
     +    Since then, maintaining a .git-blame-ignore-revs file at the top level
     +    of the repository has become the standard convention across the Git
     +    ecosystem, adopted by many open source projects (such as Chromium and
     +    LLVM) as well as hosting platforms (GitHub, GitLab, Gerrit). However,
     +    git-blame(1) and git-annotate(1) still ignore this file unless each
     +    user remembers to manually configure blame.ignoreRevsFile in every
     +    local clone.
      
     -    Teach git-blame(1) and git-annotate(1) to automatically add the
     -    HEAD:.git-blame-ignore-revs blob, if it exists, as the initial element
     -    in the list of ignore-revs files in both bare and non-bare
     -    repositories. Reading the committed blob from HEAD rather than the
     -    working tree ensures that local runs match hosting platforms even when
     -    an untracked .git-blame-ignore-revs file is present or a tracked one
     -    has uncommitted local changes.
     +    Teach git-blame(1) and git-annotate(1) to automatically add
     +    .git-blame-ignore-revs, if it exists, as the initial element in the
     +    list of ignore-revs files. Similar to how read_mailmap() handles
     +    .mailmap, consult .git-blame-ignore-revs at the root of the working
     +    tree when a working tree is available and fall back to the
     +    HEAD:.git-blame-ignore-revs blob in bare repositories. Reading from the
     +    working tree in non-bare repositories makes it ergonomic to prepare a
     +    new .git-blame-ignore-revs file or add revisions to an existing one and
     +    immediately test the effect with git-blame(1) before committing, while
     +    falling back to HEAD:.git-blame-ignore-revs allows bare repositories to
     +    respect the committed ignore list as well.
      
     -    To ensure consistent precedence and override semantics:
     -    - The default HEAD:.git-blame-ignore-revs entry is added before reading
     +    To ensure consistent precedence, override semantics, and safety when
     +    reading upstream-controlled content:
     +    - The default .git-blame-ignore-revs entry is added before reading
            configuration and CLI options, preserving user and repository config
            overrides.
          - In git_blame_config(), blame.ignoreRevsFile entries are appended via
            string_list_append() rather than inserted in sorted order via
            string_list_insert() so that configuration entries preserve their
            order relative to the initial default entry.
     -    - The HEAD:.git-blame-ignore-revs tree entry is resolved quietly via
     -      get_oid_with_context(). Its mode is checked with S_ISREG() before
     -      reading the object so that non-regular tree entries (such as a
     -      committed symbolic link whose blob stores a target path rather than
     -      revision IDs, a subdirectory, or a gitlink) are skipped instead of
     -      being read and rejected as malformed object names. Its size is checked
     -      via odb_read_object_info() and capped at IGNORE_REVS_MAX_FILE_SIZE
     -      (100MB, matching ATTR_MAX_FILE_SIZE from 3c50032ff5 ("attr: ignore
     -      overly large gitattributes files", 2022-12-01)) so an oversized blob
     -      is skipped with a warning without being loaded into memory. The blob
     -      is parsed in memory via a new oidset_parse_buffer_carefully() helper
     -      in oidset.c that shares line parsing with
     -      oidset_parse_file_carefully().
     +    - When a working tree is present, the working-tree
     +      .git-blame-ignore-revs path is checked with lstat() and S_ISREG(),
     +      opened with open_nofollow(), and verified with fstat() and S_ISREG()
     +      so symbolic links and non-regular files are silently skipped. In bare
     +      repositories, HEAD:.git-blame-ignore-revs is resolved quietly via
     +      get_oid_with_context() and its tree entry mode is checked with
     +      S_ISREG() before checking the object.
     +    - In both modes, the file or blob size is capped at
     +      IGNORE_REVS_MAX_FILE_SIZE (100MB, matching ATTR_MAX_FILE_SIZE from
     +      3c50032ff5 ("attr: ignore overly large gitattributes files",
     +      2022-12-01)) before reading its contents, skipping an oversized file
     +      or blob with a warning without loading it into memory. The contents
     +      are parsed via a new oidset_parse_buffer_carefully() helper in
     +      oidset.c that shares line parsing with oidset_parse_file_carefully().
          - In build_ignorelist(), ignore-revs entries are processed starting
            after the last empty string entry. This ensures setting
            blame.ignoreRevsFile to "" or passing --ignore-revs-file "" or
     -      --no-ignore-revs-file cleanly discards the default blob without
     +      --no-ignore-revs-file cleanly discards the default entry without
            attempting to read or parse it, allowing users to bypass a malformed
     -      default blob.
     +      default ignore-revs file.
      
          Update documentation in blame-options.adoc and config/blame.adoc, and
     -    add comprehensive test coverage in t8013 for the default blob lookup,
     -    subdirectory invocations, bare repositories, uncommitted and untracked
     -    working-tree files, CLI and config overrides, committed symlink
     -    entries, overly large blobs, and comments and whitespace handling.
     +    add test coverage in t8013 for the default working-tree lookup,
     +    uncommitted and untracked .git-blame-ignore-revs files, subdirectory
     +    invocations, bare repositories, CLI and config overrides, symbolic
     +    links, overly large files and blobs, and comments and whitespace
     +    handling.
      
          Based-on-patch-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
          Helped-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     @@ Documentation/blame-options.adoc: take effect.
      -	processed after any files specified with the `blame.ignoreRevsFile` config
      -	option.  An empty file name, `""`, will clear the list of revs from
      -	previously processed files.
     -+	processed after the default `HEAD:.git-blame-ignore-revs` blob (if it
     -+	exists) and any files specified with the `blame.ignoreRevsFile` config
     -+	option.  An empty file name, `""`, or `--no-ignore-revs-file` will clear
     -+	the list of revs from previously processed files, including the default
     -+	`HEAD:.git-blame-ignore-revs` blob.
     ++	processed after the default `.git-blame-ignore-revs` file at the root of
     ++	the working tree (or `HEAD:.git-blame-ignore-revs` in a bare repository),
     ++	if it exists, and any files specified with the `blame.ignoreRevsFile`
     ++	config option.  An empty file name, `""`, or `--no-ignore-revs-file` will
     ++	clear the list of revs from previously processed files, including the
     ++	default ignore-revs file.
       
       `--color-lines`::
       	Color line annotations in the default format differently if they come from
     @@ Documentation/config/blame.adoc: blame.showRoot::
      -	`#` are ignored.  This option may be repeated multiple times.  Empty
      -	file names will reset the list of ignored revisions.  This option will
      -	be handled before the command line option `--ignore-revs-file`.
     -+	`#` are ignored.  If the `HEAD:.git-blame-ignore-revs` blob exists, it
     ++	`#` are ignored.  If `.git-blame-ignore-revs` exists at the root of the
     ++	working tree (or `HEAD:.git-blame-ignore-revs` in a bare repository), it
      +	is added as the initial element in the list of ignore-revs files.
      +	Other files listed in the configuration are also used, but an empty
      +	element makes all elements that appeared before in the list forgotten.
     @@ Documentation/config/blame.adoc: blame.showRoot::
       	Mark lines that were changed by an ignored revision that we could not
      
       ## builtin/blame.c ##
     +@@
     + #include "object-name.h"
     + #include "odb.h"
     + #include "pager.h"
     ++#include "path.h"
     + #include "blame.h"
     + #include "refs.h"
     + #include "setup.h"
      @@ builtin/blame.c: static int git_blame_config(const char *var, const char *value,
       		if (ret)
       			return ret;
     @@ builtin/blame.c: static int peel_to_commit_oid(struct object_id *oid_ret, void *
      +out:
      +	object_context_release(&oc);
      +}
     ++
     ++static void parse_default_ignore_revs_file(struct blame_scoreboard *sb,
     ++					   const char *name)
     ++{
     ++	char *path = repo_worktree_path(sb->repo, "%s", name);
     ++	struct stat st;
     ++	int fd = -1;
     ++	size_t size;
     ++	char *buf = NULL;
     ++
     ++	if (lstat(path, &st) || !S_ISREG(st.st_mode))
     ++		goto out;
     ++	fd = open_nofollow(path, O_RDONLY);
     ++	if (fd < 0 || fstat(fd, &st) || !S_ISREG(st.st_mode))
     ++		goto out;
     ++	if (st.st_size >= IGNORE_REVS_MAX_FILE_SIZE) {
     ++		warning(_("ignoring overly large ignore-revs file '%s'"), name);
     ++		goto out;
     ++	}
     ++	size = xsize_t(st.st_size);
     ++	buf = xmalloc(size);
     ++	if (read_in_full(fd, buf, size) == (ssize_t)size)
     ++		oidset_parse_buffer_carefully(&sb->ignore_list, buf, size,
     ++					      sb->repo->hash_algo,
     ++					      peel_to_commit_oid, sb);
     ++
     ++out:
     ++	if (fd >= 0)
     ++		close(fd);
     ++	free(buf);
     ++	free(path);
     ++}
     ++
     ++static void parse_default_ignore_revs(struct blame_scoreboard *sb)
     ++{
     ++	if (repo_get_work_tree(sb->repo))
     ++		parse_default_ignore_revs_file(sb, ".git-blame-ignore-revs");
     ++	else
     ++		parse_default_ignore_revs_blob(sb, "HEAD:.git-blame-ignore-revs");
     ++}
      +
       static void build_ignorelist(struct blame_scoreboard *sb,
       			     struct string_list *ignore_revs_file_list,
     @@ builtin/blame.c: static int peel_to_commit_oid(struct object_id *oid_ret, void *
      +	for (idx = start_idx; idx < ignore_revs_file_list->nr; idx++) {
      +		i = &ignore_revs_file_list->items[idx];
      +		if (i->util)
     -+			parse_default_ignore_revs_blob(sb, i->string);
     ++			parse_default_ignore_revs(sb);
       		else
       			oidset_parse_file_carefully(&sb->ignore_list, i->string,
       						    the_repository->hash_algo,
     @@ builtin/blame.c: int cmd_blame(int argc,
       
       	setup_default_color_by_age();
      +	string_list_append(&ignore_revs_file_list,
     -+			   "HEAD:.git-blame-ignore-revs")->util = &sb;
     ++			   ".git-blame-ignore-revs")->util = &sb;
       	repo_config(the_repository, git_blame_config, &output_option);
       	repo_init_revisions(the_repository, &revs, NULL);
       	revs.date_mode = blame_date_mode;
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
       	test_cmp expect actual
       '
       
     -+# Tests for default HEAD:.git-blame-ignore-revs blob
     -+test_expect_success 'setup default HEAD:.git-blame-ignore-revs' '
     ++# Tests for default .git-blame-ignore-revs
     ++test_expect_success 'setup default .git-blame-ignore-revs' '
      +	git checkout -b default-file-branch &&
      +	test_write_lines line1 line2 >def-file &&
      +	git add def-file &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
      +	git tag DEF_B &&
      +
      +	git rev-parse DEF_B >.git-blame-ignore-revs &&
     ++	git blame --line-porcelain def-file >blame_raw &&
     ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     ++	git rev-parse DEF_A >expect &&
     ++	test_cmp expect actual &&
     ++
      +	git add .git-blame-ignore-revs &&
      +	test_tick &&
      +	git commit -m "add .git-blame-ignore-revs"
      +'
      +
     -+test_expect_success 'default HEAD:.git-blame-ignore-revs is used by default' '
     ++test_expect_success 'default .git-blame-ignore-revs is used by default' '
      +	git blame --line-porcelain def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	git rev-parse DEF_A >expect &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'default HEAD:.git-blame-ignore-revs respected by git annotate' '
     ++test_expect_success 'default .git-blame-ignore-revs respected by git annotate' '
      +	git rev-parse --short DEF_A >expect_sha &&
      +	git annotate def-file >actual &&
      +	test_grep "^$(cat expect_sha)" actual
      +'
      +
     -+test_expect_success 'default HEAD:.git-blame-ignore-revs works from subdirectory' '
     ++test_expect_success 'default .git-blame-ignore-revs works from subdirectory' '
     ++	test_when_finished "rm -rf sub" &&
      +	mkdir -p sub &&
     ++	echo "invalid-oid-value" >sub/.git-blame-ignore-revs &&
      +	(
      +		cd sub &&
      +		git blame --line-porcelain ../def-file >blame_raw &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
      +	git -C bare.git blame --line-porcelain def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	git rev-parse DEF_A >expect &&
     ++	test_cmp expect actual &&
     ++
     ++	git -C .git blame --line-porcelain HEAD -- def-file >blame_raw &&
     ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'uncommitted .git-blame-ignore-revs changes in working tree are ignored' '
     ++test_expect_success 'uncommitted .git-blame-ignore-revs changes in working tree are respected' '
      +	test_when_finished "git checkout -- .git-blame-ignore-revs" &&
     -+	echo "invalid-oid-value" >.git-blame-ignore-revs &&
     ++	: >.git-blame-ignore-revs &&
      +	git blame --line-porcelain def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     -+	git rev-parse DEF_A >expect &&
     -+	test_cmp expect actual
     ++	git rev-parse DEF_B >expect &&
     ++	test_cmp expect actual &&
     ++
     ++	rm .git-blame-ignore-revs &&
     ++	git blame --line-porcelain def-file >blame_raw &&
     ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     ++	test_cmp expect actual &&
     ++
     ++	echo "invalid-oid-value" >.git-blame-ignore-revs &&
     ++	test_must_fail git blame def-file
      +'
      +
     -+test_expect_success 'disable default HEAD:.git-blame-ignore-revs with --no-ignore-revs-file' '
     ++test_expect_success 'disable default .git-blame-ignore-revs with --no-ignore-revs-file' '
      +	git blame --line-porcelain --no-ignore-revs-file def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	git rev-parse DEF_B >expect &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'disable default HEAD:.git-blame-ignore-revs with --ignore-revs-file ""' '
     ++test_expect_success 'disable default .git-blame-ignore-revs with --ignore-revs-file ""' '
      +	git blame --line-porcelain --ignore-revs-file "" def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	git rev-parse DEF_B >expect &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'disable default HEAD:.git-blame-ignore-revs with blame.ignoreRevsFile=""' '
     ++test_expect_success 'disable default .git-blame-ignore-revs with blame.ignoreRevsFile=""' '
      +	test_config blame.ignoreRevsFile "" &&
      +	git blame --line-porcelain def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'default HEAD:.git-blame-ignore-revs handles comments and whitespace' '
     ++test_expect_success 'default .git-blame-ignore-revs handles comments and whitespace' '
      +	rev_def_b=$(git rev-parse DEF_B) &&
      +	{
      +		echo "# Leading comment" &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'empty default HEAD:.git-blame-ignore-revs is harmless' '
     ++test_expect_success 'empty default .git-blame-ignore-revs is harmless' '
      +	: >.git-blame-ignore-revs &&
      +	git add .git-blame-ignore-revs &&
      +	test_tick &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'committed symlink .git-blame-ignore-revs in HEAD is ignored' '
     -+	git rm -f .git-blame-ignore-revs &&
     ++test_expect_success SYMLINKS 'symlink .git-blame-ignore-revs in working tree is ignored' '
     ++	test_when_finished "git checkout -- .git-blame-ignore-revs && rm -f target_file" &&
      +	git rev-parse DEF_B >target_file &&
     -+	test_ln_s_add target_file .git-blame-ignore-revs &&
     ++	rm -f .git-blame-ignore-revs &&
     ++	ln -s target_file .git-blame-ignore-revs &&
     ++	git blame --line-porcelain def-file >blame_raw &&
     ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     ++	git rev-parse DEF_B >expect &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'committed symlink .git-blame-ignore-revs in bare repo HEAD is ignored' '
     ++	test_when_finished "git reset --hard HEAD~ && rm -rf bare-symlink.git" &&
     ++	blob=$(printf "%s" "target_file" | git hash-object -w --stdin) &&
     ++	git update-index --replace --cacheinfo 120000,$blob,.git-blame-ignore-revs &&
      +	test_tick &&
      +	git commit -m "symlink .git-blame-ignore-revs" &&
     -+	git blame --line-porcelain def-file >blame_raw &&
     ++	git clone --bare . bare-symlink.git &&
     ++	git -C bare-symlink.git blame --line-porcelain def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	git rev-parse DEF_B >expect &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'malformed default HEAD:.git-blame-ignore-revs fails but can be bypassed' '
     ++test_expect_success 'malformed default .git-blame-ignore-revs fails but can be bypassed' '
      +	git rm -f .git-blame-ignore-revs &&
      +	echo "invalid-oid-value" >.git-blame-ignore-revs &&
      +	git add .git-blame-ignore-revs &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
      +	test_grep "invalid object name:" err
      +'
      +
     -+test_expect_success 'default HEAD:.git-blame-ignore-revs combined with config blame.ignoreRevsFile' '
     ++test_expect_success 'default .git-blame-ignore-revs combined with config blame.ignoreRevsFile' '
      +	git rev-parse DEF_B >.git-blame-ignore-revs &&
      +	test_write_lines line1-modified line2-c >def-file &&
      +	git add .git-blame-ignore-revs def-file &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'blame works when HEAD:.git-blame-ignore-revs does not exist and ignores untracked file' '
     -+	test_when_finished "rm -f .git-blame-ignore-revs" &&
     ++test_expect_success 'blame works when .git-blame-ignore-revs does not exist' '
      +	git rm -f .git-blame-ignore-revs &&
      +	test_tick &&
      +	git commit -m "remove .git-blame-ignore-revs" &&
     -+	git rev-parse DEF_B >.git-blame-ignore-revs &&
      +	git blame --line-porcelain def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	git rev-parse DEF_B >expect &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success EXPENSIVE 'overly large default HEAD:.git-blame-ignore-revs blob is ignored' '
     -+	blob=$(dd if=/dev/zero bs=1048576 count=101 2>/dev/null |
     -+		git hash-object -w --stdin) &&
     ++test_expect_success EXPENSIVE 'overly large default .git-blame-ignore-revs is ignored' '
     ++	test_when_finished "rm -f .git-blame-ignore-revs" &&
     ++	dd if=/dev/zero of=.git-blame-ignore-revs bs=1048576 count=101 2>/dev/null &&
     ++	git blame --line-porcelain def-file >blame_raw 2>err &&
     ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     ++	git rev-parse DEF_B >expect &&
     ++	test_cmp expect actual &&
     ++	test_grep "warning: ignoring overly large ignore-revs file '\''.git-blame-ignore-revs'\''" err &&
     ++
     ++	blob=$(git hash-object -w .git-blame-ignore-revs) &&
     ++	rm -f .git-blame-ignore-revs &&
      +	git update-index --add --cacheinfo 100644,$blob,.git-blame-ignore-revs &&
      +	test_tick &&
      +	git commit -m "overly large .git-blame-ignore-revs" &&
      +	test_when_finished "git reset --hard HEAD~" &&
     -+	git blame --line-porcelain def-file >blame_raw 2>err &&
     ++	git -C .git blame --line-porcelain HEAD -- def-file >blame_raw 2>err &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     -+	git rev-parse DEF_B >expect &&
      +	test_cmp expect actual &&
      +	test_grep "warning: ignoring overly large ignore-revs blob '\''HEAD:.git-blame-ignore-revs'\''" err
      +'

-- 
gitgitgadget
