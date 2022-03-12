Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2D7C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 11:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiCLLdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 06:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiCLLdH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 06:33:07 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1AEDFD5
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 03:32:02 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id m2so9828667pll.0
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 03:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j7Gqhu+j0FYMg3m358ubDJ6GWqA5pKz5mZc0rxn6DvI=;
        b=ecWA9i4NU+5GG9aFPHZdfyKEGSrYYRUNjA9Ql7n5RELl0iMMvxLPCbHSJA3lpGURRb
         i1k484ZIJK7CRPKLeoZ3HFB9F8UX9G1B5JNBdJsWCeaXf0kSnul0Co4CYgSxq4GWMhw2
         SBuher2HkDluAEvQ9fPqyzK02Fag27tf3grXK/xPxDWPVozatH6rcdoQYHAGuL6gvQLG
         NDOZ4osDAL3M6gDSECh1ZPnkNXOL2BsCP0tsOWpnVSBuMRTrMouCdV+HYpSeGINME1ha
         nsOYc7sHX3MGxvRtLA97/PR2SYgUgf0ULGCSG7iLidYnNGMBbUxIwIFHntNIaFVOshVs
         WQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j7Gqhu+j0FYMg3m358ubDJ6GWqA5pKz5mZc0rxn6DvI=;
        b=BJxoXgoC//qEVwKmf1opgO/huB/X2Uh+hooDIXDc3x1Md5mp5nKLqDgo4KDRi7FIFK
         cweOu9A/ott6OnOQUhvgNqzpveBz3wVLbYK2UzmX1jOfB0qjRI9tG4ZUUFY69MNu1xeP
         yOMp/tDJSI6tWNQx0LIwsYP6WRlUPruj6Me12gnCPFTR6T9j8CFrej0twZ70D89InVvC
         0LyjhxmPdRtvc1WY7vYzZ5TgGun4Z4D39/EOaovFPrWc3kfVuznvP1DHpt7bb/5FlTC4
         qfr4vOStTMAzaoqHTPHvbV/4FtXXaqJ3zaENxkHmPOLEYNdfYhkv30mc49HPl6agd8mt
         qcMA==
X-Gm-Message-State: AOAM531NUAJh8xu3q/9t7xZZMaOVe85fqjxiaNiOkH6h06nN36oVudqR
        t5kggORw7gv8yBP42Dx9Dj2MQbefvBtuqw==
X-Google-Smtp-Source: ABdhPJzDV2d7ZrTEPB4aZmCyOe9r+hyNTmZtFgnA0fEFfKcRuN9dX0sA8N6wbpHjS4AB0U+Nb1B4og==
X-Received: by 2002:a17:90a:4f0b:b0:1be:e31f:bd38 with SMTP id p11-20020a17090a4f0b00b001bee31fbd38mr26711157pjh.76.1647084721647;
        Sat, 12 Mar 2022 03:32:01 -0800 (PST)
Received: from ubuntu.mate (subs02-180-214-232-69.three.co.id. [180.214.232.69])
        by smtp.gmail.com with ESMTPSA id w27-20020a637b1b000000b00380437ab89asm11246052pgc.50.2022.03.12.03.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 03:32:01 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: simplify synopsis of git-repack(1)
Date:   Sat, 12 Mar 2022 18:31:37 +0700
Message-Id: <20220312113136.26716-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify SYNOPSIS section to only mention [<options>...] placeholder.
Redundant options list can now be avoided for aesthetic and clarity.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 Shaoxuan Yuan suggested me to do the simplication, as in [1].

 [1]:
https://lore.kernel.org/git/CAJyCBORGGbn6d5UYMdRnfrbn9OONcgMMxaCyJ4qUoQY3+s8-uQ@mail.gmail.com/

 Documentation/git-repack.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ee30edc178..39dac64833 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
+'git repack' [<options>...]
 
 DESCRIPTION
 -----------

base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
-- 
An old man doll... just what I always wanted! - Clara

