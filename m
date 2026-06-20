Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B540D566
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781951824; cv=none; b=lB33JSokYiIAMFtKiE0EG74/kqae5LwJJukRtD0rirSGQeMZm5HRrt2EEj3JfyTOwGoE9xfWFgSkSrFa9UOc2jsSnyRcXJHTuur0zJVZ02tI7Tr5ljPZOesvnZhscTsQ406FSqAPqXXOMKKi+zbdY1xYQicz5gAuL35RvnwQrIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781951824; c=relaxed/simple;
	bh=OroTV7qAndgT9cJZn29iJbGydXrVTrxnwoG903c8quc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=IapVx8oKFvdo/LEiu8R/BL1uaLJqUXeG4HFEa+tXqrL7RwZ9ryaJDdxxJ2XdaPGeHUv/fvABop7rSm1VMxdA84ptH2ZzuoIf5+TWPmzttrMoIVhjxciQp9JsgAvn8VsEftf5QedmxfWh4KskAK73ojnkEmFKNRP+iMCsRjlQSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4P7rSQu; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4P7rSQu"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30b6dad2382so5314073eec.0
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781951822; x=1782556622; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lETnVTr1fPQpN4+pPSUdhISHC+X7qnm38z9ORkcOhXE=;
        b=m4P7rSQukj78PTwax6zik3gN/RG/l4Oebe00yhNNZuM1G1LybNsvncgjC+xcwpDeE7
         GDZkzFhlHUO5FkYj7ymy/i8Tb1Vx4cSv6tntH2MO3IyZWe9ozLty2FcE1dlailzsxb+t
         TRBVUBGQYCgNTTY1U7/nih+X8yNlool6hmkVlG7vmToK93FyKMRopjEB8LUol6ce6YfN
         M+XyC5FwHol5YWpkRwKrQdqray/UAv4Xdifpu0oDHJ8NEi0mGxkTmY7QanRrzdte61Wj
         7v34B7moU1wMIkEf7BaPRAbJZmHYrPQycKn6MvHMZ3IpbO7rHRB58Str+q1eIZOr7Sx2
         tJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781951822; x=1782556622;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lETnVTr1fPQpN4+pPSUdhISHC+X7qnm38z9ORkcOhXE=;
        b=h4xm/HiO9F9rTmioeP3CLwzQg4uqPM5mWB2tqaX5hS4HOoY4uUHYcB1mY0XHlnEWPH
         pJCANY09Vm2wmz3PMmiUxqe5ii5vtm+qoPyQEqVSHoR6psU/eN3HIkPsDG6PT1p8gIlW
         vK3/qfgLq2QnBJUjdZ0rcacs3FL7cE0YDhx9KURUKt0f4CLk/TYaBfk3hz/Xa9sKB75S
         6eHcV3UzCYYuVrkqXOT3MWhoXTnAOviTX+0f4qH8wkTzhFGX/haaqcMcDL6GUT9tcn2w
         34fz/yTQCddA2bQ8kxXf86MScOzZmoI94BK3E2k7HA5aFDf9vxj7RGhPYhOdwwmu0sCF
         OA/Q==
X-Gm-Message-State: AOJu0YyI5mLZQB9d1VM2Ky1F0K2YoGd8N9cg/FEWGY2m82rzHerqdCbn
	UqGoqmOdKCnkz/mEhSZplraglSkvIFXM0cVFme8o8ZjSNmYlmRykt/pHmqVt0Q==
X-Gm-Gg: AfdE7clRzuKpilDGkTG2+TtLxe+E0O6qBKDLCC9ra3jYZDmM+ajjEoWKaAT+VbcyPmR
	SBCndQIxJNrdKNxYoB4st35O+ySmnd4TJKIFJaALl/7tBT5P+ozCbL3xmXD3oxtmY/HgEpKhKmE
	KsaiBZraJdobgJliEA0qjOU8DZw6Gd+LiyqUDqPIBjCihvp/654ujoL56Rkh4D9IYvX3T373esF
	dcRw+46ndO1iUswLkcWslNdlMmu2EQHGwRcLSVvgENAzwr41LmsLVt0AxSikyujR31X+N1HrHbj
	08K3WhMG8/jp2Kxizn2Gf0NYheNJ7GQ8PnHaouRSOxrEEUTO5GX4TUohPb452WxsQh3fTKSpjJ5
	bz0aAzTN2pNi3YRXbd8mOcQ230GXkw+s8NHHbhIi8EH7sT+lK8msMyDMQ/wA0camLmPa48CoGhq
	DEWccBZHa8wmvTtsfi
X-Received: by 2002:a05:7300:6c84:b0:304:e587:5063 with SMTP id 5a478bee46e88-30c0cff485dmr3638205eec.12.1781951822379;
        Sat, 20 Jun 2026 03:37:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.54.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be5c5desm3341649eec.28.2026.06.20.03.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 03:37:01 -0700 (PDT)
Message-Id: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jun 2026 10:36:53 +0000
Subject: [PATCH/RFC 0/6] commit-reach: terminate merge-base walk when one side is exhausted
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>

Hi,

This follows up on my RFC [1] with a concrete proposal. I expect the design
to still be scrutinized, but that may be easier with actual code to look at.

I tried to make this easier to review by splitting into atomic patches. The
first two patches are the meatiest parts, though they are pure refactoring.
The behavior change is in patch 3 and is in itself quite small. The last
patch adds technical documentation to support future development.

----------------------------------------------------------------------------

Optimize paint_down_to_common() for merge-base queries that hit large
one-sided histories.

When the walk from one side reaches a commit with a very low generation
number that the other side never paints, the walk is forced to drain most of
the graph. A common trigger is a repository import that grafts a separate
history with its own root, but any merge that introduces a low-generation
commit never painted by the other side has the same effect.

A new merge-base candidate can only be discovered when exclusive PARENT1 and
PARENT2 paint meet. This series teaches paint_down_to_common() to stop as
soon as one side has no exclusive commits left in the queue; once one side
is exhausted, no further candidates can appear.

  origin/HEAD  o   o  PR HEAD
               |   |
     (import)  o   :
              / \ /
             |   o  merge-base
             |   |
             :   :  (~2.5M commits)
             |   |
  import root   main root


In the RFC thread [1], Derrick Stolee provided a criss-cross counterexample
that sharpened the halt condition, and Elijah Newren independently
discovered the same optimization and shared an implementation in PR #2150
[2]. Patch 4 incorporates test cases from Elijah's branch.

This series implements the optimization only after the walk enters the
finite-generation region, where generation ordering guarantees that paint on
visited commits is final.

Patch layout:

1/6 commit-reach: decouple ahead_behind from nonstale_queue 2/6
commit-reach: introduce paint_queue and per-side counters 3/6 commit-reach:
stop the walk when one side is exhausted 4/6 t6600: add side-exhaustion
edge-case tests 5/6 t6099, t6600: add side-exhaustion regression tests 6/6
Documentation/technical: document paint_down_to_common()

Benchmarks

Measured on a 2.6M-commit monorepo with commit-graph (baseline v2.55-rc1):

merge-base --all  (across import)       4.293s ->    8ms  (537x)
merge-tree        (across import)       5.345s ->   13ms  (411x)
merge-base --all  (1000 commits apart)  5.404s ->    7ms  (772x)


No regression on linux.git (1.4M commits, commit-graph):

merge-base HEAD HEAD~1000                 38ms ->   40ms
merge-base --all HEAD HEAD~1000           87ms ->   36ms
merge-base --is-ancestor HEAD~1000 HEAD   11ms ->   11ms
merge-base --all HEAD HEAD~10000         626ms ->  428ms


[1]
https://lore.kernel.org/git/CAL71e4Ps-2_0+uuZu43N9pFnXBemoAohPs_eyRJf8taXHJPAXQ@mail.gmail.com/T/#u
[2] https://github.com/gitgitgadget/git/pull/2150

Elijah Newren (1):
  t6600: add test cases for side-exhaustion edge cases

Kristofer Karlsson (5):
  commit-reach: decouple ahead_behind from nonstale_queue
  commit-reach: introduce struct paint_queue with per-side counters
  commit-reach: terminate merge-base walk when one paint side is
    exhausted
  t6099, t6600: add side-exhaustion regression tests
  Documentation/technical: add paint-down-to-common doc

 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/paint-down-to-common.adoc       | 130 ++++++++++++++
 commit-reach.c                                | 159 +++++++++++-------
 t/meson.build                                 |   1 +
 t/t6099-merge-base-side-exhaustion.sh         |  82 +++++++++
 t/t6600-test-reach.sh                         | 136 +++++++++++++++
 7 files changed, 451 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/technical/paint-down-to-common.adoc
 create mode 100755 t/t6099-merge-base-side-exhaustion.sh


base-commit: 8d96f09e9245ddf80c1981476fcbac8c4bb4125f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2149%2Fspkrka%2Fside-exhaust-pr-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2149/spkrka/side-exhaust-pr-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2149
-- 
gitgitgadget
