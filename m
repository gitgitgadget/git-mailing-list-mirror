Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91A526ED4F
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380719; cv=pass; b=grgVWyjW+HaW2m/WGgP/5JZ/xp1E/W9oGaZNBxzKu9+O2EEkuB8A4e9uqVOw+03eFPs65/gBsX6zhWHwHvyDkeWXDhhJ1UdgsCBfOiSSN6eXzSQgRYZdtg4y96vzjT9r9AoCtYc1vYR9qLcQ6VOvcAF8ZyFc2aCN3B7t3pLO0Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380719; c=relaxed/simple;
	bh=sgj+/QbgbLI3GGUrkVIcrTA6X8qg37CfpUfOilzgTug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpiPwAc5lDNQGyM2Zd+KgAyWjKiOZML2FlsJiMuJbuMfOuyrOXLXuX7WdQ4+em0HD+ziIyqS+xCp0Z+ED6y7kHvYx7wyEaFuA7lnLfqg4AmtDrjKwamir+V5KxReHA3SuBbzzdZ65bfn+sPSLUp1ouR52+PkRqc+F8FjWA6Hstw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MV8xBiPX; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV8xBiPX"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89c4feaaeb4so67735466d6.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774380716; cv=none;
        d=google.com; s=arc-20240605;
        b=h35y0UZfjE0EWKj1ncU1iKNHtzMUA3Ck/kv9Gm5Fmww0q8H++opVsbp8emLU/vVk0L
         tclgq3/YsUeGLdAmJrBRwCyu2tQpieS4uytWZT9E6k+zCZnhqugSApCFMQ19n/AVoczk
         gcLpLr63G95RuBRnJspWWhbb4zGu0OBO0sf4615NX1eT21H0EaHtHUXyGcyfdq06xPEE
         RFrOc0ITs5Flhmc7VXQ0mvibsxDgzO5G5eNLUmm0825OJ+J4XKUxy2ILD0hSqpPyhrEO
         1jgcNl8yyZx7Uxcro3O7yF0PXvVnImoUC2pxp/mcPlH1v7tpHdNyirddmKwl7+A2Bbr3
         prHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Au4A8dQWmOD9HCY2A7bx7hy+s/Xyp/oyzfCQQsNnuNA=;
        fh=ZWefIzu01QZwQsoKV6aSinn4xFv/uesKmpPoR9xiS1s=;
        b=F59ytkO4jzVO5gfGLah9f1lyFpVgmNcbsnUWj0rTypvzrWlZ2I5nEE/33p7ssxdfdg
         ueVH5IWDT/uZF4axixYF2vMIF2JPS5h15RFjBNjJMiDeiAWV0reBXxJh8drmdoUJLL8I
         wvRcXBK0PGU026EGz/8wHfKqjvcJyVeBzI6ANdp+/R0ByHWJuoSxHSOGu/ssHHUZ8hnB
         eK1x7DnLlVjl2Ks0x/77P+xsCra+Wd79wShTyRuaBbx/7JLx4Hor9SCuu7ULOLw291Zp
         OVws4IQsBqKSYGwqsj+HqypIKUdzelvN/10quMqWWOFNGoXYZMrWpZtzjfdvfpYT1kv4
         G55Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774380716; x=1774985516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Au4A8dQWmOD9HCY2A7bx7hy+s/Xyp/oyzfCQQsNnuNA=;
        b=MV8xBiPX9y8HfqhcXG47qOehzBNyJyrCuv7Br/gqaxMcqWYEerRG4OTLDe8C8Bj0zK
         y6AofF4RWtarVsCLE8vskb/XQufMhYKWSrNAxuRwfB68tDnJRCxOeQIu9viebcXbtK9V
         DWZRX6FhOnAmqilPT8J8iPB33j9GNoBaQJS4QJSdQzUyZ4yQA4Ihjlae1G4k9yvGfvga
         dBgMmtEHix+k6do3OJ+N1VaOZhxgF2OQ75NXXvw9EpNNiAFI1PaSSIpD1gOgYZpRADrY
         P/kO6e2q992k5SDWp7lW2+KLEsOAoxM+ScvSgqeZmH1w0K+gDCcldDPUmUf/yS6vqZop
         VQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774380716; x=1774985516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Au4A8dQWmOD9HCY2A7bx7hy+s/Xyp/oyzfCQQsNnuNA=;
        b=L+pglhjQE1FowHFKHGhIhTQcit57w6Pj5SI0xL7IXTTunVkwZGi8okyhvXHyFOehLA
         Lcu4QP02ptcCrlXNCKY19cPBLnsOMAe+musJrGnqwiQgIQzz5VJ0UHuj1DUOHflBcLK0
         pZF1mAoL6pp5mM4m5FCV+TaK+yzuR0VZVDNN6dX82RtoAXtAn5V5xF1jC2nHXWUmROv1
         NEhMbN5dc8teFAaegP3gFYeSEDYApC3CK+mn5KfRr1chhap6zC/vmMOX+i5PJv7BtmO3
         d+zvQ/gDfr/t5SGoU0YOY1y7lcz0v+T6YeTYl+4wCW2V9JgAcs+PSYBNyTHOpLzgauix
         IkGA==
X-Gm-Message-State: AOJu0YzU9QdQs1wwMbETD5N/MlQzH8gqNjfPqtjOjkE2d8chh292sjPK
	iVz6LNPbYpQqr1BkadZ7hSCqc8TNJiM1fxh9GNsLGYTC6NMDZMOehq6vxubseczmsVJ0xl9wUIy
	zFCPAiQuKMwex9tY8ROIYE/Fg66b6k/+cL+IxqA==
X-Gm-Gg: ATEYQzx55CVBzRgEDOV4tRY/klAEF+PPE7debnkOLA2y1eJz2ArwfAggRHKKUyTPOmn
	RkI7z0URtr17CK5DmLtUFuLUMMYY9nA0ZlWLcPjEs3TQGBHQuIw+76UXVHwMoZSLKwYpeiqRYWn
	LOwGG9Br+5jD07D7f//ZdNysrYdHZa7dPMPAP4iA3JwxLLwW5N8OJI3WM7xMNEpGntQ4/t6VwCC
	kQh/PK7/2t2hJR3dntqm/VKCfyyqrbw3Phnqz+TK88pZGAr4ho3Zw9YJ+NoHJQ49jMYIFsqR3+Y
	sj9HOWcjERDlzv8v1oSRRuFXwFV96xpK6o6lzQ==
X-Received: by 2002:a05:6214:483:b0:89c:621d:981b with SMTP id
 6a1803df08f44-89cc4a49eeemr14866016d6.40.1774380716050; Tue, 24 Mar 2026
 12:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEaT9_9jAoXkxKn+2+q654aKybC1=bk6p7xiVHmcy+YDDe7GXw@mail.gmail.com>
In-Reply-To: <CAEaT9_9jAoXkxKn+2+q654aKybC1=bk6p7xiVHmcy+YDDe7GXw@mail.gmail.com>
From: Francesco Paparatto <francescopaparatto@gmail.com>
Date: Tue, 24 Mar 2026 20:31:44 +0100
X-Gm-Features: AaiRm50Wi9ZgXQd2xACxPjeK4tEXXweqNaE2paZirhyZRxw_OBlUL8RvhgRtXWM
Message-ID: <CAEaT9_9vYVWBjYVfdkipTO85NE93XbZqrKGMAd5FAC6BLtnhwg@mail.gmail.com>
Subject: Re: [GSoC Proposal v2] Refactoring in order to reduce Git's global state
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	jltobler@gmail.com, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is my second version of GSoC 2026 Proposal for the project
'Refactoring in order to reduce Git=E2=80=99s global state'.

Doc version: https://docs.google.com/document/d/1xknrv88MnFPidpCbGoK43oAH3r=
lb_Iiu7Ufx42A3krw/edit?usp=3Dsharing

Changes from v1:
- Added Doc version of the proposal
- Added commit IDs for patches merged to master.
- Added reference to Olamide Bello's latest series [10].
- Added "Remaining Work" section with variable classification
  based on codebase analysis of the Olamide Bello latest series,
  as suggested by Christian [11].

---

Refactoring in order to reduce Git's global state

Personal Information
--------------------
Name: Francesco Paparatto
Pronouns: he/him
Location: Milan, Italy
Timezone: CET (UTC+1)

Email: francescopaparatto@gmail.com
GitHub: https://github.com/frapaparatto
LinkedIn: https://www.linkedin.com/in/francesco-paparatto/

About Me
--------
I am Francesco Paparatto, a self-taught programmer who dropped out
of a degree in Management to dedicate full-time to software
engineering.

My goal is to work as a Backend/Infrastructure Engineer,
and to reach that goal I am balancing CS fundamentals through
theoretical courses with challenging projects that help me develop
strong engineering skills, not only from a code perspective but also
from a system thinking point of view. I also like building
fundamental things from scratch in order to understand how they work.

This is my first time in open source and I am fascinated by this
world. I wish to become a cornerstone in one open source community.

Git Experience and Contributions
---------------------------------
I started learning Git in depth at the beginning of 2026 when I
began working on my cgit project [1], a small reimplementation of
Git's core plumbing commands in order to understand how they really
work under the hood, but also as a way to start reading and learning
from real codebases and learn how to design and structure code
properly.

So far, I have made the following contributions:

* [GSoC PATCH v2] t3310: replace test -f/-d with
  test_path_is_file/test_path_is_dir
  Status: Graduated to 'master'.
  Link: https://lore.kernel.org/git/20260228005939.9012-1-francescopaparatt=
o@gmail.com/
  Commit: f31b322008c526693660770e66c12f4bcfd29558

* [PATCH v4] t3310: avoid hiding failures from rev-parse in
  command substitutions
  Status: Graduated to 'master'.
  Link: https://lore.kernel.org/git/20260307103631.89829-1-francescopaparat=
to@gmail.com/
  Commit: d3edca979a1e916518bc2376e468609ddae2a217

Overview
--------
Git's internal functions rely heavily on global state stored in
environment.c. Configuration values like trust_executable_bit,
editor_program, and git_commit_encoding are declared as file-scope
globals and populated at startup through git_default_config() and
its sub-handlers like git_default_core_config().

This design assumes a single repository per process. When Git is
used as a library (libification) or needs to handle multiple
repositories in the same process, globals from one repository
overwrite values from another. For example, two threads formatting
commits for repositories with different i18n.commitEncoding settings
would race on the same git_commit_encoding pointer.

The goal of this project is to move these global variables into
per-repository structures within struct repository, following the
pattern established by Olamide Bello's Outreachy work with struct
repo_config_values [2].

Context and Prior Work
-----------------------
Not all config variables can be treated in the same way. There is
a fundamental distinction between eagerly and lazily parsed
variables, and conflating the two causes regressions.

Variables set in git_default_core_config() are eagerly parsed. They
are read at startup, and if a value is invalid, Git calls die()
immediately with a clear error before doing any real work. The user
gets early feedback and can fix their config.

Variables in struct repo_settings are lazily parsed. They are
populated on first access via prepare_repo_settings(). If an eagerly
parsed variable is naively moved into this struct, invalid config
that used to crash at startup now crashes mid-operation.

During GSoC 2025, Ayush Chandekar moved several global configuration
variables into repository-scoped structures [3]. Through this work
and subsequent review discussions, the eager/lazy problem became
visible [4].

Ayush's work also surfaced the getter/setter debate. When he
introduced getter and setter functions for repo_settings fields,
reviewers pointed out they added no value without calling
prepare_repo_settings() internally. From this discussion, Junio
suggested two approaches for repo_settings variables that must
not be mixed [5]:

- Common variables: populated in prepare_repo_settings(), accessed
  directly via repo->settings.foo. No getter, no setter.
- Rare variables: prepare_repo_settings() does not touch the field.
  A lazy getter checks a sentinel value (e.g. -1), reads from
  config on first access, and caches the result.

The appropriate pattern for each variable will require reasoning
and discussion on the mailing list.

Phillip Wood suggested a third approach: passing a
repository pointer through git_default_config() via the void *cb
callback data parameter, so handlers can populate per-repo structs
without touching globals [6].

Building on these lessons, Olamide Bello during the Outreachy
program introduced struct repo_config_values [2], a structure
linked to struct repository that stores eagerly parsed configuration
values while preserving their startup-time error detection. An
accessor function repo_config_values() enforces safety by preventing
access from uninitialized repositories and guarding against access
from secondary repository instances that do not yet have their
config populated.

So we now have two structs living inside struct repository:
repo_settings for lazily parsed variables, and repo_config_values
for eagerly parsed variables.

Approach
--------
I will follow the pattern established in Olamide Bello's approved
patch series [2], which provides the concrete workflow for each
variable:

1. Add a new field to struct repo_config_values in environment.h.
2. Initialize the field in repo_config_values_init().
3. Update the config callback: get cfg via
   repo_config_values(the_repository), write to cfg->field instead
   of the global.
4. Update all call sites: replace the global with cfg->field.
5. Remove the global from environment.c and the extern from
   environment.h.
6. Run tests and check fuzz targets.

Additionally, when a variable is also written by CLI options (e.g.,
OPT_INTEGER or OPT_BOOL in builtin/*.c), those option definitions
must also be updated to point to cfg->field. If only the config
path is updated and the CLI path is missed, CLI values silently
stop working. This was caught during review of Bello's
pack_compression_level patch [10].

This workflow is not purely mechanical. Each variable requires
case-by-case analysis:

- Is the variable per-repository? Some variables like
  editor_program are user preferences. As Phillip Wood asked [7],
  variables where per-repo scoping does not make semantic sense
  may be better handled by localizing them to their subsystem.

- How deep is the call chain? As preparation for this proposal, I
  traced askpass_program end-to-end. It has a single reader in
  prompt.c, which looks simple. But git_prompt() is called from
  two paths: the credential system and the bisect system. The
  difficulty of a variable is not about reader count, it is
  about call chain depth.

- Are there initialization ordering constraints? Some variables
  like is_bare_repository_cfg are set during .git directory
  discovery, before struct repository is fully initialized.
  Moving them into the repository struct creates a chicken-and-egg
  problem that requires design discussion on the mailing list.

- Are there dependent variables? Some variables must be migrated
  together. For example, comment_line_str_to_free and
  auto_comment_line_char are set in the same config callback and
  read together in builtin/commit.c. Migrating one without the
  other would leave half the state global and half per-repo.

- Does the variable have CLI interaction? Variables written by
  command-line options via OPT_INTEGER, OPT_BOOL, etc. need both
  the config path and the CLI path updated.

The macro #define USE_THE_REPOSITORY_VARIABLE, introduced by
Patrick Steinhardt [8], controls access to the_repository
global. The macro serves both as a migration indicator and a
technical gate. When all globals in a file have been migrated
and all functions receive struct repository * explicitly,
the macro can be removed.

Following Stolee's two-step migration model [9], I will first
move variables into repo_config_values using the_repository
(Step 1: safe, mechanical, no behavior change). For selected
variables with shallow call chains, I will also thread struct
repository *repo through callers to begin replacing direct
the_repository usage (Step 2).

I propose a dual approach for organizing the work:

- Variable-focused migration: move environment.c globals into
  repo_config_values following Bello's pattern. This is the
  primary track. For each variable, I classify it, trace readers,
  migrate it, and remove the global.
- File-focused cleanup: for files where only a few the_repository
  usages remain after variable migration, complete the cleanup
  and remove USE_THE_REPOSITORY_VARIABLE entirely. This is a
  natural side effect of the first track.

Some variables may need a hybrid approach: when a variable is
used across many files but heavily concentrated in one subsystem,
it may make sense to migrate it alongside other globals in that
subsystem rather than in isolation.

The two tracks reinforce each other: migrating a variable often
removes the last reason a file needs the macro.

Remaining Work and Variable Classification
--------------------------------------------
Olamide Bello's merged series [2] migrated: git_attributes_file,
core_apply_sparse_checkout, and git_branch_track.

His latest series [10] addresses: trust_ctime, check_stat,
zlib_compression_level, pack_compression_level, precomposed_unicode,
core_sparse_checkout_cone, sparse_expect_files_outside_of_patterns,
and warn_on_object_refname_ambiguity.

After those series, approximately 20+ variables remain in
environment.c. I analyzed them and classified a representative
set below, grouped by difficulty and type of challenge they
present.

Straightforward per-repo booleans (few readers, no CLI
interaction, clearly filesystem-dependent):

* trust_executable_bit (core.filemode)
  Eagerly parsed in git_default_core_config() at
  environment.c:307. Determines whether the filesystem
  correctly represents executable bits. Per-repo because
  different repos may live on different filesystems (e.g.,
  FAT32 does not support executable bits, ext4 does). Git
  probes this during init/clone.

  Reader files: apply.c, read-cache.c, read-cache.h (3 files).
  No CLI interaction.
  Note: used together with has_symlinks in read-cache.c:744,
  migrating both in the same series would be clean.

* has_symlinks (core.symlinks)
  Eagerly parsed in git_default_core_config(). Determines
  whether the filesystem supports symbolic links. Same
  rationale as trust_executable_bit: filesystem-dependent,
  clearly per-repo.

  Reader files: apply.c, combine-diff.c, compat/mingw.c,
  entry.c, read-cache.c, read-cache.h (6 files).
  No CLI interaction with the global. Note: builtin/difftool.c
  has its own local has_symlinks field inside struct
  difftool_options. This is a separate variable with the same
  name, not the global.

Ambiguous per-repo semantics (require mailing list discussion):

* editor_program (core.editor)
  Eagerly parsed in git_default_core_config() at
  environment.c:438. Sets the default editor. Phillip Wood
  questioned whether per-repo scoping makes sense [7], since
  it is a user preference rather than a repository property.

  Reader files: editor.c (1 file). Very shallow call chain
  but the design question must be resolved first.
  No CLI interaction. No dependencies.

Dependent variables (must be migrated together):

* comment_line_str_to_free and auto_comment_line_char
  (core.commentchar, core.commentstring)
  Both eagerly parsed in the same config callback in
  git_default_core_config(). auto_comment_line_char is a
  boolean flag controlling whether Git auto-selects a comment
  character that does not conflict with the commit message.
  comment_line_str_to_free stores the actual string used.
  They are set together and read together in
  builtin/commit.c. Migrating one without the other would
  leave half the state global and half per-repo.

  Reader files: builtin/commit.c (1 file for both).
  No CLI interaction.

High reader count (significant effort):

* ignore_case (core.ignorecase)
  Eagerly parsed in git_default_core_config(). Enables Git
  to work on case-insensitive filesystems. Clearly per-repo
  (filesystem-dependent, probed during init/clone).

  Reader files: apply.c, dir.c, fsmonitor.c, name-hash.c,
  read-cache.c, refs/files-backend.c, submodule.c, ... (15+ files)

  Note: many builtin/ files (grep.c, branch.c, tag.c,
  for-each-ref.c) have their own ignore_case fields in local
  structs. These are separate from the global. Careful
  analysis is needed to distinguish global usage from local
  usage.

Other remaining variables that will be classified during the
community bonding period:

  minimum_abbrev, default_abbrev, assume_unchanged,
  git_commit_encoding, git_log_output_encoding,
  apply_default_whitespace, apply_default_ignorewhitespace,
  fsync_object_files, use_fsync, fsync_method,
  fsync_components, askpass_program, excludes_file,
  auto_crlf, core_eol, global_conv_flags_eol,
  check_roundtrip_encoding, autorebase, push_default,
  object_creation_mode, grafts_keep_true_parents,
  pack_size_limit_cfg, protect_hfs, protect_ntfs,
  git_work_tree_cfg.

Timeline
--------
Project size: 175 hours.

Community Bonding (May 1 - May 25):
- Discuss project direction and design approaches with mentors.
- Study Bello Caleb's and Ayush Chandekar's patches in depth.
  Review remaining repo_config_values work and identify
  unfinished tasks.
- Complete classification of remaining variables listed above.
- Start discussions for ambiguous cases on the mailing list.
- Submit an RFC patch following Bello's pattern to validate
  the workflow before the coding period begins.

Coding Period (May 26 - August 16):
- Start with straightforward variables: filesystem-dependent
  booleans like trust_executable_bit and has_symlinks. These
  have few readers, clear per-repo semantics, and no complex
  parsing.
- Progressively move to more involved variables: string-type
  values like excludes_file, dependent pairs like
  comment_line_str_to_free and auto_comment_line_char, and
  high-reader-count variables like ignore_case.
- Apply the dual approach described above:
  + Variable-focused migration: classify, trace, migrate, and
    remove globals following Bello's pattern.
  + File-focused cleanup: where variable migration removes the
    last global dependency in a file, complete the cleanup and
    remove USE_THE_REPOSITORY_VARIABLE.
- Submit small patch series (3-5 patches each) frequently to
  respect reviewers' time and maintain steady velocity.
- Maintain two parallel series: one in review and one being
  written, to account for review cycle delays.
- Continuously iterate: incorporate mailing list feedback,
  reroll patches (v2/v3), and refine the approach based on
  community input.
- Publish weekly blog updates documenting progress and design
  decisions.

Final period (August 17 - August 24):
- Address any remaining tasks or pending patches.
- Update internal documentation.
- Receive final feedback from mentors and reviewers.
- Prepare and submit the final project report.

A 30% buffer is built into the schedule to account for
unexpected review delays and design discussions.

Blogging
--------
I believe blogging is an important part of growing as a developer
and an effective way to learn, because writing forces you to
truly understand what you are working on.

I plan to publish weekly updates documenting my journey through this
project: progress, design decisions, challenges, and lessons
learned. I also want these posts to serve as a valuable resource
for anyone who, like me today, will look for guidance on
contributing to Git or to open source projects in general.

Availability
------------
Git will be my top priority. I have no other commitments
scheduled during the GSoC period, so I will be able to work on
this full-time. In fact, I plan to devote 35=E2=80=9340+ hours per week
to the Git project. My preferred working window is 9:00-18:00 CET.

Post-GSoC
---------
Contributing to Git has been an invaluable experience.
Not only on a personal level because it pushed me out of my
comfort zone and challenged me but also, and above all, on a
professional level. The feeling of working on code used by millions
of developers and companies around the world is incredibly rewarding.

This iterative process of discussions, writing code, and receiving
feedback helps you grow tremendously as a developer and
especially quickly.

Being exposed to a codebase like Git=E2=80=99s forces you to think much mor=
e
deeply, to understand how everything works and how it connects
to the rest of the program. For these reasons, I intend to continue
working on Git even after GSoC by contributing patches, participating
in discussions, and reviewing new members=E2=80=99 code.

Furthermore, this refactoring process is a long-term effort,
and I=E2=80=99d like to keep working on it.

References
----------
[1] https://github.com/frapaparatto/cgit
[2] https://lore.kernel.org/git/cover.1768217572.git.belkid98@gmail.com/
[3] https://lore.kernel.org/git/20250603131806.14915-1-ayu.chandekar@gmail.=
com/
[4] https://lore.kernel.org/git/17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.=
com/
[5] https://lore.kernel.org/git/xmqqbjquge0c.fsf@gitster.g/
[6] https://lore.kernel.org/git/d61c966b-61ae-4ba9-b983-c8dab6e2c292@gmail.=
com/
[7] https://lore.kernel.org/git/8e657184-ee0b-453a-9f2d-a98080d3582e@gmail.=
com/
[8] https://lore.kernel.org/git/cover.1718347699.git.ps@pks.im/
[9] https://lore.kernel.org/git/47d09c43-6d27-40ff-8dbc-22cc4a5949ed@gmail.=
com/
[10] https://lore.kernel.org/git/cover.1773127785.git.belkid98@gmail.com/
[11] https://lore.kernel.org/git/CAP8UFD1H8ZsxfGSnnvX9xkKLSSpDjA3e3KNZ7eHN3=
ruq-sC7fw@mail.gmail.com/
