Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7271B35
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708286383; cv=none; b=hbDpI4x/Opq4wf5ElCksVSHifnUFlaZWEXzSupnoWhOTROe8J+ela9z+w/BFTa+DbyasO7IvvmbkqZqjGusmrwISwfIVxmU/cvWn7/4NRsp2dEKZIse/okpe+8eKllTt6sKH7Y51bsqx5HmS/lyMWHJesTo1aYb4jPs+Or+7tTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708286383; c=relaxed/simple;
	bh=Z2bDYhksL+CXRB/xETwRFAWKPKVYFSD9KvVdD7WWdIE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o9nZy85xn7doz2sK//x3dDg2pehQEEIotSoqsuYF2V5EcybGXuoCjZK6QEYohr45alcDHMlqNw1zmAtRobEsa8rUHTkq6SzEFosqznmyRGDgnU4Aekt6vZ/sV2FR6KV9DS36pmYFrzr9RjXIJdwLIYvZNZOKSxU81gZBuL0GLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaAEwHQT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaAEwHQT"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3566c0309fso423531366b.1
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 11:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708286379; x=1708891179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WxpU1FDDdP6HDRe7xxrukEYGAYhx3my3zFELDMGBzU=;
        b=KaAEwHQTjcoX3MdZ1mCp8Jd4r3Y7jj7noBNByb+KherKdo6+mg1RYN0OVUgIghEZTW
         V3lAVQt3rHIMn5lsdUMwqAIgWEWTbnku6wM+34oU5KetLEa2vxxRp4eHYkJ2IVu6wyqh
         mt33LFVM8IGZ0Zz7OJFPsBx2/ewLQUPDnG3EymJgsojMg25pCKb4ggBBHah261jBWnpj
         XhJjzfu3oQ0ZAfDBummNjDpz/lHoAXCiwoM+015Gb8ZvC1w7hQdn4OiIm5jJ0U5OQtjR
         1kb5SnxwTrgExgZbi39MmeKBdYX8xRVpnOGAEg/E1UPBKqYYpXIBlc9uQlzVUXN1NtqG
         YZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708286379; x=1708891179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WxpU1FDDdP6HDRe7xxrukEYGAYhx3my3zFELDMGBzU=;
        b=GlnFIWzu7F4nqtQ2k9YvOZg3eajlZX24zsm3yyIwhZAKFPve03sYaeFJjmERrIOVof
         fl1vhczuyrtT0MMxmlkbrn1wrgs6mFw81WrlNmh/lbYarniVyN0M4EV1kKsfCDKQq3xF
         jXzmE34cgKFytmJYc76WBI1pRwy61oRJW50ueJEeWpo3pGwUO9iuNT7yBblkFlkZ5sP6
         qGcXEERQHKiV/cz1vdX76JmZ6XAzNVg0mBybWts62lW7VgBOGyBp88/RD8umD3is6gt2
         WvxgJCTELEViAhlVYUAOP5m5M6svw826dfMEfV3VHMZdoSfv0Pyq0/6FTLeu/CQfaXK/
         tZlQ==
X-Gm-Message-State: AOJu0Yx4feO4XBvaFhFTHbreVZn33t41qbyhIqORmvmPVJKJk4bQEmJY
	Vqx9rbJ5lc+G1v5qPZiAEPToK5IrGGA6dCtF56mgie/zfFfXuWjcXPKHr2TB
X-Google-Smtp-Source: AGHT+IEFVgZmryrIyFlvGr1FMUdFfEuIj8IDZO+hlmGqwB8jDs7100/caYoRadTmwRmcdmQiTOYp8w==
X-Received: by 2002:a17:906:1988:b0:a3d:5406:a437 with SMTP id g8-20020a170906198800b00a3d5406a437mr6218018ejd.28.1708286379341;
        Sun, 18 Feb 2024 11:59:39 -0800 (PST)
Received: from mkb-desktop.bosmans (89-224-201-31.ftth.glasoperator.nl. [31.201.224.89])
        by smtp.gmail.com with ESMTPSA id dt14-20020a170907728e00b00a3cbbaf5981sm2206999ejc.51.2024.02.18.11.59.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:59:39 -0800 (PST)
From: Maarten Bosmans <mkbosmans@gmail.com>
X-Google-Original-From: Maarten Bosmans <maarten.bosmans@vortech.nl>
To: git@vger.kernel.org
Subject: [PATCH v2 0/5] Speed up git-notes show
Date: Sun, 18 Feb 2024 20:59:33 +0100
Message-Id: <20240218195938.6253-1-maarten.bosmans@vortech.nl>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
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
`setup_pager()` call and some optional textconv stuff.

The second commit is the main one fixing performance. The others are just
eliminating some overhead I noticed when going through the git notes code.


CHANGES WRT V1
  Sharing of the show_blob_object() function from log.c. The intention here is
  to have `git notes show` behave the same as `git show` when in the future the
  latter might be changed to have more sophisticated behaviour for some blobs,
  e.g. launching an image viewer for PNG blobs.  Non-blob notes are still not
  handled, just like in V1.  Current master does handle that, but that is not
  deemed a case worth handling.


Maarten Bosmans (5):
  log: Move show_blob_object() to log.c
  notes: avoid launching a child process to show a note blob
  notes: use existing function stream_blob_to_fd
  notes: do not clean up right before calling die()
  notes: use strbuf_attach to take ownership of the object contents

 Makefile        |  1 +
 builtin/log.c   | 39 +++++----------------------------------
 builtin/notes.c | 38 +++++++++++---------------------------
 log.c           | 41 +++++++++++++++++++++++++++++++++++++++++
 log.h           | 11 +++++++++++
 5 files changed, 69 insertions(+), 61 deletions(-)
 create mode 100644 log.c
 create mode 100644 log.h

-- 
2.35.3

