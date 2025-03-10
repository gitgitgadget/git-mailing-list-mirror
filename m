Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1971F09B4
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646355; cv=none; b=tZHm82tm5VtmPiEqFDoUAOd5y97bWL2FuPdNv1h89Gr7r0QlDMLBEjze0RZjOOeqi8wkpyWfRB9DCw7ZaRs/+wdTZ0wtJKelIUtRXa5A1Wc2oMZ1gsxvmVwYtRBm98Sk9mLHw41M32hxGTzGtDuc8VhSXfHPPOXLM9CAbUbRHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646355; c=relaxed/simple;
	bh=tacZdsKk11vJjRYPfZoSQ63yfmGbKv2+LPa9cdFcMiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGN8Pg0Er2pbwaJp8ko8p0Zbh0SMNtsyRf9+9/OtdhHL/AoOoNZVKesbxI2yCuAwJjS2bxwLTK8IqRE7LnSE4o+l6L3O3l9DJ7vT5sm+JxpiQOtUdMbz1eqIHSX/SR3mq0zg+HINTtpTAhnK3O0dwD4A7m3ba4UojWGr6t40EsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea7Y+wKo; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea7Y+wKo"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-854a68f5afcso114657139f.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741646353; x=1742251153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Gwnrb2jX8T1EOC8NR/eOlFBr6e48EMNLVkC4VArtg0=;
        b=Ea7Y+wKopiNNKSZZejP0JRjcY5NBg6rZSA+YW2Cb4SIgJieoh71CokBBdpMSJjCY/L
         WqVdR3BhxdJ8ZxU02J60yHs+K4jddE/SC03Eq9fOpOfVMF4DO+bBCdd3erE4Ufy0csht
         kT8LLyb6zR12ZjuPbB6ztaZSRj7G3J0smK+OG19/JEEMREh8iui5TTgnU2D/4PzNU/h+
         4An8lqpgcvykXS3VtrWPefZeZWp55AHpqmLL8TQNbkLFtGJUgTQcGzNv8tX7y3ESXzjg
         /TmysJpHOMikM4bjVqYdOO9AXRti645jKsWMxY+0dTOJxuy80YTJ2bhJ4VghEkcCCfHL
         6KIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741646353; x=1742251153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Gwnrb2jX8T1EOC8NR/eOlFBr6e48EMNLVkC4VArtg0=;
        b=c4LzbCXxrNPNu63n/KFlebCupOG5n9f7vu/EwTTM102UIqPV7gWl/OJnFX7vlf2dIp
         MVHXDEL6e11eJscsen4oTpF8GXX+0FV67sX7KYhLue5zPfK3kWtaNaN/O2cSWh38KI9n
         TSfNciguXfE/QjxUjG35O7+kuiTbPG040XPqqKi2KEdsnN5hiUhL1HWlCfM28V6qptOx
         vB81O7xXI85z6nVwPGAkp0aMsPHL3XV1aKkw+Mgft5abI8CVUxCBgsNLIN37DdNoLPjs
         9Gt9BwgcmM7hdopVEBfJzp8JgNNWIwYbJxAxSfr8s+sv6L1bO/ToNTT3WFe3BDR/0j3H
         oKVQ==
X-Gm-Message-State: AOJu0Yw3WltZRR8/OmPP+ToCH8Sbdu6PL6dv37H+JINytkN+XqbxxErT
	BERZUSaILI777i5mHLIr1SJE0c6RXqknsdytFWenCm+c9TghjNlcDnnZHR6UuXXGJs3H7vZ5DQk
	cspOBUM5hqPbRLMQ5A8Dv/xWc9qU=
X-Gm-Gg: ASbGncujfpxTfQxyR2jlpFIAJP386SvNxCwnu5UKp/O0SzWYpKhl8VgByJ14Xz5rPxW
	RKhoM8HIPun9RnJN0QVptKuqYnoyC9Y7AlHhi+2jJifL7t+3LsJxWUMaV/koRzzVooR+AndBAWr
	+W75mMSk0gOa5sg0YvbRVBP1vtcesHUCU4Yf6HoS4IPg0hwQg9ZOUW/7Fm02M=
X-Google-Smtp-Source: AGHT+IEI1sM4qj5GE9cVPTUMmHK9/Ldq4hMorzvIupQzX3vKnXsmc8MuwqzELRc++x1RNMdm5qgpO8nD7pgeB1nEaOA=
X-Received: by 2002:a05:6e02:240a:b0:3d0:10ec:cc36 with SMTP id
 e9e14a558f8ab-3d441990a54mr155943855ab.11.1741646352740; Mon, 10 Mar 2025
 15:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
In-Reply-To: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 10 Mar 2025 15:39:01 -0700
X-Gm-Features: AQ5f1Jo1xsBi0SZ5MwvchbI-uCKe9jChhv_yRHrWJKPUUrfgWcFcpK4xQ1dZXR4
Message-ID: <CABPp-BFrjqf=dMNwxzyMj3EQrAXTYkH7rDTi7X7xoWnoW_A4eA@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Stop depending on `the_repository` in
 object-related subsystems
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 12:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> Hi,
>
> this patch series is another step to remove our dependency on the global
> `the_repository` variable. The series focusses on subsystems related to
> objects.
>
[...]
> Changes in v4:
>   - Fix indentation in one of the commit messages.
>   - Link to v3: https://lore.kernel.org/r/20250307-b4-pks-objects-without=
-the-repository-v3-0-7bccf408731e@pks.im

Thanks, v4 looks good to me.

>
> Thanks!
>
> Patrick
>
> ---
> Patrick Steinhardt (12):
>       csum-file: stop depending on `the_repository`
>       object: stop depending on `the_repository`
>       pack-write: stop depending on `the_repository` and `the_hash_algo`
>       environment: move access to "core.bigFileThreshold" into repo setti=
ngs
>       pack-check: stop depending on `the_repository`
>       pack-revindex: stop depending on `the_repository`
>       pack-bitmap-write: stop depending on `the_repository`
>       object-file-convert: stop depending on `the_repository`
>       delta-islands: stop depending on `the_repository`
>       object-file: split out logic regarding hash algorithms
>       hash: fix "-Wsign-compare" warnings
>       hash: stop depending on `the_repository` in `null_oid()`
>
>  Makefile                                     |   1 +
>  archive.c                                    |   4 +-
>  blame.c                                      |   2 +-
>  branch.c                                     |   2 +-
>  builtin/checkout.c                           |   6 +-
>  builtin/clone.c                              |   2 +-
>  builtin/describe.c                           |   2 +-
>  builtin/diff.c                               |   5 +-
>  builtin/fast-export.c                        |  10 +-
>  builtin/fast-import.c                        |   8 +-
>  builtin/fsck.c                               |   6 +-
>  builtin/grep.c                               |   4 +-
>  builtin/index-pack.c                         |  16 +-
>  builtin/log.c                                |   2 +-
>  builtin/ls-files.c                           |   3 +-
>  builtin/name-rev.c                           |   4 +-
>  builtin/pack-objects.c                       |  17 +-
>  builtin/prune.c                              |   2 +-
>  builtin/rebase.c                             |   2 +-
>  builtin/receive-pack.c                       |   2 +-
>  builtin/submodule--helper.c                  |  36 ++--
>  builtin/tag.c                                |   2 +-
>  builtin/unpack-objects.c                     |   5 +-
>  builtin/update-ref.c                         |   2 +-
>  builtin/worktree.c                           |   2 +-
>  bulk-checkin.c                               |   4 +-
>  combine-diff.c                               |   2 +-
>  commit-graph.c                               |   9 +-
>  commit.c                                     |   2 +-
>  config.c                                     |   5 -
>  csum-file.c                                  |  28 +--
>  csum-file.h                                  |  12 +-
>  delta-islands.c                              |  14 +-
>  delta-islands.h                              |   2 +-
>  diff-lib.c                                   |  10 +-
>  diff-no-index.c                              |  28 +--
>  diff.c                                       |  14 +-
>  diff.h                                       |   2 +-
>  dir.c                                        |   2 +-
>  environment.c                                |   1 -
>  environment.h                                |   1 -
>  grep.c                                       |   2 +-
>  hash.c                                       | 277 +++++++++++++++++++++=
++++
>  hash.h                                       |   4 +-
>  log-tree.c                                   |   2 +-
>  merge-ort.c                                  |  26 +--
>  merge-recursive.c                            |  12 +-
>  meson.build                                  |   1 +
>  midx-write.c                                 |  12 +-
>  midx.c                                       |   3 +-
>  notes-merge.c                                |   2 +-
>  notes.c                                      |   2 +-
>  object-file-convert.c                        |  29 +--
>  object-file-convert.h                        |   3 +-
>  object-file.c                                | 292 +--------------------=
------
>  object.c                                     |  21 +-
>  object.h                                     |  10 +-
>  pack-bitmap-write.c                          |  36 ++--
>  pack-bitmap.c                                |  15 +-
>  pack-bitmap.h                                |   1 +
>  pack-check.c                                 |  12 +-
>  pack-revindex.c                              |  35 ++--
>  pack-write.c                                 |  55 +++--
>  pack.h                                       |  11 +-
>  parse-options-cb.c                           |   2 +-
>  range-diff.c                                 |   2 +-
>  reachable.c                                  |   6 +-
>  read-cache.c                                 |   4 +-
>  refs.c                                       |  12 +-
>  refs/debug.c                                 |   2 +-
>  refs/files-backend.c                         |   2 +-
>  repo-settings.c                              |  20 ++
>  repo-settings.h                              |   5 +
>  reset.c                                      |   2 +-
>  revision.c                                   |   3 +-
>  sequencer.c                                  |  10 +-
>  shallow.c                                    |  10 +-
>  streaming.c                                  |   3 +-
>  submodule-config.c                           |   2 +-
>  submodule.c                                  |  28 +--
>  t/helper/test-ref-store.c                    |   2 +-
>  t/helper/test-submodule-nested-repo-config.c |   2 +-
>  t/t1050-large.sh                             |   3 +-
>  tree-diff.c                                  |   4 +-
>  upload-pack.c                                |  14 +-
>  wt-status.c                                  |   4 +-
>  xdiff-interface.c                            |   2 +-
>  87 files changed, 677 insertions(+), 613 deletions(-)
>
> Range-diff versus v3:
>
>  1:  01b5b16c3a4 =3D  1:  9d65ce9a2f2 csum-file: stop depending on `the_r=
epository`
>  2:  14e0349be2f =3D  2:  038c6e54308 object: stop depending on `the_repo=
sitory`
>  3:  9c7b8a031cc =3D  3:  9abd1306d6a pack-write: stop depending on `the_=
repository` and `the_hash_algo`
>  4:  e0168b431e7 =3D  4:  605fb2a7176 environment: move access to "core.b=
igFileThreshold" into repo settings
>  5:  529f296a935 =3D  5:  dc88e5ca6b2 pack-check: stop depending on `the_=
repository`
>  6:  d4a2e9a7861 =3D  6:  fee92049913 pack-revindex: stop depending on `t=
he_repository`
>  7:  15e4d4de519 =3D  7:  f8ff74c83cf pack-bitmap-write: stop depending o=
n `the_repository`
>  8:  576d846495f =3D  8:  47547d3f566 object-file-convert: stop depending=
 on `the_repository`
>  9:  faf0f90a005 =3D  9:  39da917072f delta-islands: stop depending on `t=
he_repository`
> 10:  b37879d101c =3D 10:  a509d63ee74 object-file: split out logic regard=
ing hash algorithms
> 11:  4a1a5c67792 =3D 11:  421f1e96595 hash: fix "-Wsign-compare" warnings
> 12:  f45a7866d03 ! 12:  1b0b8f71125 hash: stop depending on `the_reposito=
ry` in `null_oid()`
>     @@ Commit message
>              object in the superproject, and consequently we need to use =
its hash
>              algorithm.
>
>     -    This means that we could in theory just not bother about this ed=
ge case
>     -    at all and just use `the_repository` in "diff-no-index.c". But d=
oing so
>     -    would feel misdesigned.
>     +        This means that we could in theory just not bother about thi=
s edge
>     +        case at all and just use `the_repository` in "diff-no-index.=
c". But
>     +        doing so would feel misdesigned.
>
>          Remove the `USE_THE_REPOSITORY_VARIABLE` preprocessor define in
>          "hash.c".
>
> ---
> base-commit: e2cb568e11f4ceb427ba4205e6b8a4426d26be12
> change-id: 20250210-b4-pks-objects-without-the-repository-6ba8398f7cc0
>
