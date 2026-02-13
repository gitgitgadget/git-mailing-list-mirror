Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4628C869
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012508; cv=none; b=uCGaIIy648ykQ/GolijA6fipgZHYztNTE/DjY14u+eqkccR+2WhDyxwqXPkYa4FxdgP9D5wHw//dbyJAKuXeYYLPjyeJlRmVHg6P2/wBrEL9mf+fo8/TQbD+AWjM+6ElRKG8i/H0KEpgBfJVPH6aBOfw4ufRRvJTmD+sv0oy7jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012508; c=relaxed/simple;
	bh=rkMqX46HmLM1K1QwuNFM+4Un7gCvbyV4dyM7nPMzkNs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lbe5apr+bFqCDgSybke9re5oHABRKRega1Ctl09TBmitluNe2Iqn9ZJjbUn1lqch8iULyBKBQV5ZVuTdHNmZyxGlYkNPYPkTDtjRh8JcgdN4Sa46t1xBlfTclWyJhxohBUtwQyrVBhU5VqDG1zIFJTkyugH9twQ2+oZW31zcQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+O36X4U; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+O36X4U"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8954c181830so17013796d6.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 11:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771012506; x=1771617306; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hy6jw949WTjHztk/H8m+HjX5Cvsqwr9+IhQISrYmkck=;
        b=f+O36X4Ua1/nhtee4Prf7Vic2Abo/R10lSh3O47v3A0LJT6+bNSj2WVftJIONUeOJC
         V8iG4tNLrn+T666zlL9xomrrhfwiutWg6L2xZIoWXzKaKa1F1vnVwoDNCMIR1EfdusiS
         DMe78gv965Vh/VmZ6ufjqI0tnNTscOfgIdONKxQVE6493UBXnE4kBn8M7LgJdmwiQlCO
         t/8aU2y7ksk81s1QbkFE/g9+A4Qlvz3mLwmQlLK9yoQM8d7z4S+SSgw3jwUGYNGhDSo7
         ZPQo4tLAIj5CS4Xy2m62p1DNVFrm/OjSaMqYMLnxkK7uiJY8eUiNXIkWOvVx96HOyKBQ
         Vu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771012506; x=1771617306;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hy6jw949WTjHztk/H8m+HjX5Cvsqwr9+IhQISrYmkck=;
        b=JRVZUTt9K32DE63B+6llrbqFmVEVRcYsiCJq7ukLyrINuQwvikOizYNttUZVFY9CN8
         XUT2mIprtjtm0LNCjH25povhGeOyPL8uw7r82OrBm1qsZ+xiasT+X8j7IfkGM8VLZVrt
         mpxbqmHWyewHSi/LvoISnOZDncEGUW1pwG/Qy6xCvKy/5R+GNF/NUpokamORGKyHaYCf
         Z6ZJf6TH+fOhYOQnI24F9KxXMgm92nYqjEJJKGGqX9kQYOSj3Hc0PkXM7gpogogedmLj
         FCJ8rHrda3ZzBkxI6Vgbdi5p7Uz9d3AXefH/gM1/DREXdsjFwPcexmyLlqMSRi4hiEcn
         nVRA==
X-Gm-Message-State: AOJu0YyBxsvlHPZmDCvZCqzUxbYy5ZvsjOsEtuemCZg4Zyo7NeXgcUJg
	6RaYjCboxmt/8qg+y4Gm5cqR2jVlaybVyPiMHu/Cl7MTHM9nST6zJAJ37MC3dg==
X-Gm-Gg: AZuq6aIys+VzSVNNbZE3moyLdIEp8S4VzxCnmQioHYzKvp7bz3Fnbv18fCMEPvdskEq
	+tKJiYOvwEWmdn5rSdjjvs7o/O7BwFKzQsRpMhLT/ZXPzo16r4DQBiZYpJkJ16FtUIAmN7Ptl5R
	4fvpCRCA4HfLeLxECUaMmMB27s0vkRhYmt6DKtyqiJyDU57OxYK2yeYL4M4h8II71Ff58yDso6P
	JOg6dt6mzof7g/6YkZ9r7xrPE7sBRyRZL89zNj4KFfS6+KaMa7QkG/Y9snEZQb4gU1eCLv06a5z
	u6nPttg/u4zMsgiUdHWKiRbv+vQ8pXnNuAfv69uWcErYJilIssxUCAiTrnWQMaHT6rfumGE3g/r
	d1qud2HHKq/6ozFN5htpbDll/Stho3iQoXKU47Lt8m+Ht1YOtDTuMy3yQANUO4Spfxu/J/W5Gsl
	fjcIDEk767D7WWoYWeXkMaMHZL
X-Received: by 2002:a05:6214:409:b0:894:793b:b8d with SMTP id 6a1803df08f44-897402eb9e8mr10939706d6.17.1771012506102;
        Fri, 13 Feb 2026 11:55:06 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1f5669sm674968785a.34.2026.02.13.11.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:55:04 -0800 (PST)
Message-Id: <546fcc3446508eb56312fa195483816d94ea0d41.1771012500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
	<pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 19:54:56 +0000
Subject: [PATCH v2 2/6] build: include procinfo.c impl for macOS
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
Cc: gitster@pobox.com,
    stolee@gmail.com,
    johannes.schindelin@gmx.de,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

Include an implementation of trace2_collect_process_info for macOS.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 config.mak.uname                    | 2 ++
 contrib/buildsystems/CMakeLists.txt | 2 ++
 meson.build                         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 1691c6ae6e..baa5018461 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -148,6 +148,8 @@ ifeq ($(uname_S),Darwin)
 	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
 	CSPRNG_METHOD = arc4random
 	USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS = YesPlease
+	HAVE_PLATFORM_PROCINFO = YesPlease
+	COMPAT_OBJS += compat/darwin/procinfo.o
 
 	# Workaround for `gettext` being keg-only and not even being linked via
 	# `brew link --force gettext`, should be obsolete as of
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index edb0fc04ad..d489f0cada 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -274,6 +274,8 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
 	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
 	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c compat/linux/procinfo.c)
+elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
+	list(APPEND compat_SOURCES compat/darwin/procinfo.c)
 endif()
 
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
diff --git a/meson.build b/meson.build
index 1f95a06edb..32d470e4f7 100644
--- a/meson.build
+++ b/meson.build
@@ -1292,6 +1292,8 @@ if host_machine.system() == 'linux'
   libgit_sources += 'compat/linux/procinfo.c'
 elif host_machine.system() == 'windows'
   libgit_sources += 'compat/win32/trace2_win32_process_info.c'
+elif host_machine.system() == 'darwin'
+  libgit_sources += 'compat/darwin/procinfo.c'
 else
   libgit_sources += 'compat/stub/procinfo.c'
 endif
-- 
gitgitgadget

