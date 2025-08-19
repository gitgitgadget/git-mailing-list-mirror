Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13B353347
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641037; cv=none; b=G2SsOSRLdinF2Kqz4LpuKoMSj7xWYK0mtP3NWYoEmgp6QyUM58e/Ev8X5YxnoOrynVgBLlA0y+9/EaoZZWZEgI8O/SwWcBeCmrk95gE7DFVcdkLYjJs91fVnZVjhSL3QDIOYB6pRgT5DNlMqCeaN5rbfXwbDvwbP+9ApUWmYtWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641037; c=relaxed/simple;
	bh=vBIccZzzwFbXHMPYzVxFBnWiPqg0bFCrN2UFvuPjc94=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U+O0v7IED/qqbrKdno51fOyI7dhdK4FO7jtk8P2dYbGmhGlfOSq0FakIS6O1glh+37Lg64Qp+3NfqCqV3o+JirXlHmtnA/xdB3kh/WYJ4GlwCD1/49IvdvTy7B6C8I9pQS43dj0geAFpwcCsqXyIoVfRZITCh9OE8LLMLmY7Z9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXBBfz8E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXBBfz8E"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b0cd668so31115325e9.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 15:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755641034; x=1756245834; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A15Y5RcLKbBuRSra8NHjFYZVBfqQ3BRTv6nBg7jBKHw=;
        b=MXBBfz8EvEjWoCJMu7ar3EKzT1kRNoCukT/v0yIl9dK27wxM7fuzBiRDbqF80haqw0
         2fmz2mdPzk8uD6kOzP/HBZbx2WzpiDVqtW0z5g0AlcVg+5Bz0WVFd/X2Xn+nNsipLQZJ
         nRnRWXIZKZqwibR/TSh4FlAmbRldv98PdzquNcIxbIbsHjWEBVqpue0rwsC5oq0XOBdS
         Ap7oit31BfgIdWwzQ9Ns5c+6ypDaMptKM0JWiX1ohObVorlgDYtQ7yF1+hyJZrxKqa/S
         pV6pHnUwF7gPN6Mt3E4PEiPNDuLMIY8JbVww7iMr+n2ktulQQSpcsQajiNuf76djmVqN
         r7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755641034; x=1756245834;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A15Y5RcLKbBuRSra8NHjFYZVBfqQ3BRTv6nBg7jBKHw=;
        b=MBtnbvkwbvxcKuVRokIp5ABJWwcqXlOqBqPQp4bnHWLzRZ5flSdhzLf7gMus61ElTM
         52QS7ypxDARzoGaI78rKDfE5P+YLmDotOKS43vh3Ka0eCpc1s8weWktZbPZHl3qX7qPv
         WOau9KuVTkhqws+3R7irK5em+FBt/GYMfelKEWAK3Ek6/29u6aR00vXNqnIfTyoxKnFB
         rRC814Id9/6tazgGgXww96DQS4rNrSZbf1BcmxNTv19O0+BFdW2im3NiUc1m8cgrPmn/
         B1Mnm36+G0MvQJVfJxaoVB23nkrNfXeWIMaToIIoOjKlT/hjld7v+S9uScb0/7XGEeoQ
         1Gyg==
X-Gm-Message-State: AOJu0YydbuuD75tAjyiijaj+gr+wZsx1OIm9JuNPAspEOKBTEC6vd7WH
	ASx7BozoqGxtJqd2FUtfqYNe+9FNPf7Dg4VEuycRb7oDiykZNB3P1cDZVQ+xf+wr
X-Gm-Gg: ASbGncv87LM7Yvzynz7t820bSrUZ2WFEehI7P5/dQ4Q3BCjSzUyM6MdSblLKY9vZnoX
	oES08CU5ML6MUjjClIZzLXBqkO+11yHE2no+MlgpmIGwoH64Crv3iGxpRWYANJfL/+MztArfFMG
	JKKdxYb3ZcCcobJdbo7LEIEsdUBMw9uSB5YGEtNAvMIsIWIK7dYVEHf2yA3Ts4QYF4N/Yk+SNQa
	gewT+jlDbzyLRNresbJ4jjiPc6oQVOb94m244yEksTMCtTSQ2wlv5h/1McGKGeqkqtD9VNJ/oYG
	Aj31e7Fjyfwn3nSSf8v5Dk5m2H7cYelb3NeNP/1bwNHMR/or5keghRNOlVQ7HsQUrEOobaK6hwO
	3O5/rdGlY0fUJTqbiAcHOum2t2xbZwPc73g==
X-Google-Smtp-Source: AGHT+IFM+Q74E4K11B+u9Ew8wv8r/Or1CFNLW9u+r+wR69q8r6zbGYsZFTzdH5jGMSmf+McfH4qtKA==
X-Received: by 2002:a05:600c:3b09:b0:459:e440:61c7 with SMTP id 5b1f17b1804b1-45b47a09c5dmr3817705e9.31.1755641033427;
        Tue, 19 Aug 2025 15:03:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c6d857sm3211715e9.26.2025.08.19.15.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 15:03:53 -0700 (PDT)
Message-Id: <pull.2033.v2.git.git.1755641032154.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.git.git.1755630128134.gitgitgadget@gmail.com>
References: <pull.2033.git.git.1755630128134.gitgitgadget@gmail.com>
From: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Aug 2025 22:03:51 +0000
Subject: [PATCH v2] doc: add discord to ways of getting help
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
Cc: Daniele Sassoli <danielesassoli@gmail.com>,
    Daniele Sassoli <danielesassoli@gmail.com>

From: Daniele Sassoli <danielesassoli@gmail.com>

Discord is a great way of receiving help for members of the community
that are not on the mailing list or not familiar with Libera.

Adding it to the official documentation will aid discoverability of it.

The link is the same as the one at https://git-scm.com/community.

Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
---
    doc: add discord to ways of getting help
    
    cc: Collin Funk collin.funk1@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2033%2FDanieleSassoli%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2033/DanieleSassoli/master-v2
Pull-Request: https://github.com/git/git/pull/2033

Range-diff vs v1:

 1:  922c291fc5b ! 1:  ed4fef87be7 doc: add discord to ways of getting help
     @@ Commit message
      
          Adding it to the official documentation will aid discoverability of it.
      
     -    The joining link was generated with a never expire policy.
     +    The link is the same as the one at https://git-scm.com/community.
      
          Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
      
     @@ Documentation/MyFirstContribution.adoc: respond to you. It's better to ask your
       conversation.
       
      +==== https://discord.gg/dxGanGcBSP[#discord] on Discord
     -+This is the unofficial Git Discord server for everyone, from people just
     ++This is an unofficial Git Discord server for everyone, from people just
      +starting out with Git to those who develop it. It's a great place to ask
      +questions, share tips, and connect with the broader Git community in real time.
      +


 Documentation/MyFirstContribution.adoc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index aca7212cfe2..35f18ab9f7e 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -52,6 +52,15 @@ respond to you. It's better to ask your questions in the channel so that you
 can be answered if you disconnect and so that others can learn from the
 conversation.
 
+==== https://discord.gg/dxGanGcBSP[#discord] on Discord
+This is an unofficial Git Discord server for everyone, from people just
+starting out with Git to those who develop it. It's a great place to ask
+questions, share tips, and connect with the broader Git community in real time.
+
+The server has channels for general discussions and specific channels for those
+who use Git and those who develop it. The server's search functionality also
+allows you to find previous conversations and answers to common questions.
+
 [[getting-started]]
 == Getting Started
 

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
gitgitgadget
