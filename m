Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7BE3644B7
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749976; cv=none; b=lYk+kFF3k5K3z4JTM6VSXlrTf6WCIzdXxu7mwcF5M86s88uHUTvAndrn437kxrgzbOMNwnd95O6mqyWUYi2eNRn0HLp+CsRXCSVByWUKZTXIBOJv7rZd3rjs+Wy6bs1n0EaM1iAS8Kqj/ifng0xt+sRJd5rcOhm/nDbwVxPvStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749976; c=relaxed/simple;
	bh=ZgO9PlpqxijpFWF426LVSNkr2LCrYtB4u5JvHiyLnY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NxEejvobjGzZTk6Xpo9xTkmNZuX9dnZFomNaFmxnMxHmWi6pkApXPGUxDw6o8HzNtZPsWnP5uQSL6rKqy2YhXNiTL9QE581UIY1llCSBO2kiD3wlEgh88pPY+Sy2YkgjRAxjmB952LGzeg39w8SIMzR59R3eGiRwlUvIDrM4TLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu6H4e5f; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu6H4e5f"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8299c75f730so240278b3a.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 14:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772749974; x=1773354774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tcmr39ePmngXOy3AOVGOxIXdSourwiJP4O1tcfhRyPU=;
        b=fu6H4e5fSOkJoFEBgIA0jJI2mT0NHNubfyun75oUnmHgx76+Qnkp8pGdxzApdhmXgi
         aZDJxHZ1rkrzpJOq8/LAsg0oelf7+FYj3FOnE3HW71JqGFVNr+xcZMIwtfCdSKJ+KF1F
         xRvzzTltVtQ+7UuTso3DCYY1UT8WTt+UCMFlyakOlP6EhehYDp1ApHSbwVsdMq4D9DVQ
         LtSTrGqBqbpfwpApAaYEsGJ0eHsqZ/7sc+pJYul9VJaYM6wfvKnWpMDuATDpsLAjEw59
         +uCErypwL5TSiNsZmQUuZx5Cvf2dZPisrUsB23ux8Cak3GYx6Daoej1Xx5mdNvmF7A5j
         HzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772749974; x=1773354774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tcmr39ePmngXOy3AOVGOxIXdSourwiJP4O1tcfhRyPU=;
        b=YWTqCBdS4nlvPbaeb0wb23aeBF0fHyrofibIZWglRZWrKcdcwXg8tA22g5LyZ1oAHE
         8TV/Pl299Icz5RlXfy8WaUeLGgJeoHT+yuIHCURvRRtkRsQ6/5Fc3Q3hr/EYJGd1hpoM
         1c0J+k3OxM9sqsIolySA5rgWf4RhZG5y+w8FqH+qMoefXrFSCsdtUMu6I/NrYdtqwIsu
         0r5/bfkdPmcGKhddXe5zo5TAye51Fdl6cuGMbElX6Jeh11g67oGQp8L43Y9HMy40FBeJ
         YOFGyLWkcoXMgO/iTtjNDnDYBHa64HLoagAtoChxbmm5/aeov0Wr1oSHfy3Bp56qHKGy
         ANNw==
X-Gm-Message-State: AOJu0YwP4/NH0oywfpzUdFzTrV0fPvU8XQEw77r7eprgAQTivw25DB53
	3F752gO+43OtEBrIU6mTVjlwoZi/JmgH4iEfjmagBK64yW5XBW2BKxpI5kOjZYl3
X-Gm-Gg: ATEYQzzGUVUuoqOLvpCZB2zXvxWlOg3R64QWAJhsQh2YWEmiCgNPYNh/PKmP5+s2K/t
	xNnH6UTWoyyXDOwUlXwtWRbkg5R04edEFws59x55CrwX+79WA5fESjMprs6lR0BAi3MrHu8XSQK
	mwZtI5PCseFIcQv4C2SoosGVpU9cRTHu6gFm8EOmbm/9pmo1cFuPZVaDaukoA9jeECsTQIk9byj
	ktcFH/7NhcIJA1VrE4K3T7YxLLfXNws5SEo203lkY1V+7GVpWOwHgafKTWd609Kn7dV5d+vT6HO
	Ho1QepcHgAcgqtjY7fC4Qqo3EfxaUyMFlVWB0MtUn23GxMledvPIz8QzrIl4lKSpKeUxZyclI3s
	UFRa2uMC1E1kdGzCCi92zJFS/EoDcf3b7xNrDBa/zi/S/or2NiGx4jCVsEdyQUtoD7qN8FZ4CAN
	VNEMMZjG5BonFXD3VNq9nzVZKpvzqVfhkkuy8v3fOkk0xkA6tOdkDePjf1RFnRjrYbeCGhDQ==
X-Received: by 2002:a05:6a00:7447:b0:827:32dd:59c5 with SMTP id d2e1a72fcca58-829857151c5mr2767950b3a.28.1772749973985;
        Thu, 05 Mar 2026 14:32:53 -0800 (PST)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8297ef26eb1sm3916721b3a.49.2026.03.05.14.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 14:32:53 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	gitster@pobox.com
Cc: christian.couder@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH 0/2] push: add support for pushing to remote groups
Date: Fri,  6 Mar 2026 04:02:46 +0530
Message-ID: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This RFC series adds support for `git push` to accept a remote group
name (as configured via `remotes.<name>` in config) in addition to a
single remote name, mirroring the behaviour that `git fetch` has
supported for some time.

A user with multiple remotes configured as a group can now do:

    git push all-remotes

instead of pushing to each remote individually, in the same way that:

    git fetch all-remotes

already works.

The series is split into two patches:

  - Patch 1 moves `get_remote_group`, `add_remote_or_group`, and the
    `remote_group_data` struct out of builtin/fetch.c and into
    remote.c/remote.h, making them part of the public remote API.

  - Patch 2 extends builtin/push.c to use the newly public
    `add_remote_or_group()` to resolve the repository argument as
    either a single remote or a group, and pushes to each member of
    the group in turn.

RFC notes and open questions:

  - The current implementation pushes to group members sequentially.
    A follow-up could add push.parallel (mirroring fetch.parallel) to
    allow parallel pushes to group members via run_processes_parallel(),
    the same mechanism fetch uses. Feedback on whether this is
    desirable for push is welcome.

  - push.default = simple interacts poorly with group pushes when the
    current branch has no upstream set, since setup_default_push_refspecs()
    will die on the first remote that is not the upstream. Users should
    use push.default = current or explicit refspecs for group pushes.
    It is worth discussing whether the group push path should automatically
    imply push.default = current, or whether a clear error message
    directing the user to configure this would be sufficient.

  - force-with-lease semantics across a group push are currently
    unmodified — the same CAS constraints are forwarded to every remote
    in the group. Whether this is the right behaviour or whether
    per-remote lease tracking is needed is an open question.

  - I will also add the tests and documentations in the next iterations

Usman Akinyemi (2):
  remote: move remote group resolution to remote.c
  push: support pushing to a remote group

 builtin/fetch.c | 42 -----------------------
 builtin/push.c  | 89 ++++++++++++++++++++++++++++++++++++++-----------
 remote.c        | 37 ++++++++++++++++++++
 remote.h        | 12 +++++++
 4 files changed, 119 insertions(+), 61 deletions(-)

-- 
2.53.0

