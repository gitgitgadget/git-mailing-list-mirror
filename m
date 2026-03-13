Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BA223DFF
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410372; cv=none; b=sVuVuFrx+ZvdPKha7HSPMX1p94YBONBRJtERVOXHrBkcoZqDyop48Nhiox5q3WYzrMGxGOuz74IKSSW26XkBYXr0fE+wFuC1SKoxVKN5W+6hNoqQuLjiWUEhomJ7LSFCt7l2F+y/0Nxm0Fd3cCgKiB1/ZXxqiXHTcS6NoNpjPQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410372; c=relaxed/simple;
	bh=1ye0M7jy2GqNtgx9jg08vk2zsOEBLJ6Dwt9XzS8+SJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHC9rgYdtijNKs+4a4VjaWzt5AGZdGZqHNz6SI8x+y8aQS+3Z/QyOw40XpsWNzQj90t3JqHItUW0OepmlEl60QqOQchFQ6HPotGM4k5/xzmNs/HWKBBm8pLcDZgMlBIg0q3YDw3i52Q2KbLPeiAKNHWIExmYMQHaxdf5P4H24d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/NcIMNn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/NcIMNn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so1012096a91.0
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773410371; x=1774015171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=i/NcIMNnubG0NDCpjVpXr64rK8Lnwru69TcKinPXKu/yI4Pb1S/uQUtUX56HAl0HHz
         tZWSbbQV5vFD5shtupr+Pd+iRn81Xh8AxpQSdi4prfD6SNPaXu/lRvZ8MG492BHQbI/X
         cVU5AMF++7AOoh2NvdC/mvX1qI+UDykWnJt3bLshzwMYtX0S6qy8+4ajroHs9AEWHbEN
         X0Dl/SLWUzO7zqXfUXXqHEDOEIDLgEkuwUAb0TaqYqc14yZazM54/5nff09zw/3BqWUk
         pRkr0luQfXMS2M3d8h9QUxmHk/sPsq8gzX83pmJnBahzvQyBkpUt05nQwKYYpY8qDMsN
         Aiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410371; x=1774015171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=BT1G0UBaVcn0YK/Aa4GUtIBHp+X+VyJcIISzifnxMfcHldq+q8MlXKZZtKmE7zsfmi
         kLzjnB0EPRGc6IT7xjGNPoa9PA9CmYyInJ4Jg8ggW9aBv9iLBXzStnpUySpUB1bndbb1
         QLOXbFyh7kw0kF0rKBVO8JUIaFhykheto8ML1hOTUyV0MkSZJqmnzi9+AdaO0XLp6zsq
         DbCLXCRpRW6HBNbvyoVZK2wODaTKcCMtLZjjX1OcW34XySa4FQr5tMIS4XOWQtpgs4fb
         uC7pnXbeNCPE5mAN+UQN99Tl3dEBBXLqigplW79iN6wqlTOwLmhGCMGtXRAC5xziPp6X
         Qtyw==
X-Gm-Message-State: AOJu0YxRjCdqH0woYe/plEtbVe2O5nG0TRhb7ZFqv9ULD3ZZ28B2JDpO
	w8WB8B4XZgvUs1jMXhj+jawIriU4VLYHZi0H+FjY9KUIbl3XbKL2306QmdcMgk+C
X-Gm-Gg: ATEYQzytGBn0JhdM92ViXCPiMo7AOEw7z+dLEqt4pMVrh83YbaAHfyAr7nV2pBxiph3
	/RXw6b8bZyE/apjgcaMCDnvPwRIGiVcuTfDVUEbl0sDgT4LfymaGXwlBnZwuDP8245ztm1jSHz+
	symvLsJGjl8zElnBk/XsoV3PQXCf8wMkyC5hpBTDiZWT5ZzbYhwbkksoVVjVm7lAVyLWk/A17HX
	Y9dAQq8CMlwCetrtyPcr5Mcr17AOhny2yeYQcWJrOULYO9vEFTfmLfK0Rvsv/fd83u1ElKtNwGh
	lvKGEiJZj4/aAq8vM1B9DONeUgInM5syzcgYPqNhyz3JXG4oyh8QIUpxXcjO9wl6YiqP9nwY/YM
	RoE/GJqPNzPyAlJvxc/54txRuvnTqnhI4mvNwRjSrzTnaGctvuM+LAB6lnzJ7dbG0Ythv9HPdG4
	/0Aw6+M+Z/X4HpzACCpfo8MjBJOC6N7w==
X-Received: by 2002:a17:90b:1c08:b0:359:8e5e:43ee with SMTP id 98e67ed59e1d1-35a22004e9fmr3066480a91.19.1773410370814;
        Fri, 13 Mar 2026 06:59:30 -0700 (PDT)
Received: from divineocn ([45.127.227.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e7522dsm8628983a91.6.2026.03.13.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:59:30 -0700 (PDT)
From: aum2357 <ahambrahmasmi2357@gmail.com>
To: git@vger.kernel.org
Cc: aum2357 <ahambrahmasmi2357@gmail.com>
Subject: [PATCH GSOC] Signed-off-by: aum2357 <ahambrahmasmi2357@gmail.com>
Date: Fri, 13 Mar 2026 19:30:09 +0530
Message-ID: <20260313140009.563621-1-ahambrahmasmi2357@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff: use conventional comparison order

Replace `0 <= addremove_explicit` with `addremove_explicit >= 0`
to follow the common coding style where variables appear on the
left side of comparisons.
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0ee21692c2..ad0d6047af 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -432,7 +432,7 @@ int cmd_add(int argc,
 	argc--;
 	argv++;
 
-	if (0 <= addremove_explicit)
+	if ( addremove_explicit >= 0 )
 		addremove = addremove_explicit;
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
-- 
2.53.0

