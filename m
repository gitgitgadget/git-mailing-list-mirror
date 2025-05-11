Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FF28F40
	for <git@vger.kernel.org>; Sun, 11 May 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746971976; cv=none; b=KFQtcXI5td7VRhAtJvU0in2UCaSQuEhhgnVijB90cQAaRRnK5ad88Q+M96RFHDrBJGneECZMs9pqYcCOhQuyp85ojDGKZpOA50qAkR6mUeGjWvSdKzM9y5rjEJ5JrrwDfpXBt6fWFgGj/i+cDiLdl1pLQ6wt1V5hDbQrFwA3fOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746971976; c=relaxed/simple;
	bh=nfB0BgqUQSVR6wM2VAc95L4NgnkaY7D+w0Nyd7f2boE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXtFBfnxJBpPDVweU2DMz4uMDGdlIEF7vZc9hVED0fMk0miOlz6qHhror0uDJA7bOhcQ44zr5+9mNbZxBb+rblwip9QS7rrctBL/2ujhyQKbDbLR0MVAeGz+oE3cgif3dv2EdFgF8/RZFvJ+j+s4CjrRMf7kOVn5CdEpTy/YFL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayL+JQkX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayL+JQkX"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7376e311086so5071546b3a.3
        for <git@vger.kernel.org>; Sun, 11 May 2025 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746971973; x=1747576773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ks4eBb9UtZHvijZ/uZQB5lNDTtrgqNE13uU0WiHzFTk=;
        b=ayL+JQkXUSp3bvwv85vmByWcPM23sAe7vHNg15FU/A2hDt3cJT3y20LC8gHpC1whi5
         EJlb31XaBntMYBhXwcTAY0smqnSnAqvxiD9uzKvKgMNH7qzi4WBLqvnIkkc8YzgiLmpA
         PQjCnm/dUagMO+fhJ31lX4WXf+8cqDswbmOxRTsM/08INj2ruDTl5OLXSgVUw6suEonw
         0hdz1V09a56319+W75s71Y2krlOPo0SGppSUNu+4kPBXqRahmU9NYBB2OOv+kbYXx9Qi
         pElVJACwYwv78FguRlOH9YPbnm1d41PEhKMWxCN6/YPnFqL15MLG6I3MFbVmo9G3HRwg
         ULCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746971973; x=1747576773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks4eBb9UtZHvijZ/uZQB5lNDTtrgqNE13uU0WiHzFTk=;
        b=tbJ52X463vMDpkCawp57wvIpIjGKIQzfgY1O6zPjdbjdewiDQV2YTtVVCL7BPZqya5
         hABcqDB1Fl6qZj9rQy1TA5qSxyAn/7caRoFtVnmmx9hvgdJNIRS1dUsjcUINESv64JNM
         ReIzU9+aRVWo9+IKz0QnNAORtXPlq0txlf9J5cdgXEiX8llhyyyMp9A6icj9dr5uyikx
         GXOpbOm1ES3UgMwFzFVmemC4R4hTMQ8YNhKTNSuRT6OwknhAo7++Qyrft/lRHNhwYd/M
         n9nUvnSpLNAzI1fxk27BzAbOeWoQfw+oT9Byks0seTOns5IGTngFN9saoE7EEZR53m4W
         9qvQ==
X-Gm-Message-State: AOJu0YzwxQ0SvVwAdEWVQBwOez8WO6/syb+DG1TdxPeJm3YPkvaiuGeF
	d+ZLgxVxaBJHLtBEfaqQ688E4vHe8m8bbMpR24OBynjd8OM4DO7ecwqBcA==
X-Gm-Gg: ASbGnctHBbZzEJ5QTOr1Bvht0PxeL1dawWkFkNgzcnJh1M2gYdoMhicHwEDMShkyiCu
	hqyn9eWPayeP0x+ZoHixvzqHkE6uGEobjdpxpoHsNMbY+pbwy9/m0w8coBsLUVEddLk9qTIwHm/
	Q3N8L4UcMNEAab5yTKiOVxIulJ1Uf5nruVx75wL8hEQ7JxmFJVwe8e3q957+tvSKUpwG/IjDMLQ
	bOtBgCVbcyQ7EbNUK8aN9wLIMfrcGjD0CdnG35VV1AtRJEnLF6FGE+BHOGFR8oI3Dg8vCx3AOQt
	K4r7NUH41lBIOPC/q0yYobdEogKfZEL4aGeowwWQzjcOl2g=
X-Google-Smtp-Source: AGHT+IHXC1IRnqccDbS57BshTwMW0dGrIEHPbcTVFOGOaGtjK8taPQ0mXM0yqFiOfpJcbJ02SwouKQ==
X-Received: by 2002:a05:6a00:17a7:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-7423bc128f2mr16959667b3a.8.1746971972791;
        Sun, 11 May 2025 06:59:32 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2351b7a87dsm3556263a12.70.2025.05.11.06.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 06:59:31 -0700 (PDT)
Date: Sun, 11 May 2025 21:59:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/3] align the behavior when opening "packed-refs"
Message-ID: <aCCtQDnWII-knmEc@ArchLinux>
References: <aBtzn4nwLsI9p5Cp@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBtzn4nwLsI9p5Cp@ArchLinux>

Hi All:

As discussed in [1], we need to use mmap mechanism to open large
"packed_refs" file to save the memory usage. This patch mainly does the
following things:

1: Fix an issue that we would report an error when the "packed-refs"
file is empty, which does not align with the runtime behavior.
2-4: Extract some logic from the existing code and then use these
created helper functions to let fsck code to use mmap necessarily

[1] https://lore.kernel.org/git/20250503133158.GA4450@coredump.intra.peff.net

Really thank Peff and Patrick to suggest me to do above change.

---

Change in v2:

1. Update the commit message of [PATCH 1/4]. And use redirection to
create an empty file instead of using `touch`.
2. Don't use if for the refactored function in [PATCH 3/4] and then
update the commit message to align with the new function name.
3. Enhance the commit message of [PATCH 4/4].

---

Change in v3:

1. Drop the patch which creates a new function
"munmap_temporary_snapshot". As discussed, there is no need to munmap
the file during fsck.
2. Allocate snapshot variable in the stack instead of heap.
3. Fix rebase issue, remove unneeded code to check the file size
explicitly.

The range-diff seems unreadable. Briefly, for this new version, the only
change is the last patch compared to the v2.

    packed-backend: mmap large "packed-refs" file during fsck

Thanks,
Jialuo

shejialuo (3):
  packed-backend: fsck should allow an empty "packed-refs" file
  packed-backend: extract snapshot allocation in `load_contents`
  packed-backend: mmap large "packed-refs" file during fsck

 refs/packed-backend.c    | 70 ++++++++++++++++++++++------------------
 t/t0602-reffiles-fsck.sh | 13 ++++++++
 2 files changed, 52 insertions(+), 31 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  26c3fd55a8 packed-backend: fsck should allow an empty "packed-refs" file
1:  c0609afac9 ! 2:  4604be8b51 packed-backend: extract munmap operation for `MMAP_TEMPORARY`
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    packed-backend: extract munmap operation for `MMAP_TEMPORARY`
    +    packed-backend: extract snapshot allocation in `load_contents`
     
    -    "create_snapshot" would try to munmap the file when the "mmap_strategy"
    -    is "MMAP_TEMPORARY". We also need to do this operation when checking the
    -    consistency of the "packed-refs" file.
    +    "load_contents" would choose which way to load the content of the
    +    "packed-refs". However, we cannot directly use this function when
    +    checking the consistency due to we don't want to open the file. And we
    +    also need to reuse the logic to avoid causing repetition.
     
    -    Create a new function "munmap_temporary_snapshot" to do above and
    -    change "create_snapshot" to align with the behavior.
    +    Let's create a new helper function "allocate_snapshot_buffer" to extract
    +    the snapshot allocation logic in "load_contents" and update the
    +    "load_contents" to align with the behavior.
     
         Suggested-by: Jeff King <peff@peff.net>
         Suggested-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
      ## refs/packed-backend.c ##
    -@@ refs/packed-backend.c: static int allocate_snapshot_buffer(struct snapshot *snapshot, int fd, struct st
    - 	return 1;
    - }
    +@@ refs/packed-backend.c: static int refname_contains_nul(struct strbuf *refname)
    + 
    + #define SMALL_FILE_SIZE (32*1024)
      
    -+static void munmap_temporary_snapshot(struct snapshot *snapshot)
    ++static int allocate_snapshot_buffer(struct snapshot *snapshot, int fd, struct stat *st)
     +{
    -+	char *buf_copy;
    ++	ssize_t bytes_read;
     +	size_t size;
     +
    -+	if (!snapshot)
    -+		return;
    ++	size = xsize_t(st->st_size);
    ++	if (!size)
    ++		return 0;
    ++
    ++	if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
    ++		snapshot->buf = xmalloc(size);
    ++		bytes_read = read_in_full(fd, snapshot->buf, size);
    ++		if (bytes_read < 0 || bytes_read != size)
    ++			die_errno("couldn't read %s", snapshot->refs->path);
    ++		snapshot->mmapped = 0;
    ++	} else {
    ++		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
    ++		snapshot->mmapped = 1;
    ++	}
     +
    -+	/*
    -+	 * We don't want to leave the file mmapped, so we are
    -+	 * forced to make a copy now:
    -+	 */
    -+	size = snapshot->eof - snapshot->start;
    -+	buf_copy = xmalloc(size);
    ++	snapshot->start = snapshot->buf;
    ++	snapshot->eof = snapshot->buf + size;
     +
    -+	memcpy(buf_copy, snapshot->start, size);
    -+	clear_snapshot_buffer(snapshot);
    -+	snapshot->buf = snapshot->start = buf_copy;
    -+	snapshot->eof = buf_copy + size;
    ++	return 1;
     +}
     +
      /*
       * Depending on `mmap_strategy`, either mmap or read the contents of
       * the `packed-refs` file into the snapshot. Return 1 if the file
    -@@ refs/packed-backend.c: static struct snapshot *create_snapshot(struct packed_ref_store *refs)
    - 		verify_buffer_safe(snapshot);
    - 	}
    +@@ refs/packed-backend.c: static int refname_contains_nul(struct strbuf *refname)
    +  */
    + static int load_contents(struct snapshot *snapshot)
    + {
    +-	int fd;
    + 	struct stat st;
    +-	size_t size;
    +-	ssize_t bytes_read;
    ++	int ret = 1;
    ++	int fd;
      
    --	if (mmap_strategy != MMAP_OK && snapshot->mmapped) {
    --		/*
    --		 * We don't want to leave the file mmapped, so we are
    --		 * forced to make a copy now:
    --		 */
    --		size_t size = snapshot->eof - snapshot->start;
    --		char *buf_copy = xmalloc(size);
    + 	fd = open(snapshot->refs->path, O_RDONLY);
    + 	if (fd < 0) {
    +@@ refs/packed-backend.c: static int load_contents(struct snapshot *snapshot)
    + 
    + 	if (fstat(fd, &st) < 0)
    + 		die_errno("couldn't stat %s", snapshot->refs->path);
    +-	size = xsize_t(st.st_size);
     -
    --		memcpy(buf_copy, snapshot->start, size);
    --		clear_snapshot_buffer(snapshot);
    --		snapshot->buf = snapshot->start = buf_copy;
    --		snapshot->eof = buf_copy + size;
    +-	if (!size) {
    +-		close(fd);
    +-		return 0;
    +-	} else if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
    +-		snapshot->buf = xmalloc(size);
    +-		bytes_read = read_in_full(fd, snapshot->buf, size);
    +-		if (bytes_read < 0 || bytes_read != size)
    +-			die_errno("couldn't read %s", snapshot->refs->path);
    +-		snapshot->mmapped = 0;
    +-	} else {
    +-		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
    +-		snapshot->mmapped = 1;
     -	}
    -+	if (mmap_strategy == MMAP_TEMPORARY && snapshot->mmapped)
    -+		munmap_temporary_snapshot(snapshot);
    +-	close(fd);
    + 
    +-	snapshot->start = snapshot->buf;
    +-	snapshot->eof = snapshot->buf + size;
    ++	if (!allocate_snapshot_buffer(snapshot, fd, &st))
    ++		ret = 0;
      
    - 	return snapshot;
    +-	return 1;
    ++	close(fd);
    ++	return ret;
      }
    + 
    + static const char *find_reference_location_1(struct snapshot *snapshot,
2:  c868e3dd16 ! 3:  82e19a65c6 packed-backend: mmap large "packed-refs" file during fsck
    @@ Commit message
         "packed-backend.c" use this way, we should make "fsck" align with the
         current codebase.
     
    -    As we have introduced two helper functions "allocate_snapshot_buffer"
    -    and "munmap_snapshot_if_temporary", we could simply call these functions
    -    to use mmap mechanism.
    +    As we have introduced the helper function "allocate_snapshot_buffer", we
    +    could simple use this function to use mmap mechanism.
     
         Suggested-by: Jeff King <peff@peff.net>
         Suggested-by: Patrick Steinhardt <ps@pks.im>
    @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      	struct packed_ref_store *refs = packed_downcast(ref_store,
      							REF_STORE_READ, "fsck");
     -	struct strbuf packed_ref_content = STRBUF_INIT;
    -+	struct snapshot *snapshot = xcalloc(1, sizeof(*snapshot));
    ++	struct snapshot snapshot = { 0 };
      	unsigned int sorted = 0;
      	struct stat st;
      	int ret = 0;
     @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
    - 	if (!st.st_size)
    + 		goto cleanup;
    + 	}
    + 
    +-	if (!st.st_size)
    ++	if (!allocate_snapshot_buffer(&snapshot, fd, &st))
      		goto cleanup;
      
     -	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
     -		ret = error_errno(_("unable to read '%s'"), refs->path);
    -+	if (!allocate_snapshot_buffer(snapshot, fd, &st))
    - 		goto cleanup;
    +-		goto cleanup;
     -	}
    - 
    +-
     -	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
     -				      packed_ref_content.buf + packed_ref_content.len);
    -+	if (mmap_strategy == MMAP_TEMPORARY && snapshot->mmapped)
    -+		munmap_temporary_snapshot(snapshot);
    -+
    -+	ret = packed_fsck_ref_content(o, ref_store, &sorted, snapshot->start,
    -+				      snapshot->eof);
    ++	ret = packed_fsck_ref_content(o, ref_store, &sorted, snapshot.start,
    ++				      snapshot.eof);
      	if (!ret && sorted)
     -		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
     -					     packed_ref_content.buf + packed_ref_content.len);
    -+		ret = packed_fsck_ref_sorted(o, ref_store, snapshot->start,
    -+					     snapshot->eof);
    ++		ret = packed_fsck_ref_sorted(o, ref_store, snapshot.start,
    ++					     snapshot.eof);
      
      cleanup:
      	if (fd >= 0)
      		close(fd);
     -	strbuf_release(&packed_ref_content);
    -+	clear_snapshot_buffer(snapshot);
    -+	free(snapshot);
    ++	clear_snapshot_buffer(&snapshot);
      	return ret;
      }
      
-- 
2.49.0

