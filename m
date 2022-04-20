Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E8EC433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 13:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376909AbiDTNJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 09:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiDTNJf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 09:09:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F6A424A8
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 06:06:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so2204146wrg.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMcYdPkNsh6ZEXwu2xFc4c5a18/6FOMZykGRCI7wzhM=;
        b=bXcrdCCeDx+Lb7goTq12/Pn5h9l7NRYmuZT8c8TDGVaRCqiC1Nxx08fXx2XmeMpggI
         YbVgiZrCzXUQn03zS25ZgOqATx0dT6u2Cr4WuNu9QS2mrdur1exD2uxoZmtZJabpAPcN
         AuhHsRKfVfIKTui7y9mDwe2m7IlyU7Yqa6TTJlAGBJ3vXryLOTZ3pDXIlxJA2YQnCDeJ
         mVISSHEZQttEzT3UTzlPri5hChlCMe5RH8mFRBv+MtpchfzYeP81FO8AEqKW4iSQ3sAA
         GEIsk7QCFBlFe86Ji7O+oSC+u6kN5iDPP6iSrfeZtRHB5qxwapggTkNllp4VSvRva0xL
         jTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMcYdPkNsh6ZEXwu2xFc4c5a18/6FOMZykGRCI7wzhM=;
        b=JPQ7N7bSbX8ymMzcY/LdoLFhx1f5W0NrYByCKaJ1dxuZAd/UwkJeFocZi66t+L1PtW
         9EYDpnwgltab5qCx53AWznO03MavkKq6KDNByh6o1rc7m7+sG1WG2k40id7I+/rzIoGU
         Ij+oq5I0IU25jp4F8yUqMohJtegQnuy0gtQF3oO3dq08B+IrqTZfjTKa3OtAim90h+nZ
         YaQu26ZrHfOZvrNF7DsUcori+C88Ll8si4SY6N7fqDRuoLtGymnvou82gHpGMyKjEgfo
         xpmmEIJLTXjJ0Y1me8NPlz0ubJtwlybyE07IPbe2QhGb8r82mwy2n3Bj8cdbKgMNkowk
         DmQg==
X-Gm-Message-State: AOAM532bKtvHoWf4HcCvFR5+nEWKwNH34oYFtbmaXG3tOVHM+Ytr89qA
        ZJjMWLXoa/xGZosWZl+acTw=
X-Google-Smtp-Source: ABdhPJwuvUN0OrytcYYctjdBBQR2DCPV5rWAJckH5eXOEPFzQTF/44gPDNPQ+kXAQF9weBJlatxXbA==
X-Received: by 2002:a5d:658f:0:b0:207:9c0e:1364 with SMTP id q15-20020a5d658f000000b002079c0e1364mr15603841wru.632.1650459988486;
        Wed, 20 Apr 2022 06:06:28 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm18638638wmh.31.2022.04.20.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:06:28 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     matthieu.moy@univ-lyon1.fr
Cc:     cogoni.guillaume@gmail.com, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, guillaume.cogoni@gmail.com,
        shaoxuan.yuan02@gmail.com,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Subject: [PATCH v3 1/1] Documentation/ToolsForGit.txt: Tools for developing Git
Date:   Wed, 20 Apr 2022 15:06:17 +0200
Message-Id: <20220420130617.41296-2-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420130617.41296-1-cogoni.guillaume@gmail.com>
References: <c6b48fba-c950-bb3a-3fdb-6d420a4cdfbc@univ-lyon1.fr>
 <20220420130617.41296-1-cogoni.guillaume@gmail.com>
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
Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 Documentation/CodingGuidelines | 18 +++++-------
 Documentation/Makefile         |  1 +
 Documentation/ToolsForGit.txt  | 51 ++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ToolsForGit.txt

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index b20b2f94f1..509cd89aa2 100644
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
@@ -733,3 +722,10 @@ Writing Documentation:
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

