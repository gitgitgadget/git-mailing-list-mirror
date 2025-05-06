Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDEA283CBE
	for <git@vger.kernel.org>; Tue,  6 May 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549663; cv=none; b=Qg/DWuxW8q14EW7v6iWKJARsk6XRaNftl6rEa0AYwcacDASBSxaChZjdERSvkf4/Sjo+o3470nMNCcEiO8kE5U0o+RV3AX65XBYOq2IKnVizlQhFh1mwe0t2tUjwHdOKof4nTHLy3dYeSmSuo9hVuhCxpFFWlBgpeR9i8ljc7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549663; c=relaxed/simple;
	bh=sOw/FenVQ5Drcleyo95kUBJvDigu0vhrOalz2vXgHcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCxqdqsVtkcXVJq04Isr183y5jlKEgyMFH9KzgrR01akLSEKR2MYuLRVAKzh4P3aETp2CuN8X9rtygrdcK8CtOewsiT0m1sHBraYc7ii6HJlqTJFlRp6Jpr8KwuZ0P8rFJNVMOuK3XpKRpDSZqEtdEmn+wa9Ba8G0Gdn2kPF2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU3WUX3L; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU3WUX3L"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22438c356c8so59342815ad.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746549661; x=1747154461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNN3KpgixsBSVoxP/qdQZE13Decy4VnngrVj+OuV5J8=;
        b=VU3WUX3LAdyleACfrvNa5cxMTfnFpSu6n5tpRabVY5b+pTJqBCQ/cO/HOVGPoGHIR0
         Ucy0ZoEvWHKrXUb6hpJKmID6rh9WWcdVLt32WLdlB4lY2u7oyWCbtJYwLxVJa/PoaIUO
         NKbjXnhcmvrrkJnkwhoeLgrbKslMljlQUpRKqdy74NvNqEABWYAUM2LvCRnAk0c3NPE3
         zaRaA1MXLAAnDJPp3mwgDw3TBh3Y3GtPqTHAMf2DbFUi77939Lm2LwVdjNaWMeDe/aKn
         jGCZAwP/21NU7bLuvuFtJ7cs7CsPq3bfESAVo9WJnOEwjRUbD5uW0zIjPQz+3Uge9/De
         j6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746549661; x=1747154461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNN3KpgixsBSVoxP/qdQZE13Decy4VnngrVj+OuV5J8=;
        b=WR1gHIOlNFA66H7zLIVGtVPnBn+udTTaPZPwX24UikivMA4jMumWIPXE/JVa7ylfL8
         8QhPG9snO0W3t+uYvSR+iPyt0PjzWSjv+GtdRjc/PZfn+3FONt22gqzoTP1FdHgA9z5B
         iGCL1SggXR5ZDmY60GHLWXtz4/BGykiOOBwoJGe9V44hfi6OlXN2ExG212Vf06WZSjo3
         X3TdVkWEQcV96gQ2jZOAm8n1sr1ddkVHJFbltTUPniMzBj+/famcfhlzCXb5HfPPJ5TU
         m5+b5/r6Kw9Q5CQ29cHCmpYco6qn798Y8oAWYqaKnCIz6tJac9Uum70LzD7Z+aV6wjsG
         5Oxw==
X-Gm-Message-State: AOJu0YzJjU2tWf6qZswPTMMyWlmfy12fdYu3wmnfBRdzUxLnWahanBCA
	22LqnAVPBFg2z0oOB4QS+DajGRo6jCnwP08c5QmKmeZt91Jevi2xaYeyTvPk
X-Gm-Gg: ASbGncv7IBO4CPvcB8g4ffbOdGe4mw71aNJmzX7q4220xx5R+BqpMjuzcuJgwRkSu5V
	bn+RNGmr62b/HfQaa4F2tIsuN/0XhbOFzg7Mr329PsDAVp6x2arCwUtRwCS8uBa+6FTX7fncWev
	JONNBQuV/DA32yvk+hF2aq+Iz7wyaqrXwW2n4wciY7/eyp7oG4OxbF29acouC4N3q7z/If8Tif9
	49YQzPjsBs/hYS0L6r2t/AYEE5gPmJuxm618qRe+SdeKUjRL861ruKkHTNE9T1Yu/tOkuBZiLDx
	QYmttMRhX2vRVmWQCm9hjP+pEygVCPINGV9l9tA6noEAajk=
X-Google-Smtp-Source: AGHT+IF143YPI0D/hWQkfcU+WtLMaY2884EvW9lnA/9Tlo4y7QJ8o+YHhwl/rD9j66jXKTAnymEiAQ==
X-Received: by 2002:a17:902:ebca:b0:223:6657:5003 with SMTP id d9443c01a7336-22e1ea615b6mr181451175ad.32.1746549660917;
        Tue, 06 May 2025 09:41:00 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e151e9744sm76609865ad.79.2025.05.06.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:41:00 -0700 (PDT)
Date: Wed, 7 May 2025 00:41:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/4] packed-backend: use mmap when opening large
 "packed-refs" file
Message-ID: <aBo7tOkheM6zOJpe@ArchLinux>
References: <aBo7OiCKHTyT4DzH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBo7OiCKHTyT4DzH@ArchLinux>

We use "strbuf_read" to read the content of "packed-refs". However, this
is a bad practice which would consume a lot of memory usage if there are
multiple processes reading large "packed-refs".

As we have introduced two helper functions "allocate_snapshot_buffer"
and "munmap_snapshot_if_temporary", we could simply call these functions
to use mmap mechanism.

Suggested-by: Jeff King <peff@peff.net>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index dd903db301..1370b982df 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2074,7 +2074,7 @@ static int packed_fsck(struct ref_store *ref_store,
 {
 	struct packed_ref_store *refs = packed_downcast(ref_store,
 							REF_STORE_READ, "fsck");
-	struct strbuf packed_ref_content = STRBUF_INIT;
+	struct snapshot *snapshot = xcalloc(1, sizeof(*snapshot));
 	unsigned int sorted = 0;
 	struct stat st;
 	int ret = 0;
@@ -2121,21 +2121,21 @@ static int packed_fsck(struct ref_store *ref_store,
 	if (!st.st_size)
 		goto cleanup;
 
-	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
-		ret = error_errno(_("unable to read '%s'"), refs->path);
+	if (!allocate_snapshot_buffer(snapshot, fd, &st))
 		goto cleanup;
-	}
+	munmap_snapshot_if_temporary(snapshot);
 
-	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
-				      packed_ref_content.buf + packed_ref_content.len);
+	ret = packed_fsck_ref_content(o, ref_store, &sorted, snapshot->start,
+				      snapshot->eof);
 	if (!ret && sorted)
-		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
-					     packed_ref_content.buf + packed_ref_content.len);
+		ret = packed_fsck_ref_sorted(o, ref_store, snapshot->start,
+					     snapshot->eof);
 
 cleanup:
 	if (fd >= 0)
 		close(fd);
-	strbuf_release(&packed_ref_content);
+	clear_snapshot_buffer(snapshot);
+	free(snapshot);
 	return ret;
 }
 
-- 
2.49.0

