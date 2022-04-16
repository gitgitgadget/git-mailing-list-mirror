Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD19C433EF
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 12:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiDPMh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiDPMh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 08:37:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3553397
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 05:34:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p18so12617269wru.5
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8fTrlB4zSYVL3fLW75IXmiGyluadqsE4996lrazbfs=;
        b=k00h5mXD8nDgM65JEE/+uA2S2g5mawnwCOPtsyZnxnY+awGr7YL6FySxVqVyCu/ZeE
         0alce+h4G2q0bCs0K7IgHsHDHPEyFOM6ICOGkcYDAQYRjd0I3yz69MHvv+hS2KtKcGQW
         VPd+qeWIW1+rKOGIp80i+yHLHSYhX0327nx7p25guHlmxwvjUwLaiXQUCrUvIqz5eDws
         fCvBJJ2t2AgIv9jAPMF05DMgMADlS6WWOz9aQ3V0c+Ia4eldCEt/CC2y56465Xu6IHRq
         Ekxw1O4hj49WO0EOkM2vWnlq4gD1cIWAR+8NxS60FwkVn5zvXFXcvlsPvdUN4/0b+Lmg
         Y5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8fTrlB4zSYVL3fLW75IXmiGyluadqsE4996lrazbfs=;
        b=elFqZIqQAASDcD0TVDBYsQHg99bDIkW4Z5khFaMyZkGhJ7oIoB4RiLoXhYOF1yDhlM
         stIJqCx8DIymHHyIMOBnrYfm8RIVzE2dv36tZDU83/I75FFaYd24zGUJI8C9634oyi80
         Ws4QAaOJYgBIPVVmPCS5lXAqXwCrz6a0vNRgS3fGyrtVL/coWw9z5hC63NMERvFW+aY1
         NWxzzY6tah3E9qSOXVCUsmdISiEIlXaaItIkd7unPEYSciNljqImeHYIW5x39WA54LCp
         BjVHvvjHDYRvrNOZLcu41xdbDhudnfwgiA/GL36FM17b8Fj28QXppwK1/npyFsHWqFSj
         2hzg==
X-Gm-Message-State: AOAM533tO/Jn+1CLGPJ4aEtSTn4z2R9AA3ZxzwGMXEbDu3DjmvnWiJGp
        H/Nz1yJBCT/oiv/q+moGaoj4dIeZiLHQi0Ba
X-Google-Smtp-Source: ABdhPJytdmFsLGnTLL0P73IvTVz9f64fq01MghFbTlh/LJ4WCjvtWBN5bTLeOdYBFetKtNxOeOZ3pA==
X-Received: by 2002:adf:f307:0:b0:207:b0b5:999b with SMTP id i7-20020adff307000000b00207b0b5999bmr2468398wro.694.1650112491232;
        Sat, 16 Apr 2022 05:34:51 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id z6-20020a056000110600b00207aa9eec98sm6022430wrw.30.2022.04.16.05.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 05:34:50 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     cogoni.guillaume@gmail.com
Cc:     Matthieu.Moy@univ-lyon1.fr, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org,
        guillaume.cogoni@gmail.com, shaoxuan.yuan02@gmail.com
Subject: [PATCH v1 1/1] Documentation/ToolsOnGit.txt: gather information about tools
Date:   Sat, 16 Apr 2022 14:34:33 +0200
Message-Id: <20220416123433.28391-2-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416123433.28391-1-cogoni.guillaume@gmail.com>
References: <CAA0Qn1tZxGR0cUi2JSJtTFYe2Nk9xoGuHkruji1-53-Fhokmig@mail.gmail.com>
 <20220416123433.28391-1-cogoni.guillaume@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This document aims to gather tools that have a README and/or scripts in
the GIT project in order to simplify the search of information for a
particular tool.

Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 Documentation/Makefile       |  1 +
 Documentation/ToolsOnGit.txt | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 Documentation/ToolsOnGit.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 44c080e3e5..2fd73078f7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -93,6 +93,7 @@ SP_ARTICLES += $(API_DOCS)
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
+TECH_DOCS += ToolsOnGit
 TECH_DOCS += technical/bundle-format
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
diff --git a/Documentation/ToolsOnGit.txt b/Documentation/ToolsOnGit.txt
new file mode 100644
index 0000000000..a33b369a06
--- /dev/null
+++ b/Documentation/ToolsOnGit.txt
@@ -0,0 +1,35 @@
+Tools on GIT
+============
+:sectanchors:
+
+[[summary]]
+== Summary
+
+This document aims to gather tools that have a README and/or scripts in
+the GIT project.
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
+In particular, this script enables using the VS Code visual debugger, including
+setting breakpoints, logpoints, conditional breakpoints and more in the editor.
+
+[[emacs]]
+=== Emacs
+
+See contrib/emacs/README for more information.
-- 
2.25.1

