Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1539B969
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269793; cv=none; b=Nv7xhfhhtI6vaA4nROBcGmy9u7HGxJL0GT4guADXAF+gfVg3ainctdDziO1+PppIVhYdCCe5HHOVHkoe6jXjr6L3b/zNd1iVRXtJmT/VI5S/DfdmMxJuhGEDG1qgZgzH53Zu6udzRwWoyczNvRdI3fXnB8CJfPcSA8wR7dyGA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269793; c=relaxed/simple;
	bh=6esPZhfhBJ/pPmhtRbHwkxmsO/ueCzCM5ah5wC47u4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpENNv5WgLboih3V1Bhc+DPyrjW465JQ6jyDvg7OX/zU/iXyHQx62JCVi7AkDf531hs1elAqoGOpZf/2ZdKOYtgHPu4NbotDNevTS8+Js7owexurihLT11FkHyE6lmtbsCQOsQJa9LSO7NHBYrEOnPUYFlkYSBLGBqYNiCEmJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDY2Itjw; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDY2Itjw"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4518ad44e83so373981fac.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 16:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787269790; x=1787874590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xWUDkIUnTdPELypxsRrdem7faCnjLouHaKzyxQxPqaE=;
        b=LDY2ItjwOAACbvA8CNQThrx8SPIiqotUGSx2XNNqYu5vLiOOToIGtheXfsWDSE/Fsh
         gLwQ6i2zjTBbayhvs3HDunjVY8bgPDZhZ9m8Lj3yBDATAleII4LaOtIHy6hycgzKALlS
         Mv8Jb8RdkfttqzhaZchEN/WCI1GAF5/jWoAAwpMVmU0o46euOk//LAlQtFM2zXzORB8v
         Fe2s+Ac1FaNTWIB/IOUhAI04kUbAqX4d9pGjLYeW0a5ITpuIT5Y0b3OZscR9JkN7ky1w
         Z4zwHbl2h3sML92bKTH7+t6srYb759KypTGl5PMRmDKGoSih06fgj9vU3GXpKFDeRd8Z
         AhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269790; x=1787874590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWUDkIUnTdPELypxsRrdem7faCnjLouHaKzyxQxPqaE=;
        b=jAtXydBpmie+vqT9IiaW9vV3ZHIg2LGo59EP2oROk+z/eWFuGodFVCZx6b4zDlRe4N
         RUKSnnak53uC3teywgWVIh1zyrDSsTufQG46zkM2MJX2jJ4wIR3y0t/PH+32pzc/GWEy
         fbJYoXR/x+jcnDybtNWYxmwlsJFXOAOfo75Xd2ojBR+TKMAut/897aE5rgk95QenYmcO
         ooV0sWkbRADBjy5oUhEmOJOjbtgtp1QKDnC5CMTwZES0fc0YEI+rMDsJn3YO4jxdlwrs
         qS4LAeefj+WAXAq971BVraucdmWuOXNIrdrLBtCZfp0+J1Z21vsil8xTBe50AE9Dbk6w
         cNgQ==
X-Gm-Message-State: AOJu0Yxa3CdtLa59NB2y6GzvHLNediiposwIunif8YFkDSDjJuPdQl6b
	6zcAqxpb3l71u9quAnLbua8NZLuETXtYsMHtJ9k73HiRH+JU0gv3rnOcXm/tsQ==
X-Gm-Gg: AR+sD13MRbK6GSpC0d7cqsp3ZzmeaTYM669Q2jktVbK8ATcx5ofaJYcEAGcFVTzbKgK
	MDSNxMV4B7jxYfyppfgwcEGDBaTO+prH/W4AKZ9RshkP9FCZGWTcNo4ygC4L2F7lt3epEbIbvZJ
	3dzjmsZ3ZA2IsDxEuJRlwYdCQKiWRdvRAX8ceo8idATtiE0yvc7IUnPfzb7o8wm0jPDlIsoPCbC
	Dz0Yo16BMGxAx2lSHJ+lAgsjTz0S0MEPlYHsS7yqyCvuj0PxHpUGpE2oQL+03zCeDOMXWT35gjS
	cJo6QwDFstbs0rkux/eHatd5WrU7iKdOhFv5FIs9CqpVJwL3WfpRlRwaFkbGigchWsT+lmaLN51
	r6P0+F2lBvJz2xT9sTEzbZkBbCT8LtC3FzG94gTXM4L8DWLyaf6kuZCSxitHgiFLnrQ5+kJp0Cj
	I1I1P/MF2zkE92tp+I9Zfv2voN06bs3c5JPsnBTaYwrclYMQ4OwZKKBWKfmxUbyhjSgARMiZTBb
	LRHt8ftzcw0
X-Received: by 2002:a05:6870:16d4:b0:448:3eb2:8c8c with SMTP id 586e51a60fabf-46350f869e9mr2096551fac.6.1787269789747;
        Thu, 20 Aug 2026 16:49:49 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a6c360asm2961133fac.5.2026.08.20.16.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:49:49 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 5/9] builtin/receive-pack: lift global state out of unpack()
Date: Thu, 20 Aug 2026 18:49:36 -0500
Message-ID: <20260820234940.894624-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260820234940.894624-1-jltobler@gmail.com>
References: <20260819215311.3880274-1-jltobler@gmail.com>
 <20260820234940.894624-1-jltobler@gmail.com>
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

