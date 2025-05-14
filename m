Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD95190497
	for <git@vger.kernel.org>; Wed, 14 May 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237805; cv=none; b=Mp/zS36KBzah1UHeISrUulvgoMxk18R63EYjfJw0emUZ8LgbjUDKbgLucWqjTzbMXKzxGpZ7EmI/4mJrTDUsFnNvUju4NyeaqShpqYvNRdUaUgkMVhFK850/oKiLKMa3Kw4WXjJ8LhaWQjRcss7ekoWPLEUJUWDUwW4PpvN325A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237805; c=relaxed/simple;
	bh=Qs4RG0JAvoHYRxZKSmUYuS5GdAyDXJH46CZcOPRihrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMqCOM4KzbZlQzeYQyhgr5l6oumU4ihR7FLQthCzU4COeB+WhY1jretXGjCs0yiu+rPhoBoPLfyKpiuYPEeJZOj2d4gaqocRCUcCthaAFwGBygorx26yWXD3BATNsvPmYvkKaUOqjxsZc0tT122C3mqQcXtVm1BtY0UDdqwgr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoTm5pg3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoTm5pg3"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b239763eeddso4955211a12.1
        for <git@vger.kernel.org>; Wed, 14 May 2025 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747237803; x=1747842603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67Py9NGTdtSEogEXnGUyxxYq5nkZNYRhcppywD1suJI=;
        b=KoTm5pg3JTjDg8rJj9bPOScNTgttbBzgtdnz9fUBXMz70bu+LGJ2riTC9w9RJuR97P
         wzXKl0/O40g5x6OQhPAThbSyoC36TYAHSZW3/Mi/SEUOagTPt3P5Oyb2hQzZbQFLtE2f
         z5aerBDplMTOuNsenCP1sDAn1NxdH9PZ7hLgouse0V6Xs8xV38S3M4IRLEkq5eEXqb6F
         cfJS2OrMm4fQ3BqwxlTfo9XB7hWjdHMiqOaSIgAuJrW+t8U+sCP+67jlF5AaGaSzFyUu
         qndNhsHz5qEVMYxFb8H3bRV657GD9BXISsrGpDPKrE4jxhXDmRbUq7FYeiLNOmFfJjNc
         Orng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747237803; x=1747842603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67Py9NGTdtSEogEXnGUyxxYq5nkZNYRhcppywD1suJI=;
        b=fXXXjUfD/AjkQcGFEhHDzPgfpGGy8jWL8Tn2e+hszwb5ONvbGSeiS0S5NByq7OntwK
         vwGBT3c4c1O+qGDrVkqmgsVHQXa4l4eaVIHC5T3zhnyFu5BCRpuBRop6roaDFqXKsGZ4
         /mvpunA7ld14Qt2/493CdmoKcau5MEE+G4jmSfaQGG3zdOJ87fW+/D0D44Ce7R/9msgP
         uXUbFXGxMFIeQ5ay7yyW9GY6OazVSe0YlFtjB8/+7rVICKo7nx4v71hda7dF8g27J+k1
         xVrKLiPVoZNOE77b327aNIbVL9TIoPbuMRrVagOhzrzCorn1O6fNYPCxuIDNLfw3I3ax
         /HXw==
X-Gm-Message-State: AOJu0YxuOHnSbGLD8J6UahOK7381LweqKes3lkaxnkhLPv1kOd21VC+A
	vYzl5H1WQhFH+5LwfMUJuBWJVlot19H7EyfrP+erNd0szOemOsMzqbp+aw==
X-Gm-Gg: ASbGncvh3M8FH6TDrfRGmKMYQdWOt1bhYxGs9wOUtIBy+8YGDFFDPGuUWDnOwKeTXac
	h/X/KI4EJAZDdNHLPHclXe1aj1CPGBHRuvjSHmpRasbuHmeBenwBZQJ4QBPpIJ+ZGhe1FQo5/kl
	5RMC0Iyinuq6gqj7vBAsn1pkXA+shg5XgVi2LuzSCEKjPrFGUewemrAFfBhOUPOu2qLcgiiAT8A
	UWdpq9XMr3XzJ5qDIFredQkDoNJMKVtNRzwJZtn4HZC5Sdr8TQYQpLz7aAjVhTwvK1169lgWzv3
	0vWtwS/a2AbAPAMaCLq2nH06CvKpzyS0n8+ZZr9Ry55iTnEN0HLpeKhBpQ==
X-Google-Smtp-Source: AGHT+IH6x4a494YQ5YPqaYK2nJSrc5ToXptb+vFyUQj40RsVS5wBfAigw3M7YIXXE5Yc/QJGn6xUyw==
X-Received: by 2002:a17:903:2448:b0:22e:69ee:b286 with SMTP id d9443c01a7336-231981c8e82mr50792985ad.33.1747237803033;
        Wed, 14 May 2025 08:50:03 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc7544d86sm101200295ad.47.2025.05.14.08.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 08:50:02 -0700 (PDT)
Date: Wed, 14 May 2025 23:50:35 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 2/3] packed-backend: extract snapshot allocation in
 `load_contents`
Message-ID: <aCS7y24E22TRzFV7@ArchLinux>
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

"load_contents" would choose which way to load the content of the
"packed-refs". However, we cannot directly use this function when
checking the consistency due to we don't want to open the file. And we
also need to reuse the logic to avoid causing repetition.

Let's create a new helper function "allocate_snapshot_buffer" to extract
the snapshot allocation logic in "load_contents" and update the
"load_contents" to align with the behavior.

Suggested-by: Jeff King <peff@peff.net>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 53 +++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index fb91833e76..1da44a3d6d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -517,6 +517,32 @@ static int refname_contains_nul(struct strbuf *refname)
 
 #define SMALL_FILE_SIZE (32*1024)
 
+static int allocate_snapshot_buffer(struct snapshot *snapshot, int fd, struct stat *st)
+{
+	ssize_t bytes_read;
+	size_t size;
+
+	size = xsize_t(st->st_size);
+	if (!size)
+		return 0;
+
+	if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
+		snapshot->buf = xmalloc(size);
+		bytes_read = read_in_full(fd, snapshot->buf, size);
+		if (bytes_read < 0 || bytes_read != size)
+			die_errno("couldn't read %s", snapshot->refs->path);
+		snapshot->mmapped = 0;
+	} else {
+		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		snapshot->mmapped = 1;
+	}
+
+	snapshot->start = snapshot->buf;
+	snapshot->eof = snapshot->buf + size;
+
+	return 1;
+}
+
 /*
  * Depending on `mmap_strategy`, either mmap or read the contents of
  * the `packed-refs` file into the snapshot. Return 1 if the file
@@ -525,10 +551,9 @@ static int refname_contains_nul(struct strbuf *refname)
  */
 static int load_contents(struct snapshot *snapshot)
 {
-	int fd;
 	struct stat st;
-	size_t size;
-	ssize_t bytes_read;
+	int ret;
+	int fd;
 
 	fd = open(snapshot->refs->path, O_RDONLY);
 	if (fd < 0) {
@@ -550,27 +575,11 @@ static int load_contents(struct snapshot *snapshot)
 
 	if (fstat(fd, &st) < 0)
 		die_errno("couldn't stat %s", snapshot->refs->path);
-	size = xsize_t(st.st_size);
-
-	if (!size) {
-		close(fd);
-		return 0;
-	} else if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
-		snapshot->buf = xmalloc(size);
-		bytes_read = read_in_full(fd, snapshot->buf, size);
-		if (bytes_read < 0 || bytes_read != size)
-			die_errno("couldn't read %s", snapshot->refs->path);
-		snapshot->mmapped = 0;
-	} else {
-		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		snapshot->mmapped = 1;
-	}
-	close(fd);
 
-	snapshot->start = snapshot->buf;
-	snapshot->eof = snapshot->buf + size;
+	ret = allocate_snapshot_buffer(snapshot, fd, &st);
 
-	return 1;
+	close(fd);
+	return ret;
 }
 
 static const char *find_reference_location_1(struct snapshot *snapshot,
-- 
2.49.0

