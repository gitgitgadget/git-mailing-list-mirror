Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5D1C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40873610EA
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhJMUeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhJMUd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 16:33:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20658C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 13:31:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i12so12339474wrb.7
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rgNztFjSIfkFrumoWBCPgDcO19sT/SrE7dYPYozTBh8=;
        b=gSqz708Sj7ksvbm133sxKGlCtPvtMNZBFVsAHD16/KuE5IaTNFd1zsJrCc0BfyBEQy
         QqRAkMOxDZ0xzpeiqCrGuwLibqEWbkgDgPsu5Tap6nKhonKd9+Dv5WyMMjX3xg9mxQiP
         aBGpcdoFQcbzAlre+xySP3NhjxcaIUET8x+U6BPuqvLpzj531+Iw2t9dONZ6pdIouw2b
         siuu4Vxe9jM+2dX69OTTlbu9U4r1xWrWuvbcf3hNieWvklVwpnYouycVms63CNzqdfV1
         6QgOPwshWpAS/ZIBoDgaclteXYOKXutO7nVEXZ8wJiHQz5hm6r3P5L1FpfhfmGqtDOxt
         a/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rgNztFjSIfkFrumoWBCPgDcO19sT/SrE7dYPYozTBh8=;
        b=zSJ+OZ9k559aBoB/R4nZMOODR0mNIQAI2/5Acqfap+y5xp5bHUDUUKlSemjKMoeO6O
         3QA3xfQjWwDazrHg1YFicS/2f4iZRs6L3ty73LB/5a6FntwfhBfctFOJM06ejMmiHQTS
         TexgLSb+cWBTi9Iz0nl4WGpwHLLX2N4YkbYeVJ9SvVh/J1nlZnenOvDH/pjhMWlLiZ5l
         FRFvZdwjRfzA8wGFbGVMQLtoI+RnDS9R+Qw3Vyf/CMDG0PtNJcdFhZxgxct/AOxU0XPN
         T/XN4wBjAshb6BJbGyEtXoTwmx4kBcCTeBZycbTo3gsjtBu22WkRq05Gpw2B8tfxJDl9
         651A==
X-Gm-Message-State: AOAM531FUCINJyozfMMwuCPBzlDYrgIhvCFJUeTcI4YSyYBgNL+nDW6h
        tUQ4R3fCsAJGL9TnM1j+Q8AVNJBkSlk=
X-Google-Smtp-Source: ABdhPJytTTdre9lJ+DdksX3qOBBrDhLCxf9K8rquFIE+ltfl5E+ESk1ExF3jUeFyNsly6LQcma7r+A==
X-Received: by 2002:a05:600c:3b1a:: with SMTP id m26mr14528786wms.130.1634157111728;
        Wed, 13 Oct 2021 13:31:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5sm488827wrq.86.2021.10.13.13.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 13:31:51 -0700 (PDT)
Message-Id: <45a86cef8d75911e3448dc9e3cb3d4f7c0ee76a0.1634157108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
        <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Oct 2021 20:31:47 +0000
Subject: [PATCH v3 5/5] fsmonitor: update fsmonitor config documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
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
