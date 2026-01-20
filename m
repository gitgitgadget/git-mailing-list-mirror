Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62E340D92
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903182; cv=none; b=H4wRHnSXZzQmMXqojrGRV7mSolBusnZ3nA9BULmChtr2ErF+xTLOKOBA5XbpRSpjoICqw2KgJNP7CtH04pACFnsWL9K2PaVhZrmspAIoWvOZpEzjisvZIqPLnE5Hrb775HiiQuidFDKfPB4rL++Hst0BnsOysEcHedzVelvjXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903182; c=relaxed/simple;
	bh=33U1fRTcaoCiDfZkGIHROTxCNIFA7BjxZV8swtadT8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAFWo4uz4Es33NtHVyp20MJcOMjLkH+h9ImLqeFXYtRpj4mitclUWoUKitfdadgvlMYbTSU6pPWHHLEaPwrNeVXJlaOBf8JAlz0iqZwbaw0dbU35+Mn50fcOUfMMaHte7GHHu6J/iIERaDrDMWXbB6R6ZOmaxqrPIxW+iqubnts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NG4KiyxR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NG4KiyxR"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so4479451f8f.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 01:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768903178; x=1769507978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYN+zQPkcQRsWnkM7j+Ca/DlLA3b3pB+CCiaamDJWeY=;
        b=NG4KiyxRzjXTp1H0Jh+RlLOWEEylnl7FzXtojxuvlR1bFrve3tjlJ3Yd/VLBVQiaan
         UfZSAGoaMlCf7+9NSnziTsV3rpg72vBX5ulXL8tNqvvSRBGeuxsnU2nY4Izx1LeLCly+
         x3pxmk8d/0zsMvk1+Lt+suyU2m2OSf/4PKX4xukFBNsURfTJNP6PNoGPtLRYH+hvG3XX
         hk9JAnWOdd9rLPOuNhN+9iHFyhjyNNhQ//figUUEI59YERpqaSSh8G8c2C1Ykhsl+i8O
         cg0GuTybeTDad4BCruXCsvz1ilyv9WPqHbqhjHi4k9zwzJaZiBj949zuZzwHoePKDb67
         O2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903178; x=1769507978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IYN+zQPkcQRsWnkM7j+Ca/DlLA3b3pB+CCiaamDJWeY=;
        b=tO+/2M/7vfmMceC24SK0sVOMUPboN6GPJ2m2c5l/jQl6XDi9bfw5k0AgyoS+2/yJ9E
         InygRLwd0Mi0Mv5eHZWoId6DqcHoMwOAA5C8AFb6v88Ca7ES2g/ki7UxcT56OSFStLrs
         NmfEzjhhsHBUHy9J/BzI1IwUHe/WOJwXH+4LIWOFztC38RLOixT3KrxAyWrSbceJo5Bx
         KyV3+4yOK40e0CKt/mko/5tp9T6/6ehplD55QG+MEcZLe2giwougqmIHPe1PTm4Xfxjr
         cQWE3ZSmNKw222TWUnM1sRSJsdVBSZyyNLW6VvzilZuYl6UfdCtKYuBRJBXiFismbZWp
         rlkg==
X-Gm-Message-State: AOJu0YzE/p+2cGw0tRl1UYoec37YLx8WNQ2X/nzCc8fbRseTxRrxNi5K
	28PwCYohEeSxw23bUdXRJdB7M4lFp5SUaZlWi1oralQ4veuaCDiIEe9M
X-Gm-Gg: AZuq6aITq0AuKuChbt0dlP25u6ibFnI3arb2Y7beiS24Ch8GY4RMDDXSpXZCfxeX3yJ
	p69qej0J0TX0BYoWDnLHDx+vthJPQ6Sr4fZ+J2mSfXiC/ypkMUF1lSYzpd2ZksEolFee4qVp3Jq
	qordxcS9z8GXhxpu/tQjW+aV/LzgbJ9pdUqFr7kSoyH+Z7LSfHdkagbifs0Vb7PtSku5rl0rt2K
	lQjvyiDj14pkuhN58Rwk3rNUzqvaNlacdnBKbaEeDMHLqTZwJ+2W/fKRhVNWGRUwaq1vN0+Gm/A
	p0XLlt1zPpftGRnuYTYHqrCj3AkSzOYmjSpdNf7oEVNnJR3jwTRT/6ayG2ZvqEjV4/9NCFFRoR+
	5o/qsGRY+JS2hUkqV3KVwS35Flk+BIXIJhegS+KUo5lQAE+6qDDmH4sCs8TIlEpQPpedaDn22L/
	TihRi4bOENTdcQLfz7gabcoNH6xCK7
X-Received: by 2002:a05:6000:400b:b0:432:84ef:841f with SMTP id ffacd0b85a97d-4356a0771e7mr19919047f8f.38.1768903177991;
        Tue, 20 Jan 2026 01:59:37 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:9d17:c155:e8f0:9505])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm27879778f8f.4.2026.01.20.01.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:59:37 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 20 Jan 2026 10:59:20 +0100
Subject: [PATCH v3 2/6] refs: add rejection detail to the callback function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-2-e0edb29acbef@gmail.com>
References: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
In-Reply-To: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 newren@gmail.com, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3039; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=33U1fRTcaoCiDfZkGIHROTxCNIFA7BjxZV8swtadT8Y=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlvUgakk18f3r17lEjHB/BwOuMf+Stw/Tz0z
 wTRWh8pRu2fxIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpb1IGAAoJED7VnySO
 Rox/p/4L/izG6XDnfAOhz/Kjs1LXCy8W005YJjC4QADuqAQDE5vhbdKDWBXe0ym8xdBj6kQIXs/
 6i4qI/yXdmhSCmwtgzjAuNG8LnKGDzZaS0aS3YgDuIwSWNXSTTIGDXTELb1/UPQcZCAm76lyGHM
 F0wTRLu84wttKfBgPlqxzKa3c9+UcRghahjjnEO/yBkdmxBMqJHHoM55MwOUdBgVoagPFr5iiar
 gJWEV7oTlzvnYwn/iIZs2hnsNvX8688p7RuC86hWvTSFBjqm9QR+QBogUWQaulBZ5cz8mknKfWq
 St3ZM+W2USeNOG1obJfNgOOsbA6+lYGsz3kbObDC5VCSnci2IUSpK5h+skwtDvNV3vJHEfF04bq
 9zzj6lXPb1jBHIygXbbuCCK7wOrJTtjQqGWWvai2a0HPi3rlWKRnlKWqLdpFcRTfoxQr57t/D20
 AOefH0Wtvg4UTdFf7Ml6e7pSioe27yac8p0V5fT17PocVmb3w2tB/5Vx6YB0LElOdPtDarzOyl6
 Z8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The previous commit started storing the rejection details alongside the
error code for rejected updates. Pass this along to the callback
function `ref_transaction_for_each_rejected_update()`. Currently the
field is unused, but will be integrated in the upcoming commits.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c        | 1 +
 builtin/receive-pack.c | 1 +
 builtin/update-ref.c   | 1 +
 refs.c                 | 2 +-
 refs.h                 | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 288d3772ea..d427adea61 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1649,6 +1649,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
+					      const char *details UNUSED,
 					      void *cb_data)
 {
 	struct ref_rejection_data *data = cb_data;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ef1f77be8c..94d3e73cee 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1813,6 +1813,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
+					      const char *details UNUSED,
 					      void *cb_data)
 {
 	struct strmap *failed_refs = cb_data;
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 195437e7c6..0046a87c57 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -573,6 +573,7 @@ static void print_rejected_refs(const char *refname,
 				const char *old_target,
 				const char *new_target,
 				enum ref_transaction_error err,
+				const char *details UNUSED,
 				void *cb_data UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
diff --git a/refs.c b/refs.c
index 53919c3d22..c85c3d2c8b 100644
--- a/refs.c
+++ b/refs.c
@@ -2874,7 +2874,7 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
 		   (update->flags & REF_HAVE_OLD) ? &update->old_oid : NULL,
 		   (update->flags & REF_HAVE_NEW) ? &update->new_oid : NULL,
 		   update->old_target, update->new_target,
-		   update->rejection_err, cb_data);
+		   update->rejection_err, update->rejection_details, cb_data);
 	}
 }
 
diff --git a/refs.h b/refs.h
index d9051bbb04..4fbe3da924 100644
--- a/refs.h
+++ b/refs.h
@@ -975,6 +975,7 @@ typedef void ref_transaction_for_each_rejected_update_fn(const char *refname,
 							 const char *old_target,
 							 const char *new_target,
 							 enum ref_transaction_error err,
+							 const char *details,
 							 void *cb_data);
 void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
 					      ref_transaction_for_each_rejected_update_fn cb,

-- 
2.51.2

