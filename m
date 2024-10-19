Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283016C850
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729356003; cv=none; b=n3/vZZhCG5k9faSJe7rejKBR7ZzKDKO9/1zzcmuvJm0ctFTdNkopW07/Il0DYsiMhAwbIL4rhVajpOEP4xTAlpUE46sdLIlACQegsAVqgIDK6pHBKU2qZ6t2QGo9qcBBa+ZyHwKjaAmsdf4RQsePu3SzHnrEwlfwSftSF+mVDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729356003; c=relaxed/simple;
	bh=oT94kswR180PlnAdE8Ti3sIZveWvFgBOKWe8EzVkpYA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jrKVPDGo7rhPzGzYRvW0Wdjz0rfgsNSBAQsUEw4eaOMYr50JXlx0QNwR98GXVzWCNnl/VoFo3cbiZlCiICoAdyWqcXpV6ZiuzOKjwB/8ePFi+zxfulfxAT8cSSvuB4677zAGxmzJMrLuyXXK/5YcT7CxcFLlfYDxPG7x42d3YsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IroiW2FY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IroiW2FY"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c960af31daso3513456a12.3
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729355999; x=1729960799; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1K3aVLQPojVaLAye5mY1p4yOsRGgZgJkgw9mWrhZzM=;
        b=IroiW2FYNPfiyWlSmL3a5dgO2bbwPfscIbwbVyoBJOGpgp2ox0dkxVf9ultJryogKq
         WL+rKC2tYJrM6lCGcPaTY0jZMDal/ZbqyrHb+UjvduPHo+XI4rRI9hoENU24PeMHtvL4
         CklV1I7p4e4MFuokWg9hH1vARJonILhQC2H+NF3kg4x1H0z0eDfB25uzu72Cou1oVNV4
         tZjQbqW8lr9xDJ9X5/4sF5WN/0Rbn0W6oeefe05VvIVc0o/uYan6mp45sQmjpchuQtM0
         JIVlFshlyR2Z8b6CIaD8Gu+n1Hk6zxqmnyzXTECTp1kmaFHYZbhuO6ywnT/TBxbv1VNc
         hI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729355999; x=1729960799;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1K3aVLQPojVaLAye5mY1p4yOsRGgZgJkgw9mWrhZzM=;
        b=ajiKOdeiraEhA0DKOn9J66/MmKFDZx4xpN7kgwuk14wOi417uJ34cjZOrFDMGMX7N3
         W2foWXyKyUiR6V7g6KtpkdVc67AyFHV8THDhv/SRymP+GizVfRF1Iq+NUBecowovLoBp
         2TMcn5k7Lt+GdAQGQqo92osKhREbyVG8c+iWsdg9GjJH7zXw9dye68RBOESQsi53ChPk
         Q8sbI5OQWRUoz0baQ+GmkUhQPhdlBliReGNnzn81BljaynDI1FAD1ttZkcTk81qEkBcK
         so4Qe2ECrMwQBNLuDKThMkXa1JAAFSF1mmuoWdkq5fEI6PQP9cpwjZRDDBQ4LJG4jJg7
         qgcQ==
X-Gm-Message-State: AOJu0Yze4XzmygiGO7caviYVWhSRkEWCy1AZWLQFclSKZQQY/AR2ccAi
	nQiVygZBOJL2vWcbXLbpQlKHa3APcfab/yIgPwzX+gP5Lc8buEZ2cHHcNQ==
X-Google-Smtp-Source: AGHT+IEf0C/wv0cTE87D0JASXUB7Ahmgt4YDjbLFsLM7EYsAPPZPfGmMD4Q+rhEktt8BHfmApUztYQ==
X-Received: by 2002:a17:907:7293:b0:a9a:dc3:c86e with SMTP id a640c23a62f3a-a9a699694bamr579159466b.11.1729355998705;
        Sat, 19 Oct 2024 09:39:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c2eb27sm228430066b.219.2024.10.19.09.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 09:39:58 -0700 (PDT)
Message-Id: <pull.1814.v2.git.git.1729355997353.gitgitgadget@gmail.com>
In-Reply-To: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
From: "Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Oct 2024 16:39:57 +0000
Subject: [PATCH v2] doc: document how uploadpack.allowAnySHA1InWant impact
 other allow options
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Piotr Szlazak <piotr.szlazak@gmail.com>,
    Piotr Szlazak <piotr.szlazak@gmail.com>,
    Piotr Szlazak <piotr.szlazak@gmail.com>

From: Piotr Szlazak <piotr.szlazak@gmail.com>

Document how setting of `uploadpack.allowAnySHA1InWant`
influences other `uploadpack` options - `allowTipSHA1InWant`
and `allowReachableSHA1InWant`.

Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
---
    doc: document how uploadpack.allowAnySHA1InWant impact other allow
    options

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1814%2Fpszlazak%2Fupload-pack-allow-flags-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1814/pszlazak/upload-pack-allow-flags-v2
Pull-Request: https://github.com/git/git/pull/1814

Range-diff vs v1:

 1:  8a2673bdf31 < -:  ----------- upload-pack: fix how ALLOW_ANY_SHA1 flag is disabled
 -:  ----------- > 1:  2a9fa4dabba doc: document how uploadpack.allowAnySHA1InWant impact other allow options


 Documentation/config/uploadpack.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
index 16264d82a72..0e1dda944a5 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -25,7 +25,11 @@ uploadpack.allowReachableSHA1InWant::
 uploadpack.allowAnySHA1InWant::
 	Allow `upload-pack` to accept a fetch request that asks for any
 	object at all.
-	Defaults to `false`.
+	It implies `uploadpack.allowTipSHA1InWant` and
+	`uploadpack.allowReachableSHA1InWant`. If set to `true` it will
+	enable both of them, it set to `false` it will disable both of
+	them.
+	By default not set.
 
 uploadpack.keepAlive::
 	When `upload-pack` has started `pack-objects`, there may be a

base-commit: 34b6ce9b30747131b6e781ff718a45328aa887d0
-- 
gitgitgadget
