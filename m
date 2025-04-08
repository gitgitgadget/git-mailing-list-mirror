Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6F2620E8
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102291; cv=none; b=eCEE68W1Yrl3pYb+NUQGqB4Z7ppmMbC44gANHRhEej5hBSwzrpTXpkuZ00IPGSHMAXZIptGDdVdOVOBAJfn94c/IS+VstJ3EbGGHB/UuW5Px9uICZcpMdFSOE7dd6KtScMJNmiwV7QSyHBTHQzm+Rasl870VLOxB1XNd8jxwIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102291; c=relaxed/simple;
	bh=2cfX9aP+j1ZytgQFyn8pGqNAfzdJwUY1Llo/3CmvQIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUD+9/EabYPeyFYxl+6yeR4vSc0qLCBw2cKbeeD/ou0GkBYAfnaRRHNjeWWyKl2vxpR19Gj0FYu/CI9L/K8vZfozQOGHb70/PMo3YGiBcr19lfeS08pjU7FtJhWDZJuTaNc48zAsanIqO2X33ONDpJt3BtyQXy0tBwZqvkcu8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0iChqs+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0iChqs+"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so954229766b.1
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102288; x=1744707088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3TaWYSNQOQESj7gobcQEnVyquRZnvJz+joj2sp1964=;
        b=N0iChqs+128ixtKnCrSroBuXEjTxdaI57LT04J8D25Prdmj0od1Ld65UAFTd+ddNaZ
         vqlbhiwGEYBA8Rwwg0xkcYYCSwypP3BcyDXnQBH6NCAu1qDRfOZWBzmCaGUYOgWkVZ86
         0kzRK5/MCeFOX+z97azUi3K+0F/PlrcvkNxM55PRPfi0ReDVqTURmdvvO6ZbjyoHbScp
         gO9SFupkoqZV4KbSJCM1t1h7hW5fnqZv7s1s5f9vXCUVO4EJxYOTjyMarkmOBSzLod+T
         sZz0df2uZnMDz8p5x9IkRbt/wdU/VyUgrvf/5pRHN7CBsrfkpwiEMo3AGhUJV6py/QKe
         CSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102288; x=1744707088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3TaWYSNQOQESj7gobcQEnVyquRZnvJz+joj2sp1964=;
        b=a/zYAIkoija07B5h6a4CkhCTnnzFm4plnfMGsnUqzDOSGjoW5Asw9LKsA0qCOkBT7/
         StoCt8tjf02yi65foL/Vyh1t+mpL5YOGB9/yQuaHRS4Q0OEttikRchctcfsIvcGs1i+H
         pF/rLocwGAKCDL9vZ6++8GlmRZ8G9d2vZdOZt21XOv47yhHsgnmGy6Ativy2GMyMUVT9
         IAE7mbrwJbDGpFR9JODBBybpXl5uZbOWnX7Nr03ZwpHYrI7j7IUPhotxRKpquWFiN8cK
         LPSxoczQaWQ4iNdX6BOAxYyxJXtuGoSTV1udAWvNFmg5w4enk/VOJM7MCB8eYi20kckd
         O0jQ==
X-Gm-Message-State: AOJu0Yx4Si0BYlEufD70PA4/LIM3VcpqVBbdsjmfykNNSJwkYt+cmTiy
	e4v6odfMP1EC5GzpQ6nOXPdInrMu5YJRFQlcvoXzDIuyWH9ynM+V
X-Gm-Gg: ASbGncvsC4fzKlOUu87t5GV6vDiuaTvWxGPPFPjJ6EKiXpJ3DOxRMfQDkkIm6MHzCK3
	y/72jAAuFAMzKZP2qKa+FFBk58oUBlG8XDV/C9X7+y+TwE1VhLyebGXfMxgTvpvRp6HchEmsAiy
	+YWmMaTm5FXLl1HolupA68jJJLeUUqS28/mLlH7mjohRsPB+8twqolFdaIpBgIyDW8JTd9vMBqd
	LIoMsKqRjUe8kBlwazyREvO+3B4E2HnRuI1IxtA0lXY0QOzbpOxzsoZasF1FihNqT2pEmbe4DJZ
	gjzbocluGMSxSltWrdzZ0XNggqmyJ2/xgm9DTlpuAXtfaksKvn+EcNmYSg==
X-Google-Smtp-Source: AGHT+IFeAZygcu/6WRqnQXUj6TlJ12vJRRrVCiSeimUP3x1aUK8tLPbCftRwa7KXMDobNRZqJAJNGw==
X-Received: by 2002:a17:907:9615:b0:ac8:1cf7:7aa7 with SMTP id a640c23a62f3a-ac81cf77b6dmr158730366b.15.1744102287739;
        Tue, 08 Apr 2025 01:51:27 -0700 (PDT)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c804sm890801366b.15.2025.04.08.01.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:51:27 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	ps@pks.im,
	jn.avila@free.fr,
	gitster@pobox.com
Subject: [PATCH v6 3/8] refs/files: remove duplicate duplicates check
Date: Tue,  8 Apr 2025 10:51:07 +0200
Message-ID: <20250408085120.614893-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408085120.614893-1-karthik.188@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250408085120.614893-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Within the files reference backend's transaction's 'finish' phase, a
verification step is currently performed wherein the refnames list is
sorted and examined for multiple updates targeting the same refname.

It has been observed that this verification is redundant, as an
identical check is already executed during the transaction's 'prepare'
stage. Since the refnames list remains unmodified following the
'prepare' stage, this secondary verification can be safely eliminated.

The duplicate check has been removed accordingly, and the
`ref_update_reject_duplicates()` function has been marked as static, as
its usage is now confined to 'refs.c'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               | 9 +++++++--
 refs/files-backend.c | 6 ------
 refs/refs-internal.h | 8 --------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 504bf2063e..61bed9672a 100644
--- a/refs.c
+++ b/refs.c
@@ -2303,8 +2303,13 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 	return ret;
 }
 
-int ref_update_reject_duplicates(struct string_list *refnames,
-				 struct strbuf *err)
+/*
+ * Write an error to `err` and return a nonzero value iff the same
+ * refname appears multiple times in `refnames`. `refnames` must be
+ * sorted on entry to this function.
+ */
+static int ref_update_reject_duplicates(struct string_list *refnames,
+					struct strbuf *err)
 {
 	size_t i, n = refnames->nr;
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 58f62ea8a3..ea023a59fc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3016,12 +3016,6 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	if (transaction->state != REF_TRANSACTION_PREPARED)
 		BUG("commit called for transaction that is not prepared");
 
-	string_list_sort(&transaction->refnames);
-	if (ref_update_reject_duplicates(&transaction->refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
-
 	/*
 	 * It's really undefined to call this function in an active
 	 * repository or when there are existing references: we are
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 92db793026..6d3770d0cc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -142,14 +142,6 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);
 
-/*
- * Write an error to `err` and return a nonzero value iff the same
- * refname appears multiple times in `refnames`. `refnames` must be
- * sorted on entry to this function.
- */
-int ref_update_reject_duplicates(struct string_list *refnames,
-				 struct strbuf *err);
-
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify
-- 
2.48.1

