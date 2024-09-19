Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C788F47A7C
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770894; cv=none; b=DqYlV+GYVOrzrMgusUOocxTpEVjH8kFV0TBjUOjKHJFDo2uy3OEJA550FFmsA7HDH2dn4wExLBtKni/8N6yxpbwKifaQaMFb3ezI0xYW5wNT70kr9au+hQnl9TKc2ici6ZZ9qp1wOBz7gf5dvz6OgQZ4RgMXYVMr9dM+83Vr8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770894; c=relaxed/simple;
	bh=n4M/47/0+VRylLT7nUlsc6JrNFfTUAKBWOPcwnqmNZY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZqeqADsv44Qdlqb9CUCiC37OhVYco35jCAw1AOYDD2RF79/2/LgXNKPD6PaYGz51s9vg247ZjvjXA9PmenprKMS4C2NScdWCLif/idBY/iBmtgmW93hHjUtbtUBvwzKKSg6ywP1p8+29F+VTdACuL+IYRLR31zie+rtVc21RgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS2pMDLv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS2pMDLv"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so420144366b.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770891; x=1727375691; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxA3afgKm2Lkrd+JZ/lDP/5lwVfUv2dE6xDzu2BHB7I=;
        b=JS2pMDLvn8Jcq8/NcVm72LxfJmQuD6gUsseS9A72TgdDVzf2c0n7x7wfAT1yV6hgn9
         QnYXpW3bePsa3tSnYk9i5uFFeGAPM2eKCI/aahXjV4Ps4IXnXSkMslRy2K3br4dpd3ew
         7ddkQqNZqKtJL6hqZ0ovILdxReIZjaIqoJDMM8UPsr094iwyIAJBcAohNt1XGbEDBJG3
         g4h7DWNyiNNdXIk34zuR17JQJD1W6TxQBsx5THz1JLvBK2m6hyKj8gQ2t1c2ZSxx/WHL
         PrIvVKlEeZB1aiuZTSLztDwpZ32W2SsDtD+rIuZ3oJR3/dHcAa41eJ7A07fsTDvrMvjB
         PDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770891; x=1727375691;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxA3afgKm2Lkrd+JZ/lDP/5lwVfUv2dE6xDzu2BHB7I=;
        b=r14lT6kiNXsMywGZOujCh8MmFTNCYUhu6pd11FslxNg3Hb7q+X1OLYEn1EhrOwHZp9
         wbIFFwefQKOLyrmcXWO0ro0PMBuBIjk4ZL+mag9fo2ZNu4B/3g3pzbsr/7eevEfGzBwc
         Z4D6cF9aXk42VirOATU5Kb0KstRJw64bKg4POZ4x3E3sgIh7FAxeTdRrOC3wscCc122W
         Mb1bFciHzcvubfUREdp164+2TDhUVVDt2R/tZBWyAXLmZ44q7dBS0zAmhodk/4B3Qb9W
         00jprMnxzI4lI4MhVTWJ4ftcOfVC22Rb01FyHDsyLi9Umzj+xC91/l6kuDB+Q4KT050u
         hWiQ==
X-Gm-Message-State: AOJu0YwEov15yiSEw38yQ/QwwDNnPvHuhYoxIOPfDyDgnvWELaW2Kl1T
	cbvrXO03NmJ1M3oAx9FhVUMrMan4Tie/fZxHQveZr5vljlo6ipO3VVGXeA==
X-Google-Smtp-Source: AGHT+IESDuXmHKuGaO2E0Al0iLBBuP0EcO+R4O+j+JbsQhXdyOTR63AiGnBJDuYAS8Rou0HUKxKqFA==
X-Received: by 2002:a17:907:983:b0:a8d:3ee9:12fd with SMTP id a640c23a62f3a-a90c19a6d1fmr474925966b.0.1726770890535;
        Thu, 19 Sep 2024 11:34:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061321568sm745694766b.191.2024.09.19.11.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:50 -0700 (PDT)
Message-Id: <7c950c793213681cbaa0e9cf25294291edc2fdce.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:28 +0000
Subject: [PATCH 08/20] merge-ll: fix a typo
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 merge-ll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ll.c b/merge-ll.c
index badb6dea57c..8e63071922b 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -334,7 +334,7 @@ static int read_merge_config(const char *var, const char *value,
 		 *    %X - the revision for our version
 		 *    %Y - the revision for their version
 		 *
-		 * If the file is not named indentically in all versions, then each
+		 * If the file is not named identically in all versions, then each
 		 * revision is joined with the corresponding path, separated by a colon.
 		 * The external merge driver should write the results in the
 		 * file named by %A, and signal that it has done with zero exit
-- 
gitgitgadget

