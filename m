Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB5377007
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475695; cv=pass; b=b7vpkZNEzKPw+VZJAyY2PgmK34C9e5bJAwupjL0+eF/CsecCIFGMoeTQV8Vchs3gYa51Y4QnALsOVJ5DG4vnfe6w/CDdk3fFLu2k0Z+FQBvm2oBzMZiulAb+ptYMa+FYy2SCCIhICLjbTEyFWm6XbXZbqHGeFkmIdKDVop+Bx/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475695; c=relaxed/simple;
	bh=gadUTJrt24TullqfX5DYrP7vlkbL2rRPKMV8SM+iWEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYoCKOn2Rihxfj+U43g5mhvTgX8oxRghDnN5SQx94NjOqSEFBkmf5l29JuQZPpfLFPliM5BfjL40/ffrCE5IIqtuOQ6c0k9c2cc4NX0DUzKDc2+rtX0TgS06I5bnomnKOiPCuQM+AZ90ry6f4gjUSqyK01ouyMV548D8BKZ6MQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ov6qAx0s; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ov6qAx0s"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-367cbac9c37so4399537a91.2
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779475693; cv=none;
        d=google.com; s=arc-20240605;
        b=GqnOlbAHw3JfpZ5D5vIbQ4CNt768FEFoyLK9WGJA9tZ2JaHNUygef96Fd/DNOebkXa
         BJ1scloQgHRD6ycmP5IDPd8BqkM5PT+tYs8jD0a6Yv/utwurjdhaam7mJIdw9SwRLUSM
         VBkgvXFvYSEkrkXg21qqs9bnL0DNtycA8eP3ncw1roaUZWkC1/NJoQDL2Lwo/O/ebfar
         aEb14YeMQpiJ/qkpJ4rLDJQz6/mLTKBT/0OVSE7oeUY8++ppSMUJn/X87VNejkSU9dgM
         C4TLB/FDpQCgtcxwWN+3fhMyu2vUTqDw34eEuKxr91raza/CdT83ZeeqIUPNCa347nZz
         RhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5OVGO59cBgsWByh8w/3nFMSxOWMoBChWco5FF9XMqSM=;
        fh=O99oYudPnAva7a8mtFDgUVCOE6SEK5SXVhoIUjywQeQ=;
        b=kHjSv92lAAQTPOSSrhK3rOwHjeP6QiZXbg90uiczAWe97p9P2+K29xH6XKEAoYumqF
         RIVVrYifD2D9GHMS1EHj9UsH8gHQay8vVCdiXgE1Zv/xOlFEoEvE/BpfpoZEFZWYITz4
         heRZzmgQcGKdwO2IGzau6JDA/Njl3jpEZaGKGttiotRJhZlLyrxnsMPhXEuZ1hK6/RL5
         +7zavo87GnLXOmu9ds3fUYDuDbvtUN7S/UbAsyIgEWpKLviEIZsWSMi0nXlkv4puqfSm
         2xfu3jy7j1Q2l/Bs6CMvzdokelfifvZyA6k5NzeWVhr8XQN1uBGn3wl0aVyjbNAzJQVa
         n0yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779475693; x=1780080493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OVGO59cBgsWByh8w/3nFMSxOWMoBChWco5FF9XMqSM=;
        b=ov6qAx0sSSm1iACHWaeD7x7YuIW2c34LbW8gXvPkiVClulrzaTgnCYekrp2Qmr0QUr
         9klIUAK3+9UzzjU20Me/GPgbet2Cbskdv5NdIugeWrPauXoJI32QPuBDeIZTBTXFDeO8
         waJI4kV/Uu20NwfiMvlYv6tAInYLuEEfOfoksRxEqOimi1jREw77SOfgEiTa19Y6OvPE
         hszucRzvJCAVPhIMVWIb7E1hh3VLjXiuk9gbQNm9Gtr3FgZagM7AZBs0FUltw/apcF4a
         fTKhv5toVclTYJeagsL5LNsWRypFaNDyrGs7iAMZh+SzREApycpzKoesewxeuV8oEaKW
         CdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475693; x=1780080493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OVGO59cBgsWByh8w/3nFMSxOWMoBChWco5FF9XMqSM=;
        b=H7VZJcV2LhBFV86mbAPPEQ2Buzy26PCY7lypDlXWrekTqWOjrC+W7skKLldVpMvK19
         b4L0WdwlDlDAom3Q+W7LD9noOsotDabi1Mfq3fDmP+3GIMllK110O/cjlTLVTh3htW3Z
         bdy/XBi8s/UONJbbm5DTzZhbOBvfnGBs86Pxt2BN75bqfi7MwvnqEQ82rOJbMN1tFhb9
         RnMQJl2x8fYbtk5WuxgPewRmYEIy81v9KpUYqfe4kEHQSEbfz35XHONO+d4YUT3X2OI3
         yLwoRGcS7Qgcx7s3TZ2NpOphWwQmKXiwViRexwgLvJ1CqV4t+qJOqXm3Czy6I9nsIg3/
         yU3Q==
X-Gm-Message-State: AOJu0Yym4g4zAcCyaErmkIDa9nMNc52GxAUByZmOD1rOlf6UW5c0J3Mi
	qG4p73DzgISp0mOo9LbVSBUvPSLFPkjviqCmzRSMNTQ693TbI9RJGf3dFdpdB3HgAHh4QBmz+L4
	/oxu0oHBW1wCYvR5KOenTKFmQxvVBfAc8OkZU
X-Gm-Gg: Acq92OF4JlzcaZxE3Gf6RUNMlH0Mj3B4gD2cMDHMkYE4hpwihRjMW4Jo0HSR4CO3Ig4
	f9m1QH/nIHKl1d8DP2LedBZ3eHTA9gdsvwjXaaQxkfZVSzpcpjQNoBoUr+EJQJBD5rMyYMW0bB5
	cH+0XC8WbBHUWVp504ug6k0C9B/14dmJPkM63fhr0qpGnj0xTNH6EezHq45sLhuKBUPxdpS4U79
	KAsd+mVi2VkjbR67C8e8w5aMTz/3bh5yilqt8lXlm7LOnCBP4alVFh9nrK2+XeQ2B8LzJjfo6v1
	9H/aopMmhpbOiCm8gU3T6LjL/8IAmJ3n8VeHrITjmugBn7s2fl6ZOkaiSU3LcTzsJd/LYcQruxY
	gqKTbIrPKfp+mrTM=
X-Received: by 2002:a17:90b:2cc4:b0:36a:35df:769c with SMTP id
 98e67ed59e1d1-36a67505a3fmr4936365a91.15.1779475692954; Fri, 22 May 2026
 11:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
In-Reply-To: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 22 May 2026 14:48:00 -0400
X-Gm-Features: AVHnY4IXuSkMiHGiCDc6VpmZBhZ3hQCQDdYdsr8zc5PfTQNkCjONSlS9uqWlw_Y
Message-ID: <CALnO6CApG=26Fdx2LZELf6rfTC9SgUu9W4R=K6-ozN0C15LJ0A@mail.gmail.com>
Subject: Re: [PATCH 0/3] line-log: integrate -L with the standard log output pipeline
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, Apr 28, 2026 at 12:06=E2=80=AFAM Michael Montalbo via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Since its introduction, git log -L has short-circuited from
> log_tree_commit() into its own output function, bypassing log_tree_diff()
> and log_tree_diff_flush(). This skips no_free save/restore,
> always_show_header, diff_free() cleanup, and means that pickaxe (-S, -G,
> --find-object) and --diff-filter cannot suppress commits whose pairs are =
all
> filtered out, because show_log() runs before diffcore_std().
>
> This series restructures the flow so that -L goes through the same
> log_tree_diff() -> log_tree_diff_flush() path as normal single-parent and
> merge diffs, then uses that to enable several non-patch diff formats.

Cleanup by itself to shrink the number of concepts in the code is
already a good thing IMO, so getting additional features out of it is
even nicer.

> Patch 1: revision: move -L setup before output_format-to-diff derivation
>
> Preparatory reorder in setup_revisions(). The -L block sets a default
> DIFF_FORMAT_PATCH when no format is requested; move it before the derivat=
ion
> of revs->diff from output_format so the default is visible to that check.=
 No
> behavior change on its own.

Straightforward, nice.

>
> Patch 2: line-log: integrate -L output with the standard log-tree pipelin=
e
>
> Rename line_log_print() to line_log_queue_pairs(), stripping it down to o=
nly
> queue pre-computed filepairs. log_tree_diff_flush() handles show_log(),
> diffcore_std(), and diff_flush(). This fixes pickaxe and --diff-filter
> suppression, and aligns the commit/diff separator with the rest of log
> output. Also rejects --full-diff, which is meaningless when filepairs are
> pre-computed.

At first I questioned the removal of the DIFF_FORMAT_NO_OUTPUT
conditional in line_log_queue_pairs, but now that it only queues pairs
it shouldn't be checking output formats. Good.

I also noted that log_tree_diff() returns the result of
log_tree_diff_flush() in the -L case, which is a bit different from
the other patterns. I think the difference is that the other cases
have some conditional logic around the log_tree_diff_flush cases (?)
but I'm not sure. Perhaps that branch should also be looking at
opt->loginfo ?

Finally, I wonder if in describing the removal of the early return:

> - Remove the early return in log_tree_commit() that bypassed
>   no_free save/restore, always_show_header, and diff_free().

we might want to be more explicit that this is _because_ line-level
diff is now handled in the regular pipeline?

[I suppose we could, in theory, split the rejection of --full-diff to
a separate prep commit, idk.j]

> Patch 3: line-log: allow non-patch diff formats with -L
>
> Expand the allowlist to accept --raw, --name-only, --name-status, and
> --summary. These only read filepair metadata already set by the line-log
> machinery. Diff stat formats (--stat, --numstat, --shortstat, --dirstat)
> remain blocked because they call compute_diffstat() on full blob content =
and
> would show whole-file statistics rather than range-scoped ones.

Short and sweet.

The stat formats are kind of like --full-diff, and I think they should
probably all be rejected or all allowed: since the stats are based on
the full-diff, it makes sense to enable them if we can also make -L +
--full-diff semantically sensible.

Otherwise, we'd need to find a way to make the stat formats scoped for -L.

> Michael Montalbo (3):
>   revision: move -L setup before output_format-to-diff derivation
>   line-log: integrate -L output with the standard log-tree pipeline
>   line-log: allow non-patch diff formats with -L
>
>  Documentation/line-range-options.adoc         | 10 +-
>  line-log.c                                    | 30 ++----
>  line-log.h                                    |  2 +-
>  log-tree.c                                    |  9 +-
>  revision.c                                    | 25 +++--
>  t/t4211-line-log.sh                           | 99 ++++++++++++++++---
>  t/t4211/sha1/expect.parallel-change-f-to-main |  1 -
>  .../sha256/expect.parallel-change-f-to-main   |  1 -
>  8 files changed, 120 insertions(+), 57 deletions(-)
>
>
> base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2094%2F=
mmontalbo%2Fmm%2Fline-log-use-log-tree-diff-flush-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2094/mmont=
albo/mm/line-log-use-log-tree-diff-flush-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2094
> --
> gitgitgadget

A few other comments:

- Tests should use test_grep; some do, but some don't.
- There is one occurrence of "sed | grep" that I wonder if we want to
rewrite to avoid issues with exit status one side of the pipe?

Thanks for working on this!

[Apologies for the unusual review format; this was easier for me at
the moment than digging up the individual patches, and I don't think
_most_ of the review would benefit from spreading out across multiple
mails.]

--=20
D. Ben Knoble
