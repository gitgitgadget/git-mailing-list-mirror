Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456439CD01
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269805; cv=none; b=aZHoVEgFER7thrYo/H8eefEPANvezqg87ri5NEiZHkvEl/995eFLcGDlglH1X5sPGQ4NB9EwthkfmAwtYZ7HonTvKDuyQyOc3snWTaP6ibuiB9Fs7ANT46irFYeq5zb8ucU8e25WBRdoY2MeahRnS+eQXMr2v3i8qegA5V5TlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269805; c=relaxed/simple;
	bh=mdZB7D9kOGGF60uk7ZSWYhL/XTX1DDOZg3/eZMtBBD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaB2gNXK9u18GuwqaVRfqgyN2nHnu/oP63L+zkpQ6GknpVm2W9gAJ4kN/NWrQdRLMuQrGXOyexsBSFOHgpbcDzuPgzoOLa9e/P4J0b9dKMJE62rwatDVPDW8ElgWK7eWIpT3coTXcTrT3wmLPEO4bi+2XZU83C0aPkjmMTh8JKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmHg+mUw; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmHg+mUw"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9ecd7216cso334752a34.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787269792; x=1787874592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XEpiN/PgbrSK3k5Row5H0tIA0GjrBj5Rwt4GEwE59E=;
        b=YmHg+mUw7fYnoFbk9F8E+9ke309CwWowihuAOiSl/zqOccPZoVibbAMU6ZFSqlU5JD
         M/caHIIFeQlHhuonOc36+mQSOzuGA0OVdfhi4hiofpJ9dDZuOLwH1wtF9XanD1gJ+bbB
         HlnebpcjBPnd/s6AnxvEokociDHyWPGysI/p+qLw/3lmtBSUtjqq03dYxU6LX1UgsBXm
         vtXVFREgR1tTaolODW3QI6uOLndRuiuBQborYNr2onh40MSod9XHDckwGqujxRfPL4pX
         lwcKxhEUZUBzDYmwLOpoQLY7iSWo9yiDaBoNEehi2xgWyuwWhb+pcAQ1ogIXVS4ZgXGA
         YndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269792; x=1787874592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3XEpiN/PgbrSK3k5Row5H0tIA0GjrBj5Rwt4GEwE59E=;
        b=DvwzByaYhRqyE7ik8WpPjm4Z0W2MJXmEZ5kK/GUr2lDxBb5wWg5O6N7D8mWFLYENyj
         A42X2Xe9K+IwRf5lb1NIk1nr3ZxYz7RArWCEY3s+13RDwEJ4Hs9m+EBrejSARjR1SCNz
         wpANmK1MyJ5m93UUwLKz+mcRdEoaxmAABjdDuwvO9Yg+JR5j1jkXneDncZnSsQ5hI8Dh
         yNEIWUWwc7HehLV5WdSGtXkAXLbEkVok9xykC9CZmHwoDze+E6KuGMfrv8uBwdkMHwu9
         6C/k93yM4/dnLiQvc9olNaYTiTPkn9VeOL5F5sTAK9bfKNrbUu1GzeTD7JEgSlt1NbJ6
         dkew==
X-Gm-Message-State: AOJu0YxNSLd7Ebuukw7SaQvTkhinIoIQXq0e0BrkDFghgnRY95JSv2MB
	ygGzx+8DhOZ6Dive3EzCHflUOtb4dQO7JYRrj4Gp+F2XJD1hKV+A9eOKIEVR6Q==
X-Gm-Gg: AR+sD115BXls9RJeZqSyLVLuqF8Y66nMBm8Gos0/gcIbDXgGa11D36uuF6W0NBhfWGe
	Z4GVjTyKqXsaU0TQljqVuiWtHdwV1/+H0KUPp6oDotxgefEESXvxkVLGusaaUSIKULO2siycAs5
	DQoYG3NGQjCbeCJ3CvOnh/byKKnleemOKZ3CPS1EtKrXScAGuTH6SZY6ljQSRafzSsTuM3V58QN
	+4AD6Gdm/8pncSuhuIG5/alPwviwfm3WYHfLdtcq3kVPVnL6njZ/09oxVNvXJMFpBT2jwiRf7J6
	Fz/oMIqkVUPOlNLCpHm0gxEmvhnuxWn1ut0zKwEg9ueuLnqFja7AoaBDWqR6HwNtQ6jGARUVbTS
	ZiIHqbaWkpmWPvujancKWTPJfFK3F63F7mxLxeHGnbiKA/0ofLcKHvjdIeFooDyartwL7hnoM7k
	uR2QuPle01V0p67ZCc2+R84vpcab763ynTMXx/99petRTz0dmqIANMFO48UspUyBZTdfSE8g==
X-Received: by 2002:a05:6820:4de8:b0:6aa:f920:6b1a with SMTP id 006d021491bc7-6b159287077mr2760864eaf.16.1787269791923;
        Thu, 20 Aug 2026 16:49:51 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a6c360asm2961133fac.5.2026.08.20.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:49:51 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 7/9] builtin/receive-pack: explicitly pass packfile fd
Date: Thu, 20 Aug 2026 18:49:38 -0500
Message-ID: <20260820234940.894624-8-jltobler@gmail.com>
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

When processing the incoming packfile in git-receive-pack(1), `unpack()`
assumes it should always read it from stdin. In preparation for
`unpack()` logic being moved behind a generic ODB transaction interface,
update the function signature to take the an explicit fd provided by
callers to read the incoming packfile from instead. Call sites are
updated accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6df872697b..b369466783 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2292,9 +2292,9 @@ static void read_push_options(struct packet_reader *reader,
 	}
 }
 
-static const char *parse_pack_header(struct pack_header *hdr)
+static const char *parse_pack_header(struct pack_header *hdr, int pack_fd)
 {
-	switch (read_pack_header(0, hdr)) {
+	switch (read_pack_header(pack_fd, hdr)) {
 	case PH_ERROR_EOF:
 		return "eof before pack header was fully read";
 
@@ -2340,8 +2340,8 @@ struct unpack_opts {
 	int quiet;
 };
 
-static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
-		  const struct unpack_opts *opts)
+static int unpack(struct odb_transaction *transaction, int pack_fd,
+		  struct strbuf *err_msg, const struct unpack_opts *opts)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2349,7 +2349,7 @@ static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
 	struct child_process child = CHILD_PROCESS_INIT;
 	int err_fd = opts->err_fd;
 
-	hdr_err = parse_pack_header(&hdr);
+	hdr_err = parse_pack_header(&hdr, pack_fd);
 	if (hdr_err) {
 		if (err_fd > 0)
 			close(err_fd);
@@ -2376,6 +2376,7 @@ static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
 				     (uintmax_t)opts->max_input_size);
 		child.no_stdout = 1;
+		child.in = pack_fd;
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = run_command(&child);
@@ -2410,6 +2411,7 @@ static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
 				     (uintmax_t)opts->max_input_size);
 		child.out = -1;
+		child.in = pack_fd;
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = start_command(&child);
@@ -2461,7 +2463,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 	int ret;
 
 	if (!use_sideband)
-		return unpack(transaction, err_msg, &opts);
+		return unpack(transaction, 0, err_msg, &opts);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2471,7 +2473,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 		return 0;
 
 	opts.err_fd = muxer.in;
-	ret = unpack(transaction, err_msg, &opts);
+	ret = unpack(transaction, 0, err_msg, &opts);
 
 	finish_async(&muxer);
 	return ret;
-- 
2.55.0.424.g13c7afec21

