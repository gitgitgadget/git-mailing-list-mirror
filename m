Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF27992A
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400284; cv=none; b=YHyZ2Rf7fMv9C2VMc6mdj3MASltyrh2UzxN712CMTzwW0HXVdzBbyDlaKjLPL70sFvMgTrQe6aTpEUJHJvR24N+Vw7WRa28XshwDJtQG4np3c8ABPcjcGj5XaQtGw9pLvEVbH2sN+SnE0UiKUpZH5TLEegAaiXi8jyZjFkv82sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400284; c=relaxed/simple;
	bh=s9qAo856TVOCYcvuar1zN+ihM0EK7v651thbz23dwBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThWLpxGIDPp9jhWPyuEN/M9rAyLrTj4nxO5zhJ4wU9C3RGbDAV2jCHKUgY+NGW5BWd6ZwAM8uBdDMCLBXW19RNeAQ5NNn2l/nho9Lrg079yrJuZb8J36DGLtqcJ6Iy5c3i+/k1AqKU2uOfFjeClQ+Nhx5DEiGCztmML3LLBh8GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtFh3WjT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtFh3WjT"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fe59b22dbso14518875e9.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 05:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707400280; x=1708005080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+UIwR/KIMl/hnSAFHUpRslKh//fN9VcqaodOGZidLg=;
        b=HtFh3WjThdHBva1TKH1WtnC1dliSbyAHGqs7b55n4TbNo6Z5b5h3sdbvbFu7jnjM8s
         34o+X6eAMO8GSLS69KXzsnRaoGjdSz3hVxN70ueF+QkfU/4ihl1PeMjxlatdGHIDMYMU
         6//vH40sVT62A1OUlA+CvST/kSI1r3W8/4mE8ShrrRrsKovuxzcghH6i8AIxwRpJ0PVz
         e5Lrl6uIW/Ov5ZV9zavtacfUTGvLMct7zXPTwu/dR0MzaC87lLSTbnGxSQTpuT3GQ1GB
         MP5S7llkGFbDxA/djDK03KwVVzCVSthulPDnBPoXQZeik4dJfNCuoJEbVoRztpnzot5I
         ylPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400280; x=1708005080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+UIwR/KIMl/hnSAFHUpRslKh//fN9VcqaodOGZidLg=;
        b=MByzI53t6St6SXNZdTTzjcvpF8fKBDNoEwiMuN/4WLCTpNlaeWJQhZDTKcQAovcRgV
         7YXAAAvgAN5f0PCr4ACY+NIK76BfFuEL8lGFHZ7qibNguOO8JoGh0XDUUepoEZqblGeJ
         awRLbe9fUJgyRFixOMiN6QyyK/unyl5nKBjZnGq2uVQ2813HgrJuIM+5dWpPxjM3LxF0
         S2DzviFhWUsRpUISZnWbYiR0Khg7kepyq0bwCFCQaqYloRdWp52cubBuNT6X1ipLigxR
         n5VGaUs9UAEaUCYKujsCBHBmVneIgULwnSXC/Rd97YPbx/aw4DqwBtBCuioLL16aHzKc
         ISew==
X-Gm-Message-State: AOJu0Yxh/Xs6stCRxGM7ieyEOP/rAl2msy3slicRKKBT2kc9Bm6rHibO
	mReApk9HSBa8y/URnVT/mzxU1cF0rw2Oy+WrI0DQDsmkuokLxpxY6yGAvLqg
X-Google-Smtp-Source: AGHT+IGwF2di7rE7dZ1WtTeifg+55eLdEjDqCvTcSmKyjURFseaPJs21YlIhtaZwHwhHvlQJG7nSgw==
X-Received: by 2002:a05:600c:4f54:b0:40f:dc4e:69e8 with SMTP id m20-20020a05600c4f5400b0040fdc4e69e8mr7359669wmq.27.1707400279960;
        Thu, 08 Feb 2024 05:51:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJgRBAANB+jLNxEGJw581hKE9F+UNTIMlx+lFS10MRiTa1ofq8Y6rWQpDH4m/fNKQ2QzPyHtVcO+RUqelTuhb33kJydYqJOUgCb8ECMcbG8vgbBj9TgNKGEtvsX/Bfazv9In60Ej967jXOZfc3e2bKFCocL4AA/iMi8hXqEe0490NWVXKq1UsJMKEaAOS8fyDJNoiovDk=
Received: from localhost.localdomain ([2001:861:3f04:7ca0:4c16:5b8b:3341:9836])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b0040ebf603a89sm1698307wmq.11.2024.02.08.05.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:51:18 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Linus Arver <linusa@google.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/4] t6022: fix 'test' style and 'even though' typo
Date: Thu,  8 Feb 2024 14:50:54 +0100
Message-ID: <20240208135055.2705260-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.565.g97b5fd12a3.dirty
In-Reply-To: <20240208135055.2705260-1-christian.couder@gmail.com>
References: <20240208135055.2705260-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6022-rev-list-missing.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 211672759a..5f1be7abb5 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -46,9 +46,10 @@ do
 			git rev-list --objects --no-object-names \
 				HEAD ^$obj >expect.raw &&
 
-			# Blobs are shared by all commits, so evethough a commit/tree
+			# Blobs are shared by all commits, so even though a commit/tree
 			# might be skipped, its blob must be accounted for.
-			if [ $obj != "HEAD:1.t" ]; then
+			if test $obj != "HEAD:1.t"
+			then
 				echo $(git rev-parse HEAD:1.t) >>expect.raw &&
 				echo $(git rev-parse HEAD:2.t) >>expect.raw
 			fi &&
-- 
2.43.0.565.g97b5fd12a3.dirty

