Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC626A09F
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945545; cv=none; b=icaUWnHZw7BISTBwoSNeyMmK/PBdjwjXrWoziPv1hz2mknM4bHJ997n9nLRvG1aoQzb7EJpI0lNY+8VEqjV5VNbc/Qhk0tkot8euNLMcIKD8/VbSgWzbINqWISjcNDJvC65JEzA+wCdfNvJPSGNRLqOcw4O2o8hlOGu5GqK48Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945545; c=relaxed/simple;
	bh=WQbcE0p2PaGyzq+/CqF/4E9Lu4J+lRk0yEwi99iuCAw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OdJBr57vSUbYDlkWnw13/pRZ0b0hHtYmOo5ql/qS1z1iMIXMrbf1rC+ljmEhFN5BdD6AHtTDXV0fzCm+C5uF4rLJ0tzxTXrNL3FwhnTcza5lx6Cb6hiaTqGOnoBbIsWG8gMedXMvtL8YU6oVMimnBNl70WhBJiSNjyvVroi/yt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcOLbZzu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcOLbZzu"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so43194475e9.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945541; x=1743550341; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwNOiVATTsl2SGFPJSiFbDrs6C9cxGjObK2mMHHE7kc=;
        b=QcOLbZzuB1cooB/3u7mf2Ss1TD4BZUx/khUYY2zVfRoMhkocQ3lB4AOkuRQcU1NQgi
         qerBZER5tJBsUsqzxa+VhD2gSU0WRQ1TH8FkOx6w3URKK3B60FqrhYeRW5Ob2smjSJZM
         qtiEaO6SAcXcNUoKr69aW16jt+E5+UaciDQQRd2Yx3vW7LSXZxOL0RfkZImEDhTP6BN0
         Ir7kxJMzcsSmXseI2ZLc8Ldv5e/hRGhaH1K6IEBqNdkc/37Yx6svMWDcw7fNGquicim/
         dcmXWkXoI4b3fx/k7hZjv0o//ynokTXjlUu7jSvc0Tkv6C3DO9UlSO2ckibzfty31a/C
         H9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945541; x=1743550341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwNOiVATTsl2SGFPJSiFbDrs6C9cxGjObK2mMHHE7kc=;
        b=TSrPu6ziFZjaEQbfh95navodtj2jsJyBBUFPtufdGoD/ml+6mfcjSK5pnHLhB65RXN
         BfQS6bVAphh/ye1r7eEMbouMDy8SAqUalh+z9r4EhgnGKdSyo6LO8lo/GfLlAAbZ6Uk+
         oGclzcJXFauniTqC7hYbNvK9SgKl8bKRNayc2+jEbqaFBk3xCzTTndAL0Dygb/jkCnf8
         XY1UQD2xEg2VEi2aQr4yGhZ/gKqEv4KHFDwwpJKBTH84foJdicRBQUrwgeNfau/nyKux
         TubaPLTSyKLBZIXp/KsvedEz4f1Jw335bzc7Tq0rv6fvyNwHs6KYOiqNLdFBe9yEaOqk
         FLkA==
X-Gm-Message-State: AOJu0YyIN3gnLxNhW711VnpGKfCnn4OBZp9vZtfZW7+Rv1P6p8DX7SoN
	zLWOq9Hou+wf0khlsJOiEUOYQDCCCGGv0RBaZhhIhyIrBxgOMJIU65w4sA==
X-Gm-Gg: ASbGnctfuuA4gJIK59TC4GIPah0CR1T+axl2KuyE4mCxRl6uyqEaINpa5fcKv3hNiKl
	uc3dtJYPlDzQJ4ONEsmKErTumDKMSoIuWVfsN9R1m0ZNsgnpQ3ythDHN6l70Q0l1TY693lly8Cu
	OTlecYr4yDuL6d6cbkzTRdI/JpB1/iyPW/M3Sic9vM6OPUMs2oViasBgY9uaggcRM3/qgIx5L4o
	B0FgYWec2RJ96nCk2eRBik5TFb15o3qpadvbnUFxp1Qrg2k3AmhalJygCPfOJ/c9J0SQmSRTF9m
	LZ2Cg29PfLlkGTGzxOoO7hZplHFV35i73z6BjgI88t0zyw==
X-Google-Smtp-Source: AGHT+IFAOltEw72o4vm/aRLslbLxfXf5VAZzoDLno/t0pTdtrUaqVch+Xkk1F/t2YNvxrL/GJ157Cg==
X-Received: by 2002:a5d:5f85:0:b0:390:d6b0:b89 with SMTP id ffacd0b85a97d-3997f93c41fmr16550401f8f.50.1742945541474;
        Tue, 25 Mar 2025 16:32:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e65f0sm15116942f8f.74.2025.03.25.16.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:32:21 -0700 (PDT)
Message-Id: <5e0e8325620395196608a0851f1f6fc9408f6090.1742945534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
	<pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 23:32:10 +0000
Subject: [PATCH v2 06/10] diff-delta: explicitly mark intentional use of the
 comma operator
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. That is why the
`-Wcomma` option of clang was introduced: To identify unintentional uses
of the comma operator.

Intentional uses include situations where one wants to avoid curly
brackets around multiple statements that need to be guarded by a
condition. This is the case here, as the repetitive nature of the
statements is easier to see for a human reader this way.

To mark this usage as intentional, the return value of the statement
before the comma needs to be cast to `void`, which we do here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-delta.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index a4faf73829b..a03ba10b2be 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -439,18 +439,18 @@ create_delta(const struct delta_index *index,
 			i = 0x80;
 
 			if (moff & 0x000000ff)
-				out[outpos++] = moff >> 0,  i |= 0x01;
+				(void)(out[outpos++] = moff >> 0),  i |= 0x01;
 			if (moff & 0x0000ff00)
-				out[outpos++] = moff >> 8,  i |= 0x02;
+				(void)(out[outpos++] = moff >> 8),  i |= 0x02;
 			if (moff & 0x00ff0000)
-				out[outpos++] = moff >> 16, i |= 0x04;
+				(void)(out[outpos++] = moff >> 16), i |= 0x04;
 			if (moff & 0xff000000)
-				out[outpos++] = moff >> 24, i |= 0x08;
+				(void)(out[outpos++] = moff >> 24), i |= 0x08;
 
 			if (msize & 0x00ff)
-				out[outpos++] = msize >> 0, i |= 0x10;
+				(void)(out[outpos++] = msize >> 0), i |= 0x10;
 			if (msize & 0xff00)
-				out[outpos++] = msize >> 8, i |= 0x20;
+				(void)(out[outpos++] = msize >> 8), i |= 0x20;
 
 			*op = i;
 
-- 
gitgitgadget

