Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EDC3B774F
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140419; cv=none; b=d1Zt9CQ6fmnq7f9iymbAR7WzSDwNCsrECuP5RWNlXTaH5OPOwkCtv4LVxtfCxzpdN0O/RW5fYGFrjdqqZ1eRqMibR7YLu27Btl6UjBAFuOkvvcQW6MJDGBXsTYJ8+X81j3qLUdoYowVD8oAKJn9+3KBlOkqQklOL2wWP6f7aJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140419; c=relaxed/simple;
	bh=Orc2S0ItYNSKhH5pp10W9DSA5R4jneam/rLxMGJgGVY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZzUGC0E7pEY0ZIUEx+GzWFra5zarlobPuFnzR4hyw7/22+x1xBTpzm/ggHxAxcy3vFalG/6KemepBdyQ9PwkobgpzIHxT5pVG+xnquBEv9zuHwugnNsSUNkCcgpSl2UCF9XDAYlObInHdS++35uIqn+96zz4/pHXa8lSNqR8/Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbkWhmyH; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbkWhmyH"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-650182d19e0so1117086d50.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140417; x=1775745217; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DATvBDVBaQX6OvN4m/JJFe9i+U/IqHHUZdwVvw6Znu0=;
        b=CbkWhmyHN4vA4xJw/Iv+qjKFNlFMPF7m1DFpWaF/C8bP4cLK212qeRHJdCqT3OAEv4
         Q0/QgnBh6/CHAT4gSOnc1E+1nHFxeAWc0sOjIlUriWUGXaxsdJcxsgyb7fGKoBqnGMQM
         HklF/O4JMFpqj3SYOMCMJpypjQjlUkv9IWwzrEpgAaNcYvsohZo2DdUQJUV9was6ZBec
         ht2zIJmpPtr2KyxCNhMGEisYie1p3tWKLNGbDMaZeEis4bG1czeZEaGEYXRFiS4aiAFV
         7vwdC0dj5P3wjc1ahz8NsB3T6O2nRYkMLjolIEDFeQY+P65CDpt/7Z1XIFlL5qyfnnzM
         91Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140417; x=1775745217;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DATvBDVBaQX6OvN4m/JJFe9i+U/IqHHUZdwVvw6Znu0=;
        b=Ozke94lBmcz54HqYDJ3TERFwMli2R2jIGedhmaubXkmXPx5K9p5oqxMqabnEPYpKht
         FTw4t/cNA6ZRgbBesDH1UBM8ltVbgTuYpmpYL5GZG51P/FAtCb5ePFZdwh+Wx1zg5Hnu
         CpXRw36LKAGhkV1nfAklKpcC2+e2ImDgYhmMhecCkoJSDvYXC8bcVH4Iw/0SujLBTmtZ
         xxGGqVsaGfB51iA10v1km8Ye1p610DB8u5hhX0bQlLPK8oMR7oCRyO6XmItXy2K2+Lu1
         9uXJHLGJJyM3ODS6HXRaYcPqC3SBG5VaWCKYh8LD+Vo5ecjZsh0dLQ6X8dxPUrlsLcpl
         2r6A==
X-Gm-Message-State: AOJu0YxuhB2BbYE3MZHqwJfC/CUthJO2SbnuJBGHEU2XEc5bZNzOr6qQ
	TkgEMVK5tzeUa++POl+c/BIn3ih9PhwQ2ZnsgZ1pmzHKu/spB6xnRsLLW8UMBw==
X-Gm-Gg: AeBDiesA5Kk0apgvb1D4AftEaaL+HqZLLw9GVpyo3jdGsWuNBg1154qTAPlk0hZl0nE
	3+l6OX35RWyk3PHGKdgz8P8ma/bAmHvlXN2GCxI0XoYFOaJCMd8/vm46xodCDibCcdfd6kSOeEx
	Mq+akB3pOJ/qV5wUG8sR/z+s+ufnoTokRle1I3eWGlfUxGL0dSQZSu/Tc6e9AltmIWRfA0LXtPr
	3wPc3G9NvzoUF2qSlUarWOprpHCTD62874gvXYEeBrAxfAtxj/tDIn5tzmW12rXp/uQR4oxn/1d
	YhtBP9o75rtu+gZqqxdYK2i1Ao0P6nj9fs0nUljUqiI+rAEGkGhBnSKVK0rCxR5pwGnxlqVYd9D
	NT73w8oT2eUNljGwga2bpMQpcgtu3WFv8nuy/aUDeccEDCsq6Ojay3Du1jpeVSznLA2PY/xVdCA
	0tvcjzbM5DccPj4solwELYjmvMNfs=
X-Received: by 2002:a05:690c:c50f:b0:79e:fcc9:aea6 with SMTP id 00721157ae682-7a212c1f747mr80147137b3.44.1775140416989;
        Thu, 02 Apr 2026 07:33:36 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370cf93d2sm11007177b3.35.2026.04.02.07.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:36 -0700 (PDT)
Message-Id: <9001883e152407464c83227f1e09664d0d8826b5.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:15 +0000
Subject: [PATCH 09/17] t5503: avoid discovering a bare repository
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

The test case "fetch specific OID with tag following" creates a bare
repository and wants to operate on it by changing the working directory
and relying on Git's implicit discovery of the bare repository.

Once the `safe.bareRepository` default is changed, this is no longer
an option.

So let's adjust the commands to specify the bare repository explicitly,
via `--git-dir`, and avoid changing the working directory. As a bonus,
the result is arguably more readable than the original code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5503-tagfollow.sh | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index febe441041..6d178d84dd 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -168,16 +168,13 @@ test_expect_success 'new clone fetch main and tags' '
 
 test_expect_success 'fetch specific OID with tag following' '
 	git init --bare clone3.git &&
-	(
-		cd clone3.git &&
-		git remote add origin .. &&
-		git fetch origin $B:refs/heads/main &&
+	git --git-dir=clone3.git remote add origin "$PWD" &&
+	git --git-dir=clone3.git fetch origin $B:refs/heads/main &&
 
-		git -C .. for-each-ref >expect &&
-		git for-each-ref >actual &&
+	git for-each-ref >expect &&
+	git --git-dir=clone3.git for-each-ref >actual &&
 
-		test_cmp expect actual
-	)
+	test_cmp expect actual
 '
 
 test_done
-- 
gitgitgadget

