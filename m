Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F4FC433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 14:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiJIOiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJIOhu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 10:37:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE6B2716B
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 07:37:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w18so13657677wro.7
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCfXpNh5txAG/yjAWSL2RLjvzxamc22TUvq9C7Fo7ZQ=;
        b=nzB5zufktrFaazcUHNrV+v5pw4b8TiTHLy6sE+6emCnVZuTV/bTn6k+TB6nau5+dNb
         0w3BNbqmnsde4X4sBsfKt5T5B/EBlHbMVgmtL68CkkSwCnc2QuOTscvQJ3TER4DHNBEC
         v8OyrTSWdvMK9EvzM0yLwUHnQ6z0tfYaHIUkQf/Z9a2VJph8vxQTfE4weTeqB/oLRgId
         5CePJYdwL/23CXtvMQwlvaxggUqWZDIegmYUpk/1mpfKFCZad4Q+ws388tS0bdlgWGOS
         HJ2gZsrdUTxBJV20U//aJ7GFwwUG7tfMp99LWZSEdVIbtAhhSsDsPM60dHT1ekPwWCUu
         uWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCfXpNh5txAG/yjAWSL2RLjvzxamc22TUvq9C7Fo7ZQ=;
        b=zB/Ah2hmFDYORmxCcvSYUns5UXoAD/rY+FF0Z3zkQ6Sowz5IK0e/vu9LEZAr9Jvamw
         UIyE0S46pIdcrpSHvxVUBFzu0OZt0TvpRWxaTx9yEF42AQWP9nCIjS0b1Pk8CcJcGcq+
         Ho9PoKpQrsJ6DlGYN+kf02fGGiBCHvdTkbiUwcQKL93bl4tB9sqZRrvkMULv2SIRPcJ4
         GUVkEXDdlnlpGLpW97vNU3QWHcEPyCjJC1wHiqhAUDt0d1FY0mFmgclLJeDs0Z5ujHjV
         QQB4U5rUBL+3kmVmjMt/5d1PQzEDp930uWtY7pbQL7IxEi4y/d/YiLAg1lR4hbosbbSm
         aeBg==
X-Gm-Message-State: ACrzQf2xt5/SYPsdiDuWBx4oKJcNStPzG6kOzIDZGwKU/W90jBQe8uM4
        va4bPH+19mDc7v0UUIPIretH8eZPIs8=
X-Google-Smtp-Source: AMsMyM4+rskFvqScN3eu+Rh5RNRDuyrt1jqA6dwEc+qWR4NJVwXRyDSYMpHi6+jUERLF7jgZpZUubw==
X-Received: by 2002:a5d:6b0e:0:b0:22a:2cb1:6605 with SMTP id v14-20020a5d6b0e000000b0022a2cb16605mr8629214wrw.552.1665326267327;
        Sun, 09 Oct 2022 07:37:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a5d50c8000000b0022e36c1113fsm6824958wrt.13.2022.10.09.07.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 07:37:46 -0700 (PDT)
Message-Id: <5ecbb3082f16956d049cfa98662f8e3384a6aea2.1665326258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 14:37:34 +0000
Subject: [PATCH 08/12] fsmonitor: determine if filesystem is local or remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Compare the given path to the mounted filesystems. Find the mount that is
the longest prefix of the path (if any) and determine if that mount is on a
local or remote filesystem.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-path-utils-linux.c | 163 ++++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c

diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
new file mode 100644
index 00000000000..369692a788f
--- /dev/null
+++ b/compat/fsmonitor/fsm-path-utils-linux.c
@@ -0,0 +1,163 @@
+#include "fsmonitor.h"
+#include "fsmonitor-path-utils.h"
+#include <errno.h>
+#include <mntent.h>
+#include <sys/mount.h>
+#include <sys/statvfs.h>
+
+/*
+ * https://github.com/coreutils/gnulib/blob/master/lib/mountlist.c
+ */
+#ifndef ME_REMOTE
+/* A file system is "remote" if its Fs_name contains a ':'
+   or if (it is of type (smbfs or cifs) and its Fs_name starts with '//')
+   or if it is of any other of the listed types
+   or Fs_name is equal to "-hosts" (used by autofs to mount remote fs).
+   "VM" file systems like prl_fs or vboxsf are not considered remote here. */
+# define ME_REMOTE(Fs_name, Fs_type)            \
+	(strchr (Fs_name, ':') != NULL              \
+	 || ((Fs_name)[0] == '/'                    \
+		 && (Fs_name)[1] == '/'                 \
+		 && (strcmp (Fs_type, "smbfs") == 0     \
+			 || strcmp (Fs_type, "smb3") == 0   \
+			 || strcmp (Fs_type, "cifs") == 0)) \
+	 || strcmp (Fs_type, "acfs") == 0           \
+	 || strcmp (Fs_type, "afs") == 0            \
+	 || strcmp (Fs_type, "coda") == 0           \
+	 || strcmp (Fs_type, "auristorfs") == 0     \
+	 || strcmp (Fs_type, "fhgfs") == 0          \
+	 || strcmp (Fs_type, "gpfs") == 0           \
+	 || strcmp (Fs_type, "ibrix") == 0          \
+	 || strcmp (Fs_type, "ocfs2") == 0          \
+	 || strcmp (Fs_type, "vxfs") == 0           \
+	 || strcmp ("-hosts", Fs_name) == 0)
+#endif
+
+static struct mntent *find_mount(const char *path, const struct statvfs *fs)
+{
+	const char *const mounts = "/proc/mounts";
+	const char *rp = real_pathdup(path, 1);
+	struct mntent *ment = NULL;
+	struct mntent *found = NULL;
+	struct statvfs mntfs;
+	FILE *fp;
+	int dlen, plen, flen = 0;
+
+	fp = setmntent(mounts, "r");
+	if (!fp) {
+		error_errno(_("setmntent('%s') failed"), mounts);
+		return NULL;
+	}
+
+	plen = strlen(rp);
+
+	/* read all the mount information and compare to path */
+	while ((ment = getmntent(fp)) != NULL) {
+		if (statvfs(ment->mnt_dir, &mntfs)) {
+			switch (errno) {
+			case EPERM:
+			case ESRCH:
+			case EACCES:
+				continue;
+			default:
+				error_errno(_("statvfs('%s') failed"), ment->mnt_dir);
+				endmntent(fp);
+				return NULL;
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
+			 * root is always a potential match; otherwise look for
+			 * directory prefix
+			 */
+			if ((dlen == 1 && ment->mnt_dir[0] == '/') ||
+				(dlen > flen && (!rp[dlen] || rp[dlen] == '/'))) {
+				flen = dlen;
+				/*
+				 * https://man7.org/linux/man-pages/man3/getmntent.3.html
+				 *
+				 * The pointer points to a static area of memory which is
+				 * overwritten by subsequent calls to getmntent().
+				 */
+				if (!found)
+					CALLOC_ARRAY(found, 1);
+				free(found->mnt_dir);
+				free(found->mnt_type);
+				free(found->mnt_fsname);
+				found->mnt_dir = xmemdupz(ment->mnt_dir, strlen(ment->mnt_dir));
+				found->mnt_type = xmemdupz(ment->mnt_type, strlen(ment->mnt_type));
+				found->mnt_fsname = xmemdupz(ment->mnt_fsname, strlen(ment->mnt_fsname));
+			}
+		}
+	}
+	endmntent(fp);
+
+	return found;
+}
+
+int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
+{
+	struct mntent *ment;
+	struct statvfs fs;
+
+	if (statvfs(path, &fs))
+		return error_errno(_("statvfs('%s') failed"), path);
+
+	ment = find_mount(path, &fs);
+	if (!ment)
+		return -1;
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statvfs('%s') [flags 0x%08lx] '%s' '%s'",
+			 path, fs.f_flag, ment->mnt_type, ment->mnt_fsname);
+
+	if (ME_REMOTE(ment->mnt_fsname, ment->mnt_type))
+		fs_info->is_remote = 1;
+	else
+		fs_info->is_remote = 0;
+
+	fs_info->typename = ment->mnt_fsname;
+	free(ment->mnt_dir);
+	free(ment->mnt_type);
+	free(ment);
+
+	trace_printf_key(&trace_fsmonitor,
+				"'%s' is_remote: %d",
+				path, fs_info->is_remote);
+	return 0;
+}
+
+int fsmonitor__is_fs_remote(const char *path)
+{
+	struct fs_info fs;
+
+	if (fsmonitor__get_fs_info(path, &fs))
+		return -1;
+
+	free(fs.typename);
+
+	return fs.is_remote;
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
+	const struct alias_info *info)
+{
+	return NULL;
+}
-- 
gitgitgadget

