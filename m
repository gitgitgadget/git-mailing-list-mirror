Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A2517BD9
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788555708; cv=none; b=QVIK2lSLDBibiTZ69SyOg8NBRAFV958LwKdQ3V7lX10ZH+qkAi9aU2rNxSimT9ZcCRoIXCBZz1fhZwgHelfey6aAxlNeRei/ddB1GP7O66HX3Mp3scnFnOUtuBpc08yO3dvnklcDCUz4OX/w5RQ6MSOCOU1LuKfhDQUKBVcFBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788555708; c=relaxed/simple;
	bh=3pyvkZ9Uf7sT4cC39ykv6futodudD5Kg+9C5dFRG5Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5OuZ1bRc/JTIj9ho+3YIUtD3yKb+Ya2/0Q06kg9fANs71/Rq2D0esTt4dch2u5x5j1O9/4dFJS7A8ngnYblCX/32DcpjJvS3tb+2ddrELKxKTbroV2Nhb623G31AAGnyndNdpQGoeXReBpt5fOKXz23zDL/jaELQffX3VR44yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=QABjVJ8W; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="QABjVJ8W"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f5934ba2a5so936019a34.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1788555700; x=1789160500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p/NKXYBWBWgQBrV637bwwwpyyZUGWnfFR0hTStKqAUw=;
        b=QABjVJ8WFe+7J5WuWepadOcFm8R7bLWGDTu2IvVwkBLju3uo7M+EEz/fOpt2PYCW86
         wDz8Z+V6yD/a1AQg91HXtlXPVcPvxhzfpRAVAJbrSTGEDCxjsVqU63Sic1toVniBJrQ3
         1RmjCGxbcJebDbaiT/5h0mHUU77jHjFBFYYf+I3CP1ABNwSsj6z49CG0cjKYZzDutJVi
         qQwbCfT59l/DLW+YXVLyt+rh9VOvzSROzYP+gfYl6inw4xFQePjJ6C+YVUtfWsLYgQTW
         bkF81TJ59h3CvvVLPoswCIb4Ev9pOFQaSePg7ffAE/P2qJuGX6g6uHDPR8XsLij8ODnM
         kh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788555700; x=1789160500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/NKXYBWBWgQBrV637bwwwpyyZUGWnfFR0hTStKqAUw=;
        b=s5sAUafO2JyUEUvbNYB36o9NogE2P4w3sdh09EzK34i9rkEoFSCkGfhLWl5+U4QxiV
         2TSG3eADYYxqESuRY4o6wur29N7Eb6ZLfsyBEdgrWN6T3w6x/AgwnVO2OeChasDLo4u7
         pPtPDSJbK0Y/ECOVlxNKG9vLSxJ6KCDYzX27a8/gdXgRzjmPBVDGOCI2gz8YfvCyRHjD
         NX4WOX+IlFQz6Z75457Cc97IXXuGr9TcSmyZGu67U1nnzdV+KHZOPBpc41FdCbUHcF7L
         2D+5dlanWlSzMoTFE0wkLZsCwVhhAepAcKoON8uzqjd9gwPoG7DiO9X7twC20pNsHxwx
         4pDg==
X-Gm-Message-State: AFuF++nPLC4PLXyh0jszUD6BfD+1/jhovd+NG02ypEhn5og78Bgzw02w
	Hetw/Exg85m+XZIxlylSyjzfeUBzgqlvFRtHrOFeQC/2zSiBf/yZXsiGMODfRr1XT9kAoKk93bp
	6wUZLG7Bn6KWj
X-Gm-Gg: AYBFou3kSDL/1H9w/hjj6bdwCE1bFxGcNtAgnopEg5upkAcNMPwzS/zupu4hcgNFoH9
	/Vjwf8NWdsx0+oM2zwKHwce4I1uXTGooMaksrLx8AYJtlCucTMZc/E1TWwFyzGHZ3HzNHsDK5O0
	boLhzt9KVlEJLFQ2XmFvT/y6w/MQZa4FaYqnCU5PbWkS/MFlYumCBHIje5pRQhiVeAhCaDXtW4w
	oDecTK+zZLfxgDWx9K7KbIYcqad/DHX0s+UQ2Z1+Dr5hFiNXTO1HWyXnGqb4/4gy2mKKM6S4rL0
	aABXEaaB0bfV7IevZ8/SwOKh6pPYUu/EDh9KX9r/DTZrAi4e6yKVcVAAtnQZ7QE/o+hKbOz3l2H
	pMk5o+PUWoc2Q6sNSf8ou/nQfOw6tS1f24LJPAcnkSOaHFTdk+2YzV9VaPptju7TWI+WseLNvJb
	rLw9cuvWjHUUh6d3nNuW/KiGbDMBL3LcKAhcW8+2+I+dwfhb5YMkbZdbdOZOX0
X-Received: by 2002:a05:6830:3693:b0:7e6:e8cd:bb7e with SMTP id 46e09a7af769-7fa1e1c4234mr7074236a34.4.1788555700453;
        Fri, 04 Sep 2026 14:01:40 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7f9f7bf0086sm4370281a34.27.2026.09.04.14.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 14:01:40 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tyler Cipriani <tyler@tylercipriani.com>
Subject: [PATCH 0/2] push: fix --force-if-includes consulting wrong ref
Date: Fri,  4 Sep 2026 15:01:20 -0600
Message-ID: <20260904210122.431757-1-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--force-if-includes has been checking the reflog of the local branch named
after the destination branch regardless of what's being pushed. This can cause
false rejections or unintended data loss.

False rejection has been reported twice that I could find:

- 2023-07-26 - Stefan Haller reported local branch with a different name
               false rejection[0]
- 2025-05-08 - D. Ben Knoble reported detached HEAD false rejection[1]

The same root cause can result in data loss: when a same-name local branch
contains the remote tip but you --force-if-includes push an unrelated branch,
clobbering the remote repo. PoCs are in t/t5533-push-cas.sh -- new test cases
fail against maint, but pass with patches applied.

Existing tests covered refspecs with different names for --force-with-lease,
but missed --force-if-includes. New patches cover:

- allow forced-update using refspec with different-named local branch
- allow same as above, but with HEAD
- reject force-update using refspec with different-named local branch lacking
  branch tip
- reject same as above using HEAD
- reject detached HEAD

Open question: the detached HEAD case. I opted to reject, since it seems like
it might be surprising to allow in the case where you were just on a branch
without the the tip of a remote ref, removed the last commit with git checkout
HEAD^ and pushed with --force-if-includes and it allowed a destructive push.
I made a separate patch showing different advice for that case (since a
git pull won't help).

Based on maint since this is a bugfix. Happy to split patches any way
that's helpful.

[0]: <https://lore.kernel.org/git/f51c73ed-eb03-83ca-fb31-d3e2645c9a63@haller-berlin.de>
[1]: <https://lore.kernel.org/git/CALnO6CCk0SgwObQRnpd5Pt_DvCKF8dBmyVHivU6Nr_O-GusGLA@mail.gmail.com>

Tyler Cipriani (2):
  push: check pushed ref for --force-if-includes
  push: fix --force-if-includes detached HEAD advice

 Documentation/config/advice.adoc |  4 ++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/push.c                   | 15 +++++++
 builtin/send-pack.c              |  5 +++
 remote.c                         | 27 +++++++++++-
 remote.h                         | 10 +++--
 send-pack.c                      |  1 +
 t/t5533-push-cas.sh              | 70 +++++++++++++++++++++++++++++++-
 transport-helper.c               |  5 +++
 transport.c                      |  8 ++++
 transport.h                      |  1 +
 12 files changed, 143 insertions(+), 5 deletions(-)


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.47.3

