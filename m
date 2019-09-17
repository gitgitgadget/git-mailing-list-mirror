Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5781F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfIQQfY (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:35:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46106 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730515AbfIQQfY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so2457619pfg.13
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ek0x5MfYwm7QdAPY+CVI65wC+nhjmkOQAM5eZqgTwtQ=;
        b=rnPYwAT6NrrbAb7QDFTfDLMFWCrXvqo59ykGaGQmuYCUgH1ioev1XP58wkbkVtYOn6
         /v73KE+xkvotl6G5fYhTKwIVdhjszyUyMsB8Lm+ocIDccnReJlrI9uwzW7vZR/Lz3TiK
         qoNKi1bENBhMvxgiZrtPQNUmotrTOATSlPyOpPpGCNoHKF2YZmGrrZPL4ZDFgxbdPIH3
         pnPSwNZJLEpfsnNHdH0YQ4f1nnGocUvagDEyDvoXAm+srknIVbWW25yzQPWghzzmjX4E
         9j0d6qeFNYI6QRDv3zWHKX+7rbezYlo8Td2fExRnxDVP6TwKx4mbWQ6B/xztvLS2Kgv3
         oR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ek0x5MfYwm7QdAPY+CVI65wC+nhjmkOQAM5eZqgTwtQ=;
        b=Hdh3HLiLCbPNQDOVCQH6sFwG31EXy2e2l8JcKkVXR0O7ayb/HXfhK+FjYb3JIEUCLh
         +tU5NfxtD1W3HyxSJr3dISkDFoWHAPH9T/Nr2h4+dYUkuWhvQaKavdk7H/hUTZp6x2DC
         BUYaP3Z0O/x1J526Vnau4//13/zEn6LGbXqt/Z5shslsUrcIAtmKv7YfsLn63lpy1Ruo
         JNUPbnFvm4QlY01Dyo/QIDl43M8cULy1/PFjuCM2HbYDvUEGKABmy+wQCY29wh2q4ouB
         FsYjoC0P/BiY947TwaDY7nQMZVFm00jHZDnqS7Lr7jCNheuUjleTip9ESlbei1keWO9S
         4ztA==
X-Gm-Message-State: APjAAAWbPA6QJemWwD2boDam07PuskbiiNDTm8kax0bonBy7rXhNs/T0
        sUA/9gg4mNEhn7CoPMUW7n0FPliipMI=
X-Google-Smtp-Source: APXvYqwMtyFPW1snyHPEmL6ROdfeFzoP8bJbLqVWXf9ouI5zqOOWYwSgwQDa+KUj6zgiVrAKtKRwKA==
X-Received: by 2002:a17:90a:9dc1:: with SMTP id x1mr5815480pjv.98.1568738121542;
        Tue, 17 Sep 2019 09:35:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm3202452pfe.52.2019.09.17.09.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 09:35:20 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 08/12] git-clean.txt: do not claim we will delete files with -n/--dry-run
Date:   Tue, 17 Sep 2019 09:35:00 -0700
Message-Id: <20190917163504.14566-9-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.17.g6e632477f7
In-Reply-To: <20190917163504.14566-1-newren@gmail.com>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It appears that the wrong option got included in the list of what will
cause git-clean to actually take action.  Correct the list.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-clean.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index db876f7dde..e84ffc9396 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -35,7 +35,7 @@ OPTIONS
 --force::
 	If the Git configuration variable clean.requireForce is not set
 	to false, 'git clean' will refuse to delete files or directories
-	unless given -f, -n or -i. Git will refuse to delete directories
+	unless given -f or -i. Git will refuse to delete directories
 	with .git sub directory or file unless a second -f
 	is given.
 
-- 
2.22.1.17.g6e632477f7.dirty

