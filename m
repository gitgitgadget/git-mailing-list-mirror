Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE53081C2
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105694; cv=pass; b=fl7ZmrYVO6bXMXb1s+wwjkHXfbMRtvqMMMVgml4JcVLz2zvwOORx3k2b691a6R58T38rsMlNBFhUh5Z1Q674KEXgaGoH5sEkNMXif45owQEB4xf6azeEqOxwYu/ChhgREABjznbUKeMvWTseI45QP4gbPKIm9P+Zg2Ol6qtToR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105694; c=relaxed/simple;
	bh=OwakIC665zaeGiLcFnTSVmIlyyCXvPWk3f2FNZcWxnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9LssvxHFZ6O0S858yj9fzoFTudz8vtlFtBMx9gMwfI0IG+2kcOE/NFkdsVwfNmwD0ApZKpc4DcImL1OSustboFs5l1yIg571bEfSNczAy82HqsixZdJGMDIWeqwoQuwS37HE21Zs4NTy1OKaazXV24wapCAqi4Q+/AIL6Fd6NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkIgoE0V; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkIgoE0V"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb420f7500so68980285a.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 03:34:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772105692; cv=none;
        d=google.com; s=arc-20240605;
        b=OoLYHcdJMP90Xk0evm7j4964ldJIKOrBuRpVxNbjJxY9uecL0Qw/6lSpEL29U0eD08
         ZYREL98dIoYrHoXlHcQVGvjup+IUovNjpeOh7xjmdv1Y5jPqq2Gqd1sE+9gDBm/aXO6/
         juqzbeErNGW+NrGJjJkTzhnQI6UxIBsnfNqtkFxGkYxgjxkX2mlo6kNq5X/1+IXlYFRr
         xHPQgyJ8nZ7k7VObpGMMC5zWkR8waU0R+fNDFDZz11fejdvamoJA0XKpeVp74ziI0lvT
         jl6MPDtA14lYUEDGFgpMvnupiWPe5DYrV1tIBEY/Lzm/Hocs0Pxdjh5X9mEtUe1dpu++
         1KhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M36LtLVSjmxDXfxWVm+uJ4Q33UH7M1ixZuVUnq0gyZY=;
        fh=h645OTMYlFE8yjP1X4H3QS6aBDIsBfMm6sYHUUqmlmw=;
        b=SNCDfYsF8Q9t9v7TuNzdnVuuHB3LOUozsGlJbiNw7rpTxusLIDoCyDFbiNuCmB+5QU
         Z1kvBSuzQntmEJngkuvQEY0IjHVPygxGZwjvGNx5+kq7bYpWAp/rKDxUrqTzOU61WxHm
         9zOHWL9x20iOVV5sjUivmFVyHqAb/c0sxST6IwjFSww11WeYbmycBUkHU3UjdtLb30DA
         AuEWEBa3PmAL/hnIp8F53orQAxJLoXZTYO+1LvoIe2X2BkPBQjQ9optPPi1Nn8quzd/j
         Izh+lSw4lenm5sYYgzz1C2GH3a1ezOOI8mb7aXiq5pIn8jm+8Pd6oLuEX0UP8KANRe7J
         RLuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772105692; x=1772710492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M36LtLVSjmxDXfxWVm+uJ4Q33UH7M1ixZuVUnq0gyZY=;
        b=hkIgoE0VMc9hZVPYXSDoWpPXrb8if8ng/ghqmk03HFuhMIeFZ3ffpQHeY6FT8itXj3
         bP7eP4ipXddkQTgieF/+uHYXBUHHKFra1FNn3iKzK58Za8vp5f3Xrbxlknr5jiSR/lOa
         Dn/KjbktczFVaJ32JA+yyXg6kqNRqGdLx+FQSUp3kvw11oeUoH7L8T5T2eaL5nufmPU6
         uyJhRjeP2hh+W8dniALA5izrUT6VaTPhe90Jbvj0Hq6i3Nb0Q50l8CZUmrbt6OeBFyUF
         jVps/74uFiLuDCCJyr51ugkus29E+hK1mmKF614e3BlW/4rSp8kEmefsOpg/4UxluM36
         7H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772105692; x=1772710492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M36LtLVSjmxDXfxWVm+uJ4Q33UH7M1ixZuVUnq0gyZY=;
        b=FL46Qdv/PGsuJF+l6ZD1TtmbmRiNjX70hmmfks//hrzuhgCkZDgnmQhxJgan3QZHBY
         CwXtwAgGIwsrWmVPC7TDdz0hlMZhYCQmxxmPj9hohSVfChIzVRwTZnP6N3+NsfIWvoZR
         wwEH0cGsu7tUtQaSvvD5OkHlmODMj38PWU9KtPW1NgjKaNRc2uz2010sX2Nwz6/MTkAU
         CmbtTaITsnywFM8AgfAr+WzOm0PVi9Gtm881My88HJIo9+lTBj2voORYrwOtK3H9d8pu
         SBE866IDwecMLGmzW39Q0IcyuyfSHe0sb5q8JCRFf6HCc2x/hzG0bltXUS4lGAC2Vxuz
         /4pw==
X-Gm-Message-State: AOJu0YzopCHwrv5N+XMPEy9NE4fQv7lwdiS3W6qLociLrGTrGRZfOFZb
	YM4lOV04ohqhEEC0+sbJJt1gA9C0eLgubzpGdJin3TxDrmawhAs4Ph574SS8fIB6P/lepXBd+nA
	0bluDNcPm5xVYBb7Aw+CPzmMJ6KoLQFY=
X-Gm-Gg: ATEYQzzDbcUvFH2ASQCKt0qGwwcs1aIangjKlJK4ZCUH8ju0J+ivAg1t5KSmNozkp4H
	wmzWy2H+AstE7Qtmrqi9sJy3Z4Vwx1Hr1P8qNzguuEsQzRazOpXJntVcw6wJVm9MR2ibn5AnBSm
	ZzbrTaXaBQR0jG9axnWtA2o/TPCYfBQVxgpn8lfW3rRyeA+BSO9Pl2e6Y1ng8C2IOMjBEh6ztFi
	4CJr0KAOGsiwD6nZy4SvH1krKpWbqMOVYuuCm81NkAayNgtKtcK5dbU2HzRFnvNfsg0gB0RQ4gZ
	xM83DFWDKh6MQZMkSUHpiu1JmLb6X4fmYpa7p9FfFdajTJzjb3cccaQacRgAZ/7zWQXX3nuvJ9z
	oISFhGn7YcF7WLrv8IozcDunlTg==
X-Received: by 2002:a05:622a:4ca:b0:4eb:9eaf:ab4d with SMTP id
 d75a77b69052e-50741fc50f3mr49633221cf.62.1772105692140; Thu, 26 Feb 2026
 03:34:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLdSR=NPoD7XEbYPoRTt0VS5M0QhzHcy-OmyuZMMVN-H5w@mail.gmail.com>
 <3C0852FD-59FE-496D-9521-E123181901B3@gmail.com>
In-Reply-To: <3C0852FD-59FE-496D-9521-E123181901B3@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Thu, 26 Feb 2026 17:04:40 +0530
X-Gm-Features: AaiRm52Odiu49M3-aGYPkxEUlQHkuaRL2xmxh6WtULj3R67aR_TIDO-StplFn4E
Message-ID: <CA+rGoLcQUFPCZJt9Ph_1yQW_3zWg0Zuo9BSysF5mh-6Q7m2-mw@mail.gmail.com>
Subject: Re: [GSoC proposal v2][RFC] Improve the new git repo command
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, karthik nayak <karthik.188@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Since the last feedback from Lucas
I have taken some time to improve my proposal

- I have added all my patches that I raised in Git.
- I have also taken up a much more realistic timeline.

---

Improve the new git repo command
Jayatheerth Kulkarni
February 26, 2026

---

1. About Me
I am a junior at Geethanjali College of Engineering and Technology
pursuing a bachelor's degree, with a strong interest in open-source
projects and systems programming. My interest in the Git project
stems from a desire to understand the internals of version control
and contribute to a tool that is fundamental to the global software
development ecosystem.

1.1 Contact:
- Email: jayatheerthkulkarni2005@gmail.com
- Website: https://jayatheerth.com/
- GitHub: https://github.com/jayatheerthkulkarni
- LinkedIn: https://www.linkedin.com/in/jayatheerth/

1.2 Logistics:
- Timezone: Indian Standard Time (IST) / UTC+05:30
- Tech Stack: C, Shell Scripting, Rust

---

2. Contribution History

I have formally completed all the prerequisites to apply in
GSoC `Improve the new git repo command` project.

I have listed all of my work I have done in the past few months.

2.1 Featured Contributions
For many months, I have been actively engaging with the Git community
through mailing list discussions and patch submissions. Notably, my
work on fixing stash messaging behavior in submodule environments was
featured in Git Rev-News edition 124.

- [PATCH v3] stash: fix incorrect branch name in stash message
  Link: https://lore.kernel.org/git/20250611014204.24994-1-jayatheerthkulkarni2005@gmail.com/T/#u
  Status: Merged into master & featured in Git Rev-News.

2.2 Core Path and Submodule Patches

- [PATCH v8] submodule: prevent overwriting .gitmodules entry on path reuse
  Link: https://lore.kernel.org/git/20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com/T/#u
  Status: Merged into master.

- [PATCH v2] dir: Fix and test wildcard pathspec handling
  Link: https://lore.kernel.org/git/20250422160547.577524-1-jayatheerthkulkarni2005@gmail.com/
  Status: Merged into master.

2.3 Refactoring and Micro-Projects
I am deeply familiar with Git's test suite and standard C conventions,
having submitted several refactoring and cleanup patches, including
two specific to the `builtin/repo.c` file:

- [PATCH GSoC] repo: Remove unnecessary variable shadow
  Link: https://lore.kernel.org/git/aZxyju3B4NHp4c_t@denethor/T/#t
  Status: Got a review from Justin.

- [GSoC] t7101: modernize test path checks
  Link: https://lore.kernel.org/git/CALE2CrS0Q2NS1DbFv4pyRQsuypu=KH6Kurs=m4yWrFbR9QosoA@mail.gmail.com/T/#t
  Status: Merged into master (Official micro-project).

- [PATCH v2] pull: move options[] array into function scope
  Link: https://lore.kernel.org/git/20251212074433.38027-1-jayatheerthkulkarni2005@gmail.com/T/#u
  Status: Merged to master.

2.4 Documentation
I have also contributed to updating community guidelines:
- [PATCH v3] Update MyFirstContribution.adoc to follow modern practices
  Link: https://lore.kernel.org/git/CA+rGoLfFVcUFctoEx6wshovGnRW8pTW--ZB42ntd01VHMJm_Rw@mail.gmail.com/T/#t

2.5 Experience with C
Since Git is mainly written in C, I have no issues navigating the
codebase. I hold a Cisco CLP - Advanced C Programming certificate
covering Unix and C systems programming, and I have completed two
full university semesters of C programming.

---

3. Project Proposal

3.1 Why "Improve the new git repo command"?
This project is compelling because I have closely followed its
development since its inception. Consistently reading the weekly
updates (https://lucasoshiro.github.io/gsoc-en/) and following the
mailing list patches for `git repo info` has deepened my ongoing
interest in this specific initiative since GSoC 2025.

3.2 Introduction
Taken from the SoC 2026 ideas page, the new `repo info` command
has already started to be a good replacement for parts of `rev-parse`.
As this command is still in its early stages, there is significant
opportunity to refine its architecture and expand its feature set.
Currently, many core functions in Git implicitly read environment
variables and store them as global states. To support Git's ongoing
"libification" effort, these global dependencies must be removed.

3.3 Proposed Solution and Objectives
To ensure realistic pacing and to respect the rigorous nature of Git's
mailing list review cycle, I have scoped the primary objectives of this
project down to the two most critical milestones:

Objective 1: Adding Path Values
I will integrate the missing path values currently obtained through
`git rev-parse` and `--git-path`. This includes:
- `git-dir`, `common-dir`, `toplevel`, and `superproject-working-tree`.
- The grafts file, index file, objects directory, hooks directory, and
  `git-prefix`.
Implementation: I will take over the initial design efforts on the
mailing list, and finish the leftover work.

Objective 2: Removing Global State
The `builtin/repo.c` file currently opts into using global state by
declaring `#define USE_THE_REPOSITORY_VARIABLE`.
Implementation: I will remove this macro entirely. Functions that
currently implicitly rely on global state (e.g., `get_layout_bare()`,
which currently marks its `repo` argument as `UNUSED`) will be
refactored. I will update these functions to evaluate the explicit
`struct repository *repo` pointer, threading this context down the
call chain without breaking existing external callers.

---

4. Project Timeline

4.1 Community Bonding Period (May 1 - May 24)
- Attend the Git community GSoC sessions to introduce myself, the
  project, and establish a communication schedule with my mentors.
- Initiate the design discussion on the mailing list regarding the
  output format for path-related values (absolute vs. relative paths).
- Dive into existing efforts to map out exactly how resolves its current
  path outputs.

4.2 Phase 1: Core Path Implementation (May 25 - July 5)
Weeks 1 - 3 (May 25 - June 14): Foundation and Extended Path Values
- Implement the core path values (`git-dir`, `common-dir`, `toplevel`,
  and `superproject-working-tree`).
- Implement the remaining `--git-path` values.
- Write initial tests in `t/` to ensure path resolution works correctly.

Weeks 4 - 6 (June 15 - July 5): Review and Refinement
- Address mailing list feedback for the path values patch series.
- Begin mapping out the call chains affected by
  `USE_THE_REPOSITORY_VARIABLE` in preparation for Phase 2.

4.3 Mid-Term Evaluation Phase (July 6 - July 10)
- Ensure the path-related additions are merged into master or queued
  in the next.
- Review progress with mentors and adjust the Phase 2 timeline if
  necessary. Submit mid-term evaluation.

4.4 Phase 2: Removing Global State (July 11 - August 16)
Weeks 7 - 9 (July 11 - July 26): Threading the Context
- Focus entirely on libification. Remove the global state macro from
  `builtin/repo.c`.
- Refactor functions like `get_layout_bare()` to utilize the explicit
  `repo` parameter.
- Carefully audit and update external callers to use the new API context.

Weeks 10 - 12 (July 27 - August 16): Rigorous Testing and Iteration
- This period acts as a realistic buffer for the anticipated multiple
  versions required to get complex architectural refactoring merged.
- Run the full test suite and perform rigorous edge-case testing
  (e.g., sparse checkouts, nested submodules).

4.5 Finalization (August 17 - August 24)
- Finalize the official Git documentation for all new additions.
- Clean up the commit history, ensure all patches are finalized on
  the mailing list, and submit the final GSoC project report.

4.6 Stretch Goals
Given the rigorous nature of Git's patch review process, my primary
commitment is to successfully merge the core path additions and the
global state removal. However, if review cycles move faster than
anticipated, I have prepared the following stretch goals:
1. Category-Based Queries: Implementing an internal mapping structure
   so users can query by category (e.g., `git repo info paths`).
2. `repo structure` Enhancements: Analyzing the `git-sizer` codebase
   to integrate native repository metrics into `cmd_repo_structure()`.

---

5. Availability and Blogging
This timeline aligns perfectly with my schedule. The project kicks
off in May, during which I will be on summer vacation and can
dedicate full-time hours. During June and July, I will transition
into my final year of university. My academic schedule during this
period is highly flexible.

Blogging:
I have a domain setup at "jayatheerth.com". As patches flow and the
project progresses, I will host a dedicated endpoint at "/blogs" to
provide comprehensive, weekly coverage of my project.

---

6. Post GSoC Commitment
I actively follow the mailing list and intend to continue
contributing bug fixes and enhancements. I have been a part of the
Git community since 2025 and hopefully will continue to be one for
a long time.


--- End of proposal ---


Regards
- Jayatheerth
