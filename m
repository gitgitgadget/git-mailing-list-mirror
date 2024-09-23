Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35E1957E4
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089441; cv=none; b=qF7/M/4EjgPlqpg25oAaoC4vhtGJAUO4uimXMF+XEZn3XrhHXlxuJ8SkmH0io8HN3yJNyNbCs6ieo2oHxLCXjkp3vAVG6XIxHotgv+spA74e95A4LyJ9cNK5fv7RLaEkS/v+VOsp1gcY6O+iPqtX9eUWSe1GVPpHBchRG3mZHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089441; c=relaxed/simple;
	bh=D5veaIE5R2Ue0NlHNqPCh1WaBuZQmlRu/MGfgv8TsWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qf2+su3OKtRMdDV7bB5mgf422lrZ2UigxKAngAdItoXSrr+2LKvQirvQ/sCUbbKZDe8veIuntFNBiYJ6xHa3M+0d2WdAMJV6eVvMco44VUCg4To9CTbuhQze486ccp7jXT8tyg3i5i5nmpY/JoPfTsXYyvxFxgX9vouDCm4OiHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmRmEsq2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmRmEsq2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso54196225e9.1
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727089437; x=1727694237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vl6hKbLJ48JxBvgQYW7FR5f+Ksh/l+BlB1bcDakbWXI=;
        b=jmRmEsq27zM2P4vKksC3WBqSftnrxsqL/u0K09w6OjbkNTp2tf7Ur/SLQvrEIdrOSP
         Ux6qO3tavN7E9eN+rVEBeFWDEtsGkGP9rCaSwKUIxSxPM9Vy00IqytLVaK3vcG3MpmKQ
         bgs5ZGz2iIzJSx+7c+ya0Se/yxo66w51BmDQFM5jmP6LyNFZYADVpYgK2Pra8UuhGKWZ
         C2E5rWHRELFYHJWwMDQJvo7RLQSSJNeqXenUTaf2bnwtjHZJc3zWDVBVMR1yzHtIiwzw
         a8oJRMua6dOBxXnLV4lHmoebVZPQXLxTWWETS0THdC8F5Le2KkYDMezSNX5Xu/RD7Ytg
         6tLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727089437; x=1727694237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vl6hKbLJ48JxBvgQYW7FR5f+Ksh/l+BlB1bcDakbWXI=;
        b=Qp8uB7cE69c26YeT+ddg1WumjZrR/h57Ln37mPWmpFaqBBksjC+rf9877b7IYuKjBq
         5KHGei1kr4XwHDjvXTwWUtAI4kPInBTKxPLdA0uEen3v6P4WCDbRZxmXua5M/yURb/c7
         +3wuuyRedRK5QDwyoOEK3eVO8EwuM/KtDNaAEmC/89bfXMP1ysA1GXDRuzLju0JXZuGg
         /t6nxryIv3MDY6UkiRKxnuAI/OZW6jaeq5SBCxK23JA8vpaq6Cwj0K6UpXvtsm4gcVoK
         Qy79SsqEvYYBAP/J4S2NO58WXq4FPxY5oHCLvB3u00W1qWC0FlObiCfFkIFj0vmav48J
         vZzw==
X-Gm-Message-State: AOJu0YxUXSfE6ehveWLJuJDjKyHuJEM5Brdy0I5czTWEK0yFR1jU2RwK
	0Ieq0HyIY2w9ZPsCa1Wxvk/NS6TXp8TSNSuzuVubPv0Je9txJ8DccFB1ug==
X-Google-Smtp-Source: AGHT+IGIifTcaGMSKsdqhEGzj8ha5g9pwXiEEPwAD9yeolBO0w8uvOZDC3BFrjhZqegJnuVT107K2Q==
X-Received: by 2002:a05:600c:1d26:b0:42c:b995:20db with SMTP id 5b1f17b1804b1-42e7abe3a42mr100291535e9.5.1727089436784;
        Mon, 23 Sep 2024 04:03:56 -0700 (PDT)
Received: from void.void ([94.230.83.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780578csm24366413f8f.109.2024.09.23.04.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:03:56 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2 1/2] Documentation/config: fix typos
Date: Mon, 23 Sep 2024 14:03:42 +0300
Message-Id: <20240923110343.12388-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 Documentation/config/extensions.txt | 2 +-
 Documentation/config/gc.txt         | 2 +-
 Documentation/config/remote.txt     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
index 38dce3df35..f0a784447d 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -9,7 +9,7 @@ work and will produce hard-to-diagnose issues.
 
 extensions.compatObjectFormat::
 
-	Specify a compatitbility hash algorithm to use.  The acceptable values
+	Specify a compatibility hash algorithm to use.  The acceptable values
 	are `sha1` and `sha256`.  The value specified must be different from the
 	value of extensions.objectFormat.  This allows client level
 	interoperability between git repositories whose objectFormat matches
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 1d4f9470ea..21d56db279 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -163,7 +163,7 @@ gc.repackFilterTo::
 	containing the filtered out objects. **WARNING:** The
 	specified location should be accessible, using for example the
 	Git alternates mechanism, otherwise the repo could be
-	considered corrupt by Git as it migh not be able to access the
+	considered corrupt by Git as it might not be able to access the
 	objects in that packfile. See the `--filter-to=<dir>` option
 	of linkgit:git-repack[1] and the `objects/info/alternates`
 	section of linkgit:gitrepository-layout[5].
diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 36e771556c..71d1fee835 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -50,7 +50,7 @@ remote.<name>.skipFetchAll::
 	If true, this remote will be skipped when updating
 	using linkgit:git-fetch[1], the `update` subcommand of
 	linkgit:git-remote[1], and ignored by the prefetch task
-	of `git maitenance`.
+	of `git maintenance`.
 
 remote.<name>.receivepack::
 	The default program to execute on the remote side when pushing.  See
-- 
2.39.5

