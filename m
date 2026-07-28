Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3A42CAF0
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239200; cv=none; b=ql1BQDCANV9W49isc2qIoSKmess2VmTcYQOOlSWNnPkS7i1ezjjli3mDfwpNdxqnL0keJUbMy9ynRr42bC1Ycj2de8rO0o6vaef/oQNrxhqW1qxpvwoZPsH/UhXBuB1VhcGxByVNitoac1Na44utogxL9tJumicsPCgQcuZ+yiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239200; c=relaxed/simple;
	bh=Y6b7Rl6FiOuBP15lPakbs85+YfzdDbbyzYHas3eSSEU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=b0kujtcyoiqQboNIoTfTb4u+gp8GLJepJs6+TmRZi7jySSTx034Wt3IIVP6q72Y6tx4AK7Z1KCsQ5ylFqTRzTGltv2pye5OypI0t5vex9et0jYBvAek3uHV7GxrVJ7MmU4kWR5H4y8+60qJ9J0B1DnzwDQD1/nKJYqzn1y88j2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xps+vUtr; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xps+vUtr"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7ebd88be784so2747176a34.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785239198; x=1785843998; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NA3yZR9XobX/VrH/9S/njipuw2CHd/2/uHnjWqwrgu8=;
        b=Xps+vUtr1BBcyXVMrcO5y0LcFqCR7raxirLyQX5yQr6uknWRIrDGjesus6SR4iSG+t
         F7J6jtdcxIrlVnqBJW0AtwraEj/86mM5f+2dVc2B8iYQdPwXF9nLwrHE1Mmv9Hp7F5BT
         eSaCQsNkd8bmLLHTcmbIg1yQF+pNjUucs3ZE7dKy9qrmM9S7olpuZNRJBzxPHdMXU86T
         gJixrCNXw5UZ0oVCN/ezpWc0Naq8ZGcGmwrC/FVNOVXmPLCbxDaS6vd2+3goZPOrfnvS
         mZOVdxMdWEFq+bRHZ57b2RvAwd+gPiUvMRjL5VaD+DlmncvfDbMD1CR4/D6yGRu7l7Ix
         z2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785239198; x=1785843998;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NA3yZR9XobX/VrH/9S/njipuw2CHd/2/uHnjWqwrgu8=;
        b=iOPhjQS1l8jFJ4xKY1RxTyARPVbPe+LHAGb6D5dbxzCosXg4yTuZA12dx58CFTELTr
         LR9V0wfu5n8JjEByPp6BofbB/jqyFfSEIujt55pvUosIpMv6C50wAVJ3NjwVQmZ+8Oko
         nDyQpj4ZMx+qodfNOPyFw1aNMB43beuAlASfulKlGbOgNe1+M0Gw5/OQH49TT2ih89qZ
         HRyxBfu2sQgh8RfNCn3g6v3URFm922eqIR+oFRlrV79zqxHmLNZ01mSEee2XNyHlUugQ
         N0V5wN42+e7oBjuHBGAImR2+QcY673jj3NNClLWRXVbpm07Kzg2W9OTWs+SXwHdaJAbt
         PPRg==
X-Gm-Message-State: AOJu0YyeW+XgVlYnUVH+UlP10pbWT9xP1v022b14sWMKZnqGITcWmdzF
	dIj1WfRg2bv1oobMPa+pQ6CuHM39M4LMQHq1uY2NN8R041keiVuDu0dcuZF7+A==
X-Gm-Gg: AR+sD11/si+tRnwgG3uyEvT6Fypa+JC89MocOxjwyi3bhNpKTBlptSrMAho6GklJBIQ
	qcChPUk3gHhg0wM5G5LZ5jeWTMwOWN0Z5vGGLYdjXOjXK9kcNw2pNtHRlQ0/4JXVrttSfHindfP
	06ZZf6OuvApgqh9TtkqeZpYE0jtThw4Y+gE+0Ep73xQtX9oqLyK+CsV72HHXA0tL4zm9cmsr3FT
	+vEyvhunafWOd3+A0eVtpDPJ40Kvac4Cmv19Q0NtYyEknFk9O8eOlVDDGJDp9EGALm3S4B9izqZ
	Bq8OBqcnL2nw2ehAToyWOLOtY2BGbbatdSnzwJwAFDoCOaxmnqqkFzgMY+xubjokSQjwXoxCtwV
	vIfKl/4CPVvYHjGNbLcWiGAghNPF2j7lJD7QDrj/I+CTcomWHTtaUslaEFcnutGsunjCc9wSnyg
	L5eE74wQ==
X-Received: by 2002:a05:6830:6ad6:b0:7e7:7de:ca8a with SMTP id 46e09a7af769-7efff2bc79cmr1167756a34.22.1785239197670;
        Tue, 28 Jul 2026 04:46:37 -0700 (PDT)
Received: from [127.0.0.1] ([52.242.242.176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a1087b3sm14595142a34.25.2026.07.28.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 04:46:37 -0700 (PDT)
Message-Id: <pull.2189.git.1785239196007.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Jul 2026 11:46:35 +0000
Subject: [PATCH] mingw: skip symlink type auto-detection for network share
 targets
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, symbolic links come in two flavors: file symlinks and
directory symlinks.  Since Git was born on Linux where this distinction
does not exist, Git for Windows has to auto-detect the type by looking
at the target.  When the target does not yet exist at symlink creation
time, Git for Windows creates a "phantom" file symlink and later, once
checkout is complete, calls `CreateFileW()` on the target to check
whether it is actually a directory.

If the symlink target is a UNC path (e.g. `\\attacker\share`), this
auto-detection triggers an SMB connection to the remote host.  Windows
performs NTLM authentication by default for such connections, which
means a crafted repository can exfiltrate the cloning user's NTLMv2 hash
to an attacker-controlled server without any user interaction beyond
`git clone -c core.symlinks=true <url>`.

There are ways to specify UNC paths that start with only a single
backslash (e.g. `\??\UNC\host\share`); All of them do start like that,
though, so let's use that as a tell-tale that we should skip the
auto-detection in `process_phantom_symlink()`. The symlink is then left
as a file symlink (the `mklink` default), and a warning is emitted
suggesting the user set the `symlink` gitattribute to `dir` if a
directory symlink is needed.  When the attribute is already set,
auto-detection is never invoked in the first place, so that code path is
unaffected.

This is the same class of vulnerability as CVE-2025-66413
(https://github.com/git-for-windows/git/security/advisories/GHSA-hv9c-4jm9-jh3x)
and follows the same general mitigation pattern that MinTTY adopted for
ANSI escape sequences referencing network share paths
(https://github.com/mintty/mintty/security/advisories/GHSA-jf4m-m6rv-p6c5).

Note that there are legitimate paths starting with a single backslash
that are _not_ network paths: drive-less absolute paths are interpreted
as relative to the current working directory's drive. In practice, these
are highly uncommon (and brittle, just one working directory change away
from breaking). In any case, the only consequence is now that the
symlink type of those has to be specified via Git attributes, is all.

Reported-by: Justin Lee <jessdhoctor@gmail.com>
Addresses: CVE-2026-32631
Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw: skip symlink type auto-detection for network share targets
    
    This was released as part of Git for Windows v2.53.0(3) already.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2189%2Fdscho%2Fskip-symlink-detection-for-network-shares-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2189/dscho/skip-symlink-detection-for-network-shares-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2189

 compat/mingw.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3eca3a7f2e..2b0d162d49 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -352,6 +352,29 @@ process_phantom_symlink(const wchar_t *wtarget, const wchar_t *wlink)
 	wchar_t relative[MAX_PATH];
 	const wchar_t *rel;
 
+	/*
+	 * Do not follow symlinks to network shares, to avoid NTLM credential
+	 * leak from crafted repositories (e.g. \\attacker-server\share).
+	 * Since paths come in all kind of enterprising shapes and forms (in
+	 * addition to the canonical `\\host\share` form, there's also
+	 * `\??\UNC\host\share`, `\GLOBAL??\UNC\host\share` and also
+	 * `\Device\Mup\host\share`, just to name a few), we simply avoid
+	 * following every symlink target that starts with a slash.
+	 *
+	 * This also catches drive-less absolute paths, of course. These are
+	 * uncommon in practice (and also fragile because they are relative to
+	 * the current working directory's drive). The only "harm" this does
+	 * is that it now requires users to specify via the Git attributes if
+	 * they have such an uncommon symbolic link and need it to be a
+	 * directory type link.
+	 */
+	if (is_wdir_sep(wtarget[0])) {
+		warning("created file symlink '%ls' pointing to '%ls';\n"
+			"set the `symlink` gitattribute to `dir` if a "
+			"directory symlink is required", wlink, wtarget);
+		return PHANTOM_SYMLINK_DONE;
+	}
+
 	/* check that wlink is still a file symlink */
 	if ((GetFileAttributesW(wlink)
 			& (FILE_ATTRIBUTE_REPARSE_POINT | FILE_ATTRIBUTE_DIRECTORY))

base-commit: 13c7afec212fc97ce257d15601659314c6673d6c
-- 
gitgitgadget
