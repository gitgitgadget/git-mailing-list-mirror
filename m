Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A25280A21
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770076; cv=pass; b=qhWVe1LLsuG7p9NCfpT/YWBqd483FBi4qCGOGuTIc7bfNWil7Bbng90yVENyzzXq7lwK7hW6uWzXFBk37djE/qEnLlJpKMhnitWF1PbsAo+OJDbdGDDl6r75b8idkuL8YzJdpaDqxf+DwWF6j6TUX5IUReo2ukluo1tx+frN4pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770076; c=relaxed/simple;
	bh=o3izoNanVVb+II7Z6PNGmr5Sw1cfS09ZXNEua+/8QL0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YEKogMmgzpgfzbg2xSUHF0aaZV+XWyuUIFI86iUJCpgF5nfnf7YGrwF55oiKwtEQqISGGcoLxp+zxK/65s2l5XqvWpJDXt3pQkRG+qbbyOzXmOYfbvwayRRM6I/Ay6M+rLKEWqBvC8PertT7+ygUjegT/yH/SQ6D6eyrDakzG1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLYdMJYe; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLYdMJYe"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cd847b4b23so572532385a.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 10:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773770069; cv=none;
        d=google.com; s=arc-20240605;
        b=i0LcQNuipM7TEu4RNLqx7d604/3B6Ji11AMUvP5yI35y+2Hp9/fpVMvkxAay8A/Oo8
         CH7D292kQIezV31z8XxirFGbv+L28d/WGm66zDaFCy5r3Ze95nx2PLQY/sxTh9BtDLzr
         SbxpIZlmeRcjEVI5qid3azFbQZnnY06l4a7jZZww0TOa02KS5PNZ2QQckXKLadmqOXcj
         RO+H0m/X8qoNODJvaX6BJTpj0q8uWv0vUwFDsuUfwtwkRw1es3iiY2nH8FxAm0rDGW3l
         dWxUJ8mkTYBdBDTYWSOtviLZ+HyW8aZ6S//+A2qACuPfuvb6/Dy832S0W0PWpi0krcI5
         nLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=wZpihsrq/G5IyeBy8MLaGhM8kpqdbkUkrICrX9dRI2w=;
        fh=n4UUFXWHe/KDSGAC0s4HipOuF4km4MhGvqzYcEtfH50=;
        b=V1OU6muADT4UYBoaQSIJMuX8CnuBpR96pSzjkHhmHZNGEz54xxC94N6vSJQ/FKeyie
         G+6W3oHmw9P6ELgD+tXE+4dk7p7OcoNnGD2tAuo7tbsZNs7/cxHpC7PV8fuedrTS1+1p
         iH++h8sB0PHWKEFESVOPmCq0AbbCdzCfvMVp0kNEwjoHXjcb191jSpG3JfYyChbSR2R9
         kcrmbqv2iSAj3d1/c0iKrqdAu2GoCtNct695N+uSjlAVfd0sh9FJWjjpmWXQY9Te1wUw
         tzDAhjgWyJmNanoIrYnbPVCh2i4ZhA+8sT1zYXcdjqMYFmBDZr89S9l+ecn134b6xMog
         CiVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773770069; x=1774374869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wZpihsrq/G5IyeBy8MLaGhM8kpqdbkUkrICrX9dRI2w=;
        b=TLYdMJYepYTb+CmztcrAlASd2Hl8fEo+j/WgxKzqg6SGiRZ2V59nC0zrBIKsYrK6lz
         ze1Q8o8Nt9eiLG9ECcfbrwOXvA6KzXkJ9ISBwhBy5aTX+gul9Qy7s0XDgQ1vy1LrYWGw
         nBfC0bxKrEDIrQIvGW79XeshWcdVInTuTdRMiuKtQS4aAiw8MM9Txi2ZSHWe62uGIe4l
         RVnco/YJ9iMOmhXVMFO+Zgd2JfpiIXc7p/Nokhvw/Ze4eaXOuh41JNJqg792ZMjusVKR
         3v7tObF370eGtukg0KNi2UyB9cH8MH2Os+qpvWDGhl9Lt3YjKueJzwU0wPLM6WjkW1fu
         //RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773770069; x=1774374869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZpihsrq/G5IyeBy8MLaGhM8kpqdbkUkrICrX9dRI2w=;
        b=NMO/92lDt2AlJityEuItFv76oF4yANmxiyhD2z66aP+5B4K9uLBX9mb+T/V4IpFUvc
         cB16kBKCU9y2M5Qvy/n4FZcFQF4Oql613yZZZtHRWusYHRH+HeS68g+dBZtJMUSfjMU7
         uzMlBqcM6pg9gGBsoaxgteCqikNfroKAW4H1TpxXqbTMNKtWN8QcC0M1MhIk3Lp/d9B8
         oGh+t4wb+8p6HOuwagaQTnPHo4LdqeUzeQHrfGDNqlDGit7Rwvzkg8YdGOVJR/U9JMal
         PIbROrMZ1MsMrfXSRZo1BoEgzG77KB8eJ1ShTPpk3/lMzfgcM+gd0VJy2TUCivJ0WvoM
         8hcA==
X-Gm-Message-State: AOJu0YwZiTxVvcOEx+dqErY5CQ5GyohoPwYjUtaAxwMXFcg3SLZcXwHL
	D2UNbF76nSVZDss35oyNRvPrKbpaJ3j1jQ6EBFV+MNt2j3cqTZMrvGIJfibR2wdbrezD953C4dD
	3DH1SxmE4pa+IMN/QVDzjxRbMi5nZ+xI4mKCIIA==
X-Gm-Gg: ATEYQzzgrkqVlW8Uyit7lwtv90E6f0J6hyG3zsQqN5cx4Q0l1EDa8dlXskX4SD2NFrU
	cG/E1TtoSt/HLDxLwvJ1hId8xjN+c4wrFeEBboSykGHZHePGy/Q5nnrsZbGiwYOVdJr1f8ozQKa
	4Mcs9S6K+r/9pmzY+ve10pNphgnur5awTsWITQrbr1VKgAtqp0NEUK9YiDtjzr01O2nDSGuIYMN
	GHywOm6VURR01rz3px72bZuMLrNYeRJp2CT+EgWp9qjK52HnY4l7mTTAZ1u6qsd3FrK7B7O8WYc
	LTME8MH3wKuGPXv6S9y7+OBlg4UQ3CJ2A2Tq
X-Received: by 2002:a05:620a:4108:b0:8cd:96e5:f7be with SMTP id
 af79cd13be357-8cfad3ae02fmr62353485a.69.1773770069196; Tue, 17 Mar 2026
 10:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Francesco Paparatto <francescopaparatto@gmail.com>
Date: Tue, 17 Mar 2026 18:54:18 +0100
X-Gm-Features: AaiRm50P6rJLmarAiqGv7jN495U04Z1PcE_1CIT84hbJZ4VGFF7rpe1DH2e91Yk
Message-ID: <CAEaT9_9jAoXkxKn+2+q654aKybC1=bk6p7xiVHmcy+YDDe7GXw@mail.gmail.com>
Subject: [GSoC Proposal] Refactoring in order to reduce Git's global state
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, Ayush Chandekar <ayu.chandekar@gmail.com>, jltobler@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Refactoring in order to reduce Git's global state

Personal Information
--------------------
Name: Francesco Paparatto
Pronouns: he/him
Location: Milan, Italy
Time Zone: CET (UTC+1)
Email: francescopaparatto@gmail.com
GitHub: https://github.com/frapaparatto
LinkedIn: https://www.linkedin.com/in/francesco-paparatto/

About Me
--------
I am Francesco Paparatto, a self-taught programmer who dropped out
of a degree in Management to dedicate full-time to software
engineering.

My goal is to work as a Backend/Infrastructure Engineer,
and to reach that goal I am balancing CS fundamentals through
theoretical courses with challenging projects that help me develop
strong engineering skills, not only from a code perspective but also
from a system thinking point of view. I also like building
fundamental things from scratch in order to understand how they work.

This is my first time in open source and I am fascinated by this
world. I wish to become a cornerstone in one open source community.

Git Experience and Contributions
---------------------------------
I started learning Git in depth at the beginning of 2026 when I
began working on my cgit project [1], a small reimplementation of
Git's core plumbing commands in order to understand how they really
work under the hood, but also as a way to start reading and learning
from real codebases and learn how to design and structure code
properly.

So far, I have made the following contributions:

* [GSoC PATCH v2] t3310: replace test -f/-d with
  test_path_is_file/test_path_is_dir
  Link: https://lore.kernel.org/git/20260228005939.9012-1-francescopaparatt=
o@gmail.com/
  Status: Graduated to 'master'.

* [PATCH v4] t3310: avoid hiding failures from rev-parse in
  command substitutions
  Link: https://lore.kernel.org/git/20260307103631.89829-1-francescopaparat=
to@gmail.com/
  Status: Will merge to 'master'.

Overview
--------
Git's internal functions rely heavily on global state stored in
environment.c. Configuration values like trust_executable_bit,
editor_program, and git_commit_encoding are declared as file-scope
globals and populated at startup through git_default_config() and
its sub-handlers like git_default_core_config().

This design assumes a single repository per process. When Git is
used as a library (libification) or needs to handle multiple
repositories in the same process, globals from one repository
overwrite values from another. For example, two threads formatting
commits for repositories with different i18n.commitEncoding settings
would race on the same git_commit_encoding pointer.

The goal of this project is to move these global variables into
per-repository structures within struct repository, following the
pattern established by Olamide Bello's Outreachy work with struct
repo_config_values [2].

Context and Prior Work
-----------------------
Not all config variables can be treated in the same way. There is
a fundamental distinction between eagerly and lazily parsed
variables, and conflating the two causes regressions.

Variables set in git_default_core_config() are eagerly parsed. They
are read at startup, and if a value is invalid, Git calls die()
immediately with a clear error before doing any real work. The user
gets early feedback and can fix their config.

Variables in struct repo_settings are lazily parsed. They are
populated on first access via prepare_repo_settings(). If an eagerly
parsed variable is naively moved into this struct, invalid config
that used to crash at startup now crashes mid-operation =E2=80=94 the user
may have already started work that is now lost.

During GSoC 2025, Ayush Chandekar moved several global configuration
variables into repository-scoped structures [3]. Through this work
and subsequent review discussions, the eager/lazy problem became
visible [4].

Ayush's work also surfaced the getter/setter debate. When he
introduced getter and setter functions for repo_settings fields,
reviewers pointed out they added no value without calling
prepare_repo_settings() internally. From this discussion, Junio
suggested two approaches for repo_settings variables that must
not be mixed [5]:

- Common variables: populated in prepare_repo_settings(), accessed
  directly via repo->settings.foo. No getter, no setter.
- Rare variables: prepare_repo_settings() does not touch the field.
  A lazy getter checks a sentinel value (e.g. -1), reads from
  config on first access, and caches the result.

The appropriate pattern for each variable will require reasoning
and discussion on the mailing list.

Phillip Wood suggested a third approach: passing a
repository pointer through git_default_config() via the void *cb
callback data parameter, so handlers can populate per-repo structs
without touching globals [6].

Building on these lessons, Olamide Bello during the Outreachy
program introduced struct repo_config_values [2], a structure
linked to struct repository that stores eagerly parsed configuration
values while preserving their startup-time error detection. An
accessor function repo_config_values() enforces safety by preventing
access from uninitialized repositories and guarding against access
from secondary repository instances that do not yet have their
config populated.

So we now have two structs living inside struct repository:
repo_settings for lazily parsed variables, and repo_config_values
for eagerly parsed variables.

Approach
--------
I will follow the pattern established in Olamide Bello's approved
patch series [2], which provides the concrete workflow for each
variable:

1. Add a new field to struct repo_config_values in environment.h.
2. Initialize the field in repo_config_values_init().
3. Update the config callback: get cfg via
   repo_config_values(the_repository), write to cfg->field instead
   of the global.
4. Update all call sites: replace the global with cfg->field.
5. Remove the global from environment.c and the extern from
   environment.h.
6. Run tests and check fuzz targets.

This workflow is not purely mechanical. Each variable requires
case-by-case analysis:

- Is the variable per-repository? Some variables like
  editor_program are user preferences. As Phillip Wood asked [7]:
  "Why would I want to use different editors for different
  repositories in the same process?" Variables where per-repo
  scoping does not make semantic sense may be better handled by
  localizing them to their subsystem.
- How deep is the call chain? As preparation for this proposal, I
  traced askpass_program end-to-end. It has a single reader in
  prompt.c, which looks simple. But git_prompt() is called from
  two paths: the credential system and the bisect system. The
  difficulty of a variable is not about reader count =E2=80=94 it is
  about call chain depth.
- Are there initialization ordering constraints? Some variables
  like is_bare_repository_cfg are set during .git directory
  discovery, before struct repository is fully initialized.
  Moving them into the repository struct creates a chicken-and-egg
  problem that requires design discussion on the mailing list.

The macro #define USE_THE_REPOSITORY_VARIABLE, introduced by
Patrick Steinhardt [8], controls access to the_repository
global. The macro serves both as a migration indicator and a
technical gate. When all globals in a file have been migrated
and all functions receive struct repository * explicitly,
the macro can be removed.

Following Stolee's two-step migration model [9], I will first
move variables into repo_config_values using the_repository
(Step 1: safe, mechanical, no behavior change). For selected
variables with shallow call chains, I will also thread struct
repository *repo through callers to begin replacing direct
the_repository usage (Step 2).

I propose a dual approach for organizing the work:

- Variable-focused migration: move environment.c globals into
  repo_config_values following Bello's pattern. This is the
  primary track. For each variable, I classify it, trace readers,
  migrate it, and remove the global.
- File-focused cleanup: for files where only a few the_repository
  usages remain after variable migration, complete the cleanup
  and remove USE_THE_REPOSITORY_VARIABLE entirely. This is a
  natural side effect of the first track.

Some variables may need a hybrid approach: when a variable is
used across many files but heavily concentrated in one subsystem,
it may make sense to migrate it alongside other globals in that
subsystem rather than in isolation.

The two tracks reinforce each other: migrating a variable often
removes the last reason a file needs the macro.

Timeline
--------
Project size: 175 hours.

Community Bonding (May 1 - May 25):
- Discuss project direction and design approaches with mentors.
- Study Bello Caleb's and Ayush Chandekar's patches in depth.
  Review remaining repo_config_values work and identify
  unfinished tasks.
- Identify and prioritize two main areas of work:
  + Variables in environment.c to migrate into repo_config_values.
  + Files where USE_THE_REPOSITORY_VARIABLE can be removed.
- Submit an RFC patch following Bello's pattern to validate
  the workflow before the coding period begins.

Coding Period (May 26 - August 16):
- Start with straightforward variables: those with few readers,
  clear per-repository semantics, and simple parsing logic
  (e.g., boolean flags and integer configs).
- Progressively move to more involved variables with deeper call
  chains, string-type values, or dependencies on other variables.
- Apply the dual approach described above:
  + Variable-focused migration: classify, trace, migrate, and
    remove globals following Bello's pattern.
  + File-focused cleanup: where variable migration removes the
    last global dependency in a file, complete the cleanup and
    remove USE_THE_REPOSITORY_VARIABLE.
- Submit small patch series (3-5 patches each) frequently to
  respect reviewers' time and maintain steady velocity.
- Maintain two parallel series: one in review and one being
  written, to account for review cycle delays.
- Continuously iterate: incorporate mailing list feedback,
  reroll patches (v2/v3), and refine the approach based on
  community input.
- Publish weekly or biweekly blog updates documenting progress
  and design decisions.

Final period (August 17 - August 24):
- Address any remaining tasks or pending patches.
- Run full test suite with AddressSanitizer to verify no
  memory issues were introduced.
- Update internal documentation.
- Receive final feedback from mentors and reviewers.
- Prepare and submit the final project report.

A 30% buffer is built into the schedule to account for
unexpected review delays and design discussions.

Blogging
--------
I believe blogging is an important part of growing as a developer
and an effective way to learn, because writing forces you to
truly understand what you are working on.

I plan to publish weekly updates documenting my journey through this
project: progress, design decisions, challenges, and lessons
learned. I also want these posts to serve as a valuable resource
for anyone who, like me today, will look for guidance on
contributing to Git or to open source projects in general.

Availability
------------
Git will be my top priority. I have no other commitments
scheduled during the GSoC period, so I will be able to work on
this full-time. In fact, I plan to devote 35=E2=80=9340+ hours per week
to the Git project. My preferred working window is 9:00-18:00 CET.

Post-GSoC
---------
Contributing to Git has been an invaluable experience.
Not only on a personal level=E2=80=94because it pushed me out of my
comfort zone and challenged me=E2=80=94but also, and above all, on a
professional level. The feeling of working on code used by millions
of developers and companies around the world is incredibly rewarding.

This iterative process of discussions, writing code, and receiving
feedback helps you grow tremendously as a developer=E2=80=94and
especially quickly.

Being exposed to a codebase like Git=E2=80=99s forces you to think much mor=
e
deeply, to understand how everything works and how it connects
to the rest of the program. For these reasons, I intend to continue
working on Git even after GSoC by contributing patches, participating
in discussions, and reviewing new members=E2=80=99 code.

Furthermore, this refactoring process is a long-term effort,
and I=E2=80=99d like to keep working on it.

References
----------
[1] https://github.com/frapaparatto/cgit
[2] https://lore.kernel.org/git/cover.1768217572.git.belkid98@gmail.com/
[3] https://lore.kernel.org/git/20250603131806.14915-1-ayu.chandekar@gmail.=
com/
[4] https://lore.kernel.org/git/17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.=
com/
[5] https://lore.kernel.org/git/xmqqbjquge0c.fsf@gitster.g/
[6] https://lore.kernel.org/git/d61c966b-61ae-4ba9-b983-c8dab6e2c292@gmail.=
com/
[7] https://lore.kernel.org/git/8e657184-ee0b-453a-9f2d-a98080d3582e@gmail.=
com/
[8] https://lore.kernel.org/git/cover.1718347699.git.ps@pks.im/
[9] https://lore.kernel.org/git/47d09c43-6d27-40ff-8dbc-22cc4a5949ed@gmail.=
com/
