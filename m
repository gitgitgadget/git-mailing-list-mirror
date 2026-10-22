Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694675;
	b=TwGKN3odF2UeXZ4ZMrTxW7A1O+urRP0OH+1j+0xoNyUyuUelv68Kc0BOOfXz3MS8keZP
	 mfM9r36AzgCnQXGlwCVDduUfpuecoJ0ImW2DfE5UEUCkU8YgSrtvq66qQKF4wqy8JgwQu
	 hVQyWDDCeGNPLUL9MmtsLofweQpMFlfcm55E6bk4VUzU93GQt1SrrC1Pi3vwU7ftg2VqH
	 2B4zhpYDi56wBDwFIrGmrxF+N8AvDc7Xtttxh+rpelcuzLfFaDc5mt9ZosLwseYhlUfHx
	 F933yv9L2AJqqH7W2Qo64KrBZQUaOh95OOMxEOt0dZo/Ot7ecqaVwUGwakv8h23RKow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uzU1T8LNw/dR4LCXbq6kiDNPhzUMWW7vqkUQkUmJdw8=;
	b=hsTs1PD4bOQolHDbpYFBRYYQMC93hf1thGRWZjvh5ZZhDvQsCPwhJ8xabhWg2lypJy2X
	 SWXG7vqnylENDR7r8Q4iUT0a78tGsuSmLrYCNj7kGIwBg1CdDDo4gUUZxULO2tS2aL0Ia
	 QluQFrsk1jf/Tgzn+cr1AwZ3yDewYpMpcAG9jRS2MvNrAme7tc46pYFF/t8hHVtUbLXrI
	 Bgdlh7VpzE7wjaK/VA9SZLed4osiGKIeBPLceXFm0JPpkPprTEW1LviKTuTfSa1ct2B3w
	 tx24oFmTPnOyZPcUBxgFoWCXFYcwHmynpDQhvar9lqgRbCk0NuYjJZ6hBq53K3X7Q+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVRIo8Xv;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B5606A324
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 18:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D7B5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVRIo8Xv
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917997ab0d9so2093356d6.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792694674; x=1793299474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uzU1T8LNw/dR4LCXbq6kiDNPhzUMWW7vqkUQkUmJdw8=;
        b=HVRIo8Xv3aua3ETGHi0NJrswYf5GQf7VcbC1w0cQxfXpscvqvPxdbK6hqba+svBxxs
         qap+eCXlqC7v3Ke/yTHOaVkV23Xdxan73SPgLRE6tucBYnz5z9rfVRzE+ZCotDsxZ3he
         J8bQSbuFQuDsKSK3qb55AzWtf35ekYRCPSXzjpKdEmdJ9OHPOgNkMjxV93+TKWy6gTs3
         UsRdg2wBUHv/g3bbxDVpo5wkzmyDP/tYxZP6KQYhee37w8e1fIKGAYG4Iz+SDT72fvro
         agognZgWXzI8+ARhHuVlCtTvAwIfhX5fDmoDLYRCx6fMXv/3E4rW37MTfODotOB4LnWA
         LcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694674; x=1793299474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uzU1T8LNw/dR4LCXbq6kiDNPhzUMWW7vqkUQkUmJdw8=;
        b=Tuoom/baxeE3DP/qUc+AJAos6gFGGNGzqVA4mmwD1+Ers2rtOWMRYi+W2BNU4z809p
         r7sDxiMJn9UdWGSSO9pZMfUyaCmRykyw0NGZyLPyumkm+oQi6t67/XQS8jreRWCNqgZU
         YKv0H0YxneieYvU30TBKctFAkyQkNxgw3dQE2g8934drJyQXxY5wNLrkkfzG5HGgP+w+
         EvVpDu9k6JO/kNAOZtmsrh/9rIxKqCr2HCl519zdL9IJo2CWocPIXC50yhotMlpPg/ci
         8BHGpqyL0jJKORDJNficP3sxRwr/5ePbFhLILbDHhbT4zNhlEOjv7CL7bX7hk2l4AlHS
         AXpw==
X-Gm-Message-State: AFq9FYIILyij9lH8oYxyGmTIt5jY4WXFYxSq5UM3GIAB5RUDE7i0o085
	eqNG3sIPBwXwL5ow7FJ6B7NwBDDswcrjzJiaUWZEaobHLtdyDAeUng5ScUm/5oCOfbU=
X-Gm-Gg: AYBFou0CkmUW1TjxrmOTT9IxO0VTFlLTL9PE355n9scWnficH+QhsnoHmw8jOAWLECk
	3ytnG75J/XdbG+hZdDK9oO3D4bsbqK8k4SRoMxqAPioETRefrT/cT22gaHuOiay411/aWSe7cNa
	PMNdQpigWJrrchFyQRAYmCNOPAV3cCVlJNitvdm6/7kK1BJm8d9lsX1kxD7Kj44j0QjeFF9o715
	6rXOojVA6ukZnOZvt7dgZ3kechDcayNRYXkjUdI0R1CT6XK4SafAZ+dS2+z5LUViMRXlqg1du0R
	LnGO9BPM4p/VMh86ufky9HuJkwXQz3i6gyV1n0VtnnFDaBE9rzNkoE4GJq/T9TUTvXfTEmCnkd9
	K9F5GaXPZUTAVKUfjloyZB1bI4Q1c7kvA2qMvDhUsGJ1c0xrMNtq/OXQS1QqTWJbmipFxmCkiG5
	bFN8IbdAXu6m3CPHHtvSmQoynDQ4yFmc9YrPpajIjG6RbM+rDK5ut3FpkN+Dx8znMOhRlun6d/j
	VboyfOxq+5cDlZHAY9cN+Na4CEtTuoyizEe3teanaolmEIpWLInbuKgI+GqpttS8Ui6H1Jtpa6H
	L2EubspHgKK39FPc/fP3TYCG+m9pptA0FO4VMVs949k0xP6Wez/xmsqtacMMKqUFIjLwztCU8OK
	nNZ95chw=
X-Received: by 2002:a05:6214:410d:b0:912:517b:84a with SMTP id 6a1803df08f44-91c12f1f98amr101105636d6.46.1792694673956;
        Thu, 22 Oct 2026 11:44:33 -0700 (PDT)
Received: from 3950x.home ([76.69.137.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c370fe729sm3956136d6.45.2026.10.22.11.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:44:33 -0700 (PDT)
From: Mihai Cosma <mcosma@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	stolee@gmail.com,
	quark.zju@gmail.com,
	Mihai Cosma <mcosma@gmail.com>
Subject: [PATCH 1/2] read-cache: verify skipHash index by stat data
Date: Thu, 22 Oct 2026 14:44:19 -0400
Message-ID: <20261022184420.3648771-2-mcosma@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022184420.3648771-1-mcosma@gmail.com>
References: <20261022184420.3648771-1-mcosma@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git status" and other commands read and refresh the index without the
lock, then write it only if repo_update_index_if_able() finds the
file's trailing checksum unchanged, so they cannot undo an update made
by another process in between.

Since ee1f0c242e (read-cache: add index.skipHash config option,
2023-01-06), the trailer can be all zeros, and feature.manyFiles and
Scalar turn that on. The check then passes for any index on disk, and
a "git add" that lands between status reading the index and taking the
lock is silently reverted.

When the recorded checksum is null, check instead that the stat data of
the index file is unchanged since it was read or written, apart from
the ctime, which renaming the lockfile into place changes. Ignore
core.checkStat and core.useNanosec here: a false match loses an
update, while a false mismatch only skips an optional write. On Windows,
which reports no inode numbers, this rests on the size and the mtime,
so two same-size rewrites within one 100ns tick could still be missed.

unpack_trees() builds a new index from the one it was given and copies
its checksum, so copy the stat data along with it.

Assisted-by: Claude Opus 5.5, Gemini 4 Argon
Signed-off-by: Mihai Cosma <mcosma@gmail.com>
---
To see the bug without building anything, this loses a "git add" with
v2.56.0 (it prints nothing) and keeps it with this patch (it prints
"b"). The fsmonitor hook stands in for another process that
updates the index while status is reading it:

  git init -q repro && cd repro &&
  git config index.skipHash true &&
  echo a >a && git add a && git commit -qm a &&
  # this hook runs while status reads the index: stage b behind its back
  printf '%s\n' '#!/bin/sh' \
    'test -f b && ! test -f .git/done && >.git/done && git add b' \
    'exit 1' >.git/hook &&
  chmod +x .git/hook &&
  git config core.fsmonitor .git/hook &&
  git config core.fsmonitorHookVersion 2 &&
  touch -d '1 hour ago' a && echo b >b &&
  git status >/dev/null &&
  git diff --cached --name-only

 read-cache-ll.h   |  1 +
 read-cache.c      | 37 ++++++++++++++++++++++++++++++++++++-
 t/t7508-status.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c    |  1 +
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/read-cache-ll.h b/read-cache-ll.h
index 066dd8bc3b..a45aff02ea 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -181,6 +181,7 @@ struct index_state {
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	struct object_id oid;
+	struct stat_data file_stat;
 	struct untracked_cache *untracked;
 	char *fsmonitor_last_update;
 	struct ewah_bitmap *fsmonitor_dirty;
diff --git a/read-cache.c b/read-cache.c
index c4cf08a3a3..58bae677b8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2309,6 +2309,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+	fill_stat_data(&istate->file_stat, &st);
 
 	/* if we created a thread, join it otherwise load the extensions on the primary thread */
 	if (extension_offset) {
@@ -2699,9 +2700,35 @@ static int ce_write_entry(struct hashfile *f, struct cache_entry *ce,
 	return 0;
 }
 
+/*
+ * Whether the index file is still the one whose stat data was recorded
+ * when the index was read or written. This stands in for the checksum
+ * of an index written without one, so unlike match_stat_data() it
+ * always compares the inode and the mtime to the nanosecond, whatever
+ * core.checkStat and core.useNanosec say: a false "unchanged" would
+ * discard an update made by another process, while a false "changed"
+ * only skips an opportunistic write. The ctime is left out because
+ * renaming the written lockfile into place changes it.
+ */
+static int index_file_unchanged(const struct stat_data *sd, struct stat *st)
+{
+	struct stat_data now;
+
+	fill_stat_data(&now, st);
+	return sd->sd_mtime.sec == now.sd_mtime.sec &&
+	       sd->sd_mtime.nsec == now.sd_mtime.nsec &&
+	       sd->sd_dev == now.sd_dev &&
+	       sd->sd_ino == now.sd_ino &&
+	       sd->sd_uid == now.sd_uid &&
+	       sd->sd_gid == now.sd_gid &&
+	       sd->sd_size == now.sd_size;
+}
+
 /*
  * This function verifies if index_state has the correct sha1 of the
- * index file.  Don't die if we have any other failure, just return 0.
+ * index file, or, when the index was written without a checksum
+ * (index.skipHash), that the file's stat data has not changed. Don't
+ * die if we have any other failure, just return 0.
  */
 static int verify_index_from(const struct index_state *istate, const char *path)
 {
@@ -2720,6 +2747,13 @@ static int verify_index_from(const struct index_state *istate, const char *path)
 	if (fstat(fd, &st))
 		goto out;
 
+	if (is_null_oid(&istate->oid)) {
+		if (!index_file_unchanged(&istate->file_stat, &st))
+			goto out;
+		close(fd);
+		return 1;
+	}
+
 	if (st.st_size < sizeof(struct cache_header) + the_hash_algo->rawsz)
 		goto out;
 
@@ -3098,6 +3132,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	}
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+	fill_stat_data(&istate->file_stat, &st);
 	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
 
 	trace2_data_intmax("index", istate->repo, "write/version",
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 0fd7c79911..c045a651f8 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1681,6 +1681,47 @@ test_expect_success '--no-optional-locks prevents index update' '
 	! test_is_magic_mtime .git/index
 '
 
+# The fsmonitor hook runs while status reads the index, before status
+# takes the lock, and stands in for a user command that updates the
+# index at that moment.
+for skip_hash in false true
+do
+	test_expect_success "status keeps an index update made after it read the index (index.skipHash=$skip_hash)" '
+		test_when_finished "rm -rf update-after-read" &&
+		git init update-after-read &&
+		(
+			cd update-after-read &&
+			if test $skip_hash = true
+			then
+				# index.skipHash does not work with a split index.
+				sane_unset GIT_TEST_SPLIT_INDEX
+			fi &&
+			git config index.skipHash $skip_hash &&
+			test_commit base &&
+			write_script .git/fsmonitor-hook <<-\EOF &&
+			# Act once; the "git add" below runs this hook again.
+			if test -f to-add && ! test -f .git/hook-ran
+			then
+				>.git/hook-ran &&
+				git add to-add
+			fi
+			# Report failure so that status checks every path itself.
+			exit 1
+			EOF
+			git config core.fsmonitorHookVersion 2 &&
+			git config core.fsmonitor .git/fsmonitor-hook &&
+			git status &&
+			test-tool chmtime -60 base.t &&
+			echo content >to-add &&
+			git status &&
+			test_path_is_file .git/hook-ran &&
+			echo to-add >expect &&
+			git diff --cached --name-only >actual &&
+			test_cmp expect actual
+		)
+	'
+done
+
 test_expect_success 'racy timestamps will be fixed for clean worktree' '
 	echo content >racy-dirty &&
 	echo content >racy-racy &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 1802809ad3..d6a859420f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1959,6 +1959,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			init_split_index(&o->internal.result);
 	}
 	oidcpy(&o->internal.result.oid, &o->src_index->oid);
+	o->internal.result.file_stat = o->src_index->file_stat;
 	o->internal.merge_size = len;
 	mark_all_ce_unused(o->src_index);
 
-- 
2.56.0

