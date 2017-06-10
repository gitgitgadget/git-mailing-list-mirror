Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1DAA1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 17:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbdFJRii (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 13:38:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34943 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbdFJRih (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 13:38:37 -0400
Received: by mail-wr0-f196.google.com with SMTP id g76so13244110wrd.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fa/rYys1YasXHKrHVi/c4eRaqTFVrkDal7dnuAHtDR8=;
        b=R+JynUbRUw6RYJ8dgStbK1eLad0mOnr6Emw/i+7I2LSFoaW26pqTk5Bv+97YZsLXxu
         spwfYk5Mr1xcLIPHV9Yu0aF4OdPtjGyfMEAmhs0P0rLcEIRL10UtTyLRAOue9MMr2rSF
         slibo092sAemSoHgY6Z89sGpFJQA/F7eEahtUOgs9sX3tvMdYj7L6Nqq7F8p/b77NgNC
         K9NDdXgSXTeBCuxmCL1v9GWc+wYKXE2l71+jF/VyfrB4jiQro8TEB04GojNDbII5CL9F
         ZGZEq0FVQPUBPJQXtgYTIfT6AJz9JXNxB8zvmW22MOLkS7HAJLyYzSbJb8qYv9TLnRWr
         CS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fa/rYys1YasXHKrHVi/c4eRaqTFVrkDal7dnuAHtDR8=;
        b=icglThgmgYpBOozgFcyBsumBmyfKvYqR73//hZeHd5U2+3/K9bwg6ObI3gew+SWruq
         sDH6ZX7SMcFByeJNly/2lBw60mORDcjOVVML5ShP7IU6ZEXUtbDNa4jUEYMQ0je6wH+B
         ULcOJ4Ghlr955FyZockGLToTNsOCpwd5ZEkYvZNi0HiQUPIcEDdepcMso3EUzCKqrZUr
         mfW1gGe9FAEpTmgxS3fx5Wo6GKsP82uNXx7ydRkUSaiCVZ1L/QOqpPEfzywEqZ0NAvEx
         GJc+K0y068zZ3MQo66tP98viGSmEnxhZYRylVP8u/JMVs5sJgpYDYPmJCNre2xk3FqBC
         5+3g==
X-Gm-Message-State: AKS2vOxe/0sRF7xs8CeB79HpRXMg4yLYX+l+lcO39y/Fw08JiS06h7Nz
        aPI9cmeqjfLo2BN2lBY=
X-Received: by 10.28.234.70 with SMTP id i67mr3292674wmh.91.1497116315890;
        Sat, 10 Jun 2017 10:38:35 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3439:7300:99fb:6818:11d2:739])
        by smtp.gmail.com with ESMTPSA id y41sm5909446wrd.59.2017.06.10.10.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 10:38:35 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH v2] doc: fix location of index in worktree scenatio
Date:   Sat, 10 Jun 2017 19:38:24 +0200
Message-Id: <20170610173824.19460-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170610090719.8429-1-asheiduk@gmail.com>
References: <20170610090719.8429-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When setting `.gitattributes` in a second worktree, a plain `rm .git/index`
does not actually delete the index.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 473648386..2a2d7e2a4 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -229,7 +229,7 @@ From a clean working directory:
 
 -------------------------------------------------
 $ echo "* text=auto" >.gitattributes
-$ rm .git/index     # Remove the index to re-scan the working directory
+$ git read-tree --empty   # Clean index, force re-scan of working directory
 $ git add .
 $ git status        # Show files that will be normalized
 $ git commit -m "Introduce end-of-line normalization"
-- 
2.13.0

