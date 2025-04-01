Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CBCF4ED
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 01:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743471456; cv=none; b=dO/nZdfz0blQYYUQYVNdlt30trFgjyV326fWVpmbjZ9jY1wgIKp0kIM845k+fzgT6uu+4dRx5ATf0mfRTBqd6EblqOtm1FLhGySU9HJetI0Apmm9271VmDHz9+enKTNiGLJOLOSS5gpIAm6AMdgqXKPlf/mjuPt8miw40/uwH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743471456; c=relaxed/simple;
	bh=PFwLsI3yenW/VjEOA8IS3SSHCChGx27F+LI6F9vJiUI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l0ilKJeaZ3WnsUHrHHWm+sZSj18X/tqQuB5nlOzPqV+Ci4uQcOOp/k7ggc7z3TncMrE80zh3+n4a8iOvbZmUzT5G7MdOnl1+0oVKv+0Nj/bxSOOEcGdxCYWm3BD5DE9Kboq98qs4BobMw4BoEJa18L7l+YYUA1Ag/x8MuRUapq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSv0RB4D; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSv0RB4D"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso6314778a91.1
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 18:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743471453; x=1744076253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5k4h+Jilsrj3sE/VQVhF0jnaGEfUUgF1p5278daJlcM=;
        b=ZSv0RB4DpCwLc6yfgEQd9z4jrRQW0ZHAcQpqfHQfIl7h3+JH1uajUqsJhcCdWI1UJu
         NlPyIY+wSWLFPBQcYLy/lfrhb0JqPIvmajTMMDGq2A3gSIIzbHTyC9icSM/EWWa4yR1J
         gU4comE00TsIHkENUDuhTqCzqDFq4d6ZouENClbla28SH8EjbFyA23zWBPVzR6t0w1lp
         gd0KFfxAd61ZF+TAWUhiAiMnr6vqsDik8Jh7dlKMuGUoUeLCdaV4dDv0YCnuUKOFm2Ac
         n21FsmkMJo9ljZp8XhsrrDlPf0HixrFobHclpxk4i68XBKkXErBqoeWpLBt/Dw2aoQcx
         YYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743471453; x=1744076253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k4h+Jilsrj3sE/VQVhF0jnaGEfUUgF1p5278daJlcM=;
        b=h3ZYLoAPp4BrPpZawmlOJ6PR42VfksL/6fdnFXkc5K+EUtdGeXfn8aeqCXBAuzsUY7
         ZgJeW0WzjR8KIaLU4Pzr2wYUOTZe+FiJ0Y8ryyte74LQnFme0vR7jjVv+OpdMr2SlJTa
         Avp6XwrsrHc2XUhkPSDB69Qs++qTr768FAFtRfZ/dPRf/S0E+RkWFfqSaRz1rYCiVK8h
         UwcFI8H1v3aevQ5jUE4M0aFOGsLK6J5CC2iTcF0vYSKRd8hVJpVAnaWnbChPuE7g6wrQ
         6cRua9IIB0wUoE3Ob7G36DhCUZHYN0FlA4TM2V6AiuSBE/i2yI739cVDtSmjjvuzuljp
         XirQ==
X-Gm-Message-State: AOJu0YxGyPFv7tZ1CfikZUIELbNwQghDW/gsVHoSj3iOAntu8sEtGonO
	gvg4u1iPOUGPBTFeWh+uqd1hi2oVvuUpkj18kHHaANWL/jqevxqcw2OCWZ1YDDcc720g9duVuoB
	5BZ3gBfPp+FpgRXZQ6kJXd/7whIvXxBB9
X-Gm-Gg: ASbGncviZywnSCVamF/Aqt+odHnU14nbeF2kzP/58dM5SW924Xnv0kU2e1j5HNQ5e6e
	YYwqTrBPhmDW2xtZnj+RjvNzlBMeKiKmL88ZZnChgwwziYBt+bMeU9t43tjzm4aAkFQmHFMmlbF
	SdLB4/l0ouRljaoVadvZoArBzOzg==
X-Google-Smtp-Source: AGHT+IEnnw4fgH35fL4gDSzI6Z8QdQPYSQLUtY4WN3xS+IiV8/sYYrZmMtOn4KuR3/9+q5N4eCq+ZCKOfmldj+ToEww=
X-Received: by 2002:a17:90b:1e11:b0:2f7:4cce:ae37 with SMTP id
 98e67ed59e1d1-305320b0883mr17222128a91.18.1743471452730; Mon, 31 Mar 2025
 18:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Meet Soni <meetsoni3017@gmail.com>
Date: Tue, 1 Apr 2025 07:07:21 +0530
X-Gm-Features: AQ5f1JqCfL03-Ihd5Y9PYKgKcT8IZcrAggm0Mmg8Uc2RBcz8mKtbWi69S8KBxyA
Message-ID: <CAPhwyn3McL-2rwjkexsDUWqxt0Kr4UsDVy_G=s1DmKhrw5BZ-A@mail.gmail.com>
Subject: [GSoC][Proposal RFC] Consolidate ref-related functionality into git-refs
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, christian.couder@gmail.com, shejialuo@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,
This is my proposal for "Consolidate ref-related functionality into
git-refs" in Google Summer of Code 2025. The Doc version:
https://docs.google.com/document/d/1Nfg6Dner1eU10LIlhkSJ5-N31Y6QuWj8bad_bAi=
MBa8/edit?usp=3Dsharing

I'd appreciate any feedback on this.

Thanks,
Meet

---------8<----------8<----------8<----------8<----------8<----------8<----=
------8<----------8<
GSoC 2025 @ Git | Meet Soni
Consolidate ref-related functionality into git-refs
---------------------------------------------------


Personal Information:
---------------------
Name: Meet Soni
E-mail: meetsoni3017@gmail.com
Mobile No.: +91 9054520887

Education: Silver Oak University, Gujarat, India
Year: III/IV
Degree: Bachelors in Computer Engineering

Time-Zone: UTC + 5:30 (IST)
GitHub: github.com/inosmeet
Blog: inosmeet.github.io
LinkedIn: https://www.linkedin.com/in/meet-soni-4230701b9/


Pre-GSoC:
---------

I got into Git=E2=80=99s codebase in November 2024 by reviewing various doc=
umentations,
previous patches and began contributing in mid-December 2024.

Following is the list of contributions that I have made:

* [PATCH v3] t7611: replace test -f with test_path_is* helpers
  Status: Merged into master
  Merge commit:cef3d4a89f8d21fae6669822cbb540927020d93b
  Description:
    This patch is my first contribution to fulfill microproject criteria. I=
t
    improves test t7611-merge-abort.sh by converting old style path
checks to use
    modern helper functions in order to achieve better debuggability.
  Mailing list thread:
    https://lore.kernel.org/git/20241227105345.10184-1-meetsoni3017@gmail.c=
om/

* [GSoC][PATCH v4 0/5] refspec: centralize refspec-related logic
  Status: Merged into master
  Merge Commit: e4f6ab008522c5ad386485720770b8d03b4fb880
  Description:
    This patch series addresses a design inconsistency noted by Patrick, wh=
ere
    the refspec-related logic was scattered across multiple headers, by ren=
aming
    and relocating this logic for improved cohesion. In particular, functio=
ns
    such as omit_name_by_refspec() have been renamed to better reflect thei=
r
    intended functionality, and the core refspec-related routines have been
    moved from remote.c into a dedicated refspec.c file, ensuring a clear
    separation of concerns and more maintainable code.
  Mailing list thread:
    https://lore.kernel.org/git/20250204040558.34766-1-meetsoni3017@gmail.c=
om/

* [GSoC][PATCH v2] remote: relocate valid_remote_name
  Status: Merged into master
  Merge Commit: f21ea69d945f958704f2fe143c2638ecae6e0d12
  Description:
    This patch, prompted by Junio's feedback in my previous patch series,
    moves the valid_remote_name() function from refspec to remote to
    centralize functionality related to remote repositories, thereby
    maintaining a clearer separation of concerns.
  Mailing list thread:
    https://lore.kernel.org/git/20250204142852.13035-1-meetsoni3017@gmail.c=
om

* [GSoC][PATCH v2] merge-recursive: optimize time complexity for process_re=
names
  Status: Merged into master
  Merge Commit: b07dd9078b8ba5f3b7f5c88f84f7ee9c34fa65e1
  Description:
    This patch reduces time complexity for process_renames() from O(n^2) to
    O(n log n) when building a sorted string_list by constructing it unsort=
ed
    and sorting it afterward, thereby addressing a previously noted TODO
    comment.
  Mailing list thread:
    https://lore.kernel.org/git/20250214044129.15282-1-meetsoni3017@gmail.c=
om/

* [GSoC][PATCH v2] refspec: clarify function naming and documentation
  Status: Merged into master
  Merge Commit: 044b6f04f23d6c7e3c3750c9829db96b71470874
  Description:
    This patch renames a function and its parameters to improve clarity and
    consistency in refspec matching, addressing earlier feedback from Junio=
 to
    resolve documentation ambiguities and enhance overall code readability.
  Mailing list thread:
    https://lore.kernel.org/git/20250215084539.73799-1-meetsoni3017@gmail.c=
om

* [GSoC PATCH v5 0/3] reftable: return proper error codes from block_writer=
_add
  Status: Will merge to next (Currently approved and in seen)
  Description:
    This patch series refines error handling by eliminating assumptions abo=
ut
    the error codes returned by block_writer_add(), a change motivated by a
    TODO comment to ensure more robust and flexible behavior.
  Mailing list thread:
    https://lore.kernel.org/git/20250319152927.1263033-1-meetsoni3017@gmail=
.com

* [GSoC][RFC PATCH] show-branch: use commit-slab for flag storage
  Status: On-hold from my side
  Description:
    This patch attempts to replace direct access to commit->object.flags wi=
th
    a commit-slab mechanism by introducing get_commit_flags() and
    set_commit_flags() for flag management and ensuring the canonical
    UNINTERESTING definition is used. Initially prompted by a TODO comment,
    review feedback broadened the scope to address several additional aspec=
ts
    that were new to me; while further investigating these changes, I was
    selected for LFX mentorship, which resulted in increased time constrain=
ts
    and so I had to temporarily deprioritise further refinements -- though =
I
    plan to continue advancing this work in the near future.
  Mailing list thread:
    https://lore.kernel.org/git/20250217055049.9217-1-meetsoni3017@gmail.co=
m/

* [Practice PATCH] refs: add list subcommand
  Status: As PR on my fork
  Description:
    As it would=E2=80=99ve been inappropriate to send this patch to the mai=
ling list
    without getting selected in GSoC, I decided to push it to my fork in or=
der
    to showcase my abilities and get a better understanding of the project
    scope by this proof-of-concept type of practice patch. This will be use=
d
    as a reference ahead.
  PR link:
    https://github.com/inosmeet/git/pull/1

* Reviewed fellow contributors=E2=80=99 patches:
  Mailing list threads:
  * https://lore.kernel.org/git/CAPhwyn0tGHuX_Gh=3Drno9wj8fLb6zG4M3QAZyQDQ8=
qZyE+Uyg_Q@mail.gmail.com/
  * https://lore.kernel.org/git/CAPhwyn2qeN_tZOEyhD6=3DTLEdQbcCEV1thxpDwNzA=
pqaET0+5og@mail.gmail.com/
  * https://lore.kernel.org/git/CAPhwyn03LbYexkk4YsaC6F2H_m6o73fU6aQ-c0urfd=
AsyEqPMg@mail.gmail.com/
  * https://lore.kernel.org/git/CAPhwyn0Sq0hDktPtf53Qs6LKwNsmn6yXuVyEfcYzyX=
K4yjd7HA@mail.gmail.com/


The Project:
------------
Currently, Git=E2=80=99s reference management is distributed among several =
commands,
including git update-ref, git show-ref, git for-each-ref, git pack-refs, gi=
t
symbolic-ref and git check-ref-format. The functionality of these commands =
is
implemented using the functions from refs.[c|h]

This project aims to streamline reference management in Git by consolidatin=
g
functionality currently spread across multiple commands into a single git-r=
efs
command. The project-idea page specifically mentions update-ref, show-ref,
for-each-ref, and pack-refs; therefore, this project will initially focus o=
n
these four commands, with the remaining ones slated as stretch goals, more =
on
that below.

The updated git refs command will offer subcommands to list, retrieve,
verify/check existence, write, and optimise references.

Since the project involves developing new subcommands, selecting appropriat=
e
names and addressing design considerations will be one of its primary
challenges.


The Plan:
---------
To tackle this project, the consolidation of each command will be divided i=
nto
the following steps:

    1. Create subcommands:
      Develop the actual subcommand under  the refs
command(builtin/refs file) by
      leveraging core functions from the refs module. The implementation wi=
ll
      mimic the logic of the legacy commands to maintain consistency
with existing
      behavior.
    2. Tests:
      Develop comprehensive tests to verify that the new subcommands functi=
on as
      expected. This will involve creating a range of tests, including shel=
l
      scripts and/or unit tests located in the t/ directory. For the existi=
ng
      tests covering the legacy commands targeted for consolidation, the pl=
an is
      to retain them initially=E2=80=94even if this results in some duplica=
tion=E2=80=94with the
      intention of deprecating them gradually over time.
    3. Update old usage:
      Modify all call sites of the legacy commands to invoke the newly crea=
ted
      subcommands, ensuring a smooth transition and seamless integration wi=
th
      the consolidated command.
    4. Documentation:
      Develop comprehensive documentation for the newly implemented
subcommands to
      ensure clear guidance for users and maintainers.


Command mapping and naming:
---------------------------

I have taken reference for potential names for these subcommands from Patri=
ck=E2=80=99s
suggestion (https://gitlab.com/gitlab-org/git/-/issues/330):

  # Replaces git-show-ref(1) and git-for-each-ref(1).
  $ git refs list

  # Replaces `git show-ref --exists`.
  $ git refs exist

  # Replaces `git show-ref --verify <ref>`.
  $ git refs show

  # Replaces git-symbolic-ref(1) to show a ref.
  $ git refs resolve

  # Replaces git-pack-ref(1).
  $ git refs pack

  # Replaces git-update-ref(1).
  $ git refs write

  # Replaces git-check-ref-format(1).
  $ git refs check-format

Below is a list of the commands along with their associated subcommands/fla=
gs
that need to be considered for consolidation under this project:

git show-ref -> git refs list
Used to list references in a local repository.
* abbrev
* branches
* tags
* exists
* verify
* exclude-existing
* dereference
* head
* hash
* quiet


git update-ref -> git refs update/write
Used to update the object name stored in a ref safely.
Subcommands:
* [symref-]update
* [symref-]create
* [symref-]delete
* [symref-]verify
* option
* start
* prepare
* commit
* Abort
Options/Flags:
* --stdin
* -m
* -d
* --no-deref
* --create-reflog


git for-each-ref -> git refs list
Used to output information on each ref, quite similar to show-ref.
* --count
* --shell|--perl|--python|--tcl
* --sort
* --format
* --include-root-refs
* --points-at
* --merged|--no-merged
* --contains|--no-contains
* --exclude
* --ignore-case
* --omit-empty


git pack-refs -> git refs pack
Used to pack heads and tags for efficient repository access.
* --all
* --no-prune
* --auto
* --include
* --exclude


Options/Config sharing:
-----------------------
For sharing configuration options, I propose a structure-based approach tha=
t
centralizes common options while grouping subcommand-specific settings into
dedicated substructures. This design embeds common options directly in the
top-level configuration structure (struct refs_options), and then uses sepa=
rate
structures (such as struct list_options) to encapsulate options unique to e=
ach
subcommand.

Below is a representative code snippet illustrating this approach:

struct refs_options {
        ...
        // ... Common Options =E2=80=A6

        struct list_options list_opts;
             struct exist_options exist_opts;

        // ... Similar fields for other subcommands ...
        ...
};

struct list_options {
     // ... options specific to 'list' subcommand ...
};


struct exist_options {
     // ... options specific to 'exist' subcommand ...
};


Since we plan to maintain the legacy commands for the foreseeable future, w=
e
must ensure backward compatibility while developing these new subcommands. =
Going
through this I wonder if we should make the commands as a standalone
entity, like
a library. However, it needs to be thoroughly discussed.

While studying these commands, I thought why not try out one of them to bet=
ter
understand the project=E2=80=99s requirements, scope and get a firmer grip =
on the
codebase. So, I developed a reference implementation of git refs list that
mimics the behaviour of git show-ref with [--head], [--branches|--heads] an=
d
[--tag] flags, which can be found (https://github.com/inosmeet/git/pull/1).

Although this reference implementation is still a work in progress and not =
yet
ready for merging into master, it demonstrates my understanding of navigati=
ng
the Git codebase and the process of creating commands and subcommands. More
importantly, it indicates my ability to execute this project effectively.


Timeline:
---------
Pre-GSoC (Until May 8):
* Continue to work on different things like the pending WIP patch that I ha=
ve.
  Be engaged/involved in the community.

Community Bonding (May 8 - June 1):
* Talk with mentors and discuss potential names for the new subcommands and
  interface design. Start the consolidation early with mentors=E2=80=99 per=
mission.

Phase I (June 2 - 29 June):
* Consolidate update-ref command along with subcommands/flags to refs=E2=80=
=A6 command.

Phase II (30 June - 27 July):
* Consolidate for-each-ref command along with subcommands/flags to refs=E2=
=80=A6
  command.

Phase III (28 July - 24 August):
* Consolidate show-ref and pack-refs command along with their subcommands/f=
lags
  to refs=E2=80=A6 command.

Final Week:
* Some final touches. Make a final report about the work accomplished and
  outline future work.

I have not allocated separate timeline slots for tests and documentation, a=
s
these will be integrated into the patches that introduce the new subcommand=
s.

I think if permitted to start early, I can consolidate one more command wit=
hin
the GSoC period.


Related previous work:
----------------------

git-switch Command:
https://github.com/git/git/commit/d787d311
Mailing list thread:
https://lore.kernel.org/git/20190130094831.10420-1-pclouds@gmail.com/


git-restore Command:
https://github.com/git/git/commit/46e91b663badd99b3807ab34decfd32f3cbf15e7
Mailing list thread:
https://lore.kernel.org/git/20190308101655.9767-2-pclouds@gmail.com/


Stretch goals:
--------------

If the consolidation of the 4 commands is completed ahead of schedule, I wo=
uld
like to consolidate the remaining commands (these can be done even after th=
e
GSoC period). These commands include git symbolic-ref and git check-ref-for=
mat.

List of commands along with their subcommands/flags that needs to be consid=
ered
for consolidation:

git symbolic-ref -> git refs resolve
Used for reading or updating symbolic references.
* -m
* --delete
* --quiet
* --short
* --recurse | --no-recurse


git check-ref-format -> git refs check-format
Used for validating whether a given reference adheres to Git=E2=80=99s nami=
ng
conventions
for references.
* --[no-]allow-onelevel
* --normalize
* --refspec-pattern
* --branch


Blogging:
---------

Blogging is a good way to foster transparency and community engagement in
open-source projects. By sharing insights, challenges, and milestones, blog
posts not only document the project=E2=80=99s progress but also create oppo=
rtunities for
feedback and collaboration from the broader community.

In my project, I plan to commit to bi-weekly blog posts. These updates will
detail my progress, share lessons learned, and highlight any obstacles
encountered along the way, ensuring that the development process remains op=
en
and interactive.

The blog will be at: https://inosmeet.github.io


Post-GSoC:
----------

Over the past three months, the Git community has been an invaluable source=
 of
support and learning, significantly contributing to my growth as a develope=
r.
Even after the summer program, I intend to stay active in the mailing list =
and
continue contributing meaningful patches. I'm thinking of consolidating
remaining commands after GSoC is over. I've also been following the early
efforts to integrate Rust components into Git via libgit-sys, and I would b=
e
excited to contribute to that initiative as it matures.

Lastly, if given the opportunity, I would be delighted to mentor new
contributors and help the community grow even further.


Some credits to myself:
-----------------------

I am an open source enthusiast, I have contributed to some other open-sourc=
e
projects as well. I was selected as a GSoC 2024 mentee for the Python Softw=
are
Foundation=E2=80=99s cve-bin-tool sub-organization where I worked on improv=
ing Product
mapping using PURLs (Package URLs).

More recently, I got selected as a LFX 2025 term-1 mentee for Cloud Native
Computing Foundation=E2=80=99s Microcks sub-organization. Here I=E2=80=99m =
working on improving
Microcks=E2=80=99 delivery and validation using GitHub Actions CI deploymen=
t tests.

These opportunities have given me valuable initial exposure to open source
practices and community collaboration, and I=E2=80=99m excited to further b=
uild my
skills while contributing fresh ideas to this project.

Blogs for both my GSoC as well as LFX journey can be found at my blog site:
https://inosmeet.github.io/posts


Availability:
-------------

My current semester ends on 24th April and my exam tentatively on 15th May,
leaving me enough time to prepare for my GSoC project. If I am selected, I =
shall
be able to work five days per week, 7 - 8 hours per day, dedicating around =
35-40
hrs a week on the project.

The difficulty level of this project is medium, and the expected project si=
ze is
estimated to require about 350 hours of work. Based on my proposed commitme=
nt of
35-40 hours per week, this project aligns with my availability and intended
workload for the GSoC period, ensuring that I have sufficient time to
accommodate any unforeseen circumstances that may arise during the project.

---
Thank you for considering my application. I am excited about the possibilit=
y of
contributing to this project and learning from the mentorship experience.

Thanks & Regards,
Meet
