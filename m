Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569A28C87C
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772334661; cv=pass; b=NjDK/QqU17ouWmlCVlO71TDohbo2w8AAt9jHvjkqimNRvhAysJB8OHT6QzS4ZOwisuTAYmoIw0opUHkwpBSc9kwPpvlaeYyKm2tkd51hKQk41C+eQw8C06gNkifRNqsqFL5MrbDFTEiHMD+CG14SyV05xKf6R0dOJdGK+JZp+/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772334661; c=relaxed/simple;
	bh=YYq7TNZpIoYtKDwQ/rXUDSKibfw//ThGNtV+qHaCwco=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EVVJxCNLPbojJJDWgJOX520V3Js8l6C54IFKujSdd12JgaKYJJj+opL9CYgLqBGXkgGQSI6YcuYa2fWOn/MpMNRW+CfDN9TGnEDMCKiWdez+ORePHOyDnB5iTCh90k42cqJiSSiLcoqevvu4iPR1FVXZY7NnPQbAJUQhM74uUtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2AOaCNq; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2AOaCNq"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50334dd44d2so40505581cf.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 19:11:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772334659; cv=none;
        d=google.com; s=arc-20240605;
        b=ds2Hmhk+6H7Ah5iOtq3eh1qTapk2mFLBzUWNV5rRIsBLYBgWdZhiOSKK1rIexL1wqy
         b2WNsEOsGoGsA0sKOER4Xel63+umLnxHRV1yXukGK9YKD+OIpEnrnj/VXV5mSviw7XmS
         lgxzbWB7YoJlGPGcAaMA5v3OwYWWC+WiFXd0okTkKPGCZGNwmSI+sSRBFVwjsE9Y1dT/
         q+AHkEXsFiBfBrM2ymceznHm/zrsjEsllJ+/o0p+UVubD70RweztNby7CrnCvUOWYJoS
         XNRTIU8wtTDI5hPNIpiYRXmtj1SqO7NoJnn6/jsplCcDVTzIhsR94HkAvanGkX+UMI76
         LXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=wYFYzZaL4C2l7Rem0y4bAqxlRjJ0xz5OjlWR7XKx27g=;
        fh=Gwn4hpNQs5+sAqNqM7IZ86HdNhzL5byn0P3rWsKqwTc=;
        b=VSBbcj0Jv7PjqxVDim+pqI4LUlBHQXpNkhkuXEtIueeh5Snfpgne7SlbrvRW+gr+2m
         fs9Y1byex6fI+lPawXkjvD5NdNh0yDVsICAyEnHZ7H560DA3oJvgsQb+p6LwovFN+yAQ
         PdoGZ8L0p5RUmE/mdy47uKws7ayljcOpjbUblZNDY5Ku/6TyVJjdYLlm25ziBRw28pLa
         zXnR5oRlO4HW8xmxalCf5Ny+eCXnYLfEspS5GqhE+oPa3muU/uf00WDkbkA3jmgRU0cH
         BwHmf7ZqPkhXtCvu7LIHf2QCFadXyMMLtoRTRWmDbbyHB+f02c2738ynacf5tbfxFlgl
         FhMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772334659; x=1772939459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wYFYzZaL4C2l7Rem0y4bAqxlRjJ0xz5OjlWR7XKx27g=;
        b=J2AOaCNqh630JBW0xcpknDiqYQIbZ3pjVSz6kUPbJL9lzNplAAr3cVNCRBTy0RUvKF
         WJ5gTYP4BRqAY4b2SddAc9Pt0iTdOWxMpMx8LSaGPYg5EixLYUl4n25Y6zj4QW3yHTSh
         1FQdpa8DjYEnhuW6TnQhpGSCsw1yl8oKsxqeg7hmOz28AUAMFCQAdpVI5rUp9sWaq5yp
         tPQO9LQxV7G346/WaGuPj5zhcW6HVMCUHGR8b/BNx3MtX0gzfgr8IB+bg+NoSQMP01o6
         3kd8d8tSYc9r1TI427Q5wSynaKtAwCyAzwrmQcp70tXjlHRrz7Mnx7LjB3pItjnV+GBJ
         Z/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772334659; x=1772939459;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYFYzZaL4C2l7Rem0y4bAqxlRjJ0xz5OjlWR7XKx27g=;
        b=qe4P+FYG+sDroOpnB6b0stgvftOCI/am8aVuxn+1L7NsKjXskt/mXCL5YppBS2c+fl
         m4ToDKOWyX639BbQAa7nmh8KrxOaxScUCEkuyDu9iOqYAaHvLas0Sc+rcub01WFY573A
         V0urTRbuLZTr15kWCWkTg8zW+ns3D/re1gnrxOehkp9AbutJgRVB4bZX004z998FIZbc
         FamE3ONqICuZEW269DrrAVSVxAISk5AQLMQetfhrNJAOWXv6UAj14SxVDrv9wLu6tz98
         GyFhrljheq2mAaPn7v+5ADerz8lo9UxWAiQD+GGLRsKbJJ3/uXgZlrQWet/I5IMxlJ9I
         EHjA==
X-Gm-Message-State: AOJu0Yz3e+fjluFKWv0CKu9EtVzxhlE5lzxp4cbhdpKpfb3EF2J89i3l
	lsgWhfR0jZC4u8EMLrWWPxR6IYAUJYN0MZ+H273YsO+2bjUC5Ef+esqbO2ZZ4wPGPiYKGRJ9/GF
	JgLAsAG/R3HVQcYwiQ9dCGjuPKd6G+vqL5ULFnfE=
X-Gm-Gg: ATEYQzzkkTRUJ8IoGGQpfH5wuq83eaJUkpCgyvmSQMl0RrkeQBv40j2Z3zHflO00yHy
	c7HV/z4ji3yj3GJ+zu529Z//69CkLNlUk2JAk8GztMndWWjvWLHqtfXh4cEwYOnucMRGdCepSxQ
	PWl2q/qEyw2eqCh4/11KjFeyqptqojGDQotsysqjBHdi6uTaPW2Rv8aEfN7Yo5psl6dXd5FmRzH
	AwHoXzd0+wADYrj/iYFmfrmovjU12vnlCWlFtM4A68IaxzBAZ19ubY8HJVeAtyl8QNFun048AjS
	geTzwf1CML972yGRAtwpYYEKzLqKPhgS/048WqAMWfkKjNMXKZNPvP/GW1EWrs8BHswK4ndkypd
	NA1546g7lkCn4YjXkAZoiWhlusA==
X-Received: by 2002:ac8:5ac5:0:b0:501:4446:2ce with SMTP id
 d75a77b69052e-5075288b728mr120303101cf.49.1772334659037; Sat, 28 Feb 2026
 19:10:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 1 Mar 2026 08:40:48 +0530
X-Gm-Features: AaiRm50SpK6YKyvdHoZYWE01K5gYw0O5mYNjeUUXhsZNAX-HoGwprO4zvkI8WF0
Message-ID: <CA+rGoLd-1Mb5JG1H1PvE-kyjdznrLVFjwQiMLHtd2ETQ-igmXg@mail.gmail.com>
Subject: [GSoC][PROPOSAL] Improve the new git repo command
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Justin Tobler <jltobler@gmail.com>, karthik nayak <karthik.188@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hey everyone,

This is my proposal for the project
`Improve the new git repo command`.

---
= GSoC 2026 PROPOSAL: IMPROVE THE NEW GIT REPO COMMAND
Jayatheerth Kulkarni <jayatheerthkulkarni2005@gmail.com>
v1.0, March 1, 2026

== 1. ABOUT ME

I am a junior at Geethanjali College of Engineering and
Technology pursuing a bachelor's degree, with a strong
interest in open-source projects and systems programming.
My interest in the Git project stems from a desire to
understand the internals of version control and contribute
to a tool that is fundamental to the global software
development ecosystem.

=== 1.1 Contact
* Email: jayatheerthkulkarni2005@gmail.com
* Website: https://jayatheerth.com/
* GitHub: https://github.com/jayatheerthkulkarni
* LinkedIn: https://www.linkedin.com/in/jayatheerth/

=== 1.2 Logistics
* Timezone: Indian Standard Time (IST) / UTC+05:30
* Tech Stack: C, Shell Scripting, Rust and Go

== 2. CONTRIBUTION HISTORY

I have formally completed all the prerequisites to apply
for the GSoC "Improve the new git repo command" project.
I have listed all of my work I have done in the past few
months.

=== 2.1 Featured Contributions

For many months, I have been actively engaging with the
Git community through mailing list discussions and patch
submissions. Notably, my work on fixing stash messaging
behavior in submodule environments was featured in Git
Rev-News edition 124.

* [PATCH v3] stash: fix incorrect branch name in stash message*
  Status: Merged into `master` & featured in Git Rev-News.
  Link: https://lore.kernel.org/git/20250611014204.24994-1-jayatheerthkulkarni2005@gmail.com/T/#u

=== 2.2 Core Path and Submodule Patches

* [PATCH v8] submodule: prevent overwriting .gitmodules entry on path reuse*
  Status: Merged into `master`.
  Link: https://lore.kernel.org/git/20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com/T/#u

* [PATCH v2] dir: Fix and test wildcard pathspec handling*
  Status: Merged into `master`.
  Link: https://lore.kernel.org/git/20250422160547.577524-1-jayatheerthkulkarni2005@gmail.com/

=== 2.3 Refactoring and Micro-Projects

I am deeply familiar with Git's test suite and standard
C conventions, having submitted several refactoring and
cleanup patches, including two specific to the
`builtin/repo.c` file:

* [PATCH GSoC] repo: Remove unnecessary variable shadow*
  Status: Merged into `next`
  Link: https://lore.kernel.org/git/aZxyju3B4NHp4c_t@denethor/T/#t

* [GSoC] t7101: modernize test path checks*
  Status: Merged into `master` (Official micro-project).
  Link: https://lore.kernel.org/git/CALE2CrS0Q2NS1DbFv4pyRQsuypu=KH6Kurs=m4yWrFbR9QosoA@mail.gmail.com/T/#t

* [PATCH v2] pull: move options[] array into function scope*
  Status: Merged to `master`.
  Link: https://lore.kernel.org/git/20251212074433.38027-1-jayatheerthkulkarni2005@gmail.com/T/#u

=== 2.4 Documentation

* [PATCH v3] Update MyFirstContribution.adoc to follow modern practices*
  Status: Merged to `master`.
  Link: https://lore.kernel.org/git/CA+rGoLfFVcUFctoEx6wshovGnRW8pTW--ZB42ntd01VHMJm_Rw@mail.gmail.com/T/#t

=== 2.5 Experience with C

Since Git is mainly written in C, I have no issues
navigating the codebase. I hold a Cisco CLP - Advanced C
Programming certificate covering Unix and C systems
programming, and I have completed two full university
semesters of C programming.

== 3. PROJECT PROPOSAL

=== 3.1 Why "Improve the new git repo command"?

This project is compelling because I have closely followed
its development since its inception in GSoC 2025.
Consistently reading the weekly updates
(https://lucasoshiro.github.io/gsoc-en/) and participating
in the mailing list discussions has given me a deep
understanding of the command's architecture.
My previous work fixing cross-platform wildcard pathspecs
in `dir.c` makes me uniquely suited to tackle the path
resolution this project requires, while my C systems
experience prepares me for the architectural refactoring
of the command.

=== 3.2 Introduction

The new `git repo info` command is positioned to be a
cleaner, programmatic replacement for scraping
`git rev-parse`. However, its current implementation lacks
category-based querying, relies on global state macros,
and is missing critical path data.
To fully realize Git's libification effort and improve
user experience, the internal architecture of
`builtin/repo.c` must be modernized.

=== 3.3 Proposed Solution and Objectives

Instead of just scraping basic paths, I propose an
architectural update to `repo info`, safely utilizing the
new `strbuf_add_path` API submitted by Lucas Oshiro.

*Objective 1: Category-Based Query Architecture (The Core API)* +
Currently, the `repo_info_fields` array relies on an
exact-match binary search (`bsearch`). Users must request
specific keys or use `--all`.
I will rewrite the lookup logic to support
category-prefix matching.
* *Implementation:* I will implement an internal mapping
  structure so that calling `git repo info path`
  successfully identifies the category root and iterates
  through all keys starting with `path.*`, returning them
  dynamically.

*Objective 2: Deep Libification (Removing Global State)* +
The `builtin/repo.c` file is already highly modernized,
but it opts into global state by declaring
`USE_THE_REPOSITORY_VARIABLE` at the top of the file.
* *Implementation:* I will remove this macro entirely.
  The primary blocker in this file is `get_layout_bare()`,
  which currently marks its local `repo` argument as
  `UNUSED` and falls back to the global
  `is_bare_repository()` helper.
  I will refactor this function to drop the `UNUSED` tag
  and explicitly evaluate the passed
  `struct repository *repo` pointer.
  I will thread this context down the call chain without
  breaking existing external callers.

*Objective 3: Core Path Resolution (`git rev-parse` parity)* +
With the category API built, I will populate the `path.*`
category by implementing the remaining path values currently
obtained through `git rev-parse` and `--git-path`.
Lucas Oshiro's recent patch series implemented `path.toplevel`;
https://lore.kernel.org/git/20260228224252.72788-1-lucasseikioshiro@gmail.com/T/#t
I will build upon this foundation to implement the rest.
Because path normalizations across different systems are
complex, I will leverage my experience from `dir.c` to safely implement:
* `path.git-dir`, `path.common-dir`, `path.worktree`.
* `path.objects`, `path.hooks`, `path.index`, and `path.grafts`.

*Objective 4: Sparse Topology & Boundary Awareness* +
Modern Git workflows rely heavily on partial checkouts
and submodules, and `repo info` should report these
complex states natively.
* *Implementation:* I will implement `layout.is-sparse`
  to expose if the repository uses a sparse-checkout
  cone, and `path.superproject-working-tree` to instantly
  query if the current repository is a submodule.

== 4. PROJECT TIMELINE

=== 4.1 Community Bonding Period (May 1 - May 24)

* Attend the Git community GSoC sessions to introduce
  myself and establish a communication schedule.
* Initiate the design discussion on the mailing list
  regarding the internal data structure for
  Category-Based Queries.
* Map out the exact C call chains affected by
  `USE_THE_REPOSITORY_VARIABLE` in `builtin/repo.c`.

=== 4.2 Phase 1: Category Architecture & Core Paths
(May 25 - July 5)

*Weeks 1 - 3 (May 25 - June 14):*
* Implement the category-based lookup mechanism in
  `builtin/repo.c`.
* Update the parsing logic so `git repo info <category>`
  successfully returns all nested keys.

*Weeks 4 - 6 (June 15 - July 5):*
* Utilize Lucas's `strbuf_add_path` API to implement the
  core path values.
* Implement path related keys.
  (`path.git-dir`, `path.common-dir`, `path.worktree`,
   `path.objects`, `path.hooks`, `path.index`, and `path.grafts`)
* Write rigorous OS-agnostic tests in `t/` to ensure path
  resolution works correctly across POSIX and Windows
  environments.

=== 4.3 Mid-Term Evaluation Phase (July 6 - July 10)

* Ensure the category architecture and core paths are
  merged into `master` or queued in `next`.
* Review progress with mentors and adjust the Phase 2
  timeline if necessary.
* Submit mid-term evaluation.

=== 4.4 Phase 2: Removing Global State & Sparse Topology
(July 11 - August 16)

*Weeks 7 - 9 (July 11 - July 26):*
* Focus entirely on libification.
* Remove the `USE_THE_REPOSITORY_VARIABLE` macro from
  `builtin/repo.c`.
* Refactor `get_layout_bare()` and similar functions to
  utilize the explicit `repo` parameter.

*Weeks 10 - 12 (July 27 - August 16):*
* Implement the advanced topology and boundary keys
  (`layout.is-sparse` and `path.superproject-working-tree`).
* Run the full test suite and perform rigorous edge-case
  testing ensuring libification does not cause
  regressions.
* Buffer period for addressing mailing list feedback
  regarding the libification and sparse patches.

=== 4.5 Finalization (August 17 - August 24)

* Finalize the official Git documentation
  (`Documentation/git-repo.txt`) for all new keys and
  category querying.
* Clean up the commit history and ensure all patches are
  finalized on the mailing list.
* Submit the final GSoC project report.

=== 4.6 Stretch Goals

If review cycles move faster than anticipated, I will
implement Split-Index Topology (`path.shared-index`)
to report the path to the shared index file. I will
also investigate natively parsing `git-sizer` metrics
into the newly established category API to provide
deeper repository health insights.

== 5. AVAILABILITY AND BLOGGING

This timeline aligns perfectly with my schedule.
The project kicks off in May, during which I will be on
summer vacation and can dedicate 35-50 hours a week.
During June and July, I will transition into my final
year of university.
My academic schedule during this period is highly
flexible.

*Blogging:* +
I have a domain setup at jayatheerth.com.
As patches flow and the project progresses, I will host a
dedicated endpoint at `/blogs` to provide comprehensive,
weekly coverage of my project.

== 6. POST GSOC COMMITMENT

I actively follow the mailing list and intend to continue
contributing bug fixes and enhancements.
I have been a part of the Git community since 2025 and
hopefully will continue to be one for a long time.

--- End of proposal ---

Regards
- Jayatheerth
