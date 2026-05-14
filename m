Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9873223707
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769225; cv=none; b=OVOB9YztgZ+2VSOZJegVy13jUE23xraWPjQpfEmcziUStJ/BAn3hoHaz7eRaX/c6UkM/dtRSOS6FvoMnVw6w4uEn8pRmy9BIliT95rx7UnqEYLlikbU/by2f2Dpii60Gz5L6vh8rdmzrNwuX4wGxqu//A7qtjLf9bb/HXcViXV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769225; c=relaxed/simple;
	bh=YbmACli+WciggkBi6d9jqk/UKuXolG8zsWWEa43jCI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kd1Tm2otfvHN447u5Ofp8aR9IarLG5OvbRmpKLyVQSnMe3j8gERVu1gw889+NDIukkjd3cMQOp+tFLY0nIptVUYQ3qOquhDHd6fa07IxTGMyRjiiV4GErsOpqsHotNjHaHps9RH/Tw0gb6iX/xD6j4c1tUFFrYDGDwQai3xb35A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3G7xy0e; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3G7xy0e"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8f231f3b130so620397585a.3
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769223; x=1779374023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnyaKJlY+JX2bOPiZw/cbcEAlMRde+8bJDEi5AZA24g=;
        b=m3G7xy0eC7I+FsqvCiKLyLiIhdDNBo3BuPoTt2YEx8pr1e1rrEQAcKWlAEKbpog78e
         8f+PdWgxnz9jhmZXsHRWgEeoQ4C4Ra6fPo7WzvIgQSLN+oEltQpex6BNlsACkR146XmJ
         S1+J0dqJ2qNiEcrnfxdONS+dKKjIJMz6UtJzkAe+ntFzf5yKaTo10zr/AwY5NFVbBjq8
         rNiiki2BXG6E2Xrf/i0s/AaZ5RuLcQVJ/TQkrLTLQpIaiENTdV6ZgL60DgGhLlvCl8ie
         co03DQQQXPlbTnDxqd4fDw8IHSL683TE06DGY5yb43Ss48Z1qqo+Vy0ehGsAJUeNwKDE
         RnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769223; x=1779374023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rnyaKJlY+JX2bOPiZw/cbcEAlMRde+8bJDEi5AZA24g=;
        b=a7yFU0BHmVG2RjhanpHEPziefyfnx8TupWj+KIdN6wRVf3h6Sht+qJk1jwkqt4GMhW
         WjahAstQJWH4pq2SuTdda+YYkF25dWBFaP1PtEeBIXCW1MDIm40marjvg7weHYcx31qL
         I93K7CP9ZMLlKvvRzSK9rvM0TXRK23JYGNk1jgJG6XZ/h2nl+6k4NGRIFk9YdVvURMz3
         qhck+Iex62135XXvElm7ipQvduqm6YluPXQXK4uihjGXUPGWIt7GQBaNDrQBZ/+0u3jH
         nLHlGqDKDD/j6i0P39hatAc7HbTY33PV9ZBjKv33UqctdLPEyqk+mhsMwKAyYY13hgzv
         mW3Q==
X-Gm-Message-State: AOJu0Yw1fU4+qUr9/7ewON4E0u6xAipHt7N3hhZmmisRpB6zKy4011I9
	HSWmWmJKde214IDGwrFd1r2aG3PF7x9SPJUApzAb/GVW5jRFQanprhzspz7jcQ==
X-Gm-Gg: Acq92OGD7enMyG2gloTrW8tHOBOJYYQ9v6AWGGcLHDHdALECQGijwnf0X1dBofra+qt
	zECbTvvrf0c4yvsWe71bJ4HTmO4cMacB25Sfljr8spcCoXT++4QuiljYhW1m51ot6R6K2ZLVPFi
	AHXQpvuqsd2Ra/tD78CusK/vc7q6CSnfZazMDdSWUqBztkcAla93yFT13Fsajh4w7bX2blPJ6Pu
	M2Iqmat2BPZBJsyZxxC4FX+pREQ1yV+Y8FV4XyzVgCiRXfG3W3WhV6EbPFrbIT+4xZ2Qb7pscWi
	zkPaTvyt2W/GUF0dUlf5rPIZcBAb8FDzfRVi/npo3NwcnTMzJ8qxBRUKucjiUkeslABnyfehybH
	OpVU8qtQKVZPoxyYQAREpiE5YCasjjeJRuMiqzCE8hGt+WL0ti21JXi86uemH8Ondq6I3WCq6SO
	xekh37iwg=
X-Received: by 2002:a05:620a:40c7:b0:8c6:d309:f9c0 with SMTP id af79cd13be357-90fab32843fmr1123728085a.8.1778769222725;
        Thu, 14 May 2026 07:33:42 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm262768585a.19.2026.05.14.07.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:33:42 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com,
	j6t@kdbg.org,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 00/11] Improve git gui operation without a worktree
Date: Thu, 14 May 2026 10:33:11 -0400
Message-ID: <20260514143322.865587-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git gui has a number of inter-related problems that result in problems
during startup from anything but a checked out worktree pointing at a
valid git repository. Some of the symptoms are:
- blame / browser subcommands, and launching gitk, are intended to be
  useful without a worktree, but fail to work.
- unlike git, git-gui is supposed to use the parent directory as a
  worktree if started from the .git subdirectory in the very common
  single worktree + embedded git repository format. This does not
  work.
- git-gui includes a repository picker allowing a user select a worktree
  from a list and/or start a new repo+worktree: this dialog appears at
  unexpected times, masking useful error feedback on configuration
  problems.

This patch series addresses the above issues, substantially rewriting
the blame / browser command line process, the initial repository and
worktree discovery processes, and using git rev-parse when possible to
handle repository / worktree discovery including any specification of
GIT_DIR or GIT_WORK_TREE to reduce the future likelihood of conflict
with command line git. This also allows explicit user control to avoid
the repository picker masking a configuration error.

Note: I question why git-gui ever exports GIT_WORK_TREE. If it is not
empty, that is the current directory when startup is complete and any
git command will use the current directory as the worktree. If empty,
there is no worktree and the current directory should be (and after this
series, is) at the toplevel of the gitdir: again, there is nothing to
communicate to another process. If a process being launched needs a
different worktree, that should be the startup directory given to the
process without changing git-gui's current directory.

Mark Levedahl (11):
  git-gui: allow specifying path '.' to the browser
  git-gui: refactor browser / blame argument parsing
  git-gui: guard set/unset of GIT_DIR and GIT_WORK_TREE
  git-gui: put choose_repository::pick in a proc
  git-gui: use --absolute-git-dir
  git gui: GIT_DIR / GIT_WORK_TREE make any discovery error fatal
  git-gui: use rev-parse exclusively to find a repository
  git-gui: simplify [is_bare] to report if a worktree is known
  git-gui: support using repository parent dir as a worktree
  git-gui: improve worktree discovery
  git-gui: add gui and pick as explicit subcommands

 git-gui.sh | 276 ++++++++++++++++++++++++++---------------------------
 1 file changed, 135 insertions(+), 141 deletions(-)

-- 
2.54.0.99.14

