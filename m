Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E22C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 13:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378891AbiDTNJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 09:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378883AbiDTNJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 09:09:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF52442ED8
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 06:06:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i20so2159774wrb.13
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BYFlmXjOZ+VvW1QdTH75hAm+eMQpIjqPiCGi5UM2FVU=;
        b=IlkBxRjIXucTOrBVdDfLKyvqupLPa/aah1issviD+ypur9wXOxkMpf2nV98iWmcxhR
         rHFTfiVyljSoazxodu9JIp9o8aIqMBTemj2S3J6j1ODz5+fGhPXrEe9/zRuBf+bHIQOz
         DaHRosaxPJgSmcewZEsuNff4YZcnIc4QaJq3RrDkuunoj3uXOAlLqk8DDfVc2P9fimam
         PDZRoifHQHtIGDVloLTjQiU4BAg4p2SgdsQVTx2hUKWHolO0IZ0EuH/7eMw7R6glsfQO
         QxELDIiLwuwxVYj8xGiFOa5thda5Ob5L7LarcyhZVAM0F2GVtin0zZhGk1WkN2u8a2FH
         5ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BYFlmXjOZ+VvW1QdTH75hAm+eMQpIjqPiCGi5UM2FVU=;
        b=H8bsPuP51kBJANpUFCNCuyEoftR1l2PX3R3QAVCRKUXo/jfEvsMatA9CjdWFLtSUMn
         SZtp+RVmloNsFhFNYP36rTe0IHhZaWwL4BrPvK4kujVi6m4X0DihWRlHwCl0D87cMSZa
         JKL+lizLD/mjpqLXD2LPW0WvjkXfgN4CO5Xb4fvse1iw01fiSgnrOpxgM6DtyHBQmrhf
         F+dzGe+yYksclXB+FPIuiglWm21BJ6kfx0jUVkFlzfqETeAtiq6qFSIj/QfsnttWS5/c
         lpVglFjCSWdThLCWgOhx9JR8p6lP6t0s2vnUKxfdN2Pp145kXeA7kObWCutRFi+BGhwE
         YHgA==
X-Gm-Message-State: AOAM5330FclGT4I6CNbU3roUZwAe5wq6KVIB72jk5YfG6TUET4fsuYVi
        LzqCWbHhSjdzrBiJS9ip4M0=
X-Google-Smtp-Source: ABdhPJwo0rzoT8VNeBf6VeTtRJGsmuR0A3ZHJVIqc2Jzo3CLwTd6mKJ9z7PCPLHRQ1niBeU1AgTiMQ==
X-Received: by 2002:adf:d083:0:b0:208:c159:5d33 with SMTP id y3-20020adfd083000000b00208c1595d33mr15190561wrh.692.1650459985923;
        Wed, 20 Apr 2022 06:06:25 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm18638638wmh.31.2022.04.20.06.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:06:25 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     matthieu.moy@univ-lyon1.fr
Cc:     cogoni.guillaume@gmail.com, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, guillaume.cogoni@gmail.com,
        shaoxuan.yuan02@gmail.com
Subject: [PATCH v3 0/1] Documentation/ToolsForGit.txt: Tools for developing Git
Date:   Wed, 20 Apr 2022 15:06:16 +0200
Message-Id: <20220420130617.41296-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c6b48fba-c950-bb3a-3fdb-6d420a4cdfbc@univ-lyon1.fr>
References: <c6b48fba-c950-bb3a-3fdb-6d420a4cdfbc@univ-lyon1.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MOY Matthieu wrote:

> I think you can just drop that sentence. For someone a bit familiar with 
> either VS code or any other IDE, it's no big surprise that the debugger 
> integration allows such feature. For someone not familiar with VS code, 
> the patch about to land in next already contains a link to a page 
> explaining that.

Finally, I drop that sentence, I also think that the link that I put in
contrib/vscode/README is sufficient.

> contrib/emacs was really not meant for developers hacking on Git. Since 
> it contains only pointers to obsolete stuff, we may want to just discard 
> its current content and make it the place to put documentation for 
> people hacking on Git with Emacs, just like contrib/vscode/ is for VS 
> code and Git. But we probably have only a few (tens of) lines of 
> documentation, so adding the doc directly in ToolsForGit.txt is probably 
> better.

I left everything as they were. I just add the configuration lines directly 
in ToolsForGit.txt because there is not a lot of line. 
But, in the future, if there is more line, it would be better to move all of this 
in the contrib/emacs/README.

> A good indicator, yes. But reading only the summary ...

I take the summary that you propose, so this not a criterion now.

> I agree that removing Emacs-specific code from a general document is 
> nice, but then you should replace it with a link to ToolsForGit.txt like 
> "Tips to make your editor follow this style can be found in 
> ToolsForGit.txt" (without being specific to Emacs, that's the point of 
> the document, it also applies to VS code and may be extended in the 
> future to other editors).

Yup, I fix this, I add a mention to Documentation/ToolsForGit.txt in CodingGuideline.
I add it at the end of the file.

Thanks for your review,

COGONI Guillaume.

COGONI Guillaume (1):
  Documentation/ToolsForGit.txt: Tools for developing Git

 Documentation/CodingGuidelines | 18 +++++-------
 Documentation/Makefile         |  1 +
 Documentation/ToolsForGit.txt  | 51 ++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ToolsForGit.txt

Interdiff versus v2 :
diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index a7d21d6f6b..509cd89aa2 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -722,3 +722,10 @@ Writing Documentation:
  inline substituted text+ instead of `monospaced literal text`, and with
  the former, the part that should not get substituted must be
  quoted/escaped.
+
+
+Documentation/ToolsForGit.txt:
+
+ This document collects tips, scripts, and configuration files to help
+ contributors working with the Git codebase use their favorite tools while
+ following the Git coding style.
diff --git a/Documentation/ToolsForGit.txt b/Documentation/ToolsForGit.txt
index dc370a5861..5060d0d231 100644
--- a/Documentation/ToolsForGit.txt
+++ b/Documentation/ToolsForGit.txt
@@ -5,8 +5,9 @@ Tools for developing Git
 [[summary]]
 == Summary
 
-This document aims to gather tools that have a README and/or scripts in
-the Git project.
+This document gathers tips, scripts and configuration file to help people
+working on Git's codebase use their favorite tools while following Git's
+coding style.
 
 [[author]]
 === Author
@@ -29,6 +30,8 @@ information on using the script.
 [[emacs]]
 === Emacs
 
+This is adapted from Linux's suggestion in its CodingStyle document:
+
 - To follow rules of the CodingGuideline, it's useful to put the following in
 GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
 ----
@@ -41,36 +44,8 @@ GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
 			(cperl-merge-trailing-else . t))))
 ----
 
-- The version for C:
-----
-(defun c-lineup-arglist-tabs-only (ignored)
-	"Line up argument lists by tabs, not spaces"
-	(let* ((anchor (c-langelem-pos c-syntactic-element))
-	       (column (c-langelem-2nd-pos c-syntactic-element))
-	       (offset (- (1+ column) anchor))
-	       (steps (floor offset c-basic-offset)))
-	 (* (max steps 1)
-	    c-basic-offset)))
-
-(add-hook 'c-mode-common-hook
-	(lambda ()
-		;; Add kernel style
-		(c-add-style
-		 "linux-tabs-only"
-		 '("linux" (c-offsets-alist
-			    (arglist-cont-nonempty
-			     c-lineup-gcc-asm-reg
-			     c-lineup-arglist-tabs-only))))))
-
-(add-hook 'c-mode-hook
-	(lambda ()
-		(let ((filename (buffer-file-name)))
-		 ;; Enable kernel mode for the appropriate files
-		 (when (and filename
-			(string-match (expand-file-name "~/src/linux-trees")
-				       filename))
-		 (setq indent-tabs-mode t)
-		 (setq show-trailing-whitespace t)
-		 (c-set-style "linux-tabs-only")))))
-----
+For a more complete setup, since Git's codebase uses a coding style
+similar to the Linux kernel's style, tips given in Linux's CodingStyle
+document can be applied here too.
 
+==== https://www.kernel.org/doc/html/v4.10/process/coding-style.html#you-ve-made-a-mess-of-it
-- 
2.25.1

