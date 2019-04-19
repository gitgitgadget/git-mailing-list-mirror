Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EF3020248
	for <e@80x24.org>; Fri, 19 Apr 2019 19:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfDSTxf (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 15:53:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40141 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfDSTxe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 15:53:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so3066557pgl.7
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTiWccYVFDdk+T+PcGDBXoGnjfedBeNHTv00TQCFIJU=;
        b=giNRg6xMyoY2XoUJJerSObwwSL1PKtKhiekOV0l1EURW4JbQHmesE/rYgtO1bso8m3
         H3DyAEBvCbjL0oX10PREFGujt/sR8KRY114ums1R4jyr/IgpzQzpgfTQ6INgn+tPfjrl
         kjfTXjsG1QBf4nlGrbAzx0EM/mkZjl3gtFtMVCV/Yr0KeuTGyMsuHzgjsdlpwlSJ7l/u
         HJLcpN3qFT8D3CazuiuJMiuRaRDxKyRP+soeDLg4PswSMxiVXELipb9SZ4K6YUDtnhdV
         q9GsFaEJxHsiQKhnSGGos/Z9THI5T38aSvwBpGRGDZLQTd8GN87/5aVs6/tM5rBPKrRm
         NS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTiWccYVFDdk+T+PcGDBXoGnjfedBeNHTv00TQCFIJU=;
        b=sNefAZ9nQSOySR6QsSYEqvOSDt//XYjW8ogiShLwcBRxd8H1o2dK8w9/Ccmb92Ed4s
         nJF+5BNwfKocA/znPiINotzNO2j9004aJQvkgpsI+5x+09C/nvSuuT+E8jw58CzHVCdI
         tebFu/Cn3i3CErJkuhjN2ykG3DlERjWG/XZLojnxZhXDTOP1bucG/uOHWiHpayIjVD1V
         g71nad0SozGzAJXuAyEY7KXvUWc0FYLSipYIAG/Nzwt9IGSkDCMmWSCwj9F1WjjbuCvP
         d3vvdTA+tQz1s689asLthkxAyNvY32AlQSPin1fWe2uMWwJ2TL+e7IfkqgJ83cbqtb4Z
         iD/g==
X-Gm-Message-State: APjAAAWQJQ51C4KlL4DBKVw3khdSOocSvFat9x9HeZVEXeS7rKGGFIjU
        EAN1d9VYi2/Nzhu1qh2cXafrAIsR
X-Google-Smtp-Source: APXvYqyyQ/YR2VUfSk9zQF2XKrZr5rVYAbjChqGgc6n5H9c3fDwEp8JHuCx5WopAmBZLPELMXshm7A==
X-Received: by 2002:a65:4489:: with SMTP id l9mr2790765pgq.1.1555666219049;
        Fri, 19 Apr 2019 02:30:19 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id j19sm6476704pfr.155.2019.04.19.02.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 02:30:17 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 19 Apr 2019 16:30:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] reset.txt: update the title line to cover all use cases
Date:   Fri, 19 Apr 2019 16:30:11 +0700
Message-Id: <20190419093011.5753-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-reset could be used in three different ways:

- move HEAD to somewhere, optionally (not) update worktree/index
- "move" HEAD to HEAD, mainly to update worktree/index
- just update the index from some tree-ish

The second case is frankly a (neat) corner case of the first one. But it
makes it impossible for me to summarize git-reset in one line. Without
it at least I could write "reset HEAD or the index".

And even "reset all the things" is not correct because reseting worktree
selectively is the job of git-checkout, not git-reset. Sigh.

This patch is not meant to be taken seriously. It's to raise the issue
with git-reset documentation, and maybe someone could come up with a
better summary line for git-reset. Because the current line only covers
the first (original) case.

PS. We also need to update git-reset to mentino about its ability to
clear branch state.
---
 Documentation/git-reset.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 26e746c53f..e12d8edee6 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -3,7 +3,7 @@ git-reset(1)
 
 NAME
 ----
-git-reset - Reset current HEAD to the specified state
+git-reset - Reset "something"
 
 SYNOPSIS
 --------
-- 
2.21.0.854.ge34a79f761

