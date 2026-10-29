Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233460;
	b=MSBuQIwRSgU5mtjDz2kJYNU5xLdUQ752Fn3Ui8uf22GnS9Wgr9DFzIGB7uTcOFFVykq/
	 UCvIo2QJAk/EauxBE/MNoyBBweBkE9hr0zvsOJXbfjc4/uuQY1KTWPAJGB+mVFhJcQssM
	 RyAmN3HuOKlh5egjiJvWl0NqGIPCXSJHbkXeYrQ3LtbFN9pDw7a360NK+T+qHHtzClmd2
	 gpLsYbwwc5XDQl6TaYNrC4Xb10+k738AHp+jwdB71QDryYx3JSLb6ZFGGs2vUUc4CVQt0
	 glwbo20Hfs4bKJPFVuqkT43PwgfWMt6MI9fEnFYc751Trm0jZir0oHfuP6qp/4OzDgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gUP8UcxzSAp5D8Ts+c1OdAVMmQQpLU/1N1A7USWGn8c=;
	b=cvVJqBYg96Ko6nZBonVb9kOQNzpuTF9BrprA3YbTUbEIuPg8kwy0qJanU+vmjaYG1bwr
	 4OxYnHbL66t/SOfezbmpCGfIAkoCY5KOcJts9G71NZzSrek0HwNRVfCfFpw0W7VcYsvmh
	 i7w0G7azvuJXo+UhWkmtChm0UhqglJbv+2olucVm8YoCIQHg1PH3XGTC2kUaz7g+GTPY+
	 pe+ZTzWapXmK9OMQaMtHLybnR3pr4Uz5zg12YNJaslWiQ25kxMANrVKga9rOJmJnyehuj
	 N7si2q7Z1nbsvceOb2NPQ5JeCviuU9Swmb7jp298aFXeNzgHM1sbJNQN0c1RsDtvehQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="uD6ZtL/h";
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809B606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 00:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C809B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uD6ZtL/h
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-833e671ee9fso1642165a34.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 17:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793233458; x=1793838258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUP8UcxzSAp5D8Ts+c1OdAVMmQQpLU/1N1A7USWGn8c=;
        b=uD6ZtL/hN43P3ruQ4exisDeGRaAuQBjWXGTwLwPRlFnv0eiP5USYSRBEOX/Y7rpjfG
         PZnNWateR9so6uDfbTB+DrO+0mcqWGXLEYyVYS7eFAj1Kl+pdUWPuKVnc7VXc7WZI/9n
         FBvICfe8tn/UZMBz4PFv1T4sbUuFnUl1fEX2Jwb2WtyTs1ojFLJOsf46Bm3jC4i4BqCb
         /i4Ngz0P27Kv9HGk3guy8xLtLorm6jY4l6Vw4kGBTwl3TJO32D3Z86jTKjP85J9Z1Oxy
         ej2DmU+pjxMWeHWjCK/19cf6UtrV1HyuBPEGzH7UW0lbftbzs/7f1sq60VDsJrV91XE2
         AJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793233458; x=1793838258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gUP8UcxzSAp5D8Ts+c1OdAVMmQQpLU/1N1A7USWGn8c=;
        b=MGMs7TrSfdjloGTBOoTVx3x870Q1NPEdRxjiGJSK5ZoRKYzyVie9UgDQ50BnS5zmIt
         TYym1Jcsn6MfP3NKcSA8G4VczeHROvDTPRJVTn5R+76x/I1wz2lY7efPx7VE6XX9i5wK
         YT7IxdLSkHFXeuPs6ntkVAkZ+9r2VAqJtunYIpetBsOSr8eogjchgJoGM+e3RquTD06S
         OG0n4W2utJZozX+k0aTsf8jWonP1px3S1XJDlvjqutZyFxWycxwWZLrhaOEuhzKeyN1H
         LvjxERPeydA91y+Ywv8yad59C1rjQ2N9mDUkSzwt/bEGzUlgsAI3+EJ4IMYe1y8aSEX7
         DeKg==
X-Gm-Message-State: AFq9FYJRYQcQgNBqJEwtpcgKZcT1loH9s45s2NHKAFVKA9DiJBstQTs3
	zH/McdDWJbmUQNNNHIX7WIs36ekLJX9G9fxRtfe3teYgnX+y2o1JK4OGjuES7w==
X-Gm-Gg: AYBFou2p4UsxNLBMMv/DsRLuvPu+HjJHf0s891be/ESLdFFE9mwiXbxzUND7nyyo9wM
	nyIJ0NKbMNEJq2GUTcaBYLwsnZ2aLQlLFPlpVnTdXv9ImYDL+zoyLTP7VD2k4WayDol3dQ8ilo7
	c77B7brfxXo4t8Z2rNnyAICzjeQ7zXOvUHG2XlkGZ8SXM4Yly5A5lLl6r8e2WMfDfvkLFFFuPrQ
	PGv/WZIbkE0zMthOz+OcsrcbTXMi3mgA1EW9YWYl75E8gjXoAR3ElpFpB25oI2ypNakh9VPiMqn
	oFG7pSefGemKW23aWybx3BxmaE3qREKAtyXbeGIFsi1LNRLMPzWf8vz0ZWPma6ro0I9+znVvz0y
	/HMb1wWL0cMl9xpt+zOuiHIa/o4b14MQqrToVSWp5+pfvuB/SW2jdBYcmhiUl+k1dXmDZRIlZ6o
	Y2+dfOdDDv8KYTaSCIzDn6KJOlne6UvedETaANwwgLJrlTO/odl03qnMBQjAC7E1WLULNSS/c6a
	TE6S1/EAWjnYz3YSwVRnUZtJrUhoh4knzYyLiIn0G055NG3Sl2YlA5rTA7OT8vOSJnXUc62equO
	/C9ojQtNa6MbwL5S/1At4IgSKpo+2QfagDeX3WBTvSd3pZWwymtea8fR69ttqilxHTuz
X-Received: by 2002:a05:6820:460d:b0:709:529a:477c with SMTP id 006d021491bc7-713f2167b3emr1989890eaf.87.1793233458518;
        Wed, 28 Oct 2026 17:24:18 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7142bb7942fsm2976439eaf.5.2026.10.28.17.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:24:17 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/4] loose: fix migrating "loose-object-idx" with batch fsync
Date: Wed, 28 Oct 2026 19:24:09 -0500
Message-ID: <20261029002413.3291184-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261022234007.3081825-1-jltobler@gmail.com>
References: <20261022234007.3081825-1-jltobler@gmail.com>
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

Greetings,

While working on a separate patch series to convert the "files" ODB
transaction to be eagerly created instead of lazily, I encountered this
bug that causes an ODB transaction to fail on commit when a
compatibility hash is also configured. This occurs because the temporary
directory migration code does not know how to handle the loose object
index file.

This patch addresses updating the migration logic to explicitly merge
mapping entries in the transaction and atomically write a new
"loose-object-idx" file.

Some other approaches I considered:
  - Storing the uncommitted object mapping entries in the transaction
    without writing a file and only writing on transaction commit. I
    chose to keep writing the temp index into the transaction so that
    child processes that write to the tempdir could still append entries.
  - Also writing mapping entires to the main ODB loose object index.
    This also didn't seem like a good apprach because it write entries
    that may not ultimately get committed.

Changes since V1:
  - The loose object index write after the merging maps is now atomic.
  - Added a fixed timeout to all loose object index writers.
  - Duplicate entries are now dropped when writing the merged mapping file.

Thanks for the review,
-Justin

Justin Tobler (4):
  loose: use finite timeout when locking "loose-object-idx" file
  loose: lift loose object index parsing logic into helper
  loose: lift loose object index writing logic into helper
  tmp-objdir: merge loose object index when migrating tmpdir

 loose.c                       | 207 ++++++++++++++++++++++++----------
 loose.h                       |   2 +
 t/t1016-compatObjectFormat.sh |  27 +++++
 tmp-objdir.c                  |  11 +-
 4 files changed, 189 insertions(+), 58 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  6f104c482e loose: use finite timeout when locking "loose-object-idx" file
-:  ---------- > 2:  4799421a74 loose: lift loose object index parsing logic into helper
-:  ---------- > 3:  4233e913ce loose: lift loose object index writing logic into helper
1:  34393e789c ! 4:  614aab27d1 tmp-objdir: merge loose object index when migrating tmpdir
    @@ Commit message
     
         When a repository is configured with a compatibility hash, each loose
         object write also records a mapping between the object and its
    -    compatibility hash in a "loose-object-idx" file. This index is located
    -    in the same object database the object is written to. If batch fsync of
    -    loose objects is also enabled, the loose objects and index file are
    -    instead written to a temporary object directory and expected to be
    -    migrated to the primary object directory when the batch transaction
    +    compatibility hash in a "loose-object-idx" file. This mapping file is
    +    located in the same object directory the object is written to. If batch
    +    fsync of loose objects is also enabled, the loose objects and mapping
    +    file are instead written to a temporary object directory and expected to
    +    be migrated to the primary object directory when the batch transaction
         commits.
     
         While migrating the loose objects works, the "loose-object-idx" file is
    -    unable to be migrated if an index already exists in the primary object
    -    directory. This occurs because `finalize_object_file_flags()` expects an
    -    already existing file to have the same contents. Otherwise, the
    -    following error is returned:
    +    unable to be migrated if a mapping file already exists in the primary
    +    object directory. This occurs because `finalize_object_file_flags()`
    +    expects an already existing file to have the same contents. Otherwise,
    +    the following error is returned:
     
           error: files '.git/objects/tmp_objdir-bulk-fsync-XXXXXX/loose-object-idx' and '.git/objects/loose-object-idx' differ in contents
           error: unable to migrate temporary objects
     
    -    Furthermore, it is not sufficient to just replace the preexisting index
    -    with the new one as the new index only contains mapping entries for the
    -    newly written objects.
    +    Furthermore, it is not sufficient to just replace the preexisting
    +    mapping file with the new one as the new file only contains mapping
    +    entries for the newly written objects.
     
         Update the temporary directory migration logic to handle
    -    "loose-object-idx" files explicitly by appending new mapping entries to
    -    the primary index.
    +    "loose-object-idx" files explicitly by merging new entries and
    +    atomically writing the resulting mapping file.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ loose.c: void loose_object_map_clear(struct loose_object_map **map)
     +			   const char *dst)
     +{
     +	struct lock_file lock = LOCK_INIT;
    -+	struct strbuf buf = STRBUF_INIT;
    -+	struct stat st;
    -+	FILE *fp;
    -+	int fd = -1;
    ++	struct loose_object_map *map;
     +	int ret;
    ++	int fd;
     +
    -+	fp = fopen(src, "r");
    -+	if (!fp) {
    -+		ret = error_errno(_("unable to open %s"), src);
    -+		goto out;
    -+	}
    -+	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header)) {
    -+		ret = error(_("invalid loose object index %s"), src);
    -+		goto out;
    -+	}
    ++	loose_object_map_init(&map);
     +
    -+	if (repo_hold_lock_file_for_update_timeout(repo, &lock, dst, 0, -1) < 0) {
    ++	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, dst, 0,
    ++						    LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
    ++	if (fd < 0) {
     +		ret = error_errno(_("unable to lock %s"), dst);
     +		goto out;
     +	}
     +
    -+	fd = open(dst, O_WRONLY | O_CREAT | O_APPEND, 0666);
    -+	if (fd < 0) {
    -+		ret = error_errno(_("unable to open %s"), dst);
    -+		goto out;
    -+	}
    -+	if (fstat(fd, &st) < 0) {
    -+		ret = error_errno(_("unable to stat %s"), dst);
    ++	if (loose_object_map_read(repo, dst, map, NULL) < 0) {
    ++		ret = error(_("unable to read loose object index %s"), dst);
     +		goto out;
     +	}
     +
    -+	/* Create the loose-object-idx if one does not already exist. */
    -+	if (!st.st_size && write_in_full(fd, loose_object_header,
    -+					 strlen(loose_object_header)) < 0) {
    -+		ret = error_errno(_("failed to write loose object index header"));
    ++	if (loose_object_map_read(repo, src, map, NULL) < 0) {
    ++		ret = error(_("unable to read loose object index %s"), src);
     +		goto out;
     +	}
     +
    -+	while (!strbuf_getwholeline(&buf, fp, '\n')) {
    -+		if (write_in_full(fd, buf.buf, buf.len) < 0) {
    -+			ret = error_errno(_("failed to write loose object index %s"),
    -+					  dst);
    -+			goto out;
    -+		}
    ++	if (loose_object_map_write(repo, map, fd) < 0) {
    ++		ret = error_errno(_("unable to write %s"),
    ++				  get_lock_file_path(&lock));
    ++		goto out;
     +	}
     +
    -+	ret = close(fd);
    -+	fd = -1;
    -+	if (ret) {
    -+		ret = error_errno(_("unable to close %s"), dst);
    ++	if (commit_lock_file(&lock) < 0) {
    ++		ret = error_errno(_("unable to write %s"), dst);
     +		goto out;
     +	}
     +
    -+	adjust_shared_perm(repo, dst);
    -+
     +	ret = 0;
     +
     +out:
    ++	loose_object_map_clear(&map);
     +	rollback_lock_file(&lock);
    -+	strbuf_release(&buf);
    -+	if (fd >= 0)
    -+		close(fd);
    -+	if (fp)
    -+		fclose(fp);
     +
     +	return ret;
     +}
    @@ t/t1016-compatObjectFormat.sh: compare_oids GPG2 'commit' signedcommit4 "$signed
     +
     +		# Write some additional objects and ensure the corresponding
     +		# temporary loose object index entries stored in the transaction
    -+		# are merged into the primary ODB.
    ++		# are merged into the primary object directory.
     +		echo bar >bar &&
     +		echo baz >baz &&
     +		git add bar baz &&

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
2.56.0.173.gf57c9a7388

