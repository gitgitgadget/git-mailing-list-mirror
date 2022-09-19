Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625F6ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 19:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiISTi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiISTiV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 15:38:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44914056B
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:38:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y5so783134wrh.3
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=LRAZFpHOU5+ay4ne+GDRmL5kg+GCUi05Q3xa/zAhpco=;
        b=nKIE8Qb3Zpl2IFEWcsmUq45lOEcTVZJsqnCTWkmmotQsbFZEAN5AedTbF0YUjDVYNP
         xouFcrPAzFYW8EcA6ydO1rKyecu2R+aI/9esoACZf8KJ9G2yNPd+zc2mrjGNSdAQRj6k
         U/oyUkC0bxCTMZQxsvRrDT0EiXaxqusroOUTvkZY+Y8JfSShFvx8c8HbrhYBeltXrFYX
         UdUFzQ3Lw4/3pm/VrTRWqbt4rv3s2535yn9VBjM09//PAg1i8lvp89wTddOBKdatR0me
         7u2Tut0V3ZyLXsGYyn/nlhKk/pjhq+DV8vlEwrmfFvYMG5Gsn2WiJHuYfTV/ZZnqwo0R
         V4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LRAZFpHOU5+ay4ne+GDRmL5kg+GCUi05Q3xa/zAhpco=;
        b=dLVYUnAAQ51OAK9Gr7leQbBw0avJDJv/5BPHTTIG0/NmJw5AWuuiP8FK38pH7DSUah
         PQgK+masaslfXiI/eRJxvDJTrNTCVk2t/MkEDFHDlQ6Ow7555pYpbM5QJwwTxCK58NX6
         JagfFGru5ry+dl6AKiUOABtk4VrYOJFVShnwCXvjbjtAgIWDR8i7lToEMDb5XledoxS9
         b12r8PA4z1sXatnRhX+QkzO/3Ox37dmJH05qnG8fPj56g6m429yL48Pc0WyLur4w/Yor
         yg5W0j+dx8uNDEovVnUvFirsMksClQmeM5WY8MR1pzT4jW3crOGWM0YnPiGoHPZ+iA18
         I4rg==
X-Gm-Message-State: ACrzQf2bXK+DNR0w3DtCeKlZ74gLTJf4xZUQLpT5qC/Xl/T9N/bR1mTq
        48et5ilXD6ooBVD5Xav30fsAXu5KqLQ=
X-Google-Smtp-Source: AMsMyM7KcniARPhNxvSM85HBXp24WTq1bdoNM1PJ7WWYf6yOGPFFxbKU6/jjTM7mtvyqGkFxckF5TA==
X-Received: by 2002:a5d:5b18:0:b0:22a:fb91:3d6b with SMTP id bx24-20020a5d5b18000000b0022afb913d6bmr5128047wrb.56.1663616283855;
        Mon, 19 Sep 2022 12:38:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003b47b80cec3sm15913484wmq.42.2022.09.19.12.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:38:03 -0700 (PDT)
Message-Id: <0e8ea28acc12850f2a6b347c6bce509beb756d81.1663616277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
References: <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
        <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 19:37:57 +0000
Subject: [PATCH v9 6/6] fsmonitor: add documentation for allowRemote and
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
