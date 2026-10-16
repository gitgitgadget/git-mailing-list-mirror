Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD2936215F
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186651; cv=none; b=KbQvKeojOW/CopSkjL4q+ZpvJO8IPgceeE1T6wL1JYW+Rcu2SIfmxWAneT0la+t+kko5IlF1TB9+WJtuh9SqrgNwhO6zG3OoM8bvpqbcXyYJbjVoEVOGRE9L5NyXb+lLFdRNG8KWkk2GCpkmlmKGuGPgyhzqXfdJvRHDM5ma/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186651; c=relaxed/simple;
	bh=aymdQC8JFUPHwJg0kDz9F0EoEWQL+59U52fDzXQNeXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPPI6PRMVzxBI/vLg5gX0L4RUifcumOFz3YsQva5PSxRGZHoW9YmOXv7Y3WLw6N+Z8e27Tu7zD2hGowPwMyTOu2qLLC/Sn7ixakJRyqwsjkjbm6zlFZNQ1zxeJ68rFAweZr1YpG9RJrwabuxxtPWZhERKHcQhLup94oD1k+OkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2uHv4HQ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2uHv4HQ"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8249c775215so112293a34.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792186648; x=1792791448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lGYtw6TcuiDUc+Xf6+yF9RIS3hfZg9mx0AqszN8R7I=;
        b=O2uHv4HQ908mx626fhlS2oRZ6ZyPPuPhXWVbBNFJF/VnVgMrZ/d+2HPyPeedHg7+L9
         7YQvE+A+G8KmQCr42/eJwl+F+DKCfCGhuuIVkU/+bgkpO7dQZDjXkyuUIGu0lCvYaDp9
         yGNh4DFItFrm3AfFXjwVMuzKwXBeqtJyVAxZ+diavSxBoxxDfmKSs+p3ihu4VqQrcWe9
         Pfdm4ojKhgCU3Q+wQKzyGCtMVvQ4pe9jSxskt913Wdo+dPQj0uzkfIpjmQLaqNJQnkuu
         CzRkn+TWM5bOEtiKW8yxjjYcd2HICmDYlU+uivGT+lFxqARqYAogZV7D6A989jZqIEfY
         CpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186648; x=1792791448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8lGYtw6TcuiDUc+Xf6+yF9RIS3hfZg9mx0AqszN8R7I=;
        b=bglo8Fj36hHGCFgdR2EZnGCZQuPXvguV89reaCBzn2lHnKsZpZcfaq7Bwr7TMBQm1V
         vzkJ4eMXeoWFlkbKENEhX3X+xZtS1IeX59dwpTQ75iZ0SbDh5G5GJAdYWSmd9SPcB7f6
         4KfK68nvJ01m7ZEil0y7al2UAKOtJCK/QuytWZ8exNhsMpxfLcQsufvvlTCy9a+N+//7
         wq3H/dUYsw5umoT5HtWvjK/xJVOE2p45bT7lsmIV66lQUuI6bux+c+v5hDzn+UtV8YiC
         6anxPi+RtUnKhW71BSK+rai7ruMuntcuHXeWMtDZYiK4NgGqYB3iNrt02bnKQJOGapvX
         jpBg==
X-Gm-Message-State: AFq9FYK64aTz3Y4lrMQb905Y6DHclDXqifh2tDRkgy2gWVIeoz6St908
	pQsxKbeG04sjul07Geplo6+RwnjsZsfrfxTxpJQO+U8lJ2qZABKNIGVerZ8GaA==
X-Gm-Gg: AYBFou0rUkYN0oenmFwZVbwxqwf5I1xLVDGsL/F4jNwHAsDwhIH6XXxk+6G0SkMMprK
	uRhuwVX4pLrP8RKNkIeMqJzVelPUQNIxkaIc95F8in2MwNPolFJwOwtEQMa4fOnbxjx8RXGjXUO
	JfmAVUuOP5GrOkeEPsAHVBm3dqirzTJxtcKPSZNNDxoQsPQMBwnYu0cvIJ4m8Zv8wK16lfne98/
	ynSiRLo8GasKayiCethSUb0+tgFN5ydLDXsmOlTaOagSTafDl3htkhBV6eO8oOWDQKdBHo0hQbq
	K5aSP9vctvBcIRQcyMidihDPO28Gw3Of1BhssTNg8Q9/KdMVfCyhVKA5WaEVrp5hBHJvP7sagAz
	OBI+Vf639FEqIJwJxS087gDpdTnIBaEcTnN9Jv1/kq4y1pPQARDd4sdVNBW17OLC7zRDTg/nHNS
	Wa+rMZ1PB0gCs29N6IpPoQb9SzL9LoZEbnqzdTl/5y/XRcoJw+4yMu6HnuWPqzwBMEtDAk3hWzG
	URZ7WtBdmjLbrgo4zhfYtAwUnrGRte4a3Qv/A==
X-Received: by 2002:a05:6830:6a8f:b0:81c:292f:97a3 with SMTP id 46e09a7af769-844fdad5d88mr777962a34.5.1792186648152;
        Fri, 16 Oct 2026 14:37:28 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-844d2ffbf71sm834395a34.4.2026.10.16.14.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:37:27 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/4] object-file: fix ".keep" lockfile ownership in ODB transactions
Date: Fri, 16 Oct 2026 16:37:12 -0500
Message-ID: <20261016213716.593278-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261016022901.3838402-1-jltobler@gmail.com>
References: <20261016022901.3838402-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This series addresses a bug report[1] regarding a git-receive-pack(1)
process deleting ".keep" lockfiles of with the same name but from
another concurrent git-receive-pack(1) process receiving an identical
packfile. Deleting the ".keep" lockfile for another process leaves its
newly written packfile vulnerable to deletion by another concurrent
housekeeping process.

The root of the problem here is that the temporary ".keep" lockfiles are
generated and registered in the object quarantine prior to being written
in the primary ODB. This means that even if the ODB transaction never
commits and exits early, the tempfile atexit(3) handler still runs and
tries to delete the lockfile at its expected final location. This
blindly deletes any file matching regardless of whether is was created
by the process.

The first three patches are some preparatory changes so that
`odb_transaction_files_write_pack()` is able to start explicitly
creating the lockfiles without relying on git-index-pack(1). Patch four
migrates lockfile generation to happen during ODB transaction commit to
ensure the lockfile is actually able to be written before registering it
as a tempfile.

Changes since V1:
  - Split out comment change into separate commit as suggested.
  - Improved error handling and logic flow in a couple of functions.
  - Renamed `write_pack_lock()` to `write_pack_lockfile()`.
  - Added better error messages and errno reporting to
    `write_pack_lockfile()` helper.
  - Adapted tests case to assert that packfile is not migrated.
  - Clarified some commit messages and fixed some typos.

Thanks,
-Justin

[1]: <932e8e425aecfbd33c1e5caf66c80a0226abacba.1789385483.git.gitgitgadget@gmail.com>

Justin Tobler (4):
  pack-write: make index-pack output comment hash agnostic
  pack-write: lift and expose index-pack report parsing
  object-file: explicitly write ".keep" lockfile
  object-file: write ".keep" lockfiles during transaction commit

 object-file.c              | 127 +++++++++++++++++++++++++++++--------
 pack-write.c               |  64 ++++++++++++++-----
 pack.h                     |  10 +++
 t/t5547-push-quarantine.sh |  30 ++++++++-
 4 files changed, 184 insertions(+), 47 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  b9197cbf3b pack-write: make index-pack output comment hash agnostic
1:  62521f3220 ! 2:  e27679ac16 pack-write: lift and expose index-pack report parsing
    @@ Commit message
         parse this report via `index_pack_lockfile()`, which provides the path
         to the temporary ".keep" file.
     
    -    In a subsequent commit, the "files" ODB transaction begins staging
    -    packfiles in a transaction without eagerly creating a ".keep" file and
    -    must instead read git-index-pack(1) "pack" output to get the packfile
    -    name. Extract the generic parsing logic for the git-index-pack(1) output
    -    into `read_index_pack_report()` in preparation accordingly.
    +    In a subsequent commit, the "files" ODB transaction begins creating the
    +    pack lockfiles during transaction commit instead of eagerly staging them
    +    in the transaction quarantine directory with the packfile. Extract the
    +    generic parsing logic for the git-index-pack(1) output into
    +    `read_index_pack_report()` in preparation for recording the names of
    +    newly written packfiles.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ pack-write.c: void fixup_pack_header_footer(const struct git_hash_algo *hash_alg
     +	const int len = repo->hash_algo->hexsz + 6;
      	char packname[GIT_MAX_HEXSZ + 6];
     -	const int len = source->odb->repo->hash_algo->hexsz + 6;
    ++	int is_keep_ignored;
     +	const char *name;
    -+	int keep;
    ++
    ++	if (!is_keep)
    ++		is_keep = &is_keep_ignored;
      
      	/*
    --	 * The first thing we expect from index-pack's output
    --	 * is "pack\t%40s\n" or "keep\t%40s\n" (46 bytes) where
    --	 * %40s is the newly created pack SHA1 name.  In the "keep"
    --	 * case, we need it to remove the corresponding .keep file
    --	 * later on.  If we don't get that then tough luck with it.
    -+	 * The first thing we expect from index-pack's output is
    -+	 * "pack\t<name>\n" or "keep\t<name>\n", where <name> is the hexadecimal
    -+	 * name of the packfile it has just written. The line is therefore five
    -+	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
    -+	 * "keep" prefix tells us that index-pack has also created the
    -+	 * corresponding ".keep" file.
    + 	 * The first thing we expect from index-pack's output is
    +@@ pack-write.c: char *index_pack_lockfile(struct odb_source *source, int ip_out,
    + 	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
    + 	 * "keep" prefix tells us that index-pack has also created the
    + 	 * corresponding ".keep" file.
    +-	 *
    +-	 * In the "keep" case, we need it to remove the corresponding ".keep"
    +-	 * file later on. If we don't get that then tough luck with it.
      	 */
     -	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
     -		const char *name;
    -+	if (read_in_full(ip_out, packname, len) != len || packname[len-1] != '\n')
    ++	if (read_in_full(ip_out, packname, len) != len || packname[len - 1] != '\n')
     +		return -1;
     +
    -+	packname[len-1] = 0;
    ++	packname[len - 1] = 0;
     +	if (skip_prefix(packname, "pack\t", &name))
    -+		keep = 0;
    ++		*is_keep = 0;
     +	else if (skip_prefix(packname, "keep\t", &name))
    -+		keep = 1;
    ++		*is_keep = 1;
     +	else
     +		return -1;
     +
     +	strbuf_addstr(pack_name, name);
    -+	if (is_keep)
    -+		*is_keep = keep;
     +
     +	return 0;
     +}
    -+
    + 
     +char *index_pack_lockfile(struct odb_source *source, int ip_out,
     +			  int *is_well_formed)
     +{
     +	struct strbuf pack_name = STRBUF_INIT;
     +	char *lockfile = NULL;
     +	int is_keep = 0;
    - 
    ++
     +	if (read_index_pack_report(source->odb->repo, ip_out, &pack_name, &is_keep)) {
      		if (is_well_formed)
     -			*is_well_formed = 1;
    @@ pack-write.c: void fixup_pack_header_footer(const struct git_hash_algo *hash_alg
     -	return NULL;
     +		*is_well_formed = 1;
     +
    -+	/*
    -+	 * If there is no ".keep" file, then there is no lockfile to return.
    -+	 */
    -+	if (!is_keep) {
    -+		strbuf_release(&pack_name);
    -+		return NULL;
    -+	}
    -+
    -+	lockfile = xstrfmt("%s/pack/pack-%s.keep", source->path, pack_name.buf);
    ++	/* If there is no ".keep" file, then there is no lockfile to return. */
    ++	if (is_keep)
    ++		lockfile = xstrfmt("%s/pack/pack-%s.keep", source->path, pack_name.buf);
     +
     +	strbuf_release(&pack_name);
     +	return lockfile;
    @@ pack.h: off_t write_pack_header(struct hashfile *f, uint32_t);
     +/*
     + * Read the report that git-index-pack(1) writes to its standard output after
     + * the packfile is written. The hexadecimal name of the packfile is appended to
    -+ * `pack_name` and, if `is_keep` is non-NULL, set it to indicate whether a
    ++ * `pack_name` and, if `is_keep` is non-NULL, it is set to indicate whether a
     + * ".keep" file was written. Return 0 on success and a negative error code on
     + * failure.
     + */
2:  beebbc65d8 ! 3:  9236493740 object-file: explicitly write ".keep" lockfile
    @@ object-file.c: int read_loose_object(struct repository *repo,
      	return ret;
      }
      
    -+static int write_pack_lock(struct odb_source *source, const char *pack_name,
    -+			   const char *keep_msg)
    ++static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
    ++			       const char *keep_msg)
     +{
     +	struct strbuf lock_path = STRBUF_INIT;
     +	struct strbuf contents = STRBUF_INIT;
    @@ object-file.c: int read_loose_object(struct repository *repo,
     +
     +	fd = safe_create_file_with_leading_directories(source->odb->repo,
     +						       lock_path.buf);
    -+	if (fd < 0)
    ++	if (fd < 0) {
    ++		error_errno(_("unable to create '%s'"), lock_path.buf);
     +		goto out;
    ++	}
     +
     +	if (write_in_full(fd, contents.buf, contents.len) < 0) {
    ++		error_errno(_("unable to write '%s'"), lock_path.buf);
     +		close(fd);
     +		unlink(lock_path.buf);
     +		goto out;
     +	}
     +
    -+	if (close(fd)) {
    ++	if (close(fd) < 0) {
    ++		error_errno(_("unable to close '%s'"), lock_path.buf);
     +		unlink(lock_path.buf);
     +		goto out;
     +	}
    @@ object-file.c: int read_loose_object(struct repository *repo,
      {
      	struct odb_transaction_files *transaction =
     @@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transaction *base,
    - 			return -1;
    + 		container_of(base, struct odb_transaction_files, base);
    + 	struct repository *repo = base->source->odb->repo;
    + 	struct child_process child = CHILD_PROCESS_INIT;
    ++	struct strbuf final_path = STRBUF_INIT;
    ++	struct strbuf pack_name = STRBUF_INIT;
    ++	struct strbuf keep_msg = STRBUF_INIT;
    + 	struct pack_header hdr;
    + 	const char *hdr_err;
    + 	int err_fd = opts->err_fd;
    ++	int ret = -1;
    + 	int status;
    + 
    + 	hdr_err = parse_pack_header(&hdr, pack_fd);
    +@@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transaction *base,
      		}
      	} else {
    -+		struct strbuf final_path = STRBUF_INIT;
    -+		struct strbuf pack_name = STRBUF_INIT;
    -+		struct strbuf keep_msg = STRBUF_INIT;
      		char hostname[HOST_NAME_MAX + 1];
     -		char *lockfile;
    -+		int ret;
      
      		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
      		push_header_arg(&child.args, &hdr);
    @@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transactio
      
      		status = finish_command(&child);
      		if (status) {
    -+			strbuf_release(&pack_name);
      			strbuf_addstr(err_msg, "index-pack abnormal exit");
    - 			return -1;
    - 		}
    - 
    -+		if (ret) {
    -+			strbuf_release(&pack_name);
    -+			strbuf_addstr(err_msg, "index-pack failed to report pack name");
    -+			return -1;
    +-			return -1;
    ++			goto out;
     +		}
     +
    ++		if (ret) {
    ++			strbuf_addstr(err_msg, "index-pack failed to report pack name");
    ++			goto out;
    + 		}
    + 
     +		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
     +			    (uintmax_t)getpid(), hostname);
     +
    -+		if (write_pack_lock(transaction->quarantine, pack_name.buf, keep_msg.buf)) {
    -+			strbuf_release(&pack_name);
    -+			strbuf_release(&keep_msg);
    ++		if (write_pack_lockfile(transaction->quarantine, pack_name.buf,
    ++					keep_msg.buf)) {
     +			strbuf_addstr(err_msg, "lockfile write failed");
    -+			return -1;
    ++			goto out;
     +		}
     +
     +		ALLOC_GROW(transaction->pack_lockfiles,
    @@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transactio
      		odb_source_prepare(transaction->quarantine,
      				   ODB_PREPARE_FLUSH_CACHES);
     +
    -+		strbuf_release(&final_path);
    -+		strbuf_release(&pack_name);
    -+		strbuf_release(&keep_msg);
      	}
      
    - 	return 0;
    +-	return 0;
    ++	ret = 0;
    ++
    ++out:
    ++	strbuf_release(&final_path);
    ++	strbuf_release(&pack_name);
    ++	strbuf_release(&keep_msg);
    ++
    ++	return ret;
    + }
    + 
    + static int odb_transaction_files_finalize(struct odb_transaction *base)
3:  735b922865 ! 4:  c1a175e2b9 object-file: write ".keep" lockfiles during transaction commit
    @@ Commit message
         primary ODB alongside its packfile. Writing the temporary lockfile in
         this manner has a couple of downsides:
     
    -      - Failing to migrate the lockfile during transaction commit due to a
    -        concurrent process already acquiring the same lock still allows the
    -        rest of the transaction to be migrated into the primary ODB. This
    -        dirties the primary ODB with new objects even though no references
    -        were updated and the operation failed.
    +      - Migrating quarantined objects via `tmp_objdir_migrate()` doesn't
    +        immediately stop if a ".keep" lockfile already exists for the same
    +        packfile in the primary ODB and instead allows all the remaining
    +        objects to be migrated. So even though `odb_transaction_commit()`
    +        ultimately returns an error here, the objects are needlessly written
    +        to the primary ODB anyways.
     
           - Even more concerning, the ".keep" tempfile atexit(3) handler tries
             to remove any lockfile of the same name regardless of whether it was
    @@ object-file.c: struct odb_transaction_files {
     @@ object-file.c: int read_loose_object(struct repository *repo,
      }
      
    - static int write_pack_lock(struct odb_source *source, const char *pack_name,
    --			   const char *keep_msg)
    -+			   const char *keep_msg, struct tempfile **out)
    + static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
    +-			       const char *keep_msg)
    ++			       const char *keep_msg, struct tempfile **out)
      {
      	struct strbuf lock_path = STRBUF_INIT;
      	struct strbuf contents = STRBUF_INIT;
    -@@ object-file.c: static int write_pack_lock(struct odb_source *source, const char *pack_name,
    +@@ object-file.c: static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
      		goto out;
      	}
      
    @@ object-file.c: static int write_pack_lock(struct odb_source *source, const char
      	ret = 0;
      
      out:
    -@@ object-file.c: static int write_pack_lock(struct odb_source *source, const char *pack_name,
    +@@ object-file.c: static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
      	return ret;
      }
      
    -+static int write_pack_locks(struct odb_transaction_files *transaction)
    ++static int write_pack_lockfiles(struct odb_transaction_files *transaction)
     +{
     +	struct strbuf keep_msg = STRBUF_INIT;
     +	char hostname[HOST_NAME_MAX + 1];
    @@ object-file.c: static int write_pack_lock(struct odb_source *source, const char
     +	for (size_t i = 0; i < transaction->pack_names.nr; i++) {
     +		struct tempfile *lock;
     +
    -+		ret = write_pack_lock(transaction->base.source,
    -+				      transaction->pack_names.v[i],
    -+				      keep_msg.buf, &lock);
    ++		ret = write_pack_lockfile(transaction->base.source,
    ++					  transaction->pack_names.v[i],
    ++					  keep_msg.buf, &lock);
     +		if (ret < 0)
     +			break;
     +
    @@ object-file.c: static int odb_transaction_files_commit(struct odb_transaction *b
      		delete_tempfile(&temp);
      		strbuf_release(&temp_path);
      
    -+		if (write_pack_locks(transaction))
    ++		if (write_pack_lockfiles(transaction))
     +			return error(_("unable to lock packfiles"));
     +
      		/*
      		 * Make the object files visible in the primary ODB after their data is
      		 * fully durable.
    +@@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transaction *base,
    + 		container_of(base, struct odb_transaction_files, base);
    + 	struct repository *repo = base->source->odb->repo;
    + 	struct child_process child = CHILD_PROCESS_INIT;
    +-	struct strbuf final_path = STRBUF_INIT;
    + 	struct strbuf pack_name = STRBUF_INIT;
    +-	struct strbuf keep_msg = STRBUF_INIT;
    + 	struct pack_header hdr;
    + 	const char *hdr_err;
    + 	int err_fd = opts->err_fd;
     @@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transaction *base,
      			return -1;
      		}
      	} else {
    --		struct strbuf final_path = STRBUF_INIT;
    - 		struct strbuf pack_name = STRBUF_INIT;
    --		struct strbuf keep_msg = STRBUF_INIT;
     -		char hostname[HOST_NAME_MAX + 1];
    - 		int ret;
    - 
    +-
      		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
      		push_header_arg(&child.args, &hdr);
      
    @@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transactio
      			strvec_push(&child.args, "--show-resolving-progress");
      		if (err_fd)
     @@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transaction *base,
    - 			return -1;
    + 			goto out;
      		}
      
     -		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
     -			    (uintmax_t)getpid(), hostname);
     -
    --		if (write_pack_lock(transaction->quarantine, pack_name.buf, keep_msg.buf)) {
    --			strbuf_release(&pack_name);
    --			strbuf_release(&keep_msg);
    +-		if (write_pack_lockfile(transaction->quarantine, pack_name.buf,
    +-					keep_msg.buf)) {
     -			strbuf_addstr(err_msg, "lockfile write failed");
    --			return -1;
    +-			goto out;
     -		}
     -
     -		ALLOC_GROW(transaction->pack_lockfiles,
    @@ object-file.c: static int odb_transaction_files_write_pack(struct odb_transactio
      
      		odb_source_prepare(transaction->quarantine,
      				   ODB_PREPARE_FLUSH_CACHES);
    - 
    --		strbuf_release(&final_path);
    - 		strbuf_release(&pack_name);
    --		strbuf_release(&keep_msg);
    +-
      	}
      
    - 	return 0;
    + 	ret = 0;
    + 
    + out:
    +-	strbuf_release(&final_path);
    + 	strbuf_release(&pack_name);
    +-	strbuf_release(&keep_msg);
    + 
    + 	return ret;
    + }
     @@ object-file.c: static int odb_transaction_files_finalize(struct odb_transaction *base)
      		ret |= delete_tempfile(&transaction->pack_lockfiles[i]);
      
    @@ t/t5547-push-quarantine.sh: test_expect_success '.keep file is removed after pus
     +	git -C keep.git config set receive.unpackLimit 0 &&
     +
     +	# Create a ".keep" lockfile matching the packfile to simulate a
    -+	# concurrent git-receive-pack(1) that was already written its lockfile.
    ++	# concurrent git-receive-pack(1) that has already written its lockfile.
     +	test_hook -C keep.git pre-receive <<-\EOF &&
     +	pack="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.pack)" &&
     +	pack="${pack##*/}" &&
    @@ t/t5547-push-quarantine.sh: test_expect_success '.keep file is removed after pus
     +	# left in its place.
     +	keep="$(ls keep.git/objects/pack/pack-*.keep)" &&
     +	test_path_is_file "$keep" &&
    -+	test_grep "baz" "$keep"
    ++	test_grep "baz" "$keep" &&
    ++	test_path_is_missing "${keep%.keep}.pack"
     +'
     +
      test_done

base-commit: f57c9a73884400380bddd172acc88b569834f909
-- 
2.56.0.173.gf57c9a7388

