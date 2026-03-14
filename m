Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67BF42AA6
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 02:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773456887; cv=pass; b=qfQoSeHqzAcuuRto6hdRVIrz7VEw2nT8QuOUVy38BLbJYs6PA6JohdMn1DMKcgyAAk1YnsFPFEHtcZOtwNabUnYq3krViMAEuD6Uc9G06udV5mOn8hk9oU4Bi5SJAH2+7quBXThnu5OH8/YMMknSsdklnGijRwkl4r94ydwhbL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773456887; c=relaxed/simple;
	bh=+uXjSLsFMe4z4njZr5fUnyr0znz7+eMqujca0rIiPOU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=udiDKiBGbbLchdAtPMGgH/GyY0ktHANip+71xANYdjsDvV3nfqWYFpUoPUoQsr9b+PvfINAgsSQQoIEjI12h2yW0edX95gUz9Aiwwc67HhR7ifACiFe3ZCRjXvKqpT/bBJ8IC9OTbN85Hh4C/doNps5tKP5FJhKdPywUxugik2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1o85Pod; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1o85Pod"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b940a00415cso364550466b.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 19:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773456884; cv=none;
        d=google.com; s=arc-20240605;
        b=cRGUxow/nXiUpxRgTZasNeQvVM5jwC/6Cu3RhgvXgamNV+Tqfvs44vKhKeaAfEtx4+
         w3klR6VeEukmx/XO9+nZGGN//7CMbRQ4Qa1tdMN+KotfkVCW9dYfpNbDpHwbuKO2K+f9
         BSTjwk7lCwGB9Al9SmM4r3XjhdKW1vHuxo7X03di7+3BY/WtosY5QQ1r4bsknO0qR37S
         pA8QibxO3YcOqdIPRsa+tQorYJWniDsZTVc3lmRfnWRhjqa3yyY1C+lh1Qay4uvYApO0
         3bmWnGe7ho7hk76A0ahVuvkxLnn4FRtDFstxlnvqUhriNeAEQISWRVd7qRGQetZ95x1F
         FIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=SQZUMjrL01h18zvSiDhYg0lyPB6QPa8d6HTIYLY4goc=;
        fh=0fSz9vZj0h+Ubr7tMy7ubdifiIwSAoX2GqtHaaLt0dc=;
        b=UlmlaxnTZvbbjy4KCE0nVsN6pkeclTBRTuQj0Rqw5EG7K7grEIjMjAIZ2Hc0PG7+Om
         BLsFHKT18lsW0gJmQjdN9RqE1qZw9j/gYrsv/CYTVS63P4Q6R+4V5j96Fy8fdVFceWY4
         JqlFLEU1atHB4deUP+NqfY39ORu6GVoGmIjPKWDZJ5ylOZCwhvuc03jEplX4GHQf9A1A
         0Fxfyi9koxL3NM793AsPA0uPG1JA4tluCaqrIfho42Y8sINBZVL2MTQo1bWbOr0vB8C5
         kVMXinSZYT0pY+sNtVCCx40adFdiCOa8wQeKqDp0pGFoRVQ7lFDpLK4DFVs7qG8a7Yx3
         cESw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773456884; x=1774061684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQZUMjrL01h18zvSiDhYg0lyPB6QPa8d6HTIYLY4goc=;
        b=j1o85PodWS05egOGUrJiTierVbizPpOj39o43MavDAZAbYHv1R6SfqvPUhfWYUMnU/
         xY24ElAFDdRHMlCtNVMRoQMFarnUpqsMTOj8q380nATsMw1Smojl/4bIdtDUiIsdLnFK
         ltPY34prslQaH5NtQ+FaqoZgs2M08MmJQB1zeOlfCJ3QxyobcHiNwdTuIARqycZg1DU2
         rpbuJu889rRAq7v8c0kvR2AdZ+cARLaoFHC3Q+JXMWg0F5k2nmEq8i+mN7oO0H8vwUPS
         HgNIkMWDotESzdOb10lf98w/fVX1zeunBSkEHyZR2LbxBayE/9F8wZ62hNrkxjOwAUwl
         gHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773456884; x=1774061684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQZUMjrL01h18zvSiDhYg0lyPB6QPa8d6HTIYLY4goc=;
        b=PMIb33xorbQ8Ilsuz45LZrpCchqfKHaKi9OOg/DSCpqoaecJomqNxYcofgeJrdKuf7
         wQRWB3v5bJ/QCrP+WRJHw/cIVApHviO9tEwgMqMZkIvgiXVJ7M2ghXmhpZLL+gXtl+no
         bqBHJgav3mC1WKgpnInt+qmhQcBnlDz9S+XpTmr73RDs2iVID0igMmhhTW6yzY3fTGOf
         ssuOBYNsG0GojjHHx+WSrANYp6nZ+MIPARJvO18cSH+9bNyw6WUh1nJ3wIIPTGgvpqHL
         BWAPA5lnZQtUap1yQs5owhRoo646XqhN0u9zZZSGT6VerE0ifO/bIjyVYKyyttST84AB
         dAiw==
X-Gm-Message-State: AOJu0YzSjqxHyeAxtjvgNJefIZHhAcvbCLNQlxzpqTtdiVomjRGufMyL
	CFt4tdiDPVO+LRiXfbuE8WcYpktB9/0XGFEUTJlVifyyNrQBHk9B4jCHZjBxwQh7N4H4dlRx1vn
	eUfbLnZbLJf5sv8B2XVOeiX3jimYK7d6oKlR6uJ96
X-Gm-Gg: ATEYQzxuaiKryelzHi2lYHg9Do7oWWkNowoaEbIBKwi0mU5y+CUEzYs888T9SIUWc1x
	h59xxU6dn8qqEDTu3kf/9RQZBNh4SxhECNakeyx9KUp6tXSZeU0wvPFrvkp4sD/EyxWZtAOPHAI
	RyaRfDy1N1EhTWIUN4Hv7M+Wh83Cmm/IQF2TaacEZr9ak+Ty0KV54S6IHYefbAmvFl/dO8b5ulh
	I6HmU67FJHYdPDU66vXHo8XsE19qVUpzWgde+M37lUCHrQQxT362ttw8zpb3SDsQ3ARwZf7RhWw
	6wz/mG5AlHgR1xoFLSbRDCATegdwjZY60ZD3Qp4drb8RqKqF6DRBd1UkEKuQLQ2wcCadtwI=
X-Received: by 2002:a17:906:412:b0:b97:6385:6964 with SMTP id
 a640c23a62f3a-b9764fd8af6mr283309966b.1.1773456883511; Fri, 13 Mar 2026
 19:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mansi Singh <mansimaanu8627@gmail.com>
Date: Fri, 13 Mar 2026 19:54:32 -0700
X-Gm-Features: AaiRm530h0Wn01HhnDP2CrFuz1-fbzT237hl3enAZugRTogH9MJ-Q8fkX5VfrpI
Message-ID: <CAO_P5U3g_+RpnDUmEv_qX-3GVhpxLV97eMxP1apERc0KU_95tQ@mail.gmail.com>
Subject: [GSoC][PROPOSAL] Improve the new git repo command
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I am Mansi Singh, an M.S. student at Northeastern University Seattle.
I would like to share my proposal for the "Improve the new git repo
command" project under GSoC 2026. I would appreciate any feedback.

---

GSoC 2026 Proposal: Improve the new git repo command
Mansi Singh <mansimaanu8627@gmail.com>

=3D=3D 1. PERSONAL INFORMATION

* Name: Mansi Singh
* Email: mansimaanu8627@gmail.com
* GitHub: https://github.com/MansiSingh17
* Education: M.S. Information Systems, Northeastern University Seattle,
  GPA 4.0, Expected May 2027
* Timezone: PST (UTC-8)
* Availability: 40 hours/week, May through August 2026

=3D=3D 2. ABOUT ME

I have 3+ years of professional software development experience, most
recently at Nokia Solutions and Networks where I built AI-powered
monitoring tools for engineering teams. Before that, at Grant Thornton,
I built distributed audit automation platforms processing data across
thousands of projects. This background in building analytics and
diagnostics tools gives me direct context for why repository health
metrics matter to developers at scale.

=3D=3D 3. CONTRIBUTIONS TO GIT

=3D=3D=3D 3.1 Microproject: t7605 - Replace test -f with test_path_is_file

Replaced old-style path checks with modern test helpers in
t/t7605-merge-resolve.sh. Went through 3 review iterations responding
to feedback from Lucas Seiki Oshiro and name consistency feedback from
Junio C Hamano. The patch was integrated into seen.

  PR: https://github.com/gitgitgadget/git/pull/2050

=3D=3D=3D 3.2 repo: Remove redundant variable shadow in
        stats_table_print_structure

In stats_table_print_structure() inside builtin/repo.c, the variable
'entry' was declared at the top of the loop body and then redeclared
identically inside an if block. Removed the inner redeclaration.

  PR: https://github.com/gitgitgadget/git/pull/2062

=3D=3D=3D 3.3 t1900: Add tests for git repo structure subcommand

The t1900 test file had no tests for git repo structure at all. Added
4 tests covering the default, keyvalue, and nul output formats, plus
rejection of an unknown format.

  PR: https://github.com/gitgitgadget/git/pull/2064

=3D=3D 4. PROJECT DESCRIPTION

=3D=3D=3D 4.1 Scope Decision

After reading Kaartic Sivaraam's reply on March 10 advising applicants
that the repo info scope was under discussion and suggesting looking at
other areas, I examined the full project landscape carefully.

The path-related git repo info work is already well underway =E2=80=94 esla=
m
reda's patch series is at v6 and actively being reviewed. At the same
time, the ideas page explicitly lists git repo structure enhancements
("functionality from git-sizer could be added to provide more detailed
repository analysis") but nobody has started implementing them. That
is the gap I am proposing to fill.

=3D=3D=3D 4.2 The Gap: git repo structure vs git-sizer

git repo structure currently reports reference counts, object counts
by type, and inflated/disk sizes. Comparing against git-sizer reveals
three entire sections that are missing:

Missing: Biggest objects
  - objects.commits.max-size
  - objects.commits.max-parents
  - objects.trees.max-entries
  - objects.blobs.max-size

Missing: History structure
  - history.max-depth
  - history.max-tag-depth

Missing: Biggest checkout metrics
  - checkout.max-directories
  - checkout.max-path-depth
  - checkout.max-path-length
  - checkout.max-files
  - checkout.symlinks

=3D=3D 5. TECHNICAL PLAN

=3D=3D=3D 5.1 Phase 1: Biggest Objects Metrics

Extend the count_objects() callback in builtin/repo.c to track maximum
values in addition to totals. Add corresponding fields to struct
object_stats and struct object_values. Extend both table and keyvalue
output formatters.

=3D=3D=3D 5.2 Phase 2: History Structure Metrics

Implement maximum history depth using topological traversal with
memoization. Discuss performance trade-offs on the mailing list before
implementing. For repositories like linux.git these traversals can be
expensive, so I will place them behind --expensive if needed.

=3D=3D=3D 5.3 Phase 3: Biggest Checkout Metrics

Use the existing path-walk API (walk_objects_by_path) already called
in cmd_repo_structure(). Extend the path_fn callback to track tree
entry counts and path lengths during traversal.

=3D=3D=3D 5.4 Phase 4: Removing Global State (Stretch Goal)

builtin/repo.c uses USE_THE_REPOSITORY_VARIABLE. The most visible
instance is get_layout_bare() which marks its repo argument as UNUSED
and calls the global is_bare_repository() instead. I will implement
this as a stretch goal, coordinating with the ongoing libification
work in the community to avoid duplicating effort.

=3D=3D 6. TIMELINE

Community Bonding (May 1 - May 26):
  - Establish sync schedule with mentors
  - Initiate mailing list discussion on metric naming and priority
  - Study git-sizer implementation for algorithmic approaches
  - Finalize struct extensions needed

Phase 1: Biggest Objects (Weeks 1-4, May 27 - Jun 22):
  - Weeks 1-2: Extend structs, update count_objects() callback
  - Week 3: Extend formatters, write tests in t1900-repo-structure.sh
  - Week 4: Address review feedback

Phase 2: History Structure (Weeks 5-7, Jun 23 - Jul 12):
  - Week 5: Implement commit graph traversal for max-depth
  - Week 6: Implement max-tag-depth, add output and tests
  - Week 7: Midterm buffer, address feedback

Midterm goal: Phase 1 merged or in next. Phase 2 under review.

Phase 3: Biggest Checkouts (Weeks 8-10, Jul 15 - Aug 2):
  - Weeks 8-9: Extend path-walk callback
  - Week 10: Output formatters, tests, documentation

Weeks 11-12: Buffer and Finalization (Aug 3 - Aug 17):
  - Address remaining review feedback
  - Begin Phase 4 if time permits
  - Final documentation and GSoC report

=3D=3D 7. RISKS AND MITIGATIONS

Review cycles: Structured so Phase 1 completes early, giving maximum
time for iterations before midterm.

Performance: Will benchmark history traversal against linux.git and
use --expensive flag if needed.

Design disagreements: Will initiate naming and format discussions
during bonding period before writing any code.

=3D=3D 8. WHY I AM THE RIGHT PERSON

The git repo structure enhancements I am proposing are fundamentally
a repository analytics problem. At Nokia I built monitoring tools that
aggregate diagnostic metrics for engineering teams. At Grant Thornton
I built systems analyzing data across thousands of projects.

I have already studied builtin/repo.c, run both subcommands, identified
the gaps by comparing against git-sizer, and made three contributions
touching the repo codebase directly =E2=80=94 including tests specifically =
for
git repo structure, which is the subcommand I am proposing to enhance.

My microproject went through 3 review iterations in under 2 weeks and
was integrated into seen.

=3D=3D 9. REFERENCES

* GSoC 2026 ideas page: https://git.github.io/SoC-2026-Ideas/
* git-sizer: https://github.com/github/git-sizer
* Original git repo introduction:
  https://lore.kernel.org/git/20250610152117.14826-1-lucasseikioshiro@gmail=
.com/
* Microproject PR: https://github.com/gitgitgadget/git/pull/2050
* Variable shadow fix: https://github.com/gitgitgadget/git/pull/2062
* Structure tests: https://github.com/gitgitgadget/git/pull/2064

Regards,
Mansi
