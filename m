Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C531207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755482AbcIKKaa (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:30:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33149 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755407AbcIKKa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:30:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id b187so9367385wme.0
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zsCK1HOCfzAHfR9XStvXGsylwYK1FWoxVrM99a0EWx8=;
        b=afQNBLs18FLhgTM5Gbkz7g1lskqTaduUzBX3nqQptm3eblelGjiSx0zxZMiDfRYCBO
         eTWFWo4V6S/tF8tlm6zr4NH7yZDIr/s3wxdTkXMmHuQZxYT9JsMVWxI6ra4qAc/ZSPsi
         8w+0IyH/MiqcNfIKSP6KzmDV6vC4Lkwr7qZlbH4UDaQIJzq6ICSUQP1/Qu4yqrj3b0lE
         7YiTQz9ZSumQ2HEOWsWVSaenS4MMZi/erKCuotXJv+ZXdGPwouSUhKLBKIj+GVIz4qhA
         2z6jY76IsFY/0JlTu4NQ1924u/dmePiuCZCEBy5cPHTCJnwSo5mHyE1CDaVrAhYBr4ZP
         kdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zsCK1HOCfzAHfR9XStvXGsylwYK1FWoxVrM99a0EWx8=;
        b=MWgeoo1NSJfbS4OLNX8qdeYvWSI08k3nOkIrkvHkKZ0Tr8cTLYs6tDvn7KBdZOdldg
         opjRPkVolhimpsruVsyhbLqQooNylbyOGd6tGqS29Xs6e4ryiRK62/HiDhXNG1oVzx/8
         otdZ/vSusYrvP1Er4YWLldbVgWvg5uz/N7QTLVKPM3ePnFC6fmrRxcOzYJhRtdUZ2piO
         IX/gkDgI/o5WED4bxzTK/X2Rw1zfDJP+YDv9PESaOQjUx9VI12ITJMDzqO6GiqKV9qPv
         7nXTlB5c4G6cyhvAKQ/I3vIWELMSMpx0AurhekAnX2eIkPLfYOK3Ez7RZtz0c5D5NxZ6
         hmzw==
X-Gm-Message-State: AE9vXwO4gGzHTv/w/Y7m1r8wdxZitJfzaxffCzx6Lg3gSReEZ4zZziu/hsQ0Jd58l8Xm5A==
X-Received: by 10.28.0.132 with SMTP id 126mr6447314wma.88.1473589827206;
        Sun, 11 Sep 2016 03:30:27 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 1sm19321213wmm.0.2016.09.11.03.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Sep 2016 03:30:26 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/4] add: document the chmod option
Date:   Sun, 11 Sep 2016 11:30:25 +0100
Message-Id: <20160911103028.5492-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160911103028.5492-1-t.gummerer@gmail.com>
References: <20160904113954.21697-1-t.gummerer@gmail.com>
 <20160911103028.5492-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git add --chmod option was introduced in 4e55ed3 ("add: add
--chmod=+x / --chmod=-x options", 2016-05-31), but was never
documented.  Document the feature.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-add.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 6a96a66..7ed63dc 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
 	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
-	  [--] [<pathspec>...]
+	  [--chmod=(+|-)x] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -165,6 +165,11 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	be ignored, no matter if they are already present in the work
 	tree or not.
 
+--chmod=(+|-)x::
+	Override the executable bit of the added files.  The executable
+	bit is only changed in the index, the files on disk are left
+	unchanged.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
-- 
2.10.0.304.gf2ff484

