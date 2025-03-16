Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14CF63CF
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742089665; cv=none; b=DyLcnORR/v2lByppl8SN9NTk7egHsLkQe+DkDF8eP/s2lNf+GuwfwMqnkBVusD4R9yfikdNzYlxy8vZJeH+9XJnA0A3O6+BfNsZ8CTrc2/HCnj638xIjbhPBLIOQ1090JvWfl1jH0Lgz+pr/YDUeW1Pnn9ZxhR84vECfGsxQzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742089665; c=relaxed/simple;
	bh=ZfZmeK1HsMqW5YWGMraFS6CaeSd/A4hM/LNa+hTmR6g=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=px6ampvtLASpe3XtUwDKbexqx3Oj415vC8y4XSt8bTPjZ633+wsq24n4twDNDV7k/EHan9ELj+4o20D/5XUc+bsDrItQROBBH3v1HNdE/X7k/ko5D2vVFwwyUHlzQW/oThSyh5WRZGULbnqfDZT/ypdfxY30CkhZ06bqkeFZQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSq8uI8x; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSq8uI8x"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so10599085e9.2
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 18:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742089661; x=1742694461; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j5IvM4g/R21BFEsXDDXwbZnQPuYcc8cwFy03s3tMSoQ=;
        b=ZSq8uI8xFq2jGtMWRvAtjtAHNOFpwU+1J6FFCsUrIj4Rh2dMMWqvjt5LQ+c8OJgXij
         /hZmMfl831OeY2jqvlhwuW1B/ZIt6QdfEnQLqyp9J8bddZn+8Wmv998f/ZxESAiCKN9C
         AZm+PTKRQdpdlNeGgkqRQSHm1OqaLEoY4KnJmvhPkVyW2+Zp1dl2k9obS1DhpXrcddvA
         7v9yZLPiwr+flPT2yiByRBGkfJe8k2BRw//aitbId0YcCNZxX8uVay8RKjmCZ3YuEyor
         25jK/NscTYdffXFtwPKBtvuKGESmLaOP8+Dvdzm6s217m7qhX76bsffm6qyIwRz1vy6B
         ogPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742089661; x=1742694461;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5IvM4g/R21BFEsXDDXwbZnQPuYcc8cwFy03s3tMSoQ=;
        b=gPcjTBHfQ2uUgliVcBT8ApeWNsZSA5cvoPJ3Tzth0kOcBUA/Zk7U5nfAH+vOt34/RN
         5sWWFEnn+4XeGtKrh4NYB983laEXbmhj6wRfAmm2sPACMfXZhZsl/untlyl16GnOxACe
         OTPDrHvw3fYMibIpUVmen38vqUIf8i5XEMh2lKnq6BDK+yMtNd0zhNFiK4rpcAMJUyw0
         VLMavARPh6GMjgW1WHqnD+muH/woTN8bTWEjkKXCRGKzqoUwKzXDj44zCjjOXTfRtKC1
         RxKTAqnV6RL5fiGELuarnoPfCMj2wkGxswDS2tNY1QP3PtPScN9nakZmvrzDtB4cM19K
         JTPg==
X-Gm-Message-State: AOJu0YzluPZ6yFUkDpJHQBkFDoGYJvpY68Ov+cQzgHxOPZHPLZOIPzph
	Z++xfJzQbcLruUXgqothl8sAeosaR6/URl0m2d+oO8l/7+xuVIFvH9mfHA==
X-Gm-Gg: ASbGncvU1EM826Pz0knKEUUC14J/eVh6slxkHua1mjeDaBe0zUG9T/XjxXNh5Mqxcqk
	7ZLMXbo/TTZdF8vUyjQsOU92scE+aGoRWXLzFdIB7h78ImRMaB25wf42UGXzcNTr5NaTS7O4OU8
	4nLcZ0MkKUURtfNoWGlhxVzjOji9oNALqdeLadFv6eimmIjpNB05ZZcPyh1ymPwZFflIfR2Ksxe
	JTAc1q7ZPd6ujRgcu2BEjNPEqdaObIzZC9iGE2oZSk+qBoVXW5ca6a+ycLXduQst3zetPPJ5Z6W
	OSvr6EmCrCu4L9hjatlMD7mrubjd2gXui39URP+Fw3bT7Q==
X-Google-Smtp-Source: AGHT+IHKxeIgjOD+UITTYBTynIwOIDg5q4kWyvE5IdlEo9OtmpABKWY2ENZitVn+rRa5JsFAa3mjgQ==
X-Received: by 2002:a05:600c:3b1f:b0:43d:83a:417d with SMTP id 5b1f17b1804b1-43d1ec8d85emr93313595e9.12.1742089660960;
        Sat, 15 Mar 2025 18:47:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe658d4sm64523505e9.33.2025.03.15.18.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 18:47:40 -0700 (PDT)
Message-Id: <pull.1883.git.1742089659610.gitgitgadget@gmail.com>
From: "Han Jiang via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Mar 2025 01:47:39 +0000
Subject: [PATCH] doc: add missing commit C to the graph for --ancestry-path=H
 D..M
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
Cc: Han Jiang <jhcarl0814@gmail.com>,
    Han Jiang <jhcarl0814@gmail.com>

From: Han Jiang <jhcarl0814@gmail.com>

The graph for `--ancestry-path=H D..M` should contain commit C.

Signed-off-by: Han Jiang <jhcarl0814@gmail.com>
---
    doc: add missing commit C to the graph for --ancestry-path=H D..M
    
    cc:Elijah Newren newren@gmail.com,D. Ben Knoble ben.knoble@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1883%2Fjhcarl0814%2Fpatch_ancestry_path_doc_graph_20250315-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1883/jhcarl0814/patch_ancestry_path_doc_graph_20250315-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1883

 Documentation/rev-list-options.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 785c0786e0c..5e5cedb9127 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -640,7 +640,7 @@ commits affected by that topic, we may only want to view the subset of
 -----------------------------------------------------------------------
 		E
 		 \
-		  G---H---I---J
+	      C---G---H---I---J
 			       \
 				L--M
 -----------------------------------------------------------------------

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
gitgitgadget
