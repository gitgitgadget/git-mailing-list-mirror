Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CC0C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 21:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJNVqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 17:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJNVp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 17:45:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013F35FDC2
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu30so9544118wrb.8
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZZ/jRI252DzMeVq+3yot+76+uTRZX0nJIDrWhlOFuE=;
        b=Od2uBJ6FRJy+1AZAouOF+wM/gZVGb2DeXZPbq4+/RbDcVWbrEd+PfeqLV7d2vONC8B
         pHbKE9cSw9wA5rXgB6c1mr+twuJGQfnqg3AxQr4n9voYxt+UT9zKZH0GB5Hb9ubPC2Gv
         e8ecZyRIt5aflvWDPdDiPq2sMx1gYhIN9NsarTPPN09pUK8hM29KqBG14c6NNxYD3Aby
         PNMxYsJL3kVznHb5fh8fs4uvjAuUmrL+2F19tYTZ0jmmcRkx2Kd1OmcQnXaoSkbSwpvv
         cOKIUXoic+ipLkTDDXoXuy58+OrUvcX8Y8oB1yiQhEie22muPPQm/a34b0/Oh5wDbJdZ
         DSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZZ/jRI252DzMeVq+3yot+76+uTRZX0nJIDrWhlOFuE=;
        b=DvBI31HLwnQL/ymZCmDAtWKzrXWlZ8s9/X1XKc48/PM6aWRllpIV5nnR5q8F8n9ss9
         p8YXUGQylPXpo4hluRj7e0wmTftCwMnQOUFqpJmZPDzah7i/lWi5G9nIW6gDIVxZcXda
         6dXGjxXEbj7e2embvOGGhkJINJTB5Gko8m0pKP+/tItF02wjxStIjsHyp7s1wEEbvnZQ
         GORpyAzyUcrAs2p03p5bVZ3uTrRKb4UtkiC5TDFmjF7a4FIxw8IhLiRyb6Y1tG2wFUSF
         oj0lTEIlSToJ4jgeqbjmztD0CRkAw4bQ2U244t3nWc2LSYyrarcJAboeyUL0NeBbfjwh
         Rj2A==
X-Gm-Message-State: ACrzQf11WUPuANl2miAVA0COh+X5xTjGPC1xkWFnk4ehNfaB97LGva/Q
        AgPoqlRj0NBwNExzxOMapkRWMRumaJA=
X-Google-Smtp-Source: AMsMyM739lY0EOSTPVlG8+WYE9h2ErH+KIEgXIT8h46Iic+ELCpfoWxCaUa59mxHxak6wBZVtkooqQ==
X-Received: by 2002:a05:6000:1861:b0:232:2471:d405 with SMTP id d1-20020a056000186100b002322471d405mr4658469wri.130.1665783953804;
        Fri, 14 Oct 2022 14:45:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm2982925wma.45.2022.10.14.14.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:45:53 -0700 (PDT)
Message-Id: <9c552239b57fb181189d3c6bb84a648a272cba62.1665783945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 21:45:38 +0000
Subject: [PATCH v2 06/12] fsmonitor: add documentation for allowRemote and
 socketDir options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>,
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

