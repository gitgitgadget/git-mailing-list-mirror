Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81DF1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 21:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762972AbcINVHp (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 17:07:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33463 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762115AbcINVHo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 17:07:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id b187so4241576wme.0
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zsCK1HOCfzAHfR9XStvXGsylwYK1FWoxVrM99a0EWx8=;
        b=vO6/BnXbw3G16cSA+vDJCfElTqKS7JfuFYy+kCBRGtM7QDLzW7KL9Aerz7dmlQ9eOF
         DDNOOCEETCHtQPMwmqSawFMtRvxWbqTaNbvr1PXtknU8k8Sel7xQK2fvK474z3H5F/vg
         NdaABcbDf+cUz8oxAJCKcC/baFzzCQenpFOlvYIyqnSuXHJy+EOrTQVFaLKr9MwhYkCj
         G4G5jN/+yirpkg+d/56nKK15FATCVJ7TPj8p+8lfU9GS7wQRug1kUzEaMd80kE8uvNsQ
         hO/Bk5v/hM7SYRXSSsOZGyrZ0Z45TGF7D8oj593+PsKj0ikmZ0ykSvP+F8AjMSIWJ+Vw
         9uSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zsCK1HOCfzAHfR9XStvXGsylwYK1FWoxVrM99a0EWx8=;
        b=Ie+a2Bct8iArfUfp0ITqJpvkOtzY11f0X8UMaduJra3DJuT+i9EZ2Oao7l+cxwS7bg
         +ew8+ah+CiQMY9pi1K9PhmCczBDoiXi56SBqKMHLJdF/NA2QdCY05a6JGOJqgWCbXczi
         r4abQA/oV7kZ0ZVs+ZKGsed6XtBocgJ1vGu/cya0BVukVKuNaTGZYRuNORicl+1E8u0/
         EtMIdN87cAhRRTJAOI/A4oFYTU8DYAuKag+vzcKDM6wwAF7JyEZDnSaoRJ1Z3t7aM1BN
         z0IBx298FeuMRhq5YeGoJJ0Xu+9STXq09BbvZqt53qtJUNG6of72roITYFLjoJ7s6aHx
         6WXg==
X-Gm-Message-State: AE9vXwMlbjboR+VuFvuAaodofKvudkqypsZTQfssxsGS7AyUtBFWj8Ydf/0Shk6XbsUAkw==
X-Received: by 10.28.232.208 with SMTP id f77mr12064318wmi.15.1473887262939;
        Wed, 14 Sep 2016 14:07:42 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id d62sm693727wmd.7.2016.09.14.14.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Sep 2016 14:07:42 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 1/4] add: document the chmod option
Date:   Wed, 14 Sep 2016 22:07:44 +0100
Message-Id: <20160914210747.15485-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160914210747.15485-1-t.gummerer@gmail.com>
References: <20160912210818.26282-1-t.gummerer@gmail.com>
 <20160914210747.15485-1-t.gummerer@gmail.com>
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

