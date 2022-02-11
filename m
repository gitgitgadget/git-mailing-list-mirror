Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8638AC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353542AbiBKU4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:56:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353503AbiBKU42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED380D50
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j26so6338276wrb.7
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cxn94b9+BXwP0HTyGZGmnORL0oTSSi74BHhQLepsYWQ=;
        b=GY+4Ynl0sue1Mo28pGYrNUsQEf1ipl00/P5ZwBnFPWJWDX3UkZRGhcStlH+DWpcYNk
         jSd4dkTjPfGGDKUEyH9r4sQuGo5aJkTnh33HLDFOEGHaApdUBbhzFNCHr7FEa3nDGUE6
         LW9cNgN27HWTDPv4hSQnrI/j3Hhm6pKExjvHtjmlfohRS7yIjfgve+ZPHpBKTp9/+RvB
         nEomximg/ng3YGrFmZyxufSXG6aX6nkJzPwmBnnnUfgORlHjAri2naFJk5N2qToqdF+g
         JPLgvu7OvgTS+pGPvFlzGqLD12RMIJM0cTv17DgG6jLzTjIMvLCkgkaBzbv5ZqQdAVmt
         iwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cxn94b9+BXwP0HTyGZGmnORL0oTSSi74BHhQLepsYWQ=;
        b=ab7HppNKw/UFfXfMjMo5jPagrA2a2O1ZlLAo1CqFcWgAq9IxSvRWdWLCu2f9XDIGy4
         e2FAMCR2p1KBT4IG8TzB3dt1oBOvtNMecDLqMZrgLwX2nZGD46fDrMRZlQXAvGHctc2c
         JTS3AQgJXlGVVt6VVNhe1V2QVKhk8wxsOBy3R8cpbTMnH8X36kH5WSt7DHS9lQ6ZJx6z
         A8E3CrTLle+19yCqG+lX0aFu7w4XC1ekcyCbwtj5RnWe+SBG0jm2+9xO+xsG4NuBpOIz
         exx+3GYxexs8OkFvFZZIZEvflfwiUwRv6W/RxTLQQLbdwzd6jfIzK23UzYXQddMOMhSk
         mLEg==
X-Gm-Message-State: AOAM532C2wRNTx87x9A2X8xfENTLS6TZMkJl12nj1DBq/Y5eLeusHXXm
        T4hI11yA5RJhjjJaWmGaQaAqfm1sPPM=
X-Google-Smtp-Source: ABdhPJw3BeQg0QkAhBehBonga0vU14iOl5m9But3BXih4R5rIrjIdnL+h5mTFLyqkOpZB4I45dvEVg==
X-Received: by 2002:adf:d1c7:: with SMTP id b7mr2680072wrd.370.1644612985262;
        Fri, 11 Feb 2022 12:56:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm4679124wmk.16.2022.02.11.12.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:24 -0800 (PST)
Message-Id: <49e4c146e02002f9b0af8c3f4db15706041e7b95.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:55:54 +0000
Subject: [PATCH v5 05/30] fsmonitor: document builtin fsmonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Document how `core.fsmonitor` can be set to a boolean to enable
or disable the builtin FSMonitor.

Update references to `core.fsmonitor` and `core.fsmonitorHookVersion` and
pointers to `Watchman` to refer to it.

Create `git-fsmonitor--daemon` manual page and describe its features.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config/core.txt           | 46 ++++++++++-----
 Documentation/git-fsmonitor--daemon.txt | 75 +++++++++++++++++++++++++
 Documentation/git-update-index.txt      |  8 ++-
 3 files changed, 112 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..86059dc7b88 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -62,22 +62,40 @@ core.protectNTFS::
 	Defaults to `true` on Windows, and `false` elsewhere.
 
 core.fsmonitor::
-	If set, the value of this variable is used as a command which
-	will identify all files that may have changed since the
-	requested date/time. This information is used to speed up git by
-	avoiding unnecessary processing of files that have not changed.
-	See the "fsmonitor-watchman" section of linkgit:githooks[5].
+	If set to true, enable the built-in file system monitor
+	daemon for this working directory (linkgit:git-fsmonitor--daemon[1]).
++
+Like hook-based file system monitors, the built-in file system monitor
+can speed up Git commands that need to refresh the Git index
+(e.g. `git status`) in a working directory with many files.  The
+built-in monitor eliminates the need to install and maintain an
+external third-party tool.
++
+The built-in file system monitor is currently available only on a
+limited set of supported platforms.  Currently, this includes Windows
+and MacOS.
++
+	Otherwise, this variable contains the pathname of the "fsmonitor"
+	hook command.
++
+This hook command is used to identify all files that may have changed
+since the requested date/time. This information is used to speed up
+git by avoiding unnecessary scanning of files that have not changed.
++
+See the "fsmonitor-watchman" section of linkgit:githooks[5].
 
 core.fsmonitorHookVersion::
-	Sets the version of hook that is to be used when calling fsmonitor.
-	There are currently versions 1 and 2. When this is not set,
-	version 2 will be tried first and if it fails then version 1
-	will be tried. Version 1 uses a timestamp as input to determine
-	which files have changes since that time but some monitors
-	like watchman have race conditions when used with a timestamp.
-	Version 2 uses an opaque string so that the monitor can return
-	something that can be used to determine what files have changed
-	without race conditions.
+	Sets the protocol version to be used when invoking the
+	"fsmonitor" hook.
++
+There are currently versions 1 and 2. When this is not set,
+version 2 will be tried first and if it fails then version 1
+will be tried. Version 1 uses a timestamp as input to determine
+which files have changes since that time but some monitors
+like Watchman have race conditions when used with a timestamp.
+Version 2 uses an opaque string so that the monitor can return
+something that can be used to determine what files have changed
+without race conditions.
 
 core.trustctime::
 	If false, the ctime differences between the index and the
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
new file mode 100644
index 00000000000..0fedf5a4565
--- /dev/null
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -0,0 +1,75 @@
+git-fsmonitor--daemon(1)
+========================
+
+NAME
+----
+git-fsmonitor--daemon - A Built-in File System Monitor
+
+SYNOPSIS
+--------
+[verse]
+'git fsmonitor--daemon' start
+'git fsmonitor--daemon' run
+'git fsmonitor--daemon' stop
+'git fsmonitor--daemon' status
+
+DESCRIPTION
+-----------
+
+A daemon to watch the working directory for file and directory
+changes using platform-specific file system notification facilities.
+
+This daemon communicates directly with commands like `git status`
+using the link:technical/api-simple-ipc.html[simple IPC] interface
+instead of the slower linkgit:githooks[5] interface.
+
+This daemon is built into Git so that no third-party tools are
+required.
+
+OPTIONS
+-------
+
+start::
+	Starts a daemon in the background.
+
+run::
+	Runs a daemon in the foreground.
+
+stop::
+	Stops the daemon running in the current working
+	directory, if present.
+
+status::
+	Exits with zero status if a daemon is watching the
+	current working directory.
+
+REMARKS
+-------
+
+This daemon is a long running process used to watch a single working
+directory and maintain a list of the recently changed files and
+directories.  Performance of commands such as `git status` can be
+increased if they just ask for a summary of changes to the working
+directory and can avoid scanning the disk.
+
+When `core.fsmonitor` is set to `true` (see linkgit:git-config[1])
+commands, such as `git status`, will ask the daemon for changes and
+automatically start it (if necessary).
+
+For more information see the "File System Monitor" section in
+linkgit:git-update-index[1].
+
+CAVEATS
+-------
+
+The fsmonitor daemon does not currently know about submodules and does
+not know to filter out file system events that happen within a
+submodule.  If fsmonitor daemon is watching a super repo and a file is
+modified within the working directory of a submodule, it will report
+the change (as happening against the super repo).  However, the client
+will properly ignore these extra events, so performance may be affected
+but it will not cause an incorrect result.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 2853f168d97..53ea48a04e2 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -498,7 +498,9 @@ FILE SYSTEM MONITOR
 This feature is intended to speed up git operations for repos that have
 large working directories.
 
-It enables git to work together with a file system monitor (see the
+It enables git to work together with a file system monitor (see
+linkgit:git-fsmonitor--daemon[1]
+and the
 "fsmonitor-watchman" section of linkgit:githooks[5]) that can
 inform it as to what files have been modified. This enables git to avoid
 having to lstat() every file to find modified files.
@@ -509,8 +511,8 @@ looking for new files.
 
 If you want to enable (or disable) this feature, it is easier to use
 the `core.fsmonitor` configuration variable (see
-linkgit:git-config[1]) than using the `--fsmonitor` option to
-`git update-index` in each repository, especially if you want to do so
+linkgit:git-config[1]) than using the `--fsmonitor` option to `git
+update-index` in each repository, especially if you want to do so
 across all repositories you use, because you can set the configuration
 variable in your `$HOME/.gitconfig` just once and have it affect all
 repositories you touch.
-- 
gitgitgadget

