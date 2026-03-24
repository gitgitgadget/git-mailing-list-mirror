Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECD73463
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774328413; cv=none; b=fz30VAnfYoKcxu4TuUPLjZTbkQtEpEAp701sJK8floQdWH8JVu2QyHqB7ECJBP2Y5pAoqmWkwOC8EFhdJiMs7cfUSTbZKX+0DYhfJ69GDIfC8W80YWPUaH+bIk55dn3OJ1HbD18VRyt7Eh9XF1+DIQp1VPQj9pDpvgk+zlz0ijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774328413; c=relaxed/simple;
	bh=N5KIh6bodDneUuj5nOh0eRUTMvxp84BdvUeL4ZiY72Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VqxcRmaytGTUFbQj4V9ZsmYdKpJLTY/FWA+cMIjy+76k/mzHBWEr+E0SMTddAQly1lZvJ978b2WRSfX93Q30kUJRz4tTvSC/IfGtMY0GlAUYijCpG51zqhSk+LpHrVfsvF+lJxuay8XOB1pJx7Avhbzr8CS5F15d4pRaCluTKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcUI8hW1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcUI8hW1"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aea8c13d94so11096285ad.3
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 22:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774328411; x=1774933211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCdwfad5/tq4Oev6zQNIaKrNeapsHeR0d7HGKSFyY1I=;
        b=WcUI8hW1BmeP+umvqaQ4sha3nBCr1kvyOvipO7ul/qP9I8iuNymBNv6FoxZ+ID4mim
         PfBxFdEf+LAZ5/3xVgaVa/4UzAc3D+xDSAKVWM0s4boIzERstadUliAWJ0fsaaBlzzZS
         RmQVGnWDLIAynGgHNiViysBqu5H1iLgmN67v3nrsosAyrg6326Ya4T0SZRgMrZ5E16Q0
         /ICthZ3nKc18FduQybm4I2RTwaB80NQCcxxfpKWAFcPvX9OrNFbGBMrDcKXoVaUJf2se
         qvWcCsOhSuyMUEkEFKxqri3O1SC6XxreZZzC3XWJ3lQnaA5YhTumKOpovrMVSdndlhhI
         Vtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774328411; x=1774933211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCdwfad5/tq4Oev6zQNIaKrNeapsHeR0d7HGKSFyY1I=;
        b=CaGBSANZZBrzp6rmWU3Fig1eYHK6pw4KaMdedD/GcJtxG3rwkWzF1ks/a8pbTHAqIV
         TGIAhBS8jMyQd9/oUEBieXtKXv1d32H0pR/b7zhei8ErPFifh6ajrMNkeaDbH8kLyHSw
         TVwtEHchI1KZlHOoKEQdeECg1tQ8N0sI/yna4vy1+IQ0KJ6MfKiTN/hLIc4b5o7sYA9i
         Qd1rlu/4jonxUiCNxjMQzBLfis1H5hQOYZwuXjzd2A4WqDNp2boMJhHAtuCoRptKYByy
         aLPQ7GFSHcpuSPVKwc1srxig6GLORkdoU3Q975ce60Ml3x7fa1OF9tF7PxUroR+kbfPz
         U3ZA==
X-Gm-Message-State: AOJu0YxrmPGBqvcvcAhijw5uGuEOxibJ/2iXeWA739AqDIxXXRyhw2F6
	JUEwuUvYLEeUK3i4p8Flemfx8QMdeX8XfknPbpVyiaCcSck0bCgT1vV3k/aN0xBm
X-Gm-Gg: ATEYQzzxWLKdNbPPzAfOus7wzWMi48jgeXhL7wrY916a/dIQ7i69nvfSWc+H1/vsogd
	mLlsefZ7t7G4CgLWMHYgtDlLnUUPW/f1SL89/nkaHuyJyD73DhaL6Iphbj3u1KTo1ZVDHZGRgHH
	D9IjiU8YyUeFWYaE9ONlO+3b34qsvadxBpWMaWVlpDuioMVaiog0xUtMQo4f+eoaD+1y+CloERR
	vCaKKkmbQcHgpPvTWlVAXXi5AmI3Bd6O9YzRx+/4ff0CEUc4XDoO7ywfXH0EFI+bYbsPHIDJfTM
	Gw+6tb0Ig/raYIw/pfuBkhNHAkYtBs6IqFvhthyewh1NEhwvFMd9Mr/vOxczjPfxEAF4UQB1uAC
	Rd6ovyr4z7pyH8HEHxlj2dXwke9Wy1a7e9ptAFNiY2Z0nDHgtutY5AC3WqWM32B5r8G9jJnrLxR
	BvdA+2GkqYulXAIzv8eR0cFuF86Y0HKXXnPcOUNTnMzEzID/djo0dAw7zWdy8kMq+URXDR6Mtp2
	cmzMiBG0g==
X-Received: by 2002:a17:903:1a45:b0:2b0:49c4:a9f5 with SMTP id d9443c01a7336-2b082795549mr84277805ad.3.1774328410869;
        Mon, 23 Mar 2026 22:00:10 -0700 (PDT)
Received: from localhost.localdomain ([14.195.131.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516877sm159015525ad.12.2026.03.23.22.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:00:10 -0700 (PDT)
From: jayesh0104 <jayeshdaga99@gmail.com>
To: git@vger.kernel.org
Cc: gitgitgadget@gmail.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com
Subject: [GSoC][PROPOSAL] Improve the new git repo command
Date: Tue, 24 Mar 2026 04:58:43 +0000
Message-ID: <20260324045904.44384-1-jayeshdaga99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

I am Jayesh Daga, a third-year Computer Science undergraduate at VIT Chennai.
I would like to submit my proposal for the GSoC 2026 project: "Improve the new git repo command".
I would greatly appreciate feedback from the community and mentors.

---

== 1. Personal Information

Name: Jayesh Daga
Email: jayeshdaga99@gmail.com
GitHub: https://github.com/jayesh0104
University: Vellore Institute of Technology, India
Timezone: IST (UTC+5:30)
Availability: 35–40 hours/week (May–August 2026)

---

== 2. About Me

I am a systems-oriented developer with a strong interest in developer tools,
version control systems, and backend infrastructure.

I have experience in C, C++, Python, and JavaScript, and have worked on:
- real-time telemetry systems
- CI/CD pipelines
- backend services

I enjoy working close to system internals, where small design decisions
can significantly impact usability and performance.

---

== 3. Contributions to Git

I have actively contributed to the Git project, particularly in improving
test consistency and aligning with Git’s internal testing framework.

- Replaced raw file checks with `test_path_is_missing` to align with
  Git’s testing conventions
- Fixed incorrect helper usage that could lead to test failures

One of my patches has been integrated into the `next` branch of Git,
indicating that it has passed initial review and integration stages.

I have participated in the full upstream contribution workflow:
- Sending patches via git-send-email
- Engaging in mailing list discussions
- Responding to maintainer feedback
- Submitting revised versions (v2, v3)

For example, after feedback from a Git contributor, I identified a mismatch
between the commit message and the actual code change and submitted a
corrected v3 patch.

Through this process, I gained a strong understanding of:
- Git’s test framework and helper utilities
- The importance of precise commit messages
- Incremental patch-based development and review cycles

---

== 4. Project Overview

The `git repo` command is a recent addition intended to provide a
structured interface for querying repository metadata and structure.

However, it currently:
- lacks coverage for many commonly used values
- has limited structure in output
- does not yet serve as a unified abstraction over existing commands

This project aims to evolve `git repo` into a complete, consistent,
and script-friendly interface for repository introspection.

---

== 5. Problem Statement

Currently, repository metadata is fragmented across multiple commands:

- `git rev-parse` → paths and repository state
- `git config` → configuration
- external tools like git-sizer → repository metrics

This results in:
- fragmentation (multiple commands required)
- inconsistent output formats
- lack of a unified abstraction

The `git repo` command is intended to address this, but remains incomplete.

---

== 6. Technical Proposal

The implementation will primarily involve extending logic in
`builtin/repo.c`, reusing existing helpers used by commands like
`rev-parse`, and ensuring consistency with Git’s internal APIs.

### 6.1 Path Metadata Expansion

Add support for:

Core paths:
- paths.git_dir
- paths.common_dir
- paths.toplevel
- paths.superproject_working_tree

Git-path equivalents:
- paths.objects
- paths.index
- paths.hooks
- paths.grafts
- paths.prefix

Design:
- Default to relative paths (portable)
- Optional `--absolute` flag

Final decisions will be made through mailing list discussion.

---

### 6.2 Structured Output

Current output is flat key-value.

Proposed:

{
  "paths": { ... },
  "layout": { ... }
}

Benefits:
- easier machine parsing
- better extensibility
- clearer organization

Backward compatibility will be preserved.

---

### 6.3 Remove Global State

Replace usage of global `the_repository` with explicit:

    struct repository *repo

Benefits:
- improved modularity
- better testability
- future extensibility

---

### 6.4 Extend `git repo structure`

Add metrics inspired by git-sizer:
- object counts
- largest blobs
- tree depth

Ensure:
- incremental additions
- performance safety

---

### 6.5 Testing and Documentation

Testing:
- extend tests in `t/`
- cover edge cases (bare repos, worktrees, submodules)

Documentation:
- update `git-repo.txt`
- include examples and usage patterns

---

== 7. Timeline

Community Bonding:
- study relevant code (`builtin/repo.c`, `repository.c`, `setup.c`)
- initiate mailing list discussions (paths, structure)
- submit small patch

Weeks 1–2:
- implement core path metadata
- testing and review

Weeks 3–4:
- implement git-path equivalents
- ensure parity with rev-parse

Weeks 5–6:
- refactor global state usage
- submit incremental patches

Weeks 7–8:
- structured output implementation
- RFC discussion and iteration

Weeks 9–10:
- extend repo structure metrics
- validate performance

Weeks 11–12:
- polishing, documentation, final review

---

== 8. Risks and Mitigation

Design disagreements:
- addressed via early RFC discussions

Performance concerns:
- benchmark before merging
- optional flags for expensive operations

Review delays:
- mitigated through small, incremental patches

---

== 9. Why Me

I have already contributed to Git and worked through its mailing list
development workflow.

Having a patch integrated into the `next` branch and iterating through
v2 and v3 revisions has given me practical experience with Git’s
expectations around correctness, clarity, and incremental changes.

My background in systems programming allows me to reason about API design,
performance trade-offs, and maintainability—key aspects of this project.

---

== 10. Future Work

I intend to continue contributing to Git beyond GSoC, particularly in:
- stabilizing `git repo` as a porcelain command
- improving developer-facing tooling

---

Thank you for your time and consideration. I would greatly appreciate
any feedback on this proposal.

Thanks,
Jayesh Daga
