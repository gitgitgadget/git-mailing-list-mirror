Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85736994E
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992987; cv=none; b=DXEwR0mbjOp474kcFodNyv6hWHb5dmX94IHtVGIpEUjrrFD3whbfvfoxCMhXsj3Fm6jSxWLSbpusCoPVIs30a54go0iczRs2+Tv1sroUxUCPQvYW+xcGuQwdkWecHc5Q/Lrlo+1vYseL9M4ggxpvityrAU2UE0UHa2ynx/2USpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992987; c=relaxed/simple;
	bh=DYZSLOpxSIEvCpSwGORyOFXDTIvbE33cxKTEN+w6Amc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M6mJ63XnjcXABLROjPFwduWntR4Nyxq4rYfW4QaP8Pd0JTRoj/bRKjq94avmIx0Th1E+Kp/qAPVlCou5g6pG8Xrb3JUggFyisGD8uZgENV+FAfxnegr7EVlsN2Xz3hiVcGibEGPY1eq5LTKs2VLP4W3Ti00cwtPG0Leqk/i6A88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYQmJ1m+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYQmJ1m+"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b66a7f859so199526f8f.3
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 02:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707992982; x=1708597782; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1jAhoRlRsCqkRqgq7RZ8OT6pU79N2PhXbptllXA09A=;
        b=OYQmJ1m+AhGApgS4rdtcOxC6WF18g50WMaPyl56WrPTH/FHFLwVS6Rm76i0iHnP9dK
         QG94w04jx6W/SOYRfpNo0aoWaX3QaxY7SWHdeu0s3B3li5c/na0a/ZxRdf86o/NeDXdd
         yslKDgii6hCk8HiqBe1oDmPy43LXiCecdaf0eyL712ApKzTnpTJthgZ9CumaMU/8kVFS
         GDqq/z/5Shwn2vjhkyhnVeTyX8vinjDbFl+FZJu2vbbxux/NiDdofSy+Wfr0EUmWrJJp
         0pjX7Zb0VG3edzvU38ggjuG13XmAGPXNJL9QC+jYH8XD/SYnPpUjMTy/xO6Nw4dDTvOZ
         VXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992982; x=1708597782;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1jAhoRlRsCqkRqgq7RZ8OT6pU79N2PhXbptllXA09A=;
        b=DjYdYU2uwE/7KWDDMiyZp63lLrGyXxnsfXNF7/aiyQhFXyGyFayHiakcm6ovZ7Zo43
         bNrQdeqcv/I50TpOBfVRgD82rgxq9xkJRXrEYICCA7T8RvglrJKfe32pnZV6FKfNBLKt
         nFEgHqZjTu1PZ9N7cJBAb0bdD4quv1j97OEpJvrIsiIB6733O2QRStcSiB1pdcqcB1DF
         JV1JqY9NHVxvW4K2mo3OGsGtpYJWNonBRuqDxW66mb13jHcpZx10+2KhTAwcIrgVNQCH
         aEtFXO6P5Q+4D2sggCCd00BOaJn7MybAza5suTw1IS8dN4LhhkpmCaLoUdYwlG7VsEoV
         bgAw==
X-Gm-Message-State: AOJu0YxVeM8EPGtvjM6/p/rWdBn9UNdOOzwBUD+OgXtq9D/7TCN/GhvB
	/irjXAvThKT1lAf0ECg3Zc73avwb4YsFgaHtBjOMf97XTApXTX/wGuFf6wls
X-Google-Smtp-Source: AGHT+IFYkpz3Liu+o6AIDwoYRwVvX7yrW47zQotIPOjMTK64t6pTBvkfIjgwoiEDV6y9d3bMI1BERA==
X-Received: by 2002:adf:db4a:0:b0:33b:179d:d9aa with SMTP id f10-20020adfdb4a000000b0033b179dd9aamr1123301wrj.26.1707992982168;
        Thu, 15 Feb 2024 02:29:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d4bcd000000b0033b784c2775sm1353835wrt.43.2024.02.15.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:29:40 -0800 (PST)
Message-ID: <d26de10866662a5bcd16d562cd1063dedd21cf02.1707992978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
References: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
From: "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Feb 2024 10:29:33 +0000
Subject: [PATCH 2/7] fsmonitor: determine if filesystem is local or remote
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
    "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason [ ]" <avarab@gmail.com>,
    "Glen Choo [ ]" <chooglen@google.com>,
    "Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
    "Taylor Blau [ ]" <me@ttaylorr.com>,
    marzi <m.ispare63@gmail.com>,
    Eric DeCosta <edecosta@mathworks.com>

From: Eric DeCosta <edecosta@mathworks.com>

Compare the given path to the mounted filesystems. Find the mount that is
the longest prefix of the path (if any) and determine if that mount is on a
local or remote filesystem.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Makefile                                |   4 +
 compat/fsmonitor/fsm-path-utils-linux.c | 195 ++++++++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-linux.h |  91 +++++++++++
 config.mak.uname                        |  11 ++
 4 files changed, 301 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.h

diff --git a/Makefile b/Makefile
index 78e874099d9..0f36a0fd83a 100644
--- a/Makefile
+++ b/Makefile
@@ -2088,6 +2088,10 @@ ifdef HAVE_CLOCK_GETTIME
 	BASIC_CFLAGS += -DHAVE_CLOCK_GETTIME
 endif
 
+ifdef HAVE_LINUX_MAGIC_H
+	BASIC_CFLAGS += -DHAVE_LINUX_MAGIC_H
+endif
+
 ifdef HAVE_CLOCK_MONOTONIC
 	BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
 endif
diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
new file mode 100644
index 00000000000..c21d1349532
--- /dev/null
+++ b/compat/fsmonitor/fsm-path-utils-linux.c
@@ -0,0 +1,195 @@
+#include "git-compat-util.h"
+#include "abspath.h"
+#include "fsmonitor.h"
+#include "fsmonitor-path-utils.h"
+#include "fsm-path-utils-linux.h"
+#include <errno.h>
+#include <mntent.h>
+#include <sys/mount.h>
+#include <sys/vfs.h>
+#include <sys/statvfs.h>
+
+static int is_remote_fs(const char *path)
+{
+	struct statfs fs;
+
+	if (statfs(path, &fs))
+		return error_errno(_("statfs('%s') failed"), path);
+
+	switch (fs.f_type) {
+	case ACFS_SUPER_MAGIC:
+	case AFS_SUPER_MAGIC:
+	case CEPH_SUPER_MAGIC:
+	case CIFS_SUPER_MAGIC:
+	case CODA_SUPER_MAGIC:
+	case FHGFS_SUPER_MAGIC:
+	case GFS_SUPER_MAGIC:
+	case GPFS_SUPER_MAGIC:
+	case IBRIX_SUPER_MAGIC:
+	case KAFS_SUPER_MAGIC:
+	case LUSTRE_SUPER_MAGIC:
+	case NCP_SUPER_MAGIC:
+	case NFS_SUPER_MAGIC:
+	case NFSD_SUPER_MAGIC:
+	case OCFS2_SUPER_MAGIC:
+	case PANFS_SUPER_MAGIC:
+	case SMB_SUPER_MAGIC:
+	case SMB2_SUPER_MAGIC:
+	case SNFS_SUPER_MAGIC:
+	case VMHGFS_SUPER_MAGIC:
+	case VXFS_SUPER_MAGIC:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int find_mount(const char *path, const struct statvfs *fs,
+			struct mntent *entry)
+{
+	const char *const mounts = "/proc/mounts";
+	char *rp = real_pathdup(path, 1);
+	struct mntent *ment = NULL;
+	struct statvfs mntfs;
+	FILE *fp;
+	int found = 0;
+	int ret = 0;
+	size_t dlen, plen, flen = 0;
+
+	entry->mnt_fsname = NULL;
+	entry->mnt_dir = NULL;
+	entry->mnt_type = NULL;
+
+	fp = setmntent(mounts, "r");
+	if (!fp) {
+		free(rp);
+		return error_errno(_("setmntent('%s') failed"), mounts);
+	}
+
+	plen = strlen(rp);
+
+	/* read all the mount information and compare to path */
+	while ((ment = getmntent(fp))) {
+		if (statvfs(ment->mnt_dir, &mntfs)) {
+			switch (errno) {
+			case EPERM:
+			case ESRCH:
+			case EACCES:
+				continue;
+			default:
+				error_errno(_("statvfs('%s') failed"), ment->mnt_dir);
+				ret = -1;
+				goto done;
+			}
+		}
+
+		/* is mount on the same filesystem and is a prefix of the path */
+		if ((fs->f_fsid == mntfs.f_fsid) &&
+			!strncmp(ment->mnt_dir, rp, strlen(ment->mnt_dir))) {
+			dlen = strlen(ment->mnt_dir);
+			if (dlen > plen)
+				continue;
+			/*
+			 * look for the longest prefix (including root)
+			 */
+			if (dlen > flen &&
+				((dlen == 1 && ment->mnt_dir[0] == '/') ||
+				 (!rp[dlen] || rp[dlen] == '/'))) {
+				flen = dlen;
+				found = 1;
+
+				/*
+				 * https://man7.org/linux/man-pages/man3/getmntent.3.html
+				 *
+				 * The pointer points to a static area of memory which is
+				 * overwritten by subsequent calls to getmntent().
+				 */
+				free(entry->mnt_fsname);
+				free(entry->mnt_dir);
+				free(entry->mnt_type);
+				entry->mnt_fsname = xstrdup(ment->mnt_fsname);
+				entry->mnt_dir = xstrdup(ment->mnt_dir);
+				entry->mnt_type = xstrdup(ment->mnt_type);
+			}
+		}
+	}
+
+done:
+	free(rp);
+	endmntent(fp);
+
+	if (!found)
+		return -1;
+
+	return ret;
+}
+
+int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
+{
+	int ret = 0;
+	struct mntent entry;
+	struct statvfs fs;
+
+	fs_info->is_remote = -1;
+	fs_info->typename = NULL;
+
+	if (statvfs(path, &fs))
+		return error_errno(_("statvfs('%s') failed"), path);
+
+	if (find_mount(path, &fs, &entry) < 0) {
+		ret = -1;
+		goto done;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statvfs('%s') [flags 0x%08lx] '%s' '%s'",
+			 path, fs.f_flag, entry.mnt_type, entry.mnt_fsname);
+
+	fs_info->is_remote = is_remote_fs(entry.mnt_dir);
+	fs_info->typename = xstrdup(entry.mnt_fsname);
+
+	if (fs_info->is_remote < 0)
+		ret = -1;
+
+	trace_printf_key(&trace_fsmonitor,
+				"'%s' is_remote: %d",
+				path, fs_info->is_remote);
+
+done:
+	free(entry.mnt_fsname);
+	free(entry.mnt_dir);
+	free(entry.mnt_type);
+	return ret;
+}
+
+int fsmonitor__is_fs_remote(const char *path)
+{
+	int ret = 0;
+	struct fs_info fs;
+
+	if (fsmonitor__get_fs_info(path, &fs))
+		ret = -1;
+	else
+		ret = fs.is_remote;
+
+	free(fs.typename);
+
+	return ret;
+}
+
+/*
+ * No-op for now.
+ */
+int fsmonitor__get_alias(const char *path, struct alias_info *info)
+{
+	return 0;
+}
+
+/*
+ * No-op for now.
+ */
+char *fsmonitor__resolve_alias(const char *path,
+		const struct alias_info *info)
+{
+	return NULL;
+}
diff --git a/compat/fsmonitor/fsm-path-utils-linux.h b/compat/fsmonitor/fsm-path-utils-linux.h
new file mode 100644
index 00000000000..49bdb3c4728
--- /dev/null
+++ b/compat/fsmonitor/fsm-path-utils-linux.h
@@ -0,0 +1,91 @@
+#ifndef FSM_PATH_UTILS_LINUX_H
+#define FSM_PATH_UTILS_LINUX_H
+#endif
+
+#ifdef HAVE_LINUX_MAGIC_H
+#include <linux/magic.h>
+#endif
+
+#ifndef ACFS_SUPER_MAGIC
+#define ACFS_SUPER_MAGIC 0x61636673
+#endif
+
+#ifndef AFS_SUPER_MAGIC
+#define AFS_SUPER_MAGIC 0x5346414f
+#endif
+
+#ifndef CEPH_SUPER_MAGIC
+#define CEPH_SUPER_MAGIC 0x00c36400
+#endif
+
+#ifndef CIFS_SUPER_MAGIC
+#define CIFS_SUPER_MAGIC 0xff534d42
+#endif
+
+#ifndef CODA_SUPER_MAGIC
+#define CODA_SUPER_MAGIC 0x73757245
+#endif
+
+#ifndef FHGFS_SUPER_MAGIC
+#define FHGFS_SUPER_MAGIC 0x19830326
+#endif
+
+#ifndef GFS_SUPER_MAGIC
+#define GFS_SUPER_MAGIC 0x1161970
+#endif
+
+#ifndef GPFS_SUPER_MAGIC
+#define GPFS_SUPER_MAGIC 0x47504653
+#endif
+
+#ifndef IBRIX_SUPER_MAGIC
+#define IBRIX_SUPER_MAGIC 0x013111a8
+#endif
+
+#ifndef KAFS_SUPER_MAGIC
+#define KAFS_SUPER_MAGIC 0x6b414653
+#endif
+
+#ifndef LUSTRE_SUPER_MAGIC
+#define LUSTRE_SUPER_MAGIC 0x0bd00bd0
+#endif
+
+#ifndef NCP_SUPER_MAGIC
+#define NCP_SUPER_MAGIC 0x564c
+#endif
+
+#ifndef NFS_SUPER_MAGIC
+#define NFS_SUPER_MAGIC 0x6969
+#endif
+
+#ifndef NFSD_SUPER_MAGIC
+#define NFSD_SUPER_MAGIC 0x6e667364
+#endif
+
+#ifndef OCFS2_SUPER_MAGIC
+#define OCFS2_SUPER_MAGIC 0x7461636f
+#endif
+
+#ifndef PANFS_SUPER_MAGIC
+#define PANFS_SUPER_MAGIC 0xaad7aaea
+#endif
+
+#ifndef SMB_SUPER_MAGIC
+#define SMB_SUPER_MAGIC 0x517b
+#endif
+
+#ifndef SMB2_SUPER_MAGIC
+#define SMB2_SUPER_MAGIC 0xfe534d42
+#endif
+
+#ifndef SNFS_SUPER_MAGIC
+#define SNFS_SUPER_MAGIC 0xbeefdead
+#endif
+
+#ifndef VMHGFS_SUPER_MAGIC
+#define VMHGFS_SUPER_MAGIC 0xbacbacbc
+#endif
+
+#ifndef VXFS_SUPER_MAGIC
+#define VXFS_SUPER_MAGIC 0xa501fcf5
+#endif
diff --git a/config.mak.uname b/config.mak.uname
index dacc95172dc..80d7e2a2e68 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -68,6 +68,17 @@ ifeq ($(uname_S),Linux)
 	ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS += -std=c99
 	endif
+	ifeq ($(shell test -f /usr/include/linux/magic.h && echo y),y)
+		HAVE_LINUX_MAGIC_H = YesPlease
+	endif
+	# The builtin FSMonitor on Linux builds upon Simple-IPC.  Both require
+	# Unix domain sockets and PThreads.
+	ifndef NO_PTHREADS
+	ifndef NO_UNIX_SOCKETS
+	FSMONITOR_DAEMON_BACKEND = linux
+	FSMONITOR_OS_SETTINGS = linux
+	endif
+	endif
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
-- 
gitgitgadget

