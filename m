Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F0412BE4
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052351; cv=none; b=A35BBeWB+ggDnHOg4W/01PlRilr5OMd98nJ+AI7OKS1QeugaBvFiizXirSruRSyDqZDWv6XjY+N9qsPhdIvZ6beF4PtbTNi5ODIjPIiurKi4Y683hIT5AXnMH9W45u46b2CQxmfZONYqkN4VyTqzR7VYKqIpBukyKxjjy/KIZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052351; c=relaxed/simple;
	bh=mU5cDfnKDy+hm+y4bxp2vNITbvB5ao0y095+s8S/E1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbMav07sc5D1qePnTCNyfXAgJUO/mpdosGRrYK0Dq1DDG5xKeEHCKEn7e1PNhNskV7xjjRyPNooDCBuVe5L7gBigRVchizkrefEsHET/YL02kX+aBN2A8EUEKnYKQ0TV8CVKKwA2AvDsXuRaH5AgcTb3OJ4tLZ4mMGicmJNOenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwVzPkbJ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwVzPkbJ"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6ae4aff94c2so1651751eaf.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 14:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052346; x=1786657146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+l3yfBOZbKa5AtFxobx/ERfS/hBGd2j74RGpHvk7Wrc=;
        b=RwVzPkbJC7a6CTvwQ42HVM5WCZAIiHV+tyef1l/xm9mQY1ar+eluHDHgVwckE4y70v
         ArndInGMmAAY548CKhdN29Fyo87thPLvx+qLGzlNtlweo0vUo9luQPWEzZ/6n6FoNiNt
         cuI0jlYLp68uDElZORrGwR87bFf3ssAoJBUWscQmsMDHA3+FQUgNQX4GEWsQeB+zAQSD
         yrLT/I9kx6t0ckrV/UNYpvKo09D+u+saa3pZrfUshRsm2R+J1w4sY5eP9p3YodZJLTIE
         V9L2iuRBxk4eI+PDgKbsKBewl21TLRqtC3BG1ebcdmQmFDCkUIKiYxQRDoDlP5aX8XqF
         mllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052346; x=1786657146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+l3yfBOZbKa5AtFxobx/ERfS/hBGd2j74RGpHvk7Wrc=;
        b=CJ/W5cmzRrjrEwuR2zcSNHt4CRdSo3weFdU7tXMz2sLJDisAXevTx53jD4knB2SX0p
         8MV1x5WPdsnJ/gHerc7TB7YqaX/D/9HLAXLatTi4v10uT6YazpGGnniHI0SxDTh6tv8Q
         qu9k/SikZdWoBjfGd3MaRSKg6YCx2bEp5hBFjUkvzD3+5jhRgrN7pSZa0Rigzxo5WMPB
         NhzWIN8oXDDZ7UTQ38ahgqoOrtNUSkjg4GBlCxQl1+9hOkXqi731CI3oE4iGwcmc2G6n
         zBVFnz3jP3xxy9VDR+h66W+0iSaklX99B6/Z55yMLEJn0SIvEeQdJcJo3bSKvQGYOmVR
         yomw==
X-Gm-Message-State: AOJu0YwKTW4ZNv9dEYCtUPfsbh+ZYvJkEWO1otQY41IVLkbnHf6J2EAh
	Y+mj0rbII1ReWEawYX5lED+ENMFEFXf9XQyocrab+8iL9GH7Lr6fBP3kvknuAg==
X-Gm-Gg: AR+sD13vNaiLCgu5mqE6lAj6lZ2KK36RxDqMtIzfY0aMH2NnJ6OaaOKHrgqpnIWxGny
	5FFdyE6CzKpDBXQ8HdYtiApQYjEaVD9b+4k33j7yy1NOOZoj9LzPeaRUD9fJkHPAxOwLt84AaOy
	VLOv8msSA43YHyT8rcp5NJFuD47XB+4RuTNWLk/9LH5xkodkACk3rZU92YmUrDNCP/AcNjafZCQ
	ygmttI8t8scNQD6o6GBSHIs6NFHjFEUHTsOvpJiwaO3WQPPfSn8qi7z5pP3eTWHxikmIL6YH0Gb
	jkwsYvl8rryDRrpsIN4MFj4V8CPF2ZDBCJDmgiZfqqSUnY7J+CibrszHZQpyU7FrUsy6E7/kl1u
	8VXgHUR4GMG2Ld/iK5Opp8yjWtBFM2bq4HM45vWMzp85MDvw7hetekjAa2hPaw/ji9ldx0T5S/f
	YKPD/uyygNwCLEYobHwdwUasJxl9XKAMNuCk9TzLLsFBdPxp/A1nNSiLlw5V8tRxu3zmrc
X-Received: by 2002:a4a:ee0a:0:b0:6ae:4d93:cdc2 with SMTP id 006d021491bc7-6ae96c10127mr9797758eaf.5.1786052346430;
        Thu, 06 Aug 2026 14:39:06 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02be475b6sm587078eaf.11.2026.08.06.14.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:39:06 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/6] builtin/receive-pack: lift global state out of unpack()
Date: Thu,  6 Aug 2026 16:38:56 -0500
Message-ID: <20260806213859.816157-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260806213859.816157-1-jltobler@gmail.com>
References: <20260806213859.816157-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In git-receive-pack(1), writing the packfile to the transaction is
handled via `unpack()` which relies on global variables to decide how to
invoke the underlying git-index-pack(1) or git-unpack-objects(1) child
processes. In a subsequent commit, the `unpack()` logic is moved behind
a generic ODB transaction interface to handle writing packfiles and thus
can no rely on these globals.

Lift the global state out of `unpack()` by instead storing this state in
a `struct unpack_opts` that gets passed to the function explicitly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 67 +++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6da854fca2..8c2d6e5789 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2333,18 +2333,25 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
 }
 
+struct unpack_opts {
+	const char *fsck_msg_types;
+	const char *shallow_file;
+	off_t max_input_size;
+	int fsck_objects;
+	int unpack_limit;
+	int reject_thin;
+	int err_fd;
+	int quiet;
+};
+
 static const char *unpack(struct odb_transaction *transaction,
-			  const char *shallow_file, int err_fd)
+			  const struct unpack_opts *opts)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
 	int status;
 	struct child_process child = CHILD_PROCESS_INIT;
-	int fsck_objects = (receive_fsck_objects >= 0
-			    ? receive_fsck_objects
-			    : transfer_fsck_objects >= 0
-			    ? transfer_fsck_objects
-			    : 0);
+	int err_fd = opts->err_fd;
 
 	hdr_err = parse_pack_header(&hdr);
 	if (hdr_err) {
@@ -2353,24 +2360,24 @@ static const char *unpack(struct odb_transaction *transaction,
 		return hdr_err;
 	}
 
-	if (shallow_file) {
+	if (opts->shallow_file) {
 		strvec_push(&child.args, "--shallow-file");
-		strvec_push(&child.args, shallow_file);
+		strvec_push(&child.args, opts->shallow_file);
 	}
 
 	odb_transaction_env(transaction, &child.env);
 
-	if (ntohl(hdr.hdr_entries) < unpack_limit) {
+	if (ntohl(hdr.hdr_entries) < opts->unpack_limit) {
 		strvec_push(&child.args, "unpack-objects");
 		push_header_arg(&child.args, &hdr);
-		if (quiet)
+		if (opts->quiet)
 			strvec_push(&child.args, "-q");
-		if (fsck_objects)
+		if (opts->fsck_objects)
 			strvec_pushf(&child.args, "--strict%s",
-				     fsck_msg_types.buf);
-		if (max_input_size)
+				     opts->fsck_msg_types);
+		if (opts->max_input_size)
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
-				     (uintmax_t)max_input_size);
+				     (uintmax_t)opts->max_input_size);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -2391,18 +2398,18 @@ static const char *unpack(struct odb_transaction *transaction,
 			     (uintmax_t)getpid(),
 			     hostname);
 
-		if (!quiet && err_fd)
+		if (!opts->quiet && err_fd)
 			strvec_push(&child.args, "--show-resolving-progress");
-		if (use_sideband)
+		if (err_fd)
 			strvec_push(&child.args, "--report-end-of-input");
-		if (fsck_objects)
+		if (opts->fsck_objects)
 			strvec_pushf(&child.args, "--strict%s",
-				     fsck_msg_types.buf);
-		if (!reject_thin)
+				     opts->fsck_msg_types);
+		if (!opts->reject_thin)
 			strvec_push(&child.args, "--fix-thin");
-		if (max_input_size)
+		if (opts->max_input_size)
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
-				     (uintmax_t)max_input_size);
+				     (uintmax_t)opts->max_input_size);
 		child.out = -1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -2428,11 +2435,24 @@ static const char *unpack(struct odb_transaction *transaction,
 static const char *unpack_with_sideband(struct odb_transaction *transaction,
 					const char *shallow_file)
 {
+	struct unpack_opts opts = {
+		.fsck_objects = (receive_fsck_objects >= 0
+				 ? receive_fsck_objects
+				 : transfer_fsck_objects >= 0
+				 ? transfer_fsck_objects
+				 : 0),
+		.fsck_msg_types = fsck_msg_types.buf,
+		.max_input_size = max_input_size,
+		.shallow_file = shallow_file,
+		.unpack_limit = unpack_limit,
+		.reject_thin = reject_thin,
+		.quiet = quiet,
+	};
 	struct async muxer;
 	const char *ret;
 
 	if (!use_sideband)
-		return unpack(transaction, shallow_file, 0);
+		return unpack(transaction, &opts);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2441,7 +2461,8 @@ static const char *unpack_with_sideband(struct odb_transaction *transaction,
 	if (start_async(&muxer))
 		return NULL;
 
-	ret = unpack(transaction, shallow_file, muxer.in);
+	opts.err_fd = muxer.in;
+	ret = unpack(transaction, &opts);
 
 	finish_async(&muxer);
 	return ret;
-- 
2.55.0.424.g13c7afec21

