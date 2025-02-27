Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F526BDBB
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671056; cv=none; b=ruD7CTGaM68Xf2FYqAlz0qYtcua2TURtJbs252EfuMc35301knhhy1/hOie4wiJ58dENS5y4hka5EruUgz4/TJU9v6UoxJfnVYJuoFSTd7N4x+cGAKhD42vChxVd5kofyv0xj+JN/cw8tMe9EollZEe63xmqLaLOTudKpSn8NIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671056; c=relaxed/simple;
	bh=7/ECHwU/sABJWRVWLT5r7e6u/GcfAWoHeUwLdG5FcxE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ixqIx4jXk5qNMuSkUMwB+6pODwbQfM6bqsmB6URb/1g0JHSPJ9hUM139sCt1z+WRxxG4fhvfLIX1YdCk8Nv2l54XXXhZUraxuO7amIiJLKagolKzROfsPZjWGZOZ/SO55tBcrA8D8MAhQOzS1UvpoRg1qXqvxtcT83FhMrDsm8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCPqULf3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCPqULf3"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394a823036so11461545e9.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 07:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740671053; x=1741275853; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgUeTf4jhqvN8srFtJcQRq3/8efjWvzWSuIX3PICIBA=;
        b=fCPqULf3+7SskiklK6NTAHuS5i4Nxuz3j1ZG2n54+hg7tqsy7smGCo1ei1nCQpQXzh
         3bJPeinnc/WDUSYFpTTKjS2mw70Kpy9on2usmZMjl02NB9FhdlvMejIdLnM0+YCzr0R9
         zMIEWorVAt17leagHneheqCTNRJYkaVtc1shqdCIKqMB4dTUhjCq0tAYE6m9OY7TZNGz
         1K+DP7qkeDzrIir74BniBE25xOfe6BSxy8Re/xh6tqhspV0fHRR8icBF2T0xQBoVvZNV
         F3RWiF0OsZk2pTfxwZPD3cKMx71F8Ss0DswLoBSRwP/TeJ6sBl/yEyzxsWfSSfyseavI
         W3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740671053; x=1741275853;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgUeTf4jhqvN8srFtJcQRq3/8efjWvzWSuIX3PICIBA=;
        b=jNCI2XmyJLvIohNDg+8aPJ2tY/Ykpf8pPUyAA7p6rHR65X/ZkfcGeGL/baiVEvLvqj
         uhrLpyGpSullkN8yBo+7BSe9SXLouTMcG05YUZZ+TBE8wtyNzcUT5fLFZotDvNstQ2EN
         tVT2xlnKySuUnaN1C4mn8hXNzfdC82M1w9DDvLHvpxPkOBlyccDNDYrgXZ/ge2rJoL0D
         juzmDt8f8CVtJ6YTXHpUhhbAxenMu4I/oW2QzAiFlPwkva54kgr0OZpxQwLRNDovz76x
         EUbm3WaWzJXRTrVQSKmVTei3YYRT+ALnOezTq3SO2CDEP7fjjNtnfcratrjNIuKOZuTp
         SGzg==
X-Gm-Message-State: AOJu0YyXh7BtOI7cr/wQH2XU0Vz4EPl0y1cY6ikLWBwhfmqKfU9HWsq8
	Nltz/CNaUbL9LEgEbq0wFw6I5tT6ZaiiUpTYacgbMCQex4QeRSl/ikFovg==
X-Gm-Gg: ASbGncuO5f3uWzyQ8DM28Az2P2j11aLpTAu3il3vNt8shO6fyYJMmC7bqQ89LIIDFeP
	Ewy/NsC8fMtBQQcpEL6zgobyUfzeCpa9Wux+sVFa4ukGsTjwmtRSonF1KbUEZtvmHo2rSzfbmt5
	LZ5UoV6X7aIzdrTNdmI+/MpvO/1VGxATtgewWAG17f0ngOqWcphG+fMRSl3zuD85YOJtnCmneYj
	cosV18WpTygTJvfiTzvDB6KYy+9O9eBtizpYzqn5XM+tUgSCd7fpnSUp75/IyMnWngnoRNrgFN5
	19Ea8zveF/rdwpxkIwyZMeZqKk8=
X-Google-Smtp-Source: AGHT+IH/jfnm/MTHpI5DLZNVlkrwbYY5nSCVaGDci9kWulMHADa8ikjE1dfaOTeYzZztxpUwZ83Yew==
X-Received: by 2002:a05:600c:4fc2:b0:439:9828:c446 with SMTP id 5b1f17b1804b1-439aeb0f1ebmr243657315e9.11.1740671052909;
        Thu, 27 Feb 2025 07:44:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d6dbsm2396429f8f.82.2025.02.27.07.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:44:12 -0800 (PST)
Message-Id: <9d1faeae8a47326fbaef9a7a670920899ab0aa81.1740671049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Feb 2025 15:44:09 +0000
Subject: [PATCH 2/2] meson: fix sorting
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

In 904339edbd80 (Introduce support for the Meson build system,
2024-12-06) the `meson.build` file was introduced, adding also a
Windows-specific list of source files. This list was obviously meant to
be sorted alphabetically, but there is one mistake. Let's fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index bf95576f839..16e451365e9 100644
--- a/meson.build
+++ b/meson.build
@@ -1092,11 +1092,11 @@ elif host_machine.system() == 'windows'
   libgit_sources += [
     'compat/mingw.c',
     'compat/winansi.c',
+    'compat/win32/dirent.c',
     'compat/win32/flush.c',
     'compat/win32/path-utils.c',
     'compat/win32/pthread.c',
     'compat/win32/syslog.c',
-    'compat/win32/dirent.c',
     'compat/win32mmap.c',
     'compat/nedmalloc/nedmalloc.c',
   ]
-- 
gitgitgadget
