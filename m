Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988DD14F9D9
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926088; cv=none; b=pmUaseU11ePi6rhlM9zVgeFdGLvf2+ZHY45BClHlcVWaJLmuWNklSo22zRoTub6zklT/7cM18nHTWobJ8nMdTuhLxEzVN3DtrfNSHplhkBIWpi6S4WwhIcTavVx98tvj0W89H2Wh1vP38TzrEXTdhhTmVJUfn9iovHE86N0gNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926088; c=relaxed/simple;
	bh=nlge4v3ZCYKcIEu8AdWz1cw3BJ53xb04KVTDltXygrI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=aGS2KIPSGFHCYM7F/IrtruFf4sghwxbghh7G4htJMbO3LfrHQh37S6dJ4dwyARyiCR+AwFftomS3TJLG3ixKT0NwJ2/KZSs1gGlTVEoh1NXO7/KwMZvIX0lcLYkcNDpb2eRQ2Gne3ntAWn/LzSR3kjDfoibHQlVfOrEIS17V6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A75AIze3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A75AIze3"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43159c9f617so1905285e9.2
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 12:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730926084; x=1731530884; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fadim5Wdfesdt5Xq2l9k6x/ccLfFHDJDghTB0+/YwCc=;
        b=A75AIze3+GZ89tP+wjBUxN2iMp/Cgksk7PJNeM0uHmq5O+MFT7xlt07H7cvlJplWfP
         L8IkZxIosa20iNYEqRj3iXmsjziCxEEnJjI/m9opwTkiVzP7PQ4aqx7Nq9bipACUCfsg
         86t8xNpICI3E/oGp7yTW2lPeP5+KmMKW1ISkVIAF006dmUhL7uXyzsvpy5wQ7bU0aCY/
         iIieZLNlzxetpflqYOZcnRkoULqLmHj4o9Pnp8Pt10ujJVakI4RJvrHnzH3wMKD9cIZ1
         yJKMEg3KR7vfACa5SyHTVpTVzmgqP4qCESsmqXwGSB0eZbHy22RUITW0qC9leAOc3mBu
         nsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730926084; x=1731530884;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fadim5Wdfesdt5Xq2l9k6x/ccLfFHDJDghTB0+/YwCc=;
        b=d84ztbPUuRgYHsbpOOk2K9W23kAR4BTaS1Zksu13VgCTigQxsYGe/U5UPSrNOgh9jn
         ZvFSy/5G4g03Gy3AQmJ6SZKgTe+vpuu19032LoT0bLOc2V5t+UOG/ftk6Bf95C/IVhbV
         ojtlr7cQZE2AmTMBo8tpe3fq8Zjsmays6twujPwiXyOUPbQKcQ6MTa8ySrP7tZG2ij1b
         LiLnJHjx/Foc1ntqnaQCF0BZ5ybHy2Y6hp4IScjtVvVfsRR+yQYPZPPKmc4pHJPkuTuV
         wslGnnchvr8ftSd1ZsNbocz/YfsAiKzLEI9lyTkVUsaDFOsGBYG+tgYvZ3/GJxzR4nFW
         stRQ==
X-Gm-Message-State: AOJu0YwA4dBbK5PLBrNFCUDiyn9cDJBhu9n6YFKZy+QFTtiuzas5dgk6
	6Zz0inZZU6Fxgytq6NL1nO1784JUUiYJiiAh1H6JvpbOHNkAnR0cIWzXfg==
X-Google-Smtp-Source: AGHT+IGTqMEyVVWBdm4+Lk/pBxeRr40BwD9EsN6BRewZX+VGDvt8NkG98cdL6yjACWjQRSlIKo1ziA==
X-Received: by 2002:a05:600c:2d81:b0:431:93dd:8e77 with SMTP id 5b1f17b1804b1-431b172b3bemr333454195e9.31.1730926084230;
        Wed, 06 Nov 2024 12:48:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6ae615sm36468575e9.8.2024.11.06.12.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 12:48:03 -0800 (PST)
Message-Id: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Nov 2024 20:47:59 +0000
Subject: [PATCH 0/3] Remove is_bare_repository_cfg global state
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
Cc: John Cai <johncai86@gmail.com>

This patch series removes the global state introduced by the
is_bare_repository_cfg variable by moving it into the repository struct.
Most of the refactor is done by patch 1. Patch 2 initializes the member in
places that left it unInitialized, while patch 3 adds a safety measure by
BUG()ing when the variable has not been properly initialized.

John Cai (3):
  git: remove is_bare_repository_cfg global variable
  setup: initialize is_bare_cfg
  repository: BUG when is_bare_cfg is not initialized

 attr.c                        |  4 ++--
 builtin/bisect.c              |  2 +-
 builtin/blame.c               |  2 +-
 builtin/check-attr.c          |  2 +-
 builtin/clone.c               |  4 ++--
 builtin/gc.c                  |  2 +-
 builtin/init-db.c             | 14 +++++++-------
 builtin/repack.c              |  2 +-
 builtin/reset.c               |  2 +-
 builtin/rev-parse.c           |  2 +-
 builtin/submodule--helper.c   |  2 +-
 config.c                      |  2 +-
 dir.c                         |  2 +-
 environment.c                 |  7 -------
 environment.h                 |  3 +--
 git.c                         |  2 +-
 mailmap.c                     |  4 ++--
 refs/files-backend.c          |  2 +-
 refs/reftable-backend.c       |  2 +-
 repository.c                  | 23 +++++++++++++++++++----
 repository.h                  | 12 +++++++++++-
 scalar.c                      |  2 +-
 setup.c                       | 19 +++++++++++++------
 submodule.c                   |  2 +-
 t/helper/test-partial-clone.c |  2 +-
 t/helper/test-repository.c    |  4 ++--
 transport.c                   |  4 ++--
 worktree.c                    |  4 ++--
 28 files changed, 79 insertions(+), 55 deletions(-)


base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1826%2Fjohn-cai%2Fjc%2Fremove_is_bare_global-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1826/john-cai/jc/remove_is_bare_global-v1
Pull-Request: https://github.com/git/git/pull/1826
-- 
gitgitgadget
