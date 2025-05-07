Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4B1DA21
	for <git@vger.kernel.org>; Wed,  7 May 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629649; cv=none; b=UPFzPt43zuWg3FqmacLrD0ikP1ibwyjXrCh8+jtf58I1RpYAuKaOGuZErODiz/MNVQcCXNGsGaF1VNmAYLvMW7MptQq4bfTvW7EmG9mUZjmQUpJIRihA7mPjB2pA03KAF1ZbyCkiboAVlzsBiHn+QaptIPR8UXAzvVFH1DJKMWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629649; c=relaxed/simple;
	bh=9fuPdm7pwSG8WamBRLbwRY0dWl6u6RiHH3IIwHbbIUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgyU0S4C+JCJ08Ks7e0j4de5Pu9RaO0WPlCzoTsIwg7quEVyjMlrnXNB05zLFQq4R9iKfU90wrzNZNuCvPfSpSLHDUFiMVIfWmvqCQXFKZ7TpOwDa+3+o5oP8nQ4g9jnJJ+VpgtqtAU1Hunms/KPXLparvdDGmqvKRe6mrqjvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba7Y32hk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba7Y32hk"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2241053582dso110531635ad.1
        for <git@vger.kernel.org>; Wed, 07 May 2025 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746629647; x=1747234447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPUJRRhS/lautNChHT4Rn8bz7vvfvHoNPyCCOPI4F2Y=;
        b=Ba7Y32hkHfTq4PDLPe31+V1CTRprKzqKm5q4QeELbGJ0ITwtbq7c/5zTENDonG5Rq7
         S+22FWeFFqc/wC0ghw6QEjvDrukZifrjhVaGNsDtAnqtOnNwsFlDXTIwZgqE4evt+iZB
         5cL7TTcns7zRTxVXYA2siP1Ui0OB5llAX4YC6URCK68tRBIxXv9tbGJMR4h8m2MILW5V
         xktrvFe+njCSzI1QtkatlPKijSm781jvzJIu58B1Xea4YKZ0GJQML/bIIYQrX+th5E/o
         cNJA1qz8yl+y1jtJUlIFJTm8IuCg+d7B4v2wKGeSrvq07c/3FR/VPDPRLnNpRPmVRk2m
         um4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746629647; x=1747234447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPUJRRhS/lautNChHT4Rn8bz7vvfvHoNPyCCOPI4F2Y=;
        b=MZ+gBHAuIk5eK23kFJHVg7o4xwuNvxPPq3K5RjV25vNIU5KRRrU2yIzz+Ko0eZYlZG
         CrIupCIOIu08Q1ntZ/DSyaqhvG661Ws8Hp/gwjrojp+bwgAuzqp2mufQF9WjBNBDJpyZ
         YpJJED/d5Lufp1wbbe76RIHqc+XHatReB2nq7aApIv5ZcnEwgFGRE4gVytDG5WdC181C
         5XKeo0yuzndjls7sYYGafR7wIAXz98PEDocJfFNkkXIUxCciKOQTP/it6uB55XSvuojQ
         UqUgZwDF0KHU1H1v99DWAOMVAqNqyBNZr5u5NM0hvKP87HzTGQMnS8NQqq+WXaWqk8sp
         gmqQ==
X-Gm-Message-State: AOJu0YzoYjS0lPSC7fyGnBcFB8LpJuF2tFR4/oDc0gcta9tCyCh9ccGa
	L5Eg3uKo4jrJQIB0KqaFe0aureFCNX3Y9Ze8KBer8T52D2b70tcqznTXF8bjTSk=
X-Gm-Gg: ASbGncv6K9vnIENL/GJclTpKRLQmROUEyExpwvKzzv/aOnpvzf0iWo3VsTOHUDr9JPx
	01uvHnsHbMOEdXbCtlHKjfGqkIqdS++7Q+K5LTkItp7/FkvmaHYQ+7j3PiOScDQqbXTqiFgJVbx
	xxcpB3U2GVma8hQorsALaYgeEzB/OF+pipM87rg+EiNsmeqDuQ8US8PxluYh2JK7R3W3tGmUGT2
	y90TPnJR5CVug3BhRVfWqAVaR4qUZ/p4mx3wwiytqU0RoX7v+JZkf06gPC/fkOhYV8OtRY6V0+H
	K9tM9lJLyCpFEBxY/kl/4E2tMJcnuZouLMIE
X-Google-Smtp-Source: AGHT+IEvu8LuBGL33QUYsYAOm4xTvuh1T6xzGKXswHdx5rpGnr9Z3fG0FddClZJJJesGOIECIz7lpw==
X-Received: by 2002:a17:902:d50f:b0:215:7421:262 with SMTP id d9443c01a7336-22e5ea7c56fmr65240205ad.12.1746629647162;
        Wed, 07 May 2025 07:54:07 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e150eae99sm95326165ad.19.2025.05.07.07.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:54:06 -0700 (PDT)
Date: Wed, 7 May 2025 22:54:03 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/4] packed-backend: mmap large "packed-refs" file during
 fsck
Message-ID: <aBt0C8gdBecq5f8U@ArchLinux>
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

During fsck, we use "strbuf_read" to read the content of "packed-refs"
without using mmap mechanism. This is a bad practice which would consume
more memory than using mmap mechanism. Besides, as all code paths in
"packed-backend.c" use this way, we should make "fsck" align with the
current codebase.

As we have introduced two helper functions "allocate_snapshot_buffer"
and "munmap_snapshot_if_temporary", we could simply call these functions
to use mmap mechanism.

Suggested-by: Jeff King <peff@peff.net>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index ae6b6845a6..ff744f1d4c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2079,7 +2079,7 @@ static int packed_fsck(struct ref_store *ref_store,
 {
 	struct packed_ref_store *refs = packed_downcast(ref_store,
 							REF_STORE_READ, "fsck");
-	struct strbuf packed_ref_content = STRBUF_INIT;
+	struct snapshot *snapshot = xcalloc(1, sizeof(*snapshot));
 	unsigned int sorted = 0;
 	struct stat st;
 	int ret = 0;
@@ -2126,21 +2126,23 @@ static int packed_fsck(struct ref_store *ref_store,
 	if (!st.st_size)
 		goto cleanup;
 
-	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
-		ret = error_errno(_("unable to read '%s'"), refs->path);
+	if (!allocate_snapshot_buffer(snapshot, fd, &st))
 		goto cleanup;
-	}
 
-	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
-				      packed_ref_content.buf + packed_ref_content.len);
+	if (mmap_strategy == MMAP_TEMPORARY && snapshot->mmapped)
+		munmap_temporary_snapshot(snapshot);
+
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

