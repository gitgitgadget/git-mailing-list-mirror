Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B73A9DB6
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758562; cv=pass; b=pNBSq3ENVlVcJARLpwBNZ89QBC1IpDs57Ssv6z7klHCxv38ttUAWj4hzmLoYKzhdI0MT/NtkNMiQ7vg/vWVNHrkfma8rqyIsYD4p/KbTEEFYv1rFDlioFQq9tl8PIB+GtgIT4y0GoIyNbXSLqtcKj3NAyua2U1BMsPGL8Wakxr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758562; c=relaxed/simple;
	bh=0CJaHIi/JVtScmNNKmZmQlRfuE2SUpFUO2hEm0eALeY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lTiApWv0sJL7I9GOLgmH+sUmpXXwV85NnK45rU1eIa294m474Di7pOf7DR0iGJKJPv2pye0j9zlS264eJ0nh0Fnu5+nM+EWFmETuMp3pFbj4uyS4EUXtXQnn0qf/HDvvaRp9pVGIeahSuBb6fiE0shGT49gLaglRmQOUbemt5zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edoOhfuc; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edoOhfuc"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506bcb23a78so49914661cf.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 07:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773758559; cv=none;
        d=google.com; s=arc-20240605;
        b=IbFepnyjiEjUVv26Ipe/mn5jHPwx1M02OtQG7JixvOjchKNPhoZoCJaBh22Xp9Tslu
         bDiHuj+lGICRzAQWtRsgilL5vsHeM/1mGnAhp31W2BECX6eWFkvQ1zQ1w81cV6TpIjny
         ewADeUb/ZB5MzxO2Bb3cHi/2Tl+ux4RigP4qI62ftCTFXSE7iJLfGz/b8vWoe5RINisa
         1avaGRIW2pkArdW/vVQeKwy3UCIHL5IuecPClTP5F56wppCR7DN2tmOeq0vP1NgfcMwr
         oKKAK9rolIL6lfsyemwfSYBCkrxeHPW9Ay2D3L4EWB0T3lxpAvJznJ2d2bFC0luPTWoV
         SBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=hfK/TxYXSCtGqGX5ecTwLRlP7hYECU2nCuRocu/kkzQ=;
        fh=n2Si4HvF47hBPieZ9hBwq1VMMHR4X1/gGGG1LTRa5H8=;
        b=YEadz6TeRomwjwsljtz5x12uPhfY1UbGw9fbg2rYAzSDDMWbmDxWtKFxrKrZFR6clJ
         YiNhpwoKZi6x8yEFEDPjATbgWh7jcf4JIf6B01W8bTaXCNyhQIhRgjuio4RNtrFTHM1P
         Eiq0m7lWE+lCptXK4yC8l6Guh8Oqki3A8ndRc2Lao3g19kiRuKAE44m68qNN0//4ixO/
         tnSZd9lj6BJ5tkFAodI8WI06tzjaUG1RAxh0co+0t3Y4iqGTRjgxXivKBOWU5V4/XiIH
         3zFuU8varbE3iooAIV71bINlRKlAcdQh/P6JZ5PteN863tyPrk2a0CthENZE8BSXFlE6
         gflQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773758559; x=1774363359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hfK/TxYXSCtGqGX5ecTwLRlP7hYECU2nCuRocu/kkzQ=;
        b=edoOhfuc16uy39Qmg+RGRTL5erksPk3fIm9tSzLcUecfE/QwiDSj+CfTt6v7vikB+M
         hZ2qUM4tW9eTTxLidzsni25s4fRr5lIJn2IuBzSaGBkq0N8HfjcrBpaPISdQK2imXAiE
         QrTMbwAKNOktsRBgE4RsqvD18k1StYpgeGIFrDiYyL/y1COofgxf6Z4qom8ktkMhqobI
         WN2USjXa2xG3mRhJ+iRF1uA5HyS9jzht66czIyiZu2ym/9nWtmhpkg0z+LPiHoizZgr0
         ZjunH8L0FpiKr7RoMzUgnHQT+t/+Vq7IqACC4K7CgXToWZar5kyGE9gxuZoPAS5BNoFo
         rkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773758559; x=1774363359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfK/TxYXSCtGqGX5ecTwLRlP7hYECU2nCuRocu/kkzQ=;
        b=KjxlgOw58hoxwfsgASBacae+fZSdf5WeOj/jGnzu70AjF9ptTFpwV/Gj4eJvou8ezS
         koLNb0/GgXp8yGvB96nKq5fB8qLpmmGi+DHhL5fjR26+uFPcCb7d/UAd7Wxoq4+gY/6d
         SOUSYRaiU90S4f9RvVD+E0UAm7zrt21IY7vME6CJhUzs1bIcNGNGYRVUdTjKKLQB6IY5
         KuS6Udt7nDsKQ0nUx0YG6wzQCcNe5HVAcIVulVCfrzsY+SOgkrYrXWSYIxuCYCyAZQfa
         hiVDJLA7Q0iIBlcyK0l1i4ZNEZREdpiYH38MBhcBEbXanAWqRx/L74fhl0sOxb0/b51d
         6gZg==
X-Gm-Message-State: AOJu0Yy6SSTA1vq0EtCydlAwzEX12621qtPtvpWDgI34FiFdvTwlF4Mp
	8XS17u0+KSMGKmkhHpMqqGzhjDHaIuGBUT/ppD5Zj3GFXLijs4xtbEoFS1opS5lZxylFhJcqVvT
	RUMMxTVHiqJswJGhf2Uxl0TJdvAjy4fAvU8K6nxo=
X-Gm-Gg: ATEYQzy3FEGV8Z0lQI8zO1ZvNGzK3eIN+KjgD53qvIiQGRgoOh9KmbEHDHL0nukiJ+9
	psVdUl8F+OWVTosg9c/rMsT3BTBDrxGgJtif7Ow/dwgXHXaoD/sJh/cfRUT6ZaA0QPKGp29sDE3
	htKP2moUT3dVw6D9ravPsz60MsW2cV9S1pzUDbY49rGdjspBqKvk7rPzpsoPJMR7JqqdZXO6Y1n
	9lyAs/hBoHjc94Sj1RxDwZPpDf00H1ohM8r5ojfEk58Bwsmpy8W9qc3hfZ9CVXLUuPJn04VCLS8
	gW+mluI9rDtWqFxB5+ffTi8ippNq9MReLk+wmYVQt81K0d+uCoq8dJZnJpjexukr8PSvUrFQg2T
	POU44DlFz/i2uBBH3BDERzOuvEA==
X-Received: by 2002:a05:622a:146:b0:509:15aa:cf09 with SMTP id
 d75a77b69052e-50957df0e7dmr232327371cf.45.1773758558506; Tue, 17 Mar 2026
 07:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 17 Mar 2026 20:12:27 +0530
X-Gm-Features: AaiRm52qJRLB1rsssVRGXQIo5EjGgZw1k_fYVRrhYEk4GcjLldxAHSqPiDsGmXE
Message-ID: <CA+rGoLd4ho5AmB3gWYP=yUUKJO=YqthxKX8R_rvN7V7exArn6Q@mail.gmail.com>
Subject: [RFC Proposal v2] [GSoC 2026] Improve the new repo command
To: GIT Mailing-list <git@vger.kernel.org>
Cc: karthik nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This is version 2 of my proposal
The reason why I post this in a new thread is because the
structure has entirely changed since the last time.

I have also edited a latex doc
can be viewed at [1]

I have also attached a link to the previous thread here [2]

Below is the inline text format:

--- Start of proposal ---

GSoC 2026 Proposal: Improve the new git repo command
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Author:  K Jayatheerth <jayatheerthkulkarni2005@gmail.com>

1. About Me
-----------
I am a junior Computer Science undergraduate at Geethanjali College of
Engineering and Technology with a focus on systems programming.

My interest in the Git project stems from a desire to
understand the internals of version control and contribute
to a tool that is fundamental to the global software
development ecosystem.

I am applying to this project specifically because I have followed the
development of `builtin/repo.c` since its beginning in GSoC 2025. I have
closely tracked its evolution through Lucas Oshiro's development blogs
(https://lucasoshiro.github.io/gsoc-en/) and have studied the
mailing list discussions.

2. Contact Information
----------------------
* Email:      jayatheerthkulkarni2005@gmail.com
* GitHub:     https://github.com/jayatheerthkulkarni
* Website:    https://jayatheerth.com/
* LinkedIn:   https://www.linkedin.com/in/jayatheerth/
* Timezone:   UTC+05:30 (IST)
* Tech Stack: C, Shell, Rust, Go

3. Previous Experience with Git
-------------------------------
I have been an active contributor to the Git mailing list since February
2025. I have navigated the full patch lifecycle that includes submission an=
d
review to integration into `seen`, `next` and `master`.

My work has focused on areas directly relevant to this proposal:
path matching, submodule interactions, and safe memory handling.

I have ensured to not pick any micro-project that would directly affect oth=
er
GSoC applicants.

3.1 Selected Contributions (By Relevance)
-----------------------------------------

(1) [PATCH v3] dir.c: literal match with wildcard in pathspec should still =
glob
    Date:   April 22, 2025
    Status: Merged into master
    Link:   https://lore.kernel.org/git/xmqqecxk3u5l.fsf@gitster.g/T/#t
    Impact: Fixed a logic error in `dir.c` where wildcard pattern matching
            terminated prematurely.

(2) [PATCH v3] stash: fix incorrect branch name in stash message
    Date:   June 30, 2025 (Featured in Git Rev News #124)
    Status: Merged into master
    Link:   https://git.github.io/rev_news/2025/06/30/edition-124/
    Impact: Fixed a memory safety issue (static buffer reuse) in
            `refs_resolve_ref_unsafe` that corrupted stash messages in
            submodule environments.

(3) [PATCH v3 0/3] clean up a few things
         ` [PATCH v3 1/3] path: remove unused header
         ` [PATCH v3 2/3] path: use size_t for dir_prefix length
         ` [PATCH v3 3/3] path: remove redundant function calls
    Date:   March 2, 2026
    Status: Merged into master
    Link:   https://lore.kernel.org/git/20260302142138.712273-1-jayatheerth=
kulkarni2005@gmail.com/T/#t
    Impact: Improves readability and type safety in `path.c`.

(4) [PATCH v8 0/2] Avoid submodule overwritten and skip redundant active en=
tries
         ` [PATCH v8 1/2] submodule: prevent overwriting .gitmodules
entry on path reuse
         ` [PATCH v8 2/2] submodule: skip redundant active entries
when pattern covers path
    Date:   July 25, 2025
    Status: Merged into master
    Link:   https://lore.kernel.org/git/E4F5EF8F-4146-46BA-A498-8493706238A=
7@gmail.com/T/#t
    Impact: Prevented accidental overwrites of `.gitmodules` configuration
            when paths are reused.

(5) [PATCH] repo: Remove unnecessary variable shadow
    Date:   Febuary 23, 2026
    Status: Merged into master
    Link:   https://lore.kernel.org/git/CA+rGoLeppg4Xaoqg6+SZ=3DET=3Dze6rXU=
bmjLm5UvmitmRGm9u6ag@mail.gmail.com/T/#t
    Impact: A targeted cleanup in `builtin/repo.c`.

(6) [PATCH v4 0/3] Update MyFirstContribution.adoc to follow modern practic=
es
         ` [PATCH v4 1/3] docs: remove unused mentoring mailing list refere=
nce
         ` [PATCH v4 2/3] docs: clarify cmd_psuh signature and explain
UNUSED macro
         ` [PATCH v4 3/3] docs: replace git_config to repo_config
    Date:   May 18, 2025
    Status: Merged into master
    Link:   https://lore.kernel.org/git/20250518074317.73367-1-jayatheerthk=
ulkarni2005@gmail.com/T/#t
    Impact: Modernized documentation to reflect current API usage
(e.g., `repo_config`).

(7) [GSoC] t7101: modernize test path checks (Microproject)
    Date:   January 09, 2026
    Status: Merged into master
    Link:   https://lore.kernel.org/git/CALE2CrS0Q2NS1DbFv4pyRQsuypu=3DKH6K=
urs=3Dm4yWrFbR9QosoA@mail.gmail.com/T/#t
    Impact: Modernized legacy `test -f` checks to `test_path_is_file`.

3.2 Community Engagement & Design Discussions
---------------------------------------------
Beyond my own patch series, I actively participate in technical
discussions to shape the future of the codebase.

(1) [Discussion] Regarding 'repo info' architecture
    Link: https://lore.kernel.org/git/CA+rGoLfbzXqP1Tw+94jMmWcSGPoefMv5E_fv=
wriad-O5CUeKHQ@mail.gmail.com/T/#t
    Context: Participated in discussions regarding the path normalization
             strategies for the new command.

(2) [Review] Reviewing other contributors' patches
    Link 1: https://lore.kernel.org/git/20260301165051.90762-1-jayatheerthk=
ulkarni2005@gmail.com/
    Link 2: https://lore.kernel.org/git/20260224204047.8452-1-valusoutrik@g=
mail.com/T/#m01db41a20a30efb0d891163f2c3a70c7e0496b51
    Link 3: https://lore.kernel.org/git/xmqqcy1cz8hw.fsf@gitster.g/T/#mdfe3=
c15ca5a44f59f44b660dd9690f464d1df676
    Link 4: https://lore.kernel.org/git/20260310133435.42995-1-jayatheerthk=
ulkarni2005@gmail.com/T/#md1a6f6ef1826c3c17e3ceb1b9e6e5140c9fe688d
    Context: I review patches from time to time of other contributors
             to help reduce the burden on maintainers and ensure code quali=
ty.

(3) [Discussion] Regarding 'git pull --rebase' fork-point behavior
    Link: https://lore.kernel.org/git/177a25f0-7292-4ee7-8a02-9c90a5979313@=
gmail.com/T/#ma5cc64a2a62cb622ab4d6afbc45e9d48733a748c
    Context: Wanted clarification on the fork-point heuristic
             and identified the core internal functions
             (get_rebase_fork_point() and
get_rebase_newbase_and_upstream()) responsible for the behavior to
begin exploring potential
             approaches for a fix.

4. Project Proposal
-------------------
Taken from the ideas page of the GSoC 2026 projects list, the goal of this
project is to improve the existing git repo command. To specify the
objectives in detail, this proposal covers three main goals:

a. Add path.* keys into the repo info command.
b. Remove the USE_THE_REPOSITORY_VARIABLE.
c. Form categories for the keys for the git repo command.

I had a hard time picking which of these to keep out of scope,
as I equally liked all the ideas in the proposal.
However, taking timeline into consideration, I have moved Goal d to
a stretch goal/post-GSoC commitment to ensure the core deliverables
are highly stable.

d. Study and collaborate with Justin Tobler for git structure work.

Goal a: Add path.* keys into the repo info command
--------------------------------------------------
This is currently a high-activity area on the mailing list. To avoid
redundant effort or conflicting patches, my strategy will be adaptive
based on the state of the tree during the Community Bonding period.

I have reviewed the overlapping patch series submitted by Lucas Oshiro
and Eslam Reda. Since discussions are already ongoing, my goal is to
build upon their foundation rather than reinventing it. I am already
actively participating in the core design discussions on the mailing list
(https://lore.kernel.org/git/20260228224252.72788-1-lucasseikioshiro@gmail.=
com/T/#u)
regarding how to handle relative versus absolute path outputs. We are
currently weighing several approaches: global `--path-format` flags,
stateless virtual keys (e.g., `path.absolute.toplevel`), and `ref-filter`
style format modifiers. I will prioritize finalizing this design consensus
during the bonding period, and then focus on implementing the remaining
core keys and cross-platform edge cases.

I will ensure the following keys are fully supported and tested by the
end of the GSoC timeline:

  * path.git-dir
  * path.common-dir
  * path.worktree
  * path.objects
  * path.hooks
  * path.index
  * path.grafts

If these keys are already added by the time I am selected, I would happily
focus on the other goals or the stretch goals.

Goal b: Remove USE_THE_REPOSITORY_VARIABLE
---------------------------------------------------------------------------
Removing this macro is a priority to ensure the new command is library-safe=
.
I have identified that `get_layout_bare(struct repository *repo UNUSED, ...=
)`
is the primary inhibitor in `builtin/repo.c`.

Currently, this function ignores its argument and uses the global
`is_bare_repository()` macro.

My implementation plan is as follows:
1.  Refactor `get_layout_bare` to drop the `UNUSED` tag and explicitly use
    its `repo` argument.
2.  Replace the global macro call with a check against `repo->worktree`.
    As defined in `repository.h`, a `NULL` value for `repo->worktree`
    indicates the absence of a working directory (i.e., a bare repository).
3.  This removes the dependency on global state without requiring changes t=
o
    the `struct repository` definition itself.

This change allows `builtin/repo.c` to drop the global state macro entirely=
,
making the command fully reentrant and library-safe.

Goal c: Implement Category-Based Querying (Structured Discovery)
----------------------------------------------------------------
The current implementation of `repo info` suffers from an "all-or-nothing"
usability problem. Users must either know the exact key name or dump the
entire configuration.

My proposal is to implement Prefix-Based Querying.

The internal `repo_info_fields` array is already structured for this:

    static const struct field repo_info_fields[] =3D {
        { "layout.bare", get_layout_bare },
        { "layout.shallow", get_layout_shallow },
        ...
    };

Since this array is lexicographically sorted, I can implement efficient
lookup without new data structures:

1.  Use `bsearch` to find the first key matching the requested prefix
    (e.g., `git repo info layout`).
2.  Iterate linearly from that point, printing keys as long as the prefix
    matches.
3.  Stop immediately when the prefix no longer matches.

Note: the next goal is a stretch goal. I have only added these goals
since I had already done the research and had to cut it off only
because of timeline.

Goal d: Repository Health Diagnostics and Metric Distributions
--------------------------------------------------------------
While 'git repo structure' recently gained the ability to surface basic
object counts and maximum sizes through Justin Tobler's recent patch
series (now in 'next'), the command still presents data as raw, isolated
extremes.

My goal is to evolve 'git repo structure' into a comprehensive diagnostic
tool by introducing metric distributions, packfile analysis, and actionable
health thresholds.

1. Object Size and Entry Distributions (Histograms):
   As discussed recently on the mailing list by Patrick Steinhardt and
   Junio C Hamano, extreme maximums are useful, but distributions provide
   the real picture of repository health. I will implement a streaming
   bucketing system during the object walk to track size distributions
   (e.g., blob sizes) and entry distributions (e.g., tree entry counts).
   These will be formatted into an optional ASCII bar chart output to
   visualize repository shape.

2. Packfile and Pathological Path Metrics:
   I will expand the traversal to capture metrics that directly impact
   performance and cross-platform compatibility:
     * Longest Delta Chains: Excessively long delta chains degrade packfile
       performance and clone times.
     * Maximum Path Depth & Length: Critical for identifying paths that
       silently break checkouts on systems with path-length limits
(e.g., Windows).

3. Threshold and Concern Levels:
   Currently, the command dumps data agnostically. Inspired by the 'level o=
f
   concern' logic in tools like 'git-sizer', I will introduce a mechanism
   to visually flag metrics that exceed typical Git "sweet spots"
   (e.g., flagging trees with >1000 entries, or >10 octopus merge parents).
   This transforms the command into an actionable CI/CD health-check tool.

4. Integration into the Query Architecture:
   I will ensure that both these new diagnostic metrics and the recently
   introduced ODB extremes (max parents, max tree entries) are seamlessly
   integrated into the prefix-based querying system proposed in Goal c,
   respecting the context-aware libification from Goal b.

Approach
--------
I understand the review cycle of Git cannot always be quick, therefore
my timeline is designed to buffer patch series and pivot between tasks
while waiting for reviews.

To maximize productivity while respecting Git's review cycles and
preventing merge conflicts, I am splitting the core work into two tracks:

i. Track - a (The Foundation): This will include Goal a (path.* keys)
   and Goal b (Libification). Completing path resolution and safely
   removing global state provides the clean foundation required for
   building a new querying API.
ii. Track - b (The API): This will include Goal c (Query Architecture).
   Development here will fully spin up once Track a is stabilized.

5. Timeline
-----------
I will dedicate 35-40 hours per week to this project. Because Git uses an
asynchronous mailing list review process, my timeline is designed to build
patch series with ample buffer room for design iterations.

Community Bonding Period (May 1 - May 24, 2026)
* Synchronize with Lucas Oshiro and mentors on the current state of 'path.*=
'
  architecture in the master branch.
* Finalize the exact list of remaining path keys needed.
* Publish my introductory GSoC blog post on jayatheerth.com/blogs.
* Pick up a small RFC question if we need globs in querying keys.


Phase 1: Track a Execution (May 25 =E2=80=93 July 10, 2026)
This phase focuses strictly on stabilizing Track a: Goal a (path.* keys)
and Goal b (Libification).

* Weeks 1 - 4 (May 25 =E2=80=93 June 21):
  - Work concurrently on Track a deliverables to build the command's founda=
tion.
  - Implement the core missing `path.*` keys locally (git-dir, common-dir,
    worktree, objects, hooks) and write comprehensive, OS-agnostic tests in=
 t/.
  - Refactor `get_layout_bare` to drop the UNUSED macro and completely remo=
ve
    `USE_THE_REPOSITORY_VARIABLE` from `builtin/repo.c`.
  - Milestone: Submit [PATCH v1] series for both Goal a (Paths) and Goal b
    (Libification).

* Weeks 5 - 7 (June 22 =E2=80=93 July 10):
  - Buffer time for asynchronous review cycles. Address mailing list feedba=
ck
    for Track a patches and submit subsequent versions ([PATCH v2], etc.).
  - Midterm Evaluation: Ensure Track a patch series are stabilized and
    queued in `next`.
  - Publish a detailed halfway-point blog post.

Phase 2: Track b Execution (July 11 =E2=80=93 August 21, 2026)
With Track a stabilizing, development shifts entirely to Goal c
(Query Architecture).

* Weeks 8 - 9 (July 11 =E2=80=93 July 24):
  - Using the feedback from the community bonding RFC, implement the
    query system.

* Weeks 10 - 11 (July 25 =E2=80=93 August 7):
  - Run the full test suite and ensure querying handles all edge cases.
  - Milestone: Submit [PATCH v1] encompassing the Goal c query architecture=
.

* Weeks 12 - 13 (August 8 =E2=80=93 August 21) [Buffer & Review Weeks]:
  - Dedicated time for addressing potentially complex architectural reviews=
 for
    the querying patch series.
  - Submit subsequent patch versions ([PATCH v2], [PATCH v3]).
  - Catch up on any unforeseen edge cases from previous weeks.

Phase 3: Final Handoff (August 22 =E2=80=93 August 31, 2026)
* Write the final project report and publish the concluding blog post.
* Submit the Final GSoC Evaluation.

5.1 Stretch Goals: Repository Structure Diagnostics
---------------------------------------------------
If the core `repo info` deliverables (Paths, Libification, and Querying)
are completed and merged ahead of schedule, I will pivot to extending the
`git repo structure` command (Goal d). I will prioritize implementing the
streaming bucketing system during the object walk to output ASCII histogram=
s
for Object Size and Tree Entry distributions.

6. Availability
---------------
This timeline aligns perfectly with my schedule. The project kicks off in M=
ay
and June during which I will be on summer vacation and can dedicate 35-50
hours a week. During July, I will transition into my final year of universi=
ty.
My academic schedule during this period is highly flexible.

7. Blogging
-----------
I have a domain setup at jayatheerth.com. As patches flow and the
project progresses,
I will host a dedicated endpoint at `/blogs` to provide comprehensive,
weekly and a phase wise coverage of my project.

8. Post GSoC
------------
I actively follow the mailing list and intend to continue contributing
bug fixes and enhancements. I would absolutely complete Goal d
in case no one has any reservations.
I have been a part of the Git community since 2025 and
hopefully will continue to be one for a long time.

Probably mentoring the next year GSoC applicants if that is a possibility.

--- End of Proposal ---



Regards,
- Jayatheerth


1 - https://jayatheerth.com/blogs/gsoc/jayatheerth_kulkarni_gsoc.pdf
2 - https://lore.kernel.org/git/CAOLa=3DZS6HtJrWd0kfsFASCbP2S9-MQq5Da3feA0W=
qY8ykZ0WTw@mail.gmail.com/T/#me6d18e613cdc75b1a0181252ae261e578a80bde9
