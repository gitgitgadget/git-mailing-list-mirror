Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1441C32771
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 19:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiIXTq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 15:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbiIXTqk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 15:46:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C69D5C95F
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 12:46:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t4so2108833wmj.5
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 12:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=LRAZFpHOU5+ay4ne+GDRmL5kg+GCUi05Q3xa/zAhpco=;
        b=eXFC4i9220G958p8Lnj4uVQlFdfQ28vdKCBA4vcsNT99eTB6xk50XfO0fYQn+JYHLg
         SbUDuybE0iEBA3JLVgTTWVUq5pKBsbHLvCszJhvB+2PT3OqTewVu1pyLDT+GkAHeW72J
         W6wW2PxbW27e37pRyvYNkPBN4alg395RwBiOqPFIMH+7YJxRmO0GEijTOnhVkEDeyVJv
         XmL1njk1HzzmiJhRD5Yyk46KiKbUPhEMvy1UYYnsJbKcSUyCE/GrcYEJK0rRDEKG/l2j
         A95VA/IBe9xD2SH9PKWGxEAVqoiPt6ozHFg8595ohDyPOITLWCKIWHnq/ab7Ji3CXG3F
         4HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LRAZFpHOU5+ay4ne+GDRmL5kg+GCUi05Q3xa/zAhpco=;
        b=zZruFTmhG6qEm8tUC8HunLdDKxPh4s/aNRifVDKnUMKErafkaNIE+wsicKjMVqy4sx
         DKkngldbCT4IItABJh5eu3EAWaKVM/0OpF7UsvEtgRszk6DGVODQuonnyMzg6WkwWBtJ
         RsUaUq+sEWYQDf/PwnN1KdQAFBTbILisBO26qB6dGOQl4W7/ULMzEDr3f5VXI5riUwL7
         diAyfGTf4yllsZGWkBuLPWblVpvXnCSBT9fnsaSKF3GZvl6xLVb8qCvNM+5H0Cn674xc
         AS+MtaWMDJpZ5mBlLs8u4GuVrhTk7Ld9Bho7X04DsCutcXFikD/BUZ3KQVSUiLgyrKyh
         dtMQ==
X-Gm-Message-State: ACrzQf0tU4W5adT0VFB0b1jw259XmemwTpMMBuX/JmnVlPQEWSU8Zks6
        coS9ZeQEtpNXGWG0aJqvqGb92HtGi+8=
X-Google-Smtp-Source: AMsMyM6qwUUblzbearLoEUtqaTDKLq5Pd6CYKJ8NJWJZthahDx3AGTadM2sH5s6lfMJtWg228k1SHg==
X-Received: by 2002:a7b:c417:0:b0:3b4:5c94:24c1 with SMTP id k23-20020a7bc417000000b003b45c9424c1mr9773924wmi.86.1664048794608;
        Sat, 24 Sep 2022 12:46:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b003a6a3595edasm6316532wmb.27.2022.09.24.12.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 12:46:33 -0700 (PDT)
Message-Id: <b375b0ac798a673301a09903dcdfb22bedda7393.1664048782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
        <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Sep 2022 19:46:22 +0000
Subject: [PATCH v12 6/6] fsmonitor: add documentation for allowRemote and
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
Call-out experimental nature of 'fsmonitor.allowRemote' and limited file
system support for 'fsmonitor.socketDir'.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Documentation/git-fsmonitor--daemon.txt | 48 +++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index cc142fb8612..6ad3e518ae0 100644
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
@@ -63,13 +63,55 @@ CAVEATS
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
+When `core.fsmonitor` is set to `true` (see linkgit:git-config[1])
+the fsmonitor daemon will pay attention to the following configuration
+variables:
+
+`fsmonitor.allowRemote`::
+	By default, the daemon refuses to work against network-mounted
+	repositories. Setting `fsmonitor.allowRemote` to `true` overrides
+	this behavior.
+
+`fsmonitor.socketDir`::
+    This Mac OS-specific option, if set, specifies the directory in
+    which to create the Unix domain socket used for communication
+    between fsmonitor and various Git commands. The directory must
+    reside on a native Mac OS filesystem as discussed above.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget
