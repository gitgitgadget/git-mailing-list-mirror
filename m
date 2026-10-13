Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C9374E5A
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922935; cv=none; b=O/gviT+8MDiWLxGK7UHss7HS3V2nd1x0HFZpzfVrUsB5GUcSKFqyVzpXj0Sns/HNQf8jAM2wRMjt84eiQJkJw2/MkjFG1AmYKjkNLqI8pIiUZ1A16+yqDfrpw2tBVvBgDwd3cRrRerilr/sZaAJUa/gZOjCA3k5UsUIbSHCPFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922935; c=relaxed/simple;
	bh=xJ4vYJI3UCJrOd+MNXHiJZ9cLuHOBIWDgeyrPcOHCm8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LaUeGPa7CRQRQDYF7vWi5CS7l210pqDIHA7xpDJV6RlnBWe0UCPoFNAT8IDSbuA7Dv1lcpZiddUFm8A0ADOUuwcrqdv7eLJqUf+7DbMduZxtqWJ1WsnShCYa+Gjefi9/GcsN+AlJafm6bOv/Ve+RbMEUPNQ9EIJUKfoS1tc/7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdiBYT3C; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdiBYT3C"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-81c5aac8478so2466236a34.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922932; x=1792527732; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j73gsV8W9D1D9D5dLxZ3PX783dFG6ml1jvZyWcKAhuA=;
        b=CdiBYT3CAWiPTyd5F1zv6WtfSoek6pE2kLf/CQQdlorJDGonD7VnVHzqQti9xxHcCF
         pdGFfHy6RtwrkCDt5/SOTUfNbIGS+Ypc0FAXajezfOxN4ukzf5+W6HcJaP2ALlrlIGUe
         xypl375XCfInizZNEGLbrFhsJRCRgYQG1pYnHnzKYu6ktiPL8arRZq2zaBjOxEIZxXMM
         YKXJb/cV648I0YwwBkp5XNjCsBbxASXnQ+wIru8WYpJX90OXGCFA4UWd3LMak1KIl33/
         9ck38u+lymgonw8Ayh4iogtRlIRCUgA9fKb/Pzs4FEZKpUtmuashOFcX8AHTy2mWmTdj
         /XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922932; x=1792527732;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j73gsV8W9D1D9D5dLxZ3PX783dFG6ml1jvZyWcKAhuA=;
        b=oaNXVJ0xx9S1yUuRZl6NZxvAtN1f8eN1+bP3MYaTRMmwedB+Ur34bIgR0dcXv2APaU
         6PoHNIPFKNhIFEvh8NS+uANDNTtZ7F+HDFjH8LYr+52mIbXksvADdJHeXjjDX9c3vlYS
         ywpS09lrfhQCNS/Bi0RNSx250AiuyIjoq+sWZtenZwLJbUra+7rKLcEwbjQ1LadhHTPC
         SQH5AkLbx5U6aaCaTxgSJmBTT5O4C7qGehvOwHcGLKc4SESnjgg/MSALBWjC1bwEwa+M
         sROjC4ZxKxdKGYg4jQeblTzMhiT+nr0OVKReOIEVjefDYEHgvWz+jR4bAx3ax4Mvtdj4
         n3Tg==
X-Gm-Message-State: AFq9FYI4zybgKWUXbqqdx1cXRj/tm1zmo00S7F+fayKzIOyWIqPhcZMu
	jQOYKvTb8TlCXoqaYtOOGGIf2K7ilcgxBF1pslKk9HDuTnClYyPDmwwT+oVrVw==
X-Gm-Gg: AYBFou3UmxLQ5e0QR5EfIifdlzZnJpa3YXmukEN74qDJKTc1LIgFDPgSU+PF2vWoIcr
	Uim4UW7gg2hPIAVTh1y9gHERJAZkRJ5tnA98+YrS87KvmQDn5M8sLuwkrD4DmZN2CHy+efmR19Y
	hh+Qt3VQyHNQDt3sLPDkT5cLJYvMiWVE70IFJQ4wfJUi43gOKRWJ/4Iox9K0GxKTwwcnBEVFLHE
	6X5Uno5FNgNcJ0sbHaDepSyoCmDluuaJoJDXLtLtBBo3I09LcdqClLmOfmGr4vQeb8iMPzVka1W
	I11koV/HU7FufDnPnXaR8SaBuDANgYFuub7l3SrN6OaFBCnJ/yQhAkfyknuk4yTHpyU3JHkvoVM
	YBa3wtnvcn/IIEk/HGmh9LEZ8gQB6sj2oL07cJuWjIGl8GAMwsmzZyOIkb0WCClk0ElhMwTPBGa
	OoIoLbJTvOMmcgIYQWw1L+0FTQ6RZpRViTyw9W0xtSNDBrxmL+Emq684gbpRfsqPoVMPEEOBo3e
	pFDercmQPj6
X-Received: by 2002:a05:6830:440a:b0:822:e94e:349b with SMTP id 46e09a7af769-8309815d753mr13280602a34.30.1791922930904;
        Tue, 13 Oct 2026 13:22:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.15.229.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8367ada5b6fsm6859847a34.21.2026.10.13.13.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:22:10 -0700 (PDT)
Message-Id: <pull.2224.v6.git.1791922928.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Oct 2026 20:22:06 +0000
Subject: [PATCH v6 0/2] blame: ignore revs in .git-blame-ignore-revs by default
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

Changes since v5:

 * Passed i->string from build_ignorelist() into parse_default_ignore_revs()
   so the item string is used for both the working-tree path and "HEAD:" in
   bare repositories, and changed cmd_blame() to set ->util = (void *)1 with
   an explanatory comment instead of passing the scoreboard.
 * Doc update: Changed "config option" / "configuration option" to
   "configuration variable" in Documentation/blame-options.adoc and the
   commit message.

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
 builtin/blame.c                  | 122 +++++++++++++-
 oidset.c                         |  81 ++++++---
 oidset.h                         |   9 +
 t/t8013-blame-ignore-revs.sh     | 271 +++++++++++++++++++++++++++++++
 6 files changed, 467 insertions(+), 35 deletions(-)


base-commit: fa7f9290efe2bd22dd736689597b474b93798e11
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2224%2Frmistry%2Fblame-default-ignore-revs-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2224/rmistry/blame-default-ignore-revs-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/2224

Range-diff vs v5:

 1:  e9b2c1dae2 = 1:  e9b2c1dae2 blame: harden ignore-revs parser and tag peeling
 2:  605eb049a1 ! 2:  6039d4bc2d blame: ignore revs in .git-blame-ignore-revs by default
     @@ Commit message
          blame: ignore revs in .git-blame-ignore-revs by default
      
          git-blame(1) can ignore a list of commits specified via
     -    --ignore-revs-file or the blame.ignoreRevsFile configuration option.
     +    --ignore-revs-file or the blame.ignoreRevsFile configuration variable.
          This is useful for skipping uninteresting revisions such as tree-wide
          formatting changes, large-scale refactors, and code modernizations that
          would otherwise obscure genuine historical authorship.
     @@ Commit message
          .git-blame-ignore-revs, if it exists, as the initial element in the
          list of ignore-revs files. Similar to how read_mailmap() handles
          .mailmap, consult .git-blame-ignore-revs at the root of the working
     -    tree when a working tree is available and fall back to the
     -    HEAD:.git-blame-ignore-revs blob in bare repositories. Reading from the
     -    working tree in non-bare repositories makes it ergonomic to prepare a
     -    new .git-blame-ignore-revs file or add revisions to an existing one and
     -    immediately test the effect with git-blame(1) before committing, while
     -    falling back to HEAD:.git-blame-ignore-revs allows bare repositories to
     +    tree when a working tree is available, and otherwise consult the
     +    HEAD:.git-blame-ignore-revs blob in bare repositories. Reading only
     +    from the working tree in non-bare repositories makes it ergonomic to
     +    prepare a new .git-blame-ignore-revs file, edit an existing one, or
     +    remove a committed one and immediately test the effect with
     +    git-blame(1) before committing, while consulting
     +    HEAD:.git-blame-ignore-revs in bare repositories allows them to
          respect the committed ignore list as well.
      
          To ensure consistent precedence, override semantics, and safety when
     @@ Documentation/blame-options.adoc: take effect.
      +	processed after the default `.git-blame-ignore-revs` file at the root of
      +	the working tree (or `HEAD:.git-blame-ignore-revs` in a bare repository),
      +	if it exists, and any files specified with the `blame.ignoreRevsFile`
     -+	config option.  An empty file name, `""`, or `--no-ignore-revs-file` will
     -+	clear the list of revs from previously processed files, including the
     -+	default ignore-revs file.
     ++	configuration variable.  An empty file name, `""`, or
     ++	`--no-ignore-revs-file` will clear the list of revs from previously
     ++	processed files, including the default ignore-revs file.
       
       `--color-lines`::
       	Color line annotations in the default format differently if they come from
     @@ builtin/blame.c: static int peel_to_commit_oid(struct object_id *oid_ret, void *
      +#define IGNORE_REVS_MAX_FILE_SIZE (100 * 1024 * 1024)
      +
      +static void parse_default_ignore_revs_blob(struct blame_scoreboard *sb,
     -+					   const char *name)
     ++					   const char *path)
      +{
     ++	char *name = xstrfmt("HEAD:%s", path);
      +	struct object_context oc;
      +	struct object_id oid;
      +	enum object_type type;
     @@ builtin/blame.c: static int peel_to_commit_oid(struct object_id *oid_ret, void *
      +
      +out:
      +	object_context_release(&oc);
     ++	free(name);
      +}
      +
      +static void parse_default_ignore_revs_file(struct blame_scoreboard *sb,
     @@ builtin/blame.c: static int peel_to_commit_oid(struct object_id *oid_ret, void *
      +	free(path);
      +}
      +
     -+static void parse_default_ignore_revs(struct blame_scoreboard *sb)
     ++static void parse_default_ignore_revs(struct blame_scoreboard *sb,
     ++				      const char *name)
      +{
      +	if (repo_get_work_tree(sb->repo))
     -+		parse_default_ignore_revs_file(sb, ".git-blame-ignore-revs");
     ++		parse_default_ignore_revs_file(sb, name);
      +	else
     -+		parse_default_ignore_revs_blob(sb, "HEAD:.git-blame-ignore-revs");
     ++		parse_default_ignore_revs_blob(sb, name);
      +}
      +
       static void build_ignorelist(struct blame_scoreboard *sb,
     @@ builtin/blame.c: static int peel_to_commit_oid(struct object_id *oid_ret, void *
      +	for (idx = start_idx; idx < ignore_revs_file_list->nr; idx++) {
      +		i = &ignore_revs_file_list->items[idx];
      +		if (i->util)
     -+			parse_default_ignore_revs(sb);
     ++			parse_default_ignore_revs(sb, i->string);
       		else
       			oidset_parse_file_carefully(&sb->ignore_list, i->string,
       						    the_repository->hash_algo,
     @@ builtin/blame.c: int cmd_blame(int argc,
       	const char *const *opt_usage = cmd_is_annotate ? annotate_opt_usage : blame_opt_usage;
       
       	setup_default_color_by_age();
     ++	/*
     ++	 * An entry with a non-NULL .util member names the default
     ++	 * ignore-revs file at the project root; see build_ignorelist().
     ++	 */
      +	string_list_append(&ignore_revs_file_list,
     -+			   ".git-blame-ignore-revs")->util = &sb;
     ++			   ".git-blame-ignore-revs")->util = (void *)1;
       	repo_config(the_repository, git_blame_config, &output_option);
       	repo_init_revisions(the_repository, &revs, NULL);
       	revs.date_mode = blame_date_mode;

-- 
gitgitgadget
