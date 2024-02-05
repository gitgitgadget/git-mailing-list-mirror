Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF7138485
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166185; cv=none; b=tHPikPYAYU3npxiyuyxedSNWV+Ktfmk5435Gnuqi2uFVUMuy3WSgV1/z1RwP59MOXuQVwUkKvZMgcQPA1bP/gu916mHD4+jK2G47Q3azOh3JTzmWnwTfnm4Y4JHyKmPolmp9pvi6ImBexekkvgCScg1c0yEY++WxW2syqaHdMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166185; c=relaxed/simple;
	bh=ovf13zB/TGZZyIVE4hBUyHGVfxb6MD7EaDoKYdlbDyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hLzhOXVNvJIZOcmxYEjvNnFKMKCq1YVmlLjz2iet5aUuWbVR5qHsM7gd3eqlgD0P3FSqLjygMWmuJ8RLXzjczJrr7a4uGZD5/Gg10BWAV8o5QdHaT7MQKpOybq7MaFPu5+FkzUAPCwx8dKOJsmQXZNon9F/3V9jf/BKLL715VbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD5BULg9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD5BULg9"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56061ad3d3dso2462027a12.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 12:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707166182; x=1707770982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oCepzQyZ/wAvMnkSoDNKnWLVfY0vKNyHXg1nJJdFvv4=;
        b=hD5BULg9wg9mAcryMCFoPhLfaMghZtuc+LZsXuwdM0Fbs1Qf5HOLzg2YTHudLvbfLA
         RPeSLWszTbyEkrt03NuLi8PgHN8IMDh5aB3Eb+o4A1rjuT98xnnrgnzGsvur8mKe9gan
         ILUxDx0XxHimLj/5v1S9DZawwH5u5vKWBfXbEtasT1lZsb18Wiv1UhBJ0XER6/SuDY9f
         lzb5RxvPyIFSTiNiy8pdoeNmEnDbGzcC1YpxAKkwfg6YvZ184EcswONWGCutnIMlLc+F
         N9pKgAsYzC8OXMBZYQi3Y5fPvh5jeO4TVC23JWULeCnUwHShHQB30iRQM6FNEv8n2y8f
         bq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166182; x=1707770982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCepzQyZ/wAvMnkSoDNKnWLVfY0vKNyHXg1nJJdFvv4=;
        b=wFwn5PP8S10r14aE+6zQ9c675bXrGD2V5AQ8IZ/tZWjyMCUSLsNScAzDke3u3nxMgu
         rpC9cjto/xMvIODSv9AUzPlwodU5tncYC1CuN9+RDIwqmlQjtCrbHJLe4SWVYte6/Rzt
         82yctUMnQh7NoAHNVlzuC9ECAE7PHmS/ZzpivH+gCUO1FtFRhmmOYosz9iCBrqV6wXN9
         ApDqYrlVJTb6AjhBGYb2U/toRHqOhv2GXEUvZWQm/2C4Z+RNfL+ncUxzsaCsH5cVrxrb
         yDsNJtoA1VT1FGOeY/5HRZDWycEK/iWU0GQMPliONaeqkmcvNaT4+kK4PT1nEV3Zt8EK
         EXeA==
X-Gm-Message-State: AOJu0YxFUaakfjJMPvfBXJG/mBFWnmnOuHCvOVhbHtCMymnPFEohyrCs
	u6r4pjJnKCeyTHfUBBQAxabtTZiFJJjL2Jl38JglFRs0cPaiDs+zHcs9KNQ+
X-Google-Smtp-Source: AGHT+IEUb2aggZQuFHqUq4xTwf+IJ9NL9bICUNnTqswPunBodGoNrQCKA06W4I63MA/cow7j2skpvQ==
X-Received: by 2002:a05:6402:391:b0:55f:ec15:234d with SMTP id o17-20020a056402039100b0055fec15234dmr716375edv.1.1707166181788;
        Mon, 05 Feb 2024 12:49:41 -0800 (PST)
Received: from mkb-desktop.bosmans (89-224-201-31.ftth.glasoperator.nl. [31.201.224.89])
        by smtp.gmail.com with ESMTPSA id be28-20020a0564021a3c00b0055ef4a779d9sm275551edb.34.2024.02.05.12.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:49:41 -0800 (PST)
From: Maarten Bosmans <mkbosmans@gmail.com>
X-Google-Original-From: Maarten Bosmans <maarten.bosmans@vortech.nl>
To: git@vger.kernel.org
Cc: Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 0/4] Speed up git-notes show
Date: Mon,  5 Feb 2024 21:49:28 +0100
Message-Id: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First time contributor here, trying my first git.git patch series.

BACKGROUND
  We have a script that runs a range of build tests for all new commits in the
  repository and adds a line to the commit note with the result from the test.
  Something along the lines of:
      occa-build-jit-gnu-cuda-develop: PASSED (<hostname>, 2024-01-01 00:00:00+01:00)
  Pretty useful to quickly check that all commits at least build, not only for
  master, but also in progress feature branches.  (a passing test suite is
  generally only required at the merge point)
    
PROBLEM
  The bash script loops over all remote refs and lists the commits newer than
  <N> days ago.  For each commit its note is read and grep'ed for an existing
  test name to see whether the build test needs to run again.  The `git note show`
  command that is in this loop nest only takes 14ms to execute, but as it is in
  a loop, those times add up.

ANALYSIS
  When asked to show a note for a specific commit, git looks up the blob hash
  for the note and executes `git show` with that hash.  That of course adds
  the child process overhead, but also causes the initialization of a lot of
  log related configuration, such as for decorations or the mailmap.  Simply
  outputting the blob directly in the main process reduces the run time by
  almost halve.

When looking through the git show implementation for useful stuff that command
does that should also be done when showing a note, I could only find the
`setup_pager()` call. All other git show functionality was related to showing
commits or other non-blob objects.

The only thing I was not 100% sure of was the textconv_object stuff.  From what
I could deduce was that this is only ever used on blobs that represent files in
a tree, not on blobs that represent note objects.  So I did not include any
textconv calls in the git notes code.

The first commit is the main one fixing performance. The other three are just
eliminating some overhead I noticed when going through the git notes code.


Maarten Bosmans (4):
  notes: print note blob to stdout directly
  notes: use exisisting function stream_blob_to_fd
  notes: do not clean up right before calling die()
  notes: use strbuf_attach to take ownership of the object contents

 builtin/notes.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

-- 
2.35.3

