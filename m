Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03330C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 09:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiB1JlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiB1JlS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 04:41:18 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0695E657B8
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:40:40 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so5368709wmb.1
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UvhmsGw3xX3OGt0yRDL6NxPbHv6qGeySg4bsKg7MscU=;
        b=CQzDQax5i12c+Bj0bkeZpldVZGqUKGs1yWI1hqiV4CjHpta9ylOLO7Qzj+DJu5c2pB
         l4/pt0h36ROH7Q6iMc2/FgZGb/vHGLk/fqtU+lyQ/1nIbKUFQJIS0ppwqVItdGLZbw+Z
         77T8N2sMEKiJgAgLzmMsF5lG72M0vlWZEEkkeatEG3jqYfwM49L1gpuUuQjn33PbicbW
         MsPb6KHA+UA2X1poASLaM/gH4arPCHKgnY2pFmJtMedYCitCYKNzQ0Jfaj/8b1LFLFao
         o81+u/asJWHKITkfGvaFv1SGBawts+XvebMa8nBwro5zDjfmez0ZgkLvM65OsHKK44Xw
         r5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UvhmsGw3xX3OGt0yRDL6NxPbHv6qGeySg4bsKg7MscU=;
        b=DfHEf8KyB5swnBbQYqqBJP7qESu108LMdSaQEIpQTAEWAL7RuC2LGWcea7rzwpxZOF
         bzhqKRopFQJLAxmsYIZgkO8zdI0R9pJCGGcoBmimFNZwiAvihRrHLk1bUVMM2pIpDEdw
         CxtDEYEkb5o7f2V/NLYAUz24s08pPtAPzNo+Z1uLwpFdQ7UtfQFq+d3qVjXNwPBJUvVl
         JHsXgT0BjPiC2xopHcG7m/gLWg01zThHcGFw31u8AKwi3xMVjI2SEPpnFFuTEINgLXdE
         qDh0169sDWVZCo02oCHOIaywnbBLLcOCeW92xANpKFymtPYOW1zfaRRRhyqht1NA47Kb
         uwdA==
X-Gm-Message-State: AOAM53126mzqP7bO7vtZtQHkjLCqc8k6Z6YI1Z9iUY/SO0od6zPFkQou
        8ARNnL6l2XUQ+Q5xLXs78fV+qEPGuZI=
X-Google-Smtp-Source: ABdhPJwI/pnt+BSEJDbD2nS6N5zGGmT7meIzuPEBm8U5mJzTif1quU4JmeQDdGA+n3OgOQSHb/Q3Pw==
X-Received: by 2002:a05:600c:4ed0:b0:37b:e983:287b with SMTP id g16-20020a05600c4ed000b0037be983287bmr12391801wmq.156.1646041238505;
        Mon, 28 Feb 2022 01:40:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm10455084wmb.22.2022.02.28.01.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:40:38 -0800 (PST)
Message-Id: <76b6216281e3463821e650495f3090c677905f73.1646041236.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 09:40:35 +0000
Subject: [PATCH 1/2] t/helper/test-chmtime: update mingw to support chmtime on
 directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

The mingw_utime implementation in mingw.c does not support
directories. This means that "test-tool chmtime" fails on Windows when
targeting directories. This has previously been noted and sidestepped
by Jeff Hostetler, in "t/helper/test-chmtime: skip directories
on Windows" in the "Builtin FSMonitor Part 2" work.

It would make sense to backdate file and folder changes in untracked
cache tests, to avoid needing to insert explicit delays/pauses in the
tests.

Add support for directory date manipulation in mingw_utime by calling
CreateFileW() explicitly to create the directory handle, and
CloseHandle() to close it.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 compat/mingw.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 03af369b2b9..2284ea90511 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -964,6 +964,8 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 	int fh, rc;
 	DWORD attrs;
 	wchar_t wfilename[MAX_PATH];
+	HANDLE osfilehandle;
+
 	if (xutftowcs_path(wfilename, file_name) < 0)
 		return -1;
 
@@ -975,9 +977,26 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 		SetFileAttributesW(wfilename, attrs & ~FILE_ATTRIBUTE_READONLY);
 	}
 
-	if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
-		rc = -1;
-		goto revert_attrs;
+	if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
+		fh = 0;
+		osfilehandle = CreateFileW(wfilename,
+					   0x100 /*FILE_WRITE_ATTRIBUTES*/,
+					   0 /*FileShare.None*/,
+					   NULL,
+					   OPEN_EXISTING,
+					   FILE_FLAG_BACKUP_SEMANTICS,
+					   NULL);
+		if (osfilehandle == INVALID_HANDLE_VALUE) {
+			errno = err_win_to_posix(GetLastError());
+			rc = -1;
+			goto revert_attrs;
+		}
+	} else {
+		if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
+			rc = -1;
+			goto revert_attrs;
+		}
+		osfilehandle = (HANDLE)_get_osfhandle(fh);
 	}
 
 	if (times) {
@@ -987,12 +1006,16 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 		GetSystemTimeAsFileTime(&mft);
 		aft = mft;
 	}
-	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
+	if (!SetFileTime(osfilehandle, NULL, &aft, &mft)) {
 		errno = EINVAL;
 		rc = -1;
 	} else
 		rc = 0;
-	close(fh);
+
+	if (fh)
+		close(fh);
+	else if (osfilehandle)
+		CloseHandle(osfilehandle);
 
 revert_attrs:
 	if (attrs != INVALID_FILE_ATTRIBUTES &&
-- 
gitgitgadget

