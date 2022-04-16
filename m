Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3290CC433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 12:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiDPMhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiDPMhW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 08:37:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6644B397
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 05:34:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p189so6282492wmp.3
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w0aMmJvP3HHsPp2idYj716O9ruhKlM0TqNo90aOLK5c=;
        b=mnRvOdcnUSWoesBNg8IYGs788bOcT9kN6u8CmAJZGDX+7PNP/eCvRr6ZHK96HMMH7i
         lg1GZnGHMGzP0bDDp9pDg2kVUZDtLxhENNL0DafbVKZwMMHPoroTuImMWfW7wLJ8BBD2
         O+leITkGflFDfeIqMIkyUd3XcX47ugX7WIVHgWlqEya8Nmrh1F05nuLzFYxR9YP8sD1S
         /ye23m93CwPJxiEkMW2XxeRbONWVlubnz2rGtzcyuWhfFqh0YUfKVJpdmeeu5h5dsFsr
         TUoYGyl5imlPmQzakbnSMDL1L4znNyQ5/xgHZjfiCLxYCWlWxekOHy9Pgmv23AEpC7kC
         EdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0aMmJvP3HHsPp2idYj716O9ruhKlM0TqNo90aOLK5c=;
        b=108Cy/bsc461w9/ftmt6F6+asIyf9vRz5DLV1jumsR7M7JfC/fflzgeYEklONDTSx9
         6YjDyyyKoJZ5sgPtd6yIgXR+uyjo0ZxF3I0lfgeafYMA2mRdVEsyB55euRGVsDV/XiNp
         poDNiVQ4ORo4dTTTsIIm5yWhodNBUH6tKb5Wx6QQDyH1eX2NdYq6Avoqsit08bUKN+ye
         0HmPlZ8SMPdRRMPNl3JFLUFkYaTyGOvHk20F9uoweS0fgW6ta0xu7oPAjFRg8Ty8Q+GQ
         NE48NTFuqRFyMj6X9U4b5uTgK3J2vBlrdoceVelGiU+bx+jhpQdB2dI6t/p+bND0dhKn
         4o5Q==
X-Gm-Message-State: AOAM532o0RG68pHt43WlWM4Tdq8YwDIZfYIYOU3Pb36k2UoLblAm5jDi
        cVYUxVaNAWSRf3KYmirKXgw=
X-Google-Smtp-Source: ABdhPJy9M22LWdvHifEcH0QsD8Ke9Kau8ow8OvNM3EyFNpIbpUcsdJLG5tw8/U2l8C1OTnf8NhVKUg==
X-Received: by 2002:a05:600c:154b:b0:38f:f7f4:8139 with SMTP id f11-20020a05600c154b00b0038ff7f48139mr3070666wmg.60.1650112486862;
        Sat, 16 Apr 2022 05:34:46 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id z6-20020a056000110600b00207aa9eec98sm6022430wrw.30.2022.04.16.05.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 05:34:46 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     cogoni.guillaume@gmail.com
Cc:     Matthieu.Moy@univ-lyon1.fr, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org,
        guillaume.cogoni@gmail.com, shaoxuan.yuan02@gmail.com
Subject: [PATCH v1 0/1] Documentation/ToolsOnGit.txt: gather information about tools
Date:   Sat, 16 Apr 2022 14:34:32 +0200
Message-Id: <20220416123433.28391-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAA0Qn1tZxGR0cUi2JSJtTFYe2Nk9xoGuHkruji1-53-Fhokmig@mail.gmail.com>
References: <CAA0Qn1tZxGR0cUi2JSJtTFYe2Nk9xoGuHkruji1-53-Fhokmig@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I decide to change my approach with this patch, and now I agreed at some 
point with <shaoxuan.yuan02@gmail.com>, GIT might not be the right place 
to talk about recommendation for best practice, tools or workflows. 
So, I change the file, it just gathers some links that point to tools 
that have a README or scripts in contrib/.

Now, the idea is more like "Oh, you use this tool? Did you know that we
have a README and some scripts to make it more simple to use along GIT,
it might interest you." (e.g. see contrib/emacs.). It's just informative
and no longer a recommendation.

In addition, having a file that collects this type of information is more
practical that have a tool mention in many files. And I hope that people 
who use other tools other than Emacs or Visual Studio Code, will be 
interesting for doing scripts and README in contrib/.

Thanks and I hope this new approach is better,

COGONI Guillaume

Desmoniak (1):
  Documentation/ToolsOnGit.txt: gather information

 Documentation/Makefile       |  1 +
 Documentation/ToolsOnGit.txt | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 Documentation/ToolsOnGit.txt

Difference between v0 and v1
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 82badee19a..2fd73078f7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -93,7 +93,7 @@ SP_ARTICLES += $(API_DOCS)
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
-TECH_DOCS += WorkingOnGit
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

diff --git a/Documentation/WorkingOnGit.txt b/Documentation/WorkingOnGit.txt
deleted file mode 100644
index d324d9fcd8..0000000000
--- a/Documentation/WorkingOnGit.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-Guide of the best practices and custom workflow
-===============================================
-:sectanchors:
-
-[[summary]]
-== Summary
-
-This book aims to put together a lot of useful tools, best practices and
-custom workflows that might help the Git developer.
-
-[[author]]
-=== Author
-
-The Git community.
-
-[[table_of_contents]]
-== Table of contents
-
-- <<debuggers>>
-
-[[debuggers]]
-== Using debuggers
-
-You'll probably find it useful to use a debugger to interactively inspect
-your code as it's running.
-
-There's numerous such debuggers, and you may even have one installed
-already along with your development toolchain.
-
-The GNU debugger (gdb) is probably the most common one command-line
-debugger, along with the LLDB debugger (lldb):
-
-==== https://www.sourceware.org/gdb/
-==== https://lldb.llvm.org/
-
-=== GUIs
-
-==== Visual Studio Code (VS Code)
-
-The contrib/vscode/init.sh script creates configuration files that enable
-several valuable VS Code features. See contrib/vscode/README.md for more
-information on using the script.
-
-In particular, this script enables using the VS Code visual debugger, including
-setting breakpoints, logpoints, conditional breakpoints in the editor.
-In addition, it includes the ability to see the call stack, the line of code that
-is executing and more. It is possible to visualize the variables and their values
-and change them during execution.
-
-In sum, using the built-in debugger can be particularly helpful to understand
-how Git works internally.
-It can be used to isolate certain parts of code, with this you may be able to ask
-more precises question when you are stuck.

2.25.1

