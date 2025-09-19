Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A262EB853
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270416; cv=none; b=AP6wP/WY9RTCLE+klonpkC6Mg9Azhpe6S92mjEFB/zqLkqc59vfJn6O7zr2EK9IlGnZtO9biYvZMgJWUG9u1MtB331CndIjY7u+g3+kdiHgWJ/F2iedK90/iGa5JcnP4/91b/4oOuwPX/07x9x+NR1zzxBGrDcIdmadeoEZW4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270416; c=relaxed/simple;
	bh=w2OMFVj8wo7StJVEFjkfEn9nIAAWKlm5QcybRvByAq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9zY9G83pAlDHMmiTDGFMeifZro13PMBOpPdoo3NQH0lRtXATZs5cHPx6NBvA1y/BiotVjhB8fS8vTy9yGVxJu7/KJFHT3VxBnFonuK2ugEnV6CqIKSRtgq/F8AicAgzjqI3TNnUF8XQUS2/L03DKsiCBlKdLInSJFD0rMb2zR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6HJwvpj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6HJwvpj"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7761b83fd01so1865855b3a.3
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758270413; x=1758875213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAP73apCOYbJekfWrOuTwf7EtHOoYBQUZnmnen5sAgM=;
        b=K6HJwvpj46KR5gb1LO6IBlNtcdcC8HMxRPXmlJL/UwbypZJy25lhVzHhmFXzw34Grl
         03FbhUY/gjxdDE5wZcvhtb/s62Xk/j4AP7GdJtc4xxNVpiC+f+CImPrg6Fvt5709e7y/
         Vhx2d88l1t4rS6DmQyGOYpsVH5Ioj0OFU+qoYy5cUruVzDiwHDEiuEJMdoalRX8KCHHl
         Xp4MCYIzAQML0/qMR0pxdZsxneV85Rv/6zU+oWTXbVSmVZoxuWcCapKIgG4MRB8Ac+R/
         jizcB8LYAi/SMRwR2MD+6R+hm97FORPfx323eHP/BAHiA+dRbgn3lALBGyffmZtpdWph
         mbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270413; x=1758875213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAP73apCOYbJekfWrOuTwf7EtHOoYBQUZnmnen5sAgM=;
        b=o3P391N64YEzuueCwZLQeKRp3Ee09+xJirYv18q7Aizy8J90GqrK1Map3hj9A3W5ZF
         1BQyK5PJy0gj6uNKzT0DXHA0CIS+p8SaBzWB63Of9Oo7YrugCWjLs2Oojjye1OYvvNUK
         w6S4sy0NT0FS69x0hNkNkDcLmakiv9GObL22ycCTRdthHnu3gi/nVr6gmbCe8XiOa2Ak
         JYxp6yX76eT5RTnYlTShnQsXttv4kwvLDl/EKmpG72Fom+bs4jEJ5MUzTKCv1Y7s3m7V
         B5XD8AKlQrfmIFFkJTymsskv9We9ihk6hzri81qZrGAMjQmvO06hX7uYZgyVVwnu65sU
         Elgg==
X-Gm-Message-State: AOJu0YyrOhaaXlw1D9RXPNwZEh//GH2Bjvnr8dgjJWIg+bHiz23uoBxs
	oRQ2lXRbFTqZWUkqHzyCuMgwSa98eypY1GEVe/l7w8yLpB6LpOvoGOQ+H800Zg==
X-Gm-Gg: ASbGncuLdTaoRUZcgcPR+2dAR+FjcsLgDimhFa/v6QYHFxP5R48/dpvosAkVzO6CFMq
	ajPDEBA34oveyMsZtcGDDWsc6YkQoQmYzAXobUzweRm49PwKAsjakSudMcPs+LLd+75j34Kf0JQ
	WFIVjOmne4aoDBpIDYeAvm7d29sR6GS6BzMk03vhQPex8QxPLCsknIgGlmUvtb/fb9drbd8+ITt
	z98R54SPISrnr1njShDjE7Lgwv+jjEqYjDYSYkPN2Kf93pWdVGYBz9jDXQsH08+9Elcf+Wo25ij
	iafhJ5t2Dm21rniknFNs84mwYrHND7qYUtUD6hFJM99HMfyJWqYQA5KM5YJFbZaeZh/o3oxKNrr
	UFSGiYhFczcgskqEDut4=
X-Google-Smtp-Source: AGHT+IGWEFK7vT5p4A9PClwjfyYwVPSAqyz7U/v87ACQGkH6jaDbB7dhsduIEDhWCC7eA90aOYkYYw==
X-Received: by 2002:a05:6a20:e293:b0:243:c4e1:c97a with SMTP id adf61e73a8af0-2926c3c91d2mr3880480637.34.1758270413486;
        Fri, 19 Sep 2025 01:26:53 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060803335sm4774254a91.24.2025.09.19.01.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:26:52 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v4 0/9] Add refs optimize subcommand
Date: Fri, 19 Sep 2025 13:56:38 +0530
Message-Id: <20250919082647.535213-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918054704.544254-1-meetsoni3017@gmail.com>
References: <20250918054704.544254-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series introduces `git refs optimize` as a modern replacement for
`git pack-refs`, continuing the effort to consolidate commands under the
`git refs` namespace.

Changes in v4:
- Improved commit messages and formatting.
- Removed the NULL check from the refs_optimize() dispatcher in refs.c
  to align with the project's conventions for API functions

Meet Soni (9):
  refs: add a generic 'optimize' API
  files-backend: implement 'optimize' action
  reftable-backend: implement 'optimize' action
  builtin/pack-refs: convert to use the generic refs_optimize() API
  builtin/pack-refs: factor out core logic into a shared library
  doc: pack-refs: factor out common options
  builtin/refs: add optimize subcommand
  t0601: refactor tests to be shareable
  t: add test for git refs optimize subcommand

 Documentation/git-pack-refs.adoc     |  53 +---
 Documentation/git-refs.adoc          |  10 +
 Documentation/pack-refs-options.adoc |  52 ++++
 Makefile                             |   1 +
 builtin/pack-refs.c                  |  54 +---
 builtin/refs.c                       |  17 ++
 meson.build                          |   1 +
 pack-refs.c                          |  56 ++++
 pack-refs.h                          |  23 ++
 refs.c                               |   5 +
 refs.h                               |   6 +
 refs/files-backend.c                 |  10 +
 refs/refs-internal.h                 |   3 +
 refs/reftable-backend.c              |   7 +
 t/meson.build                        |   3 +-
 t/pack-refs-tests.sh                 | 431 +++++++++++++++++++++++++++
 t/t0601-reffiles-pack-refs.sh        | 430 +-------------------------
 t/t1463-refs-optimize.sh             |  17 ++
 18 files changed, 648 insertions(+), 531 deletions(-)
 create mode 100644 Documentation/pack-refs-options.adoc
 create mode 100644 pack-refs.c
 create mode 100644 pack-refs.h
 create mode 100644 t/pack-refs-tests.sh
 create mode 100755 t/t1463-refs-optimize.sh

Range-diff against v3:
 1:  a837ae6f5d !  1:  8d8aa56fe9 refs: add a generic 'optimize' API
    @@ Metadata
      ## Commit message ##
         refs: add a generic 'optimize' API
     
    -    Add a new generic refs_optimize() API function that dispatches to a
    +    The existing `pack-refs` API is conceptually tied to the 'files'
    +    backend, but its behavior is generic (e.g., it triggers compaction for
    +    reftable). This naming is confusing.
    +
    +    Introduce a new generic refs_optimize() API that dispatches to a
         backend-specific implementation via a new 'optimize' vtable method.
     
         This lays the architectural groundwork for different reference backends
    @@ refs.c: int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts)
      
     +int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
     +{
    -+	if (!refs->be->optimize)
    -+		return 0;
     +	return refs->be->optimize(refs, opts);
     +}
     +
 2:  e0613b14b6 =  2:  aebdf90fef files-backend: implement 'optimize' action
 3:  ae8d2d29d9 =  3:  0b41b52e36 reftable-backend: implement 'optimize' action
 4:  a8cba8a355 !  4:  bcb76f2460 builtin/pack-refs: convert to use the generic refs_optimize() API
    @@ Metadata
      ## Commit message ##
         builtin/pack-refs: convert to use the generic refs_optimize() API
     
    -    The `git pack-refs` command is tied to the 'files' reference backend. In
    -    a repository that uses a different backend (like 'reftable'), the
    -    command is a no-op.
    +    The `git pack-refs` command behaves generically, triggering a pack for
    +    the 'files' backend and a compaction for the 'reftable' backend.
    +    However, the name of the command and its corresponding API is
    +    conceptually tied to the 'files' backend implementation.
     
    -    To make `git pack-refs` a truly generic frontend for reference
    -    optimization, refactor it to use the new generic `refs_optimize()` API.
    -    This will allow the command to automatically work with any backend
    -    that implements the `optimize` action in the future.
    +    To create a cleaner, more generic interface, refactor `git pack-refs` to
    +    use the new `refs_optimize()` API. "Optimize" is a better semantic term
    +    for this generic action.
     
    -    The command continues to handle parsing its own command-line options,
    -    but now calls the generic API to perform the action instead of a
    -    backend-specific function.
    +    This change allows `git pack-refs` to act as a backend-agnostic frontend
    +    for reference optimization, and paves the way for the new `git refs
    +    optimize` command to do the same.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: shejialuo <shejialuo@gmail.com>
 5:  ec1085ccd8 =  5:  6c6d63edff builtin/pack-refs: factor out core logic into a shared library
 6:  e1758816bf =  6:  5c5d3e2699 doc: pack-refs: factor out common options
 7:  e3a908fe72 !  7:  d2bff276b8 builtin/refs: add optimize subcommand
    @@ builtin/refs.c: static int cmd_refs_list(int argc, const char **argv, const char
      }
      
     +static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
    -+			   struct repository *repo)
    ++			     struct repository *repo)
     +{
     +	static char const * const refs_optimize_usage[] = {
     +		REFS_OPTIMIZE_USAGE,
 8:  4f63632ac2 =  8:  5a865d2828 t0601: refactor tests to be shareable
 9:  39eed2831a =  9:  3d7d40b510 t: add test for git refs optimize subcommand

base-commit: f814da676ae46aac5be0a98b99373a76dee6cedb
-- 
2.34.1

