Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CCE01F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeHVTbq (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:31:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36850 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeHVTbp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:31:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id c21-v6so1796673lfh.3
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjGQBmGqavTKYi4PvehTdm+FTz7rBo+y8ywHgtxSPiw=;
        b=cqmhgj5mQwMVmqCTnhb08oXhgfHfW/uR6lm/rY+Gof5zaiSdXQLzDGzIdfcenVfwac
         kcIUaDInBRfbR3xZOJYqT6lqVMuddFbKrj0H14HrDcCH8dczyVUQIolldkGFKxhg6oVP
         /LvBtRppxZtvFvvwD7RjIC0lWF565CmHgFuR1vqBZuKBjOihQSCF/6NhpVlgxJQgsyYT
         gPYrQzbumDFBe2mi4jiwh3ZmBuc6YUIT8m2bnxd5VjmZYzG8lN6dnzEYrz4uVS4ETQSC
         gTA3oJRpDCf1majiIF8/e6C/ArhqfG+VsAtsP4/668fryIdbaooQ+ieV/RrLFFuAgpUv
         YXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjGQBmGqavTKYi4PvehTdm+FTz7rBo+y8ywHgtxSPiw=;
        b=fRxMaMLXyjfHYfPVJDJA4GD5LgDPIxOm3hBOuqSv04kmrUSC8jBTK1u8o+Jp8ZJsSf
         UHBq6nef/8lir0J6uMZWCVKFGnVM415GxJvytom3hb2bBD/OrgYP3c2BDneq2LZASkun
         IYncIbCmT1wG4vWHqK2bfEuE5bIvi7WCcbPzEHU/o29Lnv50H4nGcXaoUCfYxLuoTEHz
         G0LBHWJQGkdjfj6R0xdj+RUxNkKHfAR2bzIb3A3FjnYLvwEIIp2e2Lok4ynRuNoOMzt+
         6z9yJO/vz5b7O7IIZOJPXUo+GEdR/vcM1/uUWAOQuxVZdjFmXX3/Bb1QGYTblY4EPrLq
         d4lg==
X-Gm-Message-State: AOUpUlFLayrCeDqmaiWXdl7jBaqHmQzZOXyFaclRAegK70Ilo4GIQjHK
        MM5onyDXiS9pGdwFthySQp4jZr4C
X-Google-Smtp-Source: AA+uWPyXTta3Ccre3JDtk1zOBaOL/sJWxGs88ucxbYsqRKw/bgP/uS9dVu0XlgYakaBGGQkZKOFWuw==
X-Received: by 2002:ac2:4141:: with SMTP id c1-v6mr11774160lfi.11.1534953974393;
        Wed, 22 Aug 2018 09:06:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u86-v6sm375213lfi.90.2018.08.22.09.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:06:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/11] config.txt: move gui part out to a separate file
Date:   Wed, 22 Aug 2018 18:05:59 +0200
Message-Id: <20180822160605.21864-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.335.ga73d156e9c
In-Reply-To: <20180822160605.21864-1-pclouds@gmail.com>
References: <20180822160605.21864-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt     | 58 +-----------------------------------
 Documentation/gui-config.txt | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/gui-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9309695a9e..4b1e9e830d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1740,63 +1740,7 @@ gpg.<format>.program::
 	be used as a legacy synonym for	`gpg.openpgp.program`. The default
 	value for `gpg.x509.program` is "gpgsm".
 
-gui.commitMsgWidth::
-	Defines how wide the commit message window is in the
-	linkgit:git-gui[1]. "75" is the default.
-
-gui.diffContext::
-	Specifies how many context lines should be used in calls to diff
-	made by the linkgit:git-gui[1]. The default is "5".
-
-gui.displayUntracked::
-	Determines if linkgit:git-gui[1] shows untracked files
-	in the file list. The default is "true".
-
-gui.encoding::
-	Specifies the default encoding to use for displaying of
-	file contents in linkgit:git-gui[1] and linkgit:gitk[1].
-	It can be overridden by setting the 'encoding' attribute
-	for relevant files (see linkgit:gitattributes[5]).
-	If this option is not set, the tools default to the
-	locale encoding.
-
-gui.matchTrackingBranch::
-	Determines if new branches created with linkgit:git-gui[1] should
-	default to tracking remote branches with matching names or
-	not. Default: "false".
-
-gui.newBranchTemplate::
-	Is used as suggested name when creating new branches using the
-	linkgit:git-gui[1].
-
-gui.pruneDuringFetch::
-	"true" if linkgit:git-gui[1] should prune remote-tracking branches when
-	performing a fetch. The default value is "false".
-
-gui.trustmtime::
-	Determines if linkgit:git-gui[1] should trust the file modification
-	timestamp or not. By default the timestamps are not trusted.
-
-gui.spellingDictionary::
-	Specifies the dictionary used for spell checking commit messages in
-	the linkgit:git-gui[1]. When set to "none" spell checking is turned
-	off.
-
-gui.fastCopyBlame::
-	If true, 'git gui blame' uses `-C` instead of `-C -C` for original
-	location detection. It makes blame significantly faster on huge
-	repositories at the expense of less thorough copy detection.
-
-gui.copyBlameThreshold::
-	Specifies the threshold to use in 'git gui blame' original location
-	detection, measured in alphanumeric characters. See the
-	linkgit:git-blame[1] manual for more information on copy detection.
-
-gui.blamehistoryctx::
-	Specifies the radius of history context in days to show in
-	linkgit:gitk[1] for the selected commit, when the `Show History
-	Context` menu item is invoked from 'git gui blame'. If this
-	variable is set to zero, the whole history is shown.
+include::gui-config.txt[]
 
 guitool.<name>.cmd::
 	Specifies the shell command line to execute when the corresponding item
diff --git a/Documentation/gui-config.txt b/Documentation/gui-config.txt
new file mode 100644
index 0000000000..d30831a130
--- /dev/null
+++ b/Documentation/gui-config.txt
@@ -0,0 +1,57 @@
+gui.commitMsgWidth::
+	Defines how wide the commit message window is in the
+	linkgit:git-gui[1]. "75" is the default.
+
+gui.diffContext::
+	Specifies how many context lines should be used in calls to diff
+	made by the linkgit:git-gui[1]. The default is "5".
+
+gui.displayUntracked::
+	Determines if linkgit:git-gui[1] shows untracked files
+	in the file list. The default is "true".
+
+gui.encoding::
+	Specifies the default encoding to use for displaying of
+	file contents in linkgit:git-gui[1] and linkgit:gitk[1].
+	It can be overridden by setting the 'encoding' attribute
+	for relevant files (see linkgit:gitattributes[5]).
+	If this option is not set, the tools default to the
+	locale encoding.
+
+gui.matchTrackingBranch::
+	Determines if new branches created with linkgit:git-gui[1] should
+	default to tracking remote branches with matching names or
+	not. Default: "false".
+
+gui.newBranchTemplate::
+	Is used as suggested name when creating new branches using the
+	linkgit:git-gui[1].
+
+gui.pruneDuringFetch::
+	"true" if linkgit:git-gui[1] should prune remote-tracking branches when
+	performing a fetch. The default value is "false".
+
+gui.trustmtime::
+	Determines if linkgit:git-gui[1] should trust the file modification
+	timestamp or not. By default the timestamps are not trusted.
+
+gui.spellingDictionary::
+	Specifies the dictionary used for spell checking commit messages in
+	the linkgit:git-gui[1]. When set to "none" spell checking is turned
+	off.
+
+gui.fastCopyBlame::
+	If true, 'git gui blame' uses `-C` instead of `-C -C` for original
+	location detection. It makes blame significantly faster on huge
+	repositories at the expense of less thorough copy detection.
+
+gui.copyBlameThreshold::
+	Specifies the threshold to use in 'git gui blame' original location
+	detection, measured in alphanumeric characters. See the
+	linkgit:git-blame[1] manual for more information on copy detection.
+
+gui.blamehistoryctx::
+	Specifies the radius of history context in days to show in
+	linkgit:gitk[1] for the selected commit, when the `Show History
+	Context` menu item is invoked from 'git gui blame'. If this
+	variable is set to zero, the whole history is shown.
-- 
2.19.0.rc0.335.ga73d156e9c

