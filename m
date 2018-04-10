Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D88651F404
	for <e@80x24.org>; Tue, 10 Apr 2018 18:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeDJSeH (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 14:34:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46881 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeDJSdF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 14:33:05 -0400
Received: by mail-wr0-f194.google.com with SMTP id d1so13748985wrj.13
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B4hXo5YaDn5U1Ksa0qpcR1iow8jFE++N91lY8/P4xFo=;
        b=VuPM56W6q63WSBd9AxWJYfBrjSt5hC515K9Fs8DFdsWWU24ApN6V0j89Kqj5i3HSCj
         oWe0rkjBhu42Vqm9CgllKOYm6mIj3ApJzT6+WoXEHI0R/qgHpLVCzGvnKvQ1A8eoqnnO
         2ZF4ElqhhWar62URy0sgYQp7D6j5H4Oy5zIVoNV57ugh6d39MRFIiET+dShnQya/fyH8
         SR/0iLplWFLtpb+arWkETvPLUgz2dU8YPDhxxda6loNuZwGhSbVVN0RS7n3919vab9Bs
         dpr4VmOy1P0Q4FMoJLEWu78xpzJYNZKcf/hphD7IfdloT/6P9nxTLHfaul8TrcC4pAcQ
         mSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B4hXo5YaDn5U1Ksa0qpcR1iow8jFE++N91lY8/P4xFo=;
        b=VWciJYd56wVMiRQsBj2u/2jPAoDtTlOrQVHGXLkkhVp5NRpRTBChfZklNXgh551JlH
         7sVNyqgCczvfJCLtoW8yPiDopNtQTqi0ljXMlvFl53s9CV2dBFMRVSpjJLIkalmFtzpq
         0RnD7IBkylQIuuGBGSiY7Vd8H2CFXs10YSBIaLBD30X+oamWccnzlLzp/jaO9ZG53Wo0
         LHQMUg2L0u3EdUDP93OoBn6lWh+mT1yM0iVIJ7jrFRpVuVZQZ3cXBz9LQez9kh2vR3oM
         /buVBbIWzfL3OZZ9Jrh9P/Ytl8uENYLUbhI6xOEPhao5iw3PTXk/8NQw9ytY9RZwrzg+
         Mp1g==
X-Gm-Message-State: ALQs6tDIwR2omPV0OUh23Rd71zM5mspO3zw0OOHi01T62gaDjouWRs90
        QxLQa4+/l2FN/ugNHKRliDH0HA==
X-Google-Smtp-Source: AIpwx49UTYtnfAyJP8d46fIpOgJBPZrMms4fzJipA3a1+ozhI/dsUk3MJMFBkE4X+zlWuepXiNHU/g==
X-Received: by 10.223.184.234 with SMTP id c39mr1120523wrg.67.1523385184362;
        Tue, 10 Apr 2018 11:33:04 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:91e0:5390:d305:a939])
        by smtp.gmail.com with ESMTPSA id j21sm4426354wrb.49.2018.04.10.11.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Apr 2018 11:33:03 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 3/6] doc: clarify ignore rules for git ls-files
Date:   Tue, 10 Apr 2018 20:32:21 +0200
Message-Id: <20180410183224.10780-4-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explain that `git ls-files --ignored` requires at least one
of the `--exclude*` options to do its job.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-ls-files.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3ac3e3a77d..f3474b2ede 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -53,7 +53,8 @@ OPTIONS
 	Show only ignored files in the output. When showing files in the
 	index, print only those matched by an exclude pattern. When
 	showing "other" files, show only those matched by an exclude
-	pattern.
+	pattern. Standard ignore rules are not automatically activated,
+	therefore at least one of the `--exclude*` options is required.
 
 -s::
 --stage::
-- 
2.16.2

