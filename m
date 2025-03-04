Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DA481C4
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081478; cv=none; b=pBMoLN4AASz1EtzTpoahonbZS8GS17tncDvo/W31u6kbktCqmdVuWFePA1SLe9xmRHAZ+nlAQM0imBo2yGxbWj6f+ZP8i5WRFvSgOcwMDaznlyh6+X/R3TaDL0gWv9gt91Vy42WmvZ3B2Vk8PFJyCVkU/Oq6zTr9VhO/PjS7a5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081478; c=relaxed/simple;
	bh=G7T2hXAtaL1M0X+vGu/E6KsguYtyz6owh77MhwT0a5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qc4vWluscvmlIl21+FfxVgOvLm9XkzWWCpMnsb63r0TziuKImO07TOp9373xdIjjd4Uf3kwuwfnHQCxbjWhWZhigKfVvcU9tHmSKxu5w1aeywcAQUfQsNUqBgIw2iwxCPc4qp0uBf775QcjksxUjxZ7N1zflG+XkwX/HrJwPT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wfo/DGvU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wfo/DGvU"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2232aead377so104907635ad.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 01:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741081475; x=1741686275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Qk7PHbGAO2P45jiVlOxlUZ0NSGvZDOG8uBk/PqG65s=;
        b=Wfo/DGvUV9OQarBQAh3Ddg8Fh4xhK+x8U648Tw6bUD5X/yel6UHAWjF2zisqFWpkGq
         6GQaINUp3Ncw6CQI+8mwe0uvWB26lhBYs2MI1I008xt2E3IvfUezEuNw2N15rJFeazbc
         N1rUAKgseBcTFv5eBRbp4Xw00uBlGfLIaPw2sCBC1wMlo9hVT2txIGTQwowXKip2mm2O
         bJ6IdL03z9sb+QZJlDMTafCODUPL4scveekH9R43bp/f77sC+fpiPo/wwidZefU5Vn1o
         j2f2eNvB85tgDlqP0JKACuMWfsoSRE1qbuyUpXK32tXeuPoot2QoxKWVSspyuTwld/LC
         PbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081475; x=1741686275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Qk7PHbGAO2P45jiVlOxlUZ0NSGvZDOG8uBk/PqG65s=;
        b=RwmqXpkl7NkPqBQD27tOtZuRJMqHGz+gTipEb02b92XxK/+70NP4teSdaOK6D3qaxQ
         FPCWkQA8b2vP6M8QVcvQbTdk5L6zDrMhJuzp5OXX3/fEIlaRhGuzBZqxkx5wyw+C/17R
         zAAf6k9SYXtwSnQKX1dP9+Geifha0CR4kDRbsArtFm7Sa8lv0o7x1zTSRerwLEhfx9At
         ZN19QXOWu0itIFqsOZYzjdGNlu0/QaKAYy7XhX6O3CS9ZGQwhskZrEMh7SocMiYDowcN
         qEwxjtd0zPHGNzRGBq7YPG6hS8+TqvQa7lll7WaMXpPu8ac8uacQcEL+tm9s7CtRPIyy
         KUAQ==
X-Gm-Message-State: AOJu0Yyd8qltdPb6w/OsT8EDu4LZHJ5/s+ee31/gBc/85GOzuS4jssML
	IeWie1F0xjFdEyLQ7u/bGYgUl/fEqVLA5dXe00TSK1SmN8w5rKZguA037TpvuoI=
X-Gm-Gg: ASbGnctY8GGM6OKtSUdyyvPWLgN6t8PdbIYNqtJpUU4XpkNeLZVa0V2JATPJrexjg9F
	iMP+KCPczZx8oS9o+PbX7rsIA59kmgzdI0Up7GpxC3zNZYwq6M7LOC6l0B+MDJianX9EGYUytkD
	G6vZiLjUaKvd6f27ZdMVDLuqT0JYwq15VOWpG1zyfOyvUi4K0GVM+JNUexRJI/dAFJwwiHVqxSY
	7CAO/dQDeJOM2HVRLDv2f/mFROW5l5FYLfo5C9RphtRfhDsRoKjfQYK9CjwDJGNCCljM2JFOVvA
	BUrtcm4uQmnNSaJ8epvqjSw+rkZjG2EfsAlYkJKpgZTMb+cAP17xVxMNjC2o3BBUJHPadpjReRj
	YbBP80HpqWg==
X-Google-Smtp-Source: AGHT+IG80CkEFBHfpa8iPcurSLMicoKq0XlrW1JZYiEeObztrsnBm4t0CfjTEomzuQcul0HT1aVrCA==
X-Received: by 2002:a17:903:33cc:b0:223:5a6e:b16 with SMTP id d9443c01a7336-22368f60ac5mr231944245ad.5.1741081475569;
        Tue, 04 Mar 2025 01:44:35 -0800 (PST)
Received: from localhost.localdomain ([2409:40c4:307:e1c:f069:cd37:99b2:31c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350510ec6sm91858265ad.220.2025.03.04.01.44.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Mar 2025 01:44:35 -0800 (PST)
From: Mahendra Dani <danimahendra0904@gmail.com>
To: git@vger.kernel.org
Cc: Mahendra Dani <danimahendra0904@gmail.com>
Subject: [PATCH v3 1/1] t1403: verify that path exists and is a file
Date: Tue,  4 Mar 2025 15:11:53 +0530
Message-Id: <20250304094153.28959-2-danimahendra0904@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250304094153.28959-1-danimahendra0904@gmail.com>
References: <20250304091556.22478-1-danimahendra0904@gmail.com>
 <20250304094153.28959-1-danimahendra0904@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test -e does not provide a nice error message when
we hit test failures, so use test_path_exists() instead
and verify that if the path exists then it is a file using test_path_is_file().

Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
---
 t/t1403-show-ref.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 9d698b3cc3..4afde01a29 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -196,7 +196,8 @@ test_expect_success 'show-ref --verify with dangling ref' '
 
 	remove_object() {
 		file=$(sha1_file "$*") &&
-		test -e "$file" &&
+		test_path_exists "$file" &&
+		test_path_is_file "$file" &&
 		rm -f "$file"
 	} &&
 
-- 
2.39.2 (Apple Git-143)

