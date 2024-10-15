Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F001C4A21
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003794; cv=none; b=ArfoFzseAOqjtcv/EcOuetVX/gu8S6eMLk8DLVo1smc4brr7HNxwV1lssSun30MpJICwrv5Gae0JxXBSKUSJCrWwwt8sMFCqbkRSsu0lyfLTK39LjqW/+w41EG6NMQywpSz1tGMljSEZfqxEd2vlx3Z5LGXJAbIvnKlM4l9h/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003794; c=relaxed/simple;
	bh=HX3xTTqa5GEIu2c4NXP6eG8U0jvTUHxaR/cvq0MFIOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJh4ee9lZUuGrI9nIw1uZG6dfUhdVlpEap7IRX22joXDWOWQKm/dQBUuLAOsCsKgF1x1ack1tE8RZcEVVPLX8naCY+0KMez3ZoHmqMB60gbftzo5OH93fBbNjc2A6djQpPsC9g+WjUPrI2sWdkpYB+AsiDuCGa8ig73SPerqLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Say8Ykt/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Say8Ykt/"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3526573a12.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729003792; x=1729608592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gqH5qVZhB9rQ0ZyLJMPKdr/iLzAd1LTvRnMEWWj670=;
        b=Say8Ykt/3/1otaKbm8pAjPQxGJVzVCqukxVOaqYP0OwrEVoSsx3BnXem4E9TduWhGG
         amg2bPXr6j1FFJY57Z/CLZDOfmn6YXaMNN2hei6ggiWT6ZYPzoRTXe4xqV/plh5bEnQH
         Dtf4x4ES6haMStb+zmvZk7FgYyJ6C75YfiVnZ6xEFrBVTIhAPJ0ENiRK4JTv6JPti77k
         W8nw7VoKmnkT/dej259+vw+JHXWDKvjIO9hoB3guOiR1o8nqf/24WWydZAy3fxX52d18
         /aWDwpuYHcJhwVGLlT2/eNbxj3puvrAfA0HX6XPgg+UMel5KlIyh+VnY1Kfmo6gN4nXR
         46fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003792; x=1729608592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gqH5qVZhB9rQ0ZyLJMPKdr/iLzAd1LTvRnMEWWj670=;
        b=e1oC/cuLCaP2Cz9jVbSnbnecrfsuY6jOqZ25ascKwkdiXV3AprMWqZCNOpq43lPAkA
         D44/dyZbyWBUR/G5+hHz1wkQGU1HPV1Tf1ZYVEayOvyd6dM3I2P3jJ7K19VBsrzAqkiQ
         ad2ru6Hj/vm6Kr03T9B4xVhp3EZ4pTNDdxS9pIWTAycBvuImRQUE9r2QVRpNJuVhCI5m
         9kGj6VeuFmcOTIUkh4PO1D//BRKnj5nS7UrtnFP9QnhUzXCB5K4aQ3QFKvLqCzmaJ/Ij
         ordw89E3iXGRW8OKeNtta7eLrKX4ZmV3KTKrUCxGMHQCjiD46A+Xh6H3+C/2baJtyPcS
         o6SA==
X-Gm-Message-State: AOJu0YxH6uLetOmRXEqr9YvI36ppZUqsds5PHkblJSKRXdMVyTSu+dMB
	Y2l8/2oS/yaoAOLZ+fphrPDcJZfr8EjpYvdW/qvJFG4nnuBHHRPH/rXbxQ==
X-Google-Smtp-Source: AGHT+IHSSkPUhVocyFqGtghQMV480hEknLQEwovMzlsM/RrNLfBhvZTIQkjU7rhgRA+dX2w9TnpsCw==
X-Received: by 2002:a05:6a20:d50d:b0:1d9:4cf:719d with SMTP id adf61e73a8af0-1d904cfb5d1mr1212410637.21.1729003792423;
        Tue, 15 Oct 2024 07:49:52 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:3236:51ac:756c:f3be:7ccc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e7753420asm1328000b3a.205.2024.10.15.07.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:49:52 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: git@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>
Subject: [RFC PATCH 0/3] pretty, builtin/mailinfo: don't rely on the_repository
Date: Tue, 15 Oct 2024 20:01:21 +0530
Message-ID: <20241015144935.4059-1-five231003@gmail.com>
X-Mailer: git-send-email 2.47.0.73.g7a80afd5fd.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Just a brief summary -

1/3 - the main changes are in environment.[ch] and repository.[ch], all
      the others are just changes due to this change.

2/3 - the main changes are in pretty.[ch], all the other changes are due
      to this change.

3/3 - This is pretty straight-forward.

One may notice that there are more "the_repository" occurences now than
before this change - which is good since it means that we have now made
the respective dependencies explicit (these were previously implicit).

The change in 1/3 is marked RFC since I was kind of skeptical about the
"repo" check in the repo_*() functions being done at _that_ level.
Since every other change in this series depends on this, I've marked all
the other RFC as well.

Thanks

Kousik Sanagavarapu (3):
  repository: move git_*_encoding configs to repo scope
  pretty: don't rely on "the_repository"
  builtin/mailinfo: don't rely on "the_repository"

 builtin/am.c          |  6 +++--
 builtin/blame.c       |  2 +-
 builtin/checkout.c    |  6 +++--
 builtin/commit.c      |  8 +++---
 builtin/log.c         |  7 ++---
 builtin/mailinfo.c    |  5 ++--
 builtin/merge.c       |  2 +-
 builtin/replay.c      |  3 ++-
 builtin/reset.c       |  2 +-
 builtin/rev-list.c    |  4 +--
 builtin/shortlog.c    |  5 ++--
 builtin/show-branch.c |  3 ++-
 builtin/stash.c       |  2 +-
 bundle.c              |  4 +--
 commit.c              |  9 ++++---
 config.c              | 10 ++++---
 environment.c         | 13 ---------
 environment.h         |  6 -----
 log-tree.c            |  6 ++---
 pretty.c              | 63 ++++++++++++++++++++++++-------------------
 pretty.h              | 14 +++++-----
 range-diff.c          |  2 +-
 remote-curl.c         |  4 ++-
 repository.c          | 13 +++++++++
 repository.h          |  6 +++++
 revision.c            | 16 +++++------
 sequencer.c           | 28 ++++++++++---------
 submodule.c           |  2 +-
 28 files changed, 139 insertions(+), 112 deletions(-)

-- 
2.47.0.73.g7a80afd5fd.dirty

