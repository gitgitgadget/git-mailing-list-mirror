Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35142192F5
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010018; cv=none; b=NuOGnVJlYHH68iZqhDrXuw64rKc381UcU2DJ2pklWkJkSsic9yj1biExvqD+No1Lb7/S/tEB/9Tj9adYmKjS/xOuS2X82Mmlj8U3NnlE7uDEHzVlw4WB1Gphoiu9rRmXfepHuPJEkW+QmjAmIWVtgbxnTuTrMCBNYlRNB86dbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010018; c=relaxed/simple;
	bh=OvKKijfWzBE0MCZ0wCJ+0a5UjytAb+xr5480U1Jo4Z4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o3b9OeYuSuV7Ml5rhc3Pb0pPcplUk+yjWfZ6b030pFYzBoBxwX9ClwdHQtVlZqDjzoXecvDu9mwG00gNg0/jhZzdLVh5ecddbhDFJ/LpvZjOzXSn9SRCv8EJHLcxlLtcRgVaRHQdWkzLOyX82VsDGY2jG9OBfzgi806yyLmJ32U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3Mr5Li5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3Mr5Li5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so815155e9.3
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 10:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743010014; x=1743614814; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU7b5SKJQ5hO9/SwmZW+UXVK3CuCp52iNpMoClwIP7Q=;
        b=D3Mr5Li5NAfWP2ooJs8wWdZbfVa98E7yxk8jtcvsjOKkYwXoRVPJK+y+OW1CiENern
         PkahbwuVyOEEm5cd+nzjgRrCc6EbSyumQ0saj0kQ2A3KPqfOmjAHH+E8U/Es3dNnRD5F
         UJ4p+Z84o8+GAz73ozLrW21mjXJ5TD1hwiCG+3jN0su+kG7o/slF7dWvRrKkykZrKUvR
         JNE9uIFgaP+JNIfVqCBLTSYpl6/omS5TVvnQHv1U7+dmRdvLwoybjiTfrtCwoxxTsCTN
         zGUmxXSHCiLWr3BnrxXH6/dB+HpNGdKtBHBfIx9K7FxZlDTTKGG3VYio4OERWklKVwG0
         LXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010014; x=1743614814;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kU7b5SKJQ5hO9/SwmZW+UXVK3CuCp52iNpMoClwIP7Q=;
        b=gv5B2HiPrz+fgHAQu0cS0PqSSMVm3VMbUbnSnLWQmr7cuxHneiQ9LPOXudo/jvNZrG
         Vz+2PBYH8aQU2CF7NIZPTaq4J8CWg/+331oAA+8h1EbOCIvk21RoCCZOzNMYuJJe2te4
         m5QD1v2veiI4zJGKCv/wP+371NOmeb3yRQrPMV/9H/Zc+o5/qEqqi/aH4wAXUBqsN3XM
         Zu5S1C/pOaHUY5xD+HHvePjfVQQ+zI2YQ7Rm5L1s1p/F+/4rQlHfGCNMqbhPX8+GJNmK
         aQXmi8CtOJeDiajHhMj8fn95P6ediYlqEm2Qc7g1dIcV4d+lmUqVZh+eWLOKy4WDLgA2
         eD9Q==
X-Gm-Message-State: AOJu0YyzOgHlDWmXnNbCyNh5iWD7UAIXTWApck8cqfXYUNvrFjetovr5
	EPvkurYZ08SFXINqjwLkZsP+hG/Q72hFqsN5Kl0xA2uUcHyMIGCzsQR5oQ==
X-Gm-Gg: ASbGnct5DVzjnUbrg2AmiV6eB04GSDoTJkFCTCgI3H3oOViuopL/2DCpPKbitIGYKYp
	OiZP1M7wgeQNRwDAr7PZyuktfvOePGDNcFQF71igyyxy3ldZpf1WKr2ehGMGEfGyO7e40EgIcgR
	gXKKBNzmpQA4b/cUc4+9zgN9EHvBjb4uIvVN905dnO4AtOUxAzEWbwh3P+PuDC4O69zT9/+ppOQ
	LFpic9ZA5ZJJc5fMwvIMDb96RrOqm5uVClihoCztU4X1AZNc8Suoj7vdArVAY1n6+jip3EXfB8T
	9jERbIYpVugjvuOp0ZHKqo2iCHGLUm0CRejk7n8Fd/RPMdEjb+MiEkKS
X-Google-Smtp-Source: AGHT+IHP9ivKqtdXd3kpdwrcDmyEBkKs+Ea8pQ62HM6Okev66eXea411YDQU4U1K2NpbhiKnjSxK+A==
X-Received: by 2002:a05:600c:c0f:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-43d850a2452mr3150485e9.30.1743010014219;
        Wed, 26 Mar 2025 10:26:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dedd1dsm9043575e9.8.2025.03.26.10.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:26:53 -0700 (PDT)
Message-Id: <ddfb44ed924615bdb61a30ae7627326942575567.1743010011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
References: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Mar 2025 17:26:50 +0000
Subject: [PATCH 1/2] diff: check range before dereferencing an array element
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Before accessing an array element at a given index, we should make sure
that the index is within the desired bounds, not afterwards, otherwise
it may not make sense to even access the array element in the first
place.

Pointed out by CodeQL's `cpp/offset-use-before-range-check` rule.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index c89c15d98e0..18ba3060460 100644
--- a/diff.c
+++ b/diff.c
@@ -892,7 +892,7 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
 
 	/* skip any \v \f \r at start of indentation */
 	while (s[off] == '\f' || s[off] == '\v' ||
-	       (s[off] == '\r' && off < len - 1))
+	       (off < len - 1 && s[off] == '\r'))
 		off++;
 
 	/* calculate the visual width of indentation */
-- 
gitgitgadget

