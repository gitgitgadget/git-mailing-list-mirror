Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793983460;
	b=yj7t1CfAMI8/WmjT7AfCXu1plffoFrnSmOUrvd9QK0KN7IOUAe4ZnEZ3gZ2RLQfqN/ag
	 db59O4O1gwt9qAuZDej5/Vv7kMyyLntGgEKSOY0Lgkr24FYM/my7vM47bQhYBlm9tMxC0
	 RAqAC1LiO9AkgCPB0jjVIUfHFSF2Hv5WVYTJFvRKAPvx7kahNQLM43sS/OWuSU/N+HB0r
	 XCcwRbUEHPZKfR5liQqD3w0maHYkJ1NO6bNEDsJtNyxA1fCxm0kcDMq0ZhPXiEYQLGJRQ
	 TLFu8sQuhFc+6RuIa32CRMBjoJ8eedCV6JyO4g8Fb2PuMTAnIBxL6DOxo+VP/NraQ4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=jXAwrfhHijCQm+Hg6Ikh9cxw76ShHWDwPE3P6NkazOM=;
	b=yfYbL9B3ESL3+iHv0ypcgog3/L5CEd/PFoFP/V0VV4UosOxqpQezbrII4gaWMXpRO7rR
	 jLNwTS3p7OEcTgxA8tW7w3K0fdBgRlAYNObRdolGcJ52tY+meq1sc2XEq1fymwwHfgbBh
	 dCusTqVWk8r4l6/sC1lcer9YEi+g+6m5WD5avB8fJA59rVYXwmGUZdlCZc7CUR6+9p0zk
	 JfOdVG6IDZuTBsV9DfXEMnsdCDO0I6N02ZGPIe4g+9Cy/u63kDreNVDa3DruTxnkBvScV
	 oIDOA7/I/8or/6smTHpzcEuPoGPlqYsRTXh+I0sTT3z6n2rMjoAYVFJaNRXiwqCBS3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zAX3fU8V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D34606A335
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 16:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18D34606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zAX3fU8V
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso8748186d6.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 08:44:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793983458; cv=none;
        d=google.com; s=arc-20260327;
        b=o9qcYzYPJfjrmc7m2x4TalKx9E/1tp3Gv2Hl8kvhwdS+XU3o13RN8Okmy3wyRCSC9X
         pF0UOx6fCz5nh8AG1Rna5Crcrj25uZvc8D1eoUYuuWjlAMO9QrWl5kIdBC7xs7LVhyqG
         hfTTUTAy55kuVASltUxb5uB1uZYQGqkH+MKok3biYNPpEQNG/FW/3OzlMTBD19lcWBnD
         25Szrs2GCIfNVKKJbtCCeFsVS3u7HHD50h6OGxgE3hJhGCf6SkRyDIEDMNApOpVQNb55
         wMptnWZDpTvEWaf6IRc3GcfdSqBsOd8K32+79YWNxVVRAOJTsEgzZhBYpPQk1e9ZrVZW
         4Fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jXAwrfhHijCQm+Hg6Ikh9cxw76ShHWDwPE3P6NkazOM=;
        fh=yOlUArnz53wajRpYGY4P1mFE97N8oXnD5/lIrgQGEdM=;
        b=r9MafqB7JjdTnL1Z80LUBEb/Gn9EMon0S3KIZGiiW+9P3J1lvM41EtUdiDCebkk3uM
         eTLYFnck3OlTOWzVcLRnlPR4a52KiFv/0MRLFYEEz4/VTX+Hu/H3KlnOcTYGGHhjlZW0
         hxwmy3qAaF07gxGwQr7ZMSrdvTdMWzMEfdIQJuOzf7xwxiGk6mFNUHJ9oQqdxEJyaEcm
         rWQ+Q8358cNlTeGEi9DSb5vh1Z4cTETPPYN1YrWUuLx1oHdVApqfKbcG5WsNddx20UBe
         /SmB+LkPFhvpUA9cLw26RYqqpIR2YRn2L54Bl5zVbzD8IqLGIVXKKVMelENRIrcLR79z
         fzrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793983458; x=1794588258; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jXAwrfhHijCQm+Hg6Ikh9cxw76ShHWDwPE3P6NkazOM=;
        b=zAX3fU8VoHTQQ/scZ+vsH2QkTvu44S/jnBBJ3Kr784VqrBPqCzh6/Ed9rlpG6PDX/l
         DnUoiFSYrloq1NdRvvh3pXyhCBXZZ3CozMuwyT3j2Fpp2BfzEWfked7T8PE9pfHro2Cj
         sh/g6jZexWk0CLnzoYgvXnnMTDPKkvBegzXhcsta0v1cKrPdmXf72olH0Upaed7OqeV1
         EkMP/fCL0f/DlJ+Hey9PmX9a/2/NQW36ISLFhNzVx4+/fAM16+P4DftI4sFL63E3iVSH
         7SF4KGXz9kzPJJVP9xGOodBxk3ZVPs9tvF6OHblz7JJeE84Fx++rcEuJT1jRnlLxQSmO
         g3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793983458; x=1794588258;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jXAwrfhHijCQm+Hg6Ikh9cxw76ShHWDwPE3P6NkazOM=;
        b=u19RJMzIF1nzdy9ywKOE0PpAQ6YwvZuQjuD4YLS6qnk/lT7C51iwz3yJ1cRhosAvbI
         JbEqohunYoHuOA2oiPM04jcBKbCK+UK8ITrOlNpnz/hBzq+svsXVdWBRZWxIf619r2XD
         ZyihIuxjyGB2zd5zpWoUn1lQjlSsnlF9wnwh41A+4JnX/KWBHUTONhrIhg4DnNBSfHmR
         v57hS0jde/lhkyBIFBBmSIC+0ipwsKTsuxmHRTT9XRbAiMuuG5Qfgxd21D/AkMuytdRG
         lic1PNzIQRiZUwvBQajaTspMZdFzbOdhVTVKhL/lIesCJICD13snd0BxVPw+PQ3h2BDK
         ifPA==
X-Gm-Message-State: APuU4Z+rqPuB9CW/HiTnqqY6sqDSYL9F7d70l5nJ5zsJDrHhOqbTmEYW
	FONCnmDJYPr9QpZbhHtHZJK4lk8ZZezOSH8M4HROMWmWNHDxYxJnd+39RzYm4AA6tXYZGWnspbj
	7Vz+YilMYbRmr2N9HdEztIqDQInD00tMX367KJds=
X-Gm-Gg: AYBFou1SkHOeqasA+0LfMDkGhnUg1lIS51p2UrXnJ8fmo4PHbGHIVyzKy5hBX2e94k/
	0oHydAuNx//ogj8TAl59k76sht+/vO1VniXgXjrE2ZVAzsk6EG8Gu8/dh+fGdz5Mjh32pMGNLNu
	h22beSDWM/C1cLBg7RQ6CMo3GZB6LusNj2e4J8Q8KNmUN5uGDhC63zyvYB6TgHtPv7/8KoFxL0q
	uP5XI/H46LlMiCy9N/1Z0Zca0xTlcyCSxpUSjRnaOLpBtKdc2fQhbRAHIoowdCmYcydrbW4q7L0
	ueSUKbUfT9jxYZHAgYol+FMGFy1VxvwvMwdbTSYBHRjpq+y9/e3h1uFYDVzRmUMX/JkF2GJiD75
	xbP30LGDav0ySNIQdiMcTnEaPMBS8MHoQHGPtNV+vqoxDFf1vNxXIb1UPNeUJwwy3LZ4yzbJ/so
	HEiJPqPVAdElh52NRuMWtRBtPq5UiAtaR2vZgGPaME0ZRXpIyYNKCX2I6RIOPqDAY6S65ZCk9a+
	4f1Xg==
X-Received: by 2002:a05:6214:8001:b0:91e:b670:f9f5 with SMTP id
 6a1803df08f44-91eb670fa2cmr13669026d6.3.1793983457675; Fri, 06 Nov 2026
 08:44:17 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Fri, 6 Nov 2026 22:14:06 +0530
X-Gm-Features: AclHuK_sjIzdTVgQObR9VnpH1MRcCRirk_04mgZFe1p-QbeYvV7K_Iea_CisbYk
Message-ID: <CABh_KWhErO+npX+etVTzyf-ercYjR=dM=tmhiBLbvQWM2FooEQ@mail.gmail.com>
Subject: [Outreachy][Proposal]: Reduce Git's global state to enable Git's libification
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, christian.couder@gmail.com, 
	kaartic.sivaraam@gmail.com, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I have prepared an updated and complete version of my Outreachy proposal.

I am sharing the full proposal below for your review. Could you please
let me know if there are any mistakes, missing details, or areas that
need improvement?

Your feedback will help me improve it before submitting my final application.

Thank you for your time and guidance.

---

# Outreachy December 2026 Proposal

## Project 3: Reduce Git's Global State to Enable Git's Libification

**Project Title:** Reducing Global State in Git's Pathspec Skip-Worktree
Matching

**Organization:** Git

**Mentors:** Christian Couder, Usman Akinyemi

## Project Summary: Reducing Global State in Git's Pathspec
Skip-Worktree Matching

My project focuses on reducing a hidden global dependency in Git's
pathspec skip-worktree matching. Currently, the helper function
`find_pathspecs_matching_skip_worktree()` gets index information through
the global variable `the_repository->index` instead of receiving that
information directly. The function checks which pathspecs match index
entries that are marked with skip-worktree or are outside the
sparse-checkout area. Because it depends on a global variable, its
required information is not clearly provided through its function
arguments. My goal is to investigate how this dependency can be reduced.
I will study how the helper and its wrapper function work, examine all
their callers, and understand how each caller gets its index
information. I will compare possible solutions and discuss the suitable
approach with Git maintainers before making changes. Once an approach is
agreed upon, I will update the necessary functions and callers, add or
update tests, build Git, and run relevant tests, especially those
related to sparse checkout, `git add`, and `git rm`. I will check that
the existing behaviour remains correct. This work aims to make the
code's dependencies clearer and potentially improve its testability,
reuse, and maintainability. It will contribute one focused improvement
to Git's larger effort to reduce global state and make its code easier
to use as a library. My work is limited to this specific area and its
related code; I am not aiming to remove all global state from Git or
redesign the entire pathspec system.

## Personal Information

-   **Email:** poojarysrujith@gmail.com
-   **GitHub:**poojarysrujith
-   **All PR Links:**https://github.com/gitgitgadget/git/pulls?q=is%3Apr+state%3Aopen+author%3Apoojarysrujith
-   **Location:**Karnataka,India
-   **Year of Study:**June 2026
-   **Time Zone:**GMT+5:30

## 1. About Me

I am a recent BCA (Bachelor of Computer Applications) graduate from
Karnataka, India, with a foundation in programming and some experience
in C. I have practical experience developing software projects and
contributing to open-source projects. I have also participated in
several coding competitions and have been strengthening my
problem-solving skills through Data Structures and Algorithms (DSA).
Currently, I am independently learning .NET Full Stack Development and
building projects to develop my technical skills and prepare for a
career in software development.

My journey into open source began while I was learning how to use Git
and GitHub for version control and managing changes in my projects. This
experience made me interested in exploring publicly available
open-source repositories. It also made me curious about how Git works
internally, how its source code is organised, and how Git developers
maintain such a large project.

### How I Learned About Outreachy and Chose the Project

While watching videos on YouTube, I came across the Outreachy website. I
applied for the initial application and was selected to continue in the
process. When I explored the listed projects, I chose **Reduce Git's
global state to enable Git's libification** because I was already
familiar with C, Git and GitHub. I then started learning more about the
project and exploring the Git codebase.

During my contribution period, I learned C concepts needed to understand
the codebase, such as pointers, structures and functions. I also
explored how different parts of the code communicate with one another. I
looked at Git code related to repositories, `struct repository *repo`,
global state and explicit dependencies. This taught me that contributing
to Git is not only about writing code. It is also important to
understand existing functionality, study previous changes and make sure
that code is tested properly.

I made contributions while preparing for this project. I worked on test
scripts and test-path checks, safe integer arithmetic in `diff-delta`,
and a submodule-related change involving repository-specific commit
abbreviations. I also prepared updated patch series for review and
communicated with the Git community through email, GitGitGadget and the
Git mailing list. These experiences helped me understand the
contribution process and gain experience collaborating with the
community.

I am interested in this Outreachy internship project for December 2026
because it will give me an opportunity to understand and contribute to
an important part of Git's internal design. I want to learn how implicit
dependencies on global state can be replaced by passing the required
repository or index information explicitly, and how this can help make
code easier to test, maintain and reuse.

## 2. Contributions to Git and Project Preparation

### 2.1 Contributions to Git

While preparing for this project, I made several contributions to Git:

-   **Avoid pipes in the `t0001-init.sh` test script**
    -   Description: Changed the test script to avoid using pipes in its
        commands.
    -   Pull request: [PR
        #2260](https://github.com/gitgitgadget/git/pull/2260)
    -   [Mailing-list
        discussion](https://lore.kernel.org/git/pull.2260.v2.git.1792666211685.gitgitgadget@gmail.com)
    -   Status: Integrated into `next`. A later mailing-list update
        indicated that it was expected to move to `master`. The PR
        remains open.
-   **Modernize test path checks in `t2030`**
    -   Description: Updated how the test script checks file paths.
    -   Pull request: [PR
        #2256](https://github.com/gitgitgadget/git/pull/2256)
    -   [Mailing-list
        discussion](https://lore.kernel.org/git/pull.2256.v3.git.1792299943380.gitgitgadget@gmail.com)
    -   Status: Included in `seen`. The PR remains open.
-   **Use safe integer arithmetic in `diff-delta`**
    -   Description: Improved integer arithmetic to avoid unsafe
        calculations.
    -   Pull request: [PR
        #2276](https://github.com/gitgitgadget/git/pull/2276)
    -   [Mailing-list
        discussion](https://lore.kernel.org/git/pull.2276.v9.git.1793120160248.gitgitgadget@gmail.com)
    -   Status: Included in `seen`. The PR remains open.
-   **Use the submodule repository for commit abbreviations**
    -   Description: Updated submodule commit abbreviation handling to
        use the submodule's own repository.
    -   Pull request: [PR
        #2288](https://github.com/gitgitgadget/git/pull/2288)
    -   [v6 mailing-list
        submission](https://lore.kernel.org/git/pull.2288.v6.git.1793821554097.gitgitgadget@gmail.com)
    -   Status: v6 was submitted on 4 November 2026. The PR remains
        open; it has not been confirmed as accepted or merged.

### What I Learned from My Contributions

Through this work, I became familiar with reading existing code,
understanding test failures, preparing patches, running tests and
responding to review feedback.

### 2.2 Learning C, Exploring Git's Source Code and Understanding Global State

Along with making contributions, I spent time learning the C programming
concepts needed to understand Git's source code, such as pointers,
structures, functions, function arguments, and how information is shared
between different parts of a program.

I explored different Git source files, including `repository.c`,
`repository.h`, `environment.c`, `alias.c`, `alias.h`, and
`builtin/help.c`. I focused on understanding how Git uses the global
pointer `the_repository` to access repository information and how
functions can receive repository information explicitly through
`struct repository *repo`.

I examined `alias_lookup()` in `alias.c` to understand how functions use
their arguments while also depending on global repository information. I
also investigated `is_bare_repository()` and commit `7ff3a5895b`, which
separated the initial `--bare` command-line option from the
repository-specific bare configuration. This helped me understand how
global state can hide a function's dependencies.

To understand how Git developers address these dependencies, I studied
previous refactoring changes. These included moving
`core.attributesFile` from the global variable `git_attributes_file`
into `repo_config_values`, and moving `core.hooksPath` from the global
variable `git_hooks_path` into `struct repo_settings`, along with the
introduction of `repo_settings_get_hooks_path()` to load and cache the
value for the relevant repository.

Through this exploration, I understood that global state refers to
information that different parts of a program can access without
receiving it directly as an argument. Although this can be convenient,
it can make a function's actual dependencies less obvious and harder to
reuse or test with a different repository or index.

I also learned about libification, which means making Git's internal
code easier for other programs to use as a software library rather than
relying only on Git's command-line programs. Reducing hidden
dependencies by explicitly passing the required information, such as
`struct repository *repo` or `struct index_state *istate`, is one part
of this effort.

Git developers have been working towards this goal by moving
repository-specific information into appropriate structures and updating
functions to receive their dependencies explicitly. My understanding of
these changes helped me see how reducing global state contributes to the
broader goal of libification.

This preparation helped me build the technical background needed to
investigate pathspec processing as a possible contribution area. It led
me to examine the relevant implementation, understand its dependencies,
and identify a specific opportunity for further investigation, which I
will explain in the next section.

## 3. Project Overview

### 3.1 Proposed Project: Reducing Global State in Pathspec
Skip-Worktree Matching

My project focuses on one part of Git's pathspec implementation.

A **pathspec** tells Git which files or paths a command should work
with. For example, it can select a particular file, directory or group
of files. Pathspecs are used by commands such as `git add`, `git rm`,
`git grep` and `git diff`.

While exploring Git's source code, I found that some pathspec-processing
functions use the global pointer `the_repository` to access repository
information. This means they get information from a global variable
instead of receiving everything they need through their function
arguments.

In `pathspec.c`, I identified the helper function
`find_pathspecs_matching_skip_worktree()`. It checks which pathspecs
match index entries marked with the skip-worktree flag or entries
located outside the sparse-checkout area.

Currently, this helper accesses the index through
`the_repository->index` instead of receiving the index directly as an
argument. This creates a hidden dependency on the global repository.

I also examined the inline wrapper `matches_skip_worktree()` in
`pathspec.h`. This wrapper calls the helper and caches the matching
results so they can be reused. Because of this caching behaviour,
changing only the helper may not be enough. The wrapper and its callers
also need to be examined.

I identified four call sites for `matches_skip_worktree()`:

-   One in `pathspec.c`.
-   Two in `builtin/add.c`.
-   One in `builtin/rm.c`.

Each caller needs to be checked to understand which index state it
should provide.

One important point is in `builtin/rm.c`. The `cmd_rm()` function
already receives a `struct repository *repo` argument, but it is marked
as `UNUSED`. I need to investigate this further to understand which
index should be used rather than assuming that the existing repository
argument is the correct one.

### 3.2 Possible Approaches

I have identified two approaches to investigate:

-   **Approach 1: Pass the index directly**
    -   Add a `struct index_state *istate` parameter to
        `find_pathspecs_matching_skip_worktree()`.
    -   Update the wrapper if needed.
    -   Update the callers to provide the correct index state.
-   **Approach 2: Extend the existing index-matching function**
    -   Investigate whether `find_pathspecs_matching_against_index()`
        can support this matching behaviour through an additional
        `ps_skip_worktree_action` option.
    -   Check the existing matching logic and whether it can support the
        required behaviour.

I have not decided which approach is better. I will study both, compare
the changes required and discuss the suitable approach with Git
maintainers before implementation.

### 3.3 Main Source Files and Tests

I will mainly work with the following files:

-   [`pathspec.c`](https://github.com/git/git/blob/master/pathspec.c)
    --- contains the helper function being investigated.
-   [`pathspec.h`](https://github.com/git/git/blob/master/pathspec.h)
    --- contains the wrapper function.
-   [`builtin/add.c`](https://github.com/git/git/blob/master/builtin/add.c)
    --- contains two identified call sites.
-   [`builtin/rm.c`](https://github.com/git/git/blob/master/builtin/rm.c)
    --- contains one identified call site.
-   [`t/t3705-add-sparse-checkout.sh`](https://github.com/git/git/blob/master/t/t3705-add-sparse-checkout.sh)
    --- tests sparse-checkout behaviour for `git add`.
-   [`t/t3602-rm-sparse-checkout.sh`](https://github.com/git/git/blob/master/t/t3602-rm-sparse-checkout.sh)
    --- tests sparse-checkout behaviour for `git rm`.

These files and tests will help me understand the current implementation
and check that the existing behaviour is preserved.

## 4. Technical Implementation Plan

I plan to complete the work in the following stages.

### Phase 1: Understand the Existing Code

-   Study `find_pathspecs_matching_skip_worktree()` in `pathspec.c`.
-   Understand how it checks pathspecs against skip-worktree index
    entries.
-   Study the `matches_skip_worktree()` wrapper and how it caches
    results.
-   Understand how the helper currently uses `the_repository->index`.
-   Trace all four callers and check which index state is available at
    each location.
-   Review the existing sparse-checkout tests and record the current
    behaviour.

### Phase 2: Compare Possible Approaches

-   Investigate passing `struct index_state *istate` directly to the
    helper.
-   Check how this would affect the wrapper and its callers.
-   Investigate extending `find_pathspecs_matching_against_index()` with
    another skip-worktree action.
-   Compare both approaches based on code clarity, existing Git patterns
    and the changes required.
-   Discuss the findings with Git maintainers before choosing an
    approach.

### Phase 3: Make the Agreed Changes

-   Update the helper or existing index-matching function based on the
    selected approach.
-   Update the wrapper if required.
-   Update the affected callers to provide the correct index state.
-   Pay particular attention to the index used by `cmd_rm()` in
    `builtin/rm.c`.
-   Review the changes to make sure the operation no longer depends on
    the global index for this matching task.

### Phase 4: Test the Changes

-   Run `t/t3705-add-sparse-checkout.sh`.
-   Run `t/t3602-rm-sparse-checkout.sh`.
-   Check whether additional regression tests are needed.
-   Investigate whether a test using different index states can verify
    that the helper uses the index supplied to it.
-   Check relevant pathspec and sparse-checkout behaviour.
-   Build Git and run the appropriate tests.

### Phase 5: Review and Improve

-   Review the complete changes for correctness and unnecessary
    modifications.
-   Address feedback from maintainers and reviewers.
-   Make further changes where needed.
-   Run the relevant tests again after changes.
-   Document the final implementation and test results.

If the main contribution is completed and time permits, I may
investigate related pathspec functions such as `init_pathspec_item()`
for similar dependencies. This will depend on the findings and
discussion with the Git community.

## 5. Thirteen-Week Internship Work Plan

I have divided the internship into thirteen weeks, from 7 December 2026
to 8 March 2027. I can dedicate 40 hours per week. The plan covers
understanding the existing code, discussing the approach,
implementation, testing, code review and final documentation. The
schedule may be adjusted depending on implementation complexity and
feedback from the Git community.

### Weeks 1 to 2: Code Understanding and Planning

-   Study `find_pathspecs_matching_skip_worktree()` and its inline
    wrapper.
-   Understand skip-worktree entries and sparse-checkout behaviour.
-   Trace all four callers and identify the available index state.
-   Review existing tests and current behaviour.
-   Compare the two possible API approaches.
-   Discuss the proposed approach with mentors and the Git community.
-   Consider an alternative contribution if the pathspec candidate is
    unsuitable.

**Expected outcome:** Understand the existing implementation and agree
on the contribution approach.

### Weeks 3 to 4: Implementation

-   Implement the agreed approach.
-   Update the helper or existing index-matching function as
    appropriate.
-   Update the inline wrapper if required.
-   Update affected callers to pass the correct index state.
-   Pay particular attention to `builtin/add.c` and `builtin/rm.c`.
-   Review the changes and run focused tests.

**Expected outcome:** Initial implementation with explicit index-state
handling.

### Week 5: Testing

-   Review existing sparse-checkout tests.
-   Run `t/t3705-add-sparse-checkout.sh` and
    `t/t3602-rm-sparse-checkout.sh`.
-   Identify additional regression tests if needed.
-   Check whether different index states are handled correctly.
-   Fix any issues found.

**Expected outcome:** Initial regression coverage and validation of
existing behaviour.

### Weeks 6 to 7: Code Review and Refinement

-   Submit the implementation through the Git contribution process.
-   Collect feedback from mentors and contributors.
-   Make changes based on review comments.
-   Review the helper, wrapper and callers.
-   Run relevant tests again.
-   Discuss any unresolved design questions.

**Expected outcome:** Refined implementation addressing review feedback.

### Weeks 8 to 10: Follow-up Investigation

-   Investigate related pathspec functions for similar global-state
    dependencies.
-   Consider `init_pathspec_item()` as a possible follow-up.
-   Evaluate whether additional changes are useful.
-   Discuss any scope expansion with mentors.
-   Continue testing and addressing feedback on the main contribution.

**Expected outcome:** Continue the main contribution and investigate
related opportunities where appropriate.

### Week 11: Final Testing and Documentation

-   Review the complete implementation and diff.
-   Run focused tests and broader tests where practical.
-   Check for unintended changes in pathspec and sparse-checkout
    behaviour.
-   Update comments or documentation if necessary.
-   Address remaining review feedback.

**Expected outcome:** Thoroughly reviewed and tested contribution.

### Weeks 12 to 13: Final Review and Summary

-   Complete remaining changes based on feedback.
-   Run relevant tests after final changes.
-   Review the final code and contribution history.
-   Document implementation decisions and testing performed.
-   Summarize completed work, challenges and possible follow-up
    improvements.

**Expected outcome:** Completed internship work summary with the
contribution's final review or integration status documented.

I will use this as a working schedule and adjust it based on
implementation complexity, test results and feedback from the Git
community. My main priority throughout the internship will be completing
and validating the pathspec contribution rather than expanding into
unrelated areas.

## 6. Expected Outcomes and Conclusion

### Expected Outcomes

Through this project, I aim to make a focused contribution to Git's
ongoing effort to reduce global state and make its internal code easier
to reuse.

The intended outcomes are:

-   A clear understanding of the existing
    `find_pathspecs_matching_skip_worktree()` helper, its wrapper and
    its callers.
-   A technically suitable change that makes the required index
    dependency explicit, if the investigation and review support this
    direction.
-   Updates to the wrapper and affected callers where required by the
    selected design.
-   Focused regression coverage, if the test infrastructure supports it,
    together with relevant existing pathspec and sparse-checkout tests.
-   A focused patch submitted for review, with its review status
    reported accurately. Acceptance or merging will depend on the Git
    maintainers.
-   A record of the implementation decisions, tests performed and any
    remaining limitations.

I also expect to improve my understanding of Git's internal
architecture, repository and index handling, and the process of
contributing changes to a large open-source project.

## 7. Blogging and Progress Reports

I will follow Outreachy's blogging and reporting requirements throughout
the internship. I will use my reports to describe the work completed,
technical challenges, feedback received, what I have learned and any
changes to the plan. I will also share progress updates with my mentors
at least every two weeks, including completed tasks, test results,
current blockers and next steps.

## 8. Availability and Work Planning

I can dedicate 40 hours per week to the Outreachy internship throughout
the 13-week period. I understand that the programme requires at least 30
hours per week for at least 12 of the 13 weeks, and I am prepared to
make the internship project my primary focus during this period.

I will divide my working time between understanding the existing code,
implementation, testing, communicating with mentors and responding to
review feedback. I will share progress and draft milestones with the
mentors and Git community regularly, at least every two weeks.

If I face a temporary interruption or a situation that affects my
availability, I will inform my mentor as early as possible and discuss
how to manage the work. My priority will be to maintain consistent
progress and complete the agreed contribution within the internship
period.

## 9. Acknowledgements

I sincerely thank my mentors, Usman Akinyemi and Christian Couder, and
the Git community for their guidance, feedback and support. I appreciate
the opportunity to learn, contribute and improve through this project.

Regards,
Srujith
