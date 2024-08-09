Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFDD193082
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202028; cv=none; b=FqA3C7EYd9glEs4D4RWnAyp52Yu55nJsUdrqJEnKakNJ6h1DHCH6z4Df1EdhsQ2e7nukLhwIn3TgNCDcrY+gpcAWTd3IMkygo49+7VUbycb8q7zAKJyIdPSntaTeBx/GgmatRKEPJMqgnFXaLaT+naFvyrxNxkMNGYSTG1QBYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202028; c=relaxed/simple;
	bh=W7USWDooWkcEvUhlGe44fC9J7Hisd3kdMpQXKM6JAOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNtyoCtwvAMiKPYisooLRlt0J6DcD6XULd0/VJg1wUChJGfDaSrMXbS5HHM92jVKt+MLRhCa70ZTumMSQX9S2rYN8oF6MQLJNbT4KsB7trTAXY0KxMlqUWN6EGDmJZ3WFFV7GDGGRpRC5sNgoI94HFTRb8JXF9adZOH58OqH3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMNdxC44; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMNdxC44"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db157d3bb9so1298825b6e.2
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723202025; x=1723806825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7OgYFBtkBdCtX7syiausLF4DmD8poKJ5EHK6kAOs/8=;
        b=BMNdxC44FfoVQ/BNiFxZSTwYDKYBbpQASfsJUGMkJlS6230l7Pcc0oDMakl6En9Uq7
         TKcERazvDTlIdKGiaNW+841IdN96krCiqYADhc7d9aWpzYkiVQnIaJVFrL0KESOFJ89/
         vqm6vaKBSNyLyOF4C9iWnIIc24xzWwoJkPUOaTiwZXxJcZ200krx3FdNI2Pj7CjW+cSr
         Ar0bIgG5T74LneRwz970tmhe+xO5gxzFoQ+FU+vDt0ZTporZtPG9pImf7IFL9+DT2zZx
         X8lNLeju0hyublCky2yLHX9RUxSIUK6k5GjPaE9+CmfmS64cS1IR0vgD+7FDq2nZh8Xk
         s54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723202025; x=1723806825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7OgYFBtkBdCtX7syiausLF4DmD8poKJ5EHK6kAOs/8=;
        b=BazBoaVDhnBPrlZuFmfTvM35c0wCvfhtTewqizrUP0/9YeczrCDK2nQ3QJqoSaDLVR
         tczHpmiDDg2Ynlm71VsXSpg0+T3ZmkZvegHPPNcGn5jgJWYAvTG+KJzzzgdPYsxd7dBI
         hjB5a7L86DINxSQLgA6c92zkm6DmheCxdgVigLUULklAwdptjNWfzv87TsZZQBr1DSdX
         8WJ4z0ei+Pjw/9k5h0McayqvWZNmYab796KgHS/rqiP6NGTAemEA4k1w5p91mdzZrQqN
         BmY9g2kYENuPo+YvUkCGf9rmaSHgCY/F7vvO9v1x9J1UYrgCOfeLCYNxgsy1aAidomO9
         oM+w==
X-Gm-Message-State: AOJu0YxF/PtruWYOGzfjxsqWsRg3jZrpeI93o0HIlhTSiZlEHfTd0LV6
	ExiSPLgwGqPDnqwPEjSYSnlvBvGyud4kfc3eNibODa1YUWtRaIc2us8oIe9x
X-Google-Smtp-Source: AGHT+IES7AD4MyhBlpSeReJ0JXNLNqntmeSyFzIyKQ2th2IoUmoa4aeX+QDNB052WScyyqWMii5PMQ==
X-Received: by 2002:a05:6808:3c91:b0:3dc:4223:898a with SMTP id 5614622812f47-3dc42238d0fmr1003440b6e.14.1723202025244;
        Fri, 09 Aug 2024 04:13:45 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.199])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710cb2e74d1sm2490377b3a.171.2024.08.09.04.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:13:44 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/4] t-reftable-readwrite: use free_names() instead of a for loop
Date: Fri,  9 Aug 2024 16:35:42 +0530
Message-ID: <20240809111312.4401-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240809111312.4401-1-chandrapratap3519@gmail.com>
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
 <20240809111312.4401-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_names() as defined by reftable/basics.{c,h} frees a NULL
terminated array of malloced strings along with the array itself.
Use this function instead of a for loop to free such an array.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-readwrite.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 235e3d94c7..e90f2bf9de 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -413,7 +413,6 @@ static void t_table_read_api(void)
 	struct reftable_reader rd = { 0 };
 	struct reftable_block_source source = { 0 };
 	int err;
-	int i;
 	struct reftable_log_record log = { 0 };
 	struct reftable_iterator it = { 0 };
 
@@ -432,10 +431,8 @@ static void t_table_read_api(void)
 	check_int(err, ==, REFTABLE_API_ERROR);
 
 	strbuf_release(&buf);
-	for (i = 0; i < N; i++)
-		reftable_free(names[i]);
+	free_names(names);
 	reftable_iterator_destroy(&it);
-	reftable_free(names);
 	reader_close(&rd);
 	strbuf_release(&buf);
 }
@@ -498,9 +495,7 @@ static void t_table_read_write_seek(int index, int hash_id)
 	reftable_iterator_destroy(&it);
 
 	strbuf_release(&buf);
-	for (i = 0; i < N; i++)
-		reftable_free(names[i]);
-	reftable_free(names);
+	free_names(names);
 	reader_close(&rd);
 }
 
-- 
2.45.GIT

