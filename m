Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22C78F59
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774702384; cv=pass; b=WOThowL93HnCBZZlD57UGlJpbAhha4FZ+y10tkjU6/yPjLAYDz5gFTPh9x0RdUJalIeyzkFBAXw/qKbfyrFFoslDy1TjLzsxXHE6mhpSt2X6B/1/LZl7F064x5Squ0hfjwmpXlf+8sxegnpzApcbWP4k3nLw2BBIi4XOSeyscTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774702384; c=relaxed/simple;
	bh=wLk9b6jJk+H+JFRHBQBa3yis023aHG4Weo8prxw3dKM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pYdjI0rvsgUqa2m7jTctEVQsEXesZACJt8ebv5TCjDNEOiTpAGjbc67Qq/yXD+ZdgW2AyyoSaGuMPr2j9lyp0glIdWIPFzmI3YQahF2XP8Q6mvBebCLApRoAcOKGKj15Ivga2ryc97tm0QEp6ik8xxQXSUlQoEHuyUcFxc68fhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhCGUKZk; arc=pass smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhCGUKZk"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-64acd19e1dfso3025289d50.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 05:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774702382; cv=none;
        d=google.com; s=arc-20240605;
        b=lIh8dnfI2ok3eMWs6IJXmIZTvPOXOaoKsFBRBQSzzEHa4qkIUlMLoO0j+qFFcWRvxg
         NMgwI6qXBadcVAytS3exrvsnc9vO+K0MYpFJ6v5m8/aG3eiHUzzEMRKRGcpS1l9V+nAq
         P2HltewdBEQiqIMeFPRVpocwvHrvxexMG9cov+7/HLzVVfSlu2WGYMbs9CBNLJsjVmoH
         PNvcDRj6Sd6vlai23E8OdEHzwvRhTOM6CQUa+K4DvOnvk8VfUNsA7yZ34NZh4Cdzb5Qf
         zpT3xsfdbbGvewaHu90Da/V6xJf3miGnBHJ6BYAP2VRMYCwbuoxqNIUsoIA3/EuO8rsG
         3hdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=wLk9b6jJk+H+JFRHBQBa3yis023aHG4Weo8prxw3dKM=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=gFyuVUfvNjY3LZDRXcK1zWCprsLIEpBwxHhBh7RZCkDeJo4KflksPcvrrhuNQGspeW
         ZP3HYJETA3mbZ4Nvg7k4Fd4g2wMJGclFdUl0VJ8SewrKBNeNccwVU4CqCjZ4Bym88kAc
         n2j/PvGl82Ga8mj2OUPz6oGWUjrRTHrBy88KOdz+dX71lYrbpO0/Pfp1rjDQrmmXZrtU
         E4oFiTfcqtu4hrcjjxaRcddWhndHOpDc/tCjo7UC05c5vMxSfKc8vKU+StX75ISwAJuO
         RWYCPsgyFUaUvMnUDc7DMbfTNl5v/SRfKpyh8oADYZHUgXomALxxpJYPGY4+sGRt2szL
         IKmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774702382; x=1775307182; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wLk9b6jJk+H+JFRHBQBa3yis023aHG4Weo8prxw3dKM=;
        b=rhCGUKZkKuye7PGaSAqh9mKEaweLXSulUK+fWIMoIyWnMijs7DyzialXQISysfFwzs
         Ch2p/0Xs7YvMqg3sLb5IhIZfvFl84N4ni/zA5Xhua10BX3dCvvbvB4EAR8voroxJQJsl
         zvuqowUlZgO4+r10eKqNCKp+Q8eS03bdVobGaC4o7BpbFGsdcPs8aMUNKW/SbgDxB+Ps
         8FoY8/Wgfeopqu1adDuHQo/zX4X9gohw2HyDDWQjSlDD/7hTstu0C59VPNEFtXbslUuZ
         jIseU0FbzV0ZqOeqpc/k2TanTZi8SdZ5tHV+qWoOfO7KWCx1cMK2YzE/ZLqHQlmqdhCj
         EtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774702382; x=1775307182;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLk9b6jJk+H+JFRHBQBa3yis023aHG4Weo8prxw3dKM=;
        b=fv8/fIIE3ABKEzWtkIMZKSWa4Qu5mnj+xAFZDe9t77RHGu3X06t29wMrP1nnJY4I9X
         vMtEsiJYGiPOk8k4+/qucEl8MWRbq6CqqMEwKN+m3rPzypa/7U+hdmJw8Mxgks68Fwuq
         ZnzAyDwEYYppeWqu3QliibSQYuwxJX9jfY+CHFAmQcRMPt2jmIFP4IyZ1ln7O/0LBgII
         e1YOgzZiQNJ4gsgFJTOF+32hiKCA7ZCQraVS8PxYiCPe7zij4+jW5N67TTW/hCgMJz9v
         9xfPjjKJRwn4YuxtfTtM2UGl5k4fec5wwQLsj2Q6UINzAndEizAavqLsyyjEH63XS4SB
         GalQ==
X-Gm-Message-State: AOJu0YwKCqy50xaKC2i4XmWORjUGJAvqFy7ledQy3hhqsOArPyIXUiZT
	bpRIg9/fac17WBXj7hGSkulcw4w+7OKvm7WpcjnIPIs5M9ivNGObhjZ0vLGLKf4XZ/NU4gNo/fk
	cL0X6jbrSg6WQ5H7dhOokwSYjKbF/VAFZVRMdeVvmCoe9
X-Gm-Gg: ATEYQzzeAtOHygRMtzVwdMJ1SgZDIFsmM1EcsUMQe93iZCHCBwPrZWJQMgAWMFHu4nE
	xG1F6S590EmuhgkdMfiHgwGR+phQext2OhrCCXH4lEEqUgpkbIqECyhvJJ14q6t8PvunnUuqLvs
	AE6UvP08Lerv0Waa+tEG9iuqFYZcUPtlgf63g+x7uEBM8ZFVa+LikFHVvxkJuS3a15LHDt71fV2
	+MOed1TlK9wwbDBY88p6fs8dHRCdXJzY5+zbIzZ6IalKOG/+Z38Uy13lpaylTFXlHYMYaLgq2Mb
	FaaAEdJy20OSFsdfUedmzr/fU9XarAIlj4eNcSEFB+k3pZlkP1OYlwP2G1ZLXvUaosdtZcM/fuE
	Tb6CzVsQeLuPz49a0clvMAjVcYw==
X-Received: by 2002:a05:690c:f14:b0:79a:bdac:adf with SMTP id
 00721157ae682-79bddce4c36mr65048127b3.14.1774702381544; Sat, 28 Mar 2026
 05:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mahlet Kassa <mahlet.takassa@gmail.com>
Date: Sat, 28 Mar 2026 13:52:50 +0100
X-Gm-Features: AQROBzDZwjOaLoqf5vsxuaEcrgtlduk8nBDZeKB6bsj0w0woVaf9fByDpYGBL-0
Message-ID: <CACcFiUZ6jgVua-BK=eR7Sjet99UsDKFxTFVQ6E2GqdT8VyL=qg@mail.gmail.com>
Subject: [GSoC][RFC] Proposal draft for "Improve the new git repo command"
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am applying to Git for GSoC 2026 and wanted to send my current
proposal draft for feedback.

The project I am proposing is Improve the new git repo command.

My current draft focuses on small improvements to `git repo info` and
`git repo structure`. Right now I am mainly thinking about selected
path-related values currently obtained through `git rev-parse`,
clearer grouping of returned information, and small improvements to
the current structure statistics.

I am trying to keep the scope small and reviewable instead of turning
it into one large feature series.

During the application period, I also sent a small patch in the same area:

- `repo: show subcommand-specific help text`
- message-id: `<20260323152937.257406-1-mahlet.takassa@gmail.com>`

I have included my current proposal draft below.

I would especially appreciate feedback on whether the scope looks
reasonable for a 175-hour project, and whether the proposed `git repo
info` / `git repo structure` direction seems like a sensible way to
approach this idea.

Thanks,
Mahlet Kassa

---

# Git GSoC 2026 Proposal

## Title

Improve the new `git repo` command

## Organization

Git

## Project idea

`Improve the new git repo command`

## Expected project size

175 hours

## Proposal summary

I am applying to Git for GSoC 2026 with the project idea `Improve the
new git repo command`.

The part of this project that interests me most is that it is focused,
concrete, and close to the code I have already started reading during
the application period. The `git repo` command is still new and, based
on the idea page, there is still room to improve both the information
it returns and how that information is organized. My current proposal
is to work on small and reviewable improvements to `git repo info` and
`git repo structure`, instead of treating the project as a large
redesign.

## Problem statement

The Git SoC 2026 ideas page lists several possible directions for this
project. These include adding path-related values currently obtained
through `git rev-parse`, returning values by category, and extending
`git repo structure` with more repository analysis or statistics.

What makes this project interesting to me is that these are not
completely separate tasks. They all relate to a broader question of
what `git repo` should expose, how it should present this information,
and where it should complement existing commands without overlapping
with them too much.

For that reason, I do not want to propose a broad feature expansion
with unclear boundaries. I would rather work on a few concrete
improvements that are useful, tested, and discussed early on the
mailing list.

## Why this project fits me

I am currently a software engineering student at 42 Berlin. Prior to
that I primarily coded in Python as a cognitive science researcher. At
42 however, almost all of my projects so far have been in C, Unix
systems, shell work, and lower-level programming. I am still early in
my coding journey, but this is also why Git is a strong fit for me as
an organization. It is a tool I already use, and this project would
push me further in areas I want to improve in: reading and navigating
large C codebases, understanding existing command behavior, and
learning how to contribute through a review-based development process.

At the same time, I do think I already have some useful preparation
for this kind of work. My recent projects have made me more
comfortable reading C code, debugging command-line behavior, and
writing tests around small behavioral changes. That is still a limited
level of experience, but I think it is a good base for a project that
needs careful, incremental work.

I also think this specific project is a better fit for me than a
broader or more protocol-heavy Git idea, because it gives me a
concrete place to start. The idea page already points to
`builtin/repo.c`, the `git repo` documentation, and comparisons with
`git rev-parse`, which makes it possible to approach the work in a
structured way.

## Background and preparation

During the application period, I built Git locally, read through the
implementation around `git repo`, and worked on a small patch in this
area.

The patch I sent was:

- `repo: show subcommand-specific help text`
- message-id: `<20260323152937.257406-1-mahlet.takassa@gmail.com>`

This patch touched:

- `builtin/repo.c`
- `t/t1900-repo-info.sh`
- `t/t1901-repo-structure.sh`

This was useful preparation for the current proposal because it
required me to read the command implementation and tests closely,
understand how the subcommands are wired, and go through the
mailing-list submission process in the same part of the codebase as
the proposed project.

The patch also received positive feedback from Junio C Hamano and was
queued. For me, the main value of that contribution is not only that
it was accepted, but that it helped me understand the workflow I would
need to follow for this kind of work.

## Proposed work

My current plan is to focus on two parts of `git repo`.

### 1. Improve `git repo info`

One likely direction here is to add selected path-related values that
users currently get through `git rev-parse`. Another is to improve how
returned values are grouped or presented.

My current thinking is to start with a small set of path-related
values that seem clearly useful, add those first, test them, and then
see what still makes sense to add after discussion.

I do not want to approach this as an attempt to copy `git rev-parse`.
Instead, I want to look at which values make sense in `git repo info`,
which ones are genuinely useful, and how they can be exposed in a way
that is still clear and consistent.

### 2. Improve `git repo structure`

The second part of the project would focus on extending or improving
the statistics reported by `git repo structure`.

Here I would also prefer to start with one small improvement to the
current statistics and keep it limited enough that it is easy to
review and discuss.

Here again, I want to keep the work limited to additions that are
useful and easy to justify. I do not think it would be a good idea to
make the command noisy or overly broad. The goal would be to make it
more informative while keeping the interface focused.

## How I would approach the work

My plan would be to start from the current implementation and refine
the exact scope through discussion with the Git community.

The steps would be roughly the following:

1. Read more of `builtin/repo.c`, the existing tests, and the current
documentation.
2. Compare the current behavior of `git repo info` with `git
rev-parse` to identify useful gaps.
3. Choose a first small improvement that is easy to discuss and review.
4. Implement the change together with tests and documentation updates.
5. Send the patch series to the mailing list and revise it based on feedback.
6. Continue with the next small improvement only after the previous
step is reasonably settled.

I think this kind of step-by-step approach is important for this
project because the harder part is not only writing code, but also
deciding what should belong in `git repo` in the first place.

## Deliverables

At the moment, I expect the project to produce:

- one or more improvements to `git repo info`
- one or more improvements to `git repo structure`
- tests for new behavior
- documentation updates where needed
- mailing-list patch series for each milestone

The exact patch breakdown should remain flexible until there is more
discussion about the design direction.

## Timeline

### Community bonding period

- read more of the current `git repo` implementation and nearby code
- review prior discussions related to `git repo`
- ask for feedback on the project direction
- narrow the project into a smaller set of changes that seem realistic
to work on one by one

### First phase

- start with one small `git repo info` change that seems useful and realistic
- implement it with tests and documentation updates if needed
- send the first patch series
- revise it based on feedback

### Second phase

- continue with the next `git repo info` improvement if that still
seems like the right direction
- or shift to better grouping/classification if discussion suggests
that would be more useful
- update tests and documentation as needed
- keep revising based on feedback

### Third phase

- work on one small improvement to `git repo structure`
- keep the scope limited enough that it is still easy to discuss and review
- test the output carefully
- revise it based on feedback

### Final phase

- complete follow-up fixes or smaller improvements that fit the agreed scope
- strengthen tests where needed
- address remaining review comments

## Risks and constraints

The main risk in this project is scope. Since `git repo` is still new,
there are many possible directions that sound reasonable at first. I
think the best way to deal with this is to keep the project limited to
a few concrete improvements and to discuss them early rather than
deciding too much in advance on my own.

Another risk is that some additions may overlap too much with existing
commands. That is why I want comparisons with `git rev-parse` and
mailing-list discussion to be part of the work from the start, not
something that only happens after implementation.

Finally, review iteration itself takes time. For Git this is normal,
so I think the practical response is to keep changes small and send
them early enough that there is time to revise them properly.

## Communication plan

I plan to communicate mainly through the Git mailing list and to
follow the normal Git contribution workflow.

In practice, that means:

- asking questions early when I am unsure about design direction
- sending proposal drafts and patch series early enough for feedback
- keeping changes small and testable
- revising patches based on review comments

## Why I want to work with Git

What attracts me to Git is not only that it is an important project,
but also that small behavior and interface details matter here in a
serious way. I like that commands are expected to be clear,
consistent, and carefully reviewed, because that matches the kind of
work I want to get better at. Git also feels like a strong fit for me
because it is so closely tied to command-line and Unix-style ways of
working, which is where most of my recent learning has been.

I am still early in my software engineering path, and I do not want to
pretend otherwise in this application. At the same time, I think I
have already shown through my small `git repo` patch that I can work
through a focused change carefully and follow the review process in
this area of the codebase. What I can offer is that I am willing to
keep working in that way: read carefully, work incrementally, ask
questions when needed, and revise my work based on feedback.

## Prior contribution

My current Git contribution related to this proposal is:

- `repo: show subcommand-specific help text`
- message-id: `<20260323152937.257406-1-mahlet.takassa@gmail.com>`

In the final application submission, I plan to include the
mailing-list thread for this patch and the thread for the proposal
draft as supporting material.

## Final note

This proposal is intentionally specific about the general direction of
the work, but still open about the final patch breakdown. I think that
is the right balance for this project. The details should be refined
through discussion with the Git community and then implemented in
small, reviewable steps.
