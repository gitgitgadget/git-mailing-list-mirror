Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0290CC433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 23:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiKPXYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 18:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiKPXXt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 18:23:49 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA4815FE2
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:23:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id cl5so32757861wrb.9
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi1JhA2Y49B3vsv8LyQZ/nUzDuStw5WBLGMA8BZqLVA=;
        b=C5T8pHiLL8cAN0bQMd1DrprPJ66jl9nwZuOH7Y9y8Rr8jUUbZEJNsQg6XUXP8POyNa
         dXrijQ8FyQOFbcbBjIpI1prHE1NtyFxBlZjUw2rd4LB0t/bqPmOYQXh4Lyuulc+f04tF
         achejw1sLRVAmqiQOY+QRKoA45PBmNsO2/uU2ovjXuEwfH4v6wWevLycEbpMEGwtfGFA
         3hDOwuve4dMIkFQKJz06eeWFSrjIdqxytmD+XEesZRTy3CU7AXpp3c3W5jLKQJnA1OTX
         QfE9L/c924SFlVYjHdL14htk0uUSKZh3K5bbWdrakAC+jwFekKj+zwq2BP6V81lF/T04
         PitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi1JhA2Y49B3vsv8LyQZ/nUzDuStw5WBLGMA8BZqLVA=;
        b=o2nn8T4Eh7sAdP/W06Ez8psYrikmE7Wu7vS5PBljwQXiELPUuIUdu7tgNUkyAQ5ISK
         XUuP01VjvHIBcVumlMEmzE79Ibo4sY8LFsBQe7PLG+y9E6JslJ8k0/ip16ZH2kPcDq6D
         O+IUAA6qXcvxnDpjt/ONdPJSdZKIDn3S/y5NM/rKiFoZl1WeDP+FeiSr9679Iuf0RmZq
         C1UE+fKGmtzF5qemKvlKa3GcbzRAFlyINS4txVMjjP85Y+E1zoEYN+Lmy404PF8MjQaz
         Ll6NEsRkV3Pz6ilCkb8kfkvEoXvsnwmvOI3WeZ1wJSU+Z4QOiyVckJXYMETH1bmmy6c0
         cv6g==
X-Gm-Message-State: ANoB5pkATj+7wM1NqmmXWhISzKMnjsAj/Nd7RchUVDU13dnriFGwwezb
        r+A1eALDd2rz/CFLx3gDzR1paU6wfSc=
X-Google-Smtp-Source: AA0mqf6f2J+k/6goWA0wJFD5zZcJmsrCXGTC1LmPQIUgBkaBdRCW3XsSNMPqgZiGQkJj3t5HpJ5eSw==
X-Received: by 2002:a05:6000:152:b0:22e:34c2:c6f0 with SMTP id r18-20020a056000015200b0022e34c2c6f0mr14885692wrx.232.1668641026033;
        Wed, 16 Nov 2022 15:23:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d458e000000b0022eafed36ebsm16184223wrq.73.2022.11.16.15.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:23:45 -0800 (PST)
Message-Id: <f56175e097a6cf08b0a5c87cd1524062437c4db0.1668641019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 23:23:39 +0000
Subject: [PATCH v3 6/6] fsmonitor: update doc for Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Update the documentation for Linux.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Documentation/config/fsmonitor--daemon.txt |  4 ++--
 Documentation/git-fsmonitor--daemon.txt    | 24 ++++++++++++++--------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/fsmonitor--daemon.txt b/Documentation/config/fsmonitor--daemon.txt
index c225c6c9e74..2cafb040d96 100644
--- a/Documentation/config/fsmonitor--daemon.txt
+++ b/Documentation/config/fsmonitor--daemon.txt
@@ -4,8 +4,8 @@ fsmonitor.allowRemote::
     behavior.  Only respected when `core.fsmonitor` is set to `true`.
 
 fsmonitor.socketDir::
-    This Mac OS-specific option, if set, specifies the directory in
+    Mac OS and Linux-specific option. If set, specifies the directory in
     which to create the Unix domain socket used for communication
     between the fsmonitor daemon and various Git commands. The directory must
-    reside on a native Mac OS filesystem.  Only respected when `core.fsmonitor`
+    reside on a native filesystem.  Only respected when `core.fsmonitor`
     is set to `true`.
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index 8238eadb0e1..c2b08229c74 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -76,23 +76,31 @@ repositories; this may be overridden by setting `fsmonitor.allowRemote` to
 correctly with all network-mounted repositories and such use is considered
 experimental.
 
-On Mac OS, the inter-process communication (IPC) between various Git
+On Linux and Mac OS, the inter-process communication (IPC) between various Git
 commands and the fsmonitor daemon is done via a Unix domain socket (UDS) -- a
-special type of file -- which is supported by native Mac OS filesystems,
-but not on network-mounted filesystems, NTFS, or FAT32.  Other filesystems
-may or may not have the needed support; the fsmonitor daemon is not guaranteed
-to work with these filesystems and such use is considered experimental.
+special type of file -- which is supported by many native Linux and Mac OS
+filesystems, but not on network-mounted filesystems, NTFS, or FAT32.  Other
+filesystems may or may not have the needed support; the fsmonitor daemon is not
+guaranteed to work with these filesystems and such use is considered
+experimental.
 
 By default, the socket is created in the `.git` directory, however, if the
 `.git` directory is on a network-mounted filesystem, it will be instead be
 created at `$HOME/.git-fsmonitor-*` unless `$HOME` itself is on a
 network-mounted filesystem in which case you must set the configuration
-variable `fsmonitor.socketDir` to the path of a directory on a Mac OS native
+variable `fsmonitor.socketDir` to the path of a directory on a native
 filesystem in which to create the socket file.
 
 If none of the above directories (`.git`, `$HOME`, or `fsmonitor.socketDir`)
-is on a native Mac OS file filesystem the fsmonitor daemon will report an
-error that will cause the daemon and the currently running command to exit.
+is on a native Linux or Mac OS filesystem the fsmonitor daemon will report
+an error that will cause the daemon to exit and the currently running command
+to issue a warning.
+
+On Linux, the fsmonitor daemon registers a watch for each directory in the
+repository.  The default per-user limit for the number of watches on most Linux
+systems is 8192.  This may not be sufficient for large repositories or if
+multiple instances of the fsmonitor daemon are running.
+See https://watchexec.github.io/docs/inotify-limits.html[Linux inotify limits] for more information.
 
 CONFIGURATION
 -------------
-- 
gitgitgadget
