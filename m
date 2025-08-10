Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06603220F24
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754861428; cv=none; b=cZQYRamRBejbc5WaAXq5eUm+pWtgSBrhf8tkv/hKHgZ9OQm57YpmyYjQmDSd9xSYCTjY/TYXxd2N/MsfA5//DxPo55f6HVHmzV1JEgu3jrKvmh5IL2rOZg0ySqd5JZ0FzZVqSkEmMN5yj6UjhvrZ6E4Q2UxBfPEE+BWjMhb1Lsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754861428; c=relaxed/simple;
	bh=GgReRTVdvD/TOizN8iHuqdcvTGKNaiEbXCTspAgnywQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rkFa12LtvB1C+3JzB3sbXq4Au6qMslC5T0ZRnFBgMPkYOUj9DStYY3PSPLFhwhSI1nA7QkYZZHNNopP92ZqqooQoablYJGwWXDDCMg3eDIR8Ve/1zx8FM+XyjLu37C1UJNS9pSG9EXzdrtBCnm9ZbLvlQy5ne2JzJhjVrJYD5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEnktqwQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEnktqwQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso22987525e9.3
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 14:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754861425; x=1755466225; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N14ennkG/uJfmo4XZh5PHGBjrz1F9Ub3sHZ9B3GWR14=;
        b=VEnktqwQa3v5Dujqzm48qau23NVL0CnHmR+oP6AYaiht3CBP8NHz21gIKcr7k+5lUI
         BRoq4qiKzX3i7lzJzPyFC9L8Znr9jxJV+ZkG2p9jOTSzwbLWPXSxK8x1a0ziLl3vOSAH
         u6ogEIXpLHUzE8Y2N176kqVNEY6f0gOP6xyJQvAnZn65WQizoJl82UBQnGPWNeLmIyZC
         ZQMpp+NHVtdr2FlB++ISoGYoxAAljmRc3BdRhu91UHUKK320cSo0fzDAyP4VkKbZnlgw
         OmVZzKl9v1vYESLk0E6aiSLqVisVLi7Y543uJVgHhhh2gf+L65desXjOr8MaQEdppnDp
         LmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754861425; x=1755466225;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N14ennkG/uJfmo4XZh5PHGBjrz1F9Ub3sHZ9B3GWR14=;
        b=k2QfEp2l6xfV15DARb9ln3apoxLkx6Xj29GiY6Esm3b1i2bxdeGSX48U69yxyUoYQ4
         //B5Mlo64MdbH47LrUCpItULRiwwD2yvNU5XIlVbKL2GG/0mDet/XmewAucMLfzK6Cxm
         ICRsmkSay+EmI3F/37+FlZ4jC1TvYvevE/IwCrO2piRPUXIWTzwkbKcjqJ1zNqoMqldq
         IDd8Bj3feDAzMz8qJav1jIIqPgTzQ2UyWiff+qfOpBW5bP+nxHpwRIll+jZZOjIwF2k0
         QfsfhvX8c1jMxVfHkftHYLYVNEz5K+NOi+eQ2iTTB6pm6rLh0/ZLxLf5T6LF0WjDkmKp
         AS2w==
X-Gm-Message-State: AOJu0YxYMnWo0HtPcw9OULRKkKVPG1dMqc9UPMCWNKaCQ+gVa4j7U4Wr
	3GDUKxLI89jUHI88Ee5Taw8uS8NUA/1nrJp5Zn50T0hZIuW/JAjGStxjXJyV+Q==
X-Gm-Gg: ASbGncvEafy1/jRwAE1oJBbBEjeipLi+GnGMA0TUqDPcuqp0BWlwAEJbxJOdljPjAIW
	1d1biPaCdPQmGf11Mk7FUiM88vA6htt+AfaOd1yk4XgDSi9gc0OgXnWqI180XE0D1nBnkjbSFNN
	6mahkWmvf4xvxGS2R999HbRRpXavCrBR/SPUQhpZBH5aZysQapgM61dmu82mxBXJbupT3enz1vZ
	1cBk0y4SuioMGUtJUNwl9VHSQl1wWWLcz9A/usjRkyX9eG8IVM2Pz8/4a9Eo2wztCnM+Pkpucdi
	ff1JoX+M4NHaogDducczl0vLRitbCshUDCGyb0hee0mR+yUT9xpct8Es0isxo4OT6bfPjgezQP1
	+Ik+mAu7oQmwSJXSNKG9wa/IHjQu0+6vMjw==
X-Google-Smtp-Source: AGHT+IHyfIr4olFCpZ6Z5UMZeM+7Vri7r0KjePMjTvEyBnfgklJuvgnG4lukexMyxI7xAuPR7ySDlw==
X-Received: by 2002:a05:600c:4f81:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-459f4eb18bcmr90769935e9.9.1754861424929;
        Sun, 10 Aug 2025 14:30:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc7e1ddesm312042295e9.27.2025.08.10.14.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 14:30:24 -0700 (PDT)
Message-Id: <pull.2023.v2.git.git.1754861423787.gitgitgadget@gmail.com>
In-Reply-To: <pull.2023.git.git.1753973177262.gitgitgadget@gmail.com>
References: <pull.2023.git.git.1753973177262.gitgitgadget@gmail.com>
From: "Knut Harald Ryager via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 Aug 2025 21:30:23 +0000
Subject: [PATCH v2] Remove the extra and incorrect closing bracket, so that
 the line reads:
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
Cc: Knut Harald Ryager <e-k-nut@hotmail.com>,
    Knut Harald Ryager <e-k-nut@hotmail.com>

From: Knut Harald Ryager <e-k-nut@hotmail.com>

    [--filter=<filter> [--also-filter-submodules]]

instead of

    [--filter=<filter>] [--also-filter-submodules]]

Signed-off-by: Knut Harald Ryager <e-k-nut@hotmail.com>
---
    Remove excess right bracket from git-clone docs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2023%2FKnutRyager%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2023/KnutRyager/master-v2
Pull-Request: https://github.com/git/git/pull/2023

Range-diff vs v1:

 1:  6bb5c653356 ! 1:  bb158425b8a docs: remove stray bracket from git-clone synopsis
     @@
       ## Metadata ##
     -Author: E-K-n <e-k-nut@hotmail.com>
     +Author: Knut Harald Ryager <e-k-nut@hotmail.com>
      
       ## Commit message ##
     -    docs: remove stray bracket from git-clone synopsis
     +    Remove the extra and incorrect closing bracket, so that the line reads:
      
     -    The git-clone documentation contained an extra ‘]’ after
     -    `--also-filter-submodules]`.
     +        [--filter=<filter> [--also-filter-submodules]]
      
     -    This patch removes the duplicate ‘]’ so that the line reads:
     +    instead of
      
     -        [--also-filter-submodules] [--] <repository>
     -
     -    instead of:
     -
     -        [--also-filter-submodules]] [--] <repository>
     +        [--filter=<filter>] [--also-filter-submodules]]
      
          Signed-off-by: Knut Harald Ryager <e-k-nut@hotmail.com>
      
     @@ Documentation/git-clone.adoc: git clone [--template=<template-directory>]
       	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
       	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
      -	  [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository>
     -+	  [--filter=<filter-spec>] [--also-filter-submodules] [--] <repository>
     ++	  [--filter=<filter-spec> [--also-filter-submodules]] [--] <repository>
       	  [<directory>]
       
       DESCRIPTION


 Documentation/git-clone.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index 222d558290e..d829206d1b5 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -16,7 +16,7 @@ git clone [--template=<template-directory>]
 	  [--depth <depth>] [--[no-]single-branch] [--[no-]tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
 	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
-	  [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository>
+	  [--filter=<filter-spec> [--also-filter-submodules]] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION

base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
-- 
gitgitgadget
