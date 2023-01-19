Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B9C38142
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 17:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjASRgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjASRgS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 12:36:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6B88F7DA
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:36:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z5so2593635wrt.6
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJr8ggKThuXAteyOT9hR7Ibd1ocKje+d448hO5ar8HE=;
        b=BfOmDu2982v1wvtGehW32AjOcw1+V1exwsRhA4lwCkeU645spV9lIVqYZn6OlvMLEg
         4l17xXengvOk2iIGIfJ8DLWfnzDEKn1jdXS6PG2vo7wGo8TGi7WtopuvGXtXkDRo71Tq
         /swbT+Ec+444UA5wmGGPBj+pnwELjwN84SGxJUOyKQDd3fQiiY5J8fKHlT/ZbodWwdU0
         v6i1+DMgej4TISFRpp2JXFNuweq8ZmgG97xf9rsxQHpKImZlcOwoVI8cWrMVBFCsECpd
         /hafqnWgWR6AfeIV1BK3EENxAJsBl6x6vuxHBfKJXRj8FJ2ycnAa5Mx1PA+XaJVtOKaX
         FJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJr8ggKThuXAteyOT9hR7Ibd1ocKje+d448hO5ar8HE=;
        b=ZCE9wqhzx3NA0S0QnVSn+Y1HZa9sezbZfdMR/7dhwLu5/68/QjlpIo/EKJ8DkQSGp/
         7dDOyAIBHTyB6ybD9+2mJny9pEB5Dmk7k4P+Sg2XLUi2z1eeN1RSAH0Ma481+C7/OOxc
         gV5cdjwyAUEKLFONSc/b8SCpJpbDcmnaACpheFw0WAp8t34r4pUsv9vdGrm7R6jEAZ2c
         0mk2FpBsLXRBbCIHCIlvq50Zy/MPE5uWdPO1C6cCbQ5ppR70ZmO2nzGX0xMxv0U/MKe6
         kWySDP+lalgsPQlkKdqKoZ1AZEXLn9bhIIZqkX1zMZ3C4YAYlEXehtTY+W7OJp4mSLOE
         qQFw==
X-Gm-Message-State: AFqh2koLmK4dF9mCbI351w0Km/29B4rDFLOWFUqIpHLMoUTvelv4RQUl
        37KJFnXBx3UohFv2xqLy2j+eYFyn/kQ=
X-Google-Smtp-Source: AMrXdXt0rot1dLuAsSKdH0u4e7npsxcNvBAL8rreMpRZGK7AbLzXaOOQLcqBuhus2tFyhSBv/MvBVA==
X-Received: by 2002:adf:ef50:0:b0:2bb:366b:d5e1 with SMTP id c16-20020adfef50000000b002bb366bd5e1mr10017742wrp.30.1674149774682;
        Thu, 19 Jan 2023 09:36:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b002bdec340a1csm14548672wrz.110.2023.01.19.09.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:36:14 -0800 (PST)
Message-Id: <pull.1438.v2.git.git.1674149773693.gitgitgadget@gmail.com>
In-Reply-To: <pull.1438.git.git.1674148045970.gitgitgadget@gmail.com>
References: <pull.1438.git.git.1674148045970.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Jan 2023 17:36:13 +0000
Subject: [PATCH v2] mingw: replace deprecated GetVersion with RtlGetVersion
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

RtlGetVersion is the correct way to get the Windows version now.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    mingw: replace deprecated GetVersion with RtlGetVersion
    
    GetVersion has its behavior changed in Windows 8 and above anyway, so
    this is the right way to do it now.
    
    The previous way returns the wrong value in Windows 8 and up, returning
    the manifest Windows data as opposed to the actual Windows data.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1438%2FAtariDreams%2Fmingw-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1438/AtariDreams/mingw-v2
Pull-Request: https://github.com/git/git/pull/1438

Range-diff vs v1:

 1:  8fe920c653e ! 1:  e5457905028 mingw: replace deprecated GetVersion with RtlGetVersion
     @@ compat/mingw.c: int wmain(int argc, const wchar_t **wargv)
       }
       
      +/*
     -+ * For RtlGetVersion in uname
     ++ * for RtlGetVersion in uname
      + */
      +
      +typedef NTSTATUS(WINAPI *RtlGetVersionPtr)(PRTL_OSVERSIONINFOW);
     @@ compat/mingw.c: int wmain(int argc, const wchar_t **wargv)
      +	RtlGetVersionInternal.procaddr =
      +		GetProcAddress(GetModuleHandleW(L"ntdll.dll"), "RtlGetVersion");
      +	if (!RtlGetVersionInternal.procaddr) {
     -+		die_message_errno(
     -+			"Could not get handle to RtlGetVersion in ntdll.dll");
     ++		/* if this is reached, something is seriously, seriously wrong
     ++		 */
     ++		perror("Could not call RtlGetVersion in ntdll.dll");
     ++		abort();
      +	}
      +
      +	version.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);


 compat/mingw.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index af397e68a1d..07d81fb8d69 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3081,15 +3081,38 @@ int wmain(int argc, const wchar_t **wargv)
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
+	OSVERSIONINFOA version;
+
+	RtlGetVersionInternal.procaddr =
+		GetProcAddress(GetModuleHandleW(L"ntdll.dll"), "RtlGetVersion");
+	if (!RtlGetVersionInternal.procaddr) {
+		/* if this is reached, something is seriously, seriously wrong
+		 */
+		perror("Could not call RtlGetVersion in ntdll.dll");
+		abort();
+	}
+
+	version.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
+	RtlGetVersionInternal.procGetVersion((PRTL_OSVERSIONINFOW)&version);
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

base-commit: a7caae2729742fc80147bca1c02ae848cb55921a
-- 
gitgitgadget
