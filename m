Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA534753A
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332218; cv=none; b=ZFvYN/Mfiquyok1hQEnJcScQSSERothOSnti8EnJjakaAPM6LXcCTBq/39kqFN26eNU/RDHKrB3g4Nps4DT9t7+3PlYK8TFWcQ/ZG6WSBudqLWlo5u4fslC/ospS84fYLsR85aD4UJc6jX00oyb/PQ3ZGEuhEELhDdwj1e5UQUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332218; c=relaxed/simple;
	bh=Ov8jqpAj6L0FeDurzPMMs2WrWSiOqjVjQmcWcJCEkFs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cHSYK4Ngtyj8hcIUOTth2A6Niu6nRrloJ7BmOiSqQh4pDOeMCFt0utd6xJwpHMzvn0RyKxfpYumbxl9x8xKrv1ByeaxGacJ6L+RBFtCXH83fTPMnwmQcJHyXva9wiTAejAbsZhOQCeNGEItnzPW8Ugxo+Rvcl2F4NNSpyC3T9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEqBrb0d; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEqBrb0d"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cfc085395fso255520985a.2
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332215; x=1775937015; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbndA/jWMkmYldpu8iy64Xea81ACg5kjKEO7Cm3yLqM=;
        b=pEqBrb0dDCX0pWhqr0FX/9Rnc/CbCZPc/uzkJTef9YXBwRHmTUcq/jaITUDD5uATL7
         RIqG8rZGgxn73PagFEOBkLZDyNvdWiCX6WgXXj/QxoRHkkscY19GP0lXN2Oz1sn9u3yL
         08jrjJ99FyLEFkPbi529u8g2JeIygKlg4tWGG9Kuo0+yVoKXAP/MYGfPHss2f2MYJZmh
         0EY0sm1IdJiMD89hLxnDnE48w1MLlK3F32sF0d5zDEru31dMH0nKsge4vl0zoRG/xoaw
         tNuQMmz4bfevJizX/y79aFQTapur/7GJuEzrH0tB+uJxwd4/NlbENnX7nBSyzSmNHoVd
         yn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332215; x=1775937015;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vbndA/jWMkmYldpu8iy64Xea81ACg5kjKEO7Cm3yLqM=;
        b=Z1WPgmWEXv7bnvxY51LonWsQYt1O6gaZafKJQjl8cd7Q0LjKxL8+TftVdYNZx+nqzZ
         +ouyDkeQkvZ2/9i3dQxuFYxZBb4X3XNYhwBvIhLM633b2r1SlAqNj1LDQaWlYnUkInCS
         +KipsyviR3gbWYi7i7RAv2g3K2Vf+Z0w3sDIHD5QTjOHAMZAjfvizlx3ogy5Zpjk7sTG
         lqUIEqL2YaCa+OvNTqkeLi/N+dr5NqAcS3b6vC4mtK3uF6Fr9BD4MbYuDue23q6FA4+S
         nAtZQRMZzd19qnVS5zPhNCPIF6jiIsPtj+n82Kz5AedaMfeX3/o/qnEtzT2PDKRNP0Zq
         9CPg==
X-Gm-Message-State: AOJu0YwGVhA2Lf9Kmf/UX5ufhR/8dKb9U+JdNGqHaETggL5Y0xX7PCZJ
	1hHbIVBvfOGw1d6fURC5csbsFqdJbs9CINC+ulwxs2ODac9/JqO4eDrIgJPCbtoC
X-Gm-Gg: AeBDieuOB9srwRcd7blP0u7JZ/qDW+4Im12SiWZEiQS/wbdETnM1zw1ZszZss44L7eh
	O9/8tCiICn1mSs57lhciLGHM0t9hA22I4Uq48vDyT8oEyEFYwIbmD0wGDKyJENSn2rxlneRH2s8
	4+G/mM7V97T6owzLScXL7gWqffZDeQhdep6mPIavYbYydPBdpJOpkaw0I0ID7h7hD4zL2Gu2Rls
	4W05vU6Bxk8RtoYmlaEKgqJFBH+YGPW0okzN0F/LhUkNh7+NqvPsEEqWihllXSa8iQXBXlkdxKw
	NqBemhdm2kMK7p7mx8Liia80y/cWimOXnY2m4ryYez9Qf03WkkydBs8q2LvOborxTtNP6nmMhxd
	awQNsVSLnyA58p1mARKgEua8Qu1ILcnp1QUXOSokMqu59lRMFO5sDlFJ8r9MsFOguMkZf70alKB
	C8QYL0hh/lhtykgc17VaNxshX22QagD6uHPT05Hg==
X-Received: by 2002:a05:620a:c53:b0:8cf:e993:83a4 with SMTP id af79cd13be357-8d41b5d66aamr1068807585a.47.1775332215262;
        Sat, 04 Apr 2026 12:50:15 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5392d35sm692809985a.10.2026.04.04.12.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:14 -0700 (PDT)
Message-Id: <01ec77c9080dab28afd3f013397abcf498db8798.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:54 +0000
Subject: [PATCH v2 14/17] t6020: use `-C` for worktree, `--git-dir` for bare
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

