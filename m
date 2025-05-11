Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974D17799F
	for <git@vger.kernel.org>; Sun, 11 May 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746972118; cv=none; b=gg+ve0i5r3uxwI03j2FemtAu+qs5K11ELsD/D/opsdxMAM2AMHThy83/0L1OGVluywbV0JL4EwTnCDXyAeOknwOofCSUes6f2tsoy6FgNOxE+PzyE4G24g8XS6t+EHRLcZvx4wOteaEUszNzmA+IvCDkQNkRMz0Ip4QxOKyKH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746972118; c=relaxed/simple;
	bh=bUISYwzdo265oNRuE2YO6S7Yva1Hb7XoEqo7n8jB4rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POrk2MIfSXk1/7hPQR1su3SCNLg/Pe6U9PHxsFM2miprh9XKrR8fa11354tI1MPQG5JStyamfUEkUVq4g/z2sJevfW8ONm3XylKE4URLLDpkOallCueCHMiOQ5M2DWtCWDo9PCTMdQ6k01Up+/Pmcmv8m7RYx/FlU8q6SHwFe2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgU/p8VS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgU/p8VS"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e16234307so37840785ad.0
        for <git@vger.kernel.org>; Sun, 11 May 2025 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746972115; x=1747576915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phDKJw+UjD1EoQwB2QJFAsXgBkQ7/qGdwj4hF79beqU=;
        b=KgU/p8VSGHo8rL6CIEuILiw0Xq6dHzzVm8GZeUXNm9N9UwqmNV77l206CtmAO2G02B
         WwlwWW+dQ3bW6TZR1Z7Yh4YbriaUEykg08qwJF49jkD+Ls0E9DMIbaoOlt01Zx06fyFK
         0YpEWXNbvnwSOMUtcpduUbdVMZN1cMp+ItGaZ11u6ewHcb6Bn1pfZNUV6+SdTr48P0ZC
         xO5ceSyh+eQ58wqa2T9LSchO9JDbZ8rpsPgY+BtWhNbF4xfQcpLJ8hY3k+RzF5yDouiL
         ESf4LoeXh0VADS8v9s8rj85chLDXVGA4g+dhxIVmwVL0PoEf0SWQSEpD2miO+H2m+hyH
         hWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746972115; x=1747576915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phDKJw+UjD1EoQwB2QJFAsXgBkQ7/qGdwj4hF79beqU=;
        b=YBAHzNHHJlbtzywfrIuNN7L3foj1/3iMbi38LvEv38ECrqEy5imiYSLJqxYNXhjwA+
         ucN4XXqjT/vGl6n4U+ts7H9pVQTh7QVvEZ2WCDjMcb0urhYtaQarcpKPPdobrSlhytFv
         XKoEXMdh7UrgDTGZdhRYtPTO7ETZZQ36cUsmjwRqtUVHYRs7i5yIbo4Npk67dHu/Gzdc
         bGKlYKDbCJtgkJoYM/4t47tr2eHz+KdDwpOESQrgUGuppe18yvlXzyS3Kv8Q6RheZ+E1
         PBn5LtrPUfGyg8e5AzwbdGWm5JpZSQUwQbpxXPoqxPkwfEvK/FFdPFnkAZ1EspTqYhVn
         znVg==
X-Gm-Message-State: AOJu0Yy/YAFsrYrT7Ih3CvOBavr1X73jUhaBEhzKLpGpqN8AFawKA6x9
	jEhzzt0qo06wdU0Cz0bsh9x7oY9Od+B/yv6k9w99XrFTLV+sz4bkqEt0gQ==
X-Gm-Gg: ASbGncu75CYBDLbdCW41H9N1n08CSABO8WHYL8w/7GjWVB0cZNxTqU0aPXBgJoTtwcr
	wCtD+GNehHPguqk1ZzFEtI/4smZ2bPhlVz/DhNAOv3nyey7eSYG0fxG31Hswj1B2B/X6M0J+ES7
	s/B4eBxKbOKCVgCm7Q4f1xA/+uMEuABUt6cyNlKoWM9OGfbpQfhdRo7yUIAYb6YvP3eIsG/koPn
	auongY/FV5gUnqaB6jJJftvczO/omKh8W68cFuKBoeHiYEO1iH+CHNmiJueolAyc7ZVR5VYUPrh
	341U1aOKbNtQvWpxlNyO5IKZI9l8GSrgAJsNRvDhdEhieopSQZK/n69zQA==
X-Google-Smtp-Source: AGHT+IFjJpit0OH+B3zEXQ7mID8fP/jQPqjaYICec7KqeJLrhTLdOZvFkaLPdQECnyfH3eYHuSy/rg==
X-Received: by 2002:a17:903:2307:b0:22d:e57a:27b0 with SMTP id d9443c01a7336-22e846e080dmr199178985ad.2.1746972115045;
        Sun, 11 May 2025 07:01:55 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc829d425sm46419785ad.202.2025.05.11.07.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 07:01:54 -0700 (PDT)
Date: Sun, 11 May 2025 22:01:50 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 2/3] packed-backend: extract snapshot allocation in
 `load_contents`
Message-ID: <aCCtzm2bDRSTgEO-@ArchLinux>
References: <aCCtQDnWII-knmEc@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCCtQDnWII-knmEc@ArchLinux>

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

