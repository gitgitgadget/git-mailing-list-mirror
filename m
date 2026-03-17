Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157CD3A5442
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744293; cv=pass; b=R87zwKadFf8U+yOzkI0AsYzPrfqUYrVIhX1u/q0ictNT4oYY6yB//yjlLPWuzMzxGzJwvxJWlLHiRJ9rt6e+fV8Y5LPJhJoCztIa8TEF//utBAI+3J4hpqchTmscmnTA5IK1RF+j4oiwkaON+ChZskQ1AJlofluYSxj9DTJWUzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744293; c=relaxed/simple;
	bh=KzoIQyDBaZIeg9cPgTQq8DxZ10n8irhJrz9YzG+vKC8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVJJ/H6tzXctN2uzuBf3FYBYWNQgM1iQMOmNM75z6j2hw2vdzA1M6Q0UsNykpBjXG/LujtmcW6dTmyPP1mXJvW9R1qzYJCmE/meQSL8948Suq5uwVjf7vqiNR43JUqUjlfoSMXXMQm26SlzBRH4oxXGlg7GgjuwmOP6dZfhuuTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFJiYK2D; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFJiYK2D"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ffc1e25d6cso1244974137.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 03:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773744291; cv=none;
        d=google.com; s=arc-20240605;
        b=BD+fKC9p0kd4pmC58jm+1rtFUyjG+Mz5OCqLLUDSKiO2qLZHzBr1Vq8Gu0uLQr6khi
         I7WKNKxA67QivX9XqTh5ShloeivXJp47kT1g3nSOY1cOueJYRlQy70qAzt51Vgx8Z+VE
         PJPpFypjXvrG1d5lKOu2Bwu0DxIWPftEflRCwRwsM6RIih/f5iLa2G4RRfdq6aCUUJZt
         3Jr+7fawfCBL46eJCDfgIgWXG0zeqSeZQBZqws4KN+6RzTKmPsKkOk0fE+umlDz3e4Nd
         od0fjc+Xs5/0jGkBC5+XEaFlTgQT46yrYb+yvMFhEHss6r3+NY7qUucPzS0utUKbEFId
         AqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6n8N7awmnR7moBiJcAINjCsDRvkizRBmb2GZCFiw78c=;
        fh=oz/6DJnJsDAdpQRPpUzYbdr6OMiFhKiOOZPR4m9DOvw=;
        b=Sy65yhCbQdZdUylTIavZvxYK299eYK4vfXo1yJqcjirsBPpRXVSOhcPmKJs3tQ9CmH
         mZTbPkJfYJ5rJtVqrF7wTur9+6x1LUXiBGEpqP04vbO0Ev7/rOYsB4vkT0VEcg3s18cp
         QlGdiDMNfkx8Al+kOzQsUEGdIoE+xM/BCrCuwu6N7aOwsnALdeQuN2yNnxFNBEQohJJn
         TIPOakMRUfvH0mNEJLeNzVagRmE2JjhK2qF8Jmhiavjdx8VRZXf794h466junKO+F7YD
         iyIAyH+Z4bYAb1y2ACrGn1Q0EmvZbkOt4dDsEoNTticeLKHg3Havta4l5/vWbqsG34wv
         oNkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773744291; x=1774349091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6n8N7awmnR7moBiJcAINjCsDRvkizRBmb2GZCFiw78c=;
        b=VFJiYK2DvpkfAl5m8ARDoIDDBqb+HXLiUezjwrwUpb3M3B9gWne1FATCXGehoqj45b
         7o8I2W8aDwo/VM4brzlxG6vxuejRvHxfYckNZJi1Qd3i0qCYgJmDdjzMXfBsgVnsSV6g
         QijprfWC59m5q0TUd3q3nwliR5WUB8mq5uucXfRfxgmgnpmKrMe5J/YGgN++W5OsgP0x
         ugjPF4VucM+GNRDwjggalidbXLBsSGif1y2d9deX0ClJcTln2yCF7tiel+gH6EYQbLTp
         kwL0tm1oQRtJ8ovI6hFfkxlwOhUCs1fuDkatt6kfPEkcfX5GbKEMIaI1gxoLl6Dp+/7d
         vITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773744291; x=1774349091;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6n8N7awmnR7moBiJcAINjCsDRvkizRBmb2GZCFiw78c=;
        b=aBMija72p+JN6IvF2KVlXhMoAL7q0WrYRjOV50B/Yf0xDd0SHVB0N5SZTpurSUEofp
         DcdQMSlpkuqZ7IWyTjiBRfaoUFFf96DEVZogAysER0PzkPP2HnQezQdNNCRwXo3Ww/Vq
         XX/bL6o2DazBMK7yrxNG0dHzsN6VjX5pGatfTp3IoM60KCWMB9zw/aU+M4hERIHtIgDO
         KQRd9N4oL9J9jLDOSTJiBFF3KmH2xa3ZD1E6MeRl71ryj5kdE4fkOfekmGUgNSmuO1iL
         4jjxNcB1gQDDvISeAtEf1lEOOXJUWIAPKke7cQWUuX8HTUHI35RwfjbxpIF5se3Cr9m9
         UyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfekbGjuKzH8EF9qaj4zVBKMcNvYQ90KSY9BS5mBOB3EeDfIxHLaveZTnIyW6aZ95IvO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZkbr2xFuiNCT2bKoANro04uyF0dzOYkEhmglj1wW/wKvfhSeM
	EU8U9r5kMAXvc3azBr7FZ7rhqG3TOu3VXI+byzTuJGDwTd5gzfYz8uvFEC29gVwRPIqsNcw0w4R
	Nq1iDcIIARr9QgCp+H1PZEpE9VpXSiUc=
X-Gm-Gg: ATEYQzyiivvlg86oW8HltsWdlHgULMX/l+XZkxzCpSv603Ph4sphVbHfV2a2cxNPgig
	nGHmVzONrDSW1m6AC1weud1cjaX+aRaGnLbGYp7pG2ksciWzU1dYPrqRD0TvwIG24qaguwKEaS/
	amTR3VqpwE+t+glMMtuoNCBMrGKIWF4WJF5zFhDwBTw7IQPxhnBkcb4aSXZxIBaIcN6ozVN2I+O
	5JQ51ffj/tqtvufccwOTbd2mrYjXHErPBUSMUxt1DgCjSsnxBVAgOF8P5JQwXVd/EEhYHEoIcbj
	BjIAb9CHKwGaoj40xFZGgYbIxgwwpnwJY0BPvO7yHQ==
X-Received: by 2002:a05:6102:2ac5:b0:5fe:c4aa:10d6 with SMTP id
 ada2fe7eead31-6020e55710amr6103606137.34.1773744290821; Tue, 17 Mar 2026
 03:44:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Mar 2026 03:44:49 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Mar 2026 03:44:49 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CA+rGoLd-1Mb5JG1H1PvE-kyjdznrLVFjwQiMLHtd2ETQ-igmXg@mail.gmail.com>
References: <CA+rGoLd-1Mb5JG1H1PvE-kyjdznrLVFjwQiMLHtd2ETQ-igmXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Mar 2026 03:44:49 -0700
X-Gm-Features: AaiRm52keSMfjKkUQp4spo19LStTMgAo8q_d2vkJVVFnAEl9xiMNgnWJEghSku8
Message-ID: <CAOLa=ZS6HtJrWd0kfsFASCbP2S9-MQq5Da3feA0WqY8ykZ0WTw@mail.gmail.com>
Subject: Re: [GSoC][PROPOSAL] Improve the new git repo command
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>, 
	GIT Mailing-list <git@vger.kernel.org>
Cc: Justin Tobler <jltobler@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	christian.couder@gmail.com, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000609c81064d360670"

--000000000000609c81064d360670
Content-Type: text/plain; charset="UTF-8"

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

Hello,

> Hey everyone,
>
> This is my proposal for the project
> `Improve the new git repo command`.
>
> ---
> = GSoC 2026 PROPOSAL: IMPROVE THE NEW GIT REPO COMMAND
> Jayatheerth Kulkarni <jayatheerthkulkarni2005@gmail.com>
> v1.0, March 1, 2026
>
> == 1. ABOUT ME
>
> I am a junior at Geethanjali College of Engineering and
> Technology pursuing a bachelor's degree, with a strong
> interest in open-source projects and systems programming.
> My interest in the Git project stems from a desire to
> understand the internals of version control and contribute
> to a tool that is fundamental to the global software
> development ecosystem.
>
> === 1.1 Contact
> * Email: jayatheerthkulkarni2005@gmail.com
> * Website: https://jayatheerth.com/
> * GitHub: https://github.com/jayatheerthkulkarni
> * LinkedIn: https://www.linkedin.com/in/jayatheerth/
>
> === 1.2 Logistics
> * Timezone: Indian Standard Time (IST) / UTC+05:30
> * Tech Stack: C, Shell Scripting, Rust and Go
>
> == 2. CONTRIBUTION HISTORY
>
> I have formally completed all the prerequisites to apply
> for the GSoC "Improve the new git repo command" project.
> I have listed all of my work I have done in the past few
> months.
>
> === 2.1 Featured Contributions
>
> For many months, I have been actively engaging with the
> Git community through mailing list discussions and patch
> submissions. Notably, my work on fixing stash messaging
> behavior in submodule environments was featured in Git
> Rev-News edition 124.
>
> * [PATCH v3] stash: fix incorrect branch name in stash message*
>   Status: Merged into `master` & featured in Git Rev-News.
>   Link: https://lore.kernel.org/git/20250611014204.24994-1-jayatheerthkulkarni2005@gmail.com/T/#u
>
> === 2.2 Core Path and Submodule Patches
>
> * [PATCH v8] submodule: prevent overwriting .gitmodules entry on path reuse*
>   Status: Merged into `master`.
>   Link: https://lore.kernel.org/git/20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com/T/#u
>
> * [PATCH v2] dir: Fix and test wildcard pathspec handling*
>   Status: Merged into `master`.
>   Link: https://lore.kernel.org/git/20250422160547.577524-1-jayatheerthkulkarni2005@gmail.com/
>
> === 2.3 Refactoring and Micro-Projects
>
> I am deeply familiar with Git's test suite and standard
> C conventions, having submitted several refactoring and
> cleanup patches, including two specific to the
> `builtin/repo.c` file:
>
> * [PATCH GSoC] repo: Remove unnecessary variable shadow*
>   Status: Merged into `next`
>   Link: https://lore.kernel.org/git/aZxyju3B4NHp4c_t@denethor/T/#t
>
> * [GSoC] t7101: modernize test path checks*
>   Status: Merged into `master` (Official micro-project).
>   Link: https://lore.kernel.org/git/CALE2CrS0Q2NS1DbFv4pyRQsuypu=KH6Kurs=m4yWrFbR9QosoA@mail.gmail.com/T/#t
>
> * [PATCH v2] pull: move options[] array into function scope*
>   Status: Merged to `master`.
>   Link: https://lore.kernel.org/git/20251212074433.38027-1-jayatheerthkulkarni2005@gmail.com/T/#u
>
> === 2.4 Documentation
>
> * [PATCH v3] Update MyFirstContribution.adoc to follow modern practices*
>   Status: Merged to `master`.
>   Link: https://lore.kernel.org/git/CA+rGoLfFVcUFctoEx6wshovGnRW8pTW--ZB42ntd01VHMJm_Rw@mail.gmail.com/T/#t
>
> === 2.5 Experience with C
>
> Since Git is mainly written in C, I have no issues
> navigating the codebase. I hold a Cisco CLP - Advanced C
> Programming certificate covering Unix and C systems
> programming, and I have completed two full university
> semesters of C programming.
>
> == 3. PROJECT PROPOSAL
>
> === 3.1 Why "Improve the new git repo command"?
>
> This project is compelling because I have closely followed
> its development since its inception in GSoC 2025.
> Consistently reading the weekly updates
> (https://lucasoshiro.github.io/gsoc-en/) and participating
> in the mailing list discussions has given me a deep
> understanding of the command's architecture.
> My previous work fixing cross-platform wildcard pathspecs
> in `dir.c` makes me uniquely suited to tackle the path
> resolution this project requires, while my C systems
> experience prepares me for the architectural refactoring
> of the command.
>
> === 3.2 Introduction
>
> The new `git repo info` command is positioned to be a
> cleaner, programmatic replacement for scraping
> `git rev-parse`. However, its current implementation lacks
> category-based querying, relies on global state macros,
> and is missing critical path data.
> To fully realize Git's libification effort and improve
> user experience, the internal architecture of
> `builtin/repo.c` must be modernized.
>
> === 3.3 Proposed Solution and Objectives
>
> Instead of just scraping basic paths, I propose an
> architectural update to `repo info`, safely utilizing the
> new `strbuf_add_path` API submitted by Lucas Oshiro.
>
> *Objective 1: Category-Based Query Architecture (The Core API)* +
> Currently, the `repo_info_fields` array relies on an
> exact-match binary search (`bsearch`). Users must request
> specific keys or use `--all`.
> I will rewrite the lookup logic to support
> category-prefix matching.
> * *Implementation:* I will implement an internal mapping
>   structure so that calling `git repo info path`
>   successfully identifies the category root and iterates
>   through all keys starting with `path.*`, returning them
>   dynamically.
>

This would definitely be nice to have. Have you also thought about glob
pattern matching too? That way a user could do

  $ git repo info "path*"

And have it list all keys which start with path. Similar to how you plan
to do category matching, but this can also do

  $ git repo info "*object*"

So any keys with object in it would match too. Either ways I'm just
thinking out loud and not saying this is what you _should_ do.

> *Objective 2: Deep Libification (Removing Global State)* +
> The `builtin/repo.c` file is already highly modernized,
> but it opts into global state by declaring
> `USE_THE_REPOSITORY_VARIABLE` at the top of the file.
> * *Implementation:* I will remove this macro entirely.
>   The primary blocker in this file is `get_layout_bare()`,
>   which currently marks its local `repo` argument as
>   `UNUSED` and falls back to the global
>   `is_bare_repository()` helper.
>   I will refactor this function to drop the `UNUSED` tag
>   and explicitly evaluate the passed
>   `struct repository *repo` pointer.
>   I will thread this context down the call chain without
>   breaking existing external callers.
>

It would be nice to collate some of the efforts already made in this
direction, I know its not as simple [1] as passing in the repo since
`is_bare_repository()` has a lot of callees.

> *Objective 3: Core Path Resolution (`git rev-parse` parity)* +
> With the category API built, I will populate the `path.*`
> category by implementing the remaining path values currently
> obtained through `git rev-parse` and `--git-path`.
> Lucas Oshiro's recent patch series implemented `path.toplevel`;
> https://lore.kernel.org/git/20260228224252.72788-1-lucasseikioshiro@gmail.com/T/#t
> I will build upon this foundation to implement the rest.
> Because path normalizations across different systems are
> complex, I will leverage my experience from `dir.c` to safely implement:
> * `path.git-dir`, `path.common-dir`, `path.worktree`.
> * `path.objects`, `path.hooks`, `path.index`, and `path.grafts`.
>

This is the crux, but you should also probably involve some of the newer
discussions around this. I added some pointers to Mansi's proposal, and
perhaps that's something you should look into too. [2]

> *Objective 4: Sparse Topology & Boundary Awareness* +
> Modern Git workflows rely heavily on partial checkouts
> and submodules, and `repo info` should report these
> complex states natively.
> * *Implementation:* I will implement `layout.is-sparse`
>   to expose if the repository uses a sparse-checkout
>   cone, and `path.superproject-working-tree` to instantly
>   query if the current repository is a submodule.
>

Those may be good additions.

> == 4. PROJECT TIMELINE
>
> === 4.1 Community Bonding Period (May 1 - May 24)
>
> * Attend the Git community GSoC sessions to introduce
>   myself and establish a communication schedule.
> * Initiate the design discussion on the mailing list
>   regarding the internal data structure for
>   Category-Based Queries.
> * Map out the exact C call chains affected by
>   `USE_THE_REPOSITORY_VARIABLE` in `builtin/repo.c`.
>
> === 4.2 Phase 1: Category Architecture & Core Paths
> (May 25 - July 5)
>
> *Weeks 1 - 3 (May 25 - June 14):*
> * Implement the category-based lookup mechanism in
>   `builtin/repo.c`.
> * Update the parsing logic so `git repo info <category>`
>   successfully returns all nested keys.
>
> *Weeks 4 - 6 (June 15 - July 5):*
> * Utilize Lucas's `strbuf_add_path` API to implement the
>   core path values.
> * Implement path related keys.
>   (`path.git-dir`, `path.common-dir`, `path.worktree`,
>    `path.objects`, `path.hooks`, `path.index`, and `path.grafts`)
> * Write rigorous OS-agnostic tests in `t/` to ensure path
>   resolution works correctly across POSIX and Windows
>   environments.

I think this will take way more time than the two weeks allocated here,
mostly because of the design decisions we need finalize on.

>
> === 4.3 Mid-Term Evaluation Phase (July 6 - July 10)
>
> * Ensure the category architecture and core paths are
>   merged into `master` or queued in `next`.
> * Review progress with mentors and adjust the Phase 2
>   timeline if necessary.
> * Submit mid-term evaluation.
>
> === 4.4 Phase 2: Removing Global State & Sparse Topology
> (July 11 - August 16)
>
> *Weeks 7 - 9 (July 11 - July 26):*
> * Focus entirely on libification.
> * Remove the `USE_THE_REPOSITORY_VARIABLE` macro from
>   `builtin/repo.c`.
> * Refactor `get_layout_bare()` and similar functions to
>   utilize the explicit `repo` parameter.
>
> *Weeks 10 - 12 (July 27 - August 16):*
> * Implement the advanced topology and boundary keys
>   (`layout.is-sparse` and `path.superproject-working-tree`).
> * Run the full test suite and perform rigorous edge-case
>   testing ensuring libification does not cause
>   regressions.
> * Buffer period for addressing mailing list feedback
>   regarding the libification and sparse patches.
>

Overall I think this is trying to do many things in a short time frame.
I would also consider the time it takes for reviews and iterations to
land.

> === 4.5 Finalization (August 17 - August 24)
>
> * Finalize the official Git documentation
>   (`Documentation/git-repo.txt`) for all new keys and
>   category querying.
> * Clean up the commit history and ensure all patches are
>   finalized on the mailing list.
> * Submit the final GSoC project report.
>
> === 4.6 Stretch Goals
>
> If review cycles move faster than anticipated, I will
> implement Split-Index Topology (`path.shared-index`)
> to report the path to the shared index file. I will
> also investigate natively parsing `git-sizer` metrics
> into the newly established category API to provide
> deeper repository health insights.
>
> == 5. AVAILABILITY AND BLOGGING
>
> This timeline aligns perfectly with my schedule.
> The project kicks off in May, during which I will be on
> summer vacation and can dedicate 35-50 hours a week.
> During June and July, I will transition into my final
> year of university.
> My academic schedule during this period is highly
> flexible.
>
> *Blogging:* +
> I have a domain setup at jayatheerth.com.
> As patches flow and the project progresses, I will host a
> dedicated endpoint at `/blogs` to provide comprehensive,
> weekly coverage of my project.
>
> == 6. POST GSOC COMMITMENT
>
> I actively follow the mailing list and intend to continue
> contributing bug fixes and enhancements.
> I have been a part of the Git community since 2025 and
> hopefully will continue to be one for a long time.
>
> --- End of proposal ---
>
> Regards
> - Jayatheerth

Regards,
Karthik

[1]: https://lore.kernel.org/git/xmqqbji0b5ak.fsf@gitster.g/#t
[2]: CAOLa=ZTtNSZ904v0-SN16jAis7gK4=MVj1g_5CGdbmaBopeZkg@mail.gmail.com

--000000000000609c81064d360670
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 974e4e620b5ddc4c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tNU1Kd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEdsQy93THVCMmJFWmxWZWxkZzBzT1VpNXZhRHEvbQp4MFcybnhzSTZh
QWRnQm5MWFM5NG82MnJLTzJta0ZMK0lqZVF6SlY5dEZlOXNWdHVTOEI0aTNvcDRueW5Ma09XCnpU
M1Joa2NRck1LdHQ4eEdrVS9CSWZ5N1RTa1BISFBtcU81TmNFUVhnOUVqZ2g1RUtsRkJram1VMVg1
SkZtbnQKVEJDNHRzNmE4R2k3MHRiY0JSa29VbUVaUG8zaTU4RFJOTHNKU09yZkY1T0lEc3IwL2pq
RHVPMmpncGlueSt6TAprTXR6SUdHUWU1Yk1Hd2FqZU02RWJKRitxKzBCd3o3YjE3QWNlempvMUZo
NVE2MUJkY290Y1lCMmdxZnlscmRyCkR5NG9NYXlXaG13Rm5seVBvVjBrc3dYZmhqSjZObWRpVklS
UlZZQTFjQjVZMEwvODhiODVWeUZRNGdkNVNYRTEKMzd3ajQ0NEpKRWd2a1B2dVFwTzZiOWFKTlp2
V1lxRXpUZ2svOVY5V3BOYXNERk1DRnhiYlpWQzM5RnNxdmM0MgpDWnpNWDRFcFJVd2wxUzJZZVlz
SjFrcTFQcWtOaW1jc2dON2FHT0NnWXB5emRFSjRBUi8yT2lyMER4K25RUjE5CkpwUVZEWnVHejU2
NzRyUjg5cVBjbm84Q1dmbTFwQVgwMlpiRkU5RT0KPVN3M2oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000609c81064d360670--
