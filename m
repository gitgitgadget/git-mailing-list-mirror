Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF963CC9F6
	for <git@vger.kernel.org>; Tue, 26 May 2026 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782595; cv=none; b=XYCq0JwRLZnPygI5GYztzoZCeUMuyz7fYgfSLMLg66FuuHyFlYdyougLw0YSvjUJDuy1NZPsGysSCth9R30MW0ac7uxBeW338tjKaQ36ejek/XhhVNTfOW/XKl6yGBNK2JTPPJZiK8kJdDthLRkJSHI5yHfuMppNuQZZsdgC1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782595; c=relaxed/simple;
	bh=1xB/72yNv0HXiuBbVlsw/0UIxgllbJA0uWUkhssFkAk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=O/BQ7WIDI1pGTSirX8dNG677MN2T/Kr/y9J8h9ybtan8pvh9ntkaKXY0E5vyOAEQhdSBa9TOzvbdmBefm3KO+bZBodHfkGH6YXt0qv2POb8ZtlG6o0dH/b1vdXeQVuUMZiitvKj1dNgmivoDJPxpxRzXDTpjH6izUzyGdGQMHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0W6DhLb; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0W6DhLb"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-914c1ced558so161200185a.3
        for <git@vger.kernel.org>; Tue, 26 May 2026 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779782593; x=1780387393; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O7Ha1Ld+Idhn6jh1x/ua7SZIa52/FWWtLvDuLftr45E=;
        b=A0W6DhLb7x61nOLMfz0B2U0AddIzDqqPHdexvwadmJfCMFzQi/9hRMJjPvnPC0QM5H
         LjtO4lQ7dsLojJcbtQgTGwUgoKTnbWmVnIJByeWE+kBAUg1yQ3dNHuXh9j/XkHeEBcO1
         zbagNRGId/CGcqMH+qWoRx+A6AZQzvLW83AgQdN40nhOdCC3Vr3+XREpKaVxBGAjUb/C
         h5ogPVK3cjIh5BWlTY9YEXVb1KRtw0a/lvX6dSUcxcAd4w920Y0MyppCQKRFCIL+uDUx
         GVPJpf9CB4fmi/yAlt6xsCgcm7umznN6bZSXw1ekeneGStShVrKNiQ6VLY+KBWizOjRp
         L8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779782593; x=1780387393;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7Ha1Ld+Idhn6jh1x/ua7SZIa52/FWWtLvDuLftr45E=;
        b=lXCg13DOADLDhHIQY4IaPYHLWgQn0bZ/59w53iJknajuxce94HpphautuY030Q66vl
         Wf7tPitnCP4bX8Vvipjia/5Zvpw4zpWK+mGTg01JU957r1R7as2uss0AM/BR0FIExfvi
         3k9fygPfGQfegMC5PqO/Cy9lMI6MRoHhqnwzBSr0KHoBy+QIq+NdnnGR91UkThm+23+0
         Zq8grkTk+aKTaKkTPn46inFAgBCJ2Km+/Mut1It9qGS0UIset8t/mOZ/i4pBRXlT/iUX
         WIiTGFAzj7PRI/aMs/q6pR1GFXY6eNnXJli/1EsCepVYWAgJ5L6NbsKwjI2/0GB7as3M
         xWCQ==
X-Gm-Message-State: AOJu0YyauPjAAjtjAmQjbJzjjCfedhMe2mZyu0kGNxMMt5UW0cf08Q/n
	IMkeTfMPAbxuwkk2/bhlfA0I7XHpLSmbYcd9uIIBSHEVdVuoz461qiOwAF3SoQ==
X-Gm-Gg: Acq92OExh0wS/4Q30gI36sM3UuhiGgveoz0FMVZ7tLki4Bque7g2oiixF32ZBGOPerD
	Mz9szFDs5Kr/FsLEc6c4JxfESjWoS0kQNWb37DhNu4EUm8p6vKTh5LikRyRKu+6cKokgl1Me4nu
	62ky8LtDLEpWIeOXo/OSPRP2dmqRjsWypjXiY7NSyMDLKPF1XW85ztPPXW2d4opRQuUjXwBDoBj
	fBEpFB3UFJWFjAetrkQ1yIVBpC71T5cE4npmN2mdJYapGPsrVCErIabj/SftUCZfyg4FgRpJfVB
	cffr+I0Zsp24NoLjR005+bP6uW1pF1CYD41W6iaVmgWfxA4K5IbhXMzlNPhoj43LkcR3eQHP3bo
	Ku9Aw9+Hv0lTTGy5fJjG7TMhToZFNiV8gInhfwrHymtHppoo0I5c6oaS3XwdM/h4m1wlA+HAlFn
	GAHqqtGtIwlQwStIcVqu1BR02xdoo=
X-Received: by 2002:a05:620a:4484:b0:914:ca61:2667 with SMTP id af79cd13be357-914ca618ee5mr1480698585a.59.1779782592891;
        Tue, 26 May 2026 01:03:12 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.122.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87d1b66sm144096785a.29.2026.05.26.01.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 01:03:11 -0700 (PDT)
Message-Id: <pull.2125.git.1779782591.gitgitgadget@gmail.com>
From: "George Giorgidze via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 08:03:08 +0000
Subject: [PATCH 0/2] update-index: add --refresh-stat-only
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
Cc: Junio C Hamano <gitster@pobox.com>,
    George Giorgidze <giorgidze@meta.com>

This two-patch series adds "git update-index --refresh-stat-only", a
one-shot way to update the index's cached stat data to match the current
filesystem without rehashing file contents.

When a working tree is produced or restored by means other than a normal
checkout -- a CI cache restore, container provisioning, a tarball
extraction, or a copy from another machine -- the files may be byte-for-byte
identical while filesystem-local stat fields like inode and device numbers
no longer match. Today the available workarounds are to (a) pay for full
content rehashing on the next "git status", or (b) set
core.checkStat=minimal, which is sticky and weakens every subsequent
operation. Neither composes well with modern container-based CI, where every
job step would otherwise need to set and preserve the configuration.

A similar idea ("--assume-content-unchanged") was discussed in January 2017;
see the thread starting at 20170105112359.GN8116@chrystal.oracle.com. The
concern raised there was that exposing a way to update cached stat data
without content comparison opens the index to abuse. The flag in this series
is deliberately narrower than the 2017 proposal:

 * one-shot action, not a sticky config or per-entry bit;
 * the name describes what the invocation does, not a trust state attached
   to entries (contrast --assume-unchanged);
 * intended for closed-loop callers (CI cache restore, container
   provisioning, backup/restore tooling) that produced or verified the
   worktree atomically;
 * the failure mode -- stale object IDs becoming invisible until the next
   content check -- is named directly in the docs, and the flag must be
   typed explicitly.

The series is organised so the bug fix is reviewable on its own:

1/2 preload-index: respect --really-refresh override of assume-unchanged

   A latent bug observable today via GIT_TEST_PRELOAD_INDEX=1:
   preload_thread() never sets CE_MATCH_IGNORE_VALID, so it
   honours the "assume unchanged" bit and marks modified
   assume-unchanged entries as uptodate before the
   --really-refresh loop sees them. Plumb refresh flags
   through to preload threads and add a regression test under
   t2106.


2/2 update-index: add --refresh-stat-only

   Add the new flag, extend the preload mask to also recognise
   REFRESH_STAT_ONLY, document the assume-unchanged override
   behaviour alongside the flag, and add coverage for object
   ID preservation, missing-file handling (with and without
   --ignore-missing), assume-unchanged override, and quiet
   output under t2109.


George Giorgidze (2):
  preload-index: respect --really-refresh override of assume-unchanged
  update-index: add --refresh-stat-only

 Documentation/git-update-index.adoc       | 19 ++++++++
 builtin/update-index.c                    | 12 +++++
 preload-index.c                           |  7 ++-
 read-cache-ll.h                           |  3 ++
 read-cache.c                              | 24 +++++----
 t/meson.build                             |  1 +
 t/t2106-update-index-assume-unchanged.sh  | 11 +++++
 t/t2109-update-index-refresh-stat-only.sh | 59 +++++++++++++++++++++++
 8 files changed, 126 insertions(+), 10 deletions(-)
 create mode 100755 t/t2109-update-index-refresh-stat-only.sh


base-commit: 56a4f3c3a221adf1df9b39da69b8a6890f803157
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2125%2Fgiorgidze%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2125/giorgidze/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2125
-- 
gitgitgadget
