Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007080046
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719689510; cv=none; b=D3YTItPszU+en95SoUlymniQt81peag9Fntvgt6KgaHKLKBK0tn5jyZhvyjYm/k+SbzrlwJguvt0Eaa76cwk3Dwhjtl3TgHq04RS7LTcEQsmguXpQjmSzSbtKSg/6bfRtOgU9G6xqL9Xf0Zt3uGagSd1xZLmAxfJ9qwjmNyLf04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719689510; c=relaxed/simple;
	bh=+zO7l8zDkg9z9zSEhqdfH1Jc7VU06HjyUbKDdWSedEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eo1WmgjsnSuqx6s6OB3hlI7bI8J3hF7aPyNFGJt+MWr4gaIcZTIhGOLvVxC4Jlpy167RRlrgXMU0tEfvkHEqR2DCW2BM488uxr+b/EvTT7qu9y4kan2X/lWkI4bUbZ2amuQ0MDjw9Rsds70vDGurFtCqJip75n1GonMWUrW8k0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9KXR5lU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9KXR5lU"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-706798e7ceeso60868b3a.3
        for <git@vger.kernel.org>; Sat, 29 Jun 2024 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719689508; x=1720294308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqIZ/Anh7xEqmnJRX0kwd3886Y3D+KQYt4/0cMHM5kI=;
        b=b9KXR5lUWhhCPbitXf7FeqtUZkdlR5XrW/SejngSttCIZgsJYL1clbDjTH5sonUszO
         uNb0izYcjx4z7KuIJWjp/W9ieI8vPY2wQRbUH2Ch6yIUlJndhEbB8vzL37GOq2nVTJ5T
         9bMQOi0vtOf3ea3DLjA1Jhvdnx4SORX0eDtUhTlCMLxPazitvYnw8/aEzJLGZXVf6+d4
         zMxKYotMRuYsy8dE4nnh87bKGsdA3BuTTf5IxIQLLLcUeM6MgIoeGD2F9VcpVIx93rzZ
         59kuCtSAsDqGRuUSmvG+8wwZMAlGhrgH3Tg0z0nKCSxF/oHhrvvEz+sUm4yH9h3R3+F/
         vhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719689508; x=1720294308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqIZ/Anh7xEqmnJRX0kwd3886Y3D+KQYt4/0cMHM5kI=;
        b=I9aZVgrSBWKdApiOguKChrNGVIdZZ1wPfqBuDYBb83VSCELFvJMofkE5wLSz6KxWpx
         iF0233/gnlVBXuN08bCYpWbNRBoUfIQOpX/qRE6uHsVrqNLsxdif5CTTcsp8K47jJ4J4
         zora8hItDwGjqtHUX9g/mqmbwcC3VRCdUuEDm2vm1U9Eyg5jwfadmAXhbFXfvgh/FEjP
         /2yRakbVQaKMzj2WZOzAJhIHbphXfWCPMpyZ4dtpaI0dWakzG1lH/OJoTPwDqNkGQbYj
         0ex/bKo81OcuAxDzIEaajfA9Y8CHp4pTI2VVmwbqwLWp7GaIx6U0D5U+uqSg70SkOG7H
         /1FQ==
X-Gm-Message-State: AOJu0YxdlQMpsz5i/YMzvde6MYnjSVj5KtiAEVBrPBhPtD2XVb2mMW0C
	V+yiEaTLsgI9y6J6/tra/vNOlQNkH+pK9owonDzTKwv2fs+nxm6JL1/YRqxR
X-Google-Smtp-Source: AGHT+IExJ2BBa4UzryGpefiXUQAUOEmay6pfUnh9zG6P/BTG1WeskgAs9MKuDpC7bw1bnoHZW76tmQ==
X-Received: by 2002:a05:6a00:8a07:b0:704:173c:5111 with SMTP id d2e1a72fcca58-70aaaf2f594mr1682147b3a.3.1719689507684;
        Sat, 29 Jun 2024 12:31:47 -0700 (PDT)
Received: from TTPL-LNV-0102.. ([2409:40c2:100a:731d:f4f4:e39d:d24a:1f70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfb84sm3611910b3a.134.2024.06.29.12.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 12:31:47 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: git@vger.kernel.org
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,
	Heba Waly <heba.waly@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pathspec: fix typo "glossary-context.txt" -> "glossary-content.txt"
Date: Sun, 30 Jun 2024 01:01:37 +0530
Message-ID: <20240629193137.54037-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.45.2.606.g9005149a4a.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pathspec syntax is explained in the file "glossary-content.txt".
Moreover, no file named "glossary-context.txt" exists in the repository.

Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 pathspec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pathspec.h b/pathspec.h
index fec4399bbc..de537cff3c 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -23,7 +23,7 @@ struct index_state;
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
 /**
- * See glossary-context.txt for the syntax of pathspec.
+ * See glossary-content.txt for the syntax of pathspec.
  * In memory, a pathspec set is represented by "struct pathspec" and is
  * prepared by parse_pathspec().
  */
-- 
2.45.2.606.g9005149a4a.dirty

