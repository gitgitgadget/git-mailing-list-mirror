Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAA282ED
	for <git@vger.kernel.org>; Wed, 14 May 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237813; cv=none; b=kJx6c2ntN7asFwyGm7VOA9h0Tv34dd133Z3s3H4ojmN+I//uiDjXPhAgVB9poGgbZ0bMs0bI7up9St80m4bt4CIi4I1SfzdZ0ywADH1O6QIUEJYn4FdJf066/iXY6+ysA09CvVrsTtFEaaULHEdhalsL8OfYLrMJgKdZGcXHwlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237813; c=relaxed/simple;
	bh=D8GfSCcg52kqfCENKHic91aaDs+SJ/Okr2DyJAWySCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ3iv7WCkJBJkHzd6fuYRXBHrO8rUnkUGwyV7pS4wH5i96dbLo4doAOFGLEb8lZH14z685tnKkIFXfj/t9MxMSzTlSBagcBEqotv8/j+QLE6vXt9A+ZtNPuE5KILBheTOsfJYCyyqGeFxgffSUX9efAEHwYlqrppN1UG+WhimDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqqSEAkR; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqqSEAkR"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ae727e87c26so4837245a12.0
        for <git@vger.kernel.org>; Wed, 14 May 2025 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747237810; x=1747842610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5vvPPYH26ANFBBzQSSP/GborQYTw7Pk+Mo3ffpTQt0=;
        b=YqqSEAkRTTJftPCAEvQ5YMS/Os7KQtP0RSyCiBtpmz4tj7Iy6a+Ug7Rh9BTiJ9yosI
         UaEBLJjJQhWsmh/EAoCDs0Wyx6lNX9Vkg9v3jQWREcfXEhXwtAcRWm5nrdbsvmD0okQw
         SxgvOWLth9dLO8pO1mXs0OMEz+P7WVOt5D8tKT/KmiOa1+tSwlQzhpwuijVqm165pQ+Y
         Tmesdq57RPanOEU2X20NOzyvhl1SKLmUkWNyXiAGT5nhmmW6ORdapJiSSMElcqfS8tiu
         8IJtLtS7OQ47H16s5ShG9u4v6+z4H5P+2LabZvW4Iekw/C09AhIKHSbfBHp7jBwpetYU
         0fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747237810; x=1747842610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5vvPPYH26ANFBBzQSSP/GborQYTw7Pk+Mo3ffpTQt0=;
        b=SxvBTRtaSnZBLQE5qTHqU3NtrzwFOmlBd+WrCSF8o1J8iGtpgqfxSsTmK8RJwE23Rx
         8lPNy9doiXPTQ6lrpxoBdN71Dn619GDcfTURwdr0eX9s66Tc6hBaK5teTwfc5v5uPdx1
         GL3G8N4QsQItKfHB3ruUehuYFbLKP9CrmJrjfjlSU+GP7e5UVqws+viFWUKezNG9f/7f
         YdCBLI0iZNamr1dSw5WukJFj7y+dDP8lm9HjpeKHyiQiSDrojk9wcQ3OLYEpi2haK4Pk
         9PxE7pRAdgKO7YgnBf6wgZCR142u/JAt5NmCP6xfksX+biq8n79UHK44ZpHvolxrn6zP
         QjpA==
X-Gm-Message-State: AOJu0YxSxoq7ol0sfwNluJYhbcKDtzQVLznFu2SnQ6Xu/H2dFzJQDv++
	KhJpchvH5Nviq0r4qjeTJTe2T58dcOy4GdzST6b8d5L5XyyH3jCofFHsBg==
X-Gm-Gg: ASbGncuMJazFe8r6MYEXHUui3oMw5ieebE6fRSNvMLiismvUWxQ19NiICZ+PJbds+2h
	F/GlRSH1aFWOcx/+Xv2BB0H0Qkv9JbyfXgmKrnubs259WsH03ghU6YVjNWMm7I5BfcI4T2xOAW1
	PpvXSG21/a2vuraKo6VF0q3/BazUk+hmo/joq4fXVcN5BRFZqu+lRBvXkn2g4EOx5qLrIJ1yH+6
	ofWlmfP6Httk6G8qYqcar0u38CZDQsQdcs/MgyE330cVBnpQUwIbgVKdXnSkmPSdExXoki1BLLS
	xTvCwN4bR8RSvCqfh2QdVcxbZWfXpI+J5szN9dG5IyGndbU=
X-Google-Smtp-Source: AGHT+IFqXdBGFk6/Gw5YHUPej4QvoCQywonx0Fns8mB5ucu8u7/q5EgE8EVQ/7jypK31YGXMyeN9iA==
X-Received: by 2002:a17:903:1b50:b0:223:5124:a16e with SMTP id d9443c01a7336-23198105cb6mr55096705ad.5.1747237810383;
        Wed, 14 May 2025 08:50:10 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc773ed08sm100750205ad.79.2025.05.14.08.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 08:50:09 -0700 (PDT)
Date: Wed, 14 May 2025 23:50:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 3/3] packed-backend: mmap large "packed-refs" file during
 fsck
Message-ID: <aCS70gT90mBNqL4V@ArchLinux>
References: <aCS7O8tNekg_u9Wp@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCS7O8tNekg_u9Wp@ArchLinux>

During fsck, we use "strbuf_read" to read the content of "packed-refs"
without using mmap mechanism. This is a bad practice which would consume
more memory than using mmap mechanism. Besides, as all code paths in
"packed-backend.c" use this way, we should make "fsck" align with the
current codebase.

As we have introduced the helper function "allocate_snapshot_buffer", we
can simply use this function to use mmap mechanism.

Suggested-by: Jeff King <peff@peff.net>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1da44a3d6d..7fd73a0e6d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2068,7 +2068,7 @@ static int packed_fsck(struct ref_store *ref_store,
 {
 	struct packed_ref_store *refs = packed_downcast(ref_store,
 							REF_STORE_READ, "fsck");
-	struct strbuf packed_ref_content = STRBUF_INIT;
+	struct snapshot snapshot = { 0 };
 	unsigned int sorted = 0;
 	struct stat st;
 	int ret = 0;
@@ -2112,7 +2112,7 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	if (!st.st_size) {
+	if (!allocate_snapshot_buffer(&snapshot, fd, &st)) {
 		struct fsck_ref_report report = { 0 };
 		report.path = "packed-refs";
 		ret = fsck_report_ref(o, &report,
@@ -2121,21 +2121,16 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
-		ret = error_errno(_("unable to read '%s'"), refs->path);
-		goto cleanup;
-	}
-
-	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
-				      packed_ref_content.buf + packed_ref_content.len);
+	ret = packed_fsck_ref_content(o, ref_store, &sorted, snapshot.start,
+				      snapshot.eof);
 	if (!ret && sorted)
-		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
-					     packed_ref_content.buf + packed_ref_content.len);
+		ret = packed_fsck_ref_sorted(o, ref_store, snapshot.start,
+					     snapshot.eof);
 
 cleanup:
 	if (fd >= 0)
 		close(fd);
-	strbuf_release(&packed_ref_content);
+	clear_snapshot_buffer(&snapshot);
 	return ret;
 }
 
-- 
2.49.0

