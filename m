Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F816B75F
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070416; cv=none; b=t4A0mXEPirJPWXBryLkU84c5Gq38XDkFbByQZtHA6VibJ7keIC7CYXi2aAtpJ0m7J0BTkOwn5N2UQ4IZs8POavYlQYZ2hJbP7Gy6NCj8hJXQHoLimmQOwuocdrDABIRLPJ/GIGP61uNXom71LFEZnoVQhCuRxkarsOK+hlNczWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070416; c=relaxed/simple;
	bh=nGjq1+2iFh+uKKoZfNy5Sj4kH5oLUYASx5r+rUTYS5Q=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=givq+4ML0MxrqdvfpKHGOaKLcJaK3uFOwZ0CkmTHRQsKAOm0exQKOEs0loMvHQRJUBWz5RoGiuGjkpuG18aa+naaxhf4pGuqQRd9GBCZPV9sdRgJVbBPSBRWhPKEym8253epnlstIEwqHfOn14vap01OsMrkVuHgF94035G/wQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cX3aMILE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX3aMILE"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso3198948a12.0
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724070412; x=1724675212; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BvtMgS+ionRHC/iU6gZMDPv9Nbkq2RCNVbMfeXDoEb4=;
        b=cX3aMILEt8UehABHYq+eGiXfAYDZQaQVwueZ1BXLWB/1YzqPk1Z2hNOKEyUGqTh/GR
         m1t5zGckvA/YA+rfiEhfU1kDh6p+6gGQ3DyG5IcNUB2ux7RlFz49JXi041ABflg19no7
         aEF1yZQlpaTFAuercZ3gGwbWSFSv1ySH/f9IES1SBSPXQnt/CSckJEmW1dJhFLixQKS3
         cNsl2z8+aXH/awseWDwFldZHQYztoBSDMKB0BC7rHQ/IS0CKe2cUZH/B9ZwhPDd59Ulz
         sVH7WuujF5TKx0uYlBz0HSLDod8a0+JARj/jNB0KMawHpAyg5HoUU9u8091Mkjg4u+3J
         TxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724070412; x=1724675212;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvtMgS+ionRHC/iU6gZMDPv9Nbkq2RCNVbMfeXDoEb4=;
        b=qNzdj7p8/s4vDOsL+cgSmMJG3QB/0VLO9GM8W7QxVx/BBpUt6s9+cZ4Fgtf5JPC+cc
         kiL4vkKAkdPH82epOMOj9myso7BX35u4CvCgk7c+1ae2MgiWtFN4Y7YvJhG25sOTsdFs
         IxwQM6rui6vPlJWEVV07hvWHNyQQ0WOqAI/Fp2GfDh4k0W3eeRwU+pR0x8wkTmhtgInX
         9N305o43miCXo4ATDY8MJ+582+wh/t9v9n92pOclUQp1U+i1vzlXRPKEwtemSKgscK5B
         pnAedOwYjwj0LYYWaEC5Y4CXyvIRny15DPj+5/IXEKfNHXwgqQ6uwt6A4ohmWiAUakwu
         za4g==
X-Gm-Message-State: AOJu0YzVUq/H1GZOn6TS/LpVYGoZhB4tlEd5fMRtqN67zCCXkmeG/hpZ
	jNX1YzQjR0lsqmWyxyiLkqn0N7Pk5TdMOfMaEbbpky51RsfS51Krt0PR0g==
X-Google-Smtp-Source: AGHT+IGGkhkz+KalSgqvYTYu9BsnZiaMfwOEkUAon3qLX+ZCpKCXwEUZdw8XTM4vt2YeM7orOs4wPw==
X-Received: by 2002:a05:6402:4312:b0:5be:fadc:8714 with SMTP id 4fb4d7f45d1cf-5befadc8845mr2386846a12.5.1724070412142;
        Mon, 19 Aug 2024 05:26:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde48e7sm5674589a12.26.2024.08.19.05.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:26:51 -0700 (PDT)
Message-Id: <pull.1761.git.git.1724070410906.gitgitgadget@gmail.com>
From: "ahmed akef via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 19 Aug 2024 12:26:50 +0000
Subject: [PATCH] docs: explain the order of output in cat-file batch
 operations
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
Cc: ahmed akef <aemed.akef.1@gmail.com>,
    ahmed akef <aemed.akef.1@gmail.com>

From: ahmed akef <aemed.akef.1@gmail.com>

the order of the output is not described explicitly so someone can make
complex code to parse it instead of just depending on the order

Signed-off-by: ahmed akef <aemed.akef.1@gmail.com>
---
    explain the order of output in cat-file batch operations since it is not
    explicit

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1761%2Fahmedakef%2Fexplain-the-order-of-output-in-cat-file-batch-operations-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1761/ahmedakef/explain-the-order-of-output-in-cat-file-batch-operations-v1
Pull-Request: https://github.com/git/git/pull/1761

 Documentation/git-cat-file.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index bd95a6c10a7..f1e0b4a7219 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -270,8 +270,8 @@ BATCH OUTPUT
 ------------
 
 If `--batch` or `--batch-check` is given, `cat-file` will read objects
-from stdin, one per line, and print information about them. By default,
-the whole line is considered as an object, as if it were fed to
+from stdin, one per line, and print information about them sequentially in the same order.
+By default, the whole line is considered as an object, as if it were fed to
 linkgit:git-rev-parse[1].
 
 When `--batch-command` is given, `cat-file` will read commands from stdin,

base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
-- 
gitgitgadget
