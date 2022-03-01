Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D8C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiCAJqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiCAJp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:45:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1E8BE18
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:45:13 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ay10so1668596wrb.6
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 01:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6K4I9M/4+rnQtkQTt7/MJBn7hHJbiHLjqHn9VtVWeQk=;
        b=pBj57pYLaStwgv59opR0VQfmfFf1NmwCuhOKv4VxXsGS+fT9Jus20mfLeybQxKe6pE
         V3eKvAucdKZTuJc5Y+UyN458r+eOMr6bbIqzfVUyF3fij4eqoBsUDNpiGdybYJ76iq/s
         AnhRtLLWvnLCR+epJvbUGWPLA7kBhyyLIkpAsqQ25NGJCXLDjshuJP7b4Zah2vg0SVQO
         lpvf4Hnnsr52kD7veP6xqJUl9jYriFuoqlSPgBDw3bcHVWltpieYSrUHggAZA+p5A+/e
         U9beTb4ijXl8uLQ5z5938ayqH81THT6vTRIz43oc4k7OzeiK0hs6veO4pyrtAciFZJZN
         rNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6K4I9M/4+rnQtkQTt7/MJBn7hHJbiHLjqHn9VtVWeQk=;
        b=awYujYixWFdvSh5SHsslCRrz7vytNRjxm3OmR6V/tC4hIg+DBu/SbFCjkCszku+imw
         ADrYzLGwRXwPpJ2cRImGY5Dv+s0DTNcge9xwtcX0sD1zLAFHgvdCYXfLfU5rSsqJgICu
         EjaEVQ//wUVSGen19R/MLTckLeB7qKbEARDEubJgBzuEyti7hi0ZRtdMNdWj2JaoumCD
         N7a9XuHX2mHIiS4UNT3ssoBFTyPJ3cm9XxV6DFW6iF4je3sIkvaHNJUA4m+F+w2FXKcp
         dghXR1Zqfc5aAjBABDfWvzaa7YxyCQioo9xUQK1Zeg04sZSH6DMiexeLEc/TU2TPTyO2
         1E8A==
X-Gm-Message-State: AOAM533wEPmJueYEUNjfEvzLfGgFRmrWy1V7zoPn+mFSAwx45RD+pFDC
        n8w+3QJDqHAJD8d9VvN65zEAJHuZa90=
X-Google-Smtp-Source: ABdhPJwkEJBzSjuyIzz63dSEimFMCkWQAYAfCjlH1P21t6zr73pwcYdeZFGwLycyI0T8GjOi+RRUGQ==
X-Received: by 2002:adf:fb47:0:b0:1ed:9f2c:492e with SMTP id c7-20020adffb47000000b001ed9f2c492emr18842781wrs.196.1646127912197;
        Tue, 01 Mar 2022 01:45:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f21-20020a5d58f5000000b001ea99c3397dsm13645813wrd.21.2022.03.01.01.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 01:45:11 -0800 (PST)
Message-Id: <7cdef0ad5fb6fc1a16ee1cee27b9dec0300c8c1d.1646127910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
        <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 09:45:09 +0000
Subject: [PATCH v2 1/2] t/helper/test-chmtime: update mingw to support chmtime
 on directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

The mingw_utime implementation in mingw.c does not support
directories. This means that "test-tool chmtime" fails on Windows when
targeting directories. This has previously been noted and sidestepped
temporarily by Jeff Hostetler, in "t/helper/test-chmtime: skip
directories on Windows" in the "Builtin FSMonitor Part 2" work, but
not yet fixed.

It would make sense to backdate file and folder changes in untracked
cache tests, to avoid needing to insert explicit delays/pauses in the
tests.

Add support for directory date manipulation in mingw_utime by
replacing the file-oriented _wopen() call with the
directory-supporting CreateFileW() windows API explicitly.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 compat/mingw.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 03af369b2b9..11c43ad2dfb 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -961,9 +961,11 @@ static inline void time_t_to_filetime(time_t t, FILETIME *ft)
 int mingw_utime (const char *file_name, const struct utimbuf *times)
 {
 	FILETIME mft, aft;
-	int fh, rc;
+	int rc;
 	DWORD attrs;
 	wchar_t wfilename[MAX_PATH];
+	HANDLE osfilehandle;
+
 	if (xutftowcs_path(wfilename, file_name) < 0)
 		return -1;
 
@@ -975,7 +977,16 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 		SetFileAttributesW(wfilename, attrs & ~FILE_ATTRIBUTE_READONLY);
 	}
 
-	if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
+	osfilehandle = CreateFileW(wfilename,
+				   0x100 /*FILE_WRITE_ATTRIBUTES*/,
+				   0 /*FileShare.None*/,
+				   NULL,
+				   OPEN_EXISTING,
+				   attrs & FILE_ATTRIBUTE_DIRECTORY ?
+					FILE_FLAG_BACKUP_SEMANTICS : 0,
+				   NULL);
+	if (osfilehandle == INVALID_HANDLE_VALUE) {
+		errno = err_win_to_posix(GetLastError());
 		rc = -1;
 		goto revert_attrs;
 	}
@@ -987,12 +998,14 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
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
+	if (osfilehandle != INVALID_HANDLE_VALUE)
+		CloseHandle(osfilehandle);
 
 revert_attrs:
 	if (attrs != INVALID_FILE_ATTRIBUTES &&
-- 
gitgitgadget

