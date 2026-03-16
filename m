Received: from sonic315-13.consmr.mail.bf2.yahoo.com (sonic315-13.consmr.mail.bf2.yahoo.com [74.6.134.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CCCA55
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666495; cv=none; b=pKmB0tJ9lqXBhDp9cvpQfoZBOt4kYZP5OgV+iA7/RE2NIDOnQGV9LKv8Uo5LlBKrjNktQZNshM8qyXp9faW8Rlt3oQRSFwAw2s1LfLgJp2xIZyMTmDR5kR6QIdIVMU7RnTKfUW0t/54Hcsjdrm7tgzxtJcMglq1cTxCL47Fayr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666495; c=relaxed/simple;
	bh=8ZivH+7Y1pSuSRxL89CEu2VZmaslKfTTOEDoNy57BSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=oaVW+yWgm9WnS9FOzrP+IrDhNIDICpUoijqAiPJhza9mQZYajyvNO+7nWKyWUOjkg1NJ7KLGCiCI88WdVm48ML6Cf4tEtDpxLkTc/uyHeqIhvh/3zwHN3iWH4TbQaTBPo7AvM8JtFDg/w0X7I8iwfX1ZqzVJtTHX05fS02kEW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TdXs53DU; arc=none smtp.client-ip=74.6.134.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TdXs53DU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773666493; bh=iLEo1GMewJjpOG4S13mUmYc0+/ismmMLqb4vTvVVBhY=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=TdXs53DUWFSzMGGQmGGkbxUxS7YDPq6wSaTL2tucIJQV5SZPVC27mxOD1nI7vZMRXNAvfPHO2u3Khy5UomUh3jPjN5knbnCGFyUSoIM4uozlfzBNHcqv6LISUb1u9tacEzEQ/tP2bNq1/c4V086FbACYCuGbaIzd2glRfgVbJFmJ6bWvKMVpQRV8hMk4tKr1wgKzutcQB0fSMl4VprnZX2TuXGx90VgwiYuNkmpxd/s2Y3UVH9nUyqbEQEp3YDQQC8PFT1zfiqF9dJRO9r/d6T9E5J8/HKAIMphqV2ovrfzuRc5uiM+oyXjky9zW4sVra2BvOYXrMUmbl+5jHPDPzA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773666493; bh=7MbTqtMxayEHmYsAJiUqxZPwzkpsOvs+XWXg5DiHBOW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OSWFro9i/yC+lbCFLaYjRifdQVnY9hoYAgbpBgBLHCmAVt237RJX7r2no6JJ0YEafdiGmHtILKrA/FF7tAs8ntltSSo+puJYjQC1vE9iPmdTjzt5eQpg9sOYwOSPC/NnbRCn19Ea2sIkcXKPH3hYc0B4Gjo0/8o0R4i3rpQuouwxprevdODH9b/Fm9z1i0GKTqq916SGGgjlP3HIvI9pOVfSK2ewfYPytoJTcJyR3Bcc1B5Hxd5cawUgopYgVX7/LL057CHl/CieqVkS4HG14Iv/2liviYz676QNGVtWSuNoJxYUg2b/PaSsoatIxaNI63P7O04Ie7XqmRZmZ0FsGg==
X-YMail-OSG: v6UQDRUVM1mR3b8QyipCWgPkee5mEwTkEMewHN3CZ1D324ZtBK8aQ5nstsshLNA
 .GJ9CSZvHjtaktX3yGcE.Wh82suIEyloXbhu_99OF7Wtu5yKF3tfThgfgN4hHzXjUpXciEpULCoK
 dtTjytWyv8qVdCl5k32nrnv6snPSGKPm9Q1Swb6d6C34_O5V1H5PsS9Ms2AXo6YA3qKRapF38VTE
 QQCi7Ozr7QpsZeSAnLN3uwOTeOr732yQkgguN6XBXHcEbBJ7moIT3K14JaajcHagbdlCDtjVI6d6
 wqPxl.m2dvBBgqzDs6tQP5vaPQJDvVWqKLpFIuD6nfZDynCNAjdH.2AeZ7D.cF9fVZPDB4ZCZDNY
 DE4U_qaigNk620UbVFAV9oK6bKdjcQ25G.GdItfUthQ1Chm5g4TMjH0akiJSz.eaY_M6d8ykvPOo
 OUDpJF3W.vwAHaYpWLGf3EhZZvYaA.9RFH2ZSHIbrVqHTR_yq7ClOHkrWdEItGLV6TATbTy8Ycnh
 ABZPBi70iOh8eiqj_VIAt0DnFOdEvljiH26EX1ntADj0qBu_hRazxYsie2C9ujeBWxnrH7FgcdJ0
 Bs5qZ35c6J9v6zOxMs_B0.lgt.U3tzTXMm24fl_r4mFV5NR5u334OD8qYd0EO6co2OhW6BBDAzWd
 Moa2bBiDRyfI2e_MLB5Ixk_HKo9PZNtNOM_DEgPswXWP9FB.Va2CHvpYiefKYHu7v_motn7Ox4Wp
 moQy1CzCx_q59B9lvmaVPXov2vOVspgrlS6Oeqte_qR2f7D5izfxqnVLczqQQ689Vru4VFXdSDGm
 PGMYAoK0MzJE1oNBg04Nm3oHsJ5OqrAP94weLwMy0wkI.sIpx79iA9ybt.1ru37J.tqMgmbfOJCR
 aRAs8jI9asXyyqCyeb5B1q9DskuKtSenvg_p1tcQ_FPpSGIEJmhdQHkpznTZ3NcqPmYclyL05geB
 YDKItG.Pcb_yBbhdfZ0lZHcZs6gIi3rIHnOkvKRJfghfflhg7CtNEzKfbmT_f2.Jw8vR9uSzrC_L
 Q8fQW6_iIJv58m0Ys2Hq2K9BqH2Brji9uC.hWTyPAvEtOVljyqZjkDxT5TrsXlK0ZLlBjdFsHwaj
 AZyCotLBNh9yrbRyx4SQWxDPcv8eHXbLl_Co4KNz71nUL7xuC8IFJ0.EbQjw2CluIFMDTeKX8d3s
 WRvxiMWZBD8Hfckh96G0RQ6B68TN_8vLvyfQt4XZfz71mQHFbpuv1o71SV4BOUmkExT_3q7pAKfH
 Jo1ft3_NYdjUlCxhtAVtkctfveHi.aN7gErGdA.a19MlejAt7qkVLtNkzovLPRwU2m5eXB77wfHb
 .V3DLZ6GPCogeTlSgevYWXokpdwqwb4wtgnTZNwVj9OrK06cVVEwvTWLa.BHbj7_2xgqezn9CUYE
 xQzc5VNt9CMagzYAajFfC1fKJz6koBZdRYx6A2KlzWvpU8KpkewQYdGGYje6oaLGKbYWfOD4f5nM
 fmQH_AgTL2f6Wok4XL5Aq1A6ERPstprTcE92DPjTIJbuRcYBO4EijTi_mmDxwzdiyigMl22Ig08P
 6LBBxJ36KSsMk5kWFIbIhscSekcSzddQAo1RSFeUUOWTkTaTipWYfEpon7s5UCTn5YRFEMrR0iyP
 6R9PjhpDglhzS1pcmX.QAu8E0RaT8ufed.lYnRinekMV7RLg7lYKpTN.ycMlnSkTxhSGu6dd7MU8
 55BIoj9I.87WtWnHq9c5kKYndOBFhqg4felRdtiuALlJT7dNRaFMyrlSYmYozuSkUX_rM3zUINwu
 0UbaldEoo1itQt0aEXsUfenKRn1s1O1Uid_AWXW3VI.lOzgSN9Wquet3QD..CdbN988DDtODt1go
 qWXlqeEKfQSe1yEUg09b8hvWQcAXMrBDwOn10OvLqEv.MRnCWNHAl3zEQoCDwSVouNYhARoewV9S
 JUaJT.IPgGvJrqKxHeYbb1caghJF1BVMMCsht7L_ONcxT62sMrr0kWnD4AyNmmf0EO8ecR3vg4rT
 CpxmEhYbLRg7Wyo4cGAfEDq5QiDI7ZQCwOp9ft3Ujc6qXr8gxyqWoeav5pq3Qi1LH2Cja6Ys65nz
 dbqmWE.TY4LfuSOOCxVhthBo7Ss_0_X6EwtbdWVOg.Lw1X2Ql0DsFZJrVKDnYU4L9Y_J.AI0oWjT
 h.SDq8ZOv3zmneGvP_Kr52ChLZjOSDjslF4NzPhGKzuuUuoym2W9zrx9lkqUyyS0A7PDX3iw_rmD
 ezWeJv2r5m7wkDZ9K3APCQmUaunN0hLESl_V8M81IYnYFty5XxVe1YPTu0NKgSBmhyYaZkoz80KG
 zvGOrRyRRQQr8mi1yAeDQPXDCw28NjV7wH_I6B6wmveCQQX43Gwg-
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: b2f59852-4149-4e0e-8ac7-0c9ac0b094a8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Mon, 16 Mar 2026 13:08:13 +0000
Received: by hermes--production-bf1-697f88457-629ff (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c970b30917d887ead9b391b21bfe3d56;
          Mon, 16 Mar 2026 11:47:15 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: Jialong Wang <jerrywang183@yahoo.com>
Subject: [GSoC] Proposal draft: Improve the new git repo command
Date: Mon, 16 Mar 2026 07:47:13 -0400
Message-ID: <9fc1d23fbc7d46349ac01314fbfc06eb.gsoc-proposal-draft-jerrywang183@yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <9fc1d23fbc7d46349ac01314fbfc06eb.gsoc-proposal-draft-jerrywang183.ref@yahoo.com>
X-Mailer: WebService/1.1.25297 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi,

I plan to apply to Git for GSoC 2026, and I would like to share a draft
proposal for feedback.

The project I am currently most interested in is improving the new
`git repo` command, with a primary focus on extending `git repo info`
with path-related repository metadata.

My draft is below. I would appreciate feedback on whether this scope
looks reasonable, and which parts of the current `git repo` work would
make the best starting point.

Thanks,
Jialong

---

# Improve `git repo info` by adding repository path metadata

## Name

Jialong Wang

## Email

jerrywang183@yahoo.com

## Preferred project size

175 hours

## About me

My name is Jialong Wang, and I plan to apply to Git for GSoC 2026.

I have been getting familiar with Git’s development workflow by building
Git from source, reading the contribution documents, and working on a
microproject. As part of that process, I prepared and sent a patch to
the Git mailing list.

I am interested in the new `git repo` command because it is user-facing,
but also closely tied to Git’s internal repository model. That makes it
a good fit for the kind of work I want to do: understanding existing
code, discussing design details on the mailing list, and implementing
improvements in small, reviewable patches.

Relevant links:

- Microproject discussion thread:
  https://public-inbox.org/git/CAKWWG_nGhD6vqhAS1mkEwBQPrg_YX0+C3-xW=Q3ifFDw4dDviw@mail.gmail.com/
- Microproject patch thread:
  https://public-inbox.org/git/20260315231538.68586-1-jerrywang183@yahoo.com/
- SoC 2026 idea page:
  https://git.github.io/SoC-2026-Ideas/

## Project summary

I would like to work on improving the new `git repo` command, with a
primary focus on `git repo info`.

The `git repo` command was introduced to provide a cleaner interface for
querying repository metadata. However, several useful path-related
values are still mainly accessed through `git rev-parse` and
`git rev-parse --git-path`. My proposal is to extend `git repo info`
so that it can expose a selected set of those values in a more
structured form.

The goal is not to replace `git rev-parse`, but to make `git repo info`
more useful as a structured interface for repository path metadata.

## Motivation

Today, scripts and tools still often rely on commands such as:

    git rev-parse --git-dir
    git rev-parse --show-toplevel
    git rev-parse --git-path <path>

These commands are useful, but they were not primarily designed as a
structured repository metadata interface.

Since `git repo info` already exists for this purpose, extending it with
path-related values would make repository layout information easier to
query in a cleaner and more consistent way.

I think this is a good GSoC project because it has clear user value, can
be implemented incrementally, and naturally fits Git’s patch-and-review
workflow.

## Current context

I am aware that work on path-related `git repo info` fields has already
started. There have already been patch series for path keys, category
requests, and path formatting. Because of that, I do not want to assume
that the work described on the ideas page is still untouched.

One of my first goals during the bonding period would be to review the
current state of these discussions carefully, identify what remains
open, and refine the project scope based on maintainer feedback. I would
rather build on the current direction than duplicate work that is
already in progress.

I also think this project should be scoped carefully. The ideas page
mentions improvements to both `git repo info` and `git repo structure`,
but for a GSoC project I believe it is more realistic to focus first on
`git repo info` and only expand beyond that if the main work is in good
shape.

## Proposed work

The main objective of this project is to extend `git repo info` with
selected repository path values that are currently obtained through
`git rev-parse` and `git rev-parse --git-path`.

The work will involve:

1. Studying the current implementation of `git repo info`.
2. Comparing its current output with commonly used `git rev-parse`
   path queries.
3. Identifying a first small set of missing path-related values to add.
4. Discussing output design on the mailing list, especially where there
   are open questions about relative versus absolute paths.
5. Implementing the agreed functionality through small patch series.
6. Adding tests covering the new behavior.
7. Updating documentation if needed.

## Initial scope

The first stage of the project would focus on a small set of commonly
used repository path values, for example:

- `git-dir`
- `common-dir`
- `toplevel`
- `superproject-working-tree`

I think these are a good first target because they are already familiar
to users through `git rev-parse`, and they provide immediate practical
value without requiring a large interface expansion.

Depending on project progress and mailing list feedback, I would then
like to extend support to selected values currently accessed through
`git rev-parse --git-path`, such as:

- index file
- objects directory
- hooks directory

I do not want to promise every possible path-related key up front. I
would rather start with the most straightforward and useful values, get
feedback early, and continue from there.

## My approach to scope and quality

One thing I would like to be careful about is not treating this project
as a simple checklist of fields to add.

I think the quality of the project will depend on three things:

1. choosing a small set of fields that make sense together,
2. agreeing on a consistent path representation,
3. and making sure the result fits naturally into the existing `git repo`
   design rather than becoming a thin wrapper over `git rev-parse`.

Because of that, I would prefer to make progress in a few coherent
batches instead of adding many unrelated keys at once.

I also think it is important to keep room for scope reduction. If some
part of the design turns out to be more controversial than expected,
I would prefer to complete a smaller, cleaner set of path fields rather
than stretching the project too broadly.

## Technical approach

The implementation of `git repo` is primarily in `builtin/repo.c`. The
first step would be to understand how `git repo info` currently collects
and prints repository metadata, and how that existing structure can be
extended without making the interface inconsistent.

Many relevant repository paths are already available internally through
helpers such as:

- `repo_get_git_dir()`
- `repo_get_common_dir()`
- `repo_get_work_tree()`

Similarly, `git rev-parse --git-path` already relies on existing path
resolution logic. So the work is not about inventing these values from
scratch, but about exposing a selected subset of them through
`git repo info` in a way that fits its current design.

The first implementation step would be to map existing helpers and path
resolution logic to a small set of `repo info` fields. After that, I
would extend the output code in `builtin/repo.c` to report those fields
in a consistent way.

One of the main design questions is path formatting. The ideas page
explicitly mentions the need to decide between relative and absolute
paths. I do not want to assume the answer in advance. Instead, I would
review the current discussion, compare the behavior of existing
commands, and propose a small, consistent approach on the mailing list.

I also expect that some preparatory cleanup or refactoring may be useful
before adding new fields. If so, I would keep that work minimal and send
it as small separate patches.

## Patch strategy

I expect the implementation to be divided into small patches so that
each change can be reviewed independently.

A likely patch strategy would be:

1. small preparatory cleanup if needed
2. add support for a first path-related key or a very small set of keys
3. extend support with additional related keys
4. add or refine tests for the new behavior
5. update documentation if necessary

If existing in-progress series already cover some of these parts, I
would adjust the breakdown accordingly and focus on what remains useful
and open.

## Tests

Tests would be added to cover the new behavior in common repository
setups.

Depending on the exact scope agreed on, test cases may include:

- ordinary repositories
- linked worktrees
- superproject/submodule cases
- cases where path values differ from simple defaults

I would keep the tests focused on observable behavior instead of
overfitting them to a particular implementation detail.

## What I will not try to do

To keep the project realistic, I do not plan to:

- redesign all of `git repo`
- fully replace `git rev-parse`
- implement every possible repository path query
- work on both `git repo info` and `git repo structure` at full scope in
  the same project

The project should stay focused on a well-defined subset of path-related
metadata for `git repo info`.

## Expected deliverables

By the end of the project, I expect to deliver:

- support for a useful set of path-related values in `git repo info`
- tests covering the new functionality
- documentation updates if needed
- one or more patch series discussed and refined on the Git mailing list

## Timeline

### Community bonding period

- Study `builtin/repo.c` and the current `git repo info` implementation
- Review recent and ongoing mailing list discussions related to `git repo`
- Compare current `git repo info` behavior with `git rev-parse`
- Refine the exact scope with mentors and mailing list feedback

### Phase 1

- Implement a first small batch of path-related values
- Send the first patch series
- Address review comments
- Add tests for the first batch

### Phase 2

- Implement additional agreed path values
- Continue design discussion if needed
- Refine implementation and tests based on review feedback

### Phase 3

- Complete remaining agreed work
- Update documentation if necessary
- Rework earlier patches if needed for consistency
- Prepare a final summary of the work

### Buffer time

- Handle review delays
- Fix regressions or edge cases
- Narrow scope if some planned work turns out to be too large

## Risks and mitigation

One risk is that design discussion may take longer than expected,
especially around path representation and output structure.

To reduce that risk, I would keep the patch series small and prioritize
the least controversial values first.

Another risk is overlap with work already in progress. If that happens,
I would adjust the project scope to avoid duplication and focus on what
is still useful and open.

## Why I think I am a good fit

I have already started learning Git’s normal contribution workflow
through a microproject, including building Git from source, running
tests, preparing a patch, and sending it to the mailing list.

This project fits the kind of work I want to do in Git: understanding
existing code, discussing interface details on the mailing list, and
implementing improvements incrementally in small patches.

## References

- SoC 2026 idea page:
  https://git.github.io/SoC-2026-Ideas/

- General application information:
  https://git.github.io/General-Application-Information/

- `git repo` documentation:
  https://git-scm.com/docs/git-repo

- `git rev-parse` documentation:
  https://git-scm.com/docs/git-rev-parse

- `git-sizer` project:
  https://github.com/github/git-sizer

- Recent patch series adding path-related support to `git repo`:
  https://public-inbox.org/git/20260228224252.72788-1-lucasseikioshiro@gmail.com/

- More recent work-in-progress series for category/path keys and
  `--path-format`:
  https://public-inbox.org/git/pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com/

- Recent GSoC proposal thread on improving the new `git repo` command:
  https://public-inbox.org/git/20260303140732.16886-1-pushkarkumarsingh1970@gmail.com/

- Another recent GSoC proposal thread on improving/extending `git repo`:
  https://public-inbox.org/git/CA+rGoLd-1Mb5JG1H1PvE-kyjdznrLVFjwQiMLHtd2ETQ-igmXg@mail.gmail.com/

- Recent proposal thread focused on the same SoC idea:
  https://public-inbox.org/git/CAO_P5U3g_+RpnDUmEv_qX-3GVhpxLV97eMxP1apERc0KU_95tQ@mail.gmail.com/

- Recent discussion around `git repo structure` enhancements:
  https://public-inbox.org/git/CAO_P5U2f4MD-URre+4ocC=YQ570hr03pZHDk1jvuSOKx4aLOCA@mail.gmail.com/

- Microproject discussion thread:
  https://public-inbox.org/git/CAKWWG_nGhD6vqhAS1mkEwBQPrg_YX0+C3-xW=Q3ifFDw4dDviw@mail.gmail.com/

- Microproject patch thread:
  https://public-inbox.org/git/20260315231538.68586-1-jerrywang183@yahoo.com/

- Review on the microproject patch thread:
  https://public-inbox.org/git/CAOLa=ZTpfHUySnMgCFMnvo2JcRSv8zqFP-cLFSs+Ab5Cy2zsvg@mail.gmail.com/

