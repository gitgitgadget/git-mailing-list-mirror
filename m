Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9567F375F99
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140423; cv=none; b=ALhbZ3Ydhi9e6FfJeoh+4SJfEK7RmH7rdVG9pbspfVNPK0IIxu5zyswSFAUVONiES3JdykUQU22ACFMCUjPW7ZMPl0TN3oEHal8YkRiqdsMDva4xaCI0H0JqRbt1Nd1LpZ2/LL/2jkze1tMVaOYx97Vtv+K8RuCJ3u9PDWpfurU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140423; c=relaxed/simple;
	bh=0PbczuOe8YaRO619AtUgucO8TUR8vH7rOrU1qsl7DkQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WjJdg2E4Fs6itUC/FYtnaYSs52P+2JsPFyUuSCJ6bBlq9sZ3DFkzdduoRHV4m0D7RjwkLWZTXP+4aQ+H0YnxaeyyYn5xUAdkEFEoR1FsSje8FNuQTi5FOLLwwve9kPsCVqXzmlpZH+hOIyV8R+cg9VEKjUHxy6j+UIS5Z5GTESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsmmVM2x; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsmmVM2x"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cfcb045909so115594185a.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140421; x=1775745221; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtBElVDU149smXMsfotRGsCD8+fn2Iigwugv5wO5zgw=;
        b=HsmmVM2xmPaAorwOzIHJZgM4Sr3xar6f3PdaGaZncqKFV2gA6xQQyK5Bw0gTELCade
         6xvnqQn3Ok2RQ37F1ur89nHAnQ61m2CfdbGvY3LSBKAaaitwyYWGxkPpSbbDt2NLgsfq
         5ZSt6tHeouB/ogJGHp4eEaXRIwqIkqE1Es6VGogArTvwHM8Vr03s2AYvvujacoKbHIKE
         lmBrih2yUadUkzwvkGXHuZtT+XUXyez9c+uZ5kyMu7Cw8EMgwmm+YwK5yZR8hNKQDEZL
         0jmCRuNPsbMMLTY7y9u1XfuOVTOj5dBi1Zorw2ToiObCQ2lOPFJfkdsN2Fnmxpp4CNv8
         Hjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140421; x=1775745221;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rtBElVDU149smXMsfotRGsCD8+fn2Iigwugv5wO5zgw=;
        b=e3YaR9dFpYQVQ5Hv3DfM/bT3avOKLXtxY35HWbzsSmJl+A4UpC15TXJfDMHviFPmes
         rr5b55YgAVTiGpb3lJhEhldbTo4lypb2BLZgv3DZdfRBliANwZTBJx8FMnG24ZF3kjVr
         e4dY6ReIXMMxR/+Qmt5BWRLarjuNEtpfVHblejmv0CrGdZrL+AJPHDwxZRrNA5JqDPRf
         08vtGJ4OzTk6RfkVw0VOF4VjfyzG8kAIPo7RUWZB5d446iFo5h3kXXwTZlMq26xLuxoI
         K085eQJ40mlk2B+xq/QasoiweeH6Ui5e09/CEZ7xw6y513U2plyT4/GVlk/vVgFak/xe
         QeeA==
X-Gm-Message-State: AOJu0YzARXcWOUK7ESd2jk9jo1zYctb9mrM0Yt3ePlw3bgd987/D9Ww/
	dB5BL1SzK7QizSgtNjfxDYATTc11RGyC2FMda4mvQNuL+w0GCaHHEsjjnnNGyg==
X-Gm-Gg: ATEYQzwhz7dIuhPR2IPCRgzqDuAA/FwRrCOvywzd7dBvD+2ZlDKv5m5Nf6fPOnFODSe
	1Bdi714R+tAkwjbzYfb81abvhXi1dqbnNdtfg047Kj3skRXPxgJnlKsJeaxv8CW2gegY9Xrk+Ll
	2SZ6umd41loLXgVnzgyLU59YETsrJo/jK5h3HOnbSdWrhbvz/h6UI59q1gqkz0EXpRiCpUkWyuu
	Coj47hs1k0fkmbZnMU0hVgN9C9M2mQtt6yCbO06UphTI3tRyKDxXDt9VlgydQxsXMVpiz1NMTqf
	XTMt1ellBLTTaPHj/8DQbtM4YGOrIO4ExAgJXjUrWQ4yj1Nk/gTSYUsRYCWL2y9yaKWikWB1p2A
	7zXitQQvGfM797DQ1P82Ihz4jXdLNBEbmBk4oJLs9TWKQXC2Yip50rqCSShkFnuooTGzYuoAqMW
	mjg1KJGe5k0cbqNppUj4BNe1GT0k8=
X-Received: by 2002:a05:620a:19a3:b0:8cd:b60f:9ef6 with SMTP id af79cd13be357-8d2a9fcb603mr542253585a.16.1775140421152;
        Thu, 02 Apr 2026 07:33:41 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a864b516sm239147785a.37.2026.04.02.07.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:40 -0700 (PDT)
Message-Id: <f6fc807af627701bf7f9ea413c7714e9bc01aea4.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:17 +0000
Subject: [PATCH 11/17] t5509: specify bare repository path explicitly
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

After switching from `-C pushee` to `--git-dir=pushee` as part of
the `safe.bareRepository` preparation, `ext::` URLs that used `.`
(resolved relative to the `-C` target) must spell out the directory
name explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5509-fetch-push-namespaces.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index 095df1a753..7771a3b34a 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -88,8 +88,8 @@ test_expect_success 'mirroring a repository using a ref namespace' '
 
 test_expect_success 'hide namespaced refs with transfer.hideRefs' '
 	GIT_NAMESPACE=namespace \
-		git -C pushee -c transfer.hideRefs=refs/tags \
-		ls-remote "ext::git %s ." >actual &&
+		git --git-dir=pushee -c transfer.hideRefs=refs/tags \
+		ls-remote "ext::git %s pushee" >actual &&
 	printf "$commit1\trefs/heads/main\n" >expected &&
 	test_cmp expected actual
 '
@@ -97,8 +97,8 @@ test_expect_success 'hide namespaced refs with transfer.hideRefs' '
 test_expect_success 'check that transfer.hideRefs does not match unstripped refs' '
 	git -C pushee pack-refs --all &&
 	GIT_NAMESPACE=namespace \
-		git -C pushee -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
-		ls-remote "ext::git %s ." >actual &&
+		git --git-dir=pushee -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
+		ls-remote "ext::git %s pushee" >actual &&
 	printf "$commit1\trefs/heads/main\n" >expected &&
 	printf "$commit0\trefs/tags/0\n" >>expected &&
 	printf "$commit1\trefs/tags/1\n" >>expected &&
@@ -107,8 +107,8 @@ test_expect_success 'check that transfer.hideRefs does not match unstripped refs
 
 test_expect_success 'hide full refs with transfer.hideRefs' '
 	GIT_NAMESPACE=namespace \
-		git -C pushee -c transfer.hideRefs="^refs/namespaces/namespace/refs/tags" \
-		ls-remote "ext::git %s ." >actual &&
+		git --git-dir=pushee -c transfer.hideRefs="^refs/namespaces/namespace/refs/tags" \
+		ls-remote "ext::git %s pushee" >actual &&
 	printf "$commit1\trefs/heads/main\n" >expected &&
 	test_cmp expected actual
 '
-- 
gitgitgadget

