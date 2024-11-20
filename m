Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799019CC31
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103218; cv=none; b=krvs+0IyMCxDT5u8xVqqPNZBRM5569kId5AXyeRJm1gzHjOnL2XI9NleJ7rc7AS2pqQpxvDWsv3jdSFx80rMMFYIRwIZdEkOksVufKyv8NPr44TQRPxltxNDHiUSyet3xUSpy0dGMS8OLNmTXZp0fI4cFrcxi55bJDwxn0fWzQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103218; c=relaxed/simple;
	bh=XFeOtdlEcunWcB9QYo/bnkf01CLiMd3eBC4b+PGa0C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKdPOgaqr3W7mQChNk2h7tRvZLIui466R1jpZIaRuaAMxyYP6RBjhQbHuwVh16om2MNJC3l+oyEIpnIfOquAqJTAx3eOe1NkJDJYtctp+3dy27dLhsNJufQX/csqz9yVsAH8cpBKKSGqFeqh817HyRxgui431sJiQ1ucGh9viok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXoN9qVK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXoN9qVK"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21260209c68so5533295ad.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 03:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103216; x=1732708016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qwRR4ldGfze9jgmQsD/wExpL3DOZbmm1JUf0LXuAFuM=;
        b=RXoN9qVK+w/QNk7jux4qtvpanhHEMnM+uVbNqGVtXt4rB2djtTN54Fny8Q7Urdq/kg
         kQSgyRDqEcBnKso+zR6qcOvEea+JMozEBSYB9WjN6nxHDTkVAZpg7H356bwIzzuEx+Uv
         40rNQCky5xJFknmPTBpz17zjmqWhZvbdmvSTWw4TRUiw0n7vkpoS4vqQH+VjkjC9ugvu
         lHZNZ7adGGWl69feL2Sf3N/83CE3uGWEOIBCS452FmG6DS9QMTq0ilSv+tWKRQaPmTrX
         r+yqpJsaqgNVsZCBL9UXaMky5/rLyQgcA+vh7oGINi9gFep+0IguxHjuR7VU193kokQk
         UauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103216; x=1732708016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwRR4ldGfze9jgmQsD/wExpL3DOZbmm1JUf0LXuAFuM=;
        b=Qik9tjubHljE6Z01ZrHh2X4dvFhrxiP+FWoXp/n4wqlVnJy5QAaXSgz4/NoBqJv14H
         1gyYYPkGc/sKQbgTA67vS0klqQTkI1FFBWM/NmXdgSAjs7UayRLO91ck2GZF5+e/nUW5
         dmQ8Nt5eiLIg9G1dFO3Zxn3E/J0HumcJv8Vcbi19H8wQN6SNYNRbbxmiG58MOdalVq99
         0now3j5cXUXrMcrD62h11T8X9bwFts6b8vTwcnXEP+R3YoGWDtdBdYPnsMOJ9xpcp4KF
         /N3TnnjVdueKqQhL2r+gES+N2Z4OVaFXbW8SYiApUCgx5BhRCGaYz/cXQ+e0OUn2UzFx
         mv4g==
X-Gm-Message-State: AOJu0Yws3C2TGLWPZnDXkPlZsOvkkTCnDmb5+VgXFKiPA0Kx2wjBT5by
	vg0NVovmJFFTt8ysIki+1RTzhg1iSN2k7GovWb5a9RKz6KvAx0hUjJdjjw==
X-Google-Smtp-Source: AGHT+IH9nkqKoTKEdob0xx8li442zy8dZGR0TfzV5rAk5qB0/Cytl3YSm3WNrhfz07GruHB2xnXF2Q==
X-Received: by 2002:a17:902:d504:b0:211:fd79:568 with SMTP id d9443c01a7336-2124d085619mr108806945ad.19.1732103215985;
        Wed, 20 Nov 2024 03:46:55 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fba94b1709sm1041847a12.45.2024.11.20.03.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:46:55 -0800 (PST)
Date: Wed, 20 Nov 2024 19:47:04 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v9 0/9] add ref content check for files backend
Message-ID: <Zz3MON9_9DGD6nsy@ArchLinux>
References: <ZzYqoai8X_Wdtbmt@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYqoai8X_Wdtbmt@ArchLinux>

Hi All:

This version fixes two problems:

1. Remove unnecessary space.
2. Drop extra "strerror(errno)".

Thanks,
Jialuo

shejialuo (9):
  ref: initialize "fsck_ref_report" with zero
  ref: check the full refname instead of basename
  ref: initialize ref name outside of check functions
  ref: support multiple worktrees check for refs
  ref: port git-fsck(1) regular refs check for files backend
  ref: add more strict checks for regular refs
  ref: add basic symref content check for files backend
  ref: check whether the target of the symref is a ref
  ref: add symlink ref content check for files backend

 Documentation/fsck-msgids.txt |  35 +++
 builtin/refs.c                |  10 +-
 fsck.h                        |   6 +
 refs.c                        |   7 +-
 refs.h                        |   3 +-
 refs/debug.c                  |   5 +-
 refs/files-backend.c          | 194 +++++++++++-
 refs/packed-backend.c         |   8 +-
 refs/refs-internal.h          |   5 +-
 refs/reftable-backend.c       |   3 +-
 t/t0602-reffiles-fsck.sh      | 576 ++++++++++++++++++++++++++++++++--
 11 files changed, 790 insertions(+), 62 deletions(-)

Range-diff against v8:
 1:  bfb2a21af4 =  1:  bfb2a21af4 ref: initialize "fsck_ref_report" with zero
 2:  9efc83f7ea =  2:  9efc83f7ea ref: check the full refname instead of basename
 3:  5ea7d18203 =  3:  5ea7d18203 ref: initialize ref name outside of check functions
 4:  cb4669b64d =  4:  cb4669b64d ref: support multiple worktrees check for refs
 5:  c6c128c922 !  5:  d6188063d9 ref: port git-fsck(1) regular refs check for files backend
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +	if (S_ISLNK(iter->st.st_mode))
     +		goto cleanup;
     +
    -+	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0 ) {
    ++	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
     +		/*
     +		 * Ref file could be removed by another concurrent process. We should
     +		 * ignore this error and continue to the next ref.
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +		if (errno == ENOENT)
     +			goto cleanup;
     +
    -+		ret = error_errno(_("cannot read ref file '%s': %s"),
    -+				  iter->path.buf, strerror(errno));
    ++		ret = error_errno(_("cannot read ref file '%s'"), iter->path.buf);
     +		goto cleanup;
     +	}
     +
 6:  911fa42717 =  6:  e5e97ba3ad ref: add more strict checks for regular refs
 7:  7aa6a99206 =  7:  1dec0a56d2 ref: add basic symref content check for files backend
 8:  dbb0787ad1 =  8:  dcc4a02102 ref: check whether the target of the symref is a ref
 9:  a6d85b4864 !  9:  fc10862f6f ref: add symlink ref content check for files backend
    @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_s
      		goto cleanup;
     +	}
      
    - 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0 ) {
    + 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
      		/*
     @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_store,
      			goto cleanup;
-- 
2.47.0

