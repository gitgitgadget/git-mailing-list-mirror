Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD2D192D7F
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087085; cv=none; b=VBkYmeVMIUUasWGuzaMPXpE4PsT1+VtXgqpWBRPRIBV+RvHVQIMgxVjcY6CGrVGxEUhGjH83YFXjI24VOPEdw+OlfhUB0Ha4FKZ94y5jwczvLIntLkhrPPJ1y/BzhvLUxx4gq94+RKDDCOzaCq2jqW76XeOU3pI+1CJJi+ot/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087085; c=relaxed/simple;
	bh=cljYc2vKLBGoDLR2CjpCF9mjuyNQ8IIefBbZAwdM5jY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KuaV9toWt+8UYXRbgaoqeFxcEu5NPUmQS6E9HYXSygDFlf9foyHfQddiS0D2DfuZ3fpb+4oKxKr7Wqm1Wkf+3JJfmO3YPhmRX7DFYKHenUWc1C49A3MtxpKqB5DKQziFZRHEb16t+pb6Z32Oemw22r0MJRe732csV6Q/RfnMwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aVAWbf9W; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVAWbf9W"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e2eb765285so2679493a91.1
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 09:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731087083; x=1731691883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DvGPeBWTQHgaINvlFfsiy99W+l/4tMjFbnSTEZGGhJk=;
        b=aVAWbf9W2CKNY2PG4LMijABQ6UF/31DzB6N36C3XqsWR2lufnH+M+lpzORCGq8XbHe
         A8zYXfx4urHYKUEr8aXPgbs9KELjgD+iYRTBmH/vJXFu7t16eNU8rlVOumNVEowqzSe6
         iErNkjscTQYWtFqPwiy/38PdRPbK42QSxoOrFF1wZhzj/yGnC73+OpHg+GAHwZ0RshD3
         jutK9H4aub9XmXBmBQtpWLbyOCXB/GsDxq9iOdjueISY/Z9huKpRoRR/I04ilKCK76v5
         Bw18Q1H0gdY+niEgVpsB4Ua7wTaCXgn0IH+Q78V8pd6+TD5w/idOjAiO9rizOG5XNxjY
         WxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087083; x=1731691883;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvGPeBWTQHgaINvlFfsiy99W+l/4tMjFbnSTEZGGhJk=;
        b=fcGV6219JcRayucLwmQ9Jsv9U0CWyzExK+DWDWvUh1E2HAXvnOvf2tZKKRT7eFgevH
         6INSMycTgZT5TDDRTBOIDbxfNN/gbFev03ynz0ISyLt6gugXXA6oBbUn16N28sODGAJy
         QMkX4ZyWelMYSfRNq/AWgt5vlyOMzSUvlVxlBOd7v4g/q+Sg72rtatb5neiXX3Z+cIsk
         c0h+fzv6v3OTQLqwZciBb9CfnWP3n5NDlYFO3HMOg8LsYYqJcoxRm7kO3+JHlqd86T+V
         H/PFF3tJzrqe4doJLgapnMCmfAxjQZyyIn6XXalQKSoH4EXeWHXUuRZZV82Z+SjHocjZ
         TBCg==
X-Gm-Message-State: AOJu0YyrKXFSB34OUSswtWVLJPUScF3OS/GYXQ6COtLFcQ43+yRNq4e1
	XDNMjrQuP84JBfwkwVupxAncbjOrmENIdy584sjRDfPO1P4ylw8RGywi7Jk0Wy4lyiAcbXlyrin
	JY8Ys84fAyk9uRkGS2tx12ZbNgHo8QXEj74HKJiJg8STQJYn6ozFyWHOBbRhvoYnrGpUk0p3s/B
	2cm11QHNu4w7yaYCbi0tHNP2xLvPETuekK+sU7bv/KbTXq
X-Google-Smtp-Source: AGHT+IEz25rvLLxHuk3ysSacq6OhjKy7TtFo2WhGMatEMWSTwaZzcg8iEbHjUkoGgNpTVjPTscqFmjN3vqgThSM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:ef:85c8:ac13:4239])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:a793:b0:2e9:47ad:c4f9 with SMTP
 id 98e67ed59e1d1-2e9b14dd956mr32368a91.0.1731087083068; Fri, 08 Nov 2024
 09:31:23 -0800 (PST)
Date: Fri,  8 Nov 2024 17:31:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108173112.1240584-1-calvinwan@google.com>
Subject: [RFC PATCH 0/1] maintenance: separate parallelism safe and unsafe tasks
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, steamdon@google.com, emrass@google.com, ps@pks.im, 
	me@ttaylorr.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"

Unless a user changes the config options `gc.autoDetach` or
`maintenance.autoDetach`, Git by default runs maintenance and gc tasks
in the background. This is because maintenance and gc tasks, especially
in large repositories, can take a long time to run. Therefore, they
_should_ be as nonintrusive as possible to other Git commands,
especially porcelain ones.

However, this is not the case as discovered earlier[1] -- certain
maintenance and gc tasks are not safe to run in parallel with other
commands. The consequences of such are that scripts with commands that
trigger maintenance/gc can race and crash. Users can also run into
unexpected errors from porcelain commands that touch common files such
as HEAD.lock, unaware that a background maintenance/gc task is the one
holding the lock.

As Patrick points out[2], the two unsafe commands are `git reflog expire
--all`, invoked by gc, and `git pack-refs --all --prune`, invoked by
maintenance. We can create two buckets for subtasks -- one for async
safe tasks and one for async unsafe tasks. When `[maintenance,
gc].autoDetach` is not set or set to true, maintenance will run the
unsafe tasks first before detaching to run the safe tasks.

This series is in RFC to see if the general direction of the patch is
going in the right direction. I left a couple of WIPs in the first patch
documenting what still needs to be done if the direction is palatable.

[1] https://lore.kernel.org/git/CAFySSZBCKUiY5DO3fz340a0dTb0zUDNKxaTYU0LAqsBD2RMwSg@mail.gmail.com/
[2] https://lore.kernel.org/git/ZxeilMDwq0Z3krhz@pks.im

Calvin Wan (1):
  maintenance: separate parallelism safe and unsafe tasks

 builtin/gc.c           | 173 ++++++++++++++++++++++++++++++++++++-----
 t/t7900-maintenance.sh |  24 +++---
 2 files changed, 168 insertions(+), 29 deletions(-)

-- 
2.47.0.277.g8800431eea-goog

