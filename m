Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE97C39C645
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674990; cv=none; b=RNOv+NQ+QrbUkBRM28JzU7g/pqk+1toyc52Cq5/B6mVl3LebVi/o9EmRIsMXNxaHs98xh+VcIyCY7/uqa4NJmCm23xct9NOSCscvg+Gzvz8VgRXJ56QYeE6K2R0dgTRFmAeHNmgXB4fcTXhcPX12y4YzJjx6onuRdkIdcgJ+t+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674990; c=relaxed/simple;
	bh=lZp879SiaT9sINxhzUXJea2Bu9pt61t/ccnvW71TYGY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=klRpYbQQkJjuMTFi0TV+B6nAAcSip+zSy+qR6K5JB0Q+fq1Zw3uE/7dgENHAPQP4EtIhSofKug1bKV+9zL+mg/YIDP8zL7Z/krT/zvNWSuvYCVTz3BYiw+fD4UGZrnCzSKeG5K59GhKdVrYNY2KRqltJuQSe7RHejRwjQebmMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqNG5p5X; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqNG5p5X"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50905b779dfso58167811cf.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674987; x=1774279787; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUxiXGaH5X3UG6nN4y8t4taFVcTd5r+hDcMBEPXzQFY=;
        b=RqNG5p5XQaSvQNIT3akT9XTYfYDLqznNSm3v1zOIbDstmAlgzOKPbgGTPWx1bhOAal
         yKoo5KxraLAxa4jk/UAl25I8+NQuIF3vZZqNtBb1kng0Z/IvCjMa8ovX7K7gBlf9+BSE
         WnFXmeAfhoEFyBXoDIS44aqR4dS3umOzgeSs2kUUl0FudMFVpm304AAdVZYX3z+sElpa
         Ttk6lMZFN13R4yokrbJUbOM0zcS+xSOatkrnFqY+r1z/iU0y2eWLVVksBywuclCXpeAk
         ZXNtu+xKjD3zmg01ewXGbJLGgs1CbkLIgkzEiN+bQIOOJ0sKhVFRIzPHK8ZcODdsG1Qs
         cOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674987; x=1774279787;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUxiXGaH5X3UG6nN4y8t4taFVcTd5r+hDcMBEPXzQFY=;
        b=TdI9OeEZKqbRyL+wNeSRcZiWf11cIvBPxrdMW2oirfbGMNHF7YFGTOURzckFUcET5P
         XEF2tB4RS9IsereH3oi/XHessCFAaZbG4i1ScVTqjZLvHo2aVZizDiLEJloVVfE4PMvF
         DRuNyheDynw5Xci2zHMF3OYdKmpq7MKg7tNlFNKxl8h2c3auIBEaSlX+/h2WWp0JL4WS
         TYO/pPSVaXgwek4vuyBr+P+KZZS2IO6i6G8vI2/qMvUSkBqYDns7kZhGP12OpAc0kci9
         Y8uil7OfSAZUjEd4sX58d/U8VRF2bS43IC03mdvDB6bVffjk2s5HuM9CSeubUbPMr2nt
         1Iiw==
X-Gm-Message-State: AOJu0YyjvfHvOvfdOigzkLasVzIGzkDs30ELOx4R6M4bp32FuHYvsF0s
	e2gb/VNEoIg6hi+1YpHu4QY1VG5QZb5k9ugweMKEahOdZqfeb1sjtEZVodUP1g==
X-Gm-Gg: ATEYQzyddQAZRsgb5EyDx78r4QpVlAQGmAVw3G4h+f0WwtXgbpHKAnooGpfFeVOfQbn
	GWKYaMY3KHrRZvB2EMX3snOLMU2/wzJBGKMzE1ynU5Y6eHrzvoAbKNnsuE3WMqlCZ4OthJsc7+J
	g8RuDCcVk3bCw4tX4ZKBXaret+TQtCIUMA2gZsgMEn4R1dalTTa9onF3fxBIjo5bgJIRtq7sCK7
	xuSJ9alci7CBPVuYXBjbEn91RBGpiU3Vx41yXjxywrLHlSZ650o4Mesyx4C0KTPbc6B8QAjhGtJ
	EVxjDIuYg584aZM+tJup4lvgDA5aTJHo0AS1rYJQdhHx+L13y1mRw2KdHMNGMPVnKFe6M/Omfr5
	ObC8kE7QIFoepMzxRqTegLXRQaRrNBTTHDbviGHu11TC47BB8lDqpYqNCoIVhKYORHpKdGEQCWr
	XUfjL4FBBr9gFatiUg7tjWcSkn
X-Received: by 2002:a05:622a:1a87:b0:509:4091:affe with SMTP id d75a77b69052e-50957e28510mr188600311cf.69.1773674986614;
        Mon, 16 Mar 2026 08:29:46 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.99.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a0ea844sm146431041cf.17.2026.03.16.08.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:29:45 -0700 (PDT)
Message-Id: <e6877b30d5dddce5720a15d724d7b381a5595915.1773674983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2068.git.1773674983.gitgitgadget@gmail.com>
References: <pull.2068.git.1773674983.gitgitgadget@gmail.com>
From: "Aaron Paterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Mar 2026 15:29:42 +0000
Subject: [PATCH 1/2] odb: add odb_source_files_try() for heterogeneous source
 iteration
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Aaron Paterson <apaterson@pm.me>,
    Aaron Paterson <apaterson@pm.me>

From: Aaron Paterson <apaterson@pm.me>

The odb_source vtable introduced in this release allows multiple
backend implementations via the odb_source_type enum. However,
source-chain iteration sites that need files-specific internals
(pack store, loose cache, MIDX) currently use
odb_source_files_downcast(), which calls BUG() for non-files
source types. This makes it impossible to add a non-files source
to the chain without crashing.

Add odb_source_files_try() as a companion to the existing
downcast function. It returns NULL for non-files sources instead
of aborting. This follows the pattern used elsewhere in git where
a "try" or "maybe" variant provides a fallback path while the
strict version retains its safety guarantee.

The existing odb_source_files_downcast() is unchanged and
continues to BUG() on type mismatch, protecting call sites that
should only ever receive a files source.

A subsequent commit will convert the source-chain iteration sites
to use this new helper.

Signed-off-by: Aaron Paterson <apaterson@pm.me>
---
 odb/source-files.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/odb/source-files.h b/odb/source-files.h
index 23a3b4e04b..abd093b23f 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -32,4 +32,18 @@ static inline struct odb_source_files *odb_source_files_downcast(struct odb_sour
 	return container_of(source, struct odb_source_files, base);
 }
 
+/*
+ * Try to cast the given source to the files backend. Returns NULL if
+ * the source uses a different backend. Use this in loops that iterate
+ * over heterogeneous source chains (e.g. when alternates may include
+ * non-files backends). Use odb_source_files_downcast() when the source
+ * is known to be a files backend.
+ */
+static inline struct odb_source_files *odb_source_files_try(struct odb_source *source)
+{
+	if (source->type != ODB_SOURCE_FILES)
+		return NULL;
+	return container_of(source, struct odb_source_files, base);
+}
+
 #endif
-- 
gitgitgadget

