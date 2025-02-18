Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22626F469
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895888; cv=none; b=s/Hc9FzQfm8JnQt4j7KBWjFTp0ncpzVu8tfaADpUHIsA5SFRuKrLdG8kOjXZohCIN4jvkKwwacGSJxRPP+kEMVAXORDyyeYjdewG6MDXROQqE/NDatIsWfK0wD0MsWZZMNenqW6jNdFlO9LaFWl7LGQE6IElNb4pGPbZadiCR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895888; c=relaxed/simple;
	bh=27gytcY1iCgQodLcrldIKIbF14AesUFaoltzye8Bq/M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=psgfmAwHaqcWTRsN3KjSnImHt+MCgo1pny1waH5CzphcSHSxRW2S3svaS2QAdzQiFaG7ujnFaZPX5tMWyYaj4xJR+CmmOrSOavrTswckoOjG5/Ztbf0czCcdJYnHvqo3QRU+NojJJb225dDHUxe0h+5kdnEkeloaaWGtxwLT6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC8YRvgj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC8YRvgj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394a823036so59555715e9.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739895885; x=1740500685; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOJwhIyFoZwHfX9r8sLv4CLLdBHhe33cH5JIcOQ4Ffw=;
        b=kC8YRvgj4v3l8MbIiXygUIcXA50IkOWnCoVY8aqMfw6C4OYL2ZyIYIBb9kS6z8UTCv
         Ida6Sp6gekcPEKhRCnwTjiqDHjYw6rzj6SEibvSoWVVe1dwJZe7grVSX0UrKXzFaTEn/
         ms3WoSyrG85+m5HpgUPLpkq/zaH78UR+/9ItgHTvaxSep2D7IgWXpwwndKBSXiQTJa1m
         venpuVUetr59gkWHW8gVAtWQBW0AHIHRXO6AmrmEbeLDewSaktRU6J4SqvBuSYo3vYp7
         n2Ovtu8/XPw2kYJ78f6IQLz5e6k5DpOy1oykBHi03IEkYt0NULbw7gkoGbvu8Q2xVT4o
         OO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895885; x=1740500685;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOJwhIyFoZwHfX9r8sLv4CLLdBHhe33cH5JIcOQ4Ffw=;
        b=bLbBqTgtixuWqNuyckxomGo7ZSlPWYMIm+TSmjy2pp3SQa3jRLvCyKpnB+NklZJNsP
         O3y2QLnP3ch6diQXq47gBDNQXBmwVhgLeN6NDkiNKzuwhg5ScH1hBDXBC3heOQEslRra
         l0xjdiXGQGqoo2fPlZ51oOQ9UB9Lsz80yFkv3bjgpvByQQCbEfpdONdPmZiBDStJHysP
         LpnkK/sd3XWUjppSCVyXi7eqiRNt+b/63v5fnqUhLr+45YsIZpH+FWX+i4bLEogoZ0Ep
         s0Cw+TOxp+X0PilLz+ugWJ1qHCCb7oBLUnPVPqq/agDfN20MRQ8YsF79W/VVJVo54Nq0
         v6lw==
X-Gm-Message-State: AOJu0Yx3/DgPUb1lnPs7nhDsbEIebTlzb/OrQ0D5aP+aAWavX1FlszK+
	L7ZIxHHQq5/iiA74wg/8RPwNHsz+/SCxW+toT7JURUPFu6DRUCb3Ozjc2g==
X-Gm-Gg: ASbGncu0zkfh/FLxckiISKJoN7LzatsAiuYTLrrmnuC5Iuirg+XrnedGBuxx0LTCGDs
	dmNzE6dF2WVhDlUNanDnZTasQ2UFRZILLSv/1T8Xaq71hIemw5yOwHESikPAB/V9XqFAb9B37jU
	HgiYpnkbRh+Va6ET5h/bxSMIl5QZCiwcvbtWVaFuBtouPKEgr4wWw6s3JAIYOszIXRXFxhFjDYR
	6Hi4lMygZv/s65Vi5GqORiz4uCOhHTGUJ2Zypd2U2GpVi1vYZSMh3BWA06kKrlZO4Oe1HPVMpFT
	owiK1TGuR81Hmy7h
X-Google-Smtp-Source: AGHT+IFZlJc0qkAI8HNz8o6+gZFwIx4B62Ebiwu2kdMQttyAcEn72kZhfYS3J6mqjTjz1aYss+hXXA==
X-Received: by 2002:a05:600c:1c96:b0:439:98f6:8bc8 with SMTP id 5b1f17b1804b1-43998f68d3fmr9247115e9.26.1739895884270;
        Tue, 18 Feb 2025 08:24:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5efdsm15225212f8f.43.2025.02.18.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:24:43 -0800 (PST)
Message-Id: <1645b0e747e9bd65147bb0bc4123cfa32ca68818.1739895879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
	<pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Feb 2025 16:24:38 +0000
Subject: [PATCH v2 4/5] merge-tree: improve docs for --stdin
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
    Phillip Wood <phillip.wood123@gmail.com>,
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

