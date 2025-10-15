Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090973019C4
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563116; cv=none; b=V3LbTvzaNytZwQs6c8AJ+SE2LSdQ2ePZbjq0cIK0V6NRP89QQD5fL31aXe11656s/99Hw/vXp7sqtLsoOlCQQYO3ITi0WxzG9LsifyUe7UYCSwED4I/67InYDGABFyu6cr57PVChjDRqs/+BPOSaIFr+zX2IbLbB9rufJY+ieok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563116; c=relaxed/simple;
	bh=60/FwZnCc4GCOVBcKV5uJ0J1+XcDU3lljanKSqCV9NE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aDo3yR2bN+c0alua3ct14bXdlDePJBZz46g8vlr3kXs8Iari5qp1K1oEpto8yXCFspLb/o+lLhQq1qP11ozuuUN3INeJoM993PaPgRr1aYqpzaxEnr6gLvnCYL5Uxqe06pa+amP3VA3TUnmI52Wcnvyojfe4DbHKCAGXHCjliF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaApd0uX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaApd0uX"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-271d1305ad7so716965ad.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563114; x=1761167914; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID2OzqA66CXhe7ka1n3VjicPVCM4rh9q2o+u+fkkaDI=;
        b=HaApd0uXw6j1jtnMc5ecCdEhcoqKtQz7uwFP1vIcb04tWTjcrHG6os1DYNpBuCxRJ3
         7378uPiRl/rmRjEy3x1CLaKhufSRF18TnBmm+g7s4AhEKzgPyZ+hurF4/W3337NGOHCr
         uciRHeU3A+tNagDbi45r1KHuKyl7FN9sEIlhO6odmZFFhwAtWGxaxWuq5Kg+tamLs6B1
         gWHbhv536KKkM2uwcTcFGTHC+ql0uZYxxC0cdqheiJF7T9/vpoBp2MFAxtWi+Rv0Ajy+
         tkAq6M/BTWhWrVCtaIttE0+usq5cND2sjBS1kPBvQixl1Ojx3Jn/abXtt1JsLMwISf4a
         0m1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563114; x=1761167914;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ID2OzqA66CXhe7ka1n3VjicPVCM4rh9q2o+u+fkkaDI=;
        b=hEnD/c03QPFXdZKv7o2ph6NIbts/7VB0mtm83Y714CEsSiRvoJi6p6QCpcKrYKQv0R
         Tbfu/Mp6nXn2YaXl63xH4cLd/AMaiV1a9zXnrBgByhEv5BcVwLgVQ7v5YTobfS6QXFsC
         TXszHT7gUNDeR1SqIDJ/ByZIRMIJsF7gR6lO7tl7iApyJ1SihpWh+Y0TcNMs8/Y4VJgy
         Lmbg0bqTvS1X92/HFMcEjPEFCcL0dtcshiSx1o1SviYvCp7uia2R3b0K2Cy7woGR/Zdt
         D3yX95LI3XbmIAs0QgIawlkO/Ir84+6W/41yBDPFCCouOAhCMt6SNelUVOMQFqxwKw9A
         /lug==
X-Gm-Message-State: AOJu0YxJjqF/YbLrHmhmmHKEFPNfdcpR/Ckmif5ScTmMBxAXkVmQ9oBu
	NyiWUkF9nJv40WeCSN2LT0fSi2jWIuGROIoh0MJtVBewq/2CJhY/h7yHzujFwGyv
X-Gm-Gg: ASbGncsjwRWoI4Q48D1OWjfQBjtTR3jyYe15ULKWsDTz15qPv8c3MawpZMwtvm+rzB3
	zNTKVWKjpOFrQw870mgow0lCw6iMFPcB9eR97ZFKS4LiVuG1S5twUPHDnGY62Uxuu0V3eEq7wwB
	VDWYgHEjQRho2PEb+EpmZ82MFyRr6muRRoVBrBZ218csqA+WwkMcPUW/SeGEDL788FHcu+RLqpy
	WsjU9ZRPaOzW7gfn+0wMmLGwY12cz1nYDCR6oHEqGnkOI7bypxceXFxJZj30kpoREo7WYkV38Pv
	plzuktGC7NK5tucvM7KNFliJ0SPOomRw4QlVBe0BuhZ8wJPw/QjqTD9Ph3n6oQq0WMnB42AszZS
	WDmm772YWiRVRAyYQgpot0nOqUzmHylDaUXY9EshPI+34Yx+VzIaYcHMDqt5H6gg6BxkMG+051h
	4/
X-Google-Smtp-Source: AGHT+IFFF9ijRfquaLiom7PZY987gUqkf9Ea8ZSJJrw9zzBwjaNT3XtnXF058uagOy69YVVf8BatTg==
X-Received: by 2002:a17:902:d490:b0:290:a32b:909b with SMTP id d9443c01a7336-290a32b937cmr3275895ad.44.1760563113812;
        Wed, 15 Oct 2025 14:18:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab9c86sm5910525ad.81.2025.10.15.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:18:33 -0700 (PDT)
Message-Id: <6dca5e6222e1d02092d4ba8296b757b123b85afa.1760563101.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 21:18:20 +0000
Subject: [PATCH 8/9] xdiff: change rindex from long to size_t in xdfile_t
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

rindex describes a index offset which means it's an index into memory
which should use size_t. dstart and dend will be deleted in a future
patch series. Move them to the end to help avoid refactor conflicts.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xtypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index e9473bfd45..8016222de9 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -49,7 +49,7 @@ typedef struct s_xdfile {
 	xrecord_t *recs;
 	size_t nrec;
 	bool *changed;
-	long *rindex;
+	size_t *rindex;
 	size_t nreff;
 	ssize_t dstart, dend;
 } xdfile_t;
-- 
gitgitgadget

