Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BCC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240030AbiCVSCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiCVSB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:01:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08A365830
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r64so11807837wmr.4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C/9cpq+/7LFgJqbFs52lTGJrXKzcUu9HQhf3f89AGVk=;
        b=bADyA8y8CJCIa5rkEMmRqt4r9+Irn3G9Jbnb+xPkGrvcj+kQ5qpmqCRSP0u7owvxGu
         eATMZhcGgo34dGHZK8aEm/iGxvVoCdOtga2dgNoeSOm4egZlMYQ5cKdbJs4J6Lcjwih6
         iCPRP1AB7R+Vsl5JYKH7TWOsY9ouQcJmYdtcwIMlz7iDlGIsg7mbWbzF6nGYcBUsRwE5
         PB4aN9D2a4Hj1tMl2zqPlScaBnfVcb1S2YeVv/KfhJ7IlGmfmYQVR0a29sR9TMWgUWMA
         47VDHFS+X3JvGXZeYYi3Kd1KXpGPkSYUmAAXmqtS71EfA3gvkFmZq/SRSTQ9BlATJTL2
         bQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C/9cpq+/7LFgJqbFs52lTGJrXKzcUu9HQhf3f89AGVk=;
        b=vlzO3UfMX8b+CC+itiLvThyEHKyAfT0ZYAyae33OGyehMTWCiD1n5YEWeZKKpitmpS
         +9In9XI1UBCxnbbXr/1j9j6GKaMC7b3jMmmIWe2RNx+YRWTHnDuWNG+Kv4B4dGZ1x272
         cPxks8U4aKcbADAE9X8zlv6T3Tak7nQ7XBnDNI2sSmGqXfLT5bZbolTCvhcJ4ekTCuRi
         UaqCmayBM6pigF7gktO8VUs3nH/yVX8YuwnC20kmLbSBYB6LQpJ2k/goTe6Haf212j9a
         vAvqK/EsoEmkNUnoh8ox67cFW7MsR5a9mLASb40F251zXcEUYKD/CK74M72DZ5VByY98
         CF4A==
X-Gm-Message-State: AOAM533Z0Gqc8l3VTAoBUS7ka7Gq/YfSFooVVA9+fnM4LjmjWUivyqWZ
        9Mj4zaROPyAGtE0Z0j9Hg1RP4FyJh/c=
X-Google-Smtp-Source: ABdhPJxX0eTWRG/AtAWbpnQCB2uHGr5MskclJTF4HNKDlBGXrT83OUYXzq+wNg94r5/5no2UMkYV0w==
X-Received: by 2002:a05:600c:3b15:b0:38c:6cae:ff2 with SMTP id m21-20020a05600c3b1500b0038c6cae0ff2mr5046896wms.175.1647972024203;
        Tue, 22 Mar 2022 11:00:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15-20020a05600015cf00b00203e324347bsm17502452wry.102.2022.03.22.11.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:23 -0700 (PDT)
Message-Id: <6ab7db9cb769fe44db2c76e82da0b5d898538ec0.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:46 +0000
Subject: [PATCH v7 05/29] fsmonitor: document builtin fsmonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/core.txt           | 60 +++++++++++++++-----
 Documentation/git-fsmonitor--daemon.txt | 75 +++++++++++++++++++++++++
 Documentation/git-update-index.txt      |  8 ++-
 3 files changed, 126 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..6303c36c7ed 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -62,22 +62,54 @@ core.protectNTFS::
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
++
+Note that if you concurrently use multiple versions of Git, such
+as one version on the command line and another version in an IDE
+tool, that the definition of `core.fsmonitor` was extended to
+allow boolean values in addition to hook pathnames.  Git versions
+2.35.1 and prior will not understand the boolean values and will
+consider the "true" or "false" values as hook pathnames to be
+invoked.  Git versions 2.26 thru 2.35.1 default to hook protocol
+V2 and will fall back to no fsmonitor (full scan).  Git versions
+prior to 2.26 default to hook protocol V1 and will silently
+assume there were no changes to report (no scan), so status
+commands may report incomplete results.  For this reason, it is
+best to upgrade all of your Git versions before using the built-in
+file system monitor.
 
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

