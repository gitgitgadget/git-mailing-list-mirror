Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923E244EA1
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496549; cv=none; b=uMqZZF8wGNkZYVGaExnxdsbXQk+dMQHZ+5wRzerv9IuystOk72bc8i4grgqzLUQ32sDfp2TPpdo6eaFv5h93rei0+wQhS/KWqXtUaKyNC2HkwyM07MXsKNhq0fiWkP8iiltoxNrtnefiuA1SDpks64PLZKe0/EZF+JVeP1iY59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496549; c=relaxed/simple;
	bh=IZKfqlzkiEZ9xBbspePV0OZmPcwzXTYve9phqPRwwDY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E7y0HTGXG/dMdChFQB4OoipeQ7y9kAsUjCKNXpaeECngpbyxMWHss+EzFAhO31P2+8/wmv5AU6ovEKiOwyH3whvL9Md8yjl86T4pQi3+M8JaTXTDVlkDvOLh7km3+gs5ZPTzOH4y/TeBZoZaJV4I4bO2DQuoSUGxp/p7KVOKyYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt618fS1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt618fS1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24458272c00so26656385ad.3
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496547; x=1757101347; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7JJg0rgGc2nzHqPkyjooP+cjyaBFhU8peq7DPMJe0I=;
        b=kt618fS1W5EoL1mAVeLB4z9ZrYl1DmsaOjZjunpVaF1u1Mn6KyothRVulVbtVaeXzE
         V78zLkjiyMIMTxUabeG4fyUCUwvkKuM/OMoBmGQB5NmvuXhKcF0PlXXOoMqZ9nCMnsSK
         GGOTwluXpIYyJ7chP7eB9p264ZbP5tfRS7q5YbzWVX6jzLOtjlQCHxxj3Q6R0uL767DE
         q2lP2Iz9Nh8UxkUUnfGIoZvgCGembrq1ui+bET+4Epki0MdvaKEZA+XeyA5rZwNxErJY
         VN3V/nDAcXoVY8uLuBaiGPNoIpdPsM52VX+u6HuxA5Wvp7rk3EeWFx/QOwK06plunL4f
         GQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496547; x=1757101347;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7JJg0rgGc2nzHqPkyjooP+cjyaBFhU8peq7DPMJe0I=;
        b=CWx0a9cW9hIHcPMaf7+CGT9tkzAmVAZ5hXGkutwfReAVrSYkMwY0EiwXHGV3KMxxZZ
         z2DRE3ft4JFk/eZ7bEFHqBH3rjruVQzmlRMrxsjlVPXQK+ZMjRorqcjVlpEPqrLm6RqB
         xe+BL/DXmNKtNV87oEmNCfpzdAn9phFR6TqpnwmOormiZLHqsaLeZaDqYzViyqlKk6zm
         Fdep1GmyNjcJfWBLpFny/9aANLEqOnTdvDeBDiNKvox5bA1CouJyczoxrm1//egqWABu
         6ikop5uaurH3WSqNQMgrGNyXcPv2aOlYd9BJUUpNStjeZkBPaHRkP9al54Rh/u38ElTN
         EX1w==
X-Gm-Message-State: AOJu0YxWcZkHIGwjsALFfg3JWrdAOR0R1w2Km2/DQ3LkIsf0kngJE8fY
	UsZbDFEnL3XU7awv3gDdevmWXimywuEGzpB+2nR0J+jpB9h9feMu9S+giF1sAA==
X-Gm-Gg: ASbGncseXqbsTs7/nGFjH+AMka9UWREr+6m1KgASKkJnV7qPP0YqJOTh1yYk92TMW6y
	iEyXiQd85YnixFe3bn5PkGjdAGWI6+EWVGVvD1ewPRvasoU6KY25I1GAfB3t6tY+wSJTXa0WMhA
	pMJnw5fH/Em5Katah9o2OlJr2Hsr1w11uTankaNlxVHIBDEiJdwEgQZib/MGJ6kIP/EZEXH30ZM
	Ij8wxT49vJODWO6XTcDJcykWAZEg8V9foULlQdLE6l5kJi6+I57yPw+NpsDwVA4soB8jEDqVBcx
	wTfRV6KabtCkzpLa8EWrtxnN+dZofhD66bWvYqi7y5cTXA2OXmQVWlniACq+vqY6u9mJe7t4xRo
	0FnBVOuVHy/b0vvtB83c+hrfa6NI=
X-Google-Smtp-Source: AGHT+IGsjnOFomUu+ysZfv2BjYtidRd3TKKt+gdTh462pAZYyuwEUXhQPTk9C/RIeckmXquWjAVTEw==
X-Received: by 2002:a17:902:ea07:b0:248:ac4d:23a1 with SMTP id d9443c01a7336-248ac4d2827mr133923085ad.37.1756496547059;
        Fri, 29 Aug 2025 12:42:27 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da4784sm32853235ad.90.2025.08.29.12.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:26 -0700 (PDT)
Message-Id: <8e350700bcdd0c2e020e24c202335aab4fffe286.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:08 +0000
Subject: [PATCH 04/15] win+Meson: do allow linking with the Rust-built xdiff
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When linking against the Rust-built `xdiff`, there is now a new required
dependency: Without _also_ linking to the system library `userenv`, the
compile would fail with this error message:

  xdiff.lib(std-c85e9beb7923f636.std.df32d1bc89881d89-cgu.0.rcgu.o) :
  error LNK2019: unresolved external symbol __imp_GetUserProfileDirectoryW
  referenced in function _ZN3std3env8home_dir17hfd1c3b6676cd78f6E

Therefore, just like we do in case of Makefile-based builds on Windows,
we now also link to that library when building with Meson.

Note that if we only have Rust depend upon libuserenv then at link time
GCC would complain about:

  undefined reference to `GetUserProfileDirectoryW'

Apparently there is _some_ closure that gets compiled in that requires
this function, and that in turn forces Git to link to libuserenv.

This is a new requirement, and therefore has not been made part of the
"minimal Git for Windows SDK".

In the near future, I intend to include it, but for now let's just
ensure that the file is added manually if it is missing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
[en: Squashed a few of Johannes's patches, and moved lib userenv
 handling from an earlier patch]
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .github/workflows/main.yml | 8 ++++++++
 config.mak.uname           | 4 ++++
 meson.build                | 1 +
 3 files changed, 13 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index ac1d583ab2..ff2f90d122 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -123,6 +123,14 @@ jobs:
     steps:
     - uses: actions/checkout@v4
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
+    - name: ensure that libuserenv.a is present
+      shell: bash
+      run: |
+        cd /mingw64/lib && {
+          test -f libuserenv.a ||
+          /c/Program\ Files/Git/mingw64/bin/curl -Lo libuserenv.a \
+            https://github.com/git-for-windows/git-sdk-64/raw/HEAD/mingw64/lib/libuserenv.a
+        }
     - name: Install rustup via github actions
       uses: actions-rs/toolchain@v1
       with:
diff --git a/config.mak.uname b/config.mak.uname
index 3e26bb074a..6805e3778a 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -740,6 +740,10 @@ ifeq ($(uname_S),MINGW)
 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
+
+	# Unfortunately now needed because of Rust
+	EXTLIBS += -luserenv
+
 	CC = gcc
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
diff --git a/meson.build b/meson.build
index 324f968338..5aa9901bfc 100644
--- a/meson.build
+++ b/meson.build
@@ -1267,6 +1267,7 @@ elif host_machine.system() == 'windows'
   ]
 
   libgit_dependencies += compiler.find_library('ntdll')
+  libgit_dependencies += compiler.find_library('userenv')
   libgit_include_directories += 'compat/win32'
   if compiler.get_id() == 'msvc'
     libgit_include_directories += 'compat/vcbuild/include'
-- 
gitgitgadget

