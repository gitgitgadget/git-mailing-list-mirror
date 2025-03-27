Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66120FAB5
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074015; cv=none; b=JcJHdENNOOt9ID/5uZmUzu+nh2lKL7uvtKCCWQjSEg+LBEksHGJAFaWpVs49tQSzxtbuN3F+J1gK975h7Hjkkmu5pEDIgj3mtXJ/NA9SnAPiRRBff6jpaLQD2TCyW7Xkbv31kSg1C6l5oAoYTt/jJGbBpxJLtez6FBvnz88efD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074015; c=relaxed/simple;
	bh=kZ70MrCGUroWDhuT1VddEBHL0jAvn9zT8Ss5CAhni+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VEJV+532/mfpOGYD025mevFzvk1s3dm6GGWV42wPtx1clOX9E0nOc+J3PWDPDNhp1aSfKaM+i+3jcrDMVYaVw+xhkzcB17EKPzagH3xqLOVBkV0e/Iuck8QAEvCnlHalWz0V35ZdKS2G1qE0AMUB2ehaZZRB6HvdG6COcszMZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt6uh8YU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt6uh8YU"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso157959866b.1
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743074012; x=1743678812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJGJOGebafCyIR03LL6CzEWPuA/w+J7tebiTp9njyX8=;
        b=jt6uh8YUKEFNlQgXi1Re5KpLFEkr7NotAfK9oWX6qeLRzWRnyE+hJ+LIQmDVOQ/sPM
         8oVgXtQR66CHtnh5UaeUZpAKTE5JQHAohc+SwQze4xp2heUAIN08rSByS6pkdJmx2TpB
         /guVpMTKeHpA0eHBPWwm6OuMvH8EE2D+G/CnHVqNfZdUqx2hkn/VKr33mkR1gUy8iGKu
         evB6Y66OoIkoDXXJazIszfSUdDbKbarO6WTV/NHisCG6MbKqyQ9pS+nkh+eH+GP7pPCK
         yQhMk5xVHJhDlA8ZSm5hq8Zq1+3fzE3jiMRcttjNIhGdqzyc+4e81FgHG8UFPLcRVPmE
         4HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743074012; x=1743678812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJGJOGebafCyIR03LL6CzEWPuA/w+J7tebiTp9njyX8=;
        b=TSmJ/clFX2uLjujkqlXChzkHcEwK5Acgf+m0IxXXGNzIAhTLZbrKuew26VbsXAdBFD
         t+kB/oinJSKnI8ogUK3iydiUs0U4dBCe1hsH/xje3PzqlY89P/kI2fTgL+bkJANb3p49
         rVzN14NkLqu796ynHFi58o9BergR2kYpsodEW7CKTHNulyl09oadXQs4YxcT62laHoia
         uQ3R3v+lxyMt2R403S5WKjdumOPezCLUcQcwLxrGj4cl+RgNFnOdagUrEQIi65rT9QqH
         ZDk2TMb33gK9xcbgvES09bTNA4kyTJ3i4ADusv7F8Q7PhTyu2EA2i9faeVRVD/nbJLc/
         T52A==
X-Gm-Message-State: AOJu0YzX28YfUkAgRRyFjxsItlctO7PGgI0HgDJtjwPtQDmR+ia1i348
	RvBGplYruX7mbmK9pM/rMy7GUTX5Dh2DWrDQrPf1ZpxoVMJc3lqT
X-Gm-Gg: ASbGncvEJGYLdLDMCt0iveC9VNZtlXgvG3tXyqoo8lrqJKV7Bdb5vbBis+iKgWHccrG
	cjPY0zTZ/PQIaKU0IKnbfiyzTvq8RUxO7KVB2RXm1XtydnsA9C70kxF7cSuAqjOCVN0WoXOm4RL
	KJSOYg3RzIP8Xbt4L4/w8c1oBCCdrla6V2AzJOhcIr05JX1V83gKJvGb/gAqq0wnOcxUNifVJ6c
	LW+7pP6GihlSqCmyq9jjDUBYK9wfoYBpy2YEccqzPrw8gTS3QWqnKL4o87K1k8ACgKj+8MwxZp4
	R5CoSQz3rXnS8EJopbuQmj38k41oc1tf5FTV5hULO0TJ8Kg=
X-Google-Smtp-Source: AGHT+IED6/D7TrDPzzU2JsBJb2IpLJo/hTV32GjvkNN4yZRxOehY0d87n6/U4CUmfBhTXJpzxGyeOg==
X-Received: by 2002:a17:907:3f16:b0:ac4:3d0:8bca with SMTP id a640c23a62f3a-ac6f8ba997amr352470266b.29.1743074011591;
        Thu, 27 Mar 2025 04:13:31 -0700 (PDT)
Received: from [127.0.0.2] ([80.242.170.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e56dsm1195866866b.37.2025.03.27.04.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:13:31 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 27 Mar 2025 12:13:25 +0100
Subject: [PATCH v5 1/8] refs/files: remove redundant check in
 split_symref_update()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-245-partially-atomic-ref-updates-v5-1-4db2a3e34404@gmail.com>
References: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
In-Reply-To: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, phillip.wood123@gmail.com, gitster@pobox.com, 
 ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3413; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=kZ70MrCGUroWDhuT1VddEBHL0jAvn9zT8Ss5CAhni+A=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGflMthRHMF/JstA8gcrJC/diTx6jxb8/nFHq
 jb4a+ajrA+jLokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn5TLYAAoJED7VnySO
 Rox/pVEMAJoagBm76gfi7ZEMtFgKTSZUE91/CF2f9PYeY8tkCSATfUD8k7bntGI38T5u/S0hCfN
 FLUS0mZ8PbMqLoKstCWsCfd53bRHtJSHkD3NMSleUawD32dEXWqxw9PWP9/QqwxUiModF6sloVN
 HjtrPItodfjhESZSwlTv12xoDE+qyRKTxZzE86LGr8HNeAOh2HJ+9Aq1USSaax4oOjLzDnyorDv
 ljsNKl5q6LqgRas14lCe5Upe4LJzYPMaj8+ek1O39Vwf3TNBu51joF85j6yL2IyOzEUpTHq8iKE
 1QHB6GunnfilTj3wflr90gUqqVTYxWzDNyBHmDdOFUw7O9nt3GNwqO1YRjd54hzhUh3zPNjU4+w
 n/NACktuoYZw2nfOx2h8g59wRymLAXytl4z4PvRFOR3008u0NqHfqb/TSXF3pl+ejBbotHf7DvF
 t42L0t91mK7JjQAktRdlCNS5wl4400FYJ3AE2gYDFUvEDtScAl+tgk3DRJAjOBC9w4lyksMx5v5
 n4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In `split_symref_update()`, there were two checks for duplicate
refnames:

  - At the start, `string_list_has_string()` ensures the refname is not
    already in `affected_refnames`, preventing duplicates from being
    added.

  - After adding the refname, another check verifies whether the newly
    inserted item has a `util` value.

The second check is unnecessary because the first one guarantees that
`string_list_insert()` will never encounter a preexisting entry.

The `item->util` field is assigned to validate that a rename doesn't
already exist in the list. The validation is done after the first check.
As this check is removed, clean up the validation and the assignment of
this field in `split_head_update()` and `files_transaction_prepare()`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ff54a4bb7e..15559a09c5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2382,7 +2382,6 @@ static int split_head_update(struct ref_update *update,
 			     struct string_list *affected_refnames,
 			     struct strbuf *err)
 {
-	struct string_list_item *item;
 	struct ref_update *new_update;
 
 	if ((update->flags & REF_LOG_ONLY) ||
@@ -2421,8 +2420,7 @@ static int split_head_update(struct ref_update *update,
 	 */
 	if (strcmp(new_update->refname, "HEAD"))
 		BUG("%s unexpectedly not 'HEAD'", new_update->refname);
-	item = string_list_insert(affected_refnames, new_update->refname);
-	item->util = new_update;
+	string_list_insert(affected_refnames, new_update->refname);
 
 	return 0;
 }
@@ -2441,7 +2439,6 @@ static int split_symref_update(struct ref_update *update,
 			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
-	struct string_list_item *item;
 	struct ref_update *new_update;
 	unsigned int new_flags;
 
@@ -2496,11 +2493,7 @@ static int split_symref_update(struct ref_update *update,
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
@@ -2834,7 +2827,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
-		struct string_list_item *item;
 
 		if ((update->flags & REF_IS_PRUNING) &&
 		    !(update->flags & REF_NO_DEREF))
@@ -2843,13 +2835,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
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
2.48.1

