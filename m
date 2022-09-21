Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E32DECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 22:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiIUWTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiIUWTI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 18:19:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D9A8311
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:18:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so3114567wmb.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=LRAZFpHOU5+ay4ne+GDRmL5kg+GCUi05Q3xa/zAhpco=;
        b=e0n64fhIGf56ID6qnwgrc0nYziYGYJQ2TwOu1TVcWxryIl/Am6F0l7wD8/BA6II1/j
         o7Hj/zRdwQQ/LRonwd3Tjx+jApdRrMRPsuN1A5npGFMAGK8Vcn3nC3TCAE+DY/kOXi1z
         ikGlC3aZKX1TjdUQSlr56JwGVTQZJGjPJRCteFXMixwac059ir6MTLX7JIdxmt9mh3b3
         /LAiv0T2u8Z2TUyNX1J9XWnq0jHnXhPELjhIV/KIlvUSoN9Gk6zfz+Rk+MzubDRpXFz9
         +sDjHWMbhCBHAoG7ueZnbXUby+k/mSt5UVa1XOa2VpHmrgaeLaqxlZFhsf29gjVi0M27
         1uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LRAZFpHOU5+ay4ne+GDRmL5kg+GCUi05Q3xa/zAhpco=;
        b=jxO8BxEo9HlAJHdU4/te5CAuFIov/YdW5sSpoqHs9tXcN1uJrv/EbwScMwP70L2nZD
         elcgO53fwtYniT3uAsPOTSFU/nBe81ChTHrkznubB5uYrXjIw3R0iUFBZLoUn+VdclhB
         wD7OiPX7OzCWD9/+njkGgThLb8AZiJtJ0mw4lNffXwS2UWrm3OmrkvoJlhRXdEeHCA+D
         sqmn3Vp8LIJTyQt28onkeHJePlirCnYiMxTq2qDx7LqFExykOCtg2DplAYan9JkzJHj3
         gSc2hAPfMQGgvHKs42jRkMllarccfdt3tPiMiqruNWh8lz7r6c+iL0qvpnVmubMDt2Ig
         XRbw==
X-Gm-Message-State: ACrzQf0XVxETvtZhRfnRwNNo4fwYFkyZTB3vZ/rYq9QjkYEgZs0Gc0Zc
        W6tSYlLFbgd5mpE9SUn7dMQjc035avM=
X-Google-Smtp-Source: AMsMyM64vOQLJR/W15/5HCepGVHWZU0veUm4RPDSh7DyoeHFrJ+CirB+uKuUEVIDzLPtc2OOWrjqVA==
X-Received: by 2002:a05:600c:3205:b0:3b3:3813:ae3f with SMTP id r5-20020a05600c320500b003b33813ae3fmr264911wmp.158.1663798731487;
        Wed, 21 Sep 2022 15:18:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4-20020a05600c1c8400b003b33943ce5esm4613431wms.32.2022.09.21.15.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:18:50 -0700 (PDT)
Message-Id: <3200b505988d3b46909f7a038a10e0ee9b50ede0.1663798722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
References: <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
        <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Sep 2022 22:18:42 +0000
Subject: [PATCH v11 6/6] fsmonitor: add documentation for allowRemote and
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
