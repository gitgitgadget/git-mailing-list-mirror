Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5818C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 23:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiCKXOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 18:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCKXOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 18:14:04 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC659BBBC
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 15:12:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so6190509wmp.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 15:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FUroZ4Mya6xcccBpf61ufnBkXmscI16csl6+zPcmW84=;
        b=cBaWP515G42NBBNHHtV8rspjRsV7tk1dGhv1BIHE5hxLBWKWvoiAoSaNw+7WV+cBRC
         u0i8BhDlJ9Rc7/IP/PtYjL9j06YmFfSpyy+o3p3V2xMpLktks3I2sAv704aPo8ZEjA1p
         7RmpgXMiE4KKXS1o1CuuIS/SfgwWdrrC9iM4XLdF3vogplE1dlUOuQ+B+dbxwbJkaVkp
         cvsLENWlPV8cHoAyndDJ61otrbwyX7neagfr6EIx/v2seNBbr+ZjSV1kebqJmv0lTXGW
         Si4Ii0PQuNczAyZBPx6aTW9nD2ggOnYugjFFPgw7i2lETkUxQOvHHInbwut6eOZvMmL7
         Fg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FUroZ4Mya6xcccBpf61ufnBkXmscI16csl6+zPcmW84=;
        b=ccTenvXTmRoY0c6HqV0DXl+OBAXVlRBgmii+6eD5FI8yU38H9Xwo5NIes0yzlHHdT9
         uD1F7XrWfdhNYT0+DtL7hQ4XQobfRye8Nw3VXknHdNa548z6sLEwAjP44CIkwKp75nP8
         N/6YOOFFKwtdJPFzDrBcP++4Wlg8mpneJswijcgKdENJkT0G1w3+rJTVzFmpgNeRRtyp
         ByMhj5bvCQBwhgxT5Zp3SG8iMRiSzgqLPwc2SICWixYqjx1ErsqM3t4cXxbIZ3KtZXT1
         B6wy/ChwGDYTRxtLpgcUJJukgUUUbAfJskJ2fcwE8npLgY3SHkHbdCNDn+BurAq6K80F
         /IBA==
X-Gm-Message-State: AOAM533xc9c3ELQM+OI57M37Fys2Xky7TySw3DpNJRtcNeVNekW5xW7B
        4HJiD7jAZAKT0pANLRMMgUU3sT4llOU=
X-Google-Smtp-Source: ABdhPJw9DzdgFc60lQ/GO9LmIaqQrOc4/Yuop22Y2hrILIBbRxnxKTPa/CXBpfM2IzJpFKIG1m3baA==
X-Received: by 2002:a05:600c:507:b0:389:9f23:99e7 with SMTP id i7-20020a05600c050700b003899f2399e7mr17263082wmc.175.1647033314838;
        Fri, 11 Mar 2022 13:15:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b00389dd6566f3sm5608200wms.19.2022.03.11.13.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:14 -0800 (PST)
Message-Id: <cc7c92f7760b93d2c6a45ce87ca2c9aafc57f20f.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:15:00 +0000
Subject: [PATCH 13/16] compat/fsmonitor/fsm-listen-win32: add _() to calls to
 error()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

fixup! compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend \
on Windows

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-win32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index c2d11acbc1e..5b928ab66e5 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -82,7 +82,7 @@ static int normalize_path_in_utf8(FILE_NOTIFY_INFORMATION *info,
 		if (len > 0)
 			goto normalize;
 		if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
-			error("[GLE %ld] could not convert path to UTF-8: '%.*ls'",
+			error(_("[GLE %ld] could not convert path to UTF-8: '%.*ls'"),
 			      GetLastError(),
 			      (int)(info->FileNameLength / sizeof(WCHAR)),
 			      info->FileName);
@@ -185,7 +185,7 @@ static int start_rdcw_watch(struct fsmonitor_daemon_backend_data *data,
 	if (watch->is_active)
 		return 0;
 
-	error("ReadDirectoryChangedW failed on '%s' [GLE %ld]",
+	error(_("ReadDirectoryChangedW failed on '%s' [GLE %ld]"),
 	      watch->path.buf, GetLastError());
 	return -1;
 }
@@ -228,7 +228,7 @@ static int recv_rdcw_watch(struct one_watch *watch)
 	 * sure it is worth it.
 	 */
 
-	error("GetOverlappedResult failed on '%s' [GLE %ld]",
+	error(_("GetOverlappedResult failed on '%s' [GLE %ld]"),
 	      watch->path.buf, gle);
 	return -1;
 }
-- 
gitgitgadget

