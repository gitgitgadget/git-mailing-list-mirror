Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C356C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiLLV6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLLV6K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:58:10 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355CCEE33
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:58:09 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y16so13710064wrm.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qK0gVXSDCMzkDrhNnSohmq+I1VqbuIoMYpfa29GxSaA=;
        b=FsT2Ca/G8ol9SbVy9MHnxxGQxIEwxKal218e5eqxuEcfnyt9QhOsu+Yu9I+Eyx3LBS
         HO+6xIXVpFNZEGh1Nw7fk4Rpt2b72CmPpz0Z0vYbMaGywIX1ybRRWQ/SjkVlCCoohzSF
         3X4vhECL3T3pbdk33fwRFhXluGwsDJ1NSJmra9D5dLQDVlMjQtCMBIFanTGx4ZfCYV1a
         Hk+J+MI3rxItYWSGf1uUYjQzvBAyi5dy4eWgBCZn9nS+rmWuOcxguoskpW/16jtyQXv0
         kjjkR8vkg7lA8JMpc3zK5b4Au/00wNkXDiFU77CQjgtxvD9AnnOOykSVBUSA1BHfeC3R
         UbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qK0gVXSDCMzkDrhNnSohmq+I1VqbuIoMYpfa29GxSaA=;
        b=ZOBGv7bbNOLs7Fk17UpE05L0cR0QuBEsJf9xdcFiQ7y5iAtLJ2CHnBEOyAFPbJIOrK
         qD1vP7nMbEaxX76mOQ6pUeE/dA+H6E27rrdrvfkmjBcWSNOTU0fM9xNfseBmuManvlvm
         XJ9i8HXbNezWkmIs9jECnfem/hd+tV/4jjizVZmFllzcw87YWWl1dXuuU7ctUYizTZ5A
         O1QXop2EJvXQ62XnF8msqrda7/AkZThVj+475EZO9hj+HW56frkvceb/s+p1cUE6+ot9
         ZahN0EWYWhNGUGmxIRg+7yIzMuQ1BAqGhAGlq48tRiu+Tzx9oeI1aAzOjAz4IRvfizIK
         VnJg==
X-Gm-Message-State: ANoB5pn31Hr38hZrlhxY3L3KgPCuhzkg66jFj9j29g0kByDl4WwL5evf
        Ar2hXrs5pYxpqK0uqJaplXhyBHIzt2o=
X-Google-Smtp-Source: AA0mqf527R61eb3fY04ynuvut2pt2IiHVXt1RAtb+gRXDKIwZS94WdlaiRyiGzB+PjWQccwLxvVf2g==
X-Received: by 2002:a05:6000:1d1:b0:250:777b:daa0 with SMTP id t17-20020a05600001d100b00250777bdaa0mr2457013wrx.35.1670882287565;
        Mon, 12 Dec 2022 13:58:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15-20020adfe5cf000000b002425787c5easm9732182wrn.96.2022.12.12.13.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:58:07 -0800 (PST)
Message-Id: <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:57:59 +0000
Subject: [PATCH v5 0/6] fsmonitor: Implement fsmonitor for Linux
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

v4 differs from v3:

 * Code review feedback

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
 compat/fsmonitor/fsm-path-utils-linux.c    | 193 ++++++
 compat/fsmonitor/fsm-settings-darwin.c     |  63 +-
 compat/fsmonitor/fsm-settings-linux.c      |   1 +
 compat/fsmonitor/fsm-settings-unix.c       |  62 ++
 config.mak.uname                           |   8 +
 contrib/buildsystems/CMakeLists.txt        |  11 +-
 t/t7527-builtin-fsmonitor.sh               |  94 ++-
 14 files changed, 1127 insertions(+), 139 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-unix.c
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 create mode 100644 compat/fsmonitor/fsm-settings-linux.c
 create mode 100644 compat/fsmonitor/fsm-settings-unix.c


base-commit: c48035d29b4e524aed3a32f0403676f0d9128863
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1352%2Fedecosta-mw%2Ffsmonitor_linux-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1352/edecosta-mw/fsmonitor_linux-v5
Pull-Request: https://github.com/git/git/pull/1352

Range-diff vs v4:

 1:  99d684c7bdf ! 1:  7f659603c9a fsmonitor: prepare to share code between Mac OS and Linux
     @@ compat/fsmonitor/fsm-settings-unix.c (new)
      +	strbuf_addstr(&path, ipc_path);
      +
      +	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
     ++		free(fs.typename);
      +		strbuf_release(&path);
      +		return FSMONITOR_REASON_ERROR;
      +	}
 2:  e53fc077540 ! 2:  eb3ff9d1c05 fsmonitor: determine if filesystem is local or remote
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +#include <sys/vfs.h>
      +#include <sys/statvfs.h>
      +
     -+static int is_remote_fs(const char* path) {
     ++static int is_remote_fs(const char *path) {
      +	struct statfs fs;
      +
      +	if (statfs(path, &fs)) {
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +	}
      +
      +	switch (fs.f_type) {
     -+		case 0x61636673:  /* ACFS */
     -+		case 0x5346414F:  /* AFS */
     -+		case 0x00C36400:  /* CEPH */
     -+		case 0xFF534D42:  /* CIFS */
     -+		case 0x73757245:  /* CODA */
     -+		case 0x19830326:  /* FHGFS */
     -+		case 0x1161970:   /* GFS */
     -+		case 0x47504653:  /* GPFS */
     -+		case 0x013111A8:  /* IBRIX */
     -+		case 0x6B414653:  /* KAFS */
     -+		case 0x0BD00BD0:  /* LUSTRE */
     -+		case 0x564C:      /* NCP */
     -+		case 0x6969:      /* NFS */
     -+		case 0x6E667364:  /* NFSD */
     -+		case 0x7461636f:  /* OCFS2 */
     -+		case 0xAAD7AAEA:  /* PANFS */
     -+		case 0x517B:      /* SMB */
     -+		case 0xBEEFDEAD:  /* SNFS */
     -+		case 0xFE534D42:  /* SMB2 */
     -+		case 0xBACBACBC:  /* VMHGFS */
     -+		case 0xA501FCF5:  /* VXFS */
     -+			return 1;
     -+		default:
     -+			break;
     ++	case 0x61636673:  /* ACFS */
     ++	case 0x5346414F:  /* AFS */
     ++	case 0x00C36400:  /* CEPH */
     ++	case 0xFF534D42:  /* CIFS */
     ++	case 0x73757245:  /* CODA */
     ++	case 0x19830326:  /* FHGFS */
     ++	case 0x1161970:   /* GFS */
     ++	case 0x47504653:  /* GPFS */
     ++	case 0x013111A8:  /* IBRIX */
     ++	case 0x6B414653:  /* KAFS */
     ++	case 0x0BD00BD0:  /* LUSTRE */
     ++	case 0x564C:      /* NCP */
     ++	case 0x6969:      /* NFS */
     ++	case 0x6E667364:  /* NFSD */
     ++	case 0x7461636f:  /* OCFS2 */
     ++	case 0xAAD7AAEA:  /* PANFS */
     ++	case 0x517B:      /* SMB */
     ++	case 0xBEEFDEAD:  /* SNFS */
     ++	case 0xFE534D42:  /* SMB2 */
     ++	case 0xBACBACBC:  /* VMHGFS */
     ++	case 0xA501FCF5:  /* VXFS */
     ++		return 1;
     ++	default:
     ++		break;
      +	}
      +
      +	return 0;
      +}
      +
      +static int find_mount(const char *path, const struct statvfs *fs,
     -+	struct mntent *ent)
     ++	struct mntent *entry)
      +{
      +	const char *const mounts = "/proc/mounts";
     -+	const char *rp = real_pathdup(path, 1);
     ++	char *rp = real_pathdup(path, 1);
      +	struct mntent *ment = NULL;
      +	struct statvfs mntfs;
      +	FILE *fp;
      +	int found = 0;
      +	int dlen, plen, flen = 0;
      +
     -+	ent->mnt_fsname = NULL;
     -+	ent->mnt_dir = NULL;
     -+	ent->mnt_type = NULL;
     ++	entry->mnt_fsname = NULL;
     ++	entry->mnt_dir = NULL;
     ++	entry->mnt_type = NULL;
      +
      +	fp = setmntent(mounts, "r");
      +	if (!fp) {
     ++		free(rp);
      +		error_errno(_("setmntent('%s') failed"), mounts);
      +		return -1;
      +	}
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +			default:
      +				error_errno(_("statvfs('%s') failed"), ment->mnt_dir);
      +				endmntent(fp);
     ++				free(rp);
      +				return -1;
      +			}
      +		}
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +			if (dlen > plen)
      +				continue;
      +			/*
     -+			 * root is always a potential match; otherwise look for
     -+			 * directory prefix
     ++			 * look for the longest prefix (including root)
      +			 */
     -+			if ((dlen == 1 && ment->mnt_dir[0] == '/') ||
     -+				(dlen > flen && (!rp[dlen] || rp[dlen] == '/'))) {
     ++			if (dlen > flen &&
     ++				((dlen == 1 && ment->mnt_dir[0] == '/') ||
     ++				 (!rp[dlen] || rp[dlen] == '/'))) {
      +				flen = dlen;
     ++				found = 1;
     ++
      +				/*
      +				 * https://man7.org/linux/man-pages/man3/getmntent.3.html
      +				 *
      +				 * The pointer points to a static area of memory which is
      +				 * overwritten by subsequent calls to getmntent().
      +				 */
     -+				found = 1;
     -+				free(ent->mnt_fsname);
     -+				free(ent->mnt_dir);
     -+				free(ent->mnt_type);
     -+				ent->mnt_fsname = xstrdup(ment->mnt_fsname);
     -+				ent->mnt_dir = xstrdup(ment->mnt_dir);
     -+				ent->mnt_type = xstrdup(ment->mnt_type);
     ++				free(entry->mnt_fsname);
     ++				free(entry->mnt_dir);
     ++				free(entry->mnt_type);
     ++				entry->mnt_fsname = xstrdup(ment->mnt_fsname);
     ++				entry->mnt_dir = xstrdup(ment->mnt_dir);
     ++				entry->mnt_type = xstrdup(ment->mnt_type);
      +			}
      +		}
      +	}
      +	endmntent(fp);
     ++	free(rp);
      +
      +	if (!found)
      +		return -1;
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +
      +int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
      +{
     -+	struct mntent ment;
     ++	struct mntent entry;
      +	struct statvfs fs;
      +
     ++	fs_info->is_remote = -1;
     ++	fs_info->typename = NULL;
     ++
      +	if (statvfs(path, &fs))
      +		return error_errno(_("statvfs('%s') failed"), path);
      +
     -+
     -+	if (find_mount(path, &fs, &ment) < 0) {
     -+		free(ment.mnt_fsname);
     -+		free(ment.mnt_dir);
     -+		free(ment.mnt_type);
     ++	if (find_mount(path, &fs, &entry) < 0) {
     ++		free(entry.mnt_fsname);
     ++		free(entry.mnt_dir);
     ++		free(entry.mnt_type);
      +		return -1;
      +	}
      +
      +	trace_printf_key(&trace_fsmonitor,
      +			 "statvfs('%s') [flags 0x%08lx] '%s' '%s'",
     -+			 path, fs.f_flag, ment.mnt_type, ment.mnt_fsname);
     ++			 path, fs.f_flag, entry.mnt_type, entry.mnt_fsname);
      +
     -+	fs_info->is_remote = is_remote_fs(ment.mnt_dir);
     -+	fs_info->typename = ment.mnt_fsname;
     -+	free(ment.mnt_dir);
     -+	free(ment.mnt_type);
     ++	fs_info->is_remote = is_remote_fs(entry.mnt_dir);
     ++	fs_info->typename = xstrdup(entry.mnt_fsname);
     ++	free(entry.mnt_fsname);
     ++	free(entry.mnt_dir);
     ++	free(entry.mnt_type);
      +
     -+	if (fs_info->is_remote < 0) {
     -+		free(ment.mnt_fsname);
     ++	if (fs_info->is_remote < 0)
      +		return -1;
     -+	}
      +
      +	trace_printf_key(&trace_fsmonitor,
      +				"'%s' is_remote: %d",
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +{
      +	struct fs_info fs;
      +
     -+	if (fsmonitor__get_fs_info(path, &fs))
     ++	if (fsmonitor__get_fs_info(path, &fs)) {
     ++		free(fs.typename);
      +		return -1;
     ++	}
      +
      +	free(fs.typename);
      +
 3:  80282efef57 = 3:  e093a2703b1 fsmonitor: implement filesystem change listener for Linux
 4:  cb03803e355 = 4:  c03070fb0a2 fsmonitor: enable fsmonitor for Linux
 5:  8d9d469b356 = 5:  6a7b554642c fsmonitor: test updates
 6:  5afd03fa6ca = 6:  827410c22ee fsmonitor: update doc for Linux

-- 
gitgitgadget
