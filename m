Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037E215F42
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911046; cv=none; b=pNfx2J1yW4vqw7MZBwv3hF3FjvEzlCuCMOlUQi6jK2trzuhNW1Gsy7qa8I6T4nOWNH6qB2K4GVa5pBlLqdrbeQVG8zjrg79pdK7QZTT+KsA0ZPxGTCR9aqgrZJkx3szr70YhOTnwGe1KxB0ueWmC/Nfnu/aPveWiL4L6Xc6GH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911046; c=relaxed/simple;
	bh=sTyQLkuM9WFqr5MWs/19h7v6aqZUkAqwx/hjOvqMOIc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=aigzQEaDwj1iqGsdQR0jMBeKK9vpTNKwA1tJGZH4+pq/ldhwnD5CsiF6r1sQQZtAVbXJrr/ihaO+ny/m+aoyPi6JLW8P/ZqMR347006Wv060Mu5CTgM2yqRqBFNyf4j8fWzfsgNqp/l+5L5bE8xztBDvmSHiIrTkvyczrGQpPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTzPX/El; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTzPX/El"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-884328c9473so24674039f.0
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756911043; x=1757515843; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b2zkasBUaziT1N4ialwrpPFHwOzTUpnKq7pWH4hl2xo=;
        b=fTzPX/ElhUisu0gyN0KEC5sE8oYOblIBSKwKoprVUJQqP5HmjSdVLuxEkJaOnkcv7t
         NTyDnc018J303R9dYQMR5wCd7fdgsMQter94tpYpbaKH6xVQfvU9/mWxfnpEhFcKtLSl
         jaduNNdAb0mpNqAG4lV1E295MW+FzgPrw17ajhNoadG/kBjG8sj3/sDORWpm7c6Ud/0h
         EpFQhJtQ0yLk4bwwKFRUvsws79+8pKSngVQQWYp1zhOFW+mfE3bmkL9sIghkQzItyA39
         /ASizkspa+EHkAHFaFYh2k9BhD4VWb0jRSQq6B6TCOO+s8StBbf+QNDI2VsUFUz4kj1l
         tvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756911043; x=1757515843;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2zkasBUaziT1N4ialwrpPFHwOzTUpnKq7pWH4hl2xo=;
        b=cBU4EliVJ1AahwBpAHWT4PGRnzBqg8n58ensaADWeUnAVn3oiAaTKGSoHz9ER5oPjF
         v+67BA8s/+/e5oM9eIuvr04ehd+xtd1cwXltYIlTPSWUmkehuWVhinTuBncZa27AmkNN
         NiYvTn4e9F71Kj6DN4pS3QRf1HDkHhnGzfblR+FWOdaCiSV22r/r9GQbPlBv7+Kc8nOK
         OnT669NfX1gXwArEszDpwh3L36di2ln1aEWIihcCtzQq11mi4mSKb1/xqFmMV/BuaBwj
         JfT7o7BVCbvOmouh/EXuxkG2xt4jbBlajygNi5FYB/r+eQuKq0s+crZSSPclOCgXuSRr
         n2CQ==
X-Gm-Message-State: AOJu0Yw70vNwdYRiLMbnTTaoQLzI787kYvTB/plZQ02SFYeFK1CCi/qi
	lqJis0S8ul1u6I24EcId+FvvsAf76CYI7+UJvyQ9cog/7uGQ7D/dFhMtFfvRsw==
X-Gm-Gg: ASbGncumBXAwFFKdJiuFN2b11cqkoAbQpvDqm65Y5OJCYGE1f3kRij1m/9qeX7Ll7tS
	z45dl5ryyoXX31Ja9J2HTWuwfA1QbY+6j99oG0azYa4xTSLb/jT+7Rn41rfbhcgyVctMXDPpjt8
	WVXFNr+S8+Yx1ZGiuG700keDWK4rpwy0r3mm5FGb0D/pIzgnZXd3ZMrN6Fyo2ZObpjrlVkNpeBR
	6hmTrXlo2f1/W6DStxguHW4KKThpAfjl5Zc8tZEel0qf5Ab9c357lUCKDbBOVamv+UUlzwl1VOF
	cih5OzdgALo5JAbeKUtif/OBh9a4Dq0JDwxi9PaE0oc4R3D9ojsGBjKG1VLHxKBl3J8hGeXVH3V
	uvLI/FyD4J1b8QMjGe8RcxdwK
X-Google-Smtp-Source: AGHT+IGC6/o02e//h9dP4wsr4eizdp1fBY8IU5nJNud+le83uOdqxfqGnt8Sm5GhkEb22BJPG1L13A==
X-Received: by 2002:a05:6602:140d:b0:883:fc4a:ea55 with SMTP id ca18e2360f4ac-8871f421e06mr2980737039f.3.1756911043030;
        Wed, 03 Sep 2025 07:50:43 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.32.74])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8871e346746sm373174939f.11.2025.09.03.07.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:50:41 -0700 (PDT)
Message-Id: <pull.1967.git.1756911040439.gitgitgadget@gmail.com>
From: "Mihail Malinouski via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Sep 2025 14:50:40 +0000
Subject: [PATCH] docs: fix typo in worktree.adoc 'extension'
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
Cc: Mihail Malinouski <m.l.malinouski@gmail.com>,
    Mikhail Malinouski <m.l.malinouski@gmail.com>

From: Mikhail Malinouski <m.l.malinouski@gmail.com>

The documentation incorrectly referred to the extension without an 's'.
This fixes the typo for clarity.

CC: m.l.malinouski@gmail.com
Signed-off-by: Mikhail Malinouski <m.l.malinouski@gmail.com>
---
    docs: should be 's' on the end of the "extension" in the docs.
    (recreation of broken 1936 PR)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1967%2FM-L-Ml%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1967/M-L-Ml/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1967

 Documentation/config/worktree.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/worktree.adoc b/Documentation/config/worktree.adoc
index 5e35c7d018..9e3f84f748 100644
--- a/Documentation/config/worktree.adoc
+++ b/Documentation/config/worktree.adoc
@@ -15,5 +15,5 @@ worktree.useRelativePaths::
 	different locations or environments. Defaults to "false".
 +
 Note that setting `worktree.useRelativePaths` to "true" implies enabling the
-`extension.relativeWorktrees` config (see linkgit:git-config[1]),
+`extensions.relativeWorktrees` config (see linkgit:git-config[1]),
 thus making it incompatible with older versions of Git.

base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
-- 
gitgitgadget
