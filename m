Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084727FD52
	for <git@vger.kernel.org>; Tue,  6 May 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549648; cv=none; b=g07sivY3V8NbfAlyniovs5SdqDlKwWAGQdMEfHnKyw6csJt71EZp5g3RbWT6unSYtDZsiFnV1+uYgYzu++1wyejYndPWLTLSvF8JKxaOMB2VBN3CpqF44bx4wflG8sZhjxeAhjFuQuoSHRINdP4IWJlI01/GiaNssKr8o1+lcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549648; c=relaxed/simple;
	bh=bUISYwzdo265oNRuE2YO6S7Yva1Hb7XoEqo7n8jB4rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grfsp3vPM4MPyQ6KBkyQ6TaXjHtKyh9nGh68VSG1X8LLUNP++oDcV8tHZxfwwCMjTybeo/uMrg4sO0mgYbwQZx6qIM0MifUElPr0R7QuAc2lKIpR5OQW85xlrjZ/5BRvpn7DxVZD8304dSSMlJ6nD/lpU4tAAD6AFhEOmZ12eRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPqh65RE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPqh65RE"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so5438154b3a.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746549645; x=1747154445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phDKJw+UjD1EoQwB2QJFAsXgBkQ7/qGdwj4hF79beqU=;
        b=QPqh65REViXsJ2lRTL4zzD/IvTwGeaeo0C8aqdPEkrVJzq7EyxUVneQ8aSQ62ycc2c
         +L1xAwGi6twxqLwPmX/InDPJrpDzL66a+gOkoEAv6ReKfJS51jzeQGsjADkVnH25aXIH
         2oAD78/lCFAgsNTw16x4aeBYiFpkpKJ9PudKFQljc4pcA4HevK4x6HV3WCLcooVIpUQK
         tvTG4+y6XosEnYmYHABuPkY0aqp/+j5JcCkbqGzek85Ot9JfdsSadhUTJa5K8/9mqy4L
         Sg61SRjiHarkZPeyoprf4rmGEFL4Bu1iMaw/O7vQEU5HIK27xNrMJSFcDxeOD+jO5u7N
         iwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746549645; x=1747154445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phDKJw+UjD1EoQwB2QJFAsXgBkQ7/qGdwj4hF79beqU=;
        b=X5NEbGJZznqugkUK9kFFlwwOvB1IW4mquw5BerkIc9EzwFmZn0JtLKUcnEyoBDtNlQ
         Snxbu+qJYsHQcFqzxhd7e24CKZ8ok/xbODWAYSrNyaI/WyruLuQW5NY3V3Om9fXbc2rv
         zQ8nEA9xnXVbRaWUFMsy2KyL1zaDbLG1R5XXmDshi+xPJiGoqNYzyb/W9ULI3ajJW/az
         7/L0KRp8W4GUP5PdqdmHcCzj2QTqtvRUGZJWP8HH+7LyBkeOuW7NG3BVtpkN1xspwR/D
         EmIbLzP1ToJ74QyCdm00crell3c03oFcFLZcCvnv3gXXwLlzoFlOPERLmOIf085u+bq0
         GD6Q==
X-Gm-Message-State: AOJu0YxLYfqygebH7GKtdn34het01PoZLcAO0qDZCP3Feq8Z2eMwyuQ1
	kNSYek6HvgyCrf6XNfFbtGicP3CGQpLmc/0JEcwQcUbw+dvRGsfq1vx6rYYo
X-Gm-Gg: ASbGncvMd+6BQgemE3E5u2+kO/D0UZeoXKONNpHgRZFeN5WYmfO44UOi3meADf4Q98p
	XP9eA1/AWUnBujUKe1glHu4t4Xa6XYgwrdZcsGWV9kHQwtbHwXG60cIVe0RIZp/J1QLjL1Q7uwX
	u8VpdqbevX3KrvJvptN1+MTHh8+dT/sJLO/6KQ/5vkHw3YHnWZZp6SrJunhPmluCEeMUVkJYoPN
	86sWFF0yHKy1VyIeBT/IXuyzdAp0Iwd1/11wxo4GmBegqx0VOAJ2a6+2v/CKiNVz4Q0ZM3CKAxW
	sIk56tnIrrTdB5JYoOjfkZMEp/vgX5TyAozo
X-Google-Smtp-Source: AGHT+IEJCkd2bHp+aYOrTkwmC18J/VBk1EHtFJ2eXb0pGfdcVx8OsNfi2VpFRHeAP5RdCKKd3+Q8Xg==
X-Received: by 2002:a05:6a20:3d8d:b0:1f5:80a3:afe8 with SMTP id adf61e73a8af0-211834a79d7mr4724136637.39.1746549645534;
        Tue, 06 May 2025 09:40:45 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b1fb3b5fce3sm6430665a12.31.2025.05.06.09.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:40:44 -0700 (PDT)
Date: Wed, 7 May 2025 00:41:09 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/4] packed-backend: extract snapshot allocation in
 `load_contents`
Message-ID: <aBo7pcimOG19oInQ@ArchLinux>
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
 refs/packed-backend.c | 54 +++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 0dd6c6677b..e582227772 100644
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
+	int ret = 1;
+	int fd;
 
 	fd = open(snapshot->refs->path, O_RDONLY);
 	if (fd < 0) {
@@ -550,27 +575,12 @@ static int load_contents(struct snapshot *snapshot)
 
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
+	if (!allocate_snapshot_buffer(snapshot, fd, &st))
+		ret = 0;
 
-	return 1;
+	close(fd);
+	return ret;
 }
 
 static const char *find_reference_location_1(struct snapshot *snapshot,
-- 
2.49.0

