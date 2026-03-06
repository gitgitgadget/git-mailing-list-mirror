Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4FF34D391
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810221; cv=none; b=MWhYphoLVtE0BMg75nQJ553hk/qS/rgaRpOC3bsKSuliDUZxt1DsFcUCdKbjvRhhS63JZcxYGPxslgv8bVicIFfOR0f7oYIMEuN4QI5YHUQ93g0v7DnO22zkMDNWXKERjcTxLWzOnXWRxn+WVjpGiWEOOtTQ6fuxkTjXLxq7yNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810221; c=relaxed/simple;
	bh=+aooBVOy8AKGgM/HywkDxy3qjOgtoeIZtXcQhrcr3b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LE3DkpJMbJWmdAwPkecQAsESC+DvrTenRLPWdlzhayODys8BMo+XCw86y0yUeJrhyvAmqqbgaNea4ijQx8qy/Xt7G7xwPyNWWs3p6TzY2ir4cxaJie/szf3au5qHDoNPR5wnRnrhZn0UPLrw0jSLwKOkf2Cu+V0gJhcXztxhr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOovMVjV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOovMVjV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae41544dcfso70744345ad.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 07:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772810219; x=1773415019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+62uUPwXW5Y80xElBWkExBGvR+I2Pd4/lU5i6FconJA=;
        b=kOovMVjVk8A5aM4C2J2nQq3RN3IhC4aoreNMmHSi2g2gNOo7MYcDypmRPag6cXDZkE
         zi6mqCJwL4+mCyhbqKDNVK48bpc5ob7HH5FSFQoUkH4rjRMat/OHCoZTiKHN912EX5d/
         9G47JP3YKzyfvoc2mhVR4uiQSNbOlltjFWpVde0Lhv2jQinzoyoSbqOsCCNaqkc81Hpu
         Rk8jUdfEQhX3erXoDmo/a/jOFqIZ0rVoWCU6DDAZmchCYUIA718q1f/8k+tzksIakrEm
         gTWhzgWzdnvHekDGf3aamphglgY016/ikNML1426ymNxLdIm6PbOtFpmoiSLljB0SSHH
         Uk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772810219; x=1773415019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+62uUPwXW5Y80xElBWkExBGvR+I2Pd4/lU5i6FconJA=;
        b=C1n7qdLAZR8QtbfT6hkxVUvZwrbSUjU4/FvrNIVjNbi8qURRBOeNWPNLQORf26oBDp
         k530P9S0EjMc3GZ/COHYu/kxY/UXGQjbv2Pn+EcRGt27H5+7QPWhqDuvyAuYI6QVFgLK
         LdaRip5b0uAAV7oxPHdioea7R5kS/lQj/McdcJJRRB3YQf1fxS2tnu3JpzLdZGOCyDCb
         LCy10d4vSXfMb4WbabIH+mBvgJEAbwdqCUj60XobeEph69hS+9TwDxokzQT7JFPuayDv
         5m+9JzuzI5oxPfqfQ+aLe+Ld8qFZQw/7zmdAjmAZAY1ky97qibfVa+quD/M/m1+uWmty
         myVw==
X-Gm-Message-State: AOJu0YwI4qtu2cbBjEGHo8LIApca8WXkABx54bTWqlkh2Rc7ckVGC4Sj
	yqkdlB/iI1rnRSGwjmtRIRkEN0M8zMh8I0rGE+Re0TbLnuOHi5t749dnj9CXMw==
X-Gm-Gg: ATEYQzxBpMyfB2YFO+6uasVSWDnV31CWnnXVXCyLw1mvBbiHS297qqJI60LwkktneVB
	4h3fN4P0Q64ggjcpLDRwX5LOmXXurqI79WTCRl8zXvW1x9I/YfUMMO9BWkjPtzisR5bTP+6K2U2
	P5q06MUQ0bzVdagXMIsJV8cgHB6pK+fy2mY8Cc25LSD1fgu7c0fkF/UUf6F0fzrDpp2npfswNWZ
	0XzcmumoNLJ5xYFjDXPBwvJbae1bvvAZ+GHCmEz9mBxqrNzv03RAvcluC45I3VeFwPV+YGA7lIy
	0AkJU5qJuQgLSVkDQVwch/h+Rm0GZSFRRanDRwSgsDLPHNukqWFOh+PkF6RPbuGSQZT8gwt6g1D
	P/JGPkOnDDq8vq8wFE6AY8X9h6/AcHuNiYSQSUPnjvsn0O1stItJbHOBFbTI0RQhuj3lZl1l6Ev
	hBk0XM2yUxw1Scnh8L1NvPzyDnLn+VSnltkrLEsijDVg==
X-Received: by 2002:a17:902:d48b:b0:2ae:5b64:12e6 with SMTP id d9443c01a7336-2ae82448f5amr27911825ad.38.1772810218178;
        Fri, 06 Mar 2026 07:16:58 -0800 (PST)
Received: from Shreyansh-PC ([2401:4900:88eb:2b10:225:d760:8e0b:13ca])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8cfb0sm32133395ad.67.2026.03.06.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 07:16:57 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com
Subject: =?UTF-8?q?=5BGSOC=5D=5BPROPOSAL=5D=3A=20Refactoring=20in=20order=20to=20reduce=20Git=E2=80=99s=20global=20state?=
Date: Fri,  6 Mar 2026 20:27:33 +0530
Message-ID: <20260306151605.29330-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello all,

This is my first draft of GSoC 2026 proposal for the project
'Refactoring in order to reduce Git’s global state'.

Doc version can be read at:
https://docs.google.com/document/d/16MRNUv6dJi6vtNvI5Ro0WmHf20dRRBHjFLpmhAuaUOA/edit?usp=sharing

Any feedback or suggestions would be greatly appreciated.

Thanks for reading.
---

Refactoring in order to reduce Git's global state

Personal Information:
---------------------

Name: Shreyansh Paliwal
Email: Shreyanshpaliwalcmsmn@gmail.com
Alternate Email: Shreyansh.01014803123@it.mait.ac.in
Mobile No.: +91-9335120023

Education: GGSIPU, New Delhi, India
Year: III / IV
Degree: Bachelor of Technology in Information Technology

Github: https://github.com/shreyp135
Time-zone: UTC +5:30 (IST)

About Me:
---------

I am Shreyansh Paliwal, a pre-final year undergraduate student at Guru
Gobind Singh Indraprastha University, New Delhi, India. I am a technology
enthusiast, who began programming in 2018 with Java as my first language
and later transitioned to C/C++ in 2023 as my primary focus. I enjoy
exploring new technologies and programming languages, and I have developed
solid experience building applications using TypeScript, React.js, Node.js,
and AWS. I actively participate in technical events and have organized
multiple hackathons, tech-fests, and related activities at my college as
the SIG-Head of IOSD, a tech-focused student community.

I started using Git in 2023, which is also when I made my first open-source
contribution to the Git project. I was a winner of Augtoberfest 2024, an
open-source competition organized by C4GT India. Over the past several
months, I have been involved with the Git project, studying the codebase,
submitting patches, and incorporating review feedback. I am motivated to
improve the experience of Git for end users, and this project is an
excellent opportunity to continue that work.

Overview:
---------

Git relies heavily on global state for managing environment variables and
configuration data. In particular, many parts of the codebase depend on the
global struct repository instance, the_repository, which represents the
currently active repository. Instead of passing a repository instance
explicitly, several internal functions implicitly rely on this global
object. Additionally, various configuration derived values and
environment-related variables such as the_hash_algo, default_abbrev, and
comment_line_str are stored globally, most of them defined in
environment.c.

This design assumes that only one repository is active within a process at
a time. As a result, the repository state becomes shared across the entire
process, weakening isolation and making behavior implicitly dependent on
global context. Such global dependencies make the code harder to reason
about, test, and maintain, and can introduce subtle bugs when operations
interact with multiple repositories. They also limit long-term goals such
as safely supporting multiple repositories within a single process and
continuing Git’s ongoing libification efforts.

To address these issues, global environment and configuration state should
be refactored into better-scoped contexts. Repository-specific data can be
moved into struct repository or related structures, while
subsystem-specific state should be localized appropriately. Passing
repository instances explicitly through function interfaces will improve
modularity, reduce hidden dependencies, and make the codebase easier to
maintain while moving Git closer to supporting multiple repositories safely
within a single process.

The difficulty of this project is medium, and it is estimated to take 175
to 350 hours.

Pre-GSOC:
---------

I first explored the Git codebase in December 2023, when I submitted a
small patch fixing the wording of an error message that I noticed while
browsing the source code. At that time I had recently started using Git and
GitHub for version control in my projects, which sparked my curiosity about
how Git works internally.

A few months ago, when I had some free time from college, I decided to
start contributing to Git more actively. I built Git from source, read
parts of the documentation, and familiarized myself with the mailing list
workflow. While going through the documentation, I noticed a few
inconsistencies in the MyFirstContribution page and submitted patches to
fix them. I also completed a microproject involving a test cleanup, and
later worked on adding a warning for a quiet fallback.

During this process, I attempted to remove the usage of the_repository from
a file. However, after discussion on the mailing list, Phillip pointed out
that the change was not particularly useful in that context and could
introduce segfaults that would not justify the effort for builtin code.
Based on this feedback, I dropped that attempt and instead focused on
understanding the broader global state refactoring effort. To better
understand the project area, I studied previous patches and blog posts by
Ayush Chandekar and Olamide Bello, followed discussions on the mailing
list, and explored parts of the codebase such as the wt-status and worktree
subsystems. This helped me understand the ongoing effort to reduce Git’s
reliance on global state and motivated me to work further in this area.

The following is a list of my contributions, ordered from earliest to most
recent:

Patches for Git:
----------------

* test-lib-functions.sh: fix test_grep fail message wording
        Status: Merged into master
        Mailing List: https://lore.kernel.org/git/20231203171956.771-1-shreyanshpaliwalcmsmn@gmail.com/
        Merge Commit: 37e8d795bed7b93d3f12bcdd3fbb86dfe57921e6
        Log: This was my first patch to Git in 2023. While browsing the
                 source code and past issues, I noticed that even after
                 the test_i18ngrep function was deprecated, an error message
                 referring to test_grep was left behind. I updated the
                 wording to correctly reference test_i18ngrep.

* doc: MyFirstContribution: fix missing dependencies and clarify build steps
        Status: Merged into master
        Mailing List: https://lore.kernel.org/git/20260112195625.391821-1-shreyanshpaliwalcmsmn@gmail.com/
        Merge Commit: 81021871eaa8b16a892b9c8791a0c905ab26e342
        Log: While getting familiar with the codebase, I followed the
                 MyFirstContribution documentation and encountered a few
                 issues. Some include headers were missing, the synopsis
                 format was incorrect, and the explanation for -j$(nproc)
                 was absent. I submitted fixes to improve the clarity and
                 correctness of the documentation.

* t5500: simplify test implementation and fix git exit code suppression (Microproject)
        Status: Merged into master
        Mailing List: https://lore.kernel.org/git/20260121130012.888299-1-shreyanshpaliwalcmsmn@gmail.com/
        Merge Commit: a824421d3644f39bfa8dfc75876db8ed1c7bcdbf
        Log: This was completed as a microproject for GSoC. Instead of 
                constructing the pack protocol using a complex combination
                of here-docs and echo commands, the patch captures command
                outputs beforehand and uses the test-tool pkt-line pack
                helper to construct the protocol input in a temporary file
                before feeding it to git upload-pack.

* show-index: add warning and wrap error messages with gettext
        Status: Merged into master
        Mailing List: https://lore.kernel.org/git/20260130153603.290196-1-shreyanshpaliwalcmsmn@gmail.com/
        Merge Commit: ea39808a22714b8f61b9472de7ef467ced15efea,
                227e2cc4e1415c4aeadceef527dd33e478ad5ec3
        Log: While exploring the code, I noticed a TODO comment suggesting
                automatic hash detection. After discussion on the mailing
                list, it was concluded that there was no future-proof
                approach to implement this until a new index file format
                came into use. Instead, an explicit warning was added rather
                than silently falling back to SHA-1. Additionally, several
                error messages were missing gettext wrapping, which was also
                fixed.

* wt-status: reduce reliance on global state
        Status: Merged into seen
        Mailing List: https://lore.kernel.org/git/20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com/
        Merge Commit: a7cd24de0b3b679c16ae3ee8215af06aeea1e6a3,
                9d0d2ba217f3ceefb0315b556f012edb598b9724,
                4631e22f925fa2af8d8548af97ee2215be101409
        Log: This has been the most significant patch series in my journey
                so far. It began with a suggestion from Phillip to clean up
                some the_repository usages in wt-status.c. I extended the
                effort to remove all usages of the_repository and
                the_hash_algo from the file. During review discussions, it
                was suggested that some worktree API cleanup should happen
                first, particularly regarding the representation of worktrees
                as NULL. Some related changes were later moved to a separate
                series, after which this refactoring proceeded.

* worktree: change representation and usage of primary worktree
        Status: Continued by Phillip Wood [1]
        Mailing List: https://lore.kernel.org/git/20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com/
        Log: This worktree API cleanup series started while I was working
                on wt-status. The intention was to modify the representation
                of the current worktree so that struct worktree would not be
                NULL. During discussion, Phillip clarified that NULL actually
                represents the current worktree rather than the primary
                worktree. Since Phillip already had a patch based on the right
                logic, he continued the series and it was eventually merged
                into master.

* tree-diff: remove the usage of the_hash_algo global
        Status: Merged into master
        Mailing List: https://lore.kernel.org/git/20260220175331.1250726-1-shreyanshpaliwalcmsmn@gmail.com/
        Merge Commit: 1e50d839f8592daf364778298a61670c4b998654
        Log: This was a straightforward patch that removed the remaining
                usages of the global the_hash_algo in tree-diff.c by using the
                repository’s local instance instead.

* send-email: UTF-8 encoding in subject line
        Status: Merged into seen
        Mailing List: https://lore.kernel.org/git/20260228112210.270273-1-shreyanshpaliwalcmsmn@gmail.com/
        Merge Commit: c52f085a477c8eece87821c5bbc035e5a900eb12
        Log: This patch was motivated by an issue I personally encountered
                while sending a GSoC discussion email [2]. Initially the
                change only modified the wording of the prompt, but after
                discussion on the mailing list it was extended to include
                proper validation to prevent invalid charset encodings from
                being used in git send-email and to reduce confusion.

* Remove global state from editor.c
        Status: Waiting for further feedback
        Mailing List: https://lore.kernel.org/git/20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com/
        Log: This was based on my doubt on localizing editor_program in
                editor.c [2]. The patch received mixed feedback from
                contributors and is currently awaiting additional guidance
                from mentor and/or maintainer regarding the appropriate
                direction.

Patches for git.github.io:
--------------------------

* SoC-2026-ideas: Remove an extra backtick
        Status: merged into master
        PR Link: https://github.com/git/git.github.io/pull/831
        Merge Commit: c1e4aa87a54430953eaa7355061139fdf1ff6796
        Log: Minor Typo fix.

* rn-132: fixed 2 typos
        Status: merged into master
        PR Link: https://github.com/git/git.github.io/pull/832
        Merge Commit: 92876114d855d472ce2e0e5337e72a4b97b81681
        Log: Fixed typos in Git Rev News Edition 132.

I have also been involved in additional discussions on the Git mailing
list [3][4][5][6].

History / Background:
--------------------

Efforts to reduce Git’s reliance on global state started when several Git
subsystems began moving toward libification, where Git’s internal
functionality could be reused as a library. Early examples of this
direction include major patch series such as the libification of git
mailinfo by Junio [7] and git apply by Christian [8]. These large patch
series exposed the limitations of relying on process-wide global state and
highlighted the need for better encapsulation of repository-related data.

One important step in this direction was the introduction of struct
repository, through refactoring work by Stefan Beller [9] and Brandon
Williams [10]. The motivation behind this structure was to centralize
repository-related state instead of relying on scattered global variables.
This change improved code clarity and made it easier to reason about Git’s
internal behavior. It also laid the groundwork for future improvements such
as safer multithreading and the possibility of handling submodules within
the same process. Later, additional refactoring work by Patrick further
removed reliance on the global the_repository in config [11] and path [12]
subsystems. As part of this work, several variables were consolidated into
environment.c from config.c so that environment-related state could be
managed in a single location [13]. The macro #define
USE_THE_REPOSITORY_VARIABLE was also introduced to help transition code
away from implicit global repository access [14].

This project area was further explored during GSoC 2025 by Ayush Chandekar
[15], who continued removing usages of the_repository across different parts
of the codebase and relocated several global configuration variables (such as
core_preload_index and merge_log_config) into repository-scoped structures.
More recently, Olamide Bello, during the Outreachy program, made significant
progress in improving how configuration values are stored [16] [17]. His work
introduced a new structure, repo_config_values, which stores repository
specific configuration values, linked to struct repository. This allows
configuration values to be associated with a specific repository instance
rather than stored globally. Along with this, a private structure
config_values_private was added to support initialization and internal
handling of these values. During discussions around these changes, an
important design consideration also emerged, moving global variables directly
into repository structures or introducing lazy loading helpers can lead to
user experience regressions if configuration errors are detected later.

These efforts collectively form the foundation of the ongoing work to
gradually remove Git’s reliance on global state and move toward a more
modular, repository-scoped architecture.

Proposed Plan:
-------------

I started exploring the codebase by browsing relevant files and identifying
global variables by temporarily removing the USE_THE_REPOSITORY_VARIABLE
macro. My primary focus was on core library files rather than builtin code
[18]. Through this exploration, I observed that a large number of files still
depend on the_repository.

To tackle this project systematically, I propose classifying these files into
two categories:

1. Files using the_repository or the_hash_algo where a repository instance
   already exists: These files rely on global variables even though a
   struct repository instance is available somewhere in the call stack. In
   such cases, the refactor primarily involves passing the repository
   instance through the function call stack and replacing the global
   usages. In some cases, a repository instance may not be directly
   available in the file itself. In those situations, I will trace the
   callers and propagate repository instances from higher levels in the call
   hierarchy. Examples of such files include, alias.c, archive*.c,
   walker.c, xdiff-interface.c. These cases generally require localized
   refactoring and are good candidates for incremental patches.

2. Files relying on other global variables defined in environment.c: Some
   files rely on additional global variables which are parsed and accessed
   through environment.c. In these cases, there is no existing
   repository-scoped instance, which makes refactoring slightly more
   technical. Examples include, wt-status.c (default_abbrev,
   comment_line_str), apply.c (has_symlink, ignore_case,
   trust_executable_bit, apply_default_whitespace,
   apply_default_ignorewhitespace). For such variables, I plan to evaluate
   whether they should be moved into a repository-scoped structure (e.g.,
   repo_settings, repo_config_values), or they should instead be localized
   and passed explicitly where needed. The appropriate approach will depend
   on how widely the variable is used and whether it logically fits in the
   multi-repository standpoint.

I plan to begin with the first category, addressing straightforward
refactors file by file. In parallel, I will analyze and work on specific
groups of global variables from the second category, designing appropriate
repository-scoped replacements.

The end goal is to remove reliance on global state and eventually eliminate
the USE_THE_REPOSITORY_VARIABLE macro from these files.

Project Timeline:
----------------

* Community Bonding (Until May 24):
        - Discuss the project direction and design approaches with mentors.
        - Identify and prioritize two main areas of work:
                + files that rely on the_repository.
                + global variables defined in environment.c.
        - Study the previous patches by Olamide Bello and Ayush in depth and
                 also discuss with them about their approaches and challenges.
        - Interact with all the people involved in this work to better
                 understand design decisions and potential pitfalls.
        - Experiment with small RFC patches, if needed to validate approaches.

* Coding period (May 25 - August 16):
        - Review the work done by Olamide Bello on moving values parsed by
                 git_default_config() into the repo_config_values structure and
                 identify any remaining tasks.
        - Complete remaining cleanup or refactoring related to the worktree API,
                 if left any [19].
        - Identify straightforward refactors to remove usages of the_repository
                 in files such as xdiff-interface.c, archive*.c, fsmonitor*.c etc.
        - Work file by file with the goal of eliminating
                 #define USE_THE_REPOSITORY_VARIABLE by replacing global usages
                 with explicit repository instances.
        - Concurrently maintain at least two parallel patch series:
                + Small / straightforward refactors and replacements like
                         the_hash_algo or the_repostitory.
                + Larger structural refactors involving globals such as
                         DEFAULT_ABBREV, comment_line_str etc.
        - Publish weekly or biweekly blog updates documenting progress and design
                 decisions.

* Final week (august 17 - august 24):
        - Address any remaining tasks or pending patches.
        - Recieve final feedback from mentors and reviewers.
        - Prepare a detailed report summarizing the work completed during the project.

Blogging:
---------

I believe blogging is an important part of any open-source project. It
helps others understand the ongoing work and also enables the contributor
to develop a deeper understanding and keep a better track of their own
progress. I experienced this firsthand, early in my journey I was unsure
about various aspects, but reading the blogs of Ayush and Olamide Bello
gave me valuable insight into the contributor perspective and their overall
work.

With the goal of helping future contributors in a similar way, I plan to
document my journey and project progress through regular blog posts. I will
publish updates on a weekly or biweekly basis, depending on the amount of
meaningful progress made. I have set up my blogging area on Medium, and my
posts will be available at [20].


Availability:
-------------

The main coding period runs from June to August. Most of June and July
coincide with my summer vacation, which allows me to dedicate significant
time to the project. My final exams are scheduled for May and will last
approximately one week, but they will be completed before the coding period
begins and should not affect my availability.

During June and July, I will be able to dedicate around 40 hours per week to
the project. In August, when my regular semester resumes, I expect to
contribute approximately 25–30 hours per week.

I do not have any other exams, internships, or planned vacations during the
coding period. Apart from this project, I have no other major commitments
for the summer.

I will keep the community regularly updated on my progress throughout the
project. My primary mode of communication will be email, and I will also be
available for calls or meetings if/when required. My preferred availability
window is 13:00–19:00 UTC.

Post GSoC:
----------

Being part of the Git community and contributing to the codebase has been a
very valuable experience for me. The process of understanding Git’s internals,
submitting patches, and receiving feedback on the mailing list has helped me
grow significantly as a developer. The feeling of working on code that is used
by millions of developers and companies around the world is very rewarding.

I plan to remain involved with the Git community even after GSoC by continuing
to contribute patches, review code, and participate in discussions to help make
Git better for end users. The work on refactoring Git’s global state is part of
a long-term effort, and I would love to continue working on it beyond the GSoC
timeline.

I would also be happy to mentor, co-mentor, or volunteer in the future to help
new and upcoming contributors whenever I get the chance. I see GSoC as the
starting point of a long-term relationship with the Git community.

Closing & Appreciation:
-----------------------

I would like to thank the Git community for the excellent documentation and the
welcoming environment. I am also grateful for the patience and guidance shown
in the feedback and discussions on the mailing list by Junio, Phillip, Karthik,
Ben, and others, which have helped me improve my understanding and contributions.

I also read blogs and proposals by Ayush, Lucas, Kousik Sanagavarapu, and Olamide
Bello, which provided valuable insights and helped shape my approach to contributing.

Thank you for reviewing my proposal :)

References:
-----------

[1]- https://lore.kernel.org/git/cover.1771511192.git.phillip.wood@dunelm.org.uk/

[2]- https://lore.kernel.org/git/20260304145823.189440-1-shreyanshpaliwalcmsmn@gmail.com/T/#m65b9b4547036991a7b7f3c861b9663428891f588

[3]- https://lore.kernel.org/git/20260114143238.536312-1-shreyanshpaliwalcmsmn@gmail.com/

[4]- https://lore.kernel.org/git/20260115211609.17420-1-shreyanshpaliwalcmsmn@gmail.com/

[5]- https://lore.kernel.org/git/20260204111343.71975-1-shreyanshpaliwalcmsmn@gmail.com/

[6]- https://lore.kernel.org/git/20260205131132.44282-1-shreyanshpaliwalcmsmn@gmail.com/

[7]- https://lore.kernel.org/git/1444778207-859-1-git-send-email-gitster@pobox.com/

[8]- https://lore.kernel.org/git/20160511131745.2914-1-chriscool@tuxfamily.org/

[9]- https://lore.kernel.org/git/20180205235508.216277-1-sbeller@google.com/

[10]- https://lore.kernel.org/git/20170531214417.38857-1-bmwill@google.com/

[11]- https://lore.kernel.org/git/cover.1715339393.git.ps@pks.im/

[12]- https://lore.kernel.org/git/20250206-b4-pks-path-drop-the-repository-v1-16-4e77f0313206@pks.im/

[13]- https://lore.kernel.org/git/20250717-pks-config-wo-the-repository-v1-20-d888e4a17de1@pks.im/

[14]- https://lore.kernel.org/git/cover.1718347699.git.ps@pks.im/

[15]- https://ayu-ch.github.io/2025/08/29/gsoc-final-report.html

[16]- https://cloobtech.hashnode.dev/week-5-and-6-design-reviews-rfcs-and-refining-the-path-forward

[17]- https://lore.kernel.org/all/cover.1771258573.git.belkid98@gmail.com/

[18]- https://lore.kernel.org/git/7b5dd0c4-0ca0-458e-89db-621a70dac9ae@gmail.com/

[19]- https://lore.kernel.org/git/20260217163909.55094-1-shreyanshpaliwalcmsmn@gmail.com/

[20]- https://medium.com/@shreyanshpaliwal18
