Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2FA40759F
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410889; cv=none; b=Qn4I7FN+HoHcTM/JpJktWdgz2cHlVirSMr2sUtOd7pjEl0kHd9clmdZiqc/+UZwrgn9wgJA6fTQ5p1xRLEiQAe4Uxd056KXq1TXBBrSYBF6LpqOPcN86DCmnuiv4DZXpKLgQFKeaxKz7dDXxMbEzPmEHvM8F2zL0jJBEwYb6iQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410889; c=relaxed/simple;
	bh=/PE26yy23NVqXs9J5QoBCj1A5xN3k3kN3E7btc3dKnI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NWd5eeEVjuJkCt/ch8EsfLmnloTzJA3O1n/o6OiBFaNS11nZI+1JrhXW8IgLpBsusdaOBkbDGFtJlBEWFiKrLaTjjYM/LsWb+Kgpj2LgbdWYVON6DWBgyZKM8s5hpqOUfXMfV06Qke6YmJuAprRj0NaG52eVHNPiUurIMZ6+U7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD/pz+nM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD/pz+nM"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso22514735ad.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785410887; x=1786015687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O80Ym1VjIzDpDNH6PVxqGzgW48yk739aZYYMDEQoES0=;
        b=ZD/pz+nMiDMRbKF03g5xKFp1QtPttpjZprqI1cFHdodWu4Iqd57hAAvCUhmjQWsSuy
         ySoFtFbvFxS7FDFilRVOIwUrVg78l1xKIzFm6WGCnsY3ndo3ZmiLLVTSQzRxv7nn1DDH
         nWnSdeLp9GEnutaMsu+kVaf3Vbn30NsKUyrpOaAM1n+ytJ1a7HrQRxrCXEUhRnc6kZPZ
         M1wgapZ0pLPse27G9YlLrnFTuZh9neRObmdbI4uadLwXBQYvc2T11xfAbyhePV0yrRVq
         0weV0wkQBR31OFje+eRF8fMWnH1o+n6W1ikXYAbte0ypiuSJYL2joXN1Y7QZqwazRT0u
         xKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785410887; x=1786015687;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O80Ym1VjIzDpDNH6PVxqGzgW48yk739aZYYMDEQoES0=;
        b=ccdesqXnerP+2bySz7H3gd6Lzy4alHCv8ItrDmHS8aizHLK6XBJHNB2VLhLGDPjtes
         1ettOtfIg4W1EXrkVpnl8Do7oF+zYcM9CdFFgtKnP/r9vuKRSJIAtIQ7m5rAHfmWCdVv
         OvqTMrdSU+cgk2LMVmGZBQQ8wtLjAx2AD0Hw6eLLBrHa0dSqJoZV3ajyXMDud83S8cRR
         To5GPm+vwpe+wiYme6B6Ho+uWBOKe0RAp3JQc2MS43dhcjTWEIV+GYFemMJAoDQK9kf6
         w0zAvbiUwRr5NTxKINVVNXohAIUvIB3/Eky3d6/rSnUN0SS7enS3pMxvNtlKB/Dru76x
         GT8Q==
X-Gm-Message-State: AOJu0Ywa4sBtl5A0tHUUncZKsPAnvenN42MXzFz6tQg19NfdZ76MREW/
	QZH529d3KJqFVgXUblzAZL41rk2aENMEaMf+tPIQIvUD4uM2IIQLxB/obGqFVg==
X-Gm-Gg: AR+sD12aftJVlypB5mlhkKwaQrekyp6SmvfGQ6RzmyWz6RI63476NFlNOw4L21VyWkM
	WP/7PUiord4/19liAx1WrjmJ5XqFzavYvlyuUIuFC7qPW4CaxZAXv/MsOAADgJ+NXQmDHqXGTTw
	mRQOHDi5xIGF5T/sahJFZzuNtEsNtCGRsddqOAuNqX5c8o2Uv2zMfAsKh2hWXpiFIsurS2hQhLV
	9zOxG3EEFUjGdm0iVIjnIqVKd17M3lBBioREX04xmA21oynx9Wu6TWhZCyROfhyFXlfbqV0hamd
	Zwm7MbBaIN8BavMCyf8qfqmAfeunl2kpeaR3FfN5IxhTJSEcaIUg5Vto+6+TI9Ud4y1h9LnArTx
	QfDXeVFtgszqHdbrf7YGGOHNanNcC7Gt8sPjqdn0u85Qp3tdiIVkhaO/nw6zP/dQJBtpnT/LAZq
	2nbT+ft2yOrdoxA5xBrlx8AasiqmAttUDdmRVjqvSdIE6egb5Imo1Odo7TJK9qEh2P
X-Received: by 2002:a17:903:2f8c:b0:2c9:c517:d078 with SMTP id d9443c01a7336-2d035ceb02bmr21514815ad.36.1785410886929;
        Thu, 30 Jul 2026 04:28:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.212.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bca9d7sm25742705ad.52.2026.07.30.04.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:28:05 -0700 (PDT)
Message-Id: <pull.2356.v5.git.git.1785410884.gitgitgadget@gmail.com>
In-Reply-To: <pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com>
References: <pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 11:28:02 +0000
Subject: [PATCH v5 0/2] mv: report missing destination leading directory
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Pablo Sabater <pabloosabaterr@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>

Changes in v5:

 * extracted the shared "will this move rename on disk?" condition into a
   needs_worktree_rename() helper used by both the new leading-directory
   check and the actual rename(), so the two cannot drift, per Junio C
   Hamano
 * allocate the dirname copy only when the destination has a slash
 * reworded the opening of the commit message for clarity, per Junio C
   Hamano
 * added tests: moving into an existing directory (destination is normalized
   to a full path), and moving to a bare filename in the cwd (no leading
   directory to check)

Changes in v4:

 * reverted to lstat and added has_symlink_leading_path() to refuse a
   destination that goes through a symbolic link, independent of the link
   target, per Junio C Hamano's point that Git tracks symlinks and must not
   follow them here
 * added new "destination is beyond a symbolic link" message
 * added tests: symlink as immediate parent and as intermediate component,
   symlink at the destination, -f does not bypass the symlink refusal, and a
   regression test that a move through a symlink no longer corrupts the
   index (see the reproduction reported on the list)

Changes in v3:

 * added ENOTDIR handling and an S_ISDIR check so a non-directory leading
   path component is caught, as suggested by Junio C Hamano
 * (v3 used stat() to resolve symlinks; this was reverted in v4 after Junio
   pointed out symlinks must not be followed)
 * fixed indentation

Changes in v2:

 * altered the error message to include both source and destination as
   suggested by Ben Knoble

Lucas Zamboni Orioli (2):
  mv: name both source and destination when rename fails
  mv: reject a destination whose leading path is missing or a symlink

 builtin/mv.c  |  47 +++++++++++++++++++++--
 t/t7001-mv.sh | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+), 3 deletions(-)


base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2356%2FZamboniL%2Fmv-detect-non-existing-target-folder-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2356/ZamboniL/mv-detect-non-existing-target-folder-v5
Pull-Request: https://github.com/git/git/pull/2356

Range-diff vs v4:

 1:  0d67da588b = 1:  0d67da588b mv: name both source and destination when rename fails
 2:  6b72efb413 ! 2:  6c2909e609 mv: reject a destination whose leading path is missing or a symlink
     @@ Metadata
       ## Commit message ##
          mv: reject a destination whose leading path is missing or a symlink
      
     -    Moving a file into a destination whose leading directories are not all
     -    present, real directories is only diagnosed later at rename(2), and for
     -    a symlinked component is not diagnosed at all.
     +    When moving a file, if any leading directory in the destination path
     +    is missing or is not a real directory, the problem is detected only
     +    later when rename() is called. Furthermore, if a leading directory
     +    component is a symbolic link, the issue is not detected at all.
      
          Three cases reach rename(2) unchecked today:
      
     @@ builtin/mv.c
       
       #include "setup.h"
       #include "strvec.h"
     +@@ builtin/mv.c: enum update_mode {
     + 	MOVE_VIA_PARENT_DIR = (1 << 5),
     + };
     + 
     ++static int needs_worktree_rename(enum update_mode mode, enum update_mode dst_mode)
     ++{
     ++	return !(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
     ++	       !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE));
     ++}
     ++
     + #define DUP_BASENAME 1
     + #define KEEP_TRAILING_SLASH 2
     + 
      @@ builtin/mv.c: dir_check:
       			bad = _("destination directory does not exist");
       			goto act_on_entry;
     @@ builtin/mv.c: dir_check:
      +		 * If we are going to move SRC to DST on disk, DST's leading
      +		 * directories must already exist.
      +		 */
     -+		if (!(modes[i] & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
     -+		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {
     -+			char *dst_dir = xstrdup(dst);
     -+			char *slash = strrchr(dst_dir, '/');
     ++		if (needs_worktree_rename(modes[i], dst_mode)) {
     ++			const char *slash_ = strrchr(dst, '/');
      +
     -+			if (slash) {
     ++			if (slash_) {
      +				struct stat dir_st;
     ++				char *dst_dir = xstrdup(dst);
     ++				char *slash = &dst_dir[slash_ - dst];
      +
      +				*slash = '\0';
      +				if (lstat(dst_dir, &dir_st) < 0) {
     @@ builtin/mv.c: dir_check:
      +				} else if (!S_ISDIR(dir_st.st_mode)) {
      +					bad = _("destination is not a directory");
      +				}
     ++
     ++				free(dst_dir);
      +			}
     -+			free(dst_dir);
      +
      +			if (bad)
      +				goto act_on_entry;
     @@ builtin/mv.c: dir_check:
       
       		if (ignore_sparse &&
       		    (dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
     +@@ builtin/mv.c: remove_entry:
     + 			printf(_("Renaming %s to %s\n"), src, dst);
     + 		if (show_only)
     + 			continue;
     +-		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
     +-		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
     ++		if (needs_worktree_rename(mode, dst_mode) &&
     + 		    rename(src, dst) < 0) {
     + 			if (ignore_errors)
     + 				continue;
      
       ## t/t7001-mv.sh ##
      @@ t/t7001-mv.sh: test_expect_success 'clean up' '
       	git reset --hard
       '
       
     ++test_expect_success 'moving file to directory without trailing slash' '
     ++	git reset --hard HEAD &&
     ++	rm -rf file.txt target && mkdir target &&
     ++	echo content > file.txt &&
     ++	git add file.txt &&
     ++	git mv file.txt target &&
     ++	test_path_is_file target/file.txt
     ++'
     ++
     ++test_expect_success 'moving file to a bare filename in the cwd' '
     ++	git reset --hard &&
     ++	rm -rf from dest.txt &&
     ++	mkdir from &&
     ++	echo content >from/file &&
     ++	git add from/file &&
     ++	git mv from/file dest.txt &&
     ++	test_path_is_file dest.txt
     ++'
     ++
      +test_expect_success 'moving to a non-existent directory' '
      +	git reset --hard &&
      +	rm -rf from && mkdir from &&

-- 
gitgitgadget
