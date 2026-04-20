Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099538238A
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679950; cv=none; b=eMoH/3ScnyYC+/5SMQpKu2Lf9tnMITP6lTM7mOyIiM4/JXJL13mnf2mMvUTUA1g6RGiFZ/pjboqXqzLxpxqB+jdswk21+DzERoboPvCWSTIvnYTx125KDx8EsOOM0ks0OZ/qjzwfjuDF4GRzAr5aquxUfETJfonbQm7ABw//tLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679950; c=relaxed/simple;
	bh=8CxP0AN2DAjej16e+6qZPIrBbbKoFFTs7beZAzVllSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=faw2e/VTRw0yEtQykUjkFPBgJlIhp8sN1Hl4ywtslwoKhD+hi8eOn/fwOLhDPe99NryzYJshgCcA0I8MY68lTAwgeaDomV/KKrSL4KWak1VSbIGxeGgsorPhoz4jgTFOlhHjlkej2uWQY+ko7VTfocYcla3BybENUatyv9UUUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSkrsTym; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSkrsTym"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43fea39e066so1983807f8f.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 03:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776679947; x=1777284747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zERe7nAWwUxNRqI2XzGDSTRsFzQ9quhaewrcThNV4PE=;
        b=kSkrsTymnFZzySpPsewjdhuVkpeEqHjtWTPW+CFmNrEEgc7lKpcZeqpXBce5uiGcvD
         ywaLj+zp7cwgjnrxToW4xbywpF/W1weL8zkLicaSlnuLdD1UXvUuNJSPzQIBUMsNMxgs
         Dpjt9hyHIWESzxV+VIFuqDZvobOEtiC6a6TH3GJCveLLkwE2GGSvmIy3FrOC2vK1FOsa
         RWS9X7yvMNB/CSWtRJLP7Eiq2MdH8KebCK8v5WaTXSuXOPPNAP4ZnBS4hh9KqojcuDL4
         nL/IV9SbaR6DleZ8paT4/Gl1Ue2K/d7L+7m2NOhd2mXB5TjPdrGRg9NZWz0aZDDmzE+o
         ZTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776679947; x=1777284747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zERe7nAWwUxNRqI2XzGDSTRsFzQ9quhaewrcThNV4PE=;
        b=ZIC92USpJQL5RQhZskNKqAogeVAnJJ5CmcgMjzM2NSk9KEgLk2BvMZCeOygz21+kun
         7NJg9v4mpJmx17FwnW7zI3VQvHDQStvzAPh62pBLhf+w4rYSfFTkQeCw1cJ8atyoB4uK
         wM4ltFOQ11Tvoa1HjywwFyNwJmRck0s9Dc2DNkhTs6KRuC+As2ICc0hHVLGDHwUjL90C
         7z60Zcja+3gzd8uw+1eyhChyH0pIf5QrynHBRHH442/rGAjln+fhLqPKOo7/Q+IenSdX
         WJ/YshkryMZopdUgMvm/dZl8ZtZfoaqrANlzcIs+Aq+CIKiwLUsr5HsODpwWQAZHAyBE
         DKvA==
X-Gm-Message-State: AOJu0YwHyKAs8VdeoSjy6jEJvq5P2tqYTOTK54D7V/susdaaTFCu/Nt/
	FJrgEhQkOlP2PrigWj26S43ukqh03Bm/VLWh+MLSLiUz0l4ZK7if3374BQmYIA==
X-Gm-Gg: AeBDiet6vY7HKBg5q8109Io54kBKn0I9uSX9r3hz38rXEhUWhex3XiZn1ksZAhL3Eo1
	O7b4yxFKaGV1+OnwZ8RoaPotlwMm4FePwLu19JK6JgAQtdCZNVNYgosGCYxTnx52gIzcGGaJU/g
	+BtFl3832fxLRK7jpSAzsc27Avd8OuJK9uGUaTnm/9xblJqgi5cDVdkD9lCybx1aNMDz4++98X2
	mGZc1G5Wkc2EozM6SUqGv8JTAeS3KhV76O3ltegTZ9BuGWI/Wn28GcutYXeqd99BKieEI2kcqzt
	qpnHwAH4Offdtp40I6ttGs9pauHLImV7b+xJXgYK8F2h+B+wiYJS4ZVeLfiSOwbP0p0mmtg3xOB
	qDMFXl8HmOfK+U85veBxFDP6SuIlWQuDuwUA9DizImIseCyVGhEMGkdN+5T+Oo7qXaRxFMGK7XT
	sch8+iDkiBhDgx2UC3BjlSL1vxFo9T/IMua8SJwj4=
X-Received: by 2002:a05:6000:4283:b0:43d:7b85:6c95 with SMTP id ffacd0b85a97d-43fe3e144d7mr19791744f8f.33.1776679946759;
        Mon, 20 Apr 2026 03:12:26 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:293:ab4d:327e:e6dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm25424997f8f.14.2026.04.20.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:12:26 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 20 Apr 2026 12:12:01 +0200
Subject: [PATCH 3/8] refs: return `ref_transaction_error` from
 `ref_transaction_update()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-refs-move-to-generic-layer-v1-3-513e354f376b@gmail.com>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3230; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=8CxP0AN2DAjej16e+6qZPIrBbbKoFFTs7beZAzVllSQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnl+/+6tlKI65Z5jlrh8AkrnOqac08RkCsL9
 rcUh78Hd3ZSj4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp5fv/AAoJED7VnySO
 Rox/zuMMAJ/NnQTOnZ0t7zZVX2UiLWYzyZ+vYhY2gvNG4skvy/1XV00fPEVRh7hIe/msWuIGPex
 K+7ESE7Lbbbzb8noCmSOzP1krTOtrY23AZanOJlKKQKli2ijmIa1KcodRsX0ThoAR257Z4uBHtE
 0KZqJTnll9DUhUkNOo+tHa55x5CSBP6wJ0QICQCI5/9kkesJ8KNWCdgRa73Xc7f2IiK5vVqmYkv
 WbJVd615k6cAkAsMBRBLD0jqzQMd6KElMEMsdkvtt0I3Agw1VHxEIdQcp5gEWr24VwTprd4Nx4+
 QlNWV0bH+CVEyUxaX7zcrWck+pyUH3f235V/ix6nCfKq56sI/+g3ZuGWMaqEhsHf2wZx+VG1CdB
 s+mhJM7Afmb5oMNL1XKmqH55em2quvr6iwksJuqVzchwPp1k5yOTgVGYWku3xYpMiaQ/kIMOZj3
 D3HIxXPjLAFBCATFrGYK+Q6Te3UeG6QP6dX/utXeg+zul4fYNDMW/hiNxNuUUrRWOtHh2aY2y35
 +w=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `ref_transaction_update()` function is used to add updates to a
given reference transactions. In the following commit, we'll add more
validation to this function. As such, it would be more beneficial if the
function returns specific error types, so callers can differentiate
between different errors.

To facilitate this, return `enum ref_transaction_error` from the
function and covert the existing '-1' returns to
'REF_TRANSACTION_ERROR_GENERIC'. Since this retains the existing
behavior, no changes are made to any of the callers but this sets the
necessary infrastructure for introduction of other errors.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 20 ++++++++++----------
 refs.h | 16 ++++++++--------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index aa66c6b28e..39fef1cca0 100644
--- a/refs.c
+++ b/refs.c
@@ -1383,25 +1383,25 @@ static int transaction_refname_valid(const char *refname,
 	return 1;
 }
 
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const struct object_id *new_oid,
-			   const struct object_id *old_oid,
-			   const char *new_target,
-			   const char *old_target,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err)
+enum ref_transaction_error ref_transaction_update(struct ref_transaction *transaction,
+						  const char *refname,
+						  const struct object_id *new_oid,
+						  const struct object_id *old_oid,
+						  const char *new_target,
+						  const char *old_target,
+						  unsigned int flags, const char *msg,
+						  struct strbuf *err)
 {
 	assert(err);
 
 	if ((flags & REF_FORCE_CREATE_REFLOG) &&
 	    (flags & REF_SKIP_CREATE_REFLOG)) {
 		strbuf_addstr(err, _("refusing to force and skip creation of reflog"));
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 	}
 
 	if (!transaction_refname_valid(refname, new_oid, flags, err))
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
diff --git a/refs.h b/refs.h
index d65de6ab5f..71d5c186d0 100644
--- a/refs.h
+++ b/refs.h
@@ -905,14 +905,14 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
  * See the above comment "Reference transaction updates" for more
  * information.
  */
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const struct object_id *new_oid,
-			   const struct object_id *old_oid,
-			   const char *new_target,
-			   const char *old_target,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err);
+enum ref_transaction_error ref_transaction_update(struct ref_transaction *transaction,
+						  const char *refname,
+						  const struct object_id *new_oid,
+						  const struct object_id *old_oid,
+						  const char *new_target,
+						  const char *old_target,
+						  unsigned int flags, const char *msg,
+						  struct strbuf *err);
 
 /*
  * Similar to `ref_transaction_update`, but this function is only for adding

-- 
2.53.GIT

