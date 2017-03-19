Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EEF22095B
	for <e@80x24.org>; Sun, 19 Mar 2017 09:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbdCSJKf (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 05:10:35 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34701 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdCSJKe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 05:10:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so13466459pfb.1
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MyRu5ONbKQ6U6otX1zui7bb07XB9B49PjpMckFY7tdQ=;
        b=PEgtmG0wpuA2Y8hyttKsgpOxfqSReMD43VM1YOsr5/hDtjLJeZ/xSrzCsvwfh8aF4L
         ejV255cBXa5+EfXkCBNFsOq0mFet9qEEuKrxfvf+sZ97pUHWTB+B4h1m6D23SesAlLhw
         Sp3w4cDr3AzkfVVrjwzbNrjQUgwdU2zeRxspVwQUnlPnrDOkc1z4VjeQYZe9vY5MGcnA
         3sV1OoD3QSoVVDKIK8VAJsWyJf3cA9KGXoh+irzyoH7aHZgIDcgEeoyYomXRk/ZbARGu
         oEE1NHq0qnYoSqtkk67cb4n+3dB8/wJp5r7uMINHhBA+TvVS4VFFOeYqXq110IJEb4+q
         JrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MyRu5ONbKQ6U6otX1zui7bb07XB9B49PjpMckFY7tdQ=;
        b=eVqYGMOBOWNlckPHgHTequFWsFU29bMapaUCqDASo5ff0GkIeuTmDrLX5FBNa41bH/
         0pkEmumq4hs2+0FWzPZ7lcfAF9llXI81cFjsL7s4U8C7pkH6wwc/hvf78XOMMUhpIcNM
         zTr/8vvYZb1zlXJUDgQjp0fXXa1dma+oWz6LBgFHa6MoHIB0u8k6Nkv0nmk/oWIVmSiP
         IKABQgY7dxzNaMMtIygfi/wCP+RPI0oWTCepsP4UmBSbFbMO7Lm/YN+fexNlj2s5biqB
         LFrIsExohm+sWtWZ708qnRYnxZboO9jKIbm5aeUfBNyyTP3pvCsT0KYgVrqQuL6vmwz4
         M52A==
X-Gm-Message-State: AFeK/H0vvUxM0BBdZ3Oxkcbmig4Zk3BTMAopDKFhWW7yjNmx55hWvtN+2GhF+JjxQXIGgw==
X-Received: by 10.98.204.195 with SMTP id j64mr25797818pfk.213.1489914072648;
        Sun, 19 Mar 2017 02:01:12 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id u64sm14067960pfk.113.2017.03.19.02.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Mar 2017 02:01:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 19 Mar 2017 16:01:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] git-commit.txt: list post-rewrite in HOOKS section
Date:   Sun, 19 Mar 2017 16:01:02 +0700
Message-Id: <20170319090102.5203-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The hook was added in a86ed83cce (Merge branch 'tr/notes-display' -
2010-03-24), which updated githooks.txt but not git-commit.txt.

git-commit.txt was later updated in e858af6d50 (commit: document a
couple of options - 2012-06-08). Since this commit focused on command
line options, this section was probably forgotten.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-commit.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 25dcdcc289..ed0f5b94b3 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -463,7 +463,7 @@ order).  See linkgit:git-var[1] for details.
 HOOKS
 -----
 This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
-and `post-commit` hooks.  See linkgit:githooks[5] for more
+`post-commit` and `post-rewrite` hooks.  See linkgit:githooks[5] for more
 information.
 
 FILES
-- 
2.11.0.157.gd943d85

