Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5718D620
	for <git@vger.kernel.org>; Thu, 15 May 2025 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318054; cv=none; b=lrfUBioNlbXvXjL+09U6t5h7VujXiqFumCtShJVgAy4H4OWvD6evhly2FmWcs3fjoikslcYJxgHF3r9BsQK58QCNtEg2+gvVgmfCvoNh3rC4ShZNnWyoHRRw0S36ozKN72z5Uh2GY4i+F5FvLdPxpfgCbBspHyiViWZqMJ80Stg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318054; c=relaxed/simple;
	bh=1AgNKGGYm5w5kMuPq4pkiA9o3UtnvQFg4HVvP6CXEPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gX/U3bP5jopASAVWmtLKT8bF0cJZl/J01rKHGdy9jiKi5dkFEMqJbDue5lDXL7fFAW+8vxl/NTD20YyEBsCDLNCtofS1QvsSdyPyfvx+MxjcW+7tvjdcDrxDZUF3EXa3nJ9CKvG0Go2RgIjLHWU1qzEyTAOQWa01g6B+0aV7Hsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoH0qZZy; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoH0qZZy"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54fcc593466so1079564e87.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747318050; x=1747922850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyb2P3N1Ro3oQLC9e8C9UsuT/J21sixODTw4O4Y61vY=;
        b=EoH0qZZyGF1quNwUsvrIbQVoFrBO0sAWI5tW+bYcLIah0bNUfcAfMlZU7MAj3Ak0mW
         LUXpPGYfLIT0XBSekpTJzgQFnUaNJ/yVLJOsNNQ5pKnen5xbDkY4rQtsDMyaxYAbWeyx
         8V4tQsv6kI6WMmzDv2vLmHKzmv59VI/dDyuiraMl4Ra/UJnDF4w5F6qzP7SzVioWbY9p
         ICDS9JgGGejIUcT8AIm6h/EJeQyLELyRCv3mXKZiQqP9aG2/Y6TK/qjHmDPQfOTDKSM/
         rTfisaChVBSgLtKBXEaQuzcDsrjEZcEdFaacp+nr7Xauq+oOWhlukCzdhnfopoBO1KOX
         FBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747318050; x=1747922850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyb2P3N1Ro3oQLC9e8C9UsuT/J21sixODTw4O4Y61vY=;
        b=GJvBFna6UMzk/F6qvkolJliAk91iYacF39nl6voZU2x9pxTMweWvlWNp0a9/LWHYGz
         YvwlxpUGNawulddOj2+wlXdzbQjp0Ly2wUNFV0HV3YcZrafGYhjeIQNV6YBlpdG2oR/J
         EhgpW6vOz9m/MzL0qeMa0oERE24Ad3VQEQB8DSD5UNlH0iVenb/saWKOujvaAUZFiaoB
         QfV/Ouf/rHlOZ/5C9M+Q0NK9gZPtUsjo8pY9ACH/l0nhXgQ5g1w3EKlHi3MleiXVaqUM
         R9QRLADOc9v0wUw13YtAlmBjo/3HmMycWQXQg5Vywl0vIGUGeSepj5/t7TzHf5w4JGkG
         tIhQ==
X-Gm-Message-State: AOJu0YyKJZkzhk65RNgSHao0PrqH1OB+j31mu4r/oUJVpAa6OPJFkFYr
	TJ6b3i7wS/luHqTGZymConugHO7ROu0F/76o7hDwjWNGGd3RrGPB
X-Gm-Gg: ASbGncsvbfYWVx/z+Db3PW3Etzo4dbz5IMaTEEHIeqVt+y2mEzglAie5oCz/fm1lDxE
	n6XhCnrwA+VTXcb3pqZ+BAEx+BiQqdH3B9kcquqiZcPV/FDwX4SxUN12LOGZKlkPYA5ryvOEuZa
	w6PRn1po5GhZiN73aW+1vERZ6m27cF4v0xF/f+P9pwAazo1HtRBD2whZDb9mX5QM7danxK4+RYn
	GSlAkQR3WlEzoTViiFI6Akdhmbxw1yH4XUfyYFa+7pKWV/djznqnCYAcY75Plpv843znlSh7+yY
	xyoqNBHy/S1dDtgjccJbvLo7uLJwmAA9wS4D/OkOYln9F+n7yJo=
X-Google-Smtp-Source: AGHT+IG1pKAHWA1UHmNZ79jPJr59mH3aj/2AUChb7zNurHZx3tZNLDT+CO5agthHA6F2VmzlOlc8Pg==
X-Received: by 2002:a05:6512:6408:b0:549:c1e6:cbc9 with SMTP id 2adb3069b0e04-550dd003219mr972137e87.18.1747318049623;
        Thu, 15 May 2025 07:07:29 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d70e296sm10259434a12.75.2025.05.15.07.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:07:29 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 15 May 2025 16:07:25 +0200
Subject: [PATCH v2 1/4] refs: add function to translate errors to strings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-1-80cbaaa55d2e@gmail.com>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
In-Reply-To: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3714; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=1AgNKGGYm5w5kMuPq4pkiA9o3UtnvQFg4HVvP6CXEPg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgl9R+XX6M1PxYeTf86glB42lJdrTc1SmO1R
 R0slQWUYjQxSokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoJfUfAAoJED7VnySO
 Rox/5SEMAIUprw7RepLoSg+oFGJA83/qLp4grE387Gy6ctughCaoCeQWCL9EOlqMXORhdSY9oz8
 Ab6Fr64v85FmLB1VcgYj0oG/Z3QdKVeXjLtHS325+0T0/9WXMNsoPKtbbJxDl2VA9jwPByPNoSY
 lUCyyWHTkKOrwVtlVqkdFxFwg6u7AoPcBYQRNxUpL6P7ml5GmUOpkaLdBH6g83vZuHsFEkkzAvA
 kMJYDLhCNT4tSI0TUou0rTtmAYAVmVMjjLEZpdKsk57MmnVXj7rrsRKOKFpGFPkFx9d3LSouICk
 6CYaN/psITy0CDuxzaig5wMrpNio8TyVD39XcRHA8A47bgVBTDnpFChCo0Jp0eWGv38fUDKwM62
 LBSOQcSbT37sEgJeTXA5I6OeM/kA7Udmxf21h1F4OpXI0qNG8xup57i3nAvAUjTVvGk46cmYwwe
 bgR68UYtZUxyOsacRyvEfEMOT2qf340+46Y4vaBOfMzfdB9i2PTm5eXTQ+kl13INlWAymVs0am2
 0Y=
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

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c | 26 ++------------------------
 refs.c               | 30 ++++++++++++++++++++++++++++++
 refs.h               |  5 +++++
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2b1e336ba1..09b99143bf 100644
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
+	char *reason = ref_transaction_error_msg(err);
 
 	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
 		    new_oid ? oid_to_hex(new_oid) : new_target,
@@ -606,6 +583,7 @@ static void print_rejected_refs(const char *refname,
 		    reason);
 
 	fwrite(sb.buf, sb.len, 1, stdout);
+	free(reason);
 	strbuf_release(&sb);
 }
 
diff --git a/refs.c b/refs.c
index 6559db3789..4548fd8fcf 100644
--- a/refs.c
+++ b/refs.c
@@ -3314,3 +3314,33 @@ int ref_update_expects_existing_old_ref(struct ref_update *update)
 	return (update->flags & REF_HAVE_OLD) &&
 		(!is_null_oid(&update->old_oid) || update->old_target);
 }
+
+char *ref_transaction_error_msg(enum ref_transaction_error err)
+{
+	const char *reason = "";
+
+	switch (err) {
+	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
+		reason = "refname conflict";
+		break;
+	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
+		reason = "reference already exists";
+		break;
+	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
+		reason = "reference does not exist";
+		break;
+	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
+		reason = "incorrect old value provided";
+		break;
+	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
+		reason = "invalid new value provided";
+		break;
+	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
+		reason = "expected symref but found regular ref";
+		break;
+	default:
+		reason = "unkown failure";
+	}
+
+	return xstrdup(reason);
+}
diff --git a/refs.h b/refs.h
index 46a6008e07..a0b2e3c43d 100644
--- a/refs.h
+++ b/refs.h
@@ -907,6 +907,11 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
 					      ref_transaction_for_each_rejected_update_fn cb,
 					      void *cb_data);
 
+/*
+ * Translate errors to human readable error messages.
+ */
+char *ref_transaction_error_msg(enum ref_transaction_error err);
+
 /*
  * Free `*transaction` and all associated data.
  */

-- 
2.49.0

