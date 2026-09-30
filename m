Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951FF26ED46
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727718; cv=none; b=don183qT4zCtFazMDJhIpsAJjSS5K9g8lZ6ML+oM14UskPhxT5pMWIVOpy+5tz/F+FxgwL4FP/evEeupqfYgWGG0RPrOmpmtqa1kqW6Eu24XYbMaf3sylwFjib0mzZpTR+mnngSrVSOJYygifpZUpeppzhmVtESPWFsb/0er0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727718; c=relaxed/simple;
	bh=0pceFs13kVmzxwAwr4o9tiXe2iq3atVaioX50aRGEHw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rX/oPmZci7kgKWT2qZ/cESb+sf2MtwU9h5ZMfnB/GinlIfjNu5QIHrZ9AlZ1QqCLnwH0ENvlF41lDekmbiJMPm5Gska+D2K+LHVHctEiWjy0NqAz+5WFS9EC74R+mkXKB+Uwpgh3k0a5ED1jmzU41dLOxyJ+8vsl90W/tnJsN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsIkAnOW; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsIkAnOW"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d391aso36099825e9.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790727715; x=1791332515; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dU1+ADH6VhOMKorPsyFkC8uvvQRhCureyDUDelpT35Q=;
        b=jsIkAnOWRJr0zRbRQfcOPscDOL1IllRnKkQ5NLL5gOmljABYuLjSoPOnFd9HeYlsJL
         tXEnXCOBzr+RHVbAibn84fRrUcSe3xZX2YaKQk8zjTZTJwxrs/kKpFTpWtiINgSHCWAM
         OJqEWDItP63j0Ly1TfL4lD8Sy4C2+RNXNi0rgQtt37ef8PYw+wdIeCoNv+YijdHxMAvj
         zZ4uqiIrtQSccSJ+uNXYzCUzzp67KCEAs1LwIkR0XDrS4gtFbNiJIN4lYKfoAqmC55M4
         JtE+exVHTdI+q5gtGnnuqb/5y4W0J8Q95HxTqr9BTRrpy3VANrx7/vU7/wVzgk3LUDJ6
         K63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727715; x=1791332515;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dU1+ADH6VhOMKorPsyFkC8uvvQRhCureyDUDelpT35Q=;
        b=t7UYbEy0gWv39QXH8vsEyDWphMRygLfaf3+3i6eAOxW1O/4Y7v5765mlmlPy8tZo/x
         QzfLpYP24b1lHh606jlBRoLWKwTjyY2opl+EQkbne1HgvD2xN3CcCN60lVHzaZMmTWLi
         x2BU9OdUYRdsrLWWFOIYEm3BgYB6p7sS7Jyx6VmK543dd79e9vgEgGHxJ1tsvbg1UMJ5
         X/jtTTldThgpOzRdnJrVp/8B28uOv2LSxuOcTrxnDLTbWgHKcgljbhIu5FhLL4MbF7rc
         DrXb3O9Hf2ie3pt7nk2iUCZ76LrxV1HUqUE56p5wgaasJ9QI4mFuq9RocVUDj7mbLWSZ
         cJ1A==
X-Gm-Message-State: AFuF++mVb+5il532OrREvZdnSGBgRXlxYVg3d79pHfctVID+x6hoflti
	7XveZSLeVVXUGp4dBMYMgkEL/oAVlwqgi1FVIMJbNZovqm39aW41rG0f
X-Gm-Gg: AYBFou1eVfrxx3SR5at8z5/pZdscV2zhSAr6DvyOzGxhhH/h3QCaCC8gcK3iH9/L5bo
	LO0mNw4IYQbGQQvmINEqGOjBgMxjEk5fFrqlCvB1CLDKrO26ajC6nF1dDMtxZUadl4zl/8zV7mG
	6qwbEjiljJ+6QJZIbAO3yvLGNnQYnCJIo0DqI8T/QuBgTbYeD4/sj2I9zr+4AfAjlxRkUPG/hyt
	UUI+1ZiZ6ky99A56pGZAE3cMkBmGrfc+eZUeWJO84sFyemg3iT9Qx59MKbhXQciyj4uq2y8zamF
	SCsdh7HhmsrLGhEifIjlPjevvHL2Bn7OErvL3xNzKjDAz3bdL9xljHCA5CZD7kRgw0moaYruwWh
	wdQtgUOvN2T24FurxVd7g7rQ950zELBRppRqL801saCkgwBBUUSoWr/56a7B26Ihw33ORcp/d+N
	HuIqvVwnu5CQLHIoIgd2a2b2784sskyVJ6s1sC+UXfxmyT67pJG+6K/qgfMNbOBpZ9egvGChMHA
	CSEirg/Pss0Y+YZ5wnuqThPouivLdk0oLdDMFffhD2jMSc9UjOfkHZjC5H1uC6+SJR5BcfjMeqy
	mYOqP5F/RbjBy9iW6AojFifNZBoIPNjgjUEmaERZI+piKzu0A2o0Y6aL2ghhrp/A0jZndfq6/0l
	4YgSK7VbZraSLUoxmBrQy
X-Received: by 2002:a05:600c:6388:b0:49c:fc6c:be19 with SMTP id 5b1f17b1804b1-4a01514e20cmr12402945e9.31.1790727714692;
        Tue, 29 Sep 2026 17:21:54 -0700 (PDT)
Received: from mac.lan ([2001:818:c665:a700:4e1:afcc:bdec:a44d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a015cde27asm5135615e9.3.2026.09.29.17.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 17:21:54 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH RFC 0/5] Add --dry-run option to git-backfill(1)
Date: Wed, 30 Sep 2026 01:21:45 +0100
Message-Id: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0MT3aTE5Oy0zJwc3ZSiyqLSPN20xGRLS3MDA2NjIyMloK6CotS0zAq
 widFKQW7OSrEQweLSpKzU5BKQWUq1tQC1y6+NeAAAAA==
X-Change-ID: 20260914-backfill-dryrun-fac997003322
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

[Cc'd Derrick Stolee for his work in the backfill(1) command]

This series adds a --dry-run option to git-backfill(1) that reports how
many missing blobs would be fetched and, when the remote server
supports the object-info capability, their total size:

        $ git backfill --dry-run
        After backfill, 48 blobs would be fetched (1.20 KiB).

If the server does not advertise object-info, only the count is shown.

I am not a git-backfill(1) user myself, but it seemed useful for users
to know how much data a backfill would bring in before running it.

The number of missing blobs is the sum of the number of blobs to be
fetched in each batch. The object-info capability lets us ask the server
for the size of each blob without downloading it, so summing them gives
an estimate of the total.

Note that this is an upper bound rather than the exact disk usage:
object-info reports the uncompressed size of each object, while the
objects end up stored compressed and possibly deltified in a packfile,
so the space actually used on disk will usually be smaller.

Since I do not use backfill, feedback on whether this is useful, and on
the output format, is very welcome.

Patches 1-3 are preparatory:

  [1/5] transport-internal: update fetch_object_info comment
        Fixes an outdated comment: object-info supports type as well as
        size.

  [2/5] fetch-object-info: add enum for fetch_object_info() statuses
  [3/5] fetch-object-info: return a status instead of dying
        Teach fetch_object_info() to return a status instead of dying
        when the server does not advertise object-info. The die() is
        kept in cat-file's remote-object-info path, so its behavior is
        unchanged.

Patches 4-5 add the option in two steps:

  [4/5] backfill: add --dry-run option
        Prints only the number of blobs that would be fetched.

  [5/5] backfill: report total size of missing blobs in --dry-run
        Also prints their total size when the server supports
        object-info, and falls back to the count alone otherwise.

Thanks.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Pablo Sabater (5):
      transport-internal: update fetch_object_info comment
      fetch-object-info: add enum for fetch_object_info() statuses
      fetch-object-info: return a status instead of dying
      backfill: add --dry-run option
      backfill: report total size of missing blobs in --dry-run

 Documentation/git-backfill.adoc | 10 ++++-
 builtin/backfill.c              | 97 +++++++++++++++++++++++++++++++++++++++--
 builtin/cat-file.c              |  4 ++
 fetch-object-info.c             | 17 ++++----
 fetch-object-info.h             | 24 +++++++---
 t/t5620-backfill.sh             | 48 ++++++++++++++++++++
 transport-helper.c              |  6 +--
 transport-internal.h            | 12 ++---
 transport.c                     | 29 ++++++------
 transport.h                     |  7 +--
 10 files changed, 208 insertions(+), 46 deletions(-)


---
base-commit: 12cb6293d6288865c1a133cf22accbaf99d13eb6
change-id: 20260914-backfill-dryrun-fac997003322

