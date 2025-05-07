Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E71A2643
	for <git@vger.kernel.org>; Wed,  7 May 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629642; cv=none; b=r6XwYmYfaWZCjfLkYftNL1OgHW1g9hdUJ+i84y4C5uzO8PH30nmg/DTrv1PnyU3PVMJ5lt1o0RL1I21jcFcC4PHqJJK0gg/GqQshOchY5gVgItEu8lLEoHr0rjrLS/Ro3NfTbNHxmsO3qLVOZHJcVoULrsB6BmtXd5qOAtRI17s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629642; c=relaxed/simple;
	bh=ctdHksgJtC50QPCZP3SXwzCGB+BdoBrdSlhfoHB2i/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0pH1oj8hs4/acaMz2ju8kua9dRWOWNXg/ITEDeKfGAElMYJCa95boP84MDY/5z/j5PuGohx7HLId6KSbGJq7lWVOKBzm8FqWCbORgXFo4L169cKiM7Tfu82Qv0IRnoxWhnEz9O9ZU4is1YDvQOct3CrMFrjEFk24JeyWsdtfB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNNnbnMl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNNnbnMl"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22e70a9c6bdso10107785ad.3
        for <git@vger.kernel.org>; Wed, 07 May 2025 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746629639; x=1747234439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuFixe1+DmJcvVyuOgJo35lY1WDmfejV+pdzhu0IO0M=;
        b=LNNnbnMlsvmqkO07GdOu6c9TTiQr95yHNi8FWZF1ndKjWGiEhUo2rF4oLCTpVXrx0O
         sbRzP62/+84GzzIDjEz/WFpv7iZ5m23MecqhEdjr3nQ8sNdwjJhgX93q7FdzeZ/r/eTs
         Ske9OWOmXh8l2F/BGj/12KxwN7VvN+kD37FYFlh79D5gDAhxCF3MtuBozWY3W4egZ3Nk
         lWU1YRprmJuK3HEmiC9SlAO1mAmVPIDAAH1EetcnjXKhVDqXwcyl4TVRbzMrfJcc+blT
         zxcmLQ1Xk0syiqt1UZv8MmTvF7d35/jU6Mq4GpyNzhbLqyn9lHo9g28UMOsXFVgEOBes
         xBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746629639; x=1747234439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuFixe1+DmJcvVyuOgJo35lY1WDmfejV+pdzhu0IO0M=;
        b=lsW36c8HmYKQBhe4nPccexvfcqxz1TRqCUCy+4rf4RxMnPhaz+GR/FTCdSroqn/LC0
         dmescMBrzjLUBlRzhFI0xvpdP1CYYmxxr1eb7XiFV5ScdvcCxQV1XW7Qc2DmCozsgTDI
         CGD77eDb1RWX5LzwMeAgQMG+MPTQwF01zF9A+4fubG1y+KjxhO+Ab1107/K55XUXQTUi
         O/GnFgG3C9uFAN9+l4AYZQvYpj7QN6L+QZwPDLUCwJL2eeScrP3tz8rzvfKM/IpvMH5Y
         ggq9OI2XR64Po7E9lWwSBytjTxwv9YlmnjRWSRN73OWIXzI+QdXgl70RpwXyPLDtvsLx
         A+yg==
X-Gm-Message-State: AOJu0YymK2X7D8YcH4iD5hbA9NIS/USEaiop/W4+y1xmLwWtzyTNyXBW
	d2TtM3X64Qgsb0PWZ2JAMwK9m3mG729rhwU/w7T6/WShNSEX3kG7n+h7uCg3Hbc=
X-Gm-Gg: ASbGnctmLXYr33Bj8r5WbPlzwoSH3wqTL49z3S9fz3sge66DTSFQjvnLqNJdtZ3IXa7
	1WXZ6FCoTp96k4ysAkMtADTiLERaXFcDVv1f+rWWCQffcD7EhkV3KthRBc44lvBqJkGIjmgX2O0
	m3vAEqXCLIvwmrzCRJj4ivVuK3Fxqopzhcey5Sf/DIj5rBqwld9VjOo4AWOD/7uLCVs5ZjH2Y4A
	ZRjWwyQQfPJiNirvz9YMuZQ7nmgYaeddKCrhj/DZZrrvsn6pF2u5A/9hwlWd02fw1tD6H/lrpRG
	qxRQbSCj3wqzbWTVA0jGb3zlemjdiRlO4kSF
X-Google-Smtp-Source: AGHT+IF04SKghcqB9GU15NhV7YFBd7J9lGQsqPEXaZeOIxUIUUZZKyrFiANtLAq2KKprVwbEKoRQAw==
X-Received: by 2002:a17:902:e950:b0:220:cd9a:a167 with SMTP id d9443c01a7336-22e5ea424e5mr54392585ad.4.1746629639448;
        Wed, 07 May 2025 07:53:59 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e1521fc19sm95318735ad.122.2025.05.07.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:53:58 -0700 (PDT)
Date: Wed, 7 May 2025 22:53:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/4] packed-backend: extract munmap operation for
 `MMAP_TEMPORARY`
Message-ID: <aBt0BDTuOfUuCHE4@ArchLinux>
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

"create_snapshot" would try to munmap the file when the "mmap_strategy"
is "MMAP_TEMPORARY". We also need to do this operation when checking the
consistency of the "packed-refs" file.

Create a new function "munmap_temporary_snapshot" to do above and
change "create_snapshot" to align with the behavior.

Suggested-by: Jeff King <peff@peff.net>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index e582227772..ae6b6845a6 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -543,6 +543,27 @@ static int allocate_snapshot_buffer(struct snapshot *snapshot, int fd, struct st
 	return 1;
 }
 
+static void munmap_temporary_snapshot(struct snapshot *snapshot)
+{
+	char *buf_copy;
+	size_t size;
+
+	if (!snapshot)
+		return;
+
+	/*
+	 * We don't want to leave the file mmapped, so we are
+	 * forced to make a copy now:
+	 */
+	size = snapshot->eof - snapshot->start;
+	buf_copy = xmalloc(size);
+
+	memcpy(buf_copy, snapshot->start, size);
+	clear_snapshot_buffer(snapshot);
+	snapshot->buf = snapshot->start = buf_copy;
+	snapshot->eof = buf_copy + size;
+}
+
 /*
  * Depending on `mmap_strategy`, either mmap or read the contents of
  * the `packed-refs` file into the snapshot. Return 1 if the file
@@ -761,19 +782,8 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
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
+	if (mmap_strategy == MMAP_TEMPORARY && snapshot->mmapped)
+		munmap_temporary_snapshot(snapshot);
 
 	return snapshot;
 }
-- 
2.49.0

