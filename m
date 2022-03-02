Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75553C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 06:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbiCBGGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 01:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbiCBGGK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 01:06:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9471CB12DD
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 22:05:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m6so983292wrr.10
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 22:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2MJFo7fZonL9Bx7BAcWxAHXY8nDVOJffRn3+iOUcx0E=;
        b=aKGDM7oe2YRz+Q9i2UTMWFRmarPkK7g/pog7lXfISr2K1nMQzZgcK1cYNidapuGAyy
         Is1vWWbur8rJY2OZ2dnpo92xjiV84Li2qak+hs4a/n13TCuHOtiD3KagkOG6Q/sS/zXU
         uQ6qDNDV4JL8Ak6NkzAV03ufnuRQ2ZSYJQcDIyyWQqWprVsHDTIlVT+ns4hLEMYK7ItO
         +ptskV5bX5v0cJXMg64k4Hw9FzAPhEGPjzVI1ga753pdUklf6XZaSP6LrEaHGRVlfslS
         RlxadwB+8wElhOdfpPArYIgMJZGJdasDvANsLFL2GFhL9oIbJPXVSlhLu/BQwJbEjA4b
         70YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2MJFo7fZonL9Bx7BAcWxAHXY8nDVOJffRn3+iOUcx0E=;
        b=vDDZrBn7cLRD92cPk3DlFbYBGOSkLXsobli+F5s9wlgHJJfn4FwIy54KYLyhqWBnmq
         +YUGfAp74KZzU5AqTkjathk79p+IYpnb0cOKFCJKFT7+oZxZmmJ4R0OgXOGiexGfN2YY
         yVPxqix7Y+MMD2YvfynC0Af9aMycn+x7fMoY/35J06Ef531ZWxYUaCFOtq6Sntlau0ok
         BWR5eeQm3lnaDU/9yXGy85UtqFcVh4uEgdMVaHHmyTkx+82HQ6eg3UeAhrvQhJMhOTjN
         2dU0kwl0BfhBF9xYUTtLcHFuHMJermm5ker2Iihq4mflw8lskECQRzbYzokyktVuU2RC
         5+TA==
X-Gm-Message-State: AOAM531ruzgK9rM2+VW/xpkxSEHX//1/Wc5AoSkMDewEQlM7NfE+4lPM
        A8c3vexWFT348nqRSK+tB7U9Ccmy4ns=
X-Google-Smtp-Source: ABdhPJxJMcdU0e84z6s2HfY1b8IiGL7V8bEMxZeSrvyJ3IThAYeFyk1wqvU5Ra7yPWQZBvmbsRA3QQ==
X-Received: by 2002:adf:f28a:0:b0:1f0:246e:11f8 with SMTP id k10-20020adff28a000000b001f0246e11f8mr2373697wro.481.1646201126978;
        Tue, 01 Mar 2022 22:05:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az11-20020a05600c600b00b003820f5c48e9sm3564811wmb.38.2022.03.01.22.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 22:05:26 -0800 (PST)
Message-Id: <052b3dd9bba8a79890863ace0992aaee41874402.1646201124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.v3.git.1646201124.gitgitgadget@gmail.com>
References: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
        <pull.1166.v3.git.1646201124.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Mar 2022 06:05:23 +0000
Subject: [PATCH v3 1/2] t/helper/test-chmtime: update mingw to support chmtime
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
 compat/mingw.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 03af369b2b9..58f347d6ae5 100644
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
 
@@ -975,7 +977,17 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 		SetFileAttributesW(wfilename, attrs & ~FILE_ATTRIBUTE_READONLY);
 	}
 
-	if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
+	osfilehandle = CreateFileW(wfilename,
+				   FILE_WRITE_ATTRIBUTES,
+				   0 /*FileShare.None*/,
+				   NULL,
+				   OPEN_EXISTING,
+				   (attrs != INVALID_FILE_ATTRIBUTES &&
+					(attrs & FILE_ATTRIBUTE_DIRECTORY)) ?
+					FILE_FLAG_BACKUP_SEMANTICS : 0,
+				   NULL);
+	if (osfilehandle == INVALID_HANDLE_VALUE) {
+		errno = err_win_to_posix(GetLastError());
 		rc = -1;
 		goto revert_attrs;
 	}
@@ -987,12 +999,15 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 		GetSystemTimeAsFileTime(&mft);
 		aft = mft;
 	}
-	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
+
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

