Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5A71F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbeGWOyQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:54:16 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:34778 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388123AbeGWOyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:54:16 -0400
Received: by mail-pg1-f175.google.com with SMTP id y5-v6so452114pgv.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VueOAmOgRUvHgNEc4qFJVjXHocplKMGlsfnTDD0z7SY=;
        b=nupBLlX8eVQtWchehT1OKgwy2FY8oM4wSfjbTzmWzSR43oYBGWlWBt1DV317XvHRb/
         1tXq+OzX7b6Js6aw2AavRNZZGThAq/jOtBi4LHwQiURxGSdlNRIivU/o7A0PYQUqrtlB
         Wd+iydF65dVqDySBuJ1TOTgfIkAQ8OB9qHrlsTgAk95UflOXNfjzzSsIzAbpvctS1eKB
         Umb+EfQShXqDcsdQiwU6a78DrEO5MOG7Bm9cai3OXXtTCjMx7r279+je5muOM4BSi2ZP
         hYKPRmDxbYkz0wvPlT/K4Yp0rfR6fJB+yhn7YbUolz6qD2t2zFvJ+5bB9oNQUB15JxDt
         2dCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VueOAmOgRUvHgNEc4qFJVjXHocplKMGlsfnTDD0z7SY=;
        b=ei22sw17hZY2Xz4qLPSbrVj7Xcd8wu/uFGkIogN2wp+0ugpPqs9QVFPG8bi19wF62V
         8r59nx3v+68ibm0jq3f+9CjqoyC6x3DL+S2skcopyJAala8v+j9T7Y0U7RGb0j1E3gau
         XDYNABFxojJ2LeGEaxQUxypWRDPuK6HIMGGHSYPeG/NiVt/RZQvovJcp50mp9/tlk0IT
         tV+d0E9JJnEQ+dLif/sznfzhOg4LDUH0OLs2323uZnOPvmAY6zntwama3IfYSBswqD4l
         FEAqiD/WT4WnC67yWTBkugQqsif0CMIi8MseLclNX16BpfBwKlxIGbr/JGRpeAW+llrn
         xyKQ==
X-Gm-Message-State: AOUpUlEsHTuI/YJQOAjbpBbta8FrLQSIdiHljqeJRXBr0D3LMBXsBAPA
        z2lAErPFN5xuu0ql+MjEhxfRjxwD
X-Google-Smtp-Source: AAOMgpdqv6JN8xf9csb1+SpF9VNY2EimGoAptt8FNd+IxwTTTnx2bLXqXxXVdG8xQ4PrjPo4RTNpgA==
X-Received: by 2002:a62:990f:: with SMTP id d15-v6mr13332022pfe.162.1532353974132;
        Mon, 23 Jul 2018 06:52:54 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id m6-v6sm12055936pfh.153.2018.07.23.06.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:52:53 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:52:53 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jul 2018 13:52:40 GMT
Message-Id: <b3ce2ccf4ae27811953be4cb02c4530551266213.1532353966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/9] mingw: define WIN32 explicitly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This helps VS Code's intellisense to figure out that we want to include
windows.h, and that we want to define the minimum target Windows version
as Windows Vista/2008R2.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 684fc5bf0..2be2f1981 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -528,7 +528,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
-	BASIC_CFLAGS += -DPROTECT_NTFS_DEFAULT=1
+	BASIC_CFLAGS += -DWIN32 -DPROTECT_NTFS_DEFAULT=1
 	EXTLIBS += -lws2_32
 	GITLIBS += git.res
 	PTHREAD_LIBS =
-- 
gitgitgadget

