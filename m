Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40554202F76
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363695; cv=none; b=ChuSLwFG5SffjmfxvQGyl0BzlIFxAJ6OdHrtG6X0h9tRY3fJGpEKoCicedc+ekX+RRcNCnmEkANMwA9NgO1lqtLdWt6MvcOblUY8dw9FoUDy99tmf7Wk4fHusItkJoAckoeGgo+Tn8P80MNx3eC7Z3HQ/jdf6bqv81gbXolTY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363695; c=relaxed/simple;
	bh=cp8xYHOHc0/JJdJvKjPucl9ZjETWFmLZVvnsMlIZMco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDDqZKxfz/TmqL5pkp0/Ctbjx01THbCn8P24kl7vNr3djWHMamz3h7ID03GTLNbdxefrIDk0+1VlXzvlnEtuH1qIiz9bXBU2lKLDgpKeZkvCT/j01JMpRpng0Dlgudse6de2OKMkF7IA9GlD5d2KnTMeZEU/1GmOIuVDUfRdJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jbINAZan; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jbINAZan"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso95502276.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 11:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736363693; x=1736968493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QeqphRlzbXNfsgl4zzUbnDr49e2gHpY5J6nEWyeZhNQ=;
        b=jbINAZanubRs4koJYL3Kq1zk4V5P1X8alSEUOjpgpqPXdxE6XIigRLb84s4xQDmLv2
         Nk0ohoGUrX7zhOzU4RhzWnEC4zFjl6le/CAj3ktaSXyKEmx5Sj1o/qd9AqcQnVz1AgBm
         tFa9aapoiZEijI9mbxYnUyfXi4vue4nT5x62U71LLZRHFXaM7DQL2roH+aEZmhMdV2tI
         BzKOZ7E4TG2cst2of/vC4IH2fB8z5HWLk9g9r5BT9RtVJ5rNYOFHqb1u2DCsdZgMF04m
         sapslNr/XI7pYVr3FEKfkEIr2sCErZ1Q6+cTpNPaGYfio3D9ahyiXVklhXWrxuU3A3oZ
         ktdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736363693; x=1736968493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeqphRlzbXNfsgl4zzUbnDr49e2gHpY5J6nEWyeZhNQ=;
        b=KWe6q6J90gdzmFh+mFs2eJ/JNB0+zjj0u7SZ31UTZldhonTwJTMDJqA2HM/gIzQbFz
         /cHJvkJM6DSeFGBqQaJUbwRieYV+fVHV7qzmyG712hwg2GNISVAshoXJdL81Cje+Whfu
         D9JPFFSUff9tiRt/uhHS0p/e1QC7wgg739c2Hn/6ElQRqazpYMtAZ9TmRN+ByuL2VRo4
         jALBJ2cOtik0Bj1zwG4x3BOvRS8LoXtxPjkYF+wToTYZRmgsx9aoHlGX8e8ExGzCtoqP
         kZV+x/gkRlss7xNDvNP8/034AMnfPTB5YkQEa/2Nd4j+DMW5s+Qz8XxsbFdaq/SnifYp
         uKhw==
X-Gm-Message-State: AOJu0YxXKTBJ+sO1Z8VPW9fTEbbRnTQSAYD6tSwsDNrpmLVplry2Fles
	kZZnwriA4h+eLE0lkKqCNBUsc+5pldkkt+a4JGbL5zAGbCy+fGeYPs94Bhpbc8VEBY5MN1lczIK
	Zuzw=
X-Gm-Gg: ASbGncvsK0nalPVOJNMWIOCqjSM2NlrzdvDXoYF1lW5qzUqij14WJQUOqgAFn1Cs7yA
	RViI3PvpV7Xtk8cWxnyb5BsiBwvMJ73aRBxvGC6mpKzZ+PZ+g9fy5Ka9z2IE+xDq/kh+1wL5Hd/
	hCUzOAbxfVHjYITEVVCVJJZ5ITAgdWBD8DsZhvEUBz6h4ELvniIz3Ds+refPTqJw5TD8ERH9K+X
	Tx1IypHk/HrMnCcoX0hhL0OcCZlGfXyjGS+GI/t1Jk5S8sZV2TIDcxj3Uiu+0bElKd3nyRVrFRM
	/s4liHDyEBKFbpBU2cgZGiUTeieP
X-Google-Smtp-Source: AGHT+IEzDEaBbK29p2NvXHMXltxeRbqghW3rmaLX0FcTvFZNP0ISZ6JRN7l4GXsxnKm8rW74wZmqzw==
X-Received: by 2002:a05:690c:23c6:b0:6d4:4a0c:fcf0 with SMTP id 00721157ae682-6f531241ec8mr35553287b3.20.1736363693009;
        Wed, 08 Jan 2025 11:14:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e73e8b24sm94877357b3.4.2025.01.08.11.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:14:52 -0800 (PST)
Date: Wed, 8 Jan 2025 14:14:51 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 7/8] csum-file: introduce hashfile_checkpoint_init()
Message-ID: <94c07fd8a557c569fdc83015d5f3902094f21994.1736363652.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1736363652.git.me@ttaylorr.com>

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
2.48.0.rc2.33.gaab3d23ed4c

