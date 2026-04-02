Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE144375F99
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140427; cv=none; b=gsbqf+4C2bqROxlqdSkQtUivXD333y6dvAa6UPj0qFLFQOhN8UbV/O/3SPhycEDCq6wt1khyhcxlRyF3jXj5YWkNUmXOnkaqxXwFhSqDXFynxVNCSijcses68uEF2ghDeEeUt3YjJHtAEVu+un+FD8qStarRe4Tdu31V1quEGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140427; c=relaxed/simple;
	bh=Ov8jqpAj6L0FeDurzPMMs2WrWSiOqjVjQmcWcJCEkFs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r62Jwlm/aeINGtbbdPhDN2KCp+4vLk+6C4PL1/9KMmcEo/MpzYUPh+OJiGK12rJij77gNBMJe/ajw5YSn0/R3Krn/Vpi6L9e/3t4zk8nm4Bw5Gsom64sXP6zEDNPvJmtu5R7PqNhWN07WQwtORCnGsSFJ/p7AC+2tNuYHKmisfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzxp9TBi; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzxp9TBi"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50919fc3a14so9412791cf.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140425; x=1775745225; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbndA/jWMkmYldpu8iy64Xea81ACg5kjKEO7Cm3yLqM=;
        b=hzxp9TBikj2tMrd8KFM5VzXWs6AVm+YBAVora/CYHQdsVTQA/NJxPyvuM9/623QLuW
         c9SIWcp4Gqq8jm7pUd7YB2PqBMV+GO6vpGdezHfbAiPeXgolj36eitGPiSXWhHDM4AU1
         uDzBoLx3uwPAJMxC0ZyjqeNx61cTJ5qlL0SvOTV54+pPlXPES3CNQn+uirPU0XIIomod
         HVa/+eCBTjHIxP3ziEx+XbDlYEZzXjXERLKqhaE+AIAi2qH9CxnuOp0LnuHnOZ9p9lcJ
         Yx3Go1dPgo3V3s7eyQ+Du8e9avsXYGmojl6+/cI5qy+8AQnaHBQ6BFrodna38ugr+aH2
         etwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140425; x=1775745225;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vbndA/jWMkmYldpu8iy64Xea81ACg5kjKEO7Cm3yLqM=;
        b=OcK9yq37AuXtYFGIc2F4ViX05ZTIPx1AD4WP0bxv4BIHt9zwbuRfsQ5FpIkRP1Im49
         u0DwQ8cWyDrZ74Rz3Qb2Ydc21IyJl96xpUh9OvYakuzXdpbWAwCYj0UvI44qect8wCSj
         I0pQKjXUIoAewZe9PAtuyJVkIfz0RBZPaNY0pHcuTBOSz3vA8jyhl4IgHYntXLCTzS25
         0MKjAoJ+ywy3vKZrEAhz1wbz9C3gl9W0y+3fCDPJ/vK1EIxajahIvybjHnyFz1twkPg7
         TLXCkRsYqGYCAneJweWL3tmE08alWkbvwxjY9tqWYoF8yFPTgBedq2jD2JAKODzgvEgp
         1zMA==
X-Gm-Message-State: AOJu0YyTlqJxhCIach+bcKvUJAnWSaaO1lb4oNHNfG932gb8iEyEXViW
	njzDxz3oh0XC7ippeJPRopZxGgrHCS+WSLfHyQGeG/nKiyrSFIUEpPPsUX1O9A==
X-Gm-Gg: AeBDiev3jCgP3JEoYWwbsIPKq5sB9nEiP+juUNX0UbRQv+9zzeOtVU8n+za4di0rz56
	NJ7/R/pklx9kILC6Ho6cYeDRMklJde2DiGSCO6meFfYsn4SyuLAo4D6u1oiPs9acHsFmjWSyLfw
	fSBneZ1uPnJ/Q8MHqxUWNosaue/5BsZh4ykEKq2vShoV6PNliEexslJfqHcOhhat565kN18pENb
	sYvB4S2E91uzV9AnwvAqhzU6pspadmS3lZ6ovUwLotEGrVlbCxlb7KhqK02ExdvkxqtUFMXBJQ6
	yIBcD9GMGRNWtu/n8nBivrL7sZySa1PgKFDOKtK4oLN3SsOBx3FxmpM3whrCbygj2MmswZ1mKzj
	Fl5elkk3kyDgNqev3S3N7GYuNCCwHq/tiqcwB8b6IHPEbr6qzH0kOAs0GgdrYlH1mXOVkX2uuuj
	qgV+1pbtrBSjM6FW8DrLbMH4aSqMo=
X-Received: by 2002:a05:6214:3f8f:b0:8a0:846e:8850 with SMTP id 6a1803df08f44-8a437722718mr127342646d6.20.1775140425473;
        Thu, 02 Apr 2026 07:33:45 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596a0a655sm24158876d6.29.2026.04.02.07.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:45 -0700 (PDT)
Message-Id: <1ae4caf1559d23d32c72fc1bf94c5c0025baf7c4.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:20 +0000
Subject: [PATCH 14/17] t6020: use `-C` for worktree, `--git-dir` for bare
 repository
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To prepare for `safe.bareRepository` defaulting to `explicit`
(see 8d1a7448206e), adjust a loop that iterated over both a
bare (`cloned`) and a non-bare (`unbundled`) repository using
the same `-C` flag: the bare repo needs `--git-dir` to avoid
implicit discovery, while the non-bare one keeps `-C`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6020-bundle-misc.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 500c81b8a1..82df105b47 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -594,9 +594,9 @@ do
 		reflist=$(git for-each-ref --format="%(objectname)") &&
 		git rev-list --objects --filter=$filter --missing=allow-any \
 			$reflist >expect &&
-		for repo in cloned unbundled
+		for opt in "--git-dir cloned" "-C unbundled"
 		do
-			git -C $repo rev-list --objects --missing=allow-any \
+			git $opt rev-list --objects --missing=allow-any \
 				$reflist >actual &&
 			test_cmp expect actual || return 1
 		done
-- 
gitgitgadget

