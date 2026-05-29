Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B163A2544
	for <git@vger.kernel.org>; Fri, 29 May 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065167; cv=none; b=QghgTRsKqVjn1CWpGFEZsiIAUv/JQFFhOe5LrKTAAr4Yhrl9RjqAq9FzveUNFH0+nGAuHUC4hVhnKK9ytpWTfqWH6R1qJ6oY2A/1eaN2rT+dxQrnMh9ASu3EZUjXqGOEOko9yd4I5if6/b/R3V2mqOnmosYKbEN6/YvKt3BG83Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065167; c=relaxed/simple;
	bh=1Z3ziHGB4aM4ABas4tIkhDD5U+ZYh/rFeu623/Z8BhI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dlM7kSK88+z5lYronzblp+Jw+l3OhFXV439HcH1+KuuhotnB1Vrsylf3UGmUIJFx4h2VN40YHkTJopSxBzMxPorM+oi2gFHYTBo8NrfT0CWZUHjI+zROy9NIliCDDlzZBYjBSHVPP8FZObxuhLeuaMOlbZUMaWfGabNXI0J1cYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcKHM2ls; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcKHM2ls"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e612d0693eso6022335a34.3
        for <git@vger.kernel.org>; Fri, 29 May 2026 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780065165; x=1780669965; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67lqt4n3+EZwn7ESQc827tPW6fWwBAA0TbdaJicPcNw=;
        b=ZcKHM2lsiVn0FnsapXV5djn9o7EgI/F9kgxE8efvuogajt+36P1/El6hVljMXkdM2U
         UsdzN8YYpB7RnipAeSWLRrAWoGAai1PWdW6Nw+BdfBzua0m3kjGeW43QluCx9v9FMdvO
         +8URObtVM/Vm+7gifQACwO4ICY3QMd+kTkVa6wnzzZWhN2hCdr4v6cOye5YQ7ZDG1tTz
         jYkiwnnxHU88YIyu51M7VGzGu04lp/QquVfeAHXsVM9NWm3QFBUOZq9pUgyHb4rMVkqs
         RC0TE81pqwjWFFbHWezHHxTwLRgbXu5MM9rVMRbydUX4Yivuawq7J/j2BzfQ8s03Ae2+
         XmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065165; x=1780669965;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67lqt4n3+EZwn7ESQc827tPW6fWwBAA0TbdaJicPcNw=;
        b=oXxaKmJIx7lfPykG6uvrfnAwVhykPVP5m5K7ztm8g0Onk1jyYOwBiTt3o1JhfyFth8
         o+8xbraYTW/sjAEomKK+9HBz2zAGBmOCp4ayVexGmXfv9VcqO8VnD5LgADfIUT1o/UDm
         2JotWx2OvKEf7wqf9puYWpTW3BYXmbZLcCwi5bRhHpvAO1lph5NgmdR8eZ0ZbrHxmwJ4
         Fxx+B6gJV3JywW/GQ86StYHtUGBEvtQ2N1sOMUu6lpYPjmcXHuQpZLTBeT6EG7oO3Dzq
         Ue7qdCbXT9IjrCUWzeeA0obQ7xP1KLC5tWzZJQfxPVrMh2cH2zxHKA6kg9JANWSJiF7H
         Jq+A==
X-Gm-Message-State: AOJu0YwVW8qaXpSF3IrcMzf31uJ+B5GgfwtC9jc8lcJ7+ULaOz8wyEqf
	BT3dA3bzgtdRqL2FcLIsBJ9xZ3DEbMwIKod1byb+58mnyD7fuXoWdn+ZFuvrMw==
X-Gm-Gg: Acq92OGTB9h12TFJSNdVgfB9Rw+0qjXKw54GfoXXxx2Z8zwAiQbHJ+dkebaDBxCoChc
	UizcLYMyztLSDRqGacnuEQajLUtZs2nlb00Wd3wED+BJHskm99hEw7kAlURyW9ekYei4yGm9c8Z
	Yrrkp7kUVsVcPSt4o5tMG6zRI1hCM5pyz4MadZWo7TGOB8GE435LYxzkimMPMloRwIwp2rhEiyo
	N25Nfi/+mo21j3AxEfZ0oWEKQUmYDil/6p3y3jIRnEaJwN2qJU660DEAVNOe6mH/Yi1LRSiPuAn
	6lb5MiniMOyF2MrOAH/wniRQT9r58wRDi5WoCAI+0W8pSnkDpZr7aZDgryx/yJMFuDk2QlB7Zo1
	VpYkjkGDCKOUUqSTiZfz6uoEcU/zLsrl+ZFV0N0NkJNb8J4/eYtTi6GIUr3bQYO5I+V5DR1OCuI
	MVx32j0cVxJZhJd/6r7V84EPa2iord36uuvFY=
X-Received: by 2002:a05:6808:2f16:b0:467:2f84:b0c6 with SMTP id 5614622812f47-485e6979194mr1711737b6e.8.1780065164959;
        Fri, 29 May 2026 07:32:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.95.55])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea1c2ca3sm16948416d6.29.2026.05.29.07.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:32:44 -0700 (PDT)
Message-Id: <pull.2313.v2.git.git.1780065163866.gitgitgadget@gmail.com>
In-Reply-To: <pull.2313.git.git.1779901919956.gitgitgadget@gmail.com>
References: <pull.2313.git.git.1779901919956.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 May 2026 14:32:43 +0000
Subject: [PATCH v2] config.mak.uname: avoid macOS linker warning on Xcode
 16.3+
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

Building on macOS with Xcode 16.3 or newer emits:

    ld: warning: reducing alignment of section __DATA,__common
    from 0x8000 to 0x4000 because it exceeds segment maximum
    alignment

Pass -fno-common when "ld -v" reports ld-1167 or newer, so tentative
definitions of large arrays go into BSS instead of __DATA,__common.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    pkt-line: initialize packet_buffer to avoid macOS linker warning
    
     * Check MacOS ld version instead
       (https://en.wikipedia.org/wiki/Xcode#Xcode_15.0_-_16.x_(since_visionOS_support)_2)
    
    Parsing output of
    
    ❯ ld -v
    @(#)PROGRAM:ld PROJECT:ld-1267
    BUILD 18:30:29 Apr 22 2026
    configured to support archs: armv6 armv7 armv7s arm64 arm64e arm64_32 i386 x86_64 x86_64h armv6m armv7k armv7m armv7em armv8m.main armv8.1m.main
    will use ld-classic for: armv6 armv7 armv7s i386 armv6m armv7k armv7m armv7em
    LTO support using: LLVM version 21.0.0 (static support for 30, runtime is 30)
    TAPI support using: Apple TAPI version 21.0.0 (tapi-2100.0.2.6)
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2313%2FHaraldNordgren%2Fpkt-line-init-buffer-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2313/HaraldNordgren/pkt-line-init-buffer-v2
Pull-Request: https://github.com/git/git/pull/2313

Range-diff vs v1:

 1:  1c1c66d85b < -:  ---------- pkt-line: initialize packet_buffer to avoid macOS linker warning
 -:  ---------- > 1:  0e660a346e config.mak.uname: avoid macOS linker warning on Xcode 16.3+


 config.mak.uname | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index ce5e7de779..d4d55cb324 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -163,6 +163,12 @@ ifeq ($(uname_S),Darwin)
 		NEEDS_GOOD_LIBICONV = UnfortunatelyYes
         endif
 
+	# Silence Xcode 16.3+ linker warning about __DATA,__common alignment.
+	LD_MAJOR_VERSION = $(shell ld -v 2>&1 | sed -n 's/.*PROJECT:ld-\([0-9]*\).*/\1/p')
+        ifeq ($(shell test "$(LD_MAJOR_VERSION)" -ge 1167 && echo 1),1)
+		BASIC_CFLAGS += -fno-common
+        endif
+
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
 	# Unix domain sockets and PThreads.
         ifndef NO_PTHREADS

base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
-- 
gitgitgadget
