Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE74A2A5E
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507009; cv=pass; b=GeANA36IGhqE9me6xok7fctp+QbNmvWGIBj3rGQK9Ts4zHD5EIognb/AaVCGz1CQ/OGZ0JLfiACueIxnhIMTLK2Y0NBHCIcnYC6LSV95A3voufz1x/t32+s2mxWx54dh3dr0MXh2lQm1tz96A8Jj5+wgJXudF/jMkjonenFj9Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507009; c=relaxed/simple;
	bh=E3rxDOj1yZS7b0almveJChiNGr3XO+lFJ2g20htoEG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkkjxbykjWfvj91UwyQUkOjYjemGsH9BXQJmcIBgmWmFlctEwhQHuxoikS9APz55d8RfO7iLlJc8DGQHhz6+NrDpmI7WbxgMMo5EPX5JhvtC1+Y5/43Wx9aR8bvPOHNcHthGWYgz5Np7+6H5PZV8IADHDSrwAV8ZqP7C+Fg6ZlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwX71t9h; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwX71t9h"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so267550a12.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 14:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789507002; cv=none;
        d=google.com; s=arc-20260327;
        b=Prp0tFJYXUz8N1BuEV48KafQjl4gf4+7Y9/ny5NBd5N7E1kriIZ7Ormt3pFaqoTe08
         1JKlzfZ2CSzxbbD9QQrjUvR/U+UTiWdxekMcZ+WaSgxPaoyv4JlyjvTsJnVmv7E1MpUR
         hrJMKvmO8bfEpoljpvcQABnn/F7nalKVF+wrlTLdFuBVRTNa45RnARWmZcwP5hYM0oIk
         nN8jIciB4cV+lr3q0VOdcR0XbpGO/vPE0AGlU2dEjGwZtbjxgI8ehGwW3/PFhKGoeUwX
         CjekhDRGnPzboyFeSYBuQb2OKJNP7pOvC1goPEu0YlQH/gniUjVOB9GCeteZOe2fETV2
         dmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DLt3hXawaqrrykYM9RhNWjQc75ia7qYe6OGWFUyMQGk=;
        fh=tPyVAz2hHRRK+OU1fR5ewJzzf6KzpP1ID4VCGld4488=;
        b=fK2Z2CzMwsGcMlu3CGWnuyvXvBrmaOJxcolsTDFNMgTzAGLFFUoI1gXhlhZ2/xkjL9
         17zs9NtVRwTy3FnKoQFxclO6utm8PtgxAd/nosG6DfziYLGEKaGtvFSw8Tawe+0jiXbB
         yVnI3y5tQMvcewkui6vsnPSGS6UZBFqo5UVe3VGDzkQqVflP3cn9u/58NTTkO8zqo30Z
         eTXvtuXgYQUDtSSsiPaufkvAFfJ2XvkOc1+4BOhsiCRQpvUstPAgencXNzMnMFjpDT2T
         +pE+YWF7cZsKxrCPQ8yfuye12P/PEsJaMjcUKGUwGSYlL8wEjVfmlHzlCM3AFQWnYvn5
         8j1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789507002; x=1790111802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DLt3hXawaqrrykYM9RhNWjQc75ia7qYe6OGWFUyMQGk=;
        b=FwX71t9h0hLM4bm/3Rh6z5zE+NiJyxUXFOFUIYkGFtPcq2ju34H7OJnWkBXzqAdXCY
         SkFEwCTdxUDXF4m4Y4IKFKMYH9DFR3M4Jxte22PAuQ1V/zxMV2tEj2o2OulGQnDrD2jZ
         YD9AHhKD1puJH/OTAtl9KLr/xrA3r31Rt8RabU82/IAUycMvs87Rzbhvmeybo8gbmEEh
         DauHFPzqadPBk30rmdfHyxsDlYpwXLLPC/IngYfm7RYXj2FKaCFssmzJ1CQk2izjpxN+
         VfuxZaPCXVbrcvep8IJx0ITu1IKpOpnd6TKf59VnE6fJt7McBZkr3pwh85fomXIwG2S5
         JPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789507002; x=1790111802;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DLt3hXawaqrrykYM9RhNWjQc75ia7qYe6OGWFUyMQGk=;
        b=biTdFgHUKMR3be4i9xeDJJhg5poir56t5Q9LKmr3RioHi3JVAEMYFjlwVRWJzh90qN
         9lJNt4X8G4euZ4NM9WamupNXsBdCWRpZmuNfR3113mLIhH6WLgPbS7bH9U0yWWehSAoj
         3X5onzJm+z2KhgqUmB3jdq2ToQbWcyRGWxFaHCV8DUujkyB7ocpPle+AHOUbUc4VhCvm
         86iFPBiWsDYrBAJPypd65DKxsceVF3bEMHALrly1ol+HP5Nnzvqf8x/CYUijrHpRUT6+
         aqXs8QtPAnoNvKlFWALXY2y65F9DLlNm9kl7wb982VyGfWvNd8NoL6YmecEsmuI4kzRn
         xHYA==
X-Gm-Message-State: AFuF++mGqIfru+vh5kIfBkQz43xa7N6eMjf5dI+wi0tlC8LGMr3n84Yl
	dBznEMbdLkJU7BavoiJMf262gn6JPeXQnPaq1Vi5NKzgaKqNDlrAc1ZViKDDeLGSep7oODNU5SS
	LRqgWmFhanRDB2g1bfq0oAfS33eKD7e8bFQ==
X-Gm-Gg: AYBFou3eA8qs5llWPa/0UAMVAYXatA5eDHR5xUSynFH6jlon6jQBWkyL5yQsM8M2tR2
	9gxujBABlyc3XbsLcFxgy67Ey5nr5uVD+QqV6h+7xfFAX400WqsT/i03O8KapLM/fA+s7sSYEMt
	wCIdBewQvAWI6AJQhPdiPa8b4Epva266fDakojG6R+rIrVxS4Fx3J17sXUUfFvJn7fMVhc1/zVR
	+J/5Mk/cHxMtN2nLn7LVNK1VvJfxAPKQ8H168kWX6pFp47Fwu5jXa4sZJaOc48fKr89/qF18PpK
	bNIgU88o0HwG2AlZ9wGOCRGnFuuSNlXTXri5vTo/APNbgmW73wnXR3fFupHiqafDNeLkl0UZk5i
	TEHO13qMw2IIfFaT+jaNm3HALc49YcYIMEATVGYnrYcWbk+SNaDCi549TIf9wbkQsRjIWnYe77k
	ID7KoIjn4=
X-Received: by 2002:a05:6a21:7a45:b0:3da:f21a:23ca with SMTP id
 adf61e73a8af0-3dd5f7a9cb9mr297065637.22.1789507002121; Tue, 15 Sep 2026
 14:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALO-guvbk2TcrVwzdNQ3yRpzHr0HHZ3h1wite0Xp0sUyAT4otA@mail.gmail.com>
In-Reply-To: <CALO-guvbk2TcrVwzdNQ3yRpzHr0HHZ3h1wite0Xp0sUyAT4otA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 15 Sep 2026 17:16:30 -0400
X-Gm-Features: AcwNN1UTCwVTVVOpFxV4580Nq_4eI0eBqn-YTj-mQTzBFepXo013AW-w0FBJ8_M
Message-ID: <CALnO6CCkq7mjBUKxOYcwKX8=SrH441FuWopoGZutPk99JRTGUA@mail.gmail.com>
Subject: Re: [BUG] stash.index=true leaves a redundant stash entry after an
 autostash fast-forward
To: Eli Barzilay <eli@barzilay.org>
Cc: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eli,

Since I added stash.index configuration, thought I'd take a look. I'm
out of my depth, but let's persevere anyway!

On Mon, Sep 7, 2026 at 12:47=E2=80=AFAM Eli Barzilay <eli@barzilay.org> wro=
te:
>
> Disclaimer, the following is written by an agent, but the bug is a
> real problem that I have.
>
>
> With stash.index=3Dtrue, an autostash that is applied successfully is
> nevertheless stored as a stash entry, and deleting MERGE_AUTOSTASH
> fails.  A staged change at the time of the merge is required to
> trigger it.
>
> Reproduction (independent of the reporter's configuration):
>
>     #!/bin/sh
>     set -e
>     export GIT_AUTHOR_NAME=3DA GIT_AUTHOR_EMAIL=3Da@b \
>            GIT_COMMITTER_NAME=3DA GIT_COMMITTER_EMAIL=3Da@b
>     rm -rf /tmp/gitbug && mkdir /tmp/gitbug && cd /tmp/gitbug
>     git init -q -b main up
>     cd up && echo a >u && echo z >z && git add . &&
>         git commit -qm base && cd ..
>     git clone -q up dn
>     cd up && echo more >>u && git commit -qam up2 && cd ../dn
>     echo staged >>z && git add z          # a STAGED change is required
>     git fetch -q origin
>     git -c stash.index=3Dtrue merge --ff-only --autostash origin/main
>     echo "--- git stash list:"; git stash list
>
> Actual output:
>
>     Updating 34a5e40..84ccd9d
>     Created autostash: 71d4617
>     Fast-forward
>      u | 1 +
>      1 file changed, 1 insertion(+)
>     Applied autostash.
>     error: cannot lock ref 'MERGE_AUTOSTASH': unable to resolve
> reference 'MERGE_AUTOSTASH'
>     --- git stash list:
>     stash@{0}: autostash
>
> Expected: the same without the error and with an empty stash list, as
> happens with stash.index=3Dfalse (the only change to the script).

I can reproduce this locally. Thanks for the helpful script. For some
extra tweaking, I've put a "PATH=3D=E2=80=A6:$PATH" assignment at the top t=
hat
prepends my local Git build's bin-wrappers, then put "GIT_DEBUGGER=3D$1
GIT_TRACE2=3D$2" in front of the merge command; that way I can debug a
few things.

> Analysis
> --------
>
> Merge keeps its autostash in the MERGE_AUTOSTASH ref
> (builtin/merge.c:1675) and applies it from finish()
> (builtin/merge.c:540).  apply_save_autostash_ref() resolves the ref,
> applies it, and then deletes it (sequencer.c:4821-4848).
>
> The apply is a child process, `git stash apply <oid>`
> (sequencer.c:4737-4751).  stash.index turns that into an --index
> apply, which takes the index-restoring branch of do_apply_stash() and
> calls reset_head() (builtin/stash.c:684-691), i.e. a
> `git reset --quiet --refresh` child (builtin/stash.c:455-467).
>
> That reset has no pathspec, so it calls remove_branch_state()
> (builtin/reset.c:543) -> remove_merge_branch_state()
> (branch.c:829-838), whose last statement is
>
>     save_autostash_ref(r, "MERGE_AUTOSTASH");
>
> which stores the autostash into refs/stash and deletes the ref -- in
> the middle of the very apply that was about to consume it.  Control
> returns to apply_save_autostash_ref(), the apply reports success
> ("Applied autostash."), and its refs_delete_ref() then fails on a ref
> that is already gone, producing the error line.

And this lines up with the code, I think. I find it a bit odd that
"git stash apply --index" ends up getting to a reset mode that tries
to throw away a bunch of branch state!

Ideally that would be simpler, I think, but I don't see an easy way to
do it with the existing "git reset" subprocess.

I'm experimenting with something that swaps that out for a call to
reset_working_tree(), but I don't think I've gotten it quite right for
this bug yet (let alone run other test cases that might be affected by
this change).

BTW, it's really weird to me that the reset manual doesn't mention all
these "extra" cleanups reset does via remove_merge_branch_state()!

> Possible directions, in case they are useful: remove_merge_branch_state()
> is about ending a merge, and `git stash apply --index` is not ending
> one -- having stash's reset_head() avoid the branch-state cleanup, or
> teaching an in-flight autostash apply to shield MERGE_AUTOSTASH, would
> both close it.  Making apply_save_autostash_ref() tolerate a missing
> ref would silence the error but leave the duplicate entry.

I also thought briefly about disabling stash.index for a merge
autostash, but that's really papering over things, I think.

I'll keep noodling on this (hopefully tomorrow morning), but in the
meantime input from others welcome :)

--=20
D. Ben Knoble
