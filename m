Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867FEC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B860611EE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbhJGNzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 09:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241788AbhJGNyw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 09:54:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B55C061760
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 06:52:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r7so19318547wrc.10
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rgNztFjSIfkFrumoWBCPgDcO19sT/SrE7dYPYozTBh8=;
        b=RO88eJ0bPwhlpHbHrEqawWekxqGZf1BpPlv2KcaeZDAecqPVUgfEgt8v9JRTHeGofF
         1aWOoI08a/96nD8tJ/qf0HU6toW9iARr6PRhQmcf1oKZOBJrGgRRijPOCyheYljNd2gK
         e6ITMMQ5iqt829Z4RqX2newYEcL1jFsf+SFjNPTqsxVKoHy2nikZLKEIN+AK37urfmwR
         23cg1pFBAsJMsfmCYgr8nAvISjRJlAuNV4PiudcB+dI9ebXIS+LmMM4WSRrf+M71d3M/
         7/nfMbw61+iPDbUT2P7D1YHlqrsVixBbHDU6//eloiaWhH3cnEErpbmyH0I1NVT9LsvN
         z7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rgNztFjSIfkFrumoWBCPgDcO19sT/SrE7dYPYozTBh8=;
        b=2UWD87aadeFo1Jx0a3XtcDJJDApXqyOkTN1fN+Y2R5li/Zz0gznbCrCqRsKBVFuxSV
         E2QMZDYR37h66sG9/YaSlyqU4TTRgX1G/PBWN1UifRtU3TthnG71LWhtT+VpGUpm106t
         ynzl5Ctmt4v+1EQMo8BWHng/58Oy+gYfT++2+cTl2dn7GhNhQkCqiP2SgJNuYATTx8yA
         MdeWy6rVMNxtdJsxgCbuVLk+VfYXML1gOWYt+HLd+Er7kK0bh6GPj0EafgfoRSz6Ey3n
         wDrBMREYv/oE0OSvDBLOrQrmbJrXuri4HzhF1ot7SWCs0ZwsVml3keGN/rPXiNzgJQyb
         gu0Q==
X-Gm-Message-State: AOAM532m1Xomxp3f5YmjpKkK3CjwAE2gENdmKkhNutCw4UE8o3Bg7SPv
        Kq5cnmDUthoQ8WdDiUze1mejz4hcPCU=
X-Google-Smtp-Source: ABdhPJwac/Ff5t1Fk7ncH9drwmvfd8jW0X9ca6Hs5v/CgskST4phZgnplnIN+0Upsdls8pH2qYs+pg==
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr5543341wrh.131.1633614777332;
        Thu, 07 Oct 2021 06:52:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16sm2683357wrq.39.2021.10.07.06.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 06:52:57 -0700 (PDT)
Message-Id: <7c22ce533776ad0549551024cb9fa87c8b10947e.1633614772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
        <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 13:52:52 +0000
Subject: [PATCH v2 5/5] fsmonitor: update fsmonitor config documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Update references to `core.fsmonitor` and `core.fsmonitorHookVersion` and
pointers to `Watchman` to mention the new `core.useBuiltinFSMonitor`
value.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config/core.txt      | 56 ++++++++++++++++++++++--------
 Documentation/git-update-index.txt | 27 +++++++-------
 Documentation/githooks.txt         |  3 +-
 3 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..4f6e519bc02 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -62,22 +62,50 @@ core.protectNTFS::
 	Defaults to `true` on Windows, and `false` elsewhere.
 
 core.fsmonitor::
-	If set, the value of this variable is used as a command which
-	will identify all files that may have changed since the
-	requested date/time. This information is used to speed up git by
-	avoiding unnecessary processing of files that have not changed.
-	See the "fsmonitor-watchman" section of linkgit:githooks[5].
+	If set, this variable contains the pathname of the "fsmonitor"
+	hook command.
++
+This hook command is used to identify all files that may have changed
+since the requested date/time. This information is used to speed up
+git by avoiding unnecessary scanning of files that have not changed.
++
+See the "fsmonitor-watchman" section of linkgit:githooks[5].
++
+Note: The value of this config setting is ignored if the
+built-in file system monitor is enabled (see `core.useBuiltinFSMonitor`).
 
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
++
+Note: The value of this config setting is ignored if the
+built-in file system monitor is enabled (see `core.useBuiltinFSMonitor`).
+
+core.useBuiltinFSMonitor::
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
+Note: if this config setting is set to `true`, the values of
+`core.fsmonitor` and `core.fsmonitorHookVersion` are ignored.
 
 core.trustctime::
 	If false, the ctime differences between the index and the
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 2853f168d97..c7c31b3fcf9 100644
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
@@ -508,17 +510,18 @@ performance by avoiding the cost of scanning the entire working directory
 looking for new files.
 
 If you want to enable (or disable) this feature, it is easier to use
-the `core.fsmonitor` configuration variable (see
-linkgit:git-config[1]) than using the `--fsmonitor` option to
-`git update-index` in each repository, especially if you want to do so
-across all repositories you use, because you can set the configuration
-variable in your `$HOME/.gitconfig` just once and have it affect all
-repositories you touch.
-
-When the `core.fsmonitor` configuration variable is changed, the
-file system monitor is added to or removed from the index the next time
-a command reads the index. When `--[no-]fsmonitor` are used, the file
-system monitor is immediately added to or removed from the index.
+the `core.fsmonitor` or `core.useBuiltinFSMonitor` configuration
+variable (see linkgit:git-config[1]) than using the `--fsmonitor`
+option to `git update-index` in each repository, especially if you
+want to do so across all repositories you use, because you can set the
+configuration variable in your `$HOME/.gitconfig` just once and have
+it affect all repositories you touch.
+
+When the `core.fsmonitor` or `core.useBuiltinFSMonitor` configuration
+variable is changed, the file system monitor is added to or removed
+from the index the next time a command reads the index. When
+`--[no-]fsmonitor` are used, the file system monitor is immediately
+added to or removed from the index.
 
 CONFIGURATION
 -------------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b51959ff941..b7d5e926f7b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -593,7 +593,8 @@ fsmonitor-watchman
 
 This hook is invoked when the configuration option `core.fsmonitor` is
 set to `.git/hooks/fsmonitor-watchman` or `.git/hooks/fsmonitor-watchmanv2`
-depending on the version of the hook to use.
+depending on the version of the hook to use, unless overridden via
+`core.useBuiltinFSMonitor` (see linkgit:git-config[1]).
 
 Version 1 takes two arguments, a version (1) and the time in elapsed
 nanoseconds since midnight, January 1, 1970.
-- 
gitgitgadget
