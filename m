Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81DA2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbdHGVTx (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:19:53 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33594 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbdHGVTv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:19:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id c65so1468627pfl.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 14:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+vCL24wLCczY7m58QNnjr7qiyYlwKak+CydqdQz3OiY=;
        b=D9QXBo7DOJeRLcFrZwwBRcyTPvUzt807hXQwOeabU9CO0L/KAAZs3bllZKVXZxSx8h
         mQiSMAF2BTxcU/JymXCGwnw8r5r17t0aVTA8H/QFdfPKlvjk12XZIrHYkkv3SxFyDJ/N
         bOXzPnqfBjXFvIlVDLhARfhtrqU8CdwbnBr8U/2Q4gZRI8wjHaJOn0oljF/4T7gT1HvZ
         kFrS0CKz/Ku2hpbzmUwNh0XajOm6VDrVMHPLphtCqiQM8qloLRerIZM12ZwhWklqTcC4
         tMYuPqVL6bH630Zt+0JNO5RpHrw4TWFZk5Lca0nCJ/IgyHvSEsHpJTYSR+XvLt1k673k
         imPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+vCL24wLCczY7m58QNnjr7qiyYlwKak+CydqdQz3OiY=;
        b=Ih/S1uofYvzumU7jTaxdr+fjJ60CJ4VJtOdQlUK7KmjjRlrknNOKnA5oHWsMa3S/UZ
         JEgNNoAzjrEIbUWGd85IuDJVFB3TH2KnaT0VFjBimFOiIY7pAUkINHS8DJe6w6m9KgQz
         MfISUXtV+CPzBnzbqf2s6Qzzk5u5mwJiS1b/4CAkK43vaLy5goIId+LTCjAtau4V8/i5
         NnSnQYSdjgLMhbvgKlLcDv8yAcXce+1Vn/2H8MAxsWwdInHg9mkM6Ejm1TXHPbnKTldV
         fiCPI2KyDLCka5cw+SXN7SLJveNyqKAe91P6YA33o+InC74TnHKGzcuMOHFMs4zOZLvO
         634Q==
X-Gm-Message-State: AHYfb5gZOZz7BTH7vBVdN5Y3ibZ6VTz5yScGoVDdU7ISq+5ytO0pAV37
        D/ySrn6K/QSUBzmgInM=
X-Received: by 10.98.194.130 with SMTP id w2mr1968300pfk.173.1502140790686;
        Mon, 07 Aug 2017 14:19:50 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6016:3285:fd77:5453:49e2:f3b5])
        by smtp.gmail.com with ESMTPSA id z127sm15141084pfb.64.2017.08.07.14.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 14:19:50 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 11/13] submodule foreach: clarify the '$toplevel' variable documentation
Date:   Tue,  8 Aug 2017 02:48:58 +0530
Message-Id: <20170807211900.15001-12-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170807211900.15001-1-pc44800@gmail.com>
References: <20170807211900.15001-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does not contain the topmost superproject as the author assumed,
but the direct superproject, such that $toplevel/$sm_path is the
actual absolute path of the submodule.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index a23baef62..8e7930ebc 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -188,7 +188,8 @@ foreach [--recursive] <command>::
 	$name is the name of the relevant submodule section in `.gitmodules`,
 	$sm_path is the path of the submodule as recorded in the superproject,
 	$sha1 is the commit as recorded in the superproject, and
-	$toplevel is the absolute path to the top-level of the superproject.
+	$toplevel is the absolute path to its superproject, such that
+	$toplevel/$sm_path is the absolute path of the submodule.
 	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
 	variable is now a deprecated synonym of '$sm_path' variable.
 	Any submodules defined in the superproject but not checked out are
-- 
2.13.0

