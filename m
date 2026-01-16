Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BDC3090C7
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598837; cv=none; b=Ipx2hoNZN6TpfIveuXPsHZa1/ktq1YDQMd6eSQWU/uBpOCF6SjxP5AYY0hZybgROPUObII0beFXa/xsuEFJjZJ4FRvr9uMHEzckpp9phEC5v8gKXCsewuG4D3qcNP7T0D7iYhk+jmfNU37RvD9hdXQBi2OzA971mlrNL5HuXVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598837; c=relaxed/simple;
	bh=b/k1vHOo2pCnoG/j7DojxXG+08ccj7/s0F1yKfskN1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rkkUe10lYd9ClhAq8R/oOGoH0A8tewOxCxMhJiP2zo6+mdP9X8Nf8GQ52zyQb1JDrJxTrvkahwRV/dxbCcHhPq9MWoqAg0OFHSJpk5gki5qP+Ya3njBND/u/N1dGCJ2pZtw6ZeofYy1agQEzINbxEk1CsPr3sXolzFVxigFVt/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExQ9RTKK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExQ9RTKK"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so19118115e9.0
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598834; x=1769203634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQY8wWYNgpXHRjuxCqKCZaGnzoookw/V3Y6z3MyG7Wg=;
        b=ExQ9RTKKvDVlbrf0TcWgg/HHNHojdrs6q81k7ZSBE1t5Tbw4t4jkKTg9NIqR5G9JCW
         QEQaZ6oWdlD6Djka56ySuaZP2lfQAs7oJootcu4mmkZ98zzMdjTZFf0UWQYP4s+CzVSs
         zDxcVKUjsC4YC4umT+hjlOkfhz37ekMTEgojMrNR03MMfYZSEtysLq28tKX0Z0LlUn6H
         TrnzSiGfF/bPTlPZdHcQLW7uAFGDBKeyhfY9SrRAwfakdDMHrYpyDkrPPTlE9nZ0F0sr
         Ar4FDX4aNrXkcqSh8kyPWE53R6nq6I8zvX9LVoZkQJy5f64+UfaqxejwUSAGKaojQRgZ
         XnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598834; x=1769203634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FQY8wWYNgpXHRjuxCqKCZaGnzoookw/V3Y6z3MyG7Wg=;
        b=A/FAsNf/Og8Znh1pK/9s/aKntXOWb8l62R6lFVjXq1W1KNcKFnWEqUhngrp9qjsgYD
         m17UudV5rcBDjN8P+IIPV2Cnf3uzufaK2jxG59+4YB28Ykr2yrt1vayNBYFwO4lCUM4d
         bBeTo7kyL4vH2pOZd4h2DH04TkYsI8Ka7KbUwX0rHKfC67xySq9/NiHXTbAPnfVWfNqx
         zNKR/9q/3pdnIL1LXxjQKxYDViktJIkSFDXJqzTWAqMmP5tdWaNA4ox0+YYOXCkdTw3e
         IzD0crDUkQ8/jcjiY57GqO/zT4frJo5SUaPRhhqLFm1/t+mOC4aKtmaciEhGXq32fOC7
         JwOw==
X-Gm-Message-State: AOJu0YxcQqDAWXqOu7imoTrNOJ3DiP2X+IN4KuaHECpgGIfcsW/mTFat
	3e1aUyzwOz85pm9B3T40TEIqAtrYBvyk5wO9vBmS8AqvT8GqIMzEScek
X-Gm-Gg: AY/fxX5d+tEOGbwSAPEl0f3MKq9gQRdhvmw6BrQbDsbAcLDUSBwGhfkWBdNnyNqFaI/
	/wqdn+T0oQ3hDWQgXVye8joOp2cQ08cInVW44hV4ei2aBPkfIBmKU0lAAmUvyeHuGI0ct+xQsFb
	XXIrkpitWfP2DXtGeHyOMvwJMCdPwvbIAkD+r9h0CSmf8aU7o/Cwi4eY6f//5cHnKuMsoRrvTtb
	1fI+FfExdCPGQ+eqQyVv7Ud5xmTlxkxw2jymHllD4GqaYRgd0bOE2Q+LdreGl8rJTKu9mge+Thl
	TCYpuirXU8BjJ+Manb44Bk0VC6bbgPZ0CfcqMydtXcHCES6swTljbJu75s3rnD0mqqB7uQG19HE
	gUVgan/56gpVaO4Rc+cR8LXBm3hGaa4vN8V1do5DMgyWsk4XXH4XUGKaZAJQO0LawBXRR+0R58d
	2Lm736BmT5e8cVAfVtoPg=
X-Received: by 2002:a05:600d:640f:20b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-4801e7d2a3cmr41619495e9.17.1768598834009;
        Fri, 16 Jan 2026 13:27:14 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1edb:411c:5531:1628])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe67780sm23382025e9.16.2026.01.16.13.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:27:13 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 16 Jan 2026 22:27:08 +0100
Subject: [PATCH v2 3/7] refs: add rejection detail to the callback function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-3-925a0e9c7f32@gmail.com>
References: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
In-Reply-To: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Elijah Newren <newren@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3039; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=b/k1vHOo2pCnoG/j7DojxXG+08ccj7/s0F1yKfskN1s=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlqrS3Ul/WpNvqmSbk6Tv5f27u/fi2KAVhrE
 N0aIbSjR/j9EokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpaq0tAAoJED7VnySO
 Rox/PKcL/ReUaVRkSKsmnNhYxEXaJ9g6yyuPRscNYBa9I7OBZcuw8P3XmXt0qyACAIL+lr/i/xK
 P7JuarzU7cZDL1Bu5DpyijjGf0dM2pSl49FY7X0iYQe7wefp8CfqvaZx1isaCbcL6doazVPnv9j
 sPerivLq0Spi59dtC+M9DQXh51p+HvhE4h9i9xdG3WgUaFuUVF2CPIgO0QomRuIXeNaai8NhTva
 CVnXqBywKK4gTHoziE4LxmCGt/ib4rIwIad2RFeikki1f5ELKyxxRxvka4HfwWaM7h/NMSHBjkB
 HTohrq4PofFXz84hkPHH7k51mgEVpahK73BDDzoaMW5X/FAyIfmeuZNbp/S1FdhQnWoGrvHQauC
 J7oW5SpKrvlStmixMRN7I1U6Tdx0CjGgBnCJZ5GpjlBLMvfDpRHMsPqQTKyyaL2tROd1QDRvBzW
 G+9bv49VPGp1G7h1rqGKGakLfp2uqRnJQgyPe1wYI9K3xAlw+ekOyRcxJM9yt3+Kli27t1B5kB7
 YA=
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
index 3459d0e4e5..e754159c21 100644
--- a/refs.c
+++ b/refs.c
@@ -2872,7 +2872,7 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
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

