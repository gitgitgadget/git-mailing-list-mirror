Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938461E7C23
	for <git@vger.kernel.org>; Mon, 19 May 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648700; cv=none; b=fsZ5XE03CVmAViJzLMEs2Wm8fh/zWVfdUCfIVihokxYj8UJMmkYNaTsvTmk2DNvIE0TOUKWNlj95a7DPAU3Zhyz2RoUYZoxKvBCckjVY6Etkj1datPIJbVI2U8j/tN3g0mE3OkmSRX3cuedvaYJ53/7LRdN2DvBXPj7PTb/RDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648700; c=relaxed/simple;
	bh=spvvlZHyKhgLpoSv3e2r1TLWOQ8L8E5sd7MFJNj5Kuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rW4xixcPqEXCa8t66LWgjJB1K9VSBVRRjXHCzcfN1eCNhnsU+6BJuk4cVydzu8rMZzSCbA6lqrIN9xRf/khfSsr5cE7TVvVFSXU+lUyb76iHDbf3lP3tEGmq5weRgd9jb80KDcVvRr3Tz5uY2UJpdC31jMFG8vCOla0HoDQGgNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eneMyV+f; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eneMyV+f"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so45198845e9.2
        for <git@vger.kernel.org>; Mon, 19 May 2025 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747648697; x=1748253497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCSCxVKRtFVdRzqBgTam0eOLkkHASQtdiFrr+vp8oXo=;
        b=eneMyV+f/qFzEqWiJV6RDzBV7MSTZMy/QbpLEcA/GccDEhI2axg8rG/s0sQZHQCCYV
         J6lhNA49z+5jhdoVFfgwHBJI0qY7X50yKkIuhibsyESPDP3Je1M8/iCpV8vcoa8hL6u0
         Hykfblg1vV9hjOMxS+tReK4GidFxFkbus5w/pjxqTyaDC2/dWYAiIMRuch20VwCmDjb5
         y6hZYnQuGG0wR1gNC5RIRiJgNPWW0nErMIvTEqjveTn/JNwC/sF0OijfdLAmUvimrhc3
         HA7iPuTTDF4UyFLH9k+RRWx13PH/QY4UFZQ9DYK3Ufp1URBp6u/z2b0QZaS/KzaXwgjl
         uggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747648697; x=1748253497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCSCxVKRtFVdRzqBgTam0eOLkkHASQtdiFrr+vp8oXo=;
        b=jYeDpKW6dM1Qd5Q5/NRGfg/MMS4FdzYknrc6HwscJVU6WHg/WhCSPJ6epCv6FCb/cs
         gPiQQ0UP7flmaMrVMLdaWRpWnchpYnMH4vH/vyiR+xHDIEwMRaPdDH9vMNvkagCitovW
         uw0PdWjK5+a/Ntf2QLgBlPZyYGx0MxS2YkwVYH7XyKvrNVOW9fBsa617WhpbDKBXizsx
         b6NiMjQ2+oP0sb7Iz8iCMd5GdseJvDqPSyh/OQbz8bT0wDQxCfllLhmwPMK3cVTu6Z5L
         UduJ5bLHvFp4gRdOSSGJoYKDhASGXDYfwlzSuF72zuh8tSI48XQETD3N97waAUrlgHDf
         rkOA==
X-Gm-Message-State: AOJu0YxpQs8nfSx48w1vQu8Bid/ZoGHnYHk8rpL5u+FXvRLv3ji/P2yu
	9Ig6b7pGHwhGH8H1ZA4mVDuL1EqSgJ5S9LvuCiOe3BX4+w0EsvH5CrBj
X-Gm-Gg: ASbGncub39FKXdEzVqQlGVmT13ZQEpCwZOLwOEm8SoKaJ95EIM3fbDm/46VXimCbIuA
	3K9X9RScXHJYWAYNrBR2izrEzGjVFNHGTaxOciF1g1QCIAHnwLWKK4pnU0enzNqWEarATirQne8
	l1h5ocxIQT7kLXCG0dlxCnG42uwIrOr+z+pTkPWHKFmaeOoJBIev91v0+p9P+SV6L8oAQb31TA9
	WJJv/Wi8lZkcE2ErtSmOXn5cqYJCa/3Uio19CYVCpJYdlRdvaSNH2BYJFMSBA3gvq8hre/OyN/I
	xN8VwFhfPvoKNwIt+jJLHRWC4cpCciEY320=
X-Google-Smtp-Source: AGHT+IEHdP2D0vRPOYcLcNG7Ts4riaxjFpftd9NK5mHgW6L7aKAhQ6Xs7tyzKurnak1WtdPRCN7fCw==
X-Received: by 2002:a05:600d:c:b0:442:ff8e:11ac with SMTP id 5b1f17b1804b1-442ff8e1221mr88455055e9.12.1747648696596;
        Mon, 19 May 2025 02:58:16 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b2fc:6161:a86b:8382])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fa3e2ce5sm152811285e9.13.2025.05.19.02.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:58:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 19 May 2025 11:58:06 +0200
Subject: [PATCH v3 1/4] refs: add function to translate errors to strings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-1-6cdfd4f769b9@gmail.com>
References: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
In-Reply-To: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 gitster@pobox.com, peff@peff.net
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3448; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=spvvlZHyKhgLpoSv3e2r1TLWOQ8L8E5sd7MFJNj5Kuw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgrALW/KGkNkefxY+DL++iON+v/Oa/wyjAqP
 SWt++Np07x6RYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoKwC1AAoJED7VnySO
 Rox/FeML/2CX6JdVGPu3AMqASwwXMiWk13Pc/0asyMKMFUW9rHvq1nlzOX2OilZAcxwUtiShbUF
 OF2zMPrPbroNao3xpOlJwvkYKDfzi9fxWa7Z4io7LoHKpPLpkMcbHH3MCDwyzgL5v6g7yo9cq2M
 qufPDiEfkDsOqXouYkuq88TCdwux9ZwGHDPB4qNejdQ/V/fzT/QAmlQG3h8oLbFTq7dPG3W3YZc
 aZRex3S2yLQkJ/RIWFqLrfCyTYAyayp8Y72RuRRVgVOqvF6eOzMgZzEs6r1KZFIEMvKAiB0d1Lk
 OgxuDfP7flOiJqKJgbpVGxO5Gv+kIzQj/2VvP0kEnZ+wRG878SEWr4nsITlcJ/2P3qVmxv6Nelt
 hh1CtzoK3AaXDVA9eO6EZI/oiugud59Toi+UWWXVHuH6W2ZNoI2l3EpJ16Do/iQEGAjMM6o1zAU
 MOkccWsokkkzxGKZDVgw/pwEWlI6cAxiJPrVdzR8YZpz/xLH4wlANLkvK2FvMpTY0+5Nn/zRm15
 zQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The commit 76e760b999 (refs: introduce enum-based transaction error
types, 2025-04-08) introduced enum-based transaction error types. The
refs transaction logic was also modified to propagate these errors. For
clients of the ref transaction system, it would be beneficial to provide
human readable messages for these errors.

There is already an existing mapping in 'builtin/update-ref.c', move it
to 'refs.c' as `ref_transaction_error_msg()` and use the same within the
'builtin/update-ref.c'.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c | 25 +------------------------
 refs.c               | 20 ++++++++++++++++++++
 refs.h               |  5 +++++
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2b1e336ba1..1e6131e04a 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -575,30 +575,7 @@ static void print_rejected_refs(const char *refname,
 				void *cb_data UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char *reason = "";
-
-	switch (err) {
-	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
-		reason = "refname conflict";
-		break;
-	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
-		reason = "reference already exists";
-		break;
-	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
-		reason = "reference does not exist";
-		break;
-	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
-		reason = "incorrect old value provided";
-		break;
-	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
-		reason = "invalid new value provided";
-		break;
-	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
-		reason = "expected symref but found regular ref";
-		break;
-	default:
-		reason = "unkown failure";
-	}
+	const char *reason = ref_transaction_error_msg(err);
 
 	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
 		    new_oid ? oid_to_hex(new_oid) : new_target,
diff --git a/refs.c b/refs.c
index 6559db3789..f21778c75f 100644
--- a/refs.c
+++ b/refs.c
@@ -3314,3 +3314,23 @@ int ref_update_expects_existing_old_ref(struct ref_update *update)
 	return (update->flags & REF_HAVE_OLD) &&
 		(!is_null_oid(&update->old_oid) || update->old_target);
 }
+
+const char *ref_transaction_error_msg(enum ref_transaction_error err)
+{
+	switch (err) {
+	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
+		return "refname conflict";
+	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
+		return "reference already exists";
+	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
+		return "reference does not exist";
+	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
+		return "incorrect old value provided";
+	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
+		return "invalid new value provided";
+	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
+		return "expected symref but found regular ref";
+	default:
+		return "unknown failure";
+	}
+}
diff --git a/refs.h b/refs.h
index 46a6008e07..2d58af3d88 100644
--- a/refs.h
+++ b/refs.h
@@ -907,6 +907,11 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
 					      ref_transaction_for_each_rejected_update_fn cb,
 					      void *cb_data);
 
+/*
+ * Translate errors to human readable error messages.
+ */
+const char *ref_transaction_error_msg(enum ref_transaction_error err);
+
 /*
  * Free `*transaction` and all associated data.
  */

-- 
2.49.0

