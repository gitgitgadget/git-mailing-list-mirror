Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529826FA5A
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395316; cv=none; b=fnDlcZ/HkBj3tKFpPXQ6Wwv1B0ujRJHlVwdr72aDB7kakSqXapQ3kxx3LRsL2l4PCLZIDWP9BkaJk6LZuoXsyq4sD12Qx+rNBFItIH622zg5MpwfxDtBSVrudNVeUivZvHqKgyioWfuXqXWVppqL9Bi6E8tQqozkCy+hE+yp/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395316; c=relaxed/simple;
	bh=r4ApJ6BpRYoffYlotNi0Gaub6wWlfWXSBVtgBktQeAI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sb9zDnT2T4jL4U3htXyKB9FSXBbmcSR0WD34Lr9Lhp1Ne3Iv2fMjBzykIaKZzz/mj/biwDmhvuXvnA9jwNc4OBYsKc2klMYigo76H6a0ejHJnFDujCoQy7VQhsFGKj8ufjam0ESYrc+XCoq8mOQLrZbEpwKBu1v5L0a++dCMfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/Y+Q1NU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/Y+Q1NU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso55850515e9.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745395313; x=1746000113; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbA7Nr7/4ODYZWUa5oik9mGMXCAH202DamVainI7CMQ=;
        b=N/Y+Q1NUx8yHOJrookDlK8XpqGH8j75l0rND/0L2tMRZd9C7IEtP4eN6V1LHGX31Fx
         L7FOXpZQqjmpvicpcnBQDU9Mw1D+S6njF4ZfROXBC0GAK1eafePAeRpsJ5yqFd/L0u7f
         e4jxeeFDMIalcSf+iX9jH4tAUCoLSrtulllC1vHIanNjm0sE4LkaUsUve6wckKyxdu+b
         9bVJEipc5D2YQyssWE8MWSFdDaT0/Pg+kn69e4VfuO07Ouz1cJj253fQOxTIQZh5FmVn
         iKRAS7r6adyWuALvDoeAjdmYRDPK9XqASa+KwC3c5rXtSosy9uqvMyKtOyl+r3aC8tYl
         VJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745395313; x=1746000113;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbA7Nr7/4ODYZWUa5oik9mGMXCAH202DamVainI7CMQ=;
        b=WX1BnBBJ+gxFgHQ1596lpsIYHrHXn5+xA1aqOYIOnc0qjsEEYGIZEdn3UJXQy1gQ5O
         iLARWPUfDcGVMWq7tJ2NJZXoX6xnwSqxK/SJv1QNUSoXaVa3Pc0/R0kmCc4VYqTISawv
         4fBvYPEg0EatM1Kjvg4LK0pfka/7OXaiK0/QGB2BfS5MEB1/pP0sk5mEQioiC7qcmX38
         HUZwER8kF/iWNCqfnALymLzRXt8P76zZJ70AuLFJXKSzLLkVGL1X8vdHXbY75f6fE5GW
         iemuNfQDk9N/zKDpnU7yD5yHA+svxpCxhGkwKsudAik/cMCm7HVLIzvOoKiS0qsSBki2
         PT3A==
X-Gm-Message-State: AOJu0YxQFbSCRtOD7TzI02DbWpkfH9aK0x2gpYN6MRNumJ7rAov3/quv
	uS+jw6wWNMuJOeBEiwilO4melWzzj3RTumSY8eazfhDgbEvtbBp9FFyh2A==
X-Gm-Gg: ASbGncugfHZt4dSeN/fd0PExzSODMNEAMeFtL2FJ/NhLvUXK5SqkzPpMDM1NLUjD3ob
	yYSr+VGNMXeFpWXc4EU3svpZ5vTsJltZCokvSrdA3nd+2TD29krWK8k3Yy6QU6upt6LhGXn9Knu
	tTEvULhyQBFkMMmHdvMN/GzE26+8YBsk0EqICsCpHvSAYlePv6IMmWoNpCjxd8lOqmUOpnlDdzZ
	lvlm4/4mpJEDGL/WcjhRLRCcDEmSHluy1yVWRU2hNH08WcMtnHgEQFoZZC7enSoLPOMTvLKxhIX
	VBCYq2e/DhTqZA0lRBiqaqDltrrhxbsmxNVKMVdSLw==
X-Google-Smtp-Source: AGHT+IH9NN2g8rqvCb2De212Ue7qcjg5eXQeUwAcDC/ZrJUu9fATxRL9WjG/wioZvrK0DWN81PnsCw==
X-Received: by 2002:a05:600c:1e0c:b0:43b:c284:5bc2 with SMTP id 5b1f17b1804b1-4406aa89eb7mr188558965e9.0.1745395312519;
        Wed, 23 Apr 2025 01:01:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d4707csm16278815e9.40.2025.04.23.01.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:01:51 -0700 (PDT)
Message-Id: <2feeadb0d3fb7a631489e36d861d112d46423f2a.1745395308.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
	<pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
From: "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 08:01:44 +0000
Subject: [PATCH v2 2/6] config.mak.uname: add support for clangarm64
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Dennis Ameling <dennis@dennisameling.com>

From: Dennis Ameling <dennis@dennisameling.com>

CLANGARM64 is a relatively new MSYSTEM added by the MSYS2 team. In order
to have Git build correctly for this platform, let's add some
configuration for it to config.mak.uname.

Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
---
 config.mak.uname | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index b12d4e168ae..1e5d89f1aa4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -724,6 +724,10 @@ ifeq ($(uname_S),MINGW)
 		prefix = /mingw64
 		HOST_CPU = x86_64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
+        else ifeq (CLANGARM64,$(MSYSTEM))
+		prefix = /clangarm64
+		HOST_CPU = aarch64
+		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
         else
 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
-- 
gitgitgadget

