Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0C5C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 08:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386835AbiDUIsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 04:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386838AbiDUIsP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 04:48:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C66C13D78
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 01:45:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i20so5608834wrb.13
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rs8IptVzhP0r6p96+18m0yvRgj8hPz0zNRKQNhADFR8=;
        b=msOyLFZTAFG+WrbC55Y3h9G+xXk1SMETOzx1OqZTXxBUqrmslNKlKkvk4Lx2Ih8pqt
         6c4C2ctlRaBu+cbiFvLrtrL8MEeaaQTSAFEHr4xCPn1z+BW0PmiZkCnbHpdbhB/YD11U
         qSjWwowBYhAqkDnL99t1ILi5BVeQdmMwIzrWqzhatdWKr4qpRSjeuMc//AEV9bNDKQzt
         uq+yLgmBRB8OY4HYsqQaVc1h/JPlVtaYCnwmHKuXmkW2DYKlW50Wtl7jea6Iv+V0j04M
         PRxJaPZ3Zzhug5yn50c/o7V3C5nzJp7joxl9xfgirYix1okTOkmawHfFFL4id/SrQzZg
         UorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rs8IptVzhP0r6p96+18m0yvRgj8hPz0zNRKQNhADFR8=;
        b=AR/DJcvHdFIwrT80aR8y3Pe1Xy2hUixPseRkbvfzcfobI0WWc+U0+ValKpobmyMwIr
         HiZ8rQD7SKFyDhaMFKyS2lE3Sal7QklCGJYdA0lr2XSrD5q6Jp536KzvTGMFJuE3OsHt
         Yj17vxJg1/2wxCQAdUR0rgW+sHlAvOputtFw+U9URBs86YPpRUEDbRZFcf87lgg849Wn
         9W6Wz4sNOS2w6nkKIWEHQMlo6DMsb+6S/GuJCMexdl7Dy4lKi5MECwxjXKTSp5Ip6Kql
         8jxVaZsbzPHahq85zarj3qKVH6nKVUn7fWiwWtk4fH+pAuJYxv9tSQ8v+i3lOL5kkQeU
         /czA==
X-Gm-Message-State: AOAM530wYu3Kxlmdpj83zOgs+4F5mkJvJ/kByjtcn65TkZ6Jf2+fvc1w
        sUlV7/B2Vj8Ud8LoVGYD7QlKuUGhJAQm5w==
X-Google-Smtp-Source: ABdhPJw/6rK1RJ/rBcgqZDbrjdS655pFOMnmn9bENJcdBbt31crlRrS1Es786UDBEuyo3847lkSb8Q==
X-Received: by 2002:a5d:61d1:0:b0:207:aaba:3013 with SMTP id q17-20020a5d61d1000000b00207aaba3013mr18258508wrv.465.1650530723582;
        Thu, 21 Apr 2022 01:45:23 -0700 (PDT)
Received: from desmoniak.univ-lyon1.fr (wifi-ext-0204.univ-lyon1.fr. [134.214.214.205])
        by smtp.gmail.com with ESMTPSA id r17-20020a0560001b9100b00207afaa8987sm2084444wru.27.2022.04.21.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:45:23 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     gitster@pobox.com
Cc:     cogoni.guillaume@gmail.com, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org,
        guillaume.cogoni@gmail.com, matthieu.moy@univ-lyon1.fr,
        shaoxuan.yuan02@gmail.com,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Subject: [PATCH v4 1/1] Documentation/ToolsForGit.txt: Tools for developing Git
Date:   Thu, 21 Apr 2022 10:45:15 +0200
Message-Id: <20220421084515.21236-2-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421084515.21236-1-cogoni.guillaume@gmail.com>
References: <xmqq35i7o3dk.fsf@gitster.g>
 <20220421084515.21236-1-cogoni.guillaume@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This document gathers tips, scripts and configuration file to help
people working on Git’s codebase use their favorite tools while
following Git’s coding style.

Move the part about Emacs configuration from CodingGuidelines to
ToolsForGit.txt because it's the purpose of the new file centralize the
information about tools.

But, add a mention to Documentation/ToolsForGit.txt in CodingGuidelines
because there is also information about the coding style in it.

Helped-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 Documentation/CodingGuidelines | 16 +++--------
 Documentation/Makefile         |  1 +
 Documentation/ToolsForGit.txt  | 51 ++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ToolsForGit.txt

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index b20b2f94f1..4c756be517 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -43,7 +43,10 @@ the overall style of existing code. Modifications to existing
 code is expected to match the style the surrounding code already
 uses (even if it doesn't match the overall style of existing code).
 
-But if you must have a list of rules, here they are.
+But if you must have a list of rules, here are some language
+specific ones. Note that Documentation/ToolsForGit.txt document
+has a collection of tips to help you use some external tools
+to conform to these guidelines.
 
 For shell scripts specifically (not exhaustive):
 
@@ -492,17 +495,6 @@ For Perl programs:
 
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
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 44c080e3e5..7058dd2185 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -93,6 +93,7 @@ SP_ARTICLES += $(API_DOCS)
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
+TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bundle-format
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
diff --git a/Documentation/ToolsForGit.txt b/Documentation/ToolsForGit.txt
new file mode 100644
index 0000000000..5060d0d231
--- /dev/null
+++ b/Documentation/ToolsForGit.txt
@@ -0,0 +1,51 @@
+Tools for developing Git
+========================
+:sectanchors:
+
+[[summary]]
+== Summary
+
+This document gathers tips, scripts and configuration file to help people
+working on Git's codebase use their favorite tools while following Git's
+coding style.
+
+[[author]]
+=== Author
+
+The Git community.
+
+[[table_of_contents]]
+== Table of contents
+
+- <<vscode>>
+- <<emacs>>
+
+[[vscode]]
+=== Visual Studio Code (VS Code)
+
+The contrib/vscode/init.sh script creates configuration files that enable
+several valuable VS Code features. See contrib/vscode/README.md for more
+information on using the script.
+
+[[emacs]]
+=== Emacs
+
+This is adapted from Linux's suggestion in its CodingStyle document:
+
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
+For a more complete setup, since Git's codebase uses a coding style
+similar to the Linux kernel's style, tips given in Linux's CodingStyle
+document can be applied here too.
+
+==== https://www.kernel.org/doc/html/v4.10/process/coding-style.html#you-ve-made-a-mess-of-it
-- 
2.25.1

