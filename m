Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0341F404
	for <e@80x24.org>; Thu, 18 Jan 2018 09:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755388AbeARJp5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 04:45:57 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33360 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755002AbeARJpz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 04:45:55 -0500
Received: by mail-pf0-f195.google.com with SMTP id t5so7904898pfi.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 01:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYu2VP9H7+0sVRkjip58TROqfj+Qvq0Qnecl85fDPbo=;
        b=lzJlJjgX63ei78QZH0CrYVLEfGKj1B/Y4sRWTM/xcMoCkQcn3zBfpN9lOatbcWIIV+
         IGhlpgMuYIbSWw89ye69rKcRvKntOv2s5yquRJsKsO9RBNbtymYPLgYxZfWHEze7Q2Bz
         5eowdyUijPitdVF2/N7fAvgXGj1lCGKbgL1AXB1pW+qujI91AsC9K90X6qVU5bD+a1te
         hRhahTrfvo5Qz5Hi7qUi6YkBtHM4tijq0kiS/wQQ9RjeTsb7ALMtSKeL/x9MxCeWWLlI
         3uJTHt3VsNpcbTWXmP+dHjzRb65bRjuIDnfoH9TD/0kr698Vs6qHlZL8VX5f8JUUIhj1
         EhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYu2VP9H7+0sVRkjip58TROqfj+Qvq0Qnecl85fDPbo=;
        b=DBZv98UZwg+LgiK70aJaLJTXrlzmxVCfTcnfaalYVf6N9pIzadn9rKJL6f3MaDdCVp
         QQ9AXK23WIqdE9JDY81m8c1//ay1Cmr/hAtt3s7BXZ9SlrwgQ99evp+qG5u0R7nwvfco
         kEjWhalknYZYG4Sof0rt9K9oCsgHPi3lQBLxAym3fpTPZAwEViR8rvDjjBelWPvfkY0C
         3CYT2hDwi8PCkWe84907gv68jI0DW2CbcZDg5ake1zRzcwtDzeT1ssoaMg5dPejt4oEq
         CVNRoSSJ0lwVoTuy9Sygm8z2L/QuGOhzpJ+rufN0QOLvndohn/8C1ntrsESQCiePii7c
         Kgow==
X-Gm-Message-State: AKwxytcDSIujXrF4CrTxsQszGPzklY5wCZdCEixA2tdGOe4aTBH7dHlV
        uZWJ1FFJ3zzNfI3hWPZ5FGdpAg==
X-Google-Smtp-Source: ACJfBouJhfjT4TylxJg0oVTKp1UK80WXyREYe4XwoB2OtS12j9dS56Q6oPXO1eEJvw5IgLE+xvxkcg==
X-Received: by 10.99.47.71 with SMTP id v68mr5535812pgv.176.1516268754634;
        Thu, 18 Jan 2018 01:45:54 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id u63sm3621167pfi.63.2018.01.18.01.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 01:45:54 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 18 Jan 2018 16:45:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 5/7] run-command.c: print program 'git' when tracing git_cmd mode
Date:   Thu, 18 Jan 2018 16:45:10 +0700
Message-Id: <20180118094512.27849-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180118094512.27849-1-pclouds@gmail.com>
References: <20180115105949.18328-1-pclouds@gmail.com>
 <20180118094512.27849-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We normally print full command line, including the program and its
argument. When git_cmd is set, we have a special code path to run the
right "git" program and child_process.argv[0] will not contain the
program name anymore. As a result, we print just the command
arguments.

I thought it was a regression when the code was refactored and git_cmd
added, but apparently it's not. git_cmd mode was introduced before
tracing was added in 8852f5d704 (run_command(): respect GIT_TRACE -
2008-07-07) so it's more like an oversight in 8852f5d704.

Fix it, print the program name "git" in git_cmd mode. It's nice to have
now. But it will be more important later when we start to print env
variables too, in shell syntax. The lack of a program name would look
confusing then.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 run-command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/run-command.c b/run-command.c
index eadba8cb0d..326c33e3cd 100644
--- a/run-command.c
+++ b/run-command.c
@@ -565,6 +565,8 @@ static void trace_run_command(const struct child_process *cp)
 		return;
 
 	strbuf_addf(&buf, "trace: run_command:");
+	if (cp->git_cmd)
+		strbuf_addstr(&buf, " git");
 	sq_quote_argv_pretty(&buf, cp->argv);
 
 	trace_printf("%s", buf.buf);
-- 
2.15.1.600.g899a5f85c6

