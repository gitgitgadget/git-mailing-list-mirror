Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACEEC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 17:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJDRdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 13:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJDRcm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 13:32:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34FF21E3C
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 10:32:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id iv17so9358965wmb.4
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=NZZ/jRI252DzMeVq+3yot+76+uTRZX0nJIDrWhlOFuE=;
        b=MRF8KAgDroF6Oze9zzPM+/q2GtlxrcIL4zKLELicacin7L6VuXfHfUTee5LbWD1Wd9
         Z6zlxeZEZdb2ZovttZ/4WQ0vOG8LTh3+2fXqy457xgqGjnnd2ZVkcd4s3SLQh8hg+fl1
         qf5lIYeqwboem9e1sMh2N+NFLR/KM+AOijknjPjmlMt6ok1OaqRAA0f6RFQY+OtoilLX
         P88mCdPGrL27Pe8Pmzz+yYRwdBRlmSBeXqg4HFMlskyLjbxwz9D/sdAB4+LOzjD5EPRY
         AswCk2e0VlKfph+de37Ru0qiPpWWAU1ws7oinMnnjBfQxWWQj5siux6oMzTLPtYYaPOH
         ylWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NZZ/jRI252DzMeVq+3yot+76+uTRZX0nJIDrWhlOFuE=;
        b=fJmEJ9IaXNgHF4jHSucjA3LmGbrLHAZmL4b9xjVIDQ45FTIopCPEufZKta4eZWB+RD
         r/PGhV/X8utftYGBmRWpNIYJgzBMmR/aRJtFc50t3g9ATLPkonwkNf4WiNZIO6eAX4f9
         2ecNhap25Q0NKF/6HvylvAhURoyRl3mkxrnWDJnAY52m+Jhwv4n5z4NdmhI71/GRdA/p
         S8J0i1eBJIZnnxiK/UaSukJsZEnnXmVfQZDnwizrqCOTOxY4yYgUojNvUcz59RpCfobA
         t3IOH0rBYtN829TSdzeYxoI8P9p36bCC2HRU7kvDf/piOD2vCKk7nA9/D4PO8PHsQwwG
         +3+w==
X-Gm-Message-State: ACrzQf0nGmzSm3nkrmBn3CzSvFteO0Fw3XDDSF5j+zAzq7P+O60yY9Up
        vLP2bwgen73YzY/y1y4TGxrZgudczmU=
X-Google-Smtp-Source: AMsMyM6iEKfIBq1phyCTCReQoDsI+3I2K9c5mImziyjGatQTcrNoqsr3mBLMkE8IsQ+0Ac87GKDoEA==
X-Received: by 2002:a05:600c:3b1c:b0:3b4:fef3:6a62 with SMTP id m28-20020a05600c3b1c00b003b4fef36a62mr601481wms.129.1664904758827;
        Tue, 04 Oct 2022 10:32:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm22168114wms.2.2022.10.04.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:32:38 -0700 (PDT)
Message-Id: <af7309745f759532fdb79794289d9e02de0e035c.1664904752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
References: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
        <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 17:32:31 +0000
Subject: [PATCH v15 6/6] fsmonitor: add documentation for allowRemote and
 socketDir options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Add documentation for 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'.
Call-out experimental nature of 'fsmonitor.allowRemote' and limited
filesystem support for 'fsmonitor.socketDir'.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Documentation/config.txt                   |  2 ++
 Documentation/config/fsmonitor--daemon.txt | 11 +++++++
 Documentation/git-fsmonitor--daemon.txt    | 37 ++++++++++++++++++++--
 3 files changed, 47 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/config/fsmonitor--daemon.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5b5b9765699..1e205831656 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -423,6 +423,8 @@ include::config/filter.txt[]
 
 include::config/fsck.txt[]
 
+include::config/fsmonitor--daemon.txt[]
+
 include::config/gc.txt[]
 
 include::config/gitcvs.txt[]
diff --git a/Documentation/config/fsmonitor--daemon.txt b/Documentation/config/fsmonitor--daemon.txt
new file mode 100644
index 00000000000..c225c6c9e74
--- /dev/null
+++ b/Documentation/config/fsmonitor--daemon.txt
@@ -0,0 +1,11 @@
+fsmonitor.allowRemote::
+    By default, the fsmonitor daemon refuses to work against network-mounted
+    repositories. Setting `fsmonitor.allowRemote` to `true` overrides this
+    behavior.  Only respected when `core.fsmonitor` is set to `true`.
+
+fsmonitor.socketDir::
+    This Mac OS-specific option, if set, specifies the directory in
+    which to create the Unix domain socket used for communication
+    between the fsmonitor daemon and various Git commands. The directory must
+    reside on a native Mac OS filesystem.  Only respected when `core.fsmonitor`
+    is set to `true`.
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index cc142fb8612..8238eadb0e1 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -3,7 +3,7 @@ git-fsmonitor{litdd}daemon(1)
 
 NAME
 ----
-git-fsmonitor--daemon - A Built-in File System Monitor
+git-fsmonitor--daemon - A Built-in Filesystem Monitor
 
 SYNOPSIS
 --------
@@ -17,7 +17,7 @@ DESCRIPTION
 -----------
 
 A daemon to watch the working directory for file and directory
-changes using platform-specific file system notification facilities.
+changes using platform-specific filesystem notification facilities.
 
 This daemon communicates directly with commands like `git status`
 using the link:technical/api-simple-ipc.html[simple IPC] interface
@@ -63,13 +63,44 @@ CAVEATS
 -------
 
 The fsmonitor daemon does not currently know about submodules and does
-not know to filter out file system events that happen within a
+not know to filter out filesystem events that happen within a
 submodule.  If fsmonitor daemon is watching a super repo and a file is
 modified within the working directory of a submodule, it will report
 the change (as happening against the super repo).  However, the client
 will properly ignore these extra events, so performance may be affected
 but it will not cause an incorrect result.
 
+By default, the fsmonitor daemon refuses to work against network-mounted
+repositories; this may be overridden by setting `fsmonitor.allowRemote` to
+`true`. Note, however, that the fsmonitor daemon is not guaranteed to work
+correctly with all network-mounted repositories and such use is considered
+experimental.
+
+On Mac OS, the inter-process communication (IPC) between various Git
+commands and the fsmonitor daemon is done via a Unix domain socket (UDS) -- a
+special type of file -- which is supported by native Mac OS filesystems,
+but not on network-mounted filesystems, NTFS, or FAT32.  Other filesystems
+may or may not have the needed support; the fsmonitor daemon is not guaranteed
+to work with these filesystems and such use is considered experimental.
+
+By default, the socket is created in the `.git` directory, however, if the
+`.git` directory is on a network-mounted filesystem, it will be instead be
+created at `$HOME/.git-fsmonitor-*` unless `$HOME` itself is on a
+network-mounted filesystem in which case you must set the configuration
+variable `fsmonitor.socketDir` to the path of a directory on a Mac OS native
+filesystem in which to create the socket file.
+
+If none of the above directories (`.git`, `$HOME`, or `fsmonitor.socketDir`)
+is on a native Mac OS file filesystem the fsmonitor daemon will report an
+error that will cause the daemon and the currently running command to exit.
+
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/fsmonitor--daemon.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget
