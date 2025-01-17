Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448691D86C7
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151413; cv=none; b=Fi4PxEi12zuL1KqsVXHHIrVaFUjsGejHBMPpx66ckgZw5ufjzKOLZtMOgMvbBZWXmmPrkv3YJo7PAjz7NvrtuNtiFvKheQ2r4tNlL/IjdY+SQyhbdw3H0dxM49buT5yIYUXpme0KMMJme6L124JknyDP5i6hkZAyR7YQQdZ1MVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151413; c=relaxed/simple;
	bh=4tEx831bUDWTLq/a/Jj+gaAObDrweYwFVXGjx+prZAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpq3XnXvAzk7yW2eVvUXslmH8x1tE9v3yXN2xpR4LSy8upSNmsTewEZQmoxSNZwv2BeIgIikc2EqERXpy/vtDRxHhvKAJqN/2e33kbTuuHYiocv4yZ4NzdEy1AB81aikycTFzbj97bTG1pfA3VQ9766RGqdl256A7SJo+Xx/aWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=G3uu5f97; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="G3uu5f97"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e398484b60bso4172186276.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737151411; x=1737756211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBY741sXZOT0WTbq40IXRM3lwOB19DkD28587LMhXH4=;
        b=G3uu5f97un0GTv803Gy7PVXW8Vwod8LmeMlylcwfBVurbHLhhTm1eL6hGC0EZRoVhj
         p3DxqE7Q+Dgj3NJLmiga1sHcx+POrx9rH96XN4uGzMAkB/UUWd8jw/hm8hESnhyTbiSw
         4KvzpQq1YigA2pidE6/vzX+uXDreMSTb2sbSShCYzj0hQyeEti5A97qT0zkCrbHWixne
         V49CF9eIdFv3uDTpUxhNDO8JwvwFl6IHeB64ts86gw84PuRtOK2PHLivLm+YG9So1dBM
         YPWWH5Ll5GMshrRQ7UPetVGIabpuQ7CHtBTFotgO3r+hZ+T7zpFtXtbdoJKUq94Ep8FJ
         +VEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151411; x=1737756211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBY741sXZOT0WTbq40IXRM3lwOB19DkD28587LMhXH4=;
        b=Qgv+8KshegHugYIfEdfm3MkV6jIqn0Xrj06MjMsgRfsvLzFVJfbDJQ1+dDlltIV9NR
         a+kn0/HAVLRGythAxmLVTk6VER8eymPh2hgSR1o2M1Sfeo3zSUmlzwyFdxADuTHH8t2f
         AQcNwCWEz3TpNpiSlL12hL7nDyr/2OpqynajXs3YxEbRYSW/cDskzkUKtnRhl9/8HwwG
         iDVgnLTzHC4BDbJcoI31NJRhvnpFQ3lXRPJlzberzvfzJ2zA6xGfHBhKuos7xMApsszD
         SHlSAN8LiOWtPPGO6wZDvIkLhswcCnnzb1KWF9BmPN5+L9aO71Do9boPA2jzmYEAtsnY
         WTcw==
X-Gm-Message-State: AOJu0YxO6/9oA8pYz4KXx4amoI/osQJmXBME/2oLEU0cXNOQaxQ9VukZ
	k8LMEIMLu4q3O7QiDfZKo0jzvncGuNv26z8VL5f/sDX27My5ahZi2df9a1k91fATAUudu+/gaTQ
	cjWw=
X-Gm-Gg: ASbGncu8xJMF27o7H5LrtYBxc2JROs5BdZ1s9yfXxsNy4RXGVPsrIMBHGUhE+zZKwGe
	1AOjYyn1fIH1ZFUdZT/I2TBThmtFEen8PbHtMOu3sru7z8DPPz3JoE1VYPwSP+1BGJ3XyFxFjWj
	TexXeXP5UYe2u76vLJgQ+tHez50vvINQ2g8s8JfcGZdqvg9SGdkHbMUeZgTKCLJoIC2IgciIfGM
	zsWp5wucvOhL48w5tjlh7ZZYHi1/7W977+SNIpPRq9x1sT+lc34ZWhOjlLm2AakHkH7V63eDbTp
	QBw1s1rZMXVZgvvka09C5YJSvmGA
X-Google-Smtp-Source: AGHT+IFP33FaCX8IgLV25j1L5/34Qn7HEW7TBou1Ft+JQSD5Hn4oL0LSqwqRbuFAlkQGwoEKFVH90Q==
X-Received: by 2002:a05:6902:2683:b0:e57:2ff6:945a with SMTP id 3f1490d57ef6-e57b0e17ee2mr3796411276.0.1737151410951;
        Fri, 17 Jan 2025 14:03:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e57ab479729sm584524276.54.2025.01.17.14.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:03:30 -0800 (PST)
Date: Fri, 17 Jan 2025 17:03:29 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 7/8] csum-file: introduce hashfile_checkpoint_init()
Message-ID: <850d4f407dbb3999e194bf094d0fd7b95a9c29d8.1737151386.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737151386.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737151386.git.me@ttaylorr.com>

In 106140a99f (builtin/fast-import: fix segfault with unsafe SHA1
backend, 2024-12-30) and 9218c0bfe1 (bulk-checkin: fix segfault with
unsafe SHA1 backend, 2024-12-30), we observed the effects of failing to
initialize a hashfile_checkpoint with the same hash function
implementation as is used by the hashfile it is used to checkpoint.

While both 106140a99f and 9218c0bfe1 work around the immediate crash,
changing the hash function implementation within the hashfile API to,
for example, the non-unsafe variant would re-introduce the crash. This
is a result of the tight coupling between initializing hashfiles and
hashfile_checkpoints.

Introduce and use a new function which ensures that both parts of a
hashfile and hashfile_checkpoint pair use the same hash function
implementation to avoid such crashes.

A few things worth noting:

  - In the change to builtin/fast-import.c::stream_blob(), we can see
    that by removing the explicit reference to
    'the_hash_algo->unsafe_init_fn()', we are hardened against the
    hashfile API changing away from the_hash_algo (or its unsafe
    variant) in the future.

  - The bulk-checkin code no longer needs to explicitly zero-initialize
    the hashfile_checkpoint, since it is now done as a result of calling
    'hashfile_checkpoint_init()'.

  - Also in the bulk-checkin code, we add an additional call to
    prepare_to_stream() outside of the main loop in order to initialize
    'state->f' so we know which hash function implementation to use when
    calling 'hashfile_checkpoint_init()'.

    This is OK, since subsequent 'prepare_to_stream()' calls are noops.
    However, we only need to call 'prepare_to_stream()' when we have the
    HASH_WRITE_OBJECT bit set in our flags. Without that bit, calling
    'prepare_to_stream()' does not assign 'state->f', so we have nothing
    to initialize.

  - Other uses of the 'checkpoint' in 'deflate_blob_to_pack()' are
    appropriately guarded.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/fast-import.c | 2 +-
 bulk-checkin.c        | 9 ++++++---
 csum-file.c           | 7 +++++++
 csum-file.h           | 1 +
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 0f86392761a..4a6c7ab52ac 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1106,7 +1106,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
 		cycle_packfile();
 
-	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);
+	hashfile_checkpoint_init(pack_file, &checkpoint);
 	hashfile_checkpoint(pack_file, &checkpoint);
 	offset = checkpoint.offset;
 
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 433070a3bda..892176d23d2 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -261,7 +261,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
-	struct hashfile_checkpoint checkpoint = {0};
+	struct hashfile_checkpoint checkpoint;
 	struct pack_idx_entry *idx = NULL;
 
 	seekback = lseek(fd, 0, SEEK_CUR);
@@ -272,12 +272,15 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 					  OBJ_BLOB, size);
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, obuf, header_len);
-	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);
 
 	/* Note: idx is non-NULL when we are writing */
-	if ((flags & HASH_WRITE_OBJECT) != 0)
+	if ((flags & HASH_WRITE_OBJECT) != 0) {
 		CALLOC_ARRAY(idx, 1);
 
+		prepare_to_stream(state, flags);
+		hashfile_checkpoint_init(state->f, &checkpoint);
+	}
+
 	already_hashed_to = 0;
 
 	while (1) {
diff --git a/csum-file.c b/csum-file.c
index ebffc80ef71..232121f415f 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -206,6 +206,13 @@ struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp
 	return hashfd_internal(fd, name, tp, 8 * 1024);
 }
 
+void hashfile_checkpoint_init(struct hashfile *f,
+			      struct hashfile_checkpoint *checkpoint)
+{
+	memset(checkpoint, 0, sizeof(*checkpoint));
+	f->algop->init_fn(&checkpoint->ctx);
+}
+
 void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
 {
 	hashflush(f);
diff --git a/csum-file.h b/csum-file.h
index 2b45f4673a2..b7475f16c20 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -36,6 +36,7 @@ struct hashfile_checkpoint {
 	git_hash_ctx ctx;
 };
 
+void hashfile_checkpoint_init(struct hashfile *, struct hashfile_checkpoint *);
 void hashfile_checkpoint(struct hashfile *, struct hashfile_checkpoint *);
 int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 
-- 
2.48.0.rc2.35.g0c4d006e6e8

