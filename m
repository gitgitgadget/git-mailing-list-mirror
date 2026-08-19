Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6B3AEF47
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 21:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787176399; cv=none; b=QhSeCxI7KPSsnxehv0thHK3OGot/9Z/NuQN6lzQuuOj2jRF1wAgvoCGlj2U9k8xQblw8Mj2p9rC2my+rV4OHnHYCjDVUZEvWqDm8f5l8aU8c5CZggVoe/UFeYin+Q8ba1acMcHwpXtU9B6RQqby5HWAjkAie/j4bGFfF3zST/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787176399; c=relaxed/simple;
	bh=PYItGzANjsYtk+6gIMikaF4Akhpe7NI/4EscT4//8nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUMCE2Vq8RKZ4HNzywIIp70ETPnRkARngyY4+SGQMHhKa+BZ1sdgZ59eiQw6NXS8dnNFOkTGJ5rxOp9wJz4FVlMwaItFt+3MlfWjf9wJAhoyr/h3o8f85VQQM3ZXGguomU4OXEcBP8AwNUi2Ku6ZHsnu4tHZhj7DC6xbVOUXuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIMU3Eoi; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIMU3Eoi"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ee4399c423so1226588a34.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787176397; x=1787781197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I9GoL/ooUBoRYGEIhwSnNMm2DsI8VnFlflvKEOYbUuU=;
        b=nIMU3Eoiafd6Koihz7iZKJxvz/NKZrEG3ZH5JbbZsUkO1aHguQ7CPMx4lG8qvCtVSC
         MPs8/3eyi+1t8j00zOmmaMcQiiJAune575EVY3yGSse6t5OnHGh+jLDwQKrHdPPQulqU
         OkW1OilyfhtlJji0s/X2A8zrOzgb7JUhy6yhvYj9RIbwR18xJnSkUdozDA++OV0+0ENK
         f9RRIbpqW0YQuGoOwPlVOHfbdA7slLwR+Z+b7tqmGfs02XLdRlRYiFgz114J3+2jQJz1
         2vxnEoepCi0jTSDVyBN85eRAiTN3Y9eHaYy92yfYH6/qqXlE7LHisO0eynbyXWgV7k4f
         86gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787176397; x=1787781197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I9GoL/ooUBoRYGEIhwSnNMm2DsI8VnFlflvKEOYbUuU=;
        b=U9fsrOr3FWDuOL2sgdoRZ5hf9fRVligmSR9bvOzXXlRorpvTj5FJZ7R8V7nKyJeyD/
         BM15CYJW8KId7K44iE1CtwlfVmJ35Hm8VM83nKOaSGMakIRW8VOy9Qekd559trBfLces
         JhXikgspHr4tip57erUOemPO4jEpsvlSIisiXf0FcHwi6H5voL0LNvrrXd4vUqfWMzST
         clHX885fyvYu1p3SYvHV4K+UV8sf+LP4rs/A9iUn4q8lRagshLOrpqBVMOqgynNGOGsn
         S5aiCtp4IXB1hPK3wyqCEOU8fpKzcWttBW76ayxagyfPvzMipKdgKl4FO1eNqkaa7FSl
         habg==
X-Gm-Message-State: AOJu0Ywi9Irq1J6GB1bU0TuSez/BxAwW2oIdofP0SUNvYu5rONgeBxWp
	YZuOMejwiwCurxhe0LB2h6mU7nvEoDGFHKGzmOJKlIymhqTbaxSV7RNhwQun2Q==
X-Gm-Gg: AR+sD12zq5NVJVCiLNGdHVhDR0X7XoZxg8m7zuKjgDsjZz4qooHEBLQfkAp2jt6E/gO
	r7izKrAhyh4qfUrKqhhHDVH2e43noVhG0QSfwQc1bhTZgPAG4E7PDlUe0xPN1ou2f9IlfXgoEnB
	fPshZ1WGhj8s3TeaOJXFOHZubtXMb4s9rvss/m4MG2NJSPaIkmgdszEsdn6eJu8lqdsCZBUOGi9
	Lt1oREySQ089gvoFsHzv0uksQ8P+dNlNlzCyVWdjDqC6WYmjJNHMu8nSvShM/07+vF74pzvpYyS
	m61P7VsA5pgVS/YqQt3bgmUdWHIifSzCyBAIKb3fMg4HycqqjOHM9tzwaYqaxE9Vv3yqBVASoxA
	u6kSaQepB0G/9McPYYadsQKvn+cCPQjdsRlxufQ1xk99Rvsm8VTiZLWDHI7ThscEsjeOIwEYNF0
	xBgznUXvuzRt25ArrfB3WYLbXD7DrBdRYsktQWWuGjNyJ4u+u/zNvYfFS/c4r5I6jAwGLV
X-Received: by 2002:a05:6830:2e12:b0:7e9:e0f3:b914 with SMTP id 46e09a7af769-7f43fac213amr8473262a34.13.1787176396923;
        Wed, 19 Aug 2026 14:53:16 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7029dsm2718026a34.2.2026.08.19.14.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:53:16 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 4/9] builtin/receive-pack: read unpack limit config lazily
Date: Wed, 19 Aug 2026 16:53:06 -0500
Message-ID: <20260819215311.3880274-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260819215311.3880274-1-jltobler@gmail.com>
References: <20260811175415.2044235-1-jltobler@gmail.com>
 <20260819215311.3880274-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In git-receive-pack(1), the `receive.unpackLimit` and
`transfer.unpackLimit` configuration decides whether an incoming
packfile should be exploded into loose objects or kept as a packfile
on-disk. In a subsequent commit, the logic to write the incoming
packfile is made ODB backend agnostic and moved behind a pluggable ODB
transaction interface. Consequently, whether to explode a packfile is a
detail of how a particular backend stores objects and should not be a
part of the generic interface itself.

In preparation for this, instead resolve the unpack limit lazily inside
`unpack()` by reading the configuration directly. The now-unused unpack
limit globals are dropped accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 135105deae..971dc3f52e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -62,12 +62,9 @@ static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
-static int receive_unpack_limit = -1;
-static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
 static int advertise_push_options;
 static int advertise_sid;
-static int unpack_limit = 100;
 static off_t max_input_size;
 static int report_status;
 static int report_status_v2;
@@ -157,16 +154,6 @@ static int receive_pack_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (strcmp(var, "receive.unpacklimit") == 0) {
-		receive_unpack_limit = git_config_int(var, value, ctx->kvi);
-		return 0;
-	}
-
-	if (strcmp(var, "transfer.unpacklimit") == 0) {
-		transfer_unpack_limit = git_config_int(var, value, ctx->kvi);
-		return 0;
-	}
-
 	if (strcmp(var, "receive.fsck.skiplist") == 0) {
 		char *path;
 
@@ -2333,6 +2320,16 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
 }
 
+static unsigned int get_unpack_limit(struct repository *repo)
+{
+	unsigned int limit = 100;
+
+	repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
+	repo_config_get_uint(repo, "receive.unpacklimit", &limit);
+
+	return limit;
+}
+
 static const char *unpack(struct odb_transaction *transaction,
 			  const char *shallow_file, int err_fd)
 {
@@ -2360,7 +2357,7 @@ static const char *unpack(struct odb_transaction *transaction,
 
 	odb_transaction_env(transaction, &child.env);
 
-	if (ntohl(hdr.hdr_entries) < unpack_limit) {
+	if (ntohl(hdr.hdr_entries) < get_unpack_limit(the_repository)) {
 		strvec_push(&child.args, "unpack-objects");
 		push_header_arg(&child.args, &hdr);
 		if (quiet)
@@ -2658,11 +2655,6 @@ int cmd_receive_pack(int argc,
 	if (cert_nonce_seed)
 		push_cert_nonce = prepare_push_cert_nonce(service_dir, time(NULL));
 
-	if (0 <= receive_unpack_limit)
-		unpack_limit = receive_unpack_limit;
-	else if (0 <= transfer_unpack_limit)
-		unpack_limit = transfer_unpack_limit;
-
 	switch (determine_protocol_version_server()) {
 	case protocol_v2:
 		/*
-- 
2.55.0.424.g13c7afec21

