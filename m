Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C03845A2
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937978; cv=none; b=R7xZyWj3fPA1r9l3Y//Mnon5EFOb0woMitECwSkcsLHs8jCF0oQ2H9aDF4fKtP33/xNRs5ADMeoPTEQIDmFNXJuY1pe3EevMlHT9oe4+bxgD8/cUTnWiLZDlUXsBCMuf1UDvjN82GWeQ/4fgP2gG7ahKiPt4z+ehKJl41jJ430A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937978; c=relaxed/simple;
	bh=jcgDwukSC1DVSos1K65JQ8LumLuP+q4tiK46hKwGcgU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bZ1ebjTnuBIQf9VBseV7bF1GUG7fjVfKVij2a5eeF9ahCmujG0MuoFMsk6pCcOrssvBo9x0QJaWSZtfanSeL27Q2ZXLKz8yD4bj5dqlNkHBgxtcHv09yiQ1KXC9faeYJBHiFDEfd1YqrfZ6BJT+/PbkKSNsuUFKY3T15q36FIDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt9l+hyL; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt9l+hyL"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d9b1c57a4cso4622778a34.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937976; x=1775542776; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=Jt9l+hyLYKIsMcC1y8WcOFp9PKrLRUtjU9GgGbYXHQAPv5aMJjT7EtAn8pC7N2uGmk
         thEu0O4baINnqwNJ4ycl0TESyhnXtANhkyJe+ZCQCrbMx91Y/yVqF3D9hetJlvI/H60q
         91dHgmhNFJraZzZABzupmDnfqc08Q2kTaZWS6Xq9jgEhCjPt1HFmlBrtvmHW2REJwxdH
         Gz7sU7I737ArLGb0GRZdK/lhV+roLuaTH9ck/Chwuq6683xiv5QNbSRlKp1Eu4QNLK5a
         QZuoZALhzMCgBonyzhQJFU1ymT0cVxgfPfNBssFy2z/ejMZrQcvGXy77Coot8Bp5jm4N
         4hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937976; x=1775542776;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=NxmR5uctaxkee3lkLPVuRTDddHn5Nauvkc6gGnXauCVawex/9PA4RiZsVvt/w/EJ9b
         wg//tZ1dex4tju5E+Ub3C0RCNKWTnXV/OGtzWSYGZN39wW/epklEKrvrXW8RyTrsi21Y
         tHlkDWTk3qaUhT5vgKNimjNn84+wqNT360Wi7e2N3iXPDLVXAIbv3AZzaraqqqZW2fAJ
         QPExmj3g8sOR+EvS+6kaFuUz8sGYHVTN8754Htzx0woE4DR4TkXl7N/76fJ+y3tCa8/p
         xMsM2nC6GraPA9+nFt0ZixmckeTW1fGhlK9OHuAGQwsVOX33wyZp1OWIjogCV/M/j3Ph
         NcSA==
X-Gm-Message-State: AOJu0Yx/btYfTxyPzedUFwwPgRTu2uuF3d6v9tMZPt3mBUUNIoJ6iuh2
	S72Jrb1dvku6yagIRMrA8LYg+Xf5EGh3RdlGTq6OMMnMvK+dwNLjF8AN2pVLQVUA
X-Gm-Gg: ATEYQzwqaekcYXrvqHv9A2tJoCmdUk6ugyz49rR8vfTgmDi5an0hujGcxQFb4HHPVoi
	M9LQbAS0SxZq5noS1PLul0cvGH3L7D/Pkmm+UubdI/q//xzjgGDCTSsS7xsFzcBH8mlkbxQaSi5
	5qCuEP+iQ1iikR9ydVZmcpLpoZMJifdByuOT17wY0r4QDRvsnBkPzVhrZGacvbE8J/RX14rregZ
	FEqGpFhQzrBb/24K4LcJslaEOHysJ7VZogvwb13Sj1qZhwIhOH47aJfPy3Qpjts2wQDoddELNsH
	sMNmTI2uqjYu+oj5tL9z7FJRrWS9Y6WawAy7J4kwqKQJnc2/bNK+1rhuIqerixvfyxvHoy7CqHy
	gVORKauWtx2eYwyzKBuYHaCGC97TEm9A7wOiW4Z12NnMLeDsTV9ZQMD6Wl5gIZsDMfi5mnLGpgl
	oad2w1iUeuPOSTC4ony3QZJLnQg4g=
X-Received: by 2002:a05:6830:82a9:b0:7d7:455d:1003 with SMTP id 46e09a7af769-7d9fad9b3d5mr8731292a34.4.1774937975912;
        Mon, 30 Mar 2026 23:19:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.162])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a33546csm8327809a34.1.2026.03.30.23.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:19:35 -0700 (PDT)
Message-Id: <b2aaadb4aea37729989c6cd08838d7aee5b9dc4c.1774937958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 06:19:11 +0000
Subject: [PATCH v12 06/13] fsmonitor: rename fsm-settings-darwin.c to
 fsm-settings-unix.c
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
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The fsmonitor settings logic in fsm-settings-darwin.c is not
Darwin-specific and will be reused by the upcoming Linux
implementation.  Rename it to fsm-settings-unix.c to reflect that it
is shared by all Unix platforms.

Update the build files (meson.build and CMakeLists.txt) to use
FSMONITOR_OS_SETTINGS for fsm-settings, matching the approach already
used for fsm-ipc.

Based-on-patch-by: Eric DeCosta <edecosta@mathworks.com>
Based-on-patch-by: Marziyeh Esipreh <marziyeh.esipreh@gmail.com>
Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} | 0
 contrib/buildsystems/CMakeLists.txt                             | 2 +-
 meson.build                                                     | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (100%)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-unix.c
similarity index 100%
rename from compat/fsmonitor/fsm-settings-darwin.c
rename to compat/fsmonitor/fsm-settings-unix.c
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 6197d5729c..d613809e26 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -306,7 +306,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_OS_SETTINGS}.c)
 	endif()
 endif()
 
diff --git a/meson.build b/meson.build
index 86a68365a9..4f0c0a33b8 100644
--- a/meson.build
+++ b/meson.build
@@ -1338,7 +1338,7 @@ if fsmonitor_backend != ''
     'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
     'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
+    'compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
   ]
 endif
 build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
-- 
gitgitgadget

