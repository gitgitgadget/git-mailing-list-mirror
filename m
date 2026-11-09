Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251656;
	b=ZP6ELwLJA2FMw86J2xPSqIaXOE8xLFKHq8kfjVBeZTv67uqGfaNwFciNCmqeM/LgxMA0
	 r7hSMjdm6/0HvoLwHFdecJEU5vAWRBSlqfYMO8Y0soqkpJELX1efeqH0F05cnRxfeUW2K
	 w4fJcLKKJC3pWi3KK+/6NqVPy6zZsrwxnXN1mvOQ8g/dXpqaJavpXHJLVsGO92LyKEmln
	 osHMaC/cKageL31trVqQSSc8p8ygTJErmGZEpYxFXyy1/bwikUwge9bcFxn+3lp01vfa+
	 O6/MYdwF4X4r/IVQAyJ5Y8kLwAiw9vGN77WW/kbcAq1IHC9B9VVk20HNDgI7NUzA1RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=qjAgsy9K0Md8zbTEycSiDhHvyCghe6a3mAAQb08jZsM=;
	b=fVozVPg7JfIfaawjowjI+lxt11xStJvoY7sXY8114PpEb7aBqmWUrSeqXYjQ4Ob1LpWz
	 tfkwc6UHLXXvgSSkX8dL00lSTj5vFMH3fHCfT2xYFDDiZSphWRLJSdHfYZN3hVzqCgwEt
	 Mig+q75gOPdvKuR6e9kfNhb4X/dPI8T2g9gMNzWLiZfhTO8jyvCYv9bYSQ8/eBpfJPQCN
	 cnmDh54vcWwyRPJLGXi8msx+sgTJXKNypDFuYSHmkQeBz1MEaUUl6Ku43E7Qx+8XLmuLz
	 MUi3ExMUELjo5vp/uBK+FTfmgNabJcbiF0UG0j5yYKPdDZAMBFlM/NW8DpydFZHnSqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hPR7iN3U;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5F606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 19:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hPR7iN3U
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso843977a91.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 11:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794251655; x=1794856455; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qjAgsy9K0Md8zbTEycSiDhHvyCghe6a3mAAQb08jZsM=;
        b=hPR7iN3UepXolP0RrAjrKfvXU8K384GvBqYFTsHMuMG3DYwynuLB2R3nqPj1jg2DoT
         wkIX/YTP12Otyf4Pts0LjAArBxX/cUG9uu9y/sdB8tNzF/UQCWSemWQTAy+tANZ/EtA1
         0oPtHWxusPdgewsiWVrTv8tij94FDR+cBTu5X7sYohw+JRzxtlmgw0zBJUFW0BNL1+6l
         zqbrX/C1ySm4WWXE5YLf3B0+pqfvtIJMX2f9n4VkMl32pV5ZOIYNBVQC/7sOkDxhXQIZ
         BsWeW7nTarNlWOXLRlx9Ztbenpk1/trGGoM6NqqSLD+WGugn3jiXDj94m8XuovN93GDl
         RW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794251655; x=1794856455;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjAgsy9K0Md8zbTEycSiDhHvyCghe6a3mAAQb08jZsM=;
        b=hQeJX1PRrZgZ2wOa5fgjC02r5IK9puynWfVWPxqigx5TFv0sgJFCadytIVkKwxCeNb
         R9xLdDR3sTQIjSi7aAkueKdPSUjK4hJrHJ1TCt922PDOs7ic01xy+9oOlgE6rAFblRwN
         XoGY8ME155kYvTKEGLDQB1hafmG9DMgWvzOhRdLV/h/bbo7fHRny+Gzyl779cYwe4WJA
         AfeFUQATpcgO7cwE8gm8O6YdB9sKvqL5fMr5EGap1qX1FM89WYOT4sVL81h9ubTSvQ3B
         jX35Rl91ZTCmDVc3tdmorrlvQG817g1qpiiVfwsZ0he6snozZhqsUPbRxdLcju8EeEqn
         7oXA==
X-Gm-Message-State: APuU4Z8mW0LUhoBddP82eIRgqxApFGRz7ZYgLchEL1o+eJsUZOcuX4PK
	1nyX0sJFTn4nIflrXWmPd3vDWypaGnidmZFDKDz/vYswXB1mZqZ9ws0kOeQBvw==
X-Gm-Gg: AYBFou1NF8cJIX/Qj2NBEx4+2v89lUpgkYsxFJwapFaDoAtAEGpbYtr35+eDk4aNrWs
	ZBF1cV+MUqJvPpTqb2AtxvWLe7FGEPbxSW+hWLmgmc7quF31yfdfU1wGhBCiA/5RydbSK/yW82t
	Okb37VwJNqjTP93j7lBnzQIsNq6OtOG+kJnPLAUS8hsZb3Efv7Ywg1zdQUcF4QQjnU/y82tQG+w
	G+72MLAfBYH7SHtZB7Es4tamwS8o9vbH4aE8TL8Oc/d6hUeaHgiZ0mti1kETv2K22pIlKNsAyFy
	fY6hkw5KFDZH3kUH2Aql9jKs2qGz9PmVtbKnIMzboL88QRXs2gQW+ZTyoOVYVAXJj8BAJqLqcOr
	MdYdQ2W7fbA9NiekAZF6jsBXvvGqi2xGi5FBgNEs95/KHdCRxQFppZmNX0U+IpTCgq8npMGepO4
	tcz53nsRAliI60/X6CAErqd73aXvl4CkRZqfAJviCiM8kUPEBfMg1KZiT24KLyxBbXm6HxmFQ5W
	VVLA+OcNbVuZ7bt6il0yWXv6joYh6A8QOijqTNn8qszZrJ/xFBKE7f8Dk0zSs5bZlzXuKwiBcik
	QmEVLOf4M9sRVN2RvEL9R7KwwhHWOA==
X-Received: by 2002:a17:90b:4486:b0:3ac:9d83:885e with SMTP id 98e67ed59e1d1-3b166cdc35amr556807a91.52.1794251654739;
        Mon, 09 Nov 2026 11:14:14 -0800 (PST)
Received: from [127.0.0.1] ([20.80.173.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16769b589sm610162a91.5.2026.11.09.11.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:14:14 -0800 (PST)
Message-Id: <pull.2247.v2.git.1794251653636.gitgitgadget@gmail.com>
In-Reply-To: <pull.2247.git.1791127155614.gitgitgadget@gmail.com>
References: <pull.2247.git.1791127155614.gitgitgadget@gmail.com>
From: "Ilia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Nov 2026 19:14:13 +0000
Subject: [PATCH v2] fsmonitor: check the untracked cache after a trivial
 response
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Ilia <ki.stfu@gmail.com>,
    Ilia K <ki.stfu@gmail.com>

From: Ilia K <ki.stfu@gmail.com>

When the monitor sends a trivial response ("/"), for example after
the daemon restarted or lost events, refresh_fsmonitor() marks every
index entry dirty, which is saved in the index. For the untracked
cache it only clears the in-memory flag use_fsmonitor. The valid bits
of the cached directories are saved unchanged, although nothing
checks them anymore: valid_cached_dir() does not lstat() a valid
directory while the monitor is trusted.

A command that does not scan for untracked files, like "git add" or
"git checkout", therefore saves the new token next to stale valid
bits, and every later "git status" trusts them. A directory removed
in the meantime keeps its untracked files listed, or, when its own
entry is invalid, makes every run print
```
warning: could not open directory 'sub/': No such file or directory
```
Check every cached directory against its stat data before the cache
is saved next to such a token, as valid_cached_dir() does without a
monitor, and invalidate the ones that changed or disappeared. Within
the command itself, valid_cached_dir() already checks every directory,
because use_fsmonitor is cleared. Only what is saved needs the check.
Doing this at write time skips commands that do not write the index,
and sparse index writes, which drop the fsmonitor extension anyway.
The cost is one lstat() per cached directory, once per trivial
response.

Signed-off-by: Ilia K <ki.stfu@gmail.com>
---
    fsmonitor: check the untracked cache after a trivial response
    
    Changes since v1:
    
     * the whole untracked cache is dropped if !worktree
     * removed the comments as per nits
     * rebased against ToT

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2247%2Fk15tfu%2Funtracked-cache-trivial-response-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2247/k15tfu/untracked-cache-trivial-response-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2247

Range-diff vs v1:

 1:  84618b83fe ! 1:  d2cad8abe6 fsmonitor: check the untracked cache after a trivial response
     @@ Commit message
          ```
          Check every cached directory against its stat data before the cache
          is saved next to such a token, as valid_cached_dir() does without a
     -    monitor, and invalidate the ones that changed or disappeared. Doing
     -    this at write time skips commands that do not write the index, and
     -    sparse index writes, which drop the fsmonitor extension anyway.
     +    monitor, and invalidate the ones that changed or disappeared. Within
     +    the command itself, valid_cached_dir() already checks every directory,
     +    because use_fsmonitor is cleared. Only what is saved needs the check.
     +    Doing this at write time skips commands that do not write the index,
     +    and sparse index writes, which drop the fsmonitor extension anyway.
          The cost is one lstat() per cached directory, once per trivial
          response.
      
     @@ dir.c: void untracked_cache_invalidate_trimmed_path(struct index_state *istate,
      +	 * run in the top-level directory of the worktree.
      +	 */
      +	worktree = repo_get_work_tree(istate->repo);
     -+	if (!worktree)
     -+		return 0;
     ++	if (!worktree) {
     ++		invalidate_directory(istate->untracked,
     ++				     istate->untracked->root);
     ++		return 1;
     ++	}
      +
      +	strbuf_addstr(&path, worktree);
      +	nr_invalidated = invalidate_stale_dirs(istate->untracked,
     @@ t/t7519-status-fsmonitor.sh: do
       	done
       done
       
     -+# After a trivial response ("/") the monitor cannot vouch for the
     -+# untracked cache. Even a command that does not look for untracked
     -+# files must drop the stale entries, or the next "git status" trusts them.
      +test_expect_success UNTRACKED_CACHE 'untracked cache is checked after a trivial response' '
      +	test_when_finished "rm -rf trivial err" &&
      +	git init trivial &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'fsmonitor
       	test_grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
       '
       
     -+# After a restart the daemon sends a trivial response ("/"), because it
     -+# cannot know what changed while it was down. Even a command that does
     -+# not look for untracked files must then drop the stale untracked cache
     -+# entries, or the next "git status" trusts them.
      +test_expect_success UNTRACKED_CACHE 'untracked cache is checked after a trivial response' '
      +	test_when_finished "stop_daemon_delete_repo test_trivial" &&
      +


 dir.c                        | 59 ++++++++++++++++++++++++++++++++++++
 dir.h                        |  7 +++++
 read-cache.c                 | 16 ++++++++++
 t/t7519-status-fsmonitor.sh  | 52 +++++++++++++++++++++++++++++++
 t/t7527-builtin-fsmonitor.sh | 40 ++++++++++++++++++++++++
 5 files changed, 174 insertions(+)

diff --git a/dir.c b/dir.c
index ac246ced1d..4f748800b1 100644
--- a/dir.c
+++ b/dir.c
@@ -4066,6 +4066,65 @@ void untracked_cache_invalidate_trimmed_path(struct index_state *istate,
 	}
 }
 
+static int invalidate_stale_dirs(struct untracked_cache *uc,
+				 struct untracked_cache_dir *ucd,
+				 struct index_state *istate,
+				 struct strbuf *path)
+{
+	struct stat st;
+	size_t len = path->len;
+	int nr_invalidated = 0;
+	unsigned int i;
+
+	if (ucd->valid &&
+	    (lstat(path->buf, &st) ||
+	     match_stat_data_racy(istate, &ucd->stat_data, &st))) {
+		invalidate_one_directory(uc, ucd);
+		nr_invalidated++;
+	}
+
+	for (i = 0; i < ucd->dirs_nr; i++) {
+		/* not written to the index, see write_one_dir() */
+		if (!ucd->dirs[i]->recurse)
+			continue;
+		strbuf_addch(path, '/');
+		strbuf_addstr(path, ucd->dirs[i]->name);
+		nr_invalidated += invalidate_stale_dirs(uc, ucd->dirs[i],
+							istate, path);
+		strbuf_setlen(path, len);
+	}
+
+	return nr_invalidated;
+}
+
+int untracked_cache_invalidate_stale_dirs(struct index_state *istate)
+{
+	struct strbuf path = STRBUF_INIT;
+	const char *worktree;
+	int nr_invalidated;
+
+	if (!istate->untracked || !istate->untracked->root)
+		return 0;
+
+	/*
+	 * The index is also read and written by commands that do not
+	 * run in the top-level directory of the worktree.
+	 */
+	worktree = repo_get_work_tree(istate->repo);
+	if (!worktree) {
+		invalidate_directory(istate->untracked,
+				     istate->untracked->root);
+		return 1;
+	}
+
+	strbuf_addstr(&path, worktree);
+	nr_invalidated = invalidate_stale_dirs(istate->untracked,
+					       istate->untracked->root,
+					       istate, &path);
+	strbuf_release(&path);
+	return nr_invalidated;
+}
+
 void untracked_cache_remove_from_index(struct index_state *istate,
 				       const char *path)
 {
diff --git a/dir.h b/dir.h
index 83e0f648a8..7af1562b44 100644
--- a/dir.h
+++ b/dir.h
@@ -604,6 +604,13 @@ void untracked_cache_invalidate_path(struct index_state *, const char *, int saf
 void untracked_cache_invalidate_trimmed_path(struct index_state *,
 					     const char *path,
 					     int safe_path);
+/*
+ * Invalidate every cached directory that no longer exists or whose
+ * stat data no longer matches the working tree. valid_cached_dir()
+ * skips this check while the file system monitor is trusted.
+ * Returns the number of invalidated directories.
+ */
+int untracked_cache_invalidate_stale_dirs(struct index_state *);
 void untracked_cache_remove_from_index(struct index_state *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);
 
diff --git a/read-cache.c b/read-cache.c
index 1d2b97c429..5d95ba7680 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3084,6 +3084,22 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	    istate->untracked) {
 		strbuf_reset(&sb);
 
+		/*
+		 * The monitor could not say what changed (see the trivial
+		 * response in refresh_fsmonitor()), so nothing kept the
+		 * valid bits up to date. Check them before they are saved
+		 * next to the new token, which later commands trust even
+		 * when this command did not look for untracked files.
+		 */
+		if (write_extensions & WRITE_FSMONITOR_EXTENSION &&
+		    istate->fsmonitor_last_update &&
+		    !istate->untracked->use_fsmonitor) {
+			int nr = untracked_cache_invalidate_stale_dirs(istate);
+
+			trace2_data_intmax("index", istate->repo,
+					   "extension/untr/invalidated", nr);
+		}
+
 		write_untracked_extension(&sb, istate->untracked);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_UNTRACKED,
 					     sb.len) < 0;
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 93973ed25a..27c3194ae0 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -336,6 +336,58 @@ do
 	done
 done
 
+test_expect_success UNTRACKED_CACHE 'untracked cache is checked after a trivial response' '
+	test_when_finished "rm -rf trivial err" &&
+	git init trivial &&
+	(
+		cd trivial &&
+		mkdir -p dir/sub &&
+		echo tracked >dir/sub/tracked &&
+		git add dir &&
+		git commit -m initial &&
+		git config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-none" &&
+		# Version 1 only, or the hook prints a version complaint
+		# on stderr at every query.
+		git config core.fsmonitorHookVersion 1 &&
+		git config core.untrackedCache true &&
+		# With "normal", invalidating one path also invalidates
+		# its parents, and the stale parent below is never seen.
+		git config status.showUntrackedFiles all &&
+		echo untracked >dir/sub/untracked &&
+		echo "?? dir/sub/untracked" >../expect &&
+		git status --porcelain >../actual &&
+		test_cmp ../expect ../actual &&
+		git status --porcelain >../actual &&
+		test_cmp ../expect ../actual &&
+
+		# The monitor misses the removal of dir/sub. "git add other"
+		# gets the trivial response and does not touch the entries
+		# of dir and dir/sub by itself.
+		rm -r dir/sub &&
+		echo other >other &&
+		git -c core.fsmonitor="$TEST_DIRECTORY/t7519/fsmonitor-all" \
+			add other &&
+		cat >../expect <<-\EOF &&
+		 D dir/sub/tracked
+		A  other
+		EOF
+		git status --porcelain >../actual 2>../err &&
+		test_must_be_empty ../err &&
+		test_cmp ../expect ../actual &&
+
+		# Invalidate the entry of dir/sub. The stale entry of dir then
+		# makes "git status" open the removed directory and warn.
+		git update-index --remove dir/sub/tracked &&
+		cat >../expect <<-\EOF &&
+		D  dir/sub/tracked
+		A  other
+		EOF
+		git status --porcelain >../actual 2>../err &&
+		test_must_be_empty ../err &&
+		test_cmp ../expect ../actual
+	)
+'
+
 # test that splitting the index doesn't interfere
 test_expect_success 'splitting the index results in the same state' '
 	write_integration_script &&
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 86195770e9..f2770e9056 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -1389,4 +1389,44 @@ test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
 	test_grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
 '
 
+test_expect_success UNTRACKED_CACHE 'untracked cache is checked after a trivial response' '
+	test_when_finished "stop_daemon_delete_repo test_trivial" &&
+
+	git init test_trivial &&
+	mkdir -p test_trivial/dir/sub &&
+	echo tracked >test_trivial/dir/sub/tracked &&
+	git -C test_trivial add dir &&
+	git -C test_trivial commit -m initial &&
+	git -C test_trivial config core.fsmonitor true &&
+	git -C test_trivial config core.untrackedCache true &&
+	echo untracked >test_trivial/dir/sub/untracked &&
+
+	# The first status starts the daemon and builds the untracked
+	# cache, the second one trusts it.
+	echo "?? dir/sub/untracked" >expect &&
+	git -C test_trivial status --porcelain >actual &&
+	test_cmp expect actual &&
+	git -C test_trivial status --porcelain >actual &&
+	test_cmp expect actual &&
+
+	# Remove dir/sub while no daemon is running. "git add" then
+	# starts a new daemon, receives its trivial response, and does
+	# not look for untracked files.
+	git -C test_trivial fsmonitor--daemon stop &&
+	rm -r test_trivial/dir/sub &&
+	echo other >test_trivial/other &&
+	GIT_TRACE2_EVENT="$PWD/trace_trivial" \
+		git -C test_trivial add other &&
+	have_t2_data_event fsm_client query/trivial-response <trace_trivial &&
+	git -C test_trivial fsmonitor--daemon status &&
+
+	cat >expect <<-\EOF &&
+	 D dir/sub/tracked
+	A  other
+	EOF
+	git -C test_trivial status --porcelain >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: fb255012acbcbe81189cb8014da0280b09c66ecc
-- 
gitgitgadget
