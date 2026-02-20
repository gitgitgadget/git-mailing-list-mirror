Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF423EA8A
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771552800; cv=none; b=NjYIsn5/wdph7i81jaAso3KVsP4K3TY1cppACFeHSCzVVEy0ZzvHsdhb2l9VftGlun1BafSYcXN62JgeXAZbR+WERSV5xc9svBYMj45Sys4xv2A0MBiMWxdbRS4ZYHP7Iac3jjldWGs8sBkbfarPdznr0w/UQjrAMYbxL+JSTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771552800; c=relaxed/simple;
	bh=qL1p6rxC9dScmhcuc0UQ10M61cdlhcCZTJYkVnpo4AA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bC3yXQTDuxYIBOJKoUFp8XEOgQO8ecTtGwzl4MSW7WEfGhlMKLW4H7th3qOsMVCWfF/SglefAPJSOV5iRoQtL2tN/N8/P9FGvviXj5FF1hDbQAlyjABlneYDIb4is5dVEgtf5d/BjVj38Ukw7pGUuVP3y8Oi7U/EehC7E+MHMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnrSZO92; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnrSZO92"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso1687038eec.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 17:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771552798; x=1772157598; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p16zkebo68ws0atw+u7gG5ayMinuKV1Dx3PRtHjZ/dE=;
        b=lnrSZO92HX/z+ijpC/ei6ZA4rGiAxNQ6u3sztlczCIpTFQSjZ9NwZ8fsG8fWJLsj/t
         D2dG7vBasyNBGI96FZBfePCRIB253xEvZSUuvWUtBToAwh93WZuPAVQqLFgDB9eakkIV
         IzuH1cNjjNXN2mdP//WB3rH/MTeBBXzZG+nvwqVSVDE5p0r1/Wp4VqAcPF5UrO5jTdvg
         YYsF87cs8/RciO5np/Bfdu31L/GeWE5GDT2I/Drg9WgmbPj6DawBLdkJ+RBZZbhT8S2t
         pvHm+2Emr+bEtTjPuZ7Bu2CB1cNP6c/m7icktYJH050TtJiC1DkWssJxxvaRVrzfUD+h
         2dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771552798; x=1772157598;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p16zkebo68ws0atw+u7gG5ayMinuKV1Dx3PRtHjZ/dE=;
        b=HWW8RaHh/amBozxI7PnkyhO0xjBgOMIyPqPLZjGWA1AkPfdMXIbm1V4U74bOEQMLzY
         0SYaT0QN9Td9B6yZ8sj9crz9OHSa9eV0+odATPmJgUO3OtEKM7ebNTDiL+y3+ikSJtsq
         AWAijOkAMeBWOflkiLrIyXPnNUTawLBIAdBone87gF/kjFi10p5jcY9Kn9o6An3GBl63
         8Vz9YRik2wxBTBulXlm6FloCmLAsHIiutHsP0fjkY0I8Z6Z9DiSiZGbFkxVH+BsuLeXe
         Ma+yX1DjZxOwJu1rllVldT5G01T1gYFUdqRFB8m1ElFRkt22tMsFIsCtnN6k2U0Ni7H7
         xb3Q==
X-Gm-Message-State: AOJu0YyY5uEhuV8LohQZ/qQJ+M39TnL+vSVlBRcKS/KtHyJeH8n7cx5v
	drlQokXk8NaYNqgPK1kUiJ2DvnX09WvbjdHOvdElFq3dDcn/QB0KgzbMDDbklw==
X-Gm-Gg: AZuq6aK+FTJmN42S6Rew4FVeRnUDNdsUhRuGoCJO5DbdZ5lqV3qTRSvmhb7/jpE89Fu
	PVjHDLYI2XgSfyKVm1hiXgK9w4NnYcq+lcCAblzKh3FiLib9LDib0S2VcHHCAdQeM9pH7PrhVRM
	Zq8nyw7k1ObLkDroi5BclaEWIHYHZl7ymDBhp7NyhutMFzhNK5GCXNwt8j1DT65Wz6P/VYpqZVA
	L2YnvewdK2jB/2qFEirxUTxFKhj94ikHFz+RTKxzjXfOgY6L6nS0Qfv0tn55uL4h+b9rQfOYvUt
	4OJdaeQ6D75LRlgwzh5Df8mlsLNVnSG1sHM3HQdR+1OqnFxi5VyAqJE7DS//rtC42hyofmFPJVY
	5NoXsbXI8oXcMRqIZXqyaVOiKw6b+cx965coE7hKmuBuBHsMJnIAQz5mexNEpu1IWOLybMAgWWt
	o5CWVwhE+744KD3ggUg9rKQuTZjQ==
X-Received: by 2002:a05:693c:2b06:b0:2ba:69d1:7622 with SMTP id 5a478bee46e88-2bac9811a66mr8031673eec.40.1771552797661;
        Thu, 19 Feb 2026 17:59:57 -0800 (PST)
Received: from [127.0.0.1] ([172.215.211.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658531sm25348623eec.18.2026.02.19.17.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 17:59:57 -0800 (PST)
Message-Id: <67db46f34f5a0a4a791479899b9dd954aaf5e9d9.1771552788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
	<pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 01:59:48 +0000
Subject: [PATCH v2 6/6] replay: prevent the_repository from coming back
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
    Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Due to the use of DEFAULT_ABBREV, we cannot get rid of our usage of
USE_THE_REPOSITORY_VARIABLE.  We have removed all other uses of
the_repository before, but without removing that definition, they keep
coming back.

Define the_repository to make it a compilation error so that they don't
come back any more.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 replay.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/replay.c b/replay.c
index f97d652f33..a63f6714c4 100644
--- a/replay.c
+++ b/replay.c
@@ -11,6 +11,12 @@
 #include "strmap.h"
 #include "tree.h"
 
+/*
+ * We technically need USE_THE_REPOSITORY_VARIABLE for DEFAULT_ABBREV, but
+ * do not want to use the_repository.
+ */
+#define the_repository DO_NOT_USE_THE_REPOSITORY
+
 static const char *short_commit_name(struct repository *repo,
 				     struct commit *commit)
 {
-- 
gitgitgadget
