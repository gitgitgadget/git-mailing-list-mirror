Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908B14198A
	for <git@vger.kernel.org>; Fri, 17 May 2024 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715987765; cv=none; b=jVceO6gkBXAZNNi8eji2v2Y3w1oK20mcEy+Tf18ZaZ24y1JHGXp+KlNRDLseOUtgC1KIcUCHc3b/PMR/Fe5Hab7W5oWrrjnkkEZFcNw8Ec1sSd51cidvFBwEiEqzmKtL2oSjFZjukQODExIVThNiDnCwBHVNmAgf7mB8x3KNgZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715987765; c=relaxed/simple;
	bh=nBY7fo6xdq85d2tV09GeFwAg/gEU5cYmDJWqhMOaHhA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BGq8WCRfSmLUsRy6t83W0nYCNlbbjAndcpxMndlWNbSHYOuOUX3Y4qtx5SZ00NoMY2zemNeoez+memZwzNv1H5JGstyC+UIDCgBxAR4uWCAADivAPSEW3fD9v9oKk6202+tlIw9GtexDZmAbVZnfO0y0NITkF8Hdk7o2e+Jc/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmm+sSbm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmm+sSbm"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4202c0d316cso3462835e9.1
        for <git@vger.kernel.org>; Fri, 17 May 2024 16:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715987762; x=1716592562; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0w/5eLRUAQNj9Fjdip1J3pbt9hbch3qiKFHcJA5wueM=;
        b=Zmm+sSbmrFDhQY1+eA7ITOj3qQ5M9MvqTknRsSFuka2mesOAuQd9h/sXf/UOkPefMd
         qCDKeN8rSkr6QlhuMoK0e78oPwMD5O0MfB8THZho2CmW96vGf42B+WXwlWWqf4/HYd06
         YNYiE7r8St+Aoi4luUAGR2KxcPVYITA2Qe52XygdQaOC4mvBLXGrQMZw8VxcBhKSuamC
         sF+3wYG52zviNSrACsg1o/+qj6CP2uCUe8S8nOAsNuhfiKLNIiatD+aOlOxcNk04Arf+
         7zaYmo8KVxpS0ys0r4qZmMt9wRKsNJTnlghR3c4Mt+efEN+FPgIBZvBFOmXqoTHK2RyJ
         d6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715987762; x=1716592562;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0w/5eLRUAQNj9Fjdip1J3pbt9hbch3qiKFHcJA5wueM=;
        b=GtS9y3x4+zqfr35YyWMKj9wUTxMpRxY5HkjbTAW8KOYddfxfP09WM6jvEDFF1sApMV
         RC9KuyTxRVEAAdwtaZquwyyR/1VjWL1aLRWpZhb9JrGBoGONeTxSQBkG8+Ia4yzf4RiW
         caKRbq4BRhsVxaADV4/uZYLvYTP8YmvOnY91QQyB9PcpRZUF4I9rw/kSdNXgAd7F4Q4I
         9W9T/Zgku/bVddDi/vWGHMWQcQdg0XzpZ7o04Fp9vFs1QCJEWq/0SpLEWPP+uvZ342cG
         zIZfT/YT9Ucy91vxqxD3TX1C+MkPQ3AdAdn3xAgSv2UwmeMDGbJBIyx4JGtqlO2ZeaRM
         gn8w==
X-Gm-Message-State: AOJu0YwLxEmmvXwrG/0ymmi3s56hO1wXdaIjuftcO/SxB308+onw+VLC
	gOEUtSIaODR5J68eXh0KEW2nZ1XO+ZBHOiwakUW41zdUcLnjyFKRKU9ROw==
X-Google-Smtp-Source: AGHT+IHCMZT8QmGYpKZp0Np2Voig2+PURwuDAsWPuJwXZxnjc7eeIv8Z39ZwsTBUJkaAgdj3iviV0w==
X-Received: by 2002:a5d:620e:0:b0:34e:3d3a:e144 with SMTP id ffacd0b85a97d-354b8de79dfmr331350f8f.2.1715987762378;
        Fri, 17 May 2024 16:16:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8969f0sm22726698f8f.28.2024.05.17.16.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 16:16:02 -0700 (PDT)
Message-Id: <7d5ef6db2a9c3c7a1b0ba78873d4202403768769.1715987756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 23:15:52 +0000
Subject: [PATCH 4/8] tests: verify that `clone -c core.hooksPath=/dev/null`
 works again
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

As part of the protections added in Git v2.45.1 and friends,
repository-local `core.hooksPath` settings are no longer allowed, as a
defense-in-depth mechanism to prevent future Git vulnerabilities to
raise to critical level if those vulnerabilities inadvertently allow the
repository-local config to be written.

What the added protection did not anticipate is that such a
repository-local `core.hooksPath` can not only be used to point to
maliciously-placed scripts in the current worktree, but also to
_prevent_ hooks from being called altogether.

We just reverted the `core.hooksPath` protections, based on the Git
maintainer's recommendation in
https://lore.kernel.org/git/xmqq4jaxvm8z.fsf@gitster.g/ to address this
concern as well as related ones. Let's make sure that we won't regress
while trying to protect the clone operation further.

Reported-by: Brooke Kuhlmann <brooke@alchemists.io>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1350-config-hooks-path.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index f6dc83e2aab..1eae346a6e3 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -41,4 +41,8 @@ test_expect_success 'git rev-parse --git-path hooks' '
 	test .git/custom-hooks/abc = "$(cat actual)"
 '
 
+test_expect_success 'core.hooksPath=/dev/null' '
+	git clone -c core.hooksPath=/dev/null . no-templates
+'
+
 test_done
-- 
gitgitgadget

