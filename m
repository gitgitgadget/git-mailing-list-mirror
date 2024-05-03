Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43257C9F
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763561; cv=none; b=DIrQN/Q4R5YNlOTYfiDt2OJxd1+6RzKN4eenu+T/uIm0c8BPg+b046HG/fpakNXacpKgshLyjUYAVDAO0xhuX04hm8r3hlBpm7XzBv0v1vOlkeyPw9cupZRXp55o4qhjTveUxKHNU/i+ItxGO03KfiyBbTk4NIfjlewld654WP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763561; c=relaxed/simple;
	bh=3zdd4Gm5q8kGExolckujRxrJZxH0YabyIRWIIHz8G2k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ElwKK2fUxJ+mqT5joOKDqXi4/shCYvfSGBzlGWJzmzxzP1Zen7QIdTJMpIl3pDaYVEVbJKtN3FsWQA/FAd0N4vJVLN2dsech3USAY0XunN5MRRoOGBiVbkDC/rm6UCeFuKnm0OwB8Ag17leaHGQfmZWxIF7oOtSC0RJQLBj2DBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=x8T4ozET; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="x8T4ozET"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ee2d64423cso3895597a34.2
        for <git@vger.kernel.org>; Fri, 03 May 2024 12:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714763558; x=1715368358; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmdLXDXrALpWEAnhHvrpg1WFdtNsH1oXxEDd4bKjWgQ=;
        b=x8T4ozETwyHi8/Ov5yrPf9ANYOxc7kMd52F3eMbYT1zTBlMJP3nYw937xPRMWnzd2H
         jZWsN42SLLC4HTlB0Ep917x8STFB8dY75KyszMS5HN8NWx545mQW60JUVdBG2RbgvVxF
         sNOBDkcpJMECBwTFHgq3DX+EE5fPfj3JtF4evX0559wD0HkmgWXv2kohuJgF/Dwwaukx
         IZJDzdLJdNR2PE9fxwU6MUQa64EY2gm8MZTy/X0SrzYf7gaVR44KNFWZOy9lOMJwZ1jO
         YklrMS5ObCLT1DKuDsxQhPyEtUGNYIsuO3vi6t7CFWMbPEg0utK6P6wZuRElBC1TmWT/
         gxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763558; x=1715368358;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmdLXDXrALpWEAnhHvrpg1WFdtNsH1oXxEDd4bKjWgQ=;
        b=Keupxo5yxWvPr3UbJLQJ1jJ8fs4NBJdg/F3vUix3WUCbsUF9M4EZ9CD1KxtQlYW6K0
         5qMUFKBf3BfHfOwJG4ThoiBDhkDncF3oKW/rc6dmyaUncFtHcW3/OXkClv4z3tLBA20b
         mIBc+CI8XfJ7lklaWQPKGOBTFEfj9zvfL/wRe4cPxMEvbWbMOW7n9iQdLvwF5aplnNuX
         GAVJT7RCNyTnRHY8xXAWl9aUn7RCFF3KcIAHn4YDZhhQoGGqOyF6nETtojhxMJsJGqAQ
         q7kJ+1BMGTbO5ci0TD4Ta3d71R1qQJjZGeYnhVzpNVnqhk+Rp5WuZDfVCwvKULxtGXwc
         MXEg==
X-Gm-Message-State: AOJu0YzkMnt64+q2Nfvf7PhdTC7uKS4w+YRWPWh44Uk2OZ9sVCI0JpX3
	9grYvn4cDNrMdHaRGGDHtWeyg6YeVveQU7to50VvwOJ3xq/YNZvQrNO2Hciab2wSCqaHkvRvOSm
	GS+4=
X-Google-Smtp-Source: AGHT+IGnk0FsYQTU9wrJoG+9O9RzjxrrpQdug4AGY6j9EPcEV76MQ3nZXIufS1UiUrpp1+1TpiDZ9Q==
X-Received: by 2002:a05:6830:1e8c:b0:6ee:5af6:aec8 with SMTP id n12-20020a0568301e8c00b006ee5af6aec8mr4001018otr.13.1714763558402;
        Fri, 03 May 2024 12:12:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o9-20020a05620a2a0900b0078eca9de099sm1449300qkp.134.2024.05.03.12.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:12:38 -0700 (PDT)
Date: Fri, 3 May 2024 15:12:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] attr.c: move ATTR_MAX_FILE_SIZE check into
 read_attr_from_buf()
Message-ID: <28f6267709db78ba526d7ed9fc4a734674697c70.1714763555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Commit 3c50032ff52 (attr: ignore overly large gitattributes files,
2022-12-01) added a defense-in-depth check to ensure that .gitattributes
blobs read from the index do not exceed ATTR_MAX_FILE_SIZE (100 MB).

But there were two cases added shortly after 3c50032ff52 was written
which do not apply similar protections:

  - 47cfc9bd7d0 (attr: add flag `--source` to work with tree-ish,
    2023-01-14)

  - 4723ae1007f (attr.c: read attributes in a sparse directory,
    2023-08-11) added a similar

Ensure that we refuse to process a .gitattributes blob exceeding
ATTR_MAX_FILE_SIZE when reading from either an arbitrary tree object or
a sparse directory. This is done by pushing the ATTR_MAX_FILE_SIZE check
down into the low-level `read_attr_from_buf()`.

In doing so, plug a leak in `read_attr_from_index()` where we would
accidentally leak the large buffer upon detecting it is too large to
process.

(Since `read_attr_from_buf()` handles a NULL buffer input, we can remove
a NULL check before calling it in `read_attr_from_index()` as well).

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 attr.c                | 19 +++++++++----------
 t/t0003-attributes.sh | 10 ++++++++++
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/attr.c b/attr.c
index 679e42258c..7c380c1731 100644
--- a/attr.c
+++ b/attr.c
@@ -765,8 +765,8 @@ static struct attr_stack *read_attr_from_file(const char *path, unsigned flags)
 	return res;
 }
 
-static struct attr_stack *read_attr_from_buf(char *buf, const char *path,
-					     unsigned flags)
+static struct attr_stack *read_attr_from_buf(char *buf, size_t length,
+					     const char *path, unsigned flags)
 {
 	struct attr_stack *res;
 	char *sp;
@@ -774,6 +774,11 @@ static struct attr_stack *read_attr_from_buf(char *buf, const char *path,
 
 	if (!buf)
 		return NULL;
+	if (length >= ATTR_MAX_FILE_SIZE) {
+		warning(_("ignoring overly large gitattributes blob '%s'"), path);
+		free(buf);
+		return NULL;
+	}
 
 	CALLOC_ARRAY(res, 1);
 	for (sp = buf; *sp;) {
@@ -813,7 +818,7 @@ static struct attr_stack *read_attr_from_blob(struct index_state *istate,
 		return NULL;
 	}
 
-	return read_attr_from_buf(buf, path, flags);
+	return read_attr_from_buf(buf, sz, path, flags);
 }
 
 static struct attr_stack *read_attr_from_index(struct index_state *istate,
@@ -860,13 +865,7 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
 		stack = read_attr_from_blob(istate, &istate->cache[sparse_dir_pos]->oid, relative_path, flags);
 	} else {
 		buf = read_blob_data_from_index(istate, path, &size);
-		if (!buf)
-			return NULL;
-		if (size >= ATTR_MAX_FILE_SIZE) {
-			warning(_("ignoring overly large gitattributes blob '%s'"), path);
-			return NULL;
-		}
-		stack = read_attr_from_buf(buf, path, flags);
+		stack = read_attr_from_buf(buf, size, path, flags);
 	}
 	return stack;
 }
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 774b52c298..b007f76fd6 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -572,6 +572,16 @@ test_expect_success EXPENSIVE 'large attributes file ignored in index' '
 	test_cmp expect err
 '
 
+test_expect_success EXPENSIVE 'large attributes blob ignored' '
+	test_when_finished "git update-index --remove .gitattributes" &&
+	blob=$(dd if=/dev/zero bs=1048576 count=101 2>/dev/null | git hash-object -w --stdin) &&
+	git update-index --add --cacheinfo 100644,$blob,.gitattributes &&
+	tree="$(git write-tree)" &&
+	git check-attr --cached --all --source="$tree" path >/dev/null 2>err &&
+	echo "warning: ignoring overly large gitattributes blob ${SQ}.gitattributes${SQ}" >expect &&
+	test_cmp expect err
+'
+
 test_expect_success 'builtin object mode attributes work (dir and regular paths)' '
 	>normal &&
 	attr_check_object_mode normal 100644 &&
-- 
2.45.0.36.g67f89f42283.dirty
