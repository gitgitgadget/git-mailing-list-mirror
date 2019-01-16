Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35EB91F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404127AbfAPKcg (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:32:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46405 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbfAPKcg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:32:36 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so2815886ply.13
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LUFeZLILBeS+Ryj4f65cmbP2ZeOc4mcMnECFLM+nhUc=;
        b=BwgCR0sSblyvLToYpxDP+1hrD0T9dep1f0+AsGLcl51NRtDJi5r4Xwc1+rFkxiCHIv
         Pwb53BWYF6A1ECNvgQV2hscT+Om2nv87GsG/58Mdh/0GWbbqHJWrq+RD5jMqYyQDjjxd
         qbvW7ukwuaVv5jRuRsSobwMzA5DKMQd6y6MmJiisbGF0YFBh4XxaQWSCbuE9lRPCfyBl
         Tee1jkaaSkHwvyNGZIfFOTJyn0ANR732SJv+6MLqSGY8FF7j39j9Q56aTEGdb9lK+Qhn
         9Ky+X8oAvxPSXo8IzQSIbl0ECNSjXBYrevilSP6e5ZdMk9acErI2I+3gghR/Wf7c5HvA
         XJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUFeZLILBeS+Ryj4f65cmbP2ZeOc4mcMnECFLM+nhUc=;
        b=axOExP+6K6j3UwjVcIoht7iCZSwl8kuVns7ylkzEY/iAgDu+kOsjaKFcViasrssW1H
         z4p+WiEKnG8Ad1/dNtPQ8Cuf0WeMi4tdmt/a1qacCX74Tjm8DrD5Hy92nMN2nGLXaHqL
         SdTBCHdFUAKMesPkyciSLZRxLa5lDEbr6qhe7ptEBcGVYYOhuKv7wBUK2fL5SPa4houU
         z5shrhgJfzBQSJ7XoasfMcduoCxla484knifMASm3gz6RqVvBu/4jn9lfxU1VLzNfZ4+
         8XufFrG4RuIsU97zOM52uWs4Ox802wjo/8igjQSv1vlghTzJlKMSwlfO5VH9GO35uYeh
         etSg==
X-Gm-Message-State: AJcUukcEQmESP/rdd1beitwnDd2xtN0lGgaXN6OOa2ndP1gnUZO9/Q27
        Yn4cCDDAHKUh1ObVBiPG2R6m8VYM
X-Google-Smtp-Source: ALg8bN5wtJQ+nJLVQLlnauV0oOxrehKlG1jZp8FA02POhCSSlOufxL5hE/a6u7o4K5KA3brngnQw5w==
X-Received: by 2002:a17:902:43e4:: with SMTP id j91mr8963660pld.147.1547634755299;
        Wed, 16 Jan 2019 02:32:35 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id y12sm9314595pfk.70.2019.01.16.02.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:32:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 16 Jan 2019 17:32:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, tsniatowski@vewd.com,
        Jonathan Nieder <jrnieder@gmail.com>, marcnarc@xiplink.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/10] submodule update: add tests for multiple worktrees
Date:   Wed, 16 Jan 2019 17:31:54 +0700
Message-Id: <20190116103159.9305-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190116103159.9305-1-pclouds@gmail.com>
References: <20190116103159.9305-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no changes needed for 'submodule update'. The clones will be
per-worktree and all the support is already in place. Add a test to
make sure it actually works.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2405-worktree-submodules.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t2405-worktree-submodules.sh b/t/t2405-worktree-submodules.sh
index 2ee3e2d039..c1b19ad613 100755
--- a/t/t2405-worktree-submodules.sh
+++ b/t/t2405-worktree-submodules.sh
@@ -67,4 +67,15 @@ test_expect_success 'init submodules' '
 	! test -d cloned/.git/worktrees/secondary/modules/sub2
 '
 
+test_expect_success 'update submodules' '
+	(
+		cd cloned &&
+		git submodule update sub1 &&
+		cd secondary &&
+		git submodule update sub2
+	) &&
+	test -d cloned/.git/modules/sub1 &&
+	test -d cloned/.git/worktrees/secondary/modules/sub2
+'
+
 test_done
-- 
2.20.0.482.g66447595a7

