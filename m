Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070641F453
	for <e@80x24.org>; Sat, 22 Sep 2018 17:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeIVXll (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 19:41:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35770 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbeIVXlk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 19:41:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so14811455ljg.2
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4apIEQrE9mlYXBVVd2qLbLIhwI8ri6Vwk39NtuId1A=;
        b=LtyarW4+wS+fQ5DPtTQsNb76BdZiU6yJudkgpmFRVDi6Uqr3HFspBUskH8CAWSXnc7
         dp4vaSLJzlC67z9e2lJEgBnv1Ndomy7ZXNw+fZ2AFes59G0+7/By0s4VdGJ15H+8Q56t
         VuHMhlNcHB8VvRKW11rO4jNDQjjPmMd0CTp58d9S28ax9polbLNPb8aMAZCuymLPyKhU
         nzxGal7jSjjNgWzg+STlSQ3bYSsVzc4vRZ8GshZHMtBXzeeP21nh9sqEnO6e3vrS6eRC
         CW5eK9Sfl135lA/1oOO+KkwXyZ26BJUW4AqxCv+VzxN8QRvaW+CdExseYZ9KJ0cbc2+m
         MXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4apIEQrE9mlYXBVVd2qLbLIhwI8ri6Vwk39NtuId1A=;
        b=CH9mzSe/qaRsPsIwTzIKNFoQ39IM3nZ2eqf9rhztX6t/Nce5PAbkfTsKI+CkBpYmai
         apXmX7+j0n4+YP9OP8aNYIQuTcYuh2mIE9v5Ycoa5vppkAvwjmhzZSAMVTefPU5Qh2mz
         ENz3N7IRdu0ElM/cQUMEPmNP9JP1+EV8ERkwXuLUfv6Ujmn/GXyd3syI2lmPoRORRd3m
         PzjPoyn3A0aJ5WJNeUHwB5DC4msLvzMf5i8YzC4U+ErEWyswnmhU7k+ObWSQiCSrNd9h
         gReHsxDFDlIGxUFCvAP/rjYST71NyZ4tvE+ZHWzy4EkaLGJlRP9Mw1H0Lk6AXQbGB+sq
         QVDA==
X-Gm-Message-State: ABuFfojNAVEEH+dhIfDcsDzYKtP4HWhU7RDTsxT7gH9VRFKjgfVb4c3n
        nh1/+n4hHfjJd1MYu4iGjcFxVMaE
X-Google-Smtp-Source: ACcGV61lYkYtmfW8JOfEQs3Dx4KQCD8dl1URXkRTs2hxwaAzjJ+jEphN5QWj3i9WHSp34lBfpLe64w==
X-Received: by 2002:a2e:259:: with SMTP id 86-v6mr6284395ljc.107.1537638437302;
        Sat, 22 Sep 2018 10:47:17 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n23-v6sm5610832ljh.77.2018.09.22.10.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 10:47:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] git help: promote 'git help -av'
Date:   Sat, 22 Sep 2018 19:47:07 +0200
Message-Id: <20180922174707.16498-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.647.gb9a6049235
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When you type "git help" (or just "git") you are greeted with a list
with commonly used commands and their short description and are
suggested to use "git help -a" or "git help -g" for more details.

"git help -av" would be more friendly and inline with what is shown
with "git help" since it shows list of commands with description as
well, and commands are properly grouped.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.c b/git.c
index a6f4b44af5..69c21f378b 100644
--- a/git.c
+++ b/git.c
@@ -31,7 +31,7 @@ const char git_usage_string[] =
 	   "           <command> [<args>]");
 
 const char git_more_info_string[] =
-	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
+	N_("'git help -av' and 'git help -g' list available subcommands and some\n"
 	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
 	   "to read about a specific subcommand or concept.");
 
-- 
2.19.0.647.gb9a6049235

