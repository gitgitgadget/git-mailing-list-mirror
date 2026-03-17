Received: from sonic307-31.consmr.mail.bf2.yahoo.com (sonic307-31.consmr.mail.bf2.yahoo.com [74.6.134.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608D168BD
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 00:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708060; cv=none; b=suJatKAaIyghmBB2Rs6kvOtRMKy7zhd5oIHpi2Qe6yMb9UAsu0c5H3CHEJxvcYMrvzvUtuc3TopjhhCqF//o+3riI0nxPTTR+w3xSUjCuA1kKM0qhVE7bvUmq0SDmtDrPgA7q4PkEuDyjXprLDYv3yQ0YbewNq06h3af0jTNoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708060; c=relaxed/simple;
	bh=0FjdB3zbz4A36DcuV6O0SgomT5Q8Xmw5ZPfficLRxFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNaebqcDx8mDfvd7CkHfGLljoSN8e9K/SoxSGludXv8U90xYc81OXPhr+4YhdmHnBDZz7gcmaNSZOCa5tq5kgaUJy13zPLsSDggujaPdXO/9XXvrkTc3FLGynzKia/IbRPsd+yXVuZK0VWtQaM9SjgDQNCtnXjhvtls3tVWegGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gDutFRTh; arc=none smtp.client-ip=74.6.134.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gDutFRTh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773708057; bh=G3mk6AblzhdFpnBTy14TLmtQUlRKMnM8GnQhiEgnLa0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gDutFRThGQo2NCDiPlyAiWuetD33VGiqJjZKRi5iQzHpNVa1ikV+V+33vyfvlRwWN41Tf3Velnxm8bWebKrKNfP/E73tJXcmyWeE2WcrZEfmmRxErgcNLdaHR6Sasm2X5mVSHum8v7DfP/xerxQ3wpyHbLA2cAt/XEqOp02CX5eVsKzvMy8cu+FCBDjYBWVLFrD8EeBHqtlPWlQbzH882Z0O4EDFdurtWCpUOdEkFKt8jlULrSO/JCZIM1J5MTnCGsjePQghFqz8DMxM7Nmhc8hA4DVJp6tJfVvVNlJHp/8JwOyt20I5gnhVtSB7rAQRxRrz5Vc58tTOSzIv8fl0GA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773708057; bh=4wdTiodPOSahqIzOvf4WNKi6kRa3mhhEEHjEBx87lMw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kQcEp+A+Yj7i/w8RlPZv4eGeMp6Z80YEGQP04uxN8qjifbxJ8rboeMNVhVdafnvIpY/TPHlMdza1exuflmP3RKxvmuCNfs+EgMyngK/jq2uwNra7aqENGOsvRJls1LYLScpRvI++zYWdrvOdEsp/TOnlzxc6RJVk99QGzuK/vvkGwMTwafmwGtF+Cny2kIIRVt9OdbayVdNdDhwS0Hi8g/2P5sQ2OREI8TBwMJkPsc0jh6BzJTxGTsJoTC3vQsMjnK2Z0Lj7RBkCv/rco+v99COcAyHFixGy0NmF/tuLlzwCX0Eewl7ICmDDuKn51xn+j/zPSVSj2vxjWiys4IQZ8A==
X-YMail-OSG: gUjV1J4VM1kXXlmxuF2yDz58LhNeGyW.k9fgfvpvFaSkZl3n6AXpMzgGeDS.wSi
 ZkNg_xX2z5Wdm3tJTYwXDv5Ad83tItnI8_mNvvYVRwjAsx0I.0twsXpMcaBJcOHhmrDkk1lOYk1I
 Ntw7r3RY3EkbDzQI3kIuflaVw6gf6ouY_Rai..8hWKcr6V0iieRPZY0QzwhCeZSb2ENeq_JKBLcP
 cW89IdPZPwwlhSGbRLZwE2aX5lqBbDjitqt.wPhrfiSyuCclWg0vbJ2V.lw8aG1nLzGm3QAlh2Kl
 XLkFn1xXLJiEQ3qnVMScaARVx1_ZFoi09ig.ryOzEqYP4dX44V.tOEOr8xLqx.ZXEHPrpUUL_9xl
 4ynwq7shZl5QAuw61LCPxdxrj9KWHnmnglJ_Kx55ngYkg_LxGDJ01MjYLsfiRDYKde_AmvcCgAtk
 T.AhenhDpHPhq9yJ8tnUtmVG0nQhyEnsEB6Ohnf.C3w6EcORkbWUEbhkYeLW8I3sJ4wBZzeAvD0r
 0dDtGGnQvGV7l1UqtFb4ZSF4aGSHBHuieHMSWMWTuLNSv7rReV5Bmu11khX6STDQgdOiw33nNuMS
 WyGFEADXbPIw.DNUellb1R00VHkGAbViJOBu_NXa6NniVuU3IxCJDOi.JFB9D4SmB9wfreyXmWPs
 yjX7bw_pQoMJqJNU_gkkD_QK7rtzo8ljOZZnmoXIdgPCtnHXUiAseC9eWBvHhA.2M5GMDIkYTUMH
 YHfaA1q4pk9hBgU4wnR25_3nuhZk.Q3vuNjf0AHjSXcs9JkpwZsUDdZviHyZXyC9HI1gmbh27R9T
 jVooHH8RHl3DyY2779qfyJmu02bKfOALgkBjzQLxHcjbTGccBwe074Xz3jLpb4_7h55pCSbSvK7.
 OBgg3xKKA347i8HF.cYhl_op1fLpA7ZWpgVHO01bNkGiL3NTgCV2hO9AQ0IDoC8A0D81as3W5N_6
 28MnnpoOXvVwqsuG2l8QHpCKq3zzdbTrTJUgvGAbmGArCMA.ZQqQiacYog1w.dOUZJ_An3ee0MrN
 9fk.CggDdDfCVUJHbltlAh5DD3Ppsf1L51Ux2eUaW8TtYaFMSwBixGJcLevN9ptbgMaM4EPEVsYy
 FyC2lbaJfMAxrU4RcPjGqmQ7JB4C4DAhUIUJHltoSMD.f9elWvxvxTpga99EMYm0mode_0tp5Okm
 r41.pHlDu_A5naWc2hgWWRZLLTpYsNe_P1cLJMD4tf1uXT0EL2psz02VBokVzOGZ8.oS9Q7CKUgn
 N8Jhz8NUA2Q3dgZalT4AMRWqYY2IHMhmklaMxcTopD8OB2yf9j4CFPGJfAPiZJp65bR82ysroxnd
 wfPcVuPqT1wY3egBdaJa3Rl04pi6wYCPrp_5BkXPzzCks4F56SczU0_nuJ3q3xvx06FcQIjpwo3o
 VxHjyUFs893UJgDkVSzZt_IqwCUPReDWXUbueicFgjGoPVnGJfFp_rxB2wB7aXhEpinLEnhFu2ZD
 udHxidcTPbCf5p2Dp3asIaLhstiKwwSYsrL6XBZmWyutZ9FUcj7sbE3iSGtwzr71_jbpHkbh81f5
 cdHi0dIt03LLbS9m2VUEqJJG4Whq_Er6Z7biHLa74qThI0U2oAKZHWULwUQJNQVYJU5grWxLKQZq
 qu0idXvRRniuDQBJgC.1uxjRpRsGESj715doMjQU.nZe5_uYOFZzjjZZ0bm6kE2Xc_Z0mw1TaAIw
 S9Qez3AcWkL1B90eiE49bx2DmGznaIcRZDJQ3iNRveTfkLJJq8PDI0Se3V7G.8gbHf5cM3XbDHNG
 Q3..jOaxDUp.ZVIKw6GT8XnSG0Js1CbMouz9E5LvsseBF_jSlyfs_F6UkACVB63PU7oMBr2ybi1e
 vPXVCGZim6bWmXNy.WGHOQny1E7CdSVCaJuqzo0IvsTY6F6f433dxmRnqkaA2rR90oSFNJ1RDLDn
 xcEirHf8wwswmVeeMTCuIQxdzLVsT9UKH0OHD3vs1qNDPZm.T9IxW21yRX2MP9RumM2SW0KSzrDx
 ZFQwV3R6DGuo9TbHaFMbQMgQwXJZHwcuBvgvFkToBuxrj8JDnQA6p70wjUqa6LaQbOHxFYeFiYNT
 w1.ts2swY0D530sDcaHLwXe5HiWMNKpTCNc7tKJxgeM0ExOUuete38DSaa4TRtBVOy6Ef4XNMgkV
 c08v22I6E9iR.z7NypcnUB48EaVKgxD2CjRHv_ty5A6uaZqUvQrSZeIRxdPfu8C2kcxRWQ82dCOu
 rRCnRZtuLO5jLsIHjJ2uwY36cXPmzH6_f.W_4ZaWzB6xClUZPhgdyMCwlZqQe6cMle1mJMV_ufV6
 OXkaAfHnmfbiQ3TI1A4NfviyXiVmKqERtfexE.qGkww5u6eBHZPSNuxHusbdyx4E7bxHSA8iM.F1
 iljs-
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: b84ddadc-8999-4a16-889e-9778699b70bf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Mar 2026 00:40:57 +0000
Received: by hermes--production-bf1-697f88457-tdncb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ac37418051a8f01fbdcbc2ec9156bec0;
          Tue, 17 Mar 2026 00:28:49 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Jialong Wang <jerrywang183@yahoo.com>
Subject: Re: [GSoC] Proposal draft: Improve the new git repo command
Date: Mon, 16 Mar 2026 20:28:48 -0400
Message-ID: <20260317002848.6263-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAOLa=ZQ7AMUb72N-0Z-h09KneE+ASuXt=BUOmO9Bzp4y6w6XyQ@mail.gmail.com>
References: <9fc1d23fbc7d46349ac01314fbfc06eb.gsoc-proposal-draft-jerrywang183@yahoo.com> <CAOLa=ZQ7AMUb72N-0Z-h09KneE+ASuXt=BUOmO9Bzp4y6w6XyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Karthik,

Thanks for the detailed feedback. I revised the proposal draft to make the current status, intended scope, patch breakdown, and use of existing tests clearer. The updated draft is below.

Improve Git Repo Info By Adding Repository Path Metadata

Name
Jialong Wang

Email
jerrywang183@yahoo.com

Preferred project size
175 hours

About me

My name is Jialong Wang, and I plan to apply to Git for GSoC 2026.

I have been getting familiar with Git's development workflow by building
Git from source, reading the contribution documents, and working on a
microproject. My microproject focused on improving corrupt patch
location reporting in git apply and git am. That work has already gone
through mailing list review, including comments from Karthik Nayak and
Junio C Hamano, and it gave me direct experience with rerolling
patches, updating tests, and using CI to catch gaps that I had missed
locally.

My broader programming experience has mainly involved systems-oriented
software, where I have had to read existing code, trace behavior
through unfamiliar paths, and make targeted changes without disrupting
surrounding logic.

At this point, my recent Git contributions around this microproject are:

1. an initial microproject patch series to report the location of
   corrupt patches more clearly
2. a follow-up patch to report input locations in header parsing errors
   in apply.c
3. a follow-up patch to report input locations in binary and garbage
   patch error paths in apply.c

This has also helped me get comfortable with the normal Git workflow of
starting with a small change, responding to review, and then continuing
with a logically related follow-up.

I am interested in the new git repo command because it is user-facing,
but also closely tied to Git's internal repository model. That makes it
a good fit for the kind of work I want to do: understanding existing
code, discussing design details on the mailing list, and implementing
improvements in small, reviewable patches.

Relevant links

Microproject discussion thread
This thread asked whether improving corrupt patch location reporting was
a suitable microproject and helped me choose the work.
https://public-inbox.org/git/CAKWWG_nGhD6vqhAS1mkEwBQPrg_YX0+C3-xW=Q3ifFDw4dDviw@mail.gmail.com/

Microproject patch thread
This thread contains the patch itself, review, and rerolls for the
corrupt patch location reporting work.
https://public-inbox.org/git/20260315231538.68586-1-jerrywang183@yahoo.com/

Follow-up patch
This follow-up patch extends the same idea to header parsing errors in
apply.c.
https://public-inbox.org/git/20260316195847.92386-1-jerrywang183@yahoo.com/

Second follow-up patch
This follow-up patch extends the same idea to binary and garbage patch
error paths in apply.c and has also been sent to the mailing list. I
will add the public archive link once it is indexed.
Subject: [GSoC PATCH] apply: report input location in binary and garbage patch errors

SoC 2026 idea page
https://git.github.io/SoC-2026-Ideas/

Project summary

I would like to work on improving the new git repo command, with a
primary focus on git repo info.

The git repo command was introduced to provide a cleaner interface for
querying repository metadata. However, several useful path-related
values are still mainly accessed through git rev-parse and
git rev-parse --git-path. My proposal is to extend git repo info so
that it can expose a selected set of those values in a more structured
form.

The goal is not to replace git rev-parse, but to make git repo info
more useful as a structured interface for repository path metadata.

Motivation

Today, scripts and tools still often rely on commands such as:

git rev-parse --git-dir
git rev-parse --show-toplevel
git rev-parse --git-path <path>

These commands are useful, but they were not primarily designed as a
structured repository metadata interface.

Since git repo info already exists for this purpose, extending it with
path-related values would make repository layout information easier to
query in a cleaner and more consistent way.

I think this is a good GSoC project because it has clear user value, can
be implemented incrementally, and naturally fits Git's patch-and-review
workflow.

Current context

I am aware that work on path-related git repo info fields has already
started. There have already been patch series for path keys, category
requests, and path formatting. Because of that, I do not want to assume
that the work described on the ideas page is still untouched.

One of my first goals during the bonding period would be to review the
current state of these discussions carefully, identify what remains
open, and refine the project scope based on maintainer feedback. I would
rather build on the current direction than duplicate work that is
already in progress.

My recent apply.c follow-up patches are separate from git repo itself,
but they have already helped me get comfortable with Git's mailing list
process, with responding to maintainer comments, and with organizing
small changes into follow-up patches instead of overloading a single
series. I expect to approach git repo work in the same way.

At the moment, the direction that seems most realistic to me is to
start with a small set of layout-related fields that already have clear
equivalents in git rev-parse, such as git-dir, common-dir, toplevel,
and superproject-working-tree. I would prefer to begin there before
taking on broader questions such as category-wide output or possible
git repo structure extensions.

More concretely, if the current discussions do not point in a different
direction, I would expect my first implementation work to focus on a
small initial series that adds one or a few of these layout-related
fields to git repo info, together with tests and documentation for the
same behavior. I would treat that first series as the point where the
community can judge whether the field naming, path representation, and
overall shape of the interface look right before I continue to a second
batch.

In other words, my current preference is:

1. first settle a small batch of repo info path fields with clear
   rev-parse equivalents
2. then extend to a second batch of agreed path-related values from
   rev-parse --git-path
3. only after that consider whether category keys or other nearby repo
   info improvements are worth taking on as stretch work

I also think this project should be scoped carefully. The ideas page
mentions improvements to both git repo info and git repo structure, but
for a GSoC project I believe it is more realistic to focus first on
git repo info and only expand beyond that if the main work is in good
shape.

Proposed work

The main objective of this project is to extend git repo info with
selected repository path values that are currently obtained through
git rev-parse and git rev-parse --git-path.

I expect the work to proceed in four connected parts:

1. Review the current implementation and ongoing mailing list
   discussions, then narrow the initial scope to a first small batch of
   path-related fields.
2. Discuss output design on the mailing list, especially where there are
   open questions about relative versus absolute paths and how the new
   fields should fit the existing interface.
3. Implement the agreed functionality through small patch series, with
   each patch or small patch group carrying its own tests and any
   documentation updates for the user-visible behavior.
4. If the first batch is in good shape, extend support to a second
   agreed batch of path-related fields.

Initial scope

The first stage of the project would focus on a small set of commonly
used repository path values, for example:

git-dir
common-dir
toplevel
superproject-working-tree

I think these are a good first target because they are already familiar
to users through git rev-parse, and they provide immediate practical
value without requiring a large interface expansion.

If I had to choose an initial implementation order today, I would most
likely start with git-dir, common-dir, and toplevel first, because they
seem like the most direct and broadly useful candidates. I would then
look at superproject-working-tree and selected git-path style values
after the first review round, rather than trying to push all of them in
the same initial series.

Depending on project progress and mailing list feedback, I would then
like to extend support to selected values currently accessed through
git rev-parse --git-path, such as:

index file
objects directory
hooks directory

I do not want to promise every possible path-related key up front. I
would rather start with the most straightforward and useful values, get
feedback early, and continue from there.

If the core path-related work is in good shape, possible later work
could include small extensions around category keys or closely related
repo info behavior. I do not want to commit to that up front, but I do
want the timeline to make room for it as stretch work rather than as a
core deliverable.

My approach to scope and quality

One thing I would like to be careful about is not treating this project
as a simple checklist of fields to add.

I think the quality of the project will depend on three things:

1. choosing a small set of fields that make sense together
2. agreeing on a consistent path representation
3. making sure the result fits naturally into the existing git repo
   design rather than becoming a thin wrapper over git rev-parse

Because of that, I would prefer to make progress in a few coherent
batches instead of adding many unrelated keys at once.

I also think it is important to keep room for scope reduction. If some
part of the design turns out to be more controversial than expected,
I would prefer to complete a smaller, cleaner set of path fields rather
than stretching the project too broadly.

Technical approach

The implementation of git repo is primarily in builtin/repo.c. The
first step would be to understand how git repo info currently collects
and prints repository metadata, and how that existing structure can be
extended without making the interface inconsistent.

Many relevant repository paths are already available internally through
helpers such as:

repo_get_git_dir()
repo_get_common_dir()
repo_get_work_tree()

Similarly, git rev-parse --git-path already relies on existing path
resolution logic. So the work is not about inventing these values from
scratch, but about exposing a selected subset of them through
git repo info in a way that fits its current design.

The first implementation step would be to map existing helpers and path
resolution logic to a small set of repo info fields. After that, I
would extend the output code in builtin/repo.c to report those fields
in a consistent way.

In the current implementation, git repo info is handled by
cmd_repo_info() in builtin/repo.c. The currently supported keys are
defined in repo_info_field[], and the command prints values through
print_fields() and print_all_fields().

A likely first implementation step would be to add new entries to
repo_info_field[] for the first batch of path-related keys, backed by
new getter functions that fit alongside existing ones such as
get_layout_bare(), get_layout_shallow(), get_object_format(), and
get_references_format(). The main user-facing path through the command
would still remain cmd_repo_info() together with the existing
print_fields() and print_all_fields() flow, so my goal would be to
extend that structure rather than introduce a separate special case for
path values.

For the initial batch, my expectation is that the implementation will
mostly look like:

1. identify which existing repository or path helper corresponds to the
   field to be exposed
2. add a getter that matches the shape expected by repo_info_field[]
3. register the new field in repo_info_field[]
4. update the output and tests to cover the new field
5. update the documentation for the new field and its path format

In practical terms, I expect the first series to stay close to the
existing structure in builtin/repo.c rather than try to redesign it. If
the early fields are backed cleanly by helpers such as
repo_get_git_dir(), repo_get_common_dir(), or repo_get_work_tree(), I
would prefer to start there and let review on those patches shape the
approach for later fields.

For path-related values, the main work would not be inventing new data,
but deciding which existing repository and path helpers should back
each key and how those paths should be formatted consistently in
git repo info.

One of the main design questions is path formatting. The ideas page
explicitly mentions the need to decide between relative and absolute
paths. I do not want to assume the answer in advance. Instead, I would
review the current discussion, compare the behavior of existing
commands, and propose a small, consistent approach on the mailing list.

I also expect that some preparatory cleanup or refactoring may be useful
before adding new fields. If so, I would keep that work minimal and send
it as small separate patches.

Patch strategy

I expect the implementation to be divided into small patches so that
each change can be reviewed independently.

A likely patch strategy would be:

1. small preparatory cleanup if needed
2. add a first small batch of layout-related fields, together with the
   tests and documentation updates needed for those fields
3. extend support with additional agreed path-related fields, again with
   matching tests and documentation updates

For the first batch, I currently expect something on the order of 4 to
6 patches, depending on how much preparatory cleanup is useful and on
whether tests and documentation read more clearly combined with the
field patches or as separate follow-up patches in the same series. I do
not want to promise an exact count in advance, but I do want the first
series to stay small enough that each patch still has a clear purpose.

I do not want to treat tests and documentation as a final clean-up
stage. Since these are user-visible additions to git repo info, I think
the tests and documentation should evolve with each field batch, so
that the mailing list can review the interface and its description at
the same time as the implementation.

If existing in-progress series already cover some of these parts, I
would adjust the breakdown accordingly and focus on what remains useful
and open.

Tests

Tests would be added alongside the new behavior rather than at the very
end.

Depending on the exact scope agreed on, test cases may include:

ordinary repositories
linked worktrees
superproject and submodule cases
cases where path values differ from simple defaults

Where possible, I would compare the new git repo info output against
existing git rev-parse behavior, since many of the proposed fields are
already exposed there. I would also look for opportunities to reuse or
mirror the same repository layouts and edge cases that are already
important to rev-parse, instead of inventing unrelated test-only cases.

For fields whose behavior is intentionally meant to correspond closely to
git rev-parse, I would like the tests to make that relationship clear.
For example, if a new git repo info field is meant to expose the same
information as a particular rev-parse query, I would try to test both in
the same repository setup so that any differences are explicit and
intentional rather than accidental.

I would keep the tests focused on observable behavior instead of
overfitting them to a particular implementation detail.

What I will not try to do

To keep the project realistic, I do not plan to:

redesign all of git repo
fully replace git rev-parse
implement every possible repository path query
work on both git repo info and git repo structure at full scope in the
same project

The project should stay focused on a well-defined subset of path-related
metadata for git repo info.

Expected deliverables

By the end of the project, I expect to deliver:

support for a useful set of path-related values in git repo info
tests covering the new functionality for those fields
documentation updates for the new fields and their behavior
one or more patch series discussed and refined on the Git mailing list

Success criteria

I would consider the project successful if, by the end of the GSoC
period, the following are true:

1. a first useful batch of path-related git repo info fields has been
   implemented and is in good shape on the mailing list, ideally merged
   or close to merge-ready
2. the new fields are covered by tests that clearly exercise the agreed
   repository layouts and path behavior
3. the documentation for those fields has been updated together with the
   implementation
4. if review and scope permit, at least one further agreed batch of
   fields has also been implemented or is well advanced

Timeline

Community bonding period

Study builtin/repo.c and the current git repo info implementation
Review recent and ongoing mailing list discussions related to git repo
Compare current git repo info behavior with git rev-parse
Refine the exact scope with mentors and mailing list feedback
Identify the first small batch of fields that looks realistic for an
initial patch series
Review whether any in-progress series already cover part of that first
batch, so that I can avoid duplicating ongoing work

Week 1

Confirm the exact first batch of fields to target
Prepare and send an initial patch series for that batch
Include tests and documentation updates in that first series instead of
leaving them to the end

Week 2

Address review comments on the initial series
Revise the first batch if there is feedback about key naming, output
shape, or relative versus absolute paths
Decide whether the current direction is stable enough to continue with a
second batch or whether the first batch needs another reroll first

Weeks 3 to 4

Address review comments on the initial series
Refine the first batch if there is feedback about field naming or path
formatting
Settle the first round of tests and documentation
If the first batch is accepted or close to settled, identify the exact
second batch to work on next

Weeks 5 to 6

Implement a second agreed batch of path-related fields, likely selected
git rev-parse --git-path equivalents
Send the next patch series with tests and documentation updates for
that batch
Keep the second batch narrower than the first draft of the overall idea
if review shows that path formatting or naming still needs discussion

Weeks 7 to 8

Address review comments on the second batch
Refine edge cases involving worktrees, submodules, or path formatting
Make sure the user-visible behavior is documented clearly for whatever
subset of fields is actually agreed on

Weeks 9 to 10

Finish remaining agreed work
Use the remaining time as buffer for rerolls, regressions, or scope
reduction if needed
If the core path-related work is in good shape, investigate a small
stretch item closely related to git repo info rather than branching out
into a separate large feature

Weeks 11 to 12

Handle any remaining review rounds on the core patch series
Polish tests and documentation for the agreed set of fields
Use the remaining time for final cleanup, rerolls, and project summary
rather than for opening a new large piece of work

Core goals for the project

1. land or get close to landing a first useful batch of path-related
   git repo info fields
2. implement at least one further agreed batch if the first one is in
   good shape
3. keep tests and documentation updated as part of the patch series

Stretch work

1. add a small extra batch beyond the core set if review cycles go well
2. investigate a nearby repo info improvement such as a small category
   or interface refinement, but only if the main path-related work is
   already in good shape

Risks and mitigation

One risk is that design discussion may take longer than expected,
especially around path representation and output structure.

To reduce that risk, I would keep the patch series small and prioritize
the least controversial values first.

Another risk is overlap with work already in progress. If that happens,
I would adjust the project scope to avoid duplication and focus on what
is still useful and open.

Why I think I am a good fit

I have already started learning Git's normal contribution workflow
through a microproject, including building Git from source, running
tests, preparing patches, responding to review, and rerolling them on
the mailing list.

This project is a good fit for me because it requires exactly the kind
of work I have already started doing in Git: reading existing code
paths carefully, making small user-visible improvements, and refining
the result through review rather than trying to force a large one-shot
design.

References

Official and technical references

SoC 2026 idea page
https://git.github.io/SoC-2026-Ideas/

General application information
https://git.github.io/General-Application-Information/

git repo documentation
https://git-scm.com/docs/git-repo

git rev-parse documentation
https://git-scm.com/docs/git-rev-parse

git-sizer project
https://github.com/github/git-sizer

Relevant mailing list threads

Recent patch series adding path-related support to git repo
https://public-inbox.org/git/20260228224252.72788-1-lucasseikioshiro@gmail.com/

More recent work-in-progress series for category and path keys and
path-format
https://public-inbox.org/git/pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com/

Recent GSoC proposal thread on improving the new git repo command
https://public-inbox.org/git/20260303140732.16886-1-pushkarkumarsingh1970@gmail.com/

Another recent GSoC proposal thread on improving and extending git repo
https://public-inbox.org/git/CA+rGoLd-1Mb5JG1H1PvE-kyjdznrLVFjwQiMLHtd2ETQ-igmXg@mail.gmail.com/

Recent proposal thread focused on the same SoC idea
https://public-inbox.org/git/CAO_P5U3g_+RpnDUmEv_qX-3GVhpxLV97eMxP1apERc0KU_95tQ@mail.gmail.com/

Recent discussion around git repo structure enhancements
https://public-inbox.org/git/CAO_P5U2f4MD-URre+4ocC=YQ570hr03pZHDk1jvuSOKx4aLOCA@mail.gmail.com/

Microproject discussion thread
https://public-inbox.org/git/CAKWWG_nGhD6vqhAS1mkEwBQPrg_YX0+C3-xW=Q3ifFDw4dDviw@mail.gmail.com/

Microproject patch thread
https://public-inbox.org/git/20260315231538.68586-1-jerrywang183@yahoo.com/

Review on the microproject patch thread
https://public-inbox.org/git/CAOLa=ZTpfHUySnMgCFMnvo2JcRSv8zqFP-cLFSs+Ab5Cy2zsvg@mail.gmail.com/

Follow-up patch for header parsing errors
https://public-inbox.org/git/20260316195847.92386-1-jerrywang183@yahoo.com/

Follow-up patch for binary and garbage patch errors
Sent to the mailing list; public archive link to be added once indexed.
Subject: [GSoC PATCH] apply: report input location in binary and garbage patch errors


Thanks,
Jialong
