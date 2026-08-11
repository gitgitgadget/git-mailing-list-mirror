Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5356435B65D
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470871; cv=none; b=P/CVama9IbGS+RYmm/8GEuZKyXlI2eW5U/bJsncM5OE4lso85e2mywbc0h6zyZS5xXt5YgGJ1y0/OIFBi2zcGffpbCJt8gkBZEffNQGa8WtlBpHZPYJR5YKWL2gW0EfAdGtcc/TA6WbhshFDDNCyk2DIyabI9SDZ75WSaaKLVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470871; c=relaxed/simple;
	bh=6esPZhfhBJ/pPmhtRbHwkxmsO/ueCzCM5ah5wC47u4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPj/G+cjtstR2hyhZ+Oa0EZxUqq1UvB9ggHDLU+MZTfNJQdHd6YksJJtsrTm98X5mw0mAfCcGv9/C+LSnnSnYefzsWvht/7Eg1NaD3MFHZpfLEhSIlEed8ihBJ53DS9lxqjoUdJJTCTzDAwmdp1H4EIry5bRFGSbmQ8iEEIPqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzQAKQ5b; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzQAKQ5b"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4513435cdd2so10111fac.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470869; x=1787075669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xWUDkIUnTdPELypxsRrdem7faCnjLouHaKzyxQxPqaE=;
        b=VzQAKQ5bR3l/u1qN5AFNdKcMNVYZv/DzRtJEMdREhV2T2SWKO576dT+enhGhZWZMMt
         a4ayAyjy/cWS7JEQgOGsIA1O2fs4x3t4X50uC9Pbz4FivVoBQK/hlo7wQH3q2wM7/JZL
         MCeRdRwL1oUiMPS984xT0976+2ehY5ykWgXMwj4sIHwWLRQlX2k7TEI+KnvxzvUaqbTJ
         iH33vyxOf58NLlNFv/ctC5+g/2XRy6rDEglA3u5/S9doQLAFcq/yPRJRyynGFqFDFWEx
         tQMwPpMm1YgIydFV/nJf7uCbOqJIiVzKY8douVLB9s7heD9Wrsi57YKi/eAsc4mKwjGM
         aPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470869; x=1787075669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWUDkIUnTdPELypxsRrdem7faCnjLouHaKzyxQxPqaE=;
        b=K3PyRZkjvMA4nGbvPeN2LSQiJGsDNiTIIvlQuGoQgsJpCzVueDlQkwcSHQF9cpgjbj
         Ef6FgkSxhmyXopgqtnu4dJoXmPZ2rN7gVusOzCHii8W5N1iUkAAEb6dqTRBZy+a4pLQh
         wYAdcRA2RnHPJZke12HcDQxNYVavwoXdWpyi/N1d5xyPtGtcJW1fskX9gPHfnlrzPjZK
         RoTdoLWDI128xD5oT0w7opUBDm8fYWAXuj6nwh7odxoSxFkWWoYDo7jNphnMu5pRpWNM
         jv45QsYJy3NP2urrpyHLv/82TzAds50rNtqUthEAlSxFcLmUM3od8INM7/DVCq5G/ARf
         RRrQ==
X-Gm-Message-State: AOJu0YwyYZ1MbUYfHNHxyyp2mrHons417hK3Q41ddQlognDY/pKgMOIV
	wALNaVd8Y6vsUezfHGkVI1QrHiWMbKHf1tds7K6WVK3iMfC5mY9cw1g+5sQu1g==
X-Gm-Gg: AR+sD132LVMnRAjIstfCzvr09kIsiOVrXsCZJ+uKT/wyoThBVBJul+2/dlobBVBjzjz
	8XTukYI2i5uPHN+rUnNFRvr6JkfCHw2R5ArIMuE8ZHri1rzQBqTE6/6zNQs+06G0Kbkr10chg6r
	48yCeMwdv42cshYhB6I0DDY0IMQLnnOH5xDwmJ5nsbzZ6HSOLh1zE/O9pkwinsdnoIEcfj0ZyRU
	QVgBfu8XRpYu3iUQiR5P/WSe9J+YT2WiGrKfIncy0jQLELJpqCTlrBOtjrtHKQ/fO7CDYbiCRJk
	HGwXK0Vos9kS7bCFLm5dIXOmg/EhpL7wvE6lkeHvvFWeE1CPbVg2c89NaEJdUGSnU8iq2wUhKXs
	dD0r6P795CgF09I6OzS9uSJP2qZcBNKDvkI9PfzKhdeHKXBOFoaslnnzQGCdWwAa0G2oLgu1p0g
	N4H0aQkfGX1hhlGuTllZh6VeOId+8fSTqXmMTaHfFaZjkbi4EdycqzRECq9t0JzvO5EnLY
X-Received: by 2002:a05:6808:181a:b0:495:eb86:6e8f with SMTP id 5614622812f47-4b209f954e6mr994723b6e.14.1786470869077;
        Tue, 11 Aug 2026 10:54:29 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2001331d2sm1241489b6e.11.2026.08.11.10.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:54:28 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 5/9] builtin/receive-pack: lift global state out of unpack()
Date: Tue, 11 Aug 2026 12:54:11 -0500
Message-ID: <20260811175415.2044235-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260811175415.2044235-1-jltobler@gmail.com>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
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
can no longer rely on these globals.

Lift the global state out of `unpack()` by instead storing this state in
a `struct unpack_opts` that gets passed to the function explicitly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 63 +++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 971dc3f52e..f062b93b8d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2330,18 +2330,24 @@ static unsigned int get_unpack_limit(struct repository *repo)
 	return limit;
 }
 
+struct unpack_opts {
+	const char *fsck_msg_types;
+	const char *shallow_file;
+	off_t max_input_size;
+	int fsck_objects;
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
@@ -2350,9 +2356,9 @@ static const char *unpack(struct odb_transaction *transaction,
 		return hdr_err;
 	}
 
-	if (shallow_file) {
+	if (opts->shallow_file) {
 		strvec_push(&child.args, "--shallow-file");
-		strvec_push(&child.args, shallow_file);
+		strvec_push(&child.args, opts->shallow_file);
 	}
 
 	odb_transaction_env(transaction, &child.env);
@@ -2360,14 +2366,14 @@ static const char *unpack(struct odb_transaction *transaction,
 	if (ntohl(hdr.hdr_entries) < get_unpack_limit(the_repository)) {
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
@@ -2388,18 +2394,18 @@ static const char *unpack(struct odb_transaction *transaction,
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
@@ -2431,11 +2437,23 @@ static const char *unpack(struct odb_transaction *transaction,
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
@@ -2444,7 +2462,8 @@ static const char *unpack_with_sideband(struct odb_transaction *transaction,
 	if (start_async(&muxer))
 		return NULL;
 
-	ret = unpack(transaction, shallow_file, muxer.in);
+	opts.err_fd = muxer.in;
+	ret = unpack(transaction, &opts);
 
 	finish_async(&muxer);
 	return ret;
-- 
2.55.0.424.g13c7afec21

