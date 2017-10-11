Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ECBA1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 18:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbdJKShj (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 14:37:39 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34942 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbdJKShi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 14:37:38 -0400
Received: by mail-pf0-f193.google.com with SMTP id i23so2987323pfi.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LwayeFMxdhS3OOmszuKb5XpnpJcXRU4dEz2KSrOC9H0=;
        b=E88qGlqG2odfvX7hVtwAPxCrik1bJvxysh95Bx23ePaNBklNy7x4KX82M1eI2YoBEi
         NaiQoU3XqChNVrQ+AEN+Fl6sLrQOV/6ihvUav+DL+wya/mAmksCp2rKQCCxhga6ObvbQ
         nOPlZ63IfoVMPxWa3lv7s5goTdKCWD9W77oUpgg5xhw3Ai5PDif8Jy98gicOKoloeTY/
         6mX2nYiQB6hU2oeruOBNwuvEdNaAuWiya3LECfh1oJQhBRTC8j0BapDXy7jlBrVMQPGr
         2mNy8Kz17d/UF20aXB/5yvi0GSpHZmRwj3qQDeu5PBpzVYMcGBgJIL3uP+iqC8SvMlUv
         poqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LwayeFMxdhS3OOmszuKb5XpnpJcXRU4dEz2KSrOC9H0=;
        b=GQP8F3w0fZXzSXnuqMyj0ZiMgzdoFreFV3F0Mw1MMNI3GjBpWCK6pTbrvZvKPugJha
         Px05XNhE+yd4ctOiTL9WUp1+9gwsX2sP7HySAcuPNDpkbdY3ldkFY09bdEbRxaKPfTgB
         TzaGoZT/fwVvJs9ENCX7UBowHx/dV4EH1sRliCkvWEIFEkOqCRgFpuzGusNrvQ9inBLi
         kxxAmJiEAuhMFbVzZ8ADh3eCFuiKjAKLdBOR7Ozt8ejjsAz53fyFbS9HWWd3aJRabFg6
         C43S1hG1H/scr1E8yf6Fcb4FFWI5Gk9e61ZBe0u44+1irFVQqOiJHCqvwyfqs2DTcyT8
         OU0w==
X-Gm-Message-State: AMCzsaUAiKoX/hN0s0+Qa94Njiyyywy/CYZm0aNK4S7XuYBNpLtxAOxR
        C3Qcd3nnYI4CGqpyPKbly94DJDMp
X-Google-Smtp-Source: AOwi7QBmA//VddNzbu7XYYIaLip673gN3CKv4sUGaVQKlGDtlJTrjye9hWOAzDzA7j7Oblzuaf0rtw==
X-Received: by 10.99.127.94 with SMTP id p30mr420042pgn.66.1507747057633;
        Wed, 11 Oct 2017 11:37:37 -0700 (PDT)
Received: from localhost.localdomain (64.71.239.49.rev.vmobile.jp. [49.239.71.64])
        by smtp.gmail.com with ESMTPSA id x26sm27494144pfh.95.2017.10.11.11.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 11:37:37 -0700 (PDT)
From:   Takahito Ogawa <aiueogawa217@gmail.com>
To:     git@vger.kernel.org
Cc:     Takahito Ogawa <aiueogawa217@gmail.com>
Subject: [PATCH 1/1] git-stash.txt: correct "git stash" behavior with no arguments
Date:   Thu, 12 Oct 2017 03:37:18 +0900
Message-Id: <20171011183718.2404-1-aiueogawa217@gmail.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <n>
References: <n>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git stash" behavior without any arguments was changed in
1ada5020b ("stash: use stash_push for no verb form", 2017-02-28).
This is equivalent to "git stash push" but documents says
"git stash save".

Correct it.

Signed-off-by: Takahito Ogawa <aiueogawa217@gmail.com>
---
 Documentation/git-stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 00f95fee1..63642c145 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -33,7 +33,7 @@ and reverts the working directory to match the `HEAD` commit.
 The modifications stashed away by this command can be listed with
 `git stash list`, inspected with `git stash show`, and restored
 (potentially on top of a different commit) with `git stash apply`.
-Calling `git stash` without any arguments is equivalent to `git stash save`.
+Calling `git stash` without any arguments is equivalent to `git stash push`.
 A stash is by default listed as "WIP on 'branchname' ...", but
 you can give a more descriptive message on the command line when
 you create one.
-- 
2.13.1

