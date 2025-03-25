Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870826AA83
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945548; cv=none; b=OlURITvnJe1crg6M9NGZBVKRpAk7+fztxyjCGKYVfcxZb5kxHKOdJck1IroSHU9OFMyTqi7so4pQ0C421d76wj4T+IcFKq9LH8oERBbUz4NKxMoiw3rPxE39KIZeH7qcJEmdWKLt/AOkOvrXay4jgw7qv/i0DTSs3F4UTcrbWmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945548; c=relaxed/simple;
	bh=jUNo3HVS7J+gSGac0n+fXPtR5JSEeD3RgUyY28+PAbE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r/C+lJJbakMNU+noGEsB4kvOq+yxDSUJPg0TEJQjHCtPn9XQkkJegv+6Nu6srM9HXuiXp1fltCgxGXUUvL28XQBpBk6Y+QgUNUlLfW8gJSfWVg2XQ+euUVWLtZWmoO2bdvl7WRcvq/JUpJOEKmLvV4zmDh/b1f98aLGi4ci/3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyJd+XGF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyJd+XGF"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso55649975e9.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945544; x=1743550344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1sC7oekF1HMLBo7RsoiGdAavqxiv2wKDRWJHd9d3Gg=;
        b=RyJd+XGFBoJY5BCCe1KkPSMLIKO2A/bttjop+/FCUQnVQJ0hZVJ+HmLXfV2Fo9rLah
         307ZqvQOtOjTYHSw+JP9u5/b51A5vDBWOBkK+vk/gQ5faFrcE31M9QaSc8OmgTuu8Oq9
         De1RakhuLAs0MvgozrnRWU9mqRuaRQQnIf6Qsvh0d+QrHVHTn7XBe+8JlySJOtsSuAfq
         NRRKz91ty4QZGsTtWIxLVmoRR0CNLge//I1fD6CGNRTpm6lHB8flh5W+Wcr7l5eBnk1c
         Eru8pukP3foM/KoGhYKEbNMRnFcRdxGn7nKyxc0x5KqjMEpcW4EQ6jAEOMRWCr3k9QvI
         OwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945544; x=1743550344;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1sC7oekF1HMLBo7RsoiGdAavqxiv2wKDRWJHd9d3Gg=;
        b=IWLJYUhu55YB8y8P2HsMY2IeJ2Yq2pTMBCsZXfw8REoze+eqCdZ2EejGNbDmsblmxd
         8MWMh4DSeRNa1XM3muzZ+LTXKi0LttA53wH8CyRCrRBTPeRH743oyw4wmxwUAqIvgGOz
         W7PGcO/g1NhcOnbM/FglVcvS/874ba3reKOKK0joQx4YYCbHXffHp0z8FOYVaZwl1kYl
         vA5tLe4RLCcL71D2zVpK2ogZnpxNnQ2f6L1+o9pn3IPmmGVouwL/e7GE/Kdo91vLJTTf
         vLNzXl+QFLos+cS1vtAik1LS+pS7el5pbJYdotdTGvmf4Cks3X8smchfhRu8fuBhIdXI
         hJaQ==
X-Gm-Message-State: AOJu0YxLkTxHbbQptS0/ShgL8panYFlbA2v4QQ9iTLwBoTTVtkiA5Lgi
	Gyf/l1o/0aoR+X/7cxG5+yRpLjmXxeOWY1E5k+E3RLDNn2cfM7VK7C72iA==
X-Gm-Gg: ASbGncsbk2dIoKe855daLkDKjVdOi8N+wUN0pUU5x5Mnv6xdfAgr4gu9QQfO6J1nKZt
	gU8yUn3W5tPuQZDU30FiqYP8XJfXcqmA8gtDBjIHJnHP6mvZ9JxW4PSO+MN7hT1fXhd/fTcO2B0
	vTK7X2BWLgt5oJ5tFm64btkrlBjGzShQCnLJF7T0MWDhPIfflfC5C3CXefkw0w0cd8+abpTD/0k
	TrVmTRUt9JGe2v6de00G7a3JuCG83dR5aOwm62WkGNd7DRt/WEFQLukasEsKeoWZtltwvRxGRR8
	FOdz7/D4JuwH0qDhMq2ZcPpt4fzTQYSvr8Xiktvbl0C3xQ8+qe0D3xuj
X-Google-Smtp-Source: AGHT+IHD/NiGq18GOl6MpstgNsKmbEaW2ty5D1eaM7SzVTy7G+cgGx5TLzFVEnWLS6LuvvlvNbWd9g==
X-Received: by 2002:a05:600c:3502:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43d50a4f8d5mr186412655e9.29.1742945544352;
        Tue, 25 Mar 2025 16:32:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d7ae65761sm2103095e9.0.2025.03.25.16.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:32:24 -0700 (PDT)
Message-Id: <91f86c3aba9d19d5df11661675fd6c2cc049e191.1742945534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
	<pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 23:32:13 +0000
Subject: [PATCH v2 09/10] clang: warn when the comma operator is used
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

When compiling Git using `clang`, the `-Wcomma` option can be used to
warn about code using the comma operator (because it is typically
unintentional and wants to use the semicolon instead).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.dev | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index 0fd8cc4d355..31423638169 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -40,6 +40,10 @@ DEVELOPER_CFLAGS += -Wvla
 DEVELOPER_CFLAGS += -Wwrite-strings
 DEVELOPER_CFLAGS += -fno-common
 
+ifneq ($(filter clang9,$(COMPILER_FEATURES)),)
+DEVELOPER_CFLAGS += -Wcomma
+endif
+
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wtautological-constant-out-of-range-compare
 endif
-- 
gitgitgadget

