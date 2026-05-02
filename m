Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEAC17BA6
	for <git@vger.kernel.org>; Sat,  2 May 2026 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731360; cv=none; b=YadWBmILgWX/D9RFoo81JPAPK9eoLfDo8xFMRury2ki+XbEgchky6vDZhzQXW4QxlZObRGAyDmCtkBUsouzyY0Kpl8wXs6qMjnJYTFF8kj66YJdUKf3E7Ftj8RvlPD2W2Dtzd+qJF3EY/brZJsmsL+Xpstekg93LP99qVPxSquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731360; c=relaxed/simple;
	bh=pGYI2yHB6iNbUDcWW3MmzhlbJt8qa57WgTQ86FQbRpw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RDFiyh/SRJ5aTRQR9fqPb/TlCSakhtPlcwtKL19Fk/1H7X+8FjdjEpWqBF3NgYtvO4b/O7kb4P1MMvT3gGgLxU9OtGzI8IpKKmy0p+Z9HIENRtVBgclLvWBjy8RLcFAIw+P78bqB0FrWL7w/BqaS1Tw7Br3+Y5UYckA8DYuVaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiPo8zXx; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiPo8zXx"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2eadb000b8cso5243900eec.0
        for <git@vger.kernel.org>; Sat, 02 May 2026 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777731358; x=1778336158; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqL721R/3BLtbgB4nBtjFCukY9ELCHvXq56YlUTGhho=;
        b=qiPo8zXxPtVkU/7e0HUSCw0JVDN9Oz+jl1zDU39ckOATggpgEvsJsdEzk99B9IqQVT
         xpzVmGm0qnNecnODBBmgWWUNAem1LGJ4S+C9VO8gPpInq/JnwKa8wIsiBnwjJ2+jJt75
         O5C0iqgiFDfKlw+codVAinvOHkRQiq0ao9EExNdkUb9tM+l7L+dkDz2ZJgi5YlORUJSf
         72RYcjojYKN/07+lCKx5WWMSMI9KVQRspf7GmYan00FS2gAwqzbS9bGP3f7cYsPPtMzb
         fpP/WmLwwr18FSdIPEJj0GwCTrTtGx8sAAlgALbqut7TNu5B6YK9n29zltMrMf/LbF1c
         baRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777731358; x=1778336158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LqL721R/3BLtbgB4nBtjFCukY9ELCHvXq56YlUTGhho=;
        b=FonSwkLEahywBO+b2pnKDRy7IvgXiCWYIq9E/q6SB9kni8mWNo76bR+gmyjqCSvxDu
         cDwYWFY+sgwbczvEZOPSaQnrHgke1yr94rqr8936PGSenVGElcE/+Y1ruRg4eDRh91lD
         2VjScAj5OIfDnfUXsCFctgEPiCu6LsKXiRDhNumU0Sg63lj39815YmtHKYs4NfhWFGpz
         GNHcARPyeUsMB86NDGBOCgUZPD7sllpUHHI/g7Jat3kc5jtgCawd38nLVusDSzAKSPdg
         kGmJtngcfdqUXkwNOVHZsaWESao/PGPPFHbZAo133pX7nP3DSGUeqdW2UXeAq7ELQqwJ
         hsVQ==
X-Gm-Message-State: AOJu0YwDGNG+MwdLbxN6DVJJCLKxvcnv1Bhw7I5BKvlHFvuBXbvuSwIs
	rKjQPjivJhThvouPOAXaZHnp9X1R/aVdJd3fnLPRIGI6OlQX0k7q3fkHZBgxpF56
X-Gm-Gg: AeBDieu3+Jn2fPM3vvsyUMzAWKNcKuJ0ilkeA0mcjDxtWa2qOR2sAzJGxOPhHDSu81p
	bLbfH/WUagos9HFBur00CopqrGOf7ZEVhvC12mW/H6iykP58faKw/LuxxAE5fTXRVT1oCDYD/iA
	CvbjYHqJlvqOvxg1JW2sOnv5DZ1maaZb5rptr8Mp1Qq8yt7r8th4oWTlO9ihwkfEuGKaipGj/mu
	4dmBrzDorqRkt9P1qmtGAvD8F3ACPDrNuH1nDYtgJc7e9x1gHmP1Avmb96L8a97S0fOKSxikzyb
	nraN4qzUOEQdwEguKEW6k/2iHzQ9ekAiGh+t0IumJRh2QnQZXh/vqLVomMmwTfMf91Of5s/4a3C
	j3skpEaUAdmAXcvR+HDMlSyHtyK5L0hjyXWrBcee4uq9ZR3q34JC7Mmr1spfS3o6Eu0Lm4wGFyy
	6Z3QaGsqyIiiLvj6wvuOrYDKzjd+if2xrnIiwD
X-Received: by 2002:a05:7301:6592:b0:2ed:e12:3771 with SMTP id 5a478bee46e88-2efba5a4258mr1260622eec.33.1777731358116;
        Sat, 02 May 2026 07:15:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.216.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b1a4sm8627057eec.18.2026.05.02.07.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 07:15:57 -0700 (PDT)
Message-Id: <29d2797440412bfec85be7b6a6439350b9ebf5e8.1777731354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 14:15:48 +0000
Subject: [PATCH 1/7] pack-objects: pass --objects with --path-walk
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When 'git pack-objects' has the --path-walk option enabled, it uses a
different set of revision walk parameters than normal. For once,
--objects was previously assumed by the path-walk API and was not needed
to be added. We also needed --boundary to allow discovering
UNINTERESTING objects to use as delta bases.

We will be updating the path-walk API soon to work with some filter
options. However, the revision machinery will trigger a fatal error:

  fatal: object filtering requires --objects

The fix is easy: add the --objects option as an argument. This has no
effect on the path-walk API but does simplify the revision option
parsing for the objects filter.

We can remove the comment about "removing" the options because they were
never removed and instead not added. We still need to disable using
bitmaps.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dd2480a73d..4338962904 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5190,10 +5190,7 @@ int cmd_pack_objects(int argc,
 	}
 	if (path_walk) {
 		strvec_push(&rp, "--boundary");
-		 /*
-		  * We must disable the bitmaps because we are removing
-		  * the --objects / --objects-edge[-aggressive] options.
-		  */
+		strvec_push(&rp, "--objects");
 		use_bitmap_index = 0;
 	} else if (thin) {
 		use_internal_rev_list = 1;
-- 
gitgitgadget

