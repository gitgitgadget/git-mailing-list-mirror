Received: from sonic312-21.consmr.mail.bf2.yahoo.com (sonic312-21.consmr.mail.bf2.yahoo.com [74.6.128.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C662233F8C2
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864507; cv=none; b=ebbTp8OEJt9VEaM4h924tfN09egDbqoppL2OxtBQaJKc7uTrgC1Di0tKPXGA6qw9++o7jGtm7Puq54QATug3DP8gnV1QtpofKnLmoKdm1PWoZRQl21PavJMfq1KNrWp7pqPyrrXP8o6H8G9XUbMqZTiJdtGbwyquQCGNQRIFrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864507; c=relaxed/simple;
	bh=aWKI82tCc/xxaj7UTI58/w2NVwrHbPZwp/lEmgY6J8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W12UaWSf/MW2xkD+4BRS8Uaes8B55kdvuNejZ11ZqrFbhovJJbbL20xvNNpHwXkeoOYm3av7M0SRe3Z3Dv2w6cJ7wGP6PA8/zwLQa/wmRjjOg6sGEhAOUcFsPpuT6GsXmEtzooHHWDZZvvuhZvC3YzsjKZIEx88k8K5wtV2IOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Kb3lnSnP; arc=none smtp.client-ip=74.6.128.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Kb3lnSnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773864499; bh=p6OfiOPjIgBZpxJ3Aq009xC5ij6invgeF18X/cpXm1Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Kb3lnSnPaYg5+K+lrkNbLDEtCRTMRIepc5gT7+wKDtj2LS3H8Eh0Xh85rF0FoE1CDvebRrHF9Eyn4VfVaDzLHfHN+8d088hDqP/iTavh7EHBjiw+r33s2ueF+3QHD3C1uT3we8caKx9JdtLg9hFQjZ0MML86fGG+SnQy7k/Gzwc2z5GXADLkM6MFGpFTOZRXOhQymg2pkbiD3f74o/LG86I7q1iTc78ITwLN6MQFkc5XtVxGSsCFo99+D8znQCDbwra1rC9w43ZIdETKeDcaIENh5HNPKZzqrSz/8kyAcbiVzzIIrlbwgEk689HE3CVofSX9foZzGGwn0OQuGhmjGg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773864499; bh=Cl/txBDUwGXeRDwWq7pdFkHetjpxUrKXbgkHukX2nEI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cZErUjUoXXAJgYIN5ecTYN9NEDkWaEli/VOqNp/DR2TWtawpctRhDPzKso9ZFXS2VwYmZ5jb3YdBnVypB6B6xTDfFKd3DGMPRKj8oipmQS/Y9YOFw3xrrslkaN1XMHrI2C/Y2IG/+TGY6+80yY/N6pVeey0hIQXQInngCgntnc1vJGnPmNJODby2QMmluHEQTIqUkxN+34/7S7M5OLpHRo8/ejgmUXJpc3BmL/YfG1ZUlH7ewMmca5/ATtvlUDcrgSZ6Q5zMJYoQIEjCjIXoKWHrDpX/XuTEu8d/8+m1RJIye3msQ63YApyH79XKiZW0tlFbUlgtahNJJy9nPgIz6Q==
X-YMail-OSG: nCGzTogVM1mDPTcSWCwfK6tyyV9_8mCH6UdLmDlpVfnbR.hWTZ2aO2y3CarXIyF
 xhrYIvBoc6x.0H72UwOwiMTuypq1h4leYBYp.QpiUdo6hQC.dbdvnV49RkKgvKOs0a11HsqwrbBX
 GzGg1EDyKubt9CJhvSASLY6Y.JOOTDRx.edhosxW73Pj.RWrwIUYyLB2Y85bf3CxZ3w3CR0uprp.
 9szB6nAcCJij7tETZlDxHxRcP2q_1FOHe6uXES9A0JNfjJtAbbl9uMnxWXYcmc_mfhEkm1ai9bJp
 6ABWRYhq0je7SagCK8HeBmmc1ExsaCHdyozxupK3Vx86na7JAmJPUks7tcQlVDYSV2NoO4BqfXvo
 dLfF9E1W5TIFFHylcq8qpnKd3T8dkA77l3KIipJaBLkwqYasOYMm3yzi6nKZgVAD5Ok30va7W6aU
 epEXFq1atdO76tsGf4EQuskJsW5qCAleUPgBAKkxY9y6siMtuO_dorjBKy4OyjgoJxd5JLzPFjeS
 8PcXtOMPNzkQ8Rl5Q.N.a10Ra7iqCCXaIcQ_w6RCtFnKf0vNHoJ5Cg9ow2jQJdan9WbNTg8HBwy8
 mg_2Qnt.Uaru1LYJy1rry7ktfxmul1Xo6JWnSDlXwf3Yh07wMLJvyIz4KUHyhi469dPtyf_H98Nc
 DZP0_c5Pu6uNWMyF2.2BHIzJpakeinc56mW4K9d9pY5BZ3WyDg6j6qc4i79ArmnXpKFsbqwxIbZU
 nuDbYlrpuCI9c8T8mKDWFujqenR8_aD5iKpnLNqq3F.2DcOS0X7vsKkZNf8.Dls_eImpndLdqcvp
 2gcIrkUvpWLx4uWAokvzzzUJgnoFJpoQ_SQlEgbzwBgkYdF4WWbxo7Q.0anOBtws2U4HHpH.u2Uq
 2iNeE8E5lRjjFmtKsuE05_9tGJgIajoEOIsXrgnoekh.oHJf2oQOan4m47j6l21pH0epbBDmk2oB
 mHnZyWU3EuyrHhbOvj7dg3VudVvgfYO4gLZscHfRO9cpw.nseI.LEjde_tnpiewQOKXQ2TZ5PibI
 Y7_XIdzijNRVcGULrmW4FMXmch9mgcAjIxO0K.WP8pGZUEXq.fjJCAPC.VU7GeF5zp_eKDWYnFKW
 _bDuE2lMI9mgP3vz27xd74zoppzetMPtxz9TvlC0dXrPf8AxOX1k0IBzOcwkAHgoE7QkDwVMZRhH
 lS4x1PEvVHPw6VdNRws1z9_WkinLQo59SBh_0IqbtJwsk8UFopuS8unh93_3yz6RH7XuC4Tl2niV
 BSyJdigbTmB7pn.OH9xz.iM9ZFDkGmfS_3eUIdOHT7YIqWfJoEVqgiVUykgnZ4zVHL32f.kL8Ls3
 etlvYbBClve54vpCByPPx6BNqyDi1QIoaX6hKRlAjisVzletsP4iocgFOvanNikbK2TwXklUAkBI
 PPWFUehjsI4lZLQBAjHQAXNSekD45o2wSR_2aD6w2CA4qz0TUVBxfsdtF2v1DZaSfOyqhPg1UkZW
 o5FIQyB1f87sAZpwa.WYM_qDsCPrm4DIkkkuB1h1y6wcC9_Aod8zukxcqvfHC35kEpJ.bRHlSxzr
 MbqWpucygWiln8oqzKSl7.HPQtiNNRuKBftsFhCBxC7LS89rKPL13HOjIZ4edUkOix0aFaIk4t4X
 FbU0AkLGOBo6h5hPevuXlIEjlfVdl.Ik2pxAV8sR4RKU0s7rPU8KaLGZAqu89jdo2B9DPSfrpmi_
 IjWahRuaz2tuU7l_CIERxCICDv9chrFibLrCA83c0EUTgpHfhLHloAbU430LYdx1uVacnYYPG6Sz
 SQRF1JTx4r6Ek3DBVlyUJo.QHqsq5vzth3yGh4uSRTTbi2IXVPqMFojG.EAookQp_RQprgbD0Hu2
 Lohf5pZTEettwbsL6w2wa3.Fz.xDk0yVgT4SXBO14S7fn_14UH0ukc3tu81VmqNpkQu2Ek33w9RI
 ZfWPLGrBTFpTovPZb4vRRYklbHydgSogIR0qRfvHz3HlYJITNkYmlUbtdBgXDww8zNCZ_e78.I7D
 1jSSQvflNGt0Wo3SNo3wm_mn1g0lUtq8phQWVM6FK8S96_q1dX3EDbarRI2bAPnxBui76zbFWXEd
 TcLxjiCGVcmXSvD9Sl2idrehebc9vixOKVBMmbVvihp1sdNrVkUjeMTmuei31IIHfaGskaT1TJ7i
 O_jz8g3MvpLJcyYSJ5zBSx8uOovrMhTrNusW7iEXlcGHii6Z_QmXP8XAC04VFKGRorT.DmRCzUK7
 mUb4mDxCWb9YA5GTHx_sWUNnB77ZDzYvX2NdON7OpfBQZCPpXai7_RdtavKJkKUj5OAO7r8SaXfx
 ebt1Oi2VXlroYZMMvEQvQv.7nQfFVEuAzi4AxTgY-
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: e7872827-fc8c-45e2-ba36-862e80a8368d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Wed, 18 Mar 2026 20:08:19 +0000
Received: by hermes--production-bf1-697f88457-7d7nf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1ccb3e1e23be3199390f25744e296ce5;
          Wed, 18 Mar 2026 20:08:17 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	jerrywang183@yahoo.com
Subject: [GSoC proposal v3][RFC] Improve the new git repo command
Date: Wed, 18 Mar 2026 16:08:16 -0400
Message-ID: <20260318200816.31430-1-jerrywang183@yahoo.com>
In-Reply-To: <CAOLa=ZQ7AMUb72N-0Z-h09KneE+ASuXt=BUOmO9Bzp4y6w6XyQ@mail.gmail.com>
References: <CAOLa=ZQ7AMUb72N-0Z-h09KneE+ASuXt=BUOmO9Bzp4y6w6XyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25380 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi all,

This is v3 of my proposal draft for the "Improve the new git repo
command" project. I am including the full draft inline below for
convenience.

In this revision, I tried to make the scope more realistic and better
aligned with the current public discussion around `git repo info`. In
particular, I:

- revised the proposal so it does not assume that path-related `git repo
  info` work is starting from scratch
- reframed the project around integration, testing, repository-aware
  cleanup, and any still-open metadata gaps
- added my more recent Git contributions
- added a short "immediate next steps" section describing the kind of
  `git repo` patch I want to work on next before the coding period

I would appreciate any feedback from mentors and reviewers on whether
this revised framing is closer to the right direction.

Thanks for any feedback,
Jialong


Improve the git repo command

Name
Jialong Wang

Email
jerrywang183@yahoo.com

Preferred project size
175 hours

About me

My name is Jialong Wang, and I plan to apply to Git for GSoC 2026.

I have been getting familiar with Git's development workflow by building
Git from source, reading the contribution documents, and working on
patches through the mailing list. My initial microproject focused on
improving corrupt patch location reporting in `git apply` and `git am`.
That work went through mailing-list review, including comments from
Karthik Nayak and Junio C Hamano, and gave me direct experience with
rerolling patches, updating tests, and using CI to catch gaps I had
missed locally.

Since then, I have continued contributing small Git patches and
follow-up work instead of stopping after the microproject. My recent
contributions include:

1. an initial patch series to report the location of corrupt patches
   more clearly
2. a follow-up patch to report input locations in header parsing errors
   in `apply.c`
3. a follow-up patch to report input locations in binary and garbage
   patch error paths in `apply.c`
4. `t2203: avoid suppressing git status exit code`
5. `object-name: turn INTERPRET_BRANCH_* constants into enum values`

This has helped me get comfortable with Git's normal workflow of
starting with a small change, responding to review, rerolling
appropriately, and then continuing with logically related follow-up
work.

Project summary

I would like to work on improving the new `git repo` command, with a
primary focus on `git repo info`.

The `git repo` command was introduced to provide a cleaner interface for
querying repository metadata. Path-related values are a natural part of
that goal, but the public discussion this year has already shown that
this topic is not starting from zero: there is ongoing work around
path-related fields, category-aware key naming, and path-format
behavior.

Because of that, I do not want to frame this proposal as "I will newly
add repository path metadata" in isolation. Instead, my proposal is to
improve `git repo info` by building on the direction already taking
shape upstream, focusing on integration, testing, repository-aware
cleanup, and any remaining path-related or adjacent metadata work that
is still useful and unimplemented by the time GSoC begins.

The goal is not to replace `git rev-parse`, but to make `git repo info`
a more coherent and better-tested structured interface for repository
metadata.

Motivation

Today, scripts and tools still often rely on commands such as:

- `git rev-parse --git-dir`
- `git rev-parse --show-toplevel`
- `git rev-parse --git-path <path>`

These commands are useful, but they were not primarily designed as a
structured repository metadata interface.

Since `git repo info` already exists for this purpose, extending and
refining it would make repository layout information easier to query in
a cleaner and more consistent way. However, given the current public
work in progress, I think the most useful contribution is not to
duplicate existing series, but to help move this area toward a better
integrated and upstream-ready state.

Current context

I am aware that work on path-related `git repo info` fields has already
started. There have already been patch series and proposal discussions
for path keys, category requests, path formatting, and nearby
`git repo structure` ideas.

Because of that, one of my first goals during the bonding period would
be to review the current state of those discussions carefully, identify
what remains open, and refine the exact project scope based on mentor
feedback. I would rather build on the current direction than duplicate
work that is already in progress.

At this point, the direction that seems most realistic to me is:

1. first align with the upstream direction that is already emerging for
   `git repo info`
2. improve the command's internal consistency and test coverage
3. implement remaining path-related or adjacent metadata work only where
   it is still clearly useful and not already being covered elsewhere

Immediate next steps

Before the coding period, I want to keep contributing in this area
through small reviewable patches instead of waiting until GSoC starts.

My immediate plan is:

1. review the latest upstream state of the path-related and
   category-related `git repo info` work
2. identify one small `git repo` patch that does not duplicate an
   in-flight series
3. start either with a repository-aware cleanup in `builtin/repo.c` or
   with stronger tests in `t/t1900-repo-info.sh`, depending on which
   direction is still open and useful
4. use that first patch series to validate the project direction with
   the mailing list before committing to a larger implementation batch

Proposed work

The main objective of this project is to improve `git repo info` as a
structured repository metadata interface while avoiding duplication of
public in-flight work.

I expect the work to proceed in four connected parts:

1. review the current implementation and ongoing mailing-list
   discussions, then narrow the initial scope to a first small batch of
   cleanup, tests, or still-open metadata work
2. discuss design details on the mailing list, especially where there
   are open questions about path naming, path formatting, or the
   relationship with existing `git rev-parse` behavior
3. implement the agreed functionality through small patch series, with
   each patch or small patch group carrying its own tests and
   documentation updates for the user-visible behavior
4. if the first batch is in good shape, extend support to a second
   agreed batch of improvements, whether that means remaining
   path-related fields, repository-aware cleanup, or nearby metadata
   work that still appears useful

Initial scope

At the beginning of the project, I would prefer to keep the first
practical batch conservative.

Rather than assuming that the first implementation work should directly
add a large number of path keys, I would prefer to start from one of
these two realistic entry points, depending on the state of upstream
work:

1. a small batch of still-unimplemented layout-related fields with clear
   `rev-parse` equivalents, if those remain open
2. repository-aware cleanups and stronger tests around `git repo info`,
   if the path-field direction is already substantially covered by
   existing series

If path-related values are still a good first target by the beginning of
the coding period, the most likely initial candidates would be a small
set of high-value layout paths such as:

- `git-dir`
- `common-dir`
- `toplevel`
- `superproject-working-tree`

If those are already substantially addressed, I would instead prioritize
cleanups and tests that help the command mature, for example:

- reducing unnecessary reliance on global repository state inside
  `builtin/repo.c`
- strengthening coverage in `t/t1900-repo-info.sh`
- covering edge cases such as linked worktrees and `--separate-git-dir`

Technical approach

The implementation of `git repo` is primarily in `builtin/repo.c`. The
first step would be to understand how `git repo info` currently collects
and prints repository metadata, and how that existing structure can be
extended or cleaned up without making the interface inconsistent.

Many relevant repository values are already available internally through
helpers such as:

- `repo_get_git_dir()`
- `repo_get_common_dir()`
- `repo_get_work_tree()`

Similarly, `git rev-parse` and `git rev-parse --git-path` already rely
on existing path resolution logic. So the work is not about inventing
these values from scratch, but about exposing or integrating a selected
subset of them through `git repo info` in a way that fits its current
design.

Patch strategy

I expect the implementation to be divided into small patches so that
each change can be reviewed independently.

A likely patch strategy would be:

1. a small preparatory cleanup if needed
2. a first small batch of `git repo` improvements, together with the
   tests and documentation updates needed for those changes
3. a second batch that extends the same direction once the first one is
   reviewed

I do not want to treat tests and documentation as a final cleanup
stage. Since these are user-visible changes to `git repo info`, I think
they should evolve with each patch batch so that the mailing list can
review the interface and its description at the same time as the
implementation.

Tests

Tests would be added alongside the new behavior rather than at the very
end.

Depending on the exact scope agreed on, test cases may include:

- ordinary repositories
- linked worktrees
- superproject and submodule cases
- repositories created with `--separate-git-dir`
- cases where path values differ from simple defaults

Where possible, I would compare new `git repo info` behavior against
existing `git rev-parse` behavior when the semantics are intentionally
close. I would also look for opportunities to reuse or mirror repository
layouts and edge cases that are already important elsewhere.

What I will not try to do

To keep the project realistic, I do not plan to:

- redesign all of `git repo`
- fully replace `git rev-parse`
- reimplement path-related work that is already being actively reviewed
- work on both `git repo info` and `git repo structure` at full scope in
  the same project

Expected deliverables

By the end of the project, I expect to deliver:

- support for a useful set of `git repo info` improvements that are
  still clearly open and upstream-relevant
- tests covering the new functionality and relevant repository layouts
- documentation updates for the new fields or behavior
- one or more patch series discussed and refined on the Git mailing list

Success criteria

I would consider the project successful if, by the end of the GSoC
period, the following are true:

1. a first useful batch of `git repo` improvements has been implemented
   and is in good shape on the mailing list, ideally merged or close to
   merge-ready
2. the new or refined behavior is covered by tests that clearly
   exercise the agreed repository layouts and semantics
3. the documentation has been updated together with the implementation
4. if review and scope permit, at least one further agreed batch of
   improvements has also been implemented or is well advanced

Timeline

Community bonding period

- study `builtin/repo.c` and the current `git repo info` implementation
- review recent and ongoing mailing-list discussions related to
  `git repo`
- compare current `git repo info` behavior with related
  `git rev-parse` behavior
- refine the exact scope with mentors and mailing-list feedback
- identify the first small batch of work that looks realistic for an
  initial patch series

Weeks 1-3

- confirm the exact first batch of work to target
- prepare and send an initial patch series for that batch
- include tests and documentation updates in that first series
- address review comments and reroll as needed

Weeks 4-6

- continue strengthening semantics and coverage
- add tests for edge cases such as linked worktrees and
  `--separate-git-dir`
- resolve small interface inconsistencies discovered during the early
  cleanup work

Weeks 7-9

- finish or polish any remaining path/category/path-format work that
  still needs implementation or integration
- coordinate patch scope with the latest upstream discussion
- update documentation to match settled behavior

Weeks 10-12

- implement one or more remaining metadata or interface improvements
  that are still clearly useful and unclaimed
- focus on review-driven cleanup, additional tests, and documentation
  polish
- prepare final report and project summary

Risks and mitigation

The main risk is overlap with parallel upstream work. I plan to mitigate
that by treating the project as integration-oriented from the beginning,
keeping patch series small, and adjusting scope based on the latest
public discussion and mentor guidance.

A second risk is that some of the path-related work may be largely
settled before the coding period starts. If that happens, I would shift
effort toward repository-aware cleanups, stronger test coverage,
documentation alignment, and other still-open `git repo` improvements
rather than forcing redundant feature work.

Why I think I am a good fit

I have already invested time in learning Git's contribution process
through actual submissions rather than only private experimentation.
That includes building the project, reading tests, sending patches,
rerolling in response to feedback, and adjusting patch structure when
maintainers asked for it.

I believe that experience is directly relevant here. The main challenge
of this project is not only writing code, but also moving an evolving
command forward in an upstream-friendly way without duplicating parallel
work. My recent contributions have helped me understand that process
much better, and I believe they put me in a stronger position to carry
this project successfully.

Relevant links

SoC 2026 idea page
https://git.github.io/SoC-2026-Ideas/

General application information
https://git.github.io/General-Application-Information/

git repo documentation
https://git-scm.com/docs/git-repo

git rev-parse documentation
https://git-scm.com/docs/git-rev-parse

Recent patch series adding path-related support to git repo
https://public-inbox.org/git/20260228224252.72788-1-lucasseikioshiro@gmail.com/

Recent work-in-progress series for category and path keys and
`--path-format`
https://public-inbox.org/git/pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com/

Recent GSoC proposal thread on improving the new git repo command
https://public-inbox.org/git/20260303140732.16886-1-pushkarkumarsingh1970@gmail.com/

Another recent GSoC proposal thread on improving and extending git repo
https://public-inbox.org/git/CA+rGoLd-1Mb5JG1H1PvE-kyjdznrLVFjwQiMLHtd2ETQ-igmXg@mail.gmail.com/

Recent proposal thread focused on the same SoC idea
https://public-inbox.org/git/CAO_P5U3g_+RpnDUmEv_qX-3GVhpxLV97eMxP1apERc0KU_95tQ@mail.gmail.com/

Microproject discussion thread
https://public-inbox.org/git/CAKWWG_nGhD6vqhAS1mkEwBQPrg_YX0+C3-xW=Q3ifFDw4dDviw@mail.gmail.com/

Microproject patch thread
https://public-inbox.org/git/20260315231538.68586-1-jerrywang183@yahoo.com/

Follow-up patch for header parsing errors
https://public-inbox.org/git/20260316195847.92386-1-jerrywang183@yahoo.com/
