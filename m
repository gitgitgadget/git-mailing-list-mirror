Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA75CC004D4
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 19:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjAUTua (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 14:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjAUTu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 14:50:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BCF1E1EB
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 11:50:28 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q5so2896378wrv.0
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 11:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ardzAs4S3H+8810dLsUo7YJ5Co5n6t8jnnaFIMjfFA=;
        b=UjvPe1wtq5tNVchQwMueepjeiMIvtLpcORubzK3PenKzreTwotpR0AF2NkKzFHpkLx
         Ani3vDSw+4DuOOhGcSjMdXgSKkVSAF0BtusLJysvjtQTtj4gRNmcCQjIdZx7Egr0aJxL
         is7f6WFxD3JfsPoswRb9eI8oAD6l4Lt9N3Jlv7CrpPcgkPu+ZJsu3LV8vijFPTYU4u4F
         F5XKNwvCSg/YXIOSA3+FptPeDYUHw9G/l6O9n5t3d/xTmS1AoZM03azibsNOadDsw13G
         IejS/cdxI3XkkLvDZ7lW2r0PyiObDLd3qzWmndsotZMFyBLiUqgMED8l0UtniwmYMZ3o
         0roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ardzAs4S3H+8810dLsUo7YJ5Co5n6t8jnnaFIMjfFA=;
        b=S+9oCpmC+FwWEfrkjGx4WY9/rZaujihyNBSjVcHrVvdVgeyB6OL/ZYYT/Mgn3gAvdk
         FD0ezmUZP2ycJ/EQk2gpBPknd0UL+/Tr+vu0MFWVw4ELtNjMpsKOAzchrhweovX09QVR
         oZ8v5W2Ixlqajr0UrwnCdUsEC+gMgP0AbiCiLloE75zA+K/3CqFVE63UH8bXhjTPZku3
         fYO0Cm038Ngr5JLoQKGDnMysUGSR8EXTSQSNKa22SkHsJX0hmo/ATZjfYZTTwGFf2k2E
         LM2kT7LkgVRS6ZljjLwx2+vd+WDrgnMi/dEmcMDXA5hdtVlch+SQ4M2Ywa4B7MiRuwLE
         DD7g==
X-Gm-Message-State: AFqh2kqOY9BoEadTvThY13WR+rk8vZYwbXFB+bCkQ3V+N0osx8ojCexQ
        XCVY5/WYpQm3uN8spivSoHO+/mUSRIY=
X-Google-Smtp-Source: AMrXdXtJzK2qbH7SXcdexjYlxLr7+t843YGDGPVBl7WJrOR20tvrttrK4F8YrxD/virlySQF/6RFAQ==
X-Received: by 2002:a5d:464f:0:b0:2be:4fbe:42d2 with SMTP id j15-20020a5d464f000000b002be4fbe42d2mr6845284wrs.15.1674330626319;
        Sat, 21 Jan 2023 11:50:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17-20020a056000025100b002b8fe58d6desm1156284wrz.62.2023.01.21.11.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 11:50:25 -0800 (PST)
Message-Id: <pull.1438.v3.git.git.1674330625069.gitgitgadget@gmail.com>
In-Reply-To: <pull.1438.v2.git.git.1674149773693.gitgitgadget@gmail.com>
References: <pull.1438.v2.git.git.1674149773693.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Jan 2023 19:50:24 +0000
Subject: [PATCH v3] mingw: replace deprecated GetVersion with RtlGetVersion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

The previous way is deprecated and returns
the wrong value in Windows 8 and up,
returning the manifest Windows data
as opposed to the actual Windows data.

RtlGetVersion is the correct way
to get the Windows version now.

Note: ntdll does not need to be
manually loaded into the runtime,
as this is the one special library
that is automatically loaded upon launch.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    mingw: replace deprecated GetVersion with RtlGetVersion
    
    GetVersion has its behavior changed in Windows 8 and above anyway, so
    this is the right way to do it now.
    
    The previous way returns the wrong value in Windows 8 and up, returning
    the manifest Windows data as opposed to the actual Windows data.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1438%2FAtariDreams%2Fmingw-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1438/AtariDreams/mingw-v3
Pull-Request: https://github.com/git/git/pull/1438

Range-diff vs v2:

 1:  e5457905028 ! 1:  31f778a6b34 mingw: replace deprecated GetVersion with RtlGetVersion
     @@ Commit message
          returning the manifest Windows data
          as opposed to the actual Windows data.
      
     -    RtlGetVersion is the correct way to get the Windows version now.
     +    RtlGetVersion is the correct way
     +    to get the Windows version now.
     +
     +    Note: ntdll does not need to be
     +    manually loaded into the runtime,
     +    as this is the one special library
     +    that is automatically loaded upon launch.
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
     @@ compat/mingw.c: int wmain(int argc, const wchar_t **wargv)
       {
      -	unsigned v = (unsigned)GetVersion();
      +	union winprocaddr RtlGetVersionInternal;
     -+	OSVERSIONINFOA version;
     ++	OSVERSIONINFOW version;
     ++
     ++	memset(&version, 0, sizeof(version));
     ++	version.dwOSVersionInfoSize = sizeof(version);
      +
     ++	/* RtlGetVersion always gets the true Windows version, even when running
     ++	 * under Windows's compatibility mode*/
      +	RtlGetVersionInternal.procaddr =
      +		GetProcAddress(GetModuleHandleW(L"ntdll.dll"), "RtlGetVersion");
     -+	if (!RtlGetVersionInternal.procaddr) {
     -+		/* if this is reached, something is seriously, seriously wrong
     -+		 */
     -+		perror("Could not call RtlGetVersion in ntdll.dll");
     -+		abort();
     -+	}
      +
     -+	version.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
     -+	RtlGetVersionInternal.procGetVersion((PRTL_OSVERSIONINFOW)&version);
     ++	if (RtlGetVersionInternal.procaddr) {
     ++		RtlGetVersionInternal.procGetVersion((PRTL_OSVERSIONINFOW)&version);
     ++	} else {
     ++		/* Should not happen, but just in case, fallback to deprecated
     ++		 * GetVersionExW */
     ++		GetVersionExW(&version);
     ++	}
      +
       	memset(buf, 0, sizeof(*buf));
       	xsnprintf(buf->sysname, sizeof(buf->sysname), "Windows");


 compat/mingw.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index af397e68a1d..b1d75c93cfe 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3081,15 +3081,42 @@ int wmain(int argc, const wchar_t **wargv)
 	return exit_status;
 }
 
+/*
+ * for RtlGetVersion in uname
+ */
+
+typedef NTSTATUS(WINAPI *RtlGetVersionPtr)(PRTL_OSVERSIONINFOW);
+union winprocaddr {
+	FARPROC procaddr;
+	RtlGetVersionPtr procGetVersion;
+};
+
 int uname(struct utsname *buf)
 {
-	unsigned v = (unsigned)GetVersion();
+	union winprocaddr RtlGetVersionInternal;
+	OSVERSIONINFOW version;
+
+	memset(&version, 0, sizeof(version));
+	version.dwOSVersionInfoSize = sizeof(version);
+
+	/* RtlGetVersion always gets the true Windows version, even when running
+	 * under Windows's compatibility mode*/
+	RtlGetVersionInternal.procaddr =
+		GetProcAddress(GetModuleHandleW(L"ntdll.dll"), "RtlGetVersion");
+
+	if (RtlGetVersionInternal.procaddr) {
+		RtlGetVersionInternal.procGetVersion((PRTL_OSVERSIONINFOW)&version);
+	} else {
+		/* Should not happen, but just in case, fallback to deprecated
+		 * GetVersionExW */
+		GetVersionExW(&version);
+	}
+
 	memset(buf, 0, sizeof(*buf));
 	xsnprintf(buf->sysname, sizeof(buf->sysname), "Windows");
-	xsnprintf(buf->release, sizeof(buf->release),
-		 "%u.%u", v & 0xff, (v >> 8) & 0xff);
-	/* assuming NT variants only.. */
-	xsnprintf(buf->version, sizeof(buf->version),
-		  "%u", (v >> 16) & 0x7fff);
+	xsnprintf(buf->release, sizeof(buf->release), "%lu.%lu",
+		  version.dwMajorVersion, version.dwMinorVersion);
+	xsnprintf(buf->version, sizeof(buf->version), "%lu",
+		  version.dwBuildNumber);
 	return 0;
 }

base-commit: 904d404274fef6695c78a6b055edd184b72e2f9b
-- 
gitgitgadget
