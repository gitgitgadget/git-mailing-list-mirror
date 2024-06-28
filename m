Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8323A15884B
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587279; cv=none; b=C5kY8aEceeZIuw7GZ3FdLr5zz8psyTMX3fmBvWBUMqOPXz0bTGp6UEcEBBUHOeLj192r5oBbvE8BAEkBcBDBJSRwfuH7JXaLZV4HGhEKPvOrn0zdz4o1lkvYY7kH4FO91ytfZ33KHfsYaN78TNQiZum3KBVUdmc6y0eJiSa0Lxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587279; c=relaxed/simple;
	bh=2LLJGWr5hXWyOphFBdIdBi8dEMf1E4QqCuMMXRi2Dj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPG7NKjcmPLwV+3YvSAfRz/stwJqn8fUeC2g+ozqWrpoPPdxAGazZj67e5FAaSDpxi4NPDxIAm2i39gqPrEizqxE7gTIzCXqastlZGPDVqF/LC0SASj6NdezOVinSE7QBMAiQxY276X4fXEpHmXGmAh3WI69PDl7+NSkD7Uslm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0QN0UqI; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0QN0UqI"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7eb5dd9f994so23468239f.2
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587276; x=1720192076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9GM2eLT8D40BrYL+JI/P8UtFX/8W2gXOJfriDKnN/E=;
        b=X0QN0UqILmhMYbtkGI25JHSZLh8KuoK/MZuuEsJ8IvjezG71Txb3keyfdFd/k1RHiN
         0KXWjlGQ5ltq0M6DfM4jHwRm+Y84QzRy72Uu1n4BRKeExGKKX4iiVlIIMyY9/nQY3+kj
         yPn0EA0PY7/g715fcd6Kw67gLTQnUSDVzJX30mdfFA5XJCGtD2awoIGbUwl7opH3NSOh
         wsSiBj5gMtsSyri+99QAoXJrK55zhgs8Hc5VXISE0BX5MqOUAN04a88DUClPdwkO+94q
         2mV98CtTtCvaz4L4EJlJbz3vG/NPqi9IADlwspIY275KaBhLXs7nSgp66TZ+6kusOw8i
         wCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587276; x=1720192076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9GM2eLT8D40BrYL+JI/P8UtFX/8W2gXOJfriDKnN/E=;
        b=sjX8kFuLkP7PUo0WQl9CuouJRlFH2CfZpR0UXDCM2Giyf873vIVPx8k3WTROI3svRx
         Gfo//ClF9fnjxrvMHswHGNX4cpoVebLfrIKHVd0ntC5IVryLurLSUX5lK7xtODLCnQFW
         iJGn/dm4WZHD6v4za1U50dC4ge55nyTgIpo61hRRbVQnxOH/m5eToEAueX26SNWQVFAW
         OVJOS6K5XKqCHzy4Bn1atYBWXoumW5SUyhxJ/Pubym8rp2ZRge7Wy2h1mWDqddlQwkOh
         8fctstclqTBUDQwPGEdouPoJPx84AQ+mZHjU/VfWWQUhd2aZ5ZuD4S0xyW/havZUVyCj
         Frpg==
X-Gm-Message-State: AOJu0YyeWY6NUxPWxn9OiwiLmFkEqeALQORpdTdZPNJGqbdgSgU7cA37
	xrtxrr8ebXRXXYaXqL8FHOH/D8ondPKvbIDeYygvrz4/2doqeOpDvuimcxzMHwEjkd6LIYUiAcz
	WyyPWxIJKbSLJ+zsZkKpMlAGZ0uSeiw==
X-Google-Smtp-Source: AGHT+IH7vai+PReVBxUz4deBvA1WS5riQYQic2Hs3MheFba5P9oFOjEPXqULYTRg6r1qS1SNX2E4X1UWNbMTuNyS3aQ=
X-Received: by 2002:a05:6602:81b:b0:7f6:1f20:f137 with SMTP id
 ca18e2360f4ac-7f61f20f431mr180385439f.5.1719587276574; Fri, 28 Jun 2024
 08:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com> <pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 28 Jun 2024 08:07:44 -0700
Message-ID: <CABPp-BFd7Bk68Omdao5LS0sP5bK1WQ7V6dodB5x8EsncNARxNA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] sparse-index: improve clear_skip_worktree_from_present_files()
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, anh@canva.com, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 5:43=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> While doing some investigation in a private monorepo with sparse-checkout
> and a sparse index, I accidentally left a modified file outside of my
> sparse-checkout cone. This caused my Git commands to slow to a crawl, so =
I
> reran with GIT_TRACE2_PERF=3D1.
>
> While I was able to identify clear_skip_worktree_from_present_files() as =
the
> culprit, it took longer than desired to figure out what was going on. Thi=
s
> series intends to both fix the performance issue (as much as possible) an=
d
> do some refactoring to make it easier to understand what is happening.
>
> In the end, I was able to reduce the number of lstat() calls in my case f=
rom
> over 1.1 million to about 4,400, improving the time from 13.4s to 81ms on=
 a
> warm disk cache. (These numbers are from a test after v2, which somehow h=
it
> the old caching algorithm even worse than my test in v1.)
>
>
> Updates in v3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  * Removed the incorrect paragraph in the commit message of patch 1.
>  * Replaced "largest" with "longest" in the final patch.
>
> Thanks, Stolee
>
> Derrick Stolee (5):
>   sparse-checkout: refactor skip worktree retry logic
>   sparse-index: refactor path_found()
>   sparse-index: use strbuf in path_found()
>   sparse-index: count lstat() calls
>   sparse-index: improve lstat caching of sparse paths
>
>  sparse-index.c | 216 +++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 164 insertions(+), 52 deletions(-)
>
>
> base-commit: 66ac6e4bcd111be3fa9c2a6b3fafea718d00678d
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1754%2F=
derrickstolee%2Fclear-skip-speed-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1754/derri=
ckstolee/clear-skip-speed-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1754
>
> Range-diff vs v2:
>
>  1:  93d0baed0b0 ! 1:  0844cda94cf sparse-checkout: refactor skip worktre=
e retry logic
>      @@ Commit message
>           stored in the index, so caching was introduced in d79d299352 (A=
ccelerate
>           clear_skip_worktree_from_present_files() by caching, 2022-01-14=
).
>
>      -    If users are having trouble with the performance of this operat=
ion and
>      -    don't care about paths outside of the sparse-checkout, they can=
 disable
>      -    them using the sparse.expectFilesOutsideOfPatterns config optio=
n
>      -    introduced in ecc7c8841d (repo_read_index: add config to expect=
 files
>      -    outside sparse patterns, 2022-02-25).
>      -
>           This check is particularly confusing in the presence of a spars=
e index,
>           as a sparse tree entry corresponding to an existing directory m=
ust first
>           be expanded to a full index before examining the paths within. =
This is
>  2:  69c3beaabf7 =3D 2:  c242e2c9168 sparse-index: refactor path_found()
>  3:  0a82e6b4183 =3D 3:  ad63bf746ca sparse-index: use strbuf in path_fou=
nd()
>  4:  9549f5b8062 =3D 4:  db6ded0df0d sparse-index: count lstat() calls
>  5:  0cb344ac14f ! 5:  1f58e19691f sparse-index: improve lstat caching of=
 sparse paths
>      @@ sparse-index.c: static void clear_path_found_data(struct path_fou=
nd_data *data)
>        }
>
>       +/**
>      -+ * Return the length of the largest common substring that ends in =
a
>      -+ * slash ('/') to indicate the largest common parent directory. Re=
turns
>      ++ * Return the length of the longest common substring that ends in =
a
>      ++ * slash ('/') to indicate the longest common parent directory. Re=
turns
>       + * zero if no common directory exists.
>       + */
>       +static size_t max_common_dir_prefix(const char *path1, const char =
*path2)
>
> --
> gitgitgadget

This version covers the last two outstanding items.

Reviewed-by: Elijah Newren <newren@gmail.com>
