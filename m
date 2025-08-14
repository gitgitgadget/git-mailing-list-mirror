Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37024293B
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177387; cv=none; b=Rlp28bnsc8ggwDoK6DM3qZJHVpP81HYd9y4f7ri2+OstwbOxqHLb549VmhlqPIC6ZP0XhgqBo9AyXNX9qDRVF6tfq7EETpOPKjXLc4cvvqMDTUlh5gaukT1tqSbwLjhm4gLfoEG13sTjwg48X/Ltp4O2XfhOK/iKsP4w6PBxZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177387; c=relaxed/simple;
	bh=Am47+42ayxLjIlzeYQbqaKyhlQndEJ+Fqsl5pRF4r/0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NuLDsK3k8ZYHWj2upO5Lc41DaobN3YGv7Avz/gtshoNs9y51qxW1x05AaQacLDkVZQLf2piAPvajng1oEpnuXIqxJe1og+y2FNeym3EnNH7EXzW99/Ckznj3b05JhvVIlu0I+0G4EfzOMrPiAM7qmRuRqpL8luRGX/uy6+fQn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRDJqvgk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRDJqvgk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso6292515e9.3
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177384; x=1755782184; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNS6S3V8eA4l89MgR4u+XUQN2RzvuZRrPOfUY6ZkfHw=;
        b=fRDJqvgkkTwjX2hjIHot/zYmth/nkiilHlXYBO2NFT1EW/TzB2eY1M/n/TMTtdZjNe
         BhwtPWuzWflIBq7bt9QcCZjDThuPgFCIeYGxGlPjFiiXPZM4/Cyt0BWMtAHcvOfBpd7T
         cS59GzqDSZUl9bXAtVYq73imkX5Y577TfXsnslaCW4d87oq3JFkJxYn2n3eMkFm44Ena
         Bi527L+d37xIo9i2dwvWf/rOdqnYeqV8oCJUg6qzr7lw7JsrK/2/QjlImFvnrOnOMEdS
         73pqpIAaHNFrBTlddleqT94t8WCQlqXUYg0PzVMYUJCZB4nygiUkld+DveblG5fE/TKi
         ntTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177384; x=1755782184;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNS6S3V8eA4l89MgR4u+XUQN2RzvuZRrPOfUY6ZkfHw=;
        b=Opr+50hGRXEab0gNZlSvEzviymmJscXEG3n5GnSiKGqdBhIePIbt9oPeJpSBC+WPRv
         gbUYpZEUphh9HF9XmCOGa4T4Vcx2kEUSZH4cu04uoYzMhYJ1WhrsrTx83zM4t8OabIpB
         DkM8OuAMersHYlhZEGfc4pTP3+5AurkNpr4COe1YtLqPeLYjVtlILKyyGT0jYeKC+FgK
         UabcQ+G6w811/jAD43Va1B5lvgrWt5Jvo+1x1OnbfkmAEVOF1Em1cx1fW9ZZ+YvvLVmx
         zJ1TLlplaD0x0UQtS7U66iOWEH09LLKwMdAoyM+2v94kCn7ljmAtyj7kfZGMEYDWFqgp
         Jt3g==
X-Gm-Message-State: AOJu0YyaO0xGJsoF379AkBsJvJRuMEjvWBE8Zzp4BXXp6/wsuhXMoQNU
	uBQSuHI9mWGbvA92XfkH6BZQ2g41vh7cB9AxcCBOG9jrpUx0jGBuRsJMbc81vg==
X-Gm-Gg: ASbGncu5QnR0uXN2362/+KMq9mlYqd5wUEU75dh8qjkUA+Nt8DpXyGaAYG/bgUxdWFx
	p58Gb7Clrw/pE+XBGmCL+u62wCYZKHIT+/10dcqLYJX0w83Z9PeuEEK0P80EMbvKLxvzVnLNq9D
	S0m4NNzA6pmfRQWd3+4DtlnLDgF2eqrHIHeCQ2ezPqMb9VUaWvVS5IfMrZ6U8jLAcuwVoWSHDRc
	rEa2pHulQfpZEhORpZI2Vzv0ocixHMem1pZFbvVAMY0RLsPdvesREe811QbZse0LPucut8lw1Dz
	5MbHVe0z9J7GJAw6veDo2CHn/Dyrv2TKDdMKur288zKSdipYocp3d3hRmZEGHnlWoKZAXPYV+Ql
	hbW3iOiplz2WmE5FD7zkfKOutF7yLVThdsA==
X-Google-Smtp-Source: AGHT+IGyTFu2dQIuwwjDAzR8mkM+pJEUVRFYfflI6hc4j/5J3C4nXg80o+T2REgjXu2bIMUD8tvc3Q==
X-Received: by 2002:a05:600c:138d:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-45a1b6697d0mr22070875e9.19.1755177384067;
        Thu, 14 Aug 2025 06:16:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453ab0sm51204872f8f.44.2025.08.14.06.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:16:23 -0700 (PDT)
Message-Id: <pull.2031.v2.git.git.1755177382349.gitgitgadget@gmail.com>
In-Reply-To: <pull.2031.git.git.1755078045397.gitgitgadget@gmail.com>
References: <pull.2031.git.git.1755078045397.gitgitgadget@gmail.com>
From: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Aug 2025 13:16:22 +0000
Subject: [PATCH v2] Document count-objects pack
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Daniele Sassoli <danielesassoli@gmail.com>,
    Daniele Sassoli <danielesassoli@gmail.com>

From: Daniele Sassoli <danielesassoli@gmail.com>

0bdaa12169b (git-count-objects.txt: describe each line in -v output,
2013-02-08) forgot to include `packs`.

Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
---
    Document count-objects -v - packs output
    
    https://github.com/DanieleSassoli/git/commit/0bdaa12169bca5d69f2c58f96cc92d51280e9e26
    (git-count-objects.txt: describe each line in -v output, 2013-02-08)
    forgot to include packs.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2031%2FDanieleSassoli%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2031/DanieleSassoli/master-v2
Pull-Request: https://github.com/git/git/pull/2031

Range-diff vs v1:

 1:  85bcb142b55 ! 1:  6f0394651c9 Document count-objects pack
     @@ Metadata
       ## Commit message ##
          Document count-objects pack
      
     -    Juno added the printing of "packs" with ae72f685418b.
     -    When 0bdaa1216 refactored the docs for the -v option, this was missed.
     +    0bdaa12169b (git-count-objects.txt: describe each line in -v output,
     +    2013-02-08) forgot to include `packs`.
      
          Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
      


 Documentation/git-count-objects.adoc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-count-objects.adoc b/Documentation/git-count-objects.adoc
index 97f9f126101..eeee6b9f7f4 100644
--- a/Documentation/git-count-objects.adoc
+++ b/Documentation/git-count-objects.adoc
@@ -28,6 +28,8 @@ size: disk space consumed by loose objects, in KiB (unless -H is specified)
 +
 in-pack: the number of in-pack objects
 +
+packs: the number of pack files
++
 size-pack: disk space consumed by the packs, in KiB (unless -H is specified)
 +
 prune-packable: the number of loose objects that are also present in

base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
-- 
gitgitgadget
