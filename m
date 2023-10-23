Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83042224D7
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2kR1uEG"
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1159B
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:11:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-313e742a787so2174727f8f.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698099116; x=1698703916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptiY9uGr0tGcZYfRLICQClF0krFFysLZ7VCGpBGmACM=;
        b=k2kR1uEGrI18i5maC0iy3g+2dSKIsOwiQSL9cT3wZC2eAnf66N4G80VEavB5gusXMe
         2P5xgVIbQzsvbC9P1k9BtAku0SIgKpxCCl7B9lt4o7y/ODqXzaB2+a8D3damuyzP8dqZ
         J2KEGRj4P32rTzn4vNKUnOsW5o9uI9DPCd7QhVluzefpj2ijEle7N3Wt+1Tt8RS7Oh27
         EJ85Yg7OKMET3AOjJtVZ4Z8w6wzYYG/4FlQNlgtkTAYAndS2Ivp6nHrYpa5BVgplavgR
         Z90m0MmOgKQmgiWm4HcSPeaKfj7woN6NyIdgIDKbV5ak748tsncbQbKXW6Q/QUs1ZsZl
         WTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698099116; x=1698703916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptiY9uGr0tGcZYfRLICQClF0krFFysLZ7VCGpBGmACM=;
        b=I2KwQzsDurczfoc53eS+AheHB4Ah350MOJvzdrqdzag2N6YrO7bnvKrz87huZ9DYC7
         6yIo10FzkMryIwxfEyRKvV0zbbfnbHxWR1htk4X9p5vwBi7SP0oF2YI+U5/xUvRYiQQR
         og6UGyykxh7FfpsL8sN5OnnmLwQv9Yv08MWx69h+YObsbqhen3FaCXVW95SZWyVH4dHp
         rctzCoJ01ErMbioODzbTkLKKlaiiTrqwukn+lg0GMEWoDegpNaPFXPNlPDChlS1Xy5zG
         Vr+nl8cLC4PcRN7iJWOUQA4MEqfLbsF3Y2tjdpUFwlFAkvAMWSl390/AlZc/UwrfLxMd
         tCuA==
X-Gm-Message-State: AOJu0YzGOXNmsHIUsJatFLMG9X8v+SyUaIXNMbwjAndzWL86vdJ6+cIE
	hm95ZgWxss+1QPeswgoSucNySjFnyIg18A==
X-Google-Smtp-Source: AGHT+IGT7Hxg0+ZGLev5gCqMecFXSZ8dcdvN+s+VQr8LnXHORsgf70ewSSAkGkvuMy8iXczcwH0kYg==
X-Received: by 2002:adf:9cc6:0:b0:31f:f8a7:a26c with SMTP id h6-20020adf9cc6000000b0031ff8a7a26cmr11127391wre.25.1698099116504;
        Mon, 23 Oct 2023 15:11:56 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d608b000000b0032008f99216sm8559953wrt.96.2023.10.23.15.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:11:56 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 1/7] config: restructure color.decorate documentation
Date: Mon, 23 Oct 2023 23:11:37 +0100
Message-ID: <20231023221143.72489-2-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231023221143.72489-1-andy.koppe@gmail.com>
References: <20231022214432.56325-1-andy.koppe@gmail.com>
 <20231023221143.72489-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List color.decorate slots in git-config documentation one-by-one in the
same way as color.grep slots, to aid readability and make it easier to
add slots.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/color.txt | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index 1795b2d16b..3453703f9b 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -74,10 +74,25 @@ color.diff.<slot>::
 	`oldBold`, and `newBold` (see linkgit:git-range-diff[1] for details).
 
 color.decorate.<slot>::
-	Use customized color for 'git log --decorate' output.  `<slot>` is one
-	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
-	branches, remote-tracking branches, tags, stash and HEAD, respectively
-	and `grafted` for grafted commits.
+	Use customized color for the output of 'git log --decorate' as well as
+	the `%d`, `%D` and `%(decorate)` placeholders in custom log formats,
+	whereby `<slot>` specifies which decoration elements the color applies
+	to:
++
+--
+`HEAD`;;
+	the current HEAD
+`branch`;;
+	local branches
+`remoteBranch`;;
+	remote-tracking branches
+`tag`;;
+	lightweight and annotated tags
+`stash`;;
+	the stash ref
+`grafted`;;
+	grafted and replaced commits
+--
 
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
-- 
2.42.GIT

