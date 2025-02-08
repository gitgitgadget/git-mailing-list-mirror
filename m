Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D49241134
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739039372; cv=none; b=lTnIvu6fOd8nMwIagC7pi9FQFceB5jZ8e/ZKzz3Eb3JmZO34L0YpJLjAbxI8RIPxSnrcZZKLuJdnhKdh69FXSekqVUhkTjoKqZy3DkYohKxPRezaDUAbOxxvSeh2VjLN4SOWOMUIG7zz4XWJl7//aeWcUoVxKhKMQ3zOOEBLCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739039372; c=relaxed/simple;
	bh=zQnbhRCacv7N1rD13FzabhiH7vjJJlggvHCbP4dHsEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYDmRt3zZ9xfjXJUfZzocjEZ35J6Rpa773dqvRGHR9+gsA9wyWJDJhwSFIxuZsITaYwy5iJsmqp7gIXR2Mm9G0A4HAfGFZwdPrpNW9bGA8rQ+AR7gmuj4WfeQ2XAqkF1p1hlA366ylCwKP6i72LCV7mWHL/oLBltTAPMxJcTU4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKbrLP2y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKbrLP2y"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f573ff39bso31809255ad.1
        for <git@vger.kernel.org>; Sat, 08 Feb 2025 10:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739039370; x=1739644170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YMJmKuQq0f+AsyM0Ol21ygj+2EBiaA0et6KyfBZVLE=;
        b=TKbrLP2y80WS2bKNZF75Zo72xcAJ3itvl7Zs4kienflZW533bhKjahhexDo9/dSuiF
         pCqJYkDY9OMGt4PbifFHsBEZ8+zM0xC9zL2BOMO4qmYmUFugjpVBI+D4fl+9oosNbMX9
         r+C6Zk2R0Y0KcY3cs+utii1noKIYimRtZWShHE4PLPJAXsh+j+pYZs4sxBsqOIWtX5VV
         LvUa8D5xNNlOvfP7j68E51PjtyDzHbdg4Nzu0qUhdNLRhvEKA6WATuCvWYHd8bcofDxS
         IU0dJPaGUM7KAQ2wyFCPyf/RP8qCRiFr2v0vY1MVeb+vpqoj7R2Q9AuGvC+o6RokAA7K
         065Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739039370; x=1739644170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YMJmKuQq0f+AsyM0Ol21ygj+2EBiaA0et6KyfBZVLE=;
        b=pkD0CjnowzS1KfmZa0srwpq/iw0QVb/VCson3eFRcvuzyR02e/ickFXJ0nb6eDqpOk
         Izd9hIDgjOwLF5GlBeH4qFqY+8Eb47MqhJri0XrvORCdX2Jyr2OH1XSnE6Mx8r2o+8VZ
         2inV1pbT6yfk0eK24qqPPUyTGijYzQjhCKjePtRsNg6Ra7rX2oQEmIms5nLYnbq6KvCj
         qzbbEkB87DMMQsoiqtl9Pc5M581POQeX3pjMi5/2OLN8AgRUwwfKRbBAUQ+GidC+I87O
         IkZlS4myiBdN/+o1tIbkdLf5+guajr4ksbsudYV+orr80A6jpxyQSt5TcPQarvDHbvt7
         t3hw==
X-Gm-Message-State: AOJu0Yxr2YsRM9/N9MJFsUqlCXrcjlOx/f1hXZX/AU9x5vVb4YlAtsZZ
	dYit4XcbO08k6zL+0cMUt1cKxzl9PVYP10dDw7jICuTmjkjVkSHFYh+Q+Q==
X-Gm-Gg: ASbGncvnbtpvPfmMQfMHMy8n5bbQh8dFYCgn8gPtoxKdmfI0W1z6v/JVJb8tU++gAma
	wePwIvoeL2OpMKbcFbZjt+LKwGBn5/Uox/A/7tM2WhEghR/2ElPlEccXMlGUEr67GZ7tSE0H8nN
	HQ3s6jMeD+alR8Cikkbc6bVyvLQbF3C8szAkiGcIdINYGZLKATjsu8uixNJDNioKCSqj5b5GJ0U
	6HXH+bAWHQTjwP7igHGCmVZZS+9W+YygaRiDMxFs7/hsedvvE/AtzPE1LwUAf8Lwezp/DI+4GOI
	FRQj4bFwmOCoXfUYtulrkPiFejde
X-Google-Smtp-Source: AGHT+IGGBmTYeo8w6rJ20I3VTcmB6TAipx2M4i22qtnBeFeYPg18AB2HrdODdWaIi6xpJStDsWYvHw==
X-Received: by 2002:a05:6a20:ce4f:b0:1ea:e8a2:57d6 with SMTP id adf61e73a8af0-1ee03a47443mr15371918637.14.1739039370394;
        Sat, 08 Feb 2025 10:29:30 -0800 (PST)
Received: from localhost.localdomain ([171.60.229.127])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53af80cc0sm1333731a12.73.2025.02.08.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 10:29:30 -0800 (PST)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/1] refs.c: fix -Wsign-compare warnings
Date: Sat,  8 Feb 2025 23:57:35 +0530
Message-ID: <20250208182736.18133-2-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250208182736.18133-1-dhar61595@gmail.com>
References: <20250208182736.18133-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove DISABLE_SIGN_COMPARE_WARNINGS from refs.c and fix integer
comparison issues that caused -Wsign-compare warnings.

Tested using `make DEVELOPER=1` and `make t` to ensure correctness.
---
 refs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 37b8cfb90c..e5cb7acfbe 100644
--- a/refs.c
+++ b/refs.c
@@ -3,7 +3,7 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
+
 
 #include "git-compat-util.h"
 #include "advice.h"
@@ -1652,7 +1652,7 @@ const char *find_descendant_ref(const char *dirname,
 	 * slash) and is not in skip, then we have a conflict.
 	 */
 	for (pos = string_list_find_insert_index(extras, dirname, 0);
-	     pos < extras->nr; pos++) {
+	 (size_t)pos < extras->nr; pos++) {
 		const char *extra_refname = extras->items[pos].string;
 
 		if (!starts_with(extra_refname, dirname))
@@ -2304,7 +2304,8 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	const char *hook;
-	int ret = 0, i;
+	int ret = 0;
+	size_t i ;
 
 	hook = find_hook(transaction->ref_store->repo, "reference-transaction");
 	if (!hook)
@@ -2635,9 +2636,9 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
 					    ref_transaction_for_each_queued_update_fn cb,
 					    void *cb_data)
 {
-	int i;
+	size_t i;
 
-	for (i = 0; i < transaction->nr; i++) {
+	for ( i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
 		cb(update->refname,
-- 
2.48.0

