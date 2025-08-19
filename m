Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF40124A069
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630133; cv=none; b=JWb85Hlcnfcdv3ZIVR7WmVqim0Fi58bOmee6lPfn88oxFnOtMH9GunyVrJV6WJKFUU4U0R6q0rsKls2nq809wnTgYTW5gcbcO4qjjy1vtHyAesAcBspNnWe5GZLNO6r7KVd4PC1wQuBWLYRV/zUEHK4Vae58RUte4kkbCD3Ps7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630133; c=relaxed/simple;
	bh=+VERXH6CXTXjJMP5aoAQvsgnEfaIEQzdrJ82Jfvt/ec=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jYmgBW/bx6Yu4dTtmtj2j8JNtjR7PaE+7WpupQDPULdjtB8LaurheshaEXRHR5Mx83vEYpKEoVJ7124vM63viLenmu7gDMnzQ4rLdISr++sQH0G8qzvXfZ3xk3zwJxDTPj+r74lMjQwfa4ygIsYVhcgX+9qmNKqC8sGAZmFC8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5D1zWvu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5D1zWvu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b46a332a5so2879015e9.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755630130; x=1756234930; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6QnrKGNDNKFhsPtbSgAb3c43h8zNstoxtep0YNl0skA=;
        b=e5D1zWvum776HwhpBe8s9e6nIGrNXP46hYfWzsOMCS9yNiHDXCUHatIgY5sxfueSqz
         +BrH2Hu77Nvr3aRD0hZGwIIxpAdDYb4tmWy6sbwY3hG5QzZ1/t8uDO+MIPeD1lL3Urht
         1WYMYP2r6rXY/qNdL2U0zFm93DKyqotbNAp1sIB91gRdil1A9xnEs7vLXkvspj3VbtId
         WrS9k+j/8RX6yktvD210AOxe48s+vDq/I4acyBY7GZKmujN55/QHjGe/leCLeZ2ROZEi
         f8IvqTpGRDfqrrtCzdTp67a/lpTwNeF3Ltvad5u6kbUO7uPyz6+FiEn4TT8UAD/u7IKc
         4nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755630130; x=1756234930;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QnrKGNDNKFhsPtbSgAb3c43h8zNstoxtep0YNl0skA=;
        b=mrVVcq92b00Ualt/IOyUobyvCNDQzxyoKZPHGlj+se4UQI5tglkJmMYFNZ4zLa0BZk
         WnDJrBLVNKDsbxvuBV5eqLx/nF0I63r6UGLWSjvmFqTu3qhv9TIfJmRJDaHX2q8489iD
         hui+CJhpCKIURbV8054iTcsDCOiMKg4GY0MbuWXYh7KcjTCAq6PS32eMxig1p7x562yx
         cCpKUbgk+/Jo79bBWB/g8ZtvlsAgoVvV+N3OIx6WmIJrngbGEliDxd8ZaTLxsgwxz5WV
         /pwQJcbL5Dv2Y6IhG6qFzjsmoyKzMDt1DBOCwpxSYiutS+FLRZbmMSmXLH3cfSBZL6ay
         LAvA==
X-Gm-Message-State: AOJu0Yzg9RS9SklDe7D7qGX4flLyJXtpV/uFn7bjpl3b/TYzdH7Abdyt
	561F/kU8vF4iS8OFDKFkkyL6wnRb4jtrtF693+hbeN3YO3ANO91eVV28NMJDeu80
X-Gm-Gg: ASbGncvX6RZvSnpS5sJzIJFpB1V3ew3KbEg7nSfxSmo2MYv2SDZP7QysbXPMoIbnnmW
	w8U0/60kMNPqbAfJb2MngNMEnfB87GQKcYnOLodLn7lAO84L9p+tUT96ejkAnsPCZ5W/3SuP3mi
	UoBKjVBZxavMv/dgRxZSCAc+osSTG4J/isBOS+GlflaeOa1ee9AIoEMEqf+P3Hn94rF5b6xd5Qc
	aIvEd94ACQy8FDzz6/1F16vi+A5w57Dk1sQT5nYFFcxIar1KT3LWgayZhwuAS+r2BGJG/LXENEk
	bfYl3glncUZjsSAIDAV1f11DehJNDqCa1phgguG5E0TWERwrCGaOT2/BmSErE8ovC91nY9XQ+eR
	cO2qSa5Y0YzUht654YxMK9BiEssQBsAuI3X4tezmtDXAZ
X-Google-Smtp-Source: AGHT+IH1DbGNNMckeaayMfA2W9AiGF5xJ52/9P1xMFVMAZ1Hmjc1qr336UdkO1FWZJ+kpNuw9S8/5A==
X-Received: by 2002:a05:6000:40e0:b0:3b7:9b4d:70e9 with SMTP id ffacd0b85a97d-3c32fb2fb8dmr64892f8f.43.1755630129490;
        Tue, 19 Aug 2025 12:02:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077788df7sm4737330f8f.48.2025.08.19.12.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 12:02:09 -0700 (PDT)
Message-Id: <pull.2033.git.git.1755630128134.gitgitgadget@gmail.com>
From: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Aug 2025 19:02:07 +0000
Subject: [PATCH] doc: add discord to ways of getting help
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

The joining link was generated with a never expire policy.

Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
---
    doc: add discord to ways of getting help

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2033%2FDanieleSassoli%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2033/DanieleSassoli/master-v1
Pull-Request: https://github.com/git/git/pull/2033

 Documentation/MyFirstContribution.adoc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index aca7212cfe2..0293a410289 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -52,6 +52,15 @@ respond to you. It's better to ask your questions in the channel so that you
 can be answered if you disconnect and so that others can learn from the
 conversation.
 
+==== https://discord.gg/dxGanGcBSP[#discord] on Discord
+This is the unofficial Git Discord server for everyone, from people just
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
