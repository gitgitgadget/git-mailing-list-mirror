Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294A30E0D5
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381568; cv=none; b=RAPi7P0Dku+CsKPjPlWlCT/cbkxdR96E0EjTrScm73S2uH9Ias+LnwUeTiYTMwYxUHh6Q7sbv8nn+ufzvVb7AGQUoBHz8AngMwArR28jIUWuVkzdvbpUOJJqTneXD5pFtzISIgQq5Vm+QNnCR9AaeMHKkavLlfOwkP52Gisulps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381568; c=relaxed/simple;
	bh=IMACRuBqccFKpZmenmlnQ0Uz01cBORZpWqMkv3/P/1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0EUPXduJdSS6klZxL5Jo3EYt+17S5kQ6+7AR+4NgmQNfeqs10SQb+LzzWC3KE+XbVqF2NxCAQlna6LvxQyMt3xVRGxjUchFCz1z6R2f/1/EqLkUOFn1OI353Nb98nol+e31W+nO7hBPzsO+zeYRQ0/u+JSWHC1R+PC5FcHcbQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaIGCVVy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaIGCVVy"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4801bc32725so30421185e9.0
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 14:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769381566; x=1769986366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhuXJzfzbCdMOPhZN5alU/dnu8gPEtMTjdZDqxg5QYk=;
        b=PaIGCVVyE/zIsO5V9eTLTAJugnhENE+1F5sMsGBHdBflDvZnVJ3NVrdsJwvwaAD8RO
         V/E4VEe1bpUHGNZEYOl1MYqFlDRiF/3FfNSZY4BQ4gQiAkBy7Qd0PKe5UF4MMyEWwTQq
         Ak1CWECS0ZTUG5VNm2g1BEPQzh3jMM68EH3W59Tjfux+fNCR6rao35N+UEDEx0XBAvKm
         rvHVuRW4i0Mjwy6fVNcG5ITmW1ke3stdtv02SdvnSlpR3MTwzI1AfJMBaksDg288VF0t
         34d5DviguFKMxZgw5iiarwUy6G/MfZYZ3jLyhsNVeGIssGXT6Rs2M9A+TcjTf37Vjlw6
         E8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769381566; x=1769986366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JhuXJzfzbCdMOPhZN5alU/dnu8gPEtMTjdZDqxg5QYk=;
        b=hER6NKaiALtu4VGJp/vJvw40HEVOHTf3WbDf5QW9gasXbmJ336Xf6cESTss27Ccq5F
         fHWuoRA1GWpkBSJETAlPROeT3QEmAATn2gUsm1FYNMrE/voYepQfp0dHtmUmTNBKbR8p
         evKTE/BrVeZa6BBob92waVWoK2KdAeEUJtSEAS2XSFE7AhV1byUk+9stk8NEFTuBLcTt
         oDHflRUAedBvl1PTFzmmck06roN3IYZv4u+l5yJUOVBe8bQYu8xg4QVBKqX8QB4TBM1i
         44UPSXVfe0Ie85h+JsdQ/lBDhFX41H+jZjozDF4Gh1JLTe+GcRmITdPMATpeQ8QWC87l
         WxLw==
X-Gm-Message-State: AOJu0Yzyon9c4yopLhuo1c/dWYLonpKV+QWtUp88SRclK8gVywHl7aGU
	jCE0o6KlLSo3xYVqG3y1rBnSQ4k/suzpV9Tyl/f+/9+Ajp7uhnyK+AEW
X-Gm-Gg: AZuq6aI67FoJaCr1S6xN1NZi0HjERfVIi5kMJ2HzzWoI2HXOll80Jqt67rCpB1PlLUu
	JhhrqhSha9gwBi5w+HnOHMJam9+qoQSZfQIWMQ7w83tzZDgcyHyHR4RcX9MayI4uJNBxe8gCWLx
	suM/q20d2Ck6RimljyorscM6uqoFOO6FJZ1AbvxhiaMIzbMEiKpcSGCkY/YgGsIav9MeIg9qK/w
	Zomg6NW8F8xmvZENU/hjASNnPak+/CKIVoebRQgrQLqHcsHSV5BNfK9IVO7QZqsPTacTOKRY+GL
	OAOYd1GC3QR5qC1ze4Xt/gZ+QQbnpVNYWRwA9jhr3XkI+UrrIB+xIWbaAME20SRucu0nO0A8IuF
	FV0se3bOM6gZEohkbab4Pvcgbg4lNvmv1OM+wbc9sIEdQhHoMZOui6VTXHP1SE1U+tPANWmmcre
	mUduWZiFagEJyzCaqPcg==
X-Received: by 2002:a05:600c:1547:b0:47a:8088:439c with SMTP id 5b1f17b1804b1-4805d065d80mr53708305e9.35.1769381565639;
        Sun, 25 Jan 2026 14:52:45 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ba14:1b51:e353:2193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm425263545e9.2.2026.01.25.14.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:52:45 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 25 Jan 2026 23:52:37 +0100
Subject: [PATCH v5 2/6] refs: add rejection detail to the callback function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-2-d58f3a9edf98@gmail.com>
References: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
In-Reply-To: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3039; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=IMACRuBqccFKpZmenmlnQ0Uz01cBORZpWqMkv3/P/1k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGl2nrcL4ml+slX9FbRdGKGVfKOn4n+b/S1SL
 UOwcTekC9TK9YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpdp63AAoJED7VnySO
 Rox/KP4L/jfQGb+JkCHnmiD3SbjwSoX4RnRJ/m3/yGuaq88YmWCDi+q6VzFLva2ipkKCkStCSAd
 V7TKubbgY44mxvR4NKndJhNJXJ1PRQaGHfZjA2vTc0+7yB+dEOCiCIh5753oZ5jw/Fu3ZtVw8G5
 TsecQjtyoXHaKBJqxhtx7NZ4+uhUsZxqcDtFDvvRbAyi2+6gcimn6blyV1jAXH7+KKWgoKoUQVH
 LTbfjjI+57N4inSsM7jYmrJMzZVUHQs1SNrpgwd6OQcRsPqjVXrRfGLzC/ltz/zGWyHnSYD8XXy
 z1X49AA2BlE9LsfCGo/qcAOkWXOxC/4wJnEk5QgPiC6NWm1UduHBqxB/tUIiWWsUS78YilqsuSP
 1fS1m+tYWnaHUtbwHrcoJ4R5FSagSDlYF0G/UYA0rixI8KTgcGcEaNPuXIqUqxztLYxY0fIx97a
 PRNHAKdFzLj+Sb+4hMYDKFgamAYYH4BEKEiaRHwzOM577XFYsm1DeQZY/2p+VKz0mE+yjcHcHh5
 VQ=
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
2.52.0

