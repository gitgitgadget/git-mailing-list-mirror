Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896DBC433F5
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 09:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiDQJig (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Apr 2022 05:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiDQJie (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Apr 2022 05:38:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989973FBC8
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 02:35:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e21so15483460wrc.8
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nP3NaD9vRYpOeBhMcg7J/hdrI+GNvHAtmrmj1BTI9lw=;
        b=ZTIqSQ658kEp+2/RGYCCNdCwzDZjD22WrwojS3OCXF64twQLwELwZbWuxQTxTB7x6e
         jWZpTK3VgtmAAD+25HTHZ42uN8OOCXn2o//BHKTKFDiLJsEIoL9tgK0XCiGF3bjVS8bq
         5ccYWyWrZ50PEE4jIOP9p2esMmQIGjKmmtWahir7+RBHFGuRSjD9U1QAZRy/rj+Zq3iS
         5oBCves/tE0VTOR7I6k89EGwFxcJ+E0CoK526KWMZNyuK7T0VYo1fwaKqiuZmEzXyZa0
         KYRl9Pz8ImCHBnKhWQKAlIQQaYYHewj1tbyTdYETHinqRMbssUZjE4UBI0qhvUk9UR48
         MQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nP3NaD9vRYpOeBhMcg7J/hdrI+GNvHAtmrmj1BTI9lw=;
        b=0oba6CbvKdQZiUhjawqbDdwTGTEIu0xn2oLPwXDyrn5B8Ea83v01r6uHws8LrGyMsJ
         Od5OmvRU3oo8bEmAJIviR0Musgmp3QhUKhogYLHe7Y5SxWMw52stMa/O69vl3rq6qD2e
         uq/UDueIyCDvhlgcm1N/DorQEnbNrMAAGOfrfzRJGph5T2OOelC0+rDV0QbAYGTzvK7X
         vEEbKH3mWFSwGNiwAQDbJzz+jPEwtECz4PDxWji+VDvizxWfKyGD717lOwvw9toWIDGq
         RUx1l1CSrHRnY5/emb5T+5EzhmR00u1HPEo2+fgvSObhzNJdjfun+Vas0icwlgYHCm/T
         BOfQ==
X-Gm-Message-State: AOAM530QQ/695HKlsGA+5RDv5DGWuxqEeyNmES2CsoIUEI1vAf+iFt53
        i4zziGzaKvTr5WtN7Din6gY=
X-Google-Smtp-Source: ABdhPJzrzwwYF+gHfMFnh9biv0uSM5KF3xrwTivtBxAjd6r5tELTIKvwM+zoNe9SWxK5qvvSMi81Ug==
X-Received: by 2002:adf:e609:0:b0:20a:8110:2245 with SMTP id p9-20020adfe609000000b0020a81102245mr4763546wrm.211.1650188156703;
        Sun, 17 Apr 2022 02:35:56 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d45cb000000b0020a810f7726sm4470757wrs.5.2022.04.17.02.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 02:35:56 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     gitster@pobox.com
Cc:     Matthieu.Moy@univ-lyon1.fr, cogoni.guillaume@gmail.com,
        derrickstolee@github.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, guillaume.cogoni@gmail.com,
        shaoxuan.yuan02@gmail.com
Subject: [PATCH v2 0/1] Documentation/ToolsForGit.txt: Tools for developing Git
Date:   Sun, 17 Apr 2022 11:35:48 +0200
Message-Id: <20220417093549.101436-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqqlew554ye.fsf@gitster.g>
References: <xmqqlew554ye.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MOY Matthieu wrote:

> I don't think the last sentence is needed, and if it is, it would be
> better within contrib/vscode/README.md (so that someone reaching this
> README directly do see the information too).

I think so too. However, I already make a PATCH last week for 
contrib/vscode/README:
(see <20220407204001.112287-2-cogoni.guillaume@gmail.com>).
And, I see that in What's cooking in git.git (Apr 2022, #04; Thu, 14)
it will be merge in Next. So, do I take this PATCH from the last week
and I add it this part in contrib/vscode/README or I just add this part
here in this new PATCH but where the subject is different?

> - For Emacs, it's useful to put the following in
>    GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:

>     ;; note the first part is useful for C editing, too
>     ((nil . ((indent-tabs-mode . t)
>                   (tab-width . 8)
>                   (fill-column . 80)))
>      (cperl-mode . ((cperl-indent-level . 8)
>                     (cperl-extra-newline-before-brace . nil)
>                     (cperl-merge-trailing-else . t))))

> Actually, the Linux kernel's CodingStyle contains more relevant stuff 
> (for C, not Perl):

> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#you-ve-made-a-mess-of-it

I add this part directly in ToolsForGit.txt and not in the README in contrib/emacs.
But, from this document in Documentation/RelNotes/2.18.0.txt, I read this:
"The scripts in contrib/emacs/ have outlived their usefulness and have been
replaced with a stub that errors out and tells the user there are replacements."
So, for the next version of this PATCH, can I replace what is in the README by the 
configuration that I write in ToolsForGit.txt?


OAKLEY Philip  wrote:

> I'm of the view that a README is a positive indicator that there is some
> informational value regarding the tool's use for developing Git being
> made available. It doesn't always have to be code before it is of
> assistance in developing Git.

I agreed with OAKLEY, the README is good indicator to say that we have some
information besides the scripts.


COGONI Guillaume (1):
  Documentation/ToolsForGit.txt: Tools for developing Git

 Documentation/CodingGuidelines | 11 -----
 Documentation/Makefile         |  1 +
 Documentation/ToolsForGit.txt  | 79 ++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ToolsForGit.txt

Difference between v1 and v2
diff --git a/Documentation/ToolsOnGit.txt b/Documentation/ToolsForGit.txt
index a33b369a06..d96cadd09c 100644
--- a/Documentation/ToolsOnGit.txt
+++ b/Documentation/ToolsForGit.txt
@@ -1,12 +1,12 @@
-Tools on GIT
-============
+Tools for developing Git
+========================
 :sectanchors:
 
 [[summary]]
 == Summary
 
 This document aims to gather tools that have a README and/or scripts in
-the GIT project.
+the Git project.
 
 [[author]]
 === Author
@@ -32,4 +32,48 @@ setting breakpoints, logpoints, conditional breakpoints and more in the editor.
 [[emacs]]
 === Emacs
 
-See contrib/emacs/README for more information.
+- To follow rules of the CodingGuideline, it's useful to put the following in
+GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
+----
+;; note the first part is useful for C editing, too
+((nil . ((indent-tabs-mode . t)
+	 (tab-width . 8)
+	 (fill-column . 80)))
+	 (cperl-mode . ((cperl-indent-level . 8)
+			(cperl-extra-newline-before-brace . nil)
+			(cperl-merge-trailing-else . t))))
+----
+
+- The version for C:
+----
+(defun c-lineup-arglist-tabs-only (ignored)
+	"Line up argument lists by tabs, not spaces"
+	(let* ((anchor (c-langelem-pos c-syntactic-element))
+	       (column (c-langelem-2nd-pos c-syntactic-element))
+	       (offset (- (1+ column) anchor))
+	       (steps (floor offset c-basic-offset)))
+	 (* (max steps 1)
+	    c-basic-offset)))
+
+(add-hook 'c-mode-common-hook
+	(lambda ()
+		;; Add kernel style
+		(c-add-style
+		 "linux-tabs-only"
+		 '("linux" (c-offsets-alist
+			    (arglist-cont-nonempty
+			     c-lineup-gcc-asm-reg
+			     c-lineup-arglist-tabs-only))))))
+
+(add-hook 'c-mode-hook
+	(lambda ()
+		(let ((filename (buffer-file-name)))
+		 ;; Enable kernel mode for the appropriate files
+		 (when (and filename
+			(string-match (expand-file-name "~/src/linux-trees")
+				       filename))
+		 (setq indent-tabs-mode t)
+		 (setq show-trailing-whitespace t)
+		 (c-set-style "linux-tabs-only")))))
+----
+

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index b20b2f94f1..a7d21d6f6b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -492,17 +492,6 @@ For Perl programs:
 
  - Learn and use Git.pm if you need that functionality.
 
- - For Emacs, it's useful to put the following in
-   GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
-
-    ;; note the first part is useful for C editing, too
-    ((nil . ((indent-tabs-mode . t)
-                  (tab-width . 8)
-                  (fill-column . 80)))
-     (cperl-mode . ((cperl-indent-level . 8)
-                    (cperl-extra-newline-before-brace . nil)
-                    (cperl-merge-trailing-else . t))))
-
 For Python scripts:
 
  - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).


-- 
2.25.1

