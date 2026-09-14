Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C880F32F764
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369754; cv=none; b=pvQ31OapwyfeTUUIM/MIYvlJH0w8fcSrxLY1n4Th/sJTETrUR/lcIopU5d3hW7AQPK6jBPDXFhso9AiQL7C8ZDFuSAOwvtoVhj1vnlwGXxj1JnG/CXbHVuyj3flNBI++O9j2Hn4uw4cQoeJX5xO5YN9QnaTJUNcY9oIGlNQqSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369754; c=relaxed/simple;
	bh=HLgPixPlJklq8zpsrXv2pRBm0eZgZTnK/2pbijhhnZs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=siYMDKioHlwt4q26dFVX6RI3O/KRttiGoaeRq32gkAAyfn64HtmTJcoAWIItlFOxwWmZOBmAB0O1+rL8JpOISZQbmhL4w6lnprwFwxAQZx4LZqmCx37EauUZ6UmyA2/3tTUk9Do4/W3iF0m9S+HZLzGCrSO90kVsb4to3X4xyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjRIYca/; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjRIYca/"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd6so25645411cf.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 00:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789369752; x=1789974552; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f0Lb9rx4/iMCLp7Z/LlKunbDsxHr6iTYBl9fTKWhLEM=;
        b=TjRIYca/ANuux/zIOH+xfafcue1O750yZGrvRh1NG15aDYw6Uqc+VuNnvPJSC06XSR
         7NDxkb++cX4nz5rP1auMAFNPJoxoRAxGntxC8tdzcTdOBBCZ9Upoibo0RiGpI4HIimCk
         zL7nFQCupGOwC8juOtalY7REG99HwDwxgkHXnnEvj9QWcYAZ8GsddCAqOf+Ybliq3Nh+
         TxXclbfevmvdPghixO1Hn7S+pG7BHQc+lQUs5OPSbG+2MCGKmNXzoGmRf3Ex2eOt5gSZ
         TBg46kLMTk6JxQW/gOCjCBCxSXL8NymCyjflxJvrnqRnY2//vyYc31Bnd4tJ3WnEU5DF
         Qe0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789369752; x=1789974552;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f0Lb9rx4/iMCLp7Z/LlKunbDsxHr6iTYBl9fTKWhLEM=;
        b=rOOagVDrbJJDZhsLwp1eOS1QLk1bDCktO0WNFO61X+ZToF8AeemzyrjReyci7adajH
         1NTzm17WQI93leZu222DNAfqoRzuHLv4fNnQ8QL1YIWI349I11lQ7LpmUDne4b/QLrz+
         GkLiUMF20lJVc24je2szzWMmhKdx1Qo7DtMFlu/b4p7AArb5LgGMVeKlZgwPCnIwouDH
         8P1ST13441MrHLqCtc6EFmUj5ueqAXOK5OtHsj0GIaM2RtxEJH/PesWrgGnWlwwGB+2y
         bN2fpMmfEnE8XB2y/posnvmo9YHlHPwNoMYK7WnfIgdpl4YmqT/q2cLuGFTw7N2CZ/7n
         5p3g==
X-Gm-Message-State: AFuF++nnRNI4KUbc5FJZJQIIh14yeZ49UK9R5t82xvCp67RJMiug4h+H
	j07THykyNn460H0Ewp0jIihwbs/UOg52LR+M5/hg2DIj71WMXt4KR4VeCei6hQ==
X-Gm-Gg: AYBFou0FrYe+nvqviYpNTigEQ+OOIEBoKtObRupc3FM51MD9cniTn/sJNeD6IkbAXji
	B64jNTAYZoJqeAGK8wT+jpF9zoX9Fu1LwjAFMW82VnAkLed3B+HQciTd1czuYNs/yWkIpBmXQv8
	vbWWeBp+eNJliae8GdnN73id0xfrK+CKLHkime4w3PK9Sg19EMpHcJx0jHUSud+v57mHtXEPXBG
	FlhNFL8/oWqy/MTK7fM5LuEtiKmBAilhC0Lnz5/tyw/rN3CYLN3N3BhDo09Zf7xxgcp5yrbR99J
	0Dcu86vXzim3iadLcnYGIGqEtBJpRhO3T6o0Uv7nCduQFhwEq/c17Qk7o5EnV5teDl4ca4+qu92
	OeCVVkPbnFqZnFD4OYmtd0C8i2BztK6pk+GlNNanGBxnc3yNVHqe9BYwF8QpOkb52jov5tr2vDV
	1G7J74X8pjxChu5FyZySiPu3KNlCkn09zx+7JAg0HjRzdk11kxw654MjCG8OFlQN4r3fRhn0jVW
	pDrRyBIgA==
X-Received: by 2002:a05:622a:2c7:b0:530:e36d:1855 with SMTP id d75a77b69052e-5310d056446mr16612371cf.42.1789369751707;
        Mon, 14 Sep 2026 00:09:11 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.135.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ff1bf4a2sm30590071cf.17.2026.09.14.00.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:09:09 -0700 (PDT)
Message-Id: <pull.2402.v2.git.git.1789369749450.gitgitgadget@gmail.com>
In-Reply-To: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com>
References: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 07:09:09 +0000
Subject: [PATCH v2] ci: drop no-op gettext link on macOS
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Homebrew's gettext formula used to be keg-only, meaning brew would
install it into the Cellar without linking its headers, libraries, or
utilities like msgfmt anywhere on the default search paths, to avoid
clashing with software that already ships its own gettext. `brew link
--force gettext` overrode that restriction so the keg-only install
became visible on the paths git's build and tests rely on.

Homebrew dropped gettext's keg-only status in 2020
(https://github.com/Homebrew/homebrew-core/pull/53489), so a fresh
install now links into the prefix by itself. `brew link --force`
against an already-linked keg has nothing left to override, and only
produces a spurious "Already linked" warning in every macOS job's
log.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    ci: drop no-op gettext link on macOS
    
    Gettext is already linked on the macOS CI runner image, so the forced
    relink was a no-op that only produced a spurious "Already linked"
    warning in every macOS job's log.
    
    Changes in v2:
    
     * Clarify problem in commit message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2402%2FHaraldNordgren%2Fci-drop-noop-gettext-link-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2402/HaraldNordgren/ci-drop-noop-gettext-link-v2
Pull-Request: https://github.com/git/git/pull/2402

Range-diff vs v1:

 1:  9af619d085 ! 1:  39922c8e97 ci: drop no-op gettext link on macOS
     @@ Metadata
       ## Commit message ##
          ci: drop no-op gettext link on macOS
      
     -    gettext ships already linked on the macOS CI runner image, so this
     -    command never links anything. It only emits a spurious "Already
     -    linked" warning in every macOS job's log.
     +    Homebrew's gettext formula used to be keg-only, meaning brew would
     +    install it into the Cellar without linking its headers, libraries, or
     +    utilities like msgfmt anywhere on the default search paths, to avoid
     +    clashing with software that already ships its own gettext. `brew link
     +    --force gettext` overrode that restriction so the keg-only install
     +    became visible on the paths git's build and tests rely on.
     +
     +    Homebrew dropped gettext's keg-only status in 2020
     +    (https://github.com/Homebrew/homebrew-core/pull/53489), so a fresh
     +    install now links into the prefix by itself. `brew link --force`
     +    against an already-linked keg has nothing left to override, and only
     +    produces a spurious "Already linked" warning in every macOS job's
     +    log.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      


 ci/install-dependencies.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 2f61fbb07c..2903c39fab 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -117,7 +117,6 @@ macos-*)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
-	brew link --force gettext
 
 	mkdir -p "$CUSTOM_PATH"
 	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&

base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
-- 
gitgitgadget
