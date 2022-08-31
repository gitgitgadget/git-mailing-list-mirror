Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DF3ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiHaQJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiHaQJK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:09:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED489A61F1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:09:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k9so18953077wri.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=T6B36VGkHoEy8o2VMzAMXfZN/Cqvj4n2fspFc3eA4Co=;
        b=oYZglVE+k+DWH8IXJOs7RP/3ZfbMy6zvQPxpsp1clghDwHYT8FVgG4cO2Y6J9zxHiN
         Dg0hsHk+7r0aizZYEkcwCbtQE9Jh3MMKPoO4P3R7uJOuaahkxRueX4cCZJ1dGAsPwV5K
         6Q8IxQnJmJQeaEEZAP3TES2ODqJrjSKgeJZ3u8ftyuxormVomyZkTtMtsPbrLE0iR4HY
         rZXJYKca033g0zhSB9zndov+zHEl0jSdVSjksb0C1hOhrDGlO1OQj3Uk/qlVgjZBZomW
         xQKh2eatPy0VnCWxje8ZcBEqH5Xvp9N29ul6onUtGrH79QWUkyO79BVy3LvMVFGZzcYP
         BeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=T6B36VGkHoEy8o2VMzAMXfZN/Cqvj4n2fspFc3eA4Co=;
        b=upjLU2XNqXDSwoI9u3vNcTjU+DQb1AoGUHlLKPE4WQPV5CJKQjrNCbFFpSKEU2vyfH
         14CGV+VqGdaXN/OJEBZDeQsf4oAZCBkOiS8lh5KagzE+0uyEamLTDr+d9hYhxFFOwo+6
         ILEZNYXOvMsn4E5iSYKVmWABBvvdnQc3kIEsLy3L3lRju0mTy8FJvdycuV26S1YL7iHi
         OstQEw/AhMeb5PskvSHjzZGbDvlFo8tm+xwQQwam8E4Rha8K2QugUZnTtNBGCudIWmp2
         nkb5ZUVrMPeUuONaMFqTRF1MQmbIruQS+PUWPajc3a21jSyhQqLoJYyrHB2Xgda44wDy
         Jwgw==
X-Gm-Message-State: ACgBeo3IrusrwWiuR7sYasVu4/KyLXFcpYikgAom19KxLE4D9noK0nXZ
        mh4Szj0ZldXKZtEiBTdOAS5JvG2qBjE=
X-Google-Smtp-Source: AA6agR66u670MUdC0ioxXtRcIdE7rjBUNk4h5Ue9SOODG/LyUu7dmSGlQb6CJr3Y20ZP2D+H6AiSxA==
X-Received: by 2002:a5d:6e8c:0:b0:225:5f3f:1d8f with SMTP id k12-20020a5d6e8c000000b002255f3f1d8fmr12981273wrz.610.1661962147197;
        Wed, 31 Aug 2022 09:09:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b003a32297598csm2807651wmq.43.2022.08.31.09.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:09:05 -0700 (PDT)
Message-Id: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:09:00 +0000
Subject: [PATCH v4 0/4] fsmonitor: option to allow fsmonitor to run against network-mounted repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cc: Johannes Schindelin Johannes.Schindelin@gmx.de cc: Jeff Hostetler
git@jeffhostetler.com cc: Eric Sunshine sunshine@sunshineco.com cc: Torsten
Bögershausen tboegi@web.de

Allow fsmonitor to run against network-mounted repos on macOS.

There are four parts to this effort:

 1. Introduce two new configuration options
    
    fsmonitor.allowRemote - setting this to true overrides fsmonitor's
    default behavior of erroring out when enountering network file systems.
    Additionly, when true, the Unix domain socket (UDS) file used for IPC is
    located in $HOME rather than in the .git directory.
    
    fsmonitor.socketDir - allows for the UDS file to be located anywhere the
    user chooses rather $HOME.

 2. Using the values of above configuration options, locate the UDS file in
    the desired location with a unique name based on the SHA1 of the path of
    the .git folder.

 3. Ensure that both the working directory (.git directory) and the UDS file
    location are compatible with fsmonitor

 4. Normalize the paths returned by FSEvents to the real path for each
    affected file or directory

Eric DeCosta (4):
  fsmonitor: add two new config options, allowRemote and socketDir
  fsmonitor: generate unique Unix socket file name in the desired
    location
  fsmonitor: ensure filesystem and unix socket filesystem are compatible
  fsmonitor: normalize FSEvents event paths to the real path

 compat/fsmonitor/fsm-listen-darwin.c   | 11 ++--
 compat/fsmonitor/fsm-settings-darwin.c | 72 +++++++++++++++++++-------
 fsmonitor-ipc.c                        | 40 ++++++++++++--
 fsmonitor-ipc.h                        |  6 +++
 fsmonitor-settings.c                   | 67 +++++++++++++++++++++++-
 fsmonitor-settings.h                   |  4 ++
 6 files changed, 172 insertions(+), 28 deletions(-)


base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v3:

 1:  cd16d8bb3d6 ! 1:  836a791e6b7 fsmonitor: macOS: allow fsmonitor to run against network-mounted repos
     @@ Metadata
      Author: Eric DeCosta <edecosta@mathworks.com>
      
       ## Commit message ##
     -    fsmonitor: macOS: allow fsmonitor to run against network-mounted repos
     +    fsmonitor: add two new config options, allowRemote and socketDir
      
     -    Follow-on to the work done to allow Windows to work against
     -    network-mounted repos. Have macOS take advantage of the same
     -    configuration option, 'fsmonitor.allowRemote' that was introduced for
     -    Windows. Setting this option to true will override the default behavior
     -    (erroring-out) when a network-mounted repo is detected by fsmonitor.
     +    Introduce two new configuration options
      
     -    The added wrinkle being that the Unix domain socket (UDS) file used for
     -    IPC cannot be created in a network location; instead $HOME is used if
     -    'fsmonitor.allowRemote' is true.
     +       fsmonitor.allowRemote - setting this to true overrides fsmonitor's
     +       default behavior of erroring out when enountering network file
     +       systems. Additionly, when true, the Unix domain socket (UDS) file
     +       used for IPC is located in $HOME rather than in the .git directory.
      
     -    If $HOME is in a network location, allow the user to override this via
     -    the 'fsmonitor.socketDir' configuration option. There the user can
     -    specify any local directory for the location of the UDS file.
     +       fsmonitor.socketDir - allows for the UDS file to be located
     +       anywhere the user chooses rather $HOME.
      
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
     - ## fsmonitor-ipc.c ##
     -@@
     - #include "cache.h"
     --#include "fsmonitor.h"
     --#include "simple-ipc.h"
     - #include "fsmonitor-ipc.h"
     -+#include "fsmonitor-settings.h"
     - #include "run-command.h"
     - #include "strbuf.h"
     - #include "trace2.h"
     -@@ fsmonitor-ipc.c: int fsmonitor_ipc__is_supported(void)
     - 	return 1;
     - }
     - 
     --GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
     -+GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
     -+
     -+const char *fsmonitor_ipc__get_path(void)
     -+{
     -+#ifdef WIN32
     -+	return fsmonitor_ipc__get_default_path();
     -+#else
     -+	char *retval;
     -+	SHA_CTX sha1ctx;
     -+	const char *git_dir;
     -+	const char *sock_dir;
     -+	struct strbuf ipc_file = STRBUF_INIT;
     -+	unsigned char hash[SHA_DIGEST_LENGTH];
     -+
     -+	if (fsm_settings__get_allow_remote(the_repository) < 1)
     -+		return fsmonitor_ipc__get_default_path();
     -+
     -+	git_dir = get_git_dir();
     -+	sock_dir = fsm_settings__get_socket_dir(the_repository);
     -+
     -+	SHA1_Init(&sha1ctx);
     -+	SHA1_Update(&sha1ctx, git_dir, strlen(git_dir));
     -+	SHA1_Final(hash, &sha1ctx);
     -+
     -+	if (sock_dir && *sock_dir)
     -+		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
     -+					sock_dir, hash_to_hex(hash));
     -+	else
     -+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
     -+	retval = interpolate_path(ipc_file.buf, 1);
     -+	if (!retval)
     -+		die(_("Invalid path: %s"), ipc_file.buf);
     -+	strbuf_release(&ipc_file);
     -+	return retval;
     -+#endif
     -+}
     - 
     - enum ipc_active_state fsmonitor_ipc__get_state(void)
     - {
     -
     - ## fsmonitor-ipc.h ##
     -@@ fsmonitor-ipc.h: int fsmonitor_ipc__is_supported(void);
     -  */
     - const char *fsmonitor_ipc__get_path(void);
     - 
     -+/*
     -+ * Returns the pathname to the default IPC named pipe or Unix domain
     -+ * socket.
     -+ */
     -+const char *fsmonitor_ipc__get_default_path(void);
     -+
     - /*
     -  * Try to determine whether there is a `git-fsmonitor--daemon` process
     -  * listening on the IPC pipe/socket.
     -
       ## fsmonitor-settings.c ##
      @@
       struct fsmonitor_settings {
 -:  ----------- > 2:  2cb026a6317 fsmonitor: generate unique Unix socket file name in the desired location
 2:  f977d140afa ! 3:  a3110f1e25a Check working directory and Unix domain socket file for compatability
     @@
       ## Metadata ##
     -Author: edecosta <edecosta@mathworks.com>
     +Author: Eric DeCosta <edecosta@mathworks.com>
      
       ## Commit message ##
     -    Check working directory and Unix domain socket file for compatability
     +    fsmonitor: ensure filesystem and unix socket filesystem are compatible
      
          Perform separate checks for the working directory and Unix domain socket
          (UDS) file location. The working directory may be located on a
     @@ Commit message
          file may never be located on a network-mounted file system; additionally
          it may not be located on FAT32 or NTFS file systems.
      
     -    Signed-off-by: edecosta <edecosta@mathworks.com>
     +    Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
       ## compat/fsmonitor/fsm-settings-darwin.c ##
      @@
 -:  ----------- > 4:  56cabf3be3b fsmonitor: normalize FSEvents event paths to the real path

-- 
gitgitgadget
