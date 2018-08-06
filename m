Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43516208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 16:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbeHFSoT (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 14:44:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39032 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731469AbeHFSoS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 14:44:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id a134-v6so9539725lfe.6
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbjY/kaSf5GG1GaGCfg5DRxiZP0zfLcEigIO84HkOZQ=;
        b=hzk8PM6F7KNtYx8yt1PSvZvP6of0oj+VJaTxXJGpkX8XbfVUBXGte5+Wvm/FkgI1gO
         FuRHWp4maCv/FrPXchchJvSRscNvPTaaa6s9d7/Cwt4WyRmx1L+QhvXS3xoyhumlC8l8
         Or45axT/9kU/xUzXrjy34ajcnPRydL+s9jjpm9zYNL0zWlJbXRnVqBe5YEEdJIUA2jie
         cY3/kcb4dka9k6HGg9CBIyWJ4bJPBsU/9hSemm4HK5w/kW+JqkdkUE1op/mdEoVOMREV
         /y86pxKa0foZe1m5edj2NiYtfpty0ygx43gwiFw0MD1gzHECj9JuLOfAEMBQ2qt51ifL
         jQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbjY/kaSf5GG1GaGCfg5DRxiZP0zfLcEigIO84HkOZQ=;
        b=sp5gjQMk+Oa+/MvstrnSFpTa3eAMIoaqIl/zk0Q0syDj6XXeoutyaxJ1CSbcpXv00n
         Hbvnm1CY1bvrRSn6/Pw7jZIs6fuD8dyiPp0Qoec+84iXFED3zM3Qmyq8uOtT+g7ZKdkI
         C0+AFIIU8h8QK6TBmSe/3BdcuPtMGeoKaudSHaP3J6a9jQU33jpjVfeTRKmKx+OGttO0
         AFXHa5RVD4OlSV8Wn0SDdY8CfHMKrn5ugvXyHKq4YMTAY3Oa+4m1RvngOHFHFLHf031W
         sK8F4IJUwF0tuH1G5aDxLuimq+9v2WQRHg0SvcB2yu4y9+u1AhIh6L9Q6eNHpH7vORxf
         QCSQ==
X-Gm-Message-State: AOUpUlEoJEOKNkQPeUWQRzFbOQmBy2qV0U67+1aD159VwAd5oxsUbnGP
        Bq0S2IeAmiwISW/uUs3JVtkitYz6
X-Google-Smtp-Source: AAOMgpfVkSk1WOdWEczYpAJuy4G9YNfvbD8EKPNPu8pefI2P3dyzEuY9HmqGaPeWehuPysUIciCB2Q==
X-Received: by 2002:a19:3b11:: with SMTP id i17-v6mr11528769lfa.146.1533573264799;
        Mon, 06 Aug 2018 09:34:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n23-v6sm2348755ljh.77.2018.08.06.09.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 09:34:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] Makefile: add missing dependency for command-list.h
Date:   Mon,  6 Aug 2018 18:34:21 +0200
Message-Id: <20180806163421.30636-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.901.gd528ad0b1c.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 3ac68a93fd (help: add --config to list all available config -
2018-05-26) makes generate-cmdlist.sh adds a new input source
config.txt but it's not a Makefile dependency. Any changes in
config.txt will not trigger command-list.h regeneration and the config
list in this file becomes outdated. Correct the dependency.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index bc4fc8eeab..47ca56d0e2 100644
--- a/Makefile
+++ b/Makefile
@@ -2037,7 +2037,7 @@ $(BUILT_INS): git$X
 
 command-list.h: generate-cmdlist.sh command-list.txt
 
-command-list.h: $(wildcard Documentation/git*.txt)
+command-list.h: $(wildcard Documentation/git*.txt) Documentation/config.txt
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
-- 
2.18.0.901.gd528ad0b1c.dirty

