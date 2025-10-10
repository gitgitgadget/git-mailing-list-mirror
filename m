Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCC222587
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092037; cv=none; b=WWTH/UmrJAT0Fu3W+rCRiSWTsX2spu+NNCeKEBljIRgmkVt6T1UkcIOzTT5t9aEXEIRtpxeCgcn83XejzhI9M5Tgic02fcalHoOtflZTtKGBnaqq+ZmQacbkz+nv0iREHPWY/3MM5FI8syk3sOMZGkWV629i9IzCti1mxCJaQNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092037; c=relaxed/simple;
	bh=QBxmGvHS6+Igp62eCc0VIL6Sm9c+8AUrbv60YQPq3Lc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zp4QZ6gP+jfBeYrGj+gBZ9mD4kqqoJCd31b0gXumDmTO33xDvh8pBIbchEaavaYg8+viZfYfE25x1JEPnxxDLn23uRV7zbcxdZde/zRCpZE114CFP4eMKtJ69iTr4QS+7BNP4xwL1vorjCNzFy+thSFNPgacrPhO8M9Hh735MUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B30Yt99Z; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B30Yt99Z"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso4111697a12.2
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760092034; x=1760696834; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3GOKGge5yJz0XjgIGHN7FIPaavrCwCtY3nV7xl+wdY=;
        b=B30Yt99ZPU9qxLOO/ljYL3kxJ5ffth1dKuv9avLINaQ+rM0eo5ATOCgaqwGIQXWqym
         sWewt5XPvR99HMXOaZ2d9r9Obg7xT874ZV1c97B50AlOlbnwDbaokOKnL6hQ/kYOQZZh
         H/VVP/Hyf6pa67qUQ/7nGAf9rqM+4EGcjzEyOLIp8MxymI3pNTUdluNKDurJwyxyRdgp
         6iey4t0NdIF9yrUc3VmOACcpiByg57TW36DlGHPlNRVxKGPxc9t6BpWsuTlUamP1HK8k
         M8iEkW8z6kgvJtDjEzzPwnW114mDiIbXfU0yfEMSt20SLUK2erKxhr31IlG7b1z4yaZ1
         t1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760092034; x=1760696834;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3GOKGge5yJz0XjgIGHN7FIPaavrCwCtY3nV7xl+wdY=;
        b=WweQVBaNCYnIqPAvu64wXWHSMrKw4mSoH9UxtRp9xdtB/c6Xc927r5jmTb72LPqdnW
         yXx28PKyZAWDt1AbwmdYkSRNjLN5XJbLQr6XO2nToeCKrLve8YliEUkK+22ap1SGxEWK
         y75K99Xcv8V6KF42MTyK3BMSCQxJTggmPyDcCfQaCy9TBzgpkGuoQDS4lJg1sZ9BInQ+
         pn1NySviuQYaOHhNfLaMsuF36pdlM1i8GJUV7c5Rwi7//SEnpRbvyxXnK+17TQPblSr5
         70gHN/I6y2/rkQ9spoaRouPaVd1Bk0tXua63ValNeGPguZ7nNUV8+dlaQzDCzZHbvKU1
         poSg==
X-Gm-Message-State: AOJu0YyNAOh0DldhfClF2SFdne6AqeaCaWACefy/3SXZbG6GdvRStPVe
	eOIjM1ugnmerPLsouN3OijKMlX1D6d3OJaN1ofeV5wNJAU0n4A26FgYbC4BCfq8F
X-Gm-Gg: ASbGnctJ2oiGgV08fbv3D/DhzEVqWBmPif6kkzsbDnT3Dmg8sLM9v007oPIILCkPOze
	2F44DmW18sHt3O894Rn558owXAh5azeFLxYmNy7N+Tu833uTH19WlYjLvibYdnaC4mwKvKv56S7
	WAY+ePTvwDQswHfkAG9waDntT45+DYrS4VJObZ1ATEut8eADycckTDeDCA7kde4T/woJ6QR5M/B
	Ix1jRmV/HU+pmMfbEQ7CdZwn3fC2WSMd/nfiiNrX3npxNz/3nggu7k8FGFNAdoAj/ikvjRniMwS
	k5H9YML05rlL6BvEq2ewY+VF3ctApEJndyl2QodWP2841Jo4vo7BInggbD/VV0eFYEmZ6GyF7AE
	RRpTT5zoFLy0ugyMjJBB3wpha2W/o2NA7B0qtt+whztvOisG6P+dKOgkFZQ==
X-Google-Smtp-Source: AGHT+IEeZGzRwmwtxGdi4KaNOFMO9ZjSvcU1kwUCNkO1fUnjV/NbEijZFzq05hOERaZnRxNHHGN0Xw==
X-Received: by 2002:a05:6402:3591:b0:639:dee8:703c with SMTP id 4fb4d7f45d1cf-639dee87560mr8674763a12.18.1760092033477;
        Fri, 10 Oct 2025 03:27:13 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:70de:2d8a:d550:c37c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f750sm1960729a12.14.2025.10.10.03.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:27:13 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/9] refs: add a '--required' flag to 'git refs optimize'
Date: Fri, 10 Oct 2025 12:27:04 +0200
Message-Id: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHjf6GgC/x2NQQrDMAwEvxJ0rsB1saH9SunBsTeJCMjBDiUQ8
 veKHmfZYU7qaIJOr+Gkhq90qWpwvw2Ul6QzWIoxeeeDe/rIIXpOpXDddrvyXjkvyCvLxA0TGjS
 Dx5RXaGEFSrd9MxadOaXoHMYHXAhkic0UOf759+e6fvSFVmGOAAAA
X-Change-ID: 20250926-562-add-option-to-check-if-reference-backend-needs-repacking-aa600eb3e055
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3522; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QBxmGvHS6+Igp62eCc0VIL6Sm9c+8AUrbv60YQPq3Lc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjo336pkeInREMqs81TTtUtVacmBczrmr5KN
 Nqk9JuZ7ZxzFYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo6N9+AAoJED7VnySO
 Rox/O2UL/3daVbfPcdB/btGZx3zmNLTk2AzntXBABJ6tUI6797q/nQHHQGCXeMuVz51ork8UQAm
 9e/xvRwdv5MMvAxxBbHrdq8SsjCjqTbre3B3oVAxKpJI1q5S4XyPToHPU4IyBIrvND2TEjnWBFp
 d60eKIwBInjdFtfk4maGKYTIWaRC1r0upGdzP7WjFN3feVMj0eNlp7dOtiFwJIp3NNsISNL+x13
 C/RbktutSU8qpsBYx2UxYyYv4Jq2HsgPw0ZTPGJAIZ5YTY1r8AKx/kAiWRYpGqPYlMBBFneo6Qm
 a7TZUqJAB8USlacg+huAaqaq+is/MEkcnPUWaIjIg4hxTBvvZO5XYRf3lDiRfja/1UDkghjQ+xy
 QbnMFmL15Cr3Wfdqt3YW/JZnad57vq9vrZPuXkfevv83C4X471pnlywXra6AByvMrAGfDU+58Dj
 0rDHL/mSrWS0EU0f1bwP0N7iVMGauOmSF0+fBwqCmC/buugIbjJ3QBv+YhzdKY1FB1HWRHAI/o7
 NY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

At GitLab, we use a transaction manager in Gitaly (our service layer on
top of Git) to manage incoming requests. This provides snapshotting
capabilities and provides ACID properties. To optimize for performance,
read snapshots are shared. This means they are cheaper to initiate than
write snapshots. However, housekeeping requires a write snapshot.

Currently, we run housekeeping in write snapshots which includes
optimizing references. If Git exposed information regarding if
optimization was required, then we could spawn a read snapshot to check
if optimization was required and only spawn a write snapshot if needed.

This patch series adds a '--required' flag to 'git refs optimize' which
will indicate if optimization is required for the reference backend or
not.

The series is structured as follows:

Patches 1-4 are mostly cleanup patches, cleaning up existing code post
the addition of 'git refs optimize'. Some of them could be potentially
dropped.

Patch 5 fixes the test which checks for inconsisten leading whitespaces
in our documentation for builtin commands to also consider subcommands.

Patches 6-8 are preliminary patches which add the required changes to
provide a functionality which only checks if optimization is required
without running it.

Patch 9 adds the '--required' flag.

The series is based on top of 60f3f52f17 (The sixteenth batch,
2025-10-08) with 'ps/ref-peeled-tags' merged in.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-pack-refs.adoc     |  1 +
 Documentation/git-refs.adoc          |  1 +
 Documentation/pack-refs-options.adoc |  5 +++++
 builtin/pack-refs.c                  |  2 +-
 builtin/refs.c                       |  2 +-
 pack-refs.c                          | 19 ++++++++++++-----
 pack-refs.h                          | 10 +++++++--
 refs.c                               | 11 +++++-----
 refs.h                               | 31 +++++++++++++++------------
 refs/debug.c                         | 21 ++++++++++++++----
 refs/files-backend.c                 | 27 ++++++++++++------------
 refs/packed-backend.c                | 19 ++++++++++++++---
 refs/refs-internal.h                 | 11 ++++++----
 refs/reftable-backend.c              | 34 +++++++++++++++++++++++-------
 reftable/reftable-stack.h            |  3 +++
 reftable/stack.c                     | 41 ++++++++++++++++++++++++++----------
 t/pack-refs-tests.sh                 | 21 +++++++++++++++++-
 t/t0450-txt-doc-vs-help.sh           | 28 +++++++++++++-----------
 t/t0601-reffiles-pack-refs.sh        |  2 ++
 t/t1463-refs-optimize.sh             |  2 ++
 t/unit-tests/u-reftable-stack.c      | 12 +++++++++--
 21 files changed, 217 insertions(+), 86 deletions(-)

Karthik Nayak (9):
      refs: move to using the '.optimize' functions
      refs: cleanup code around optimization
      refs: rename 'pack_refs_opts' to 'optimize_refs_opts'
      t/pack-refs-tests: move the 'test_done' to callees
      t/t0450: split whitespace consistency check per subcommand
      reftable/stack: return stack segments directly
      reftable/stack: add function to check if optimization is required
      refs: add a `optimize_required` field to `struct ref_storage_be`
      refs: add a '--required' flag to 'git refs optimize'



base-commit: 9081ca56692a28ce89a49537e6c568b3ccdef405
change-id: 20250926-562-add-option-to-check-if-reference-backend-needs-repacking-aa600eb3e055

Thanks
- Karthik

