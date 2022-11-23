Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97097C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 19:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbiKWTAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiKWTAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 14:00:50 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC2A91C22
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:00:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id x17so17365039wrn.6
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xC8ZZvyVAb/PXhfLFXJgVsX0BOTqFc24j+NxQNOxcPo=;
        b=B973qpdQ4ghNax/NioGkbhRJ6L8N+GDfvZlzON2mP3Zi7UBl7Q6OkFBRffnuMBaZsz
         Q4yPKr6R/26hnZG4imNBle8sIYKyl/l9ILndufLp/lPa6sEvUaZoXUjL7eu98tYCrW2X
         3R5cp5zRMP6cJkkMx0gil8oqfjfzHtD07F4/ApRbAlkNvZ5rcIW320fd3Y9r+Keftmwy
         tYJ2/FfssgI9OH3HvNEc6auFadu22+NDBgA1hfNTxTub3AD1LgPiZthF/RR5/r2RZywA
         0gQCnpaGzXccyGH1ZOCJ6pheFCIW96kZ9YkIhHcT4MYKDI8N+Rs4hpjE/AI0Qdk6gCai
         jiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xC8ZZvyVAb/PXhfLFXJgVsX0BOTqFc24j+NxQNOxcPo=;
        b=4I/OgMV+XvwH8QBFwNh83vGdyHjrtOqNQg5Uv4UZ5ztNfrFDE+EBYIiozqKQzFe8tf
         q0k8PU8PpPDCDps4jywuAj7/ChMWie6oOAGQF/QMaRMgvHY4QAHX+uyNOe1Q9uZr687I
         ieOWpBNz6JqQW3ZDTrapFBzy+mgJs1LfkGpRNbF0hvNAMxkNGHTRT2mlbjxoW3+VJct4
         /yMq25KBF9IimFeGOYIzEJe0SzQK2DsUtFarxPNVuWlzx6u+GefLMYIIHll6Vj06fhr6
         FN+bVJM824mSs5SSG9RBzKnKYzxGf1T+1Y07yV1kZnUA6NlbfkcgtvFqB7Ugfrg6f5nw
         osrw==
X-Gm-Message-State: ANoB5pn/yPAwLfBjyUzfd4hD5UbDZHVN/yQjDZJRQetoj9qB3wF2nekp
        vWZQbRw2/9rPFnUCRRxqVJp6ewK8DRs=
X-Google-Smtp-Source: AA0mqf6JneTvrUxBDOk1eqJrDEfJJjDmcTHc82OK3xVLekzTOZ7qiRwscgzN4AoWN82Ntok9Rw5Mxg==
X-Received: by 2002:adf:e3cd:0:b0:241:bc27:f8b6 with SMTP id k13-20020adfe3cd000000b00241bc27f8b6mr17795553wrm.367.1669230046918;
        Wed, 23 Nov 2022 11:00:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6281000000b0022ae0965a8asm17297705wru.24.2022.11.23.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:00:46 -0800 (PST)
Message-Id: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
References: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Nov 2022 19:00:38 +0000
Subject: [PATCH v4 0/6] fsmonitor: Implement fsmonitor for Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal is to deliver fsmonitor for Linux that is on par with fsmonitor for
Windows and Mac OS.

This patch set builds upon previous work for done for Windows and Mac OS to
implement a fsmonitor back-end for Linux based on the Linux inotify API.
inotify differs significantly from the equivalent Windows and Mac OS APIs in
that a watch must be registered for every directory of interest (rather than
a singular watch at the root of the directory tree) and special care must be
taken to handle directory renames correctly.

More information about inotify:
https://man7.org/linux/man-pages/man7/inotify.7.html

v3 differs from v2:

 * Avoid potential entanglements with GPLv3
 * Classify a reasonable set of filesystems as being remote

v2 differs from v1:

 * Prior work for Windows and Mac OS has been merged to master, reducing the
   patch set from 12 to 6 patches
 * Code review feedback
 * Identified and resolved race condition revealed by CI test system, see
   "Limitations and caveats" regarding monitoring of directory trees from
   the man page, above
 * Apologies for being away from this for so long, but my attention was
   needed elsewhere

v1 differs from v0:

 * Code review feedback
 * Update how and which code can be shared between Mac OS and Linux
 * Increase polling frequency to every 1ms (matches Mac OS)
 * Updates to t7527 to improve test stability

Eric DeCosta (6):
  fsmonitor: prepare to share code between Mac OS and Linux
  fsmonitor: determine if filesystem is local or remote
  fsmonitor: implement filesystem change listener for Linux
  fsmonitor: enable fsmonitor for Linux
  fsmonitor: test updates
  fsmonitor: update doc for Linux

 Documentation/config/fsmonitor--daemon.txt |   4 +-
 Documentation/git-fsmonitor--daemon.txt    |  24 +-
 compat/fsmonitor/fsm-health-linux.c        |  24 +
 compat/fsmonitor/fsm-ipc-darwin.c          |  53 +-
 compat/fsmonitor/fsm-ipc-linux.c           |   1 +
 compat/fsmonitor/fsm-ipc-unix.c            |  52 ++
 compat/fsmonitor/fsm-listen-linux.c        | 676 +++++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-linux.c    | 186 ++++++
 compat/fsmonitor/fsm-settings-darwin.c     |  63 +-
 compat/fsmonitor/fsm-settings-linux.c      |   1 +
 compat/fsmonitor/fsm-settings-unix.c       |  61 ++
 config.mak.uname                           |   8 +
 contrib/buildsystems/CMakeLists.txt        |  11 +-
 t/t7527-builtin-fsmonitor.sh               |  94 ++-
 14 files changed, 1119 insertions(+), 139 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-unix.c
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 create mode 100644 compat/fsmonitor/fsm-settings-linux.c
 create mode 100644 compat/fsmonitor/fsm-settings-unix.c


base-commit: 319605f8f00e402f3ea758a02c63534ff800a711
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1352%2Fedecosta-mw%2Ffsmonitor_linux-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1352/edecosta-mw/fsmonitor_linux-v4
Pull-Request: https://github.com/git/git/pull/1352

Range-diff vs v3:

 1:  99d684c7bdf = 1:  99d684c7bdf fsmonitor: prepare to share code between Mac OS and Linux
 2:  aa405379891 ! 2:  e53fc077540 fsmonitor: determine if filesystem is local or remote
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +#include <errno.h>
      +#include <mntent.h>
      +#include <sys/mount.h>
     ++#include <sys/vfs.h>
      +#include <sys/statvfs.h>
      +
     -+/*
     -+ * https://github.com/coreutils/gnulib/blob/master/lib/mountlist.c
     -+ */
     -+#ifndef ME_REMOTE
     -+/* A file system is "remote" if its Fs_name contains a ':'
     -+   or if (it is of type (smbfs or cifs) and its Fs_name starts with '//')
     -+   or if it is of any other of the listed types
     -+   or Fs_name is equal to "-hosts" (used by autofs to mount remote fs).
     -+   "VM" file systems like prl_fs or vboxsf are not considered remote here. */
     -+# define ME_REMOTE(Fs_name, Fs_type)            \
     -+	(strchr (Fs_name, ':') != NULL              \
     -+	 || ((Fs_name)[0] == '/'                    \
     -+		 && (Fs_name)[1] == '/'                 \
     -+		 && (strcmp (Fs_type, "smbfs") == 0     \
     -+			 || strcmp (Fs_type, "smb3") == 0   \
     -+			 || strcmp (Fs_type, "cifs") == 0)) \
     -+	 || strcmp (Fs_type, "acfs") == 0           \
     -+	 || strcmp (Fs_type, "afs") == 0            \
     -+	 || strcmp (Fs_type, "coda") == 0           \
     -+	 || strcmp (Fs_type, "auristorfs") == 0     \
     -+	 || strcmp (Fs_type, "fhgfs") == 0          \
     -+	 || strcmp (Fs_type, "gpfs") == 0           \
     -+	 || strcmp (Fs_type, "ibrix") == 0          \
     -+	 || strcmp (Fs_type, "ocfs2") == 0          \
     -+	 || strcmp (Fs_type, "vxfs") == 0           \
     -+	 || strcmp ("-hosts", Fs_name) == 0)
     -+#endif
     ++static int is_remote_fs(const char* path) {
     ++	struct statfs fs;
     ++
     ++	if (statfs(path, &fs)) {
     ++		error_errno(_("statfs('%s') failed"), path);
     ++		return -1;
     ++	}
     ++
     ++	switch (fs.f_type) {
     ++		case 0x61636673:  /* ACFS */
     ++		case 0x5346414F:  /* AFS */
     ++		case 0x00C36400:  /* CEPH */
     ++		case 0xFF534D42:  /* CIFS */
     ++		case 0x73757245:  /* CODA */
     ++		case 0x19830326:  /* FHGFS */
     ++		case 0x1161970:   /* GFS */
     ++		case 0x47504653:  /* GPFS */
     ++		case 0x013111A8:  /* IBRIX */
     ++		case 0x6B414653:  /* KAFS */
     ++		case 0x0BD00BD0:  /* LUSTRE */
     ++		case 0x564C:      /* NCP */
     ++		case 0x6969:      /* NFS */
     ++		case 0x6E667364:  /* NFSD */
     ++		case 0x7461636f:  /* OCFS2 */
     ++		case 0xAAD7AAEA:  /* PANFS */
     ++		case 0x517B:      /* SMB */
     ++		case 0xBEEFDEAD:  /* SNFS */
     ++		case 0xFE534D42:  /* SMB2 */
     ++		case 0xBACBACBC:  /* VMHGFS */
     ++		case 0xA501FCF5:  /* VXFS */
     ++			return 1;
     ++		default:
     ++			break;
     ++	}
     ++
     ++	return 0;
     ++}
      +
      +static int find_mount(const char *path, const struct statvfs *fs,
      +	struct mntent *ent)
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +			 "statvfs('%s') [flags 0x%08lx] '%s' '%s'",
      +			 path, fs.f_flag, ment.mnt_type, ment.mnt_fsname);
      +
     -+	fs_info->is_remote = ME_REMOTE(ment.mnt_fsname, ment.mnt_type);
     ++	fs_info->is_remote = is_remote_fs(ment.mnt_dir);
      +	fs_info->typename = ment.mnt_fsname;
      +	free(ment.mnt_dir);
      +	free(ment.mnt_type);
      +
     ++	if (fs_info->is_remote < 0) {
     ++		free(ment.mnt_fsname);
     ++		return -1;
     ++	}
     ++
      +	trace_printf_key(&trace_fsmonitor,
      +				"'%s' is_remote: %d",
      +				path, fs_info->is_remote);
     ++
      +	return 0;
      +}
      +
 3:  c2e5a7201aa = 3:  80282efef57 fsmonitor: implement filesystem change listener for Linux
 4:  05f5b2dd4fb = 4:  cb03803e355 fsmonitor: enable fsmonitor for Linux
 5:  754355ca44f = 5:  8d9d469b356 fsmonitor: test updates
 6:  f56175e097a = 6:  5afd03fa6ca fsmonitor: update doc for Linux

-- 
gitgitgadget
