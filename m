Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8921A2C0E
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913826; cv=none; b=He6rENwyPGwzC5KzXpxVGYnUdXzFtxwcGevkysafZd8bOYPXY+yWdWByMNy5vpOeSJEpY9j4YrGxy6H2UVum8hOBfbjL1fky+J4Kub0CqEbW6cAr3YMUviG+mBrHe5zEt+PJ7jLlHRs2pXvDKlo1ApY8EET20/Yi7AgjP5rwiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913826; c=relaxed/simple;
	bh=FPEtb933i/ph+3B1q6fak6jB9o9O6rmyEjnVW9FqYXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SP9ML4JuKS6y35P/0wlWCRcxZIi60evPf/CAClNo0zZMavjy+CR15r+V/Mju8p+O5Clbc1jK3wPkdvprrRYP6B84FHevJztAioJg96JzjKynhhaqMehEMOSah9YzNWbEJb1m/aDGqAZORkk93zq3RmroFk+V2kGh+VCDvOeBFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Adx2v8T0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adx2v8T0"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f0c4275a1so26933085ad.2
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 23:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738913824; x=1739518624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9dvGWvmJ9Hhk4pAGFZSmGw3UkklUfmgnMIjLCXPLIs=;
        b=Adx2v8T07IAZ7bc9y0U0876jASDxjEcEq2pTR2KK6nzWI6NG3SZ10KvA3XgqFhEQV7
         8e73vFg6s+tT/5/sYO6uckEzs7L9RuTCrIWR70ZHPmp1SHai74jdAIJdvCCx4aJ1lp6h
         u8G5cnmUlpsMqu86wnoW/McIURLY+ocm7wJgUdY4YTkbuLfupHKWmportkaTsfHe31kg
         s/GW9z/fDc58/6KV6JXrtmvW2SjJvg6x7pqHfE7G4mNqLXZkiaNRgxxIeEJsU7qTMRUs
         aX7mCEfK1G7iXjC5BUpCSBYlBLHtK8GgBPvFHGx23DhQwgg1xGqv5lUwKj0PXjhsKj+e
         iARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913824; x=1739518624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9dvGWvmJ9Hhk4pAGFZSmGw3UkklUfmgnMIjLCXPLIs=;
        b=h15aiuaNuWyB9UPEWtHRgY9jmF7f+GmVGSBD/8jzdiRurF88124VloNNBkXt9uwPse
         EQOe09OqFL8L7UYnKUEJDkPBdMkRIFSKcuRGMsCKx/UeRxlZdh1pU/BNXgfGdVN7SHi/
         d5q/FpiH5Ktxc8EeG8i6SDOweDz7jk0TQ2T8OEPOa65GkAcIWye5RzTa9HsR5YMY75k/
         dNcnfPOceWA6CZyd65rr9oLLv1Vvs1MStv5IKyAMDCrs16kn0X0FLkR0NPGs8anzVyQ5
         vfeF5rcCAzfXatQpX5HAJIwrZ6WZTjQ7HiXK2B+IuoElwdPdUF6YyWm3pCEiY43tnj/f
         wrrw==
X-Gm-Message-State: AOJu0YzH6ve1olz5Vdwb/uABMQLiM99r+qWK2shdGHYitMqwbgc2VykP
	37FDbfgHT9FxmqTUQgy7Po8GI2GvWpCfG8wonRI21aSdlq/fN/wVu5j20Ip3
X-Gm-Gg: ASbGncu51SkuA67ZXdE6XfJcPfFwi5zzcjNkjsI8x87Dh8yH7QCUepf8SsXtKCExppM
	72Ms54GXKG/HA/sHRj7/MFmwuAMKCUqI7SxbyAh8KF7Sp/jnEzSuZ7TDkXvrckxHQxtmRCyq8oN
	GxQC1JG21+E0IMvEtyF1dF21/TlWHaQdHk9+IhBw5cXJpzIafQdm2R9a9KgDaBVQYff550sG68E
	d+ALG9YmwaBjTgheT4PlbGIk6digQ7IEzwY5gnwO9Bfte2dujqsGAd/aGhfD+T9xRBf5g/TWM91
	BGu3jOtLLsRfOJIsp96llA==
X-Google-Smtp-Source: AGHT+IE7brL3e0Jafb/WwGom6fHJeNarcoOdHn0/p5HLU88+tjrqtXyfsSpNnDED3sMCgMPgInNPYA==
X-Received: by 2002:a05:6a20:9d8f:b0:1e1:b1bb:87a0 with SMTP id adf61e73a8af0-1ee03b12926mr5487509637.34.1738913824077;
        Thu, 06 Feb 2025 23:37:04 -0800 (PST)
Received: from [127.0.0.2] ([2401:4900:33b7:4cb0:4dd3:85f0:5c4b:b677])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aee79casm2115063a12.44.2025.02.06.23.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:37:03 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 07 Feb 2025 08:34:36 +0100
Subject: [PATCH 1/6] refs/files: remove duplicate check in
 `split_symref_update()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-245-partially-atomic-ref-updates-v1-1-e6a3690ff23a@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3208; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=FPEtb933i/ph+3B1q6fak6jB9o9O6rmyEjnVW9FqYXQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeluBqKIFiECuMa6u9Yv0S4ELFPekvn0TXk0
 zEXEK+M3Dh7NokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnpbgaAAoJED7VnySO
 Rox/ln0L/0AayNSEXNy2VP8g0B+L/nC3bUvSDohorlOWxACKX5D9m9cs3IMAtAUu4o40nhCoWsG
 1eK4pAC+JHlvGYEjyy3mSlHQnRPAfz1ve9ijwgCU9v3cebdF2x+/0LvZHKkHcX2f8RmlYZhKpB9
 3tQxe0PDYbXPcsyXImcPa4gle/aPJj4t6qWNyUOgTi8d+zfTTEV1O8cqiJEFft3bdx113xR6CLe
 +z5QgrtKtjwZep+cKqVd5+vvV9s3+C5TWDy/3QzGlIZP3mPhHWv6FJ1aiDn6OTqe8fsjX84nkSf
 oAgPADkVO0xI2lght7YcEHrkYgmxmkbh36zwWvTsOWFskzMSVSd0hDKGy7mxAQ9eSKlvTvZ3q+e
 1NYkNiHTsNN3HI/OdoXSzVw0kpEV0XBbPpCsvfi7qHB08eAs+oWGt1JkDQP0FaEAwNs7DrBDlya
 C6egIwbo50QWxNsQ7V4WSnGONl3Ie7Rt6fdZ+mUv3ErnYgGtOJrYrsaazc3p+J/BeF/J6P+O6t7
 U0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In split_symref_update(), there were two redundant checks:
   - At the start: checking if refname exists in `affected_refnames`.
   - After adding refname: checking if the item added to
     `affected_refnames` contains the util field.

Remove the second check since the first one already prevents duplicate
refnames from being added to the transaction updates.

Since this is the only place that utilizes the `item->util` value, avoid
setting the value in the first place and cleanup code around it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 29f08dced40418eb815072c6335e0c3d1a45c7d8..c6a3f6d6261a894e1c294bb1329fdf8079a39eb4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2387,7 +2387,6 @@ static int split_head_update(struct ref_update *update,
 			     struct string_list *affected_refnames,
 			     struct strbuf *err)
 {
-	struct string_list_item *item;
 	struct ref_update *new_update;
 
 	if ((update->flags & REF_LOG_ONLY) ||
@@ -2426,8 +2425,7 @@ static int split_head_update(struct ref_update *update,
 	 */
 	if (strcmp(new_update->refname, "HEAD"))
 		BUG("%s unexpectedly not 'HEAD'", new_update->refname);
-	item = string_list_insert(affected_refnames, new_update->refname);
-	item->util = new_update;
+	string_list_insert(affected_refnames, new_update->refname);
 
 	return 0;
 }
@@ -2446,7 +2444,6 @@ static int split_symref_update(struct ref_update *update,
 			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
-	struct string_list_item *item;
 	struct ref_update *new_update;
 	unsigned int new_flags;
 
@@ -2501,11 +2498,7 @@ static int split_symref_update(struct ref_update *update,
 	 * be valid as long as affected_refnames is in use, and NOT
 	 * referent, which might soon be freed by our caller.
 	 */
-	item = string_list_insert(affected_refnames, new_update->refname);
-	if (item->util)
-		BUG("%s unexpectedly found in affected_refnames",
-		    new_update->refname);
-	item->util = new_update;
+	string_list_insert(affected_refnames, new_update->refname);
 
 	return 0;
 }
@@ -2837,7 +2830,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
-		struct string_list_item *item;
 
 		if ((update->flags & REF_IS_PRUNING) &&
 		    !(update->flags & REF_NO_DEREF))
@@ -2846,13 +2838,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		if (update->flags & REF_LOG_ONLY)
 			continue;
 
-		item = string_list_append(&affected_refnames, update->refname);
-		/*
-		 * We store a pointer to update in item->util, but at
-		 * the moment we never use the value of this field
-		 * except to check whether it is non-NULL.
-		 */
-		item->util = update;
+		string_list_append(&affected_refnames, update->refname);
 	}
 	string_list_sort(&affected_refnames);
 	if (ref_update_reject_duplicates(&affected_refnames, err)) {

-- 
2.47.0

