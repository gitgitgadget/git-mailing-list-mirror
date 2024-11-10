Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F81537C6
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731240579; cv=none; b=qX8/AvL7HVMByfvREbnckOQTg0nKsnI+kSWu7qMAs7mJetOk/GYHsFfV2Pfpg+IsgcFi+7a7qTAYgOIEIL643iiBqqLraQLbyf4+HCSmW1jarepdr1aBNa1k7VnWp19bv4Lzq/x5Kqayy1I4AsLe8J6IKzeDfIVzOwmgT7uofso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731240579; c=relaxed/simple;
	bh=5V0XiAbP8HWSYG2I6t6wyCWdiAvyF9V1n8no7T7g7Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHkN3uFBL1Y7P7asWECRV3qvpDm7uUHSgfQWgEMVGvp1CPZec0EkI1pD9/Bv/hA/f5itLK4Xd+9bxlYtGuUaNKJLe4S3yO3cfs9bWYUuLIYkLWFBV/6wFM89F1jYXqORqwjCs09wzSyPclV9y/QQJ3ZTLOY0WrNCZ6BS+sGUggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pavg27DQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pavg27DQ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ca1b6a80aso39324845ad.2
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 04:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731240577; x=1731845377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ75sjuyqz5k++4m10zIcF0Gbi0g1hHVhXO/JjRwBWE=;
        b=Pavg27DQqIUZMVH5qkVOQGGjkoJy2tXN0tRXWBTPvS+2TP3yzD22Fx62GXST+UkRkU
         TWlNabUr0CzsStcZZjjWGEc8KSfbjiiR93eI6nxHDgOHsboDaq+BdtixQikwkqPLcMtV
         l+tmGmBHRtmDc/mjJPg1OZgJ9oQjZHT0gzU4u07x7LZFvcOnt+aHu18zzbrIEAWnGBE6
         O/l5d4xZt1VqSO9G7G+abr/wHF3jU5cBzVLOQck96Ln1FuwmM0eaYOd1sMyK5hgBrfZy
         ban2S/vAPuFBHm0wy8DNmHRDOCt9Y3sIncDOu0PBlWlz4tN5SEagKDnM8bnAdlZUsA3x
         jWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731240577; x=1731845377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ75sjuyqz5k++4m10zIcF0Gbi0g1hHVhXO/JjRwBWE=;
        b=GcjC4S9rSKA1VM6eKzpibpe6J715hR41P29Fv143dAeQN3+eKVk1bwNfJ9gUyNZiho
         iMbow5aPGjEFUzZuIOgS7FKxqtoSvoOQ8vWxiRus+Qb3b+wmGLUoP8qJQ6DSJreJr1op
         EzzJZl4V/Bd/52zF4XK68qhYr5S4uf31cSSndNjodNMQeQLyR4aOyuPG+4Kkxsfh0uf6
         JUwpAkczj4mBN8w5/mBhdydLW7ft1L01o/PHajYqIPI+EpkprVUvJQiQehD9XadmJl2k
         aoDqUFK+h1NG6aIYfK3/fKRU9peoCCYh15p6y9L0ed8bKOy7yli6kh10qAfgrX24jxSm
         XIHA==
X-Gm-Message-State: AOJu0Yw1/5p8AU0E//aMbeib+Qy8FXbT8DOpcYx0HvX4NEFRY6aaSeo1
	nMuXB7pk/Xxi4qU0xn0WqX9PSDhRgz4cFBPbxOfL6Mt4aLP8AqaAkAmDgULLwSQ=
X-Google-Smtp-Source: AGHT+IGTfseGN89g/G/jKpgKcyORiO4MWnmLVSKgzJP9pYeu5D6jm6/aM18HDttyUHNWhI+Snb0Z2Q==
X-Received: by 2002:a17:902:f707:b0:20c:79f1:fee9 with SMTP id d9443c01a7336-21183c7df2cmr134164075ad.11.1731240576620;
        Sun, 10 Nov 2024 04:09:36 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6abb0sm58893595ad.244.2024.11.10.04.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 04:09:36 -0800 (PST)
Date: Sun, 10 Nov 2024 20:09:34 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 3/9] ref: initialize ref name outside of check functions
Message-ID: <ZzCifksT_MShWeoy@ArchLinux>
References: <ZzCiCGxL4Adnd_eq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzCiCGxL4Adnd_eq@ArchLinux>

We passes "refs_check_dir" to the "files_fsck_refs_name" function which
allows it to create the checked ref name later. However, when we
introduce a new check function, we have to allocate redundant memory and
re-calculate the ref name. It's bad for us to allocate redundant memory
and duplicate logic. Instead, we should allocate and calculate it only
once and pass the ref name to the check functions.

In order not to do repeat calculation, rename "refs_check_dir" to
"refname". And in "files_fsck_refs_dir", create a new strbuf "refname",
thus whenever we handle a new ref, calculate the name and call the check
functions one by one.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b055edc061..8edb700568 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3501,12 +3501,12 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
  */
 typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  struct fsck_options *o,
-				  const char *refs_check_dir,
+				  const char *refname,
 				  struct dir_iterator *iter);
 
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
-				const char *refs_check_dir,
+				const char *refname,
 				struct dir_iterator *iter)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -3522,11 +3522,10 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 	/*
 	 * This works right now because we never check the root refs.
 	 */
-	strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
-	if (check_refname_format(sb.buf, 0)) {
+	if (check_refname_format(refname, 0)) {
 		struct fsck_ref_report report = { 0 };
 
-		report.path = sb.buf;
+		report.path = refname;
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_NAME,
 				      "invalid refname format");
@@ -3542,6 +3541,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       const char *refs_check_dir,
 			       files_fsck_refs_fn *fsck_refs_fn)
 {
+	struct strbuf refname = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct dir_iterator *iter;
 	int iter_status;
@@ -3560,11 +3560,15 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 			continue;
 		} else if (S_ISREG(iter->st.st_mode) ||
 			   S_ISLNK(iter->st.st_mode)) {
+			strbuf_reset(&refname);
+			strbuf_addf(&refname, "%s/%s", refs_check_dir,
+				    iter->relative_path);
+
 			if (o->verbose)
-				fprintf_ln(stderr, "Checking %s/%s",
-					   refs_check_dir, iter->relative_path);
+				fprintf_ln(stderr, "Checking %s", refname.buf);
+
 			for (size_t i = 0; fsck_refs_fn[i]; i++) {
-				if (fsck_refs_fn[i](ref_store, o, refs_check_dir, iter))
+				if (fsck_refs_fn[i](ref_store, o, refname.buf, iter))
 					ret = -1;
 			}
 		} else {
@@ -3581,6 +3585,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 
 out:
 	strbuf_release(&sb);
+	strbuf_release(&refname);
 	return ret;
 }
 
-- 
2.47.0

