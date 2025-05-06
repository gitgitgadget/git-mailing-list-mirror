Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D627FD52
	for <git@vger.kernel.org>; Tue,  6 May 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549656; cv=none; b=pMlX2gNvsXMuJPAVdweJsf5aQGtQGMaeoIixm3o0LfvoOa9bOkKVBn3hjqLVTkTMffxfiZjLU0NZ29cFcZ7ni4j+IXHKVZKWWFz+7dhokOskjmV54WgSoRnlvVBj9yFaqsz2e1ONtcuqZMG5dN7H6SYgMrmF5XLvzcUr8JqS8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549656; c=relaxed/simple;
	bh=W10sCbVX44U7bjK2aceKmSCkt3aoTmERy3wNO01IzIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbNgAOmMWqWbqW8BcNC6duPa4yLlw0Ulh+FbTK78D59tWBL19wprjjSHIhy8ZVRedEOm5+tSvkTCTsAVo3cvYJApFtfLcyziZ1inc8ZO4+DCYrnD6YVINGapTYPN0k4pKMPCrH8+SSXU/KuPM+4aYO8YHuoLawzvJtflP9WLykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvFVL2A1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvFVL2A1"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74068f95d9fso3012588b3a.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746549653; x=1747154453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ei1Y4giheLV5L+irsVD9m3JcHibc5uOx5sxEf681dlE=;
        b=QvFVL2A1PWzLLNtlb8X/nJuPzTy95w9Ueta+6XPc7mDEt6/hvLnCStbt9fDC5npopz
         CgJVnCHljHMnDszUANGmclyNjKeaD6N2XvXjwXhLEk0hwO5+uKedT5TvTRwK6YJk9hB0
         lrM9ci4bniGNaaKQ/kDQbqdqLInTwaIMC3M9S5Ea7eF2n/nlr6pQ6Z9hWKkiC7Qc77UB
         HRn+JXnE0f81pLE6DADbm+jbsx+sePsqXaIB6LkpBd4DYGRLhWGDaaKWM1cx0JPmIv9c
         9dxgnK51TpHf7T/KnN99i6S/Q3V37ua28HLaK/U6sYhJdvtCoO5ZnaCv7xma24M4eR9x
         ldEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746549653; x=1747154453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei1Y4giheLV5L+irsVD9m3JcHibc5uOx5sxEf681dlE=;
        b=Yx/CumfRu92l7fUTrRcobXxsO48NOBxHZLM9TsWUQkx8rk0ul4Drn4DEgKZWfC93Jy
         QgOK3AADRsXCRd5Awg0DxrRJEEtX82N5G7DYtlqcYjbdTzk+ETMjcesBLMNGWxl5+5t4
         3FRzG1fzW2wf1gwJUJATnJnbUav3ZArHsQrgxI4xF2lDyOh8+bD/tDZ+xOPEHahojLaQ
         XT5ZrmLgkAfhu7rXqhr/CRwb1vFAIih1zIUlCX/MWKqIypmUjZEhYUKGysRaUD0IWw1C
         yHleZVbctHzKlSb/1/P8YtK2gCzmA+ZSQn5zWAvGM2E7QfT0LyCG+iqce9b45VFy1c0C
         xDhQ==
X-Gm-Message-State: AOJu0YwBx3HC6eCX4hv3xL0MAsYMdlvFQMyuKhLE9Wwlb1+LmauIH6WN
	Gt20CPikIVt/BxjPTfNhZAw00yLkN+enRv3mxATyZASGAcLpDtqUh/HvLvCs
X-Gm-Gg: ASbGncs0YfI5VX2j/GWOR2M/N0HZO26tTN3befk3nlBcq40YQwuzs8MGcZyywQHL5j+
	OO+hU/EXFcQ+SwejNB4bFFm6iAV8gQ92uZwZWMus3L+93Uj8PCPULjPGkSp6/9w/47YSIRU6V+J
	sYKjdVnCEOpMLP1mFzf8TbPcYyM+3nuRvK0iiCUIr89EvNxfg9HqKdZmh9BF50wCfA4SKIxAsNR
	Lz/V+h9L+sEaQrzVIxhLKhz0bjJ7GOf0KhsBf1eeuO99hS6OfKrLoVPUfDXeQol5ChK/ivYKfYe
	ov5ovIaffFi74j+mDtfQoeWXOhShfeX4igQit6Wv20uIs+A=
X-Google-Smtp-Source: AGHT+IGW+/xQiCsN5jTjjrh6ZjYJz4zctKnfntY9iCWMc1mtMZi0oLGCUlfxPxZBwZqmFowcErb4/Q==
X-Received: by 2002:aa7:930d:0:b0:740:6615:33c7 with SMTP id d2e1a72fcca58-7409bb27b11mr380708b3a.23.1746549653569;
        Tue, 06 May 2025 09:40:53 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74059020de2sm9412385b3a.103.2025.05.06.09.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:40:52 -0700 (PDT)
Date: Wed, 7 May 2025 00:41:17 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/4] packed-backend: extract munmap operation for
 `MMAP_TEMPORARY`
Message-ID: <aBo7rXx46_jQhTGA@ArchLinux>
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

"create_snapshot" would try to munmap the file when the "mmap_strategy"
is "MMAP_TEMPORARY". We also need to do this operation when checking the
consistency of the "packed-refs" file.

Create a new function "munmap_snapshot_if_temporary" to do above and
change "create_snapshot" to align with the behavior.

Suggested-by: Jeff King <peff@peff.net>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index e582227772..dd903db301 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -543,6 +543,23 @@ static int allocate_snapshot_buffer(struct snapshot *snapshot, int fd, struct st
 	return 1;
 }
 
+static void munmap_snapshot_if_temporary(struct snapshot *snapshot)
+{
+	if (mmap_strategy != MMAP_OK && snapshot->mmapped) {
+		/*
+		 * We don't want to leave the file mmapped, so we are
+		 * forced to make a copy now:
+		 */
+		size_t size = snapshot->eof - snapshot->start;
+		char *buf_copy = xmalloc(size);
+
+		memcpy(buf_copy, snapshot->start, size);
+		clear_snapshot_buffer(snapshot);
+		snapshot->buf = snapshot->start = buf_copy;
+		snapshot->eof = buf_copy + size;
+	}
+}
+
 /*
  * Depending on `mmap_strategy`, either mmap or read the contents of
  * the `packed-refs` file into the snapshot. Return 1 if the file
@@ -761,19 +778,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 		verify_buffer_safe(snapshot);
 	}
 
-	if (mmap_strategy != MMAP_OK && snapshot->mmapped) {
-		/*
-		 * We don't want to leave the file mmapped, so we are
-		 * forced to make a copy now:
-		 */
-		size_t size = snapshot->eof - snapshot->start;
-		char *buf_copy = xmalloc(size);
-
-		memcpy(buf_copy, snapshot->start, size);
-		clear_snapshot_buffer(snapshot);
-		snapshot->buf = snapshot->start = buf_copy;
-		snapshot->eof = buf_copy + size;
-	}
+	munmap_snapshot_if_temporary(snapshot);
 
 	return snapshot;
 }
-- 
2.49.0

