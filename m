Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB83B2F5A2C
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050647; cv=none; b=FkUVk6BTqe5RiAY9VZkQCpjE7PitTSZe8ufaegxK+DXA5MXMK5WnX4qilaQLS+TjBWnk0kf/algxDpVkRbzphG2u1jd2D/NDYREW+ruNsXtbKva8PuFSdFSPMp3RU2PPv3ZJkwTs77kFVq86QpxSs7GJ3NaO/CW0E57oafLdtII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050647; c=relaxed/simple;
	bh=qFUGhX5K0EdXFhP0lRYRqnKijnP8oX1/km4szrCzI18=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ej7mogy/0uo9hV+8bWLarO77NUGZfjQ86ozgEtUih8iSxTSTv/EdNPJBasD7b1Beoka3XLEaFfAtP8e4hLcsTEoXfC72GhTrd6O6j1jbHAjrIc1yaOFESweBsFU5Iw3KAqTSFt4H1AXWb3lbVLWMc5cWLGMncvcomdx4o8zIP6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFYKVix5; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFYKVix5"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5033387c80aso17124251cf.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 12:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772050644; x=1772655444; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzpXplbIieyHLNczHYss4CYl/IQN2bgS1mLO66FLNi8=;
        b=GFYKVix5SmAe5HhX8uAnCt9Xg5uifB8aKyQYYcJZoxjerF6hkeDbK/+mJZcfzg1ZV7
         7wpQ8Gmvo18P98fytGQlDiuT2owesXxW/NiR5n/y63Mv6yiYS+ah4/4exOhVsRGpqAoG
         uGqfTo0Y4lLA9Pyylr8cFF4YB+/vjqwwVjDVhxqCFBqLv9kZaOcTEhWJqoL1SnV1PwPd
         ke91VaWI9xCF6EFfSQfMVNZLegMes6XIRK0kIAArzNPPK/1ue4yB+wfhB/xO9KT5kuzU
         yWt0RI4StyyltEAB1ZlcoYD1qxyZGiUCIYAoQ4r0rMhNaHmfxfbyzvUqmw11WmvzDx88
         Zw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050644; x=1772655444;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MzpXplbIieyHLNczHYss4CYl/IQN2bgS1mLO66FLNi8=;
        b=r0J16LaH6Txf7Hq2mN0gcDSPgNB52+NdvAcbXQLfDc9Qj6ecazG3qHXmkV8unBqvOB
         DX4txNRHGjEIewkj/VH1x4qECeA8QeHoheQrRoNiuzJHZjAGF7/KkB83J9A79FNLUxPk
         ewhdG2XEEuBFKrxXON32/YXxrwylorZt9Onq0LNqag06Umxo9crhf2T8hKWxIIaZURho
         LKAFT9KuHKiQ2pM8IPOnt3ao5f16QYlxiDN4/EueF2VuapMNt6DGg2cTAIHXg0DzRmgw
         v5YITPo9YSaXLOca+4jGn9j9QLtORfdumfSRViMTUbInfTjNr/Otfep1ivlaM+QOCVEF
         cnYw==
X-Gm-Message-State: AOJu0YxWr9IMzEM7BHJp+aB0T1PC8UUfr2Nt0QDqtotdm1OzdcB6KrLD
	BQ/l4TQ7KNedtgE7D6fRPEYiW4TbxxFa6JU6r/zSVv3aW1dfI1R4C2zi6uYFcg==
X-Gm-Gg: ATEYQzyCni2LtyW9z9Xl4J7fez/BMf9jSsHvGQkl3ef9KalsryJqcBNs7EXGcUkOBoR
	feigynW0b5KMxX2M8AwnrdG/W/8GSQjv6JKSC7xkqoD0fMNF573sWomVVY9HymxZlWf6a5sBQIC
	GGlwGijCUzai6AU23UZzEBpNYOTMi+M0aEX0U6fxGfl9509OQYZRMzQIHAHuzqd3/wT5HKK8Wk2
	QmeA+ichM/5eS6Vxew9Hd2rsG1vZloHQCPJvbDp2XP9aKrXjBtdK5gmxPjD7LrYHpYe7qdLRz9N
	jkBqTbwfpzSAbNU7LfwiOQEtjARDcHSTbt5MpmIIgdVa6fJaZA5+PForpnkb5iUFY4hOrnY8KXx
	MJyqm2pWWhkXfWTd/G3kFQwGZUJtxRTSKtP0XHmPnKrBDIcqhC0UQ+55/6qjzYQo9CW2Bk14/W6
	fcXonCEIirdZnTBE6uhdpQlg2HPA==
X-Received: by 2002:ac8:7dcf:0:b0:4ee:1dd0:5a50 with SMTP id d75a77b69052e-50744391120mr4880591cf.17.1772050644315;
        Wed, 25 Feb 2026 12:17:24 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744afa7d7sm1160451cf.32.2026.02.25.12.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:17:23 -0800 (PST)
Message-Id: <ff31e359a7070c8d410518da0230ad0ecae7d771.1772050636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 20:17:11 +0000
Subject: [PATCH v6 05/10] fsmonitor: deduplicate IPC path logic for Unix
 platforms
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
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The IPC path logic for determining the Unix domain socket location is
nearly identical between macOS and Linux.  Both need to check whether
the .git directory is on a remote filesystem and, if so, fall back to
a socket path under $HOME or a user-configured directory.

Merge the two implementations into a single fsm-ipc-unix.c that is
shared by both platforms.  The unified version includes the worktree
NULL check (BUG guard) from the Linux implementation, which was missing
in the macOS version.

Update Makefile, meson.build, and CMakeLists.txt to use the new shared
file for non-Windows platforms.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 Makefile                                              | 6 +++++-
 compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} | 4 +++-
 contrib/buildsystems/CMakeLists.txt                   | 2 +-
 meson.build                                           | 7 ++++++-
 4 files changed, 15 insertions(+), 4 deletions(-)
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (96%)

diff --git a/Makefile b/Makefile
index 8aa489f3b6..2157bbf173 100644
--- a/Makefile
+++ b/Makefile
@@ -2365,7 +2365,11 @@ ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
+ifeq ($(FSMONITOR_DAEMON_BACKEND),win32)
+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-win32.o
+else
+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-unix.o
+endif
 endif
 
 ifdef FSMONITOR_OS_SETTINGS
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-unix.c
similarity index 96%
rename from compat/fsmonitor/fsm-ipc-darwin.c
rename to compat/fsmonitor/fsm-ipc-unix.c
index fe149a1b37..d34a6419bc 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-unix.c
@@ -27,13 +27,15 @@ const char *fsmonitor_ipc__get_path(struct repository *r)
 	if (ipc_path)
 		return ipc_path;
 
-
 	/* By default the socket file is created in the .git directory */
 	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
 		ipc_path = fsmonitor_ipc__get_default_path();
 		return ipc_path;
 	}
 
+	if (!r->worktree)
+		BUG("repository has no worktree");
+
 	git_SHA1_Init(&sha1ctx);
 	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
 	git_SHA1_Final(hash, &sha1ctx);
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 28877feb9d..32ef6ebe1b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -303,7 +303,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
diff --git a/meson.build b/meson.build
index dd52efd1c8..8de795f9d4 100644
--- a/meson.build
+++ b/meson.build
@@ -1332,11 +1332,16 @@ if fsmonitor_backend != ''
 
   libgit_sources += [
     'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
   ]
+
+  if fsmonitor_backend == 'win32'
+    libgit_sources += 'compat/fsmonitor/fsm-ipc-win32.c'
+  else
+    libgit_sources += 'compat/fsmonitor/fsm-ipc-unix.c'
+  endif
 endif
 build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
 build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_backend)
-- 
gitgitgadget

