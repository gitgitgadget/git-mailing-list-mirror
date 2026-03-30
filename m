Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE42374E43
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891672; cv=none; b=Q2dD85ksO6vlaDaJ9r4+gRnIhIb1rrGiikKY5zHXEyRE7VGyCPaa5Wpg2u0dnPwIEY1uIQp67BNV4ZwOuszuBcqIeK0idTiE5/hTbW43gnSb7eoXw9itywwmnncUOgrm2O71mjSbpE5XByy4tXrWuuUNQWjQbXpv6DWGBoZajxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891672; c=relaxed/simple;
	bh=BCFv5ZXEJ6JCgeyzoAJZsjGUPyFyhJYbpJUIChEEfcU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yt/UMpfhFd/YBq2UTKmR5BnbOysShv6hPQ0IkETGe+HcZm3cSXjQWzuC7UwqrG9XJLU3qUx4roYz0NbPWfF5JGGjSCxSgQ8n4gIYsaJUYVdQqgK0uDrS6Jt95eRmkxlNfP+Q0qcRF4bMxlOiYkxHhV8ltc4HlwT+EEEsAYDRA+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlL5/a8g; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlL5/a8g"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9694so445048c88.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774891669; x=1775496469; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aphQfZ5EJdkrYx5CWc7xI5rK552v5kAXtYWDcBrSdLs=;
        b=UlL5/a8g/B4lkPTrdKprKTeEezGlXOxHIttAaDJ8BDNFa3P8b1hdih8D+phuyHEbYN
         FtAUy96gEZEPZkKh7u/FDrWt3sUs76OVktKv1NcpOzg3YVYIFZJvDRvOQWK4dTpa3xrT
         tY6cVDR1RqzBwuF75ImPfN8QGyVPx1MuhsRJM1tGHFBM0k0uvHjMM0XC0xjTzCo9rsZI
         h0/VVRBV8uMdzDITcPgwRo2sftLWdSdFp+/czyVnhuqcLpgfE7gwO7W+MaVGv+fW8RWo
         6wwiveyvdLg9PqTJ0mtGDP+5KfwaxucPM5GkoFleFNYj+PvMgMYva6AKKPv1GIh0qKaf
         vwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774891669; x=1775496469;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aphQfZ5EJdkrYx5CWc7xI5rK552v5kAXtYWDcBrSdLs=;
        b=J/g8b4XvOIs1sFEgf9zRCFYkSVW72/P0TqifWB/0Mn80KNAx1e5X787YkLFnyo5mO/
         Ol6BF7XFUz6pwhtvmm9ViazXIoNh1MSZCYcuPOexpc5Yg5U5KCjPsBCwij2jXN0MNMfr
         mDcn8ocaT8Y/SpXzTbSSmFS6rq+ZViUAQ9o4H6DAchn4hc/kEl3/zPA+TIL+oapUvJTH
         jqxe9KLU854Uaw3rfFI4LdmVha23PtbWCnIQxGeH9U6bhpEDKKMps8HMxTjsoQQE3Uhe
         0aJKjycNCTARVulbLBtoo79Wlkv4SY6MYZwc2ECeeJoYI4cubvaLTdCuCiAmm55tNm5c
         iVeQ==
X-Gm-Message-State: AOJu0YxkMHZg1yQNcRZEnm/CQLNh1v8ml7oX1f7VZ+j4FIVimFTlIVBk
	4u3LFSO3UkO2XcnVRMjzIJL9spcFenGIbfFwLkUtFGNX4SL0SLlTiihLo68rLQ==
X-Gm-Gg: ATEYQzxLi4+C+/wRiMhdKurDG73O2uhoE0w8cjdkwJOBV6julivyLWHmyGVscd2F738
	U8S6Bi4b/o04Q428zgiAw3UzsDsb77HdvBMae0Gpv56nE4AKJM7xcmKLJV1P7vQpBQEbCHxuRKY
	bauLqGuZY+ZUb5STzABQ71Cu14MVsXaLOvUO7k2eM8XUT6o28ZYb318hyR1SqN8PIkw3IYuH5p+
	2b1eSKX39lmMq4TPLLNksUoPGx0DaM+OS+qpGroIJmov4UST5bKVAQvuukTS/nFyUTx8hrp0HtH
	jaiucJEvbLXSeOze3L+tpch4vxFnLRKu+b08zpiUSjLLYbvo7XKvQ15R+2+F0D7j9+FaQSIT/Gp
	loCbX0JwtzI5VyRC33H1swDrNI2LgW030gOpIh+hy6E11+Ipag+KEYv5oaFsk5TO6vP4qbzHsfi
	UarckAxWfHGkAl/VhPusX5Klu7jw==
X-Received: by 2002:a05:7022:f8a:b0:119:e56b:957b with SMTP id a92af1059eb24-12ab276d87fmr8151382c88.0.1774891669206;
        Mon, 30 Mar 2026 10:27:49 -0700 (PDT)
Received: from [127.0.0.1] ([52.225.73.164])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm12125988c88.3.2026.03.30.10.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:27:48 -0700 (PDT)
Message-Id: <pull.2253.v3.git.git.1774891667.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v2.git.git.1774682046750.gitgitgadget@gmail.com>
References: <pull.2253.v2.git.git.1774682046750.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 17:27:45 +0000
Subject: [PATCH v3 0/2] [GSoC] read-cache: use index state repository for trace2 logging
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
Cc: Jayesh Daga <jayeshdaga99@gmail.com>

trace2 calls in read-cache.c use the global 'the_repository', even though
the relevant index_state provides an explicit repository pointer via
'istate->repo'.

Using the global repository can result in incorrect trace2 output when
multiple repository instances are in use, as events may be attributed to the
wrong repository.

Use 'istate->repo' instead in these call sites to ensure correct repository
attribution.

Changes since v2:

 * Apply the change consistently across read-cache.c
 * Drop unnecessary intermediate variable
 * Remove obsolete TODO comments
 * Update commit message

Jayesh Daga (1):
  read-cache: use istate->repo for trace2 logging

jayesh0104 (1):
  repo: add paths.git_dir repo info key

 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              |  7 +++++++
 read-cache.c                | 32 ++++++++------------------------
 t/t1900-repo-info.sh        | 10 ++++++++++
 4 files changed, 30 insertions(+), 24 deletions(-)


base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2253%2Fjayesh0104%2Ftrace2-istate-repo-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2253/jayesh0104/trace2-istate-repo-v3
Pull-Request: https://github.com/git/git/pull/2253

Range-diff vs v2:

 -:  ---------- > 1:  5a8165b05d repo: add paths.git_dir repo info key
 1:  7fdfaaef9b ! 2:  9bb6d0fa01 read-cache: use istate->repo for trace2 logging
     @@ Metadata
       ## Commit message ##
          read-cache: use istate->repo for trace2 logging
      
     -    trace2_data_intmax() calls in do_read_index() currently use the
     -    global 'the_repository' instance, even though the index_state
     -    already carries an explicit repository pointer (istate->repo).
     +    trace2 calls in read-cache.c use the global 'the_repository',
     +    even though the relevant index_state provides an explicit
     +    repository pointer via 'istate->repo'.
      
     -    index_state instances are initialized via INDEX_STATE_INIT(r),
     -    which sets istate->repo. Using the_repository here is therefore
     -    redundant and obscures the actual repository context associated
     -    with the index being read.
     +    Using the global repository can result in incorrect trace2
     +    output when multiple repository instances are in use, as
     +    events may be attributed to the wrong repository.
      
     -    In particular, using the global repository can lead to misleading
     -    trace2 output in scenarios where multiple repository instances are
     -    in use (such as tests or future refactoring toward better library
     -    boundaries), as events may be attributed to the wrong repository.
     -
     -    Switch these calls to use istate->repo directly, making the
     -    association between the index and its repository explicit.
     -
     -    Since istate->repo is expected to be non-NULL, enforce this
     -    assumption with a BUG() check so that any violation of this
     -    invariant is caught early.
     -
     -    Also remove the now-obsolete TODO comment.
     +    Use 'istate->repo' instead to ensure correct repository
     +    attribution.
      
          Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
      
       ## read-cache.c ##
     -@@ read-cache.c: int do_read_index(struct index_state *istate, const char *path, int must_exist)
     - 	size_t extension_offset = 0;
     - 	int nr_threads, cpus;
     - 	struct index_entry_offset_table *ieot = NULL;
     -+	struct repository *r;
     - 
     - 	if (istate->initialized)
     - 		return istate->cache_nr;
      @@ read-cache.c: int do_read_index(struct index_state *istate, const char *path, int must_exist)
       	}
       	munmap((void *)mmap, mmap_size);
     @@ read-cache.c: int do_read_index(struct index_state *istate, const char *path, in
      -	 * that is associated with the given "istate".
      -	 */
      -	trace2_data_intmax("index", the_repository, "read/version",
     -+	r=istate->repo;
     -+	if (!r)
     -+	    BUG("istate->repo is NULL in do_read_index");
     -+	trace2_data_intmax("index", r, "read/version",
     ++	trace2_data_intmax("index", istate->repo, "read/version",
       			   istate->version);
      -	trace2_data_intmax("index", the_repository, "read/cache_nr",
     -+	trace2_data_intmax("index", r, "read/cache_nr",
     ++	trace2_data_intmax("index", istate->repo, "read/cache_nr",
       			   istate->cache_nr);
       
       	/*
     +@@ read-cache.c: int read_index_from(struct index_state *istate, const char *path,
     + 	if (istate->initialized)
     + 		return istate->cache_nr;
     + 
     +-	/*
     +-	 * TODO trace2: replace "the_repository" with the actual repo instance
     +-	 * that is associated with the given "istate".
     +-	 */
     +-	trace2_region_enter_printf("index", "do_read_index", the_repository,
     ++	trace2_region_enter_printf("index", "do_read_index", istate->repo,
     + 				   "%s", path);
     + 	trace_performance_enter();
     + 	ret = do_read_index(istate, path, 0);
     + 	trace_performance_leave("read cache %s", path);
     +-	trace2_region_leave_printf("index", "do_read_index", the_repository,
     ++	trace2_region_leave_printf("index", "do_read_index", istate->repo,
     + 				   "%s", path);
     + 
     + 	split_index = istate->split_index;
     +@@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
     + 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
     + 	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
     + 
     +-	/*
     +-	 * TODO trace2: replace "the_repository" with the actual repo instance
     +-	 * that is associated with the given "istate".
     +-	 */
     +-	trace2_data_intmax("index", the_repository, "write/version",
     ++	trace2_data_intmax("index", istate->repo, "write/version",
     + 			   istate->version);
     +-	trace2_data_intmax("index", the_repository, "write/cache_nr",
     ++	trace2_data_intmax("index", istate->repo, "write/cache_nr",
     + 			   istate->cache_nr);
     + 
     + 	ret = 0;
     +@@ read-cache.c: static int do_write_locked_index(struct index_state *istate,
     + 		return ret;
     + 	}
     + 
     +-	/*
     +-	 * TODO trace2: replace "the_repository" with the actual repo instance
     +-	 * that is associated with the given "istate".
     +-	 */
     +-	trace2_region_enter_printf("index", "do_write_index", the_repository,
     ++	trace2_region_enter_printf("index", "do_write_index", istate->repo,
     + 				   "%s", get_lock_file_path(lock));
     + 	ret = do_write_index(istate, lock->tempfile, write_extensions, flags);
     +-	trace2_region_leave_printf("index", "do_write_index", the_repository,
     ++	trace2_region_leave_printf("index", "do_write_index", istate->repo,
     + 				   "%s", get_lock_file_path(lock));
     + 
     + 	if (was_full)

-- 
gitgitgadget
