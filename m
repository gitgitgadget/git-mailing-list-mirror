Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758C19D083
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723839; cv=none; b=gGOxhePOMtlYRMq5KBRe6Zr/xEqJsyrviOjn7urVAFAXVVpyXZ4ytCQWWwfPkWNovTnjlwJbm+FaDmJgLsFAZOs97ireFqUUnJIEr0OUNm3/RZa2/hYyCaOSWEuFbLZWLQKM/nGdPdtoRzPJJ7amCLMi7OUFo60cBBJsuCuHMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723839; c=relaxed/simple;
	bh=27gytcY1iCgQodLcrldIKIbF14AesUFaoltzye8Bq/M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fbVzw9oiZRzyuj6ZPpBUjpIx2YoKWiiDH3IBvl7drhCPf6QDI9wbiw+vgl/a9KZdcDwG4+pnbsw0XNI1etW61lA5G4iLDzsBJ3FvS4eBrJlGZwMrQPlDaGPVUWwSZ8eYYG6gg+BUkXEQnFMthO3Px1EuSOlPPPEXhaYTUThdpKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrTlplo0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrTlplo0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4395dddb07dso37717725e9.2
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 08:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739723835; x=1740328635; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOJwhIyFoZwHfX9r8sLv4CLLdBHhe33cH5JIcOQ4Ffw=;
        b=SrTlplo0J3VQaWcgwkWb9/R0wYdzWnyBNKA61/TdfdBI7GwN1GUXXn+M/JNFBJIcnI
         EeU+gllos8yseYAQ1RjpdiJsxAeTb1IWHLLLZZa321PfKCkNPrbulU/ZQxgGiuZfzjv+
         ZvjXbYXM7+GDKUiQ+K4BQqgeFz28uoKUudmJhKQQ6upKAXRBbtFfPbiTExi16lBCya7P
         h64LtLLBxJMyL2d/Bh1vdJZtzXWH2Aq8jV5Lyu6Ju2f7uDk3lDWJzZ+VOa3Rgv0ry78w
         kglRndlgtuxB3Hhu3NqOprmt4o8aSh57zkR7gztp0+BsX2ehsgX3ucXqsfdmZCEYlOtO
         Ib8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739723835; x=1740328635;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOJwhIyFoZwHfX9r8sLv4CLLdBHhe33cH5JIcOQ4Ffw=;
        b=mtMUpBa4m5sP/5kqCs8yxUBNzAygMx3fM8np/j8W8aF8qikJXG5jvM04gvxwf38XyK
         VbUmipKQQ8aiAKmOhjMOP8kndtc6dLbb1dZeuMocNlprFYHkFimYxW+H5dXMWF7yH2iD
         Y/bcg8zJ9qkHYQXZfZWemMriR70kJJht2yFihi+6KQY4P7jGrZH7zwIBjmnVRyFy78ut
         mvamckOdzi9yvg1XiQGhwjLUedq37gw6oC3tT4XBdUEWm34M8Cw/AdQpK94ok9D2ELze
         3Tj2+T6zgcOQLiI6vzdThN8UIobCIxVYrzlt0MqawVmnve4HvsdZpnKlf8GsPNXTSPL8
         xSBg==
X-Gm-Message-State: AOJu0YyAMZxhLJPCpBFspqC1ZvQUNpfacEP1seKSksxZo9bZPJbhL+94
	vncj6b0bUEIBSIwwh6c07snfum8HUXG0+qKCNJDurHq0CDvBBzfpr41WZA==
X-Gm-Gg: ASbGncvUxxdtLwQ4b/+D1AUNNRZ5MD6VRq8QkHq3dSvdYlgr54k7+BQgJh2kPPf6Qry
	+GPQrERpZ/WLJVzbEncjSAfbsu4zt0PmdnJY5nW1X9bwz8wCSI894CDVzzlofVUiZ/ckyu+8lV0
	mzZ7V5dR7/At3KSE3DMElKferib6L3GioJNOhxd/TLSR41uLvyLrzYhI6FTuPC9JZjyo8LGWUwN
	jxDxFMoJh6eTwjjR4Srm8K1cml0MTWZGJqU73wVt6TecbA4tFnFhpqrrWHWMNJGAA27lY8T5zl3
	bOJvkOOKX8tG+pMs
X-Google-Smtp-Source: AGHT+IGOg2jDn3Jm8tHK5wCuqvDZVIAomphKxWqTctxXTIg1dZgEe6Z6oJjBde90h5W5O0wxO5wNiQ==
X-Received: by 2002:a5d:5a4c:0:b0:38f:2289:90f1 with SMTP id ffacd0b85a97d-38f33f4726cmr5586911f8f.29.1739723834969;
        Sun, 16 Feb 2025 08:37:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccd3sm9976351f8f.23.2025.02.16.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:37:14 -0800 (PST)
Message-Id: <4c4168506346fa3eed3d01445980044bce6c14ab.1739723830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Feb 2025 16:37:08 +0000
Subject: [PATCH 4/5] merge-tree: improve docs for --stdin
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a section for --stdin in the list of options and document that it
implies -z so readers know how to parse the output. Also correct the
merge status documentation for --stdin as if the status is less than
zero "git merge-tree" dies before printing it.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-merge-tree.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 0b6a8a19b1f..efb16b4f27d 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -40,6 +40,11 @@ After the merge completes, a new toplevel tree object is created.  See
 OPTIONS
 -------
 
+--stdin::
+	Read the commits to merge from the standard input rather than
+	the command-line. See <<INPUT,INPUT FORMAT>> below for more
+	information.  Implies `-z`.
+
 -z::
 	Do not quote filenames in the <Conflicted file info> section,
 	and end each filename with a NUL character rather than
@@ -116,8 +121,6 @@ This is an integer status followed by a NUL character.  The integer status is:
 
      0: merge had conflicts
      1: merge was clean
-     <0: something prevented the merge from running (e.g. access to repository
-	 objects denied by filesystem)
 
 [[OIDTLT]]
 OID of toplevel tree
@@ -235,6 +238,7 @@ with linkgit:git-merge[1]:
   * any messages that would have been printed to stdout (the
     <<IM,Informational messages>>)
 
+[[INPUT]]
 INPUT FORMAT
 ------------
 'git merge-tree --stdin' input format is fully text based. Each line
-- 
gitgitgadget

