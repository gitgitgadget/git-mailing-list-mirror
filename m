Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C68C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 00:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiEXAX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 20:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiEXAXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 20:23:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2558A314
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:23:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r23so23524059wrr.2
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aRwHZX8lhlkBqqYp0nk9o1igfA9fQ8ZPDtMgHEJ9wj8=;
        b=giZKKQAUVWt1NWFUlwjtwGU80yRGqEi1+NFzYhv9n4LJuXGq82x/+dg8svQp5pApga
         zA3cUOI31ZixA5D3sQKltmyRqz3jn0pQbAss8hddi8D4wUFzLMORm0SWahQE2RhrEz0U
         X0CAfBjwZdzNVw++IEBhbGgdyo9jlP25scIGvN1EgLqa+8h9VX1ic/7qXDSaXPlyKQma
         cFJcCpOWLSaOYSZW0fpngBMTBFusNUr/0DV4iEfe2eyty7gRBt7l5sKO1fqruCjyDTZ3
         2UncFjAa9DYNfcCPEyFlvRvYvjW1dZE7gIkEewJBnRK0p1jrdzcCrpxwj2oq+rqTiXpL
         L3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aRwHZX8lhlkBqqYp0nk9o1igfA9fQ8ZPDtMgHEJ9wj8=;
        b=o8RCRcVWTYpDx09zaRXHJ87YYaW7ad2I7WQyv7L+0fFsA79HAln1OBxylv5bQBOnaV
         TUP4k8hg1/5UKm4WV784tschVNimw89pWcJvBM8lULSiwN9ztL8ZEGHArZNd+IdFQWNs
         wEfHqHMmXUeYF6g755lasNSeqLMR3ZUaOVr933yoqmhM9B0PoBXbJmZJKk8ajRH8KFOT
         HOPUjoXbj7/sLO4Mmb5NCpwFxD9iIWzJe87pSMSP8Jb8+a6lhhz10zTTjI7iN3KGhu21
         zIr8jZ2Y4bdWhiUR9kcD3aWA5fdCCdyJ7ccIsMtyn5b0juq1PIlQHDtfK+m3l+Hw9sl/
         PrwQ==
X-Gm-Message-State: AOAM532XgwwUlOZEevuEo9qH4UQ0t5BXtVSyDUz3QLQIKTa53H3xZL+9
        XLO409nHwgXph5vZoS6Mq7bMo0IYSpY=
X-Google-Smtp-Source: ABdhPJxkuLkMcVr/bqW/fFMwkPchVrxcY76tkx7rKohD/+81CK36TpBQ8+JAC4ZUbGITXS+tzy8X4A==
X-Received: by 2002:adf:d1cf:0:b0:20f:d7f1:9b49 with SMTP id b15-20020adfd1cf000000b0020fd7f19b49mr7146451wrd.369.1653351788608;
        Mon, 23 May 2022 17:23:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b00394351e35edsm600164wms.26.2022.05.23.17.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 17:23:08 -0700 (PDT)
Message-Id: <d0ade6531bc77b654c28cf7b1bfa42523150c015.1653351786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 00:23:03 +0000
Subject: [PATCH 1/4] compat/win32/syslog: fix use-after-realloc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows' SDK recently upgraded to GCC v12.x which points out
that the `pos` variable might be used even after the corresponding
memory was `realloc()`ed and therefore potentially no longer valid.

Since a subset of this SDK is used in Git's CI/PR builds, we need to fix
this to continue to be able to benefit from the CI/PR runs.

Note: This bug has been with us since 2a6b149c64f6 (mingw: avoid using
strbuf in syslog, 2011-10-06), and while it looks tempting to replace
the hand-rolled string manipulation with a `strbuf`-based one, that
commit's message explains why we cannot do that: The `syslog()` function
is called as part of the function in `daemon.c` which is set as the
`die()` routine, and since `strbuf_grow()` can call that function if it
runs out of memory, this would cause a nasty infinite loop that we do
not want to re-introduce.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/syslog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 161978d720a..1f8d8934cc9 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -43,6 +43,7 @@ void syslog(int priority, const char *fmt, ...)
 	va_end(ap);
 
 	while ((pos = strstr(str, "%1")) != NULL) {
+		size_t offset = pos - str;
 		char *oldstr = str;
 		str = realloc(str, st_add(++str_len, 1));
 		if (!str) {
@@ -50,6 +51,7 @@ void syslog(int priority, const char *fmt, ...)
 			warning_errno("realloc failed");
 			return;
 		}
+		pos = str + offset;
 		memmove(pos + 2, pos + 1, strlen(pos));
 		pos[1] = ' ';
 	}
-- 
gitgitgadget

