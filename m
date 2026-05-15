Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C46137DACB
	for <git@vger.kernel.org>; Fri, 15 May 2026 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831266; cv=pass; b=TuUyPxuAO3AzinVkrL087+cbDlycLzctteZv14Vzdewx+xxoKygk518i9t1IlYV7AMw9oJc8nSDYY+3HwsegTTPUhj5Fa6VtLsDO3ggjQPX8M9QiMwPYphF/eCJejyBiCOoTqL9JPwnyhMXf7GFhnJAylxDzx+8fIN7QFCApO+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831266; c=relaxed/simple;
	bh=t0ZAG00SSILQo0wtgj2XOLqg5dtgziN26imMBYRehqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4F7ypnMld3u3Xi80y005zQ4mQOiHMKrXcvEzoOccx4VJQPUB9/o4NYHWDzM59mOJrJ8DFyGLQoShN6DlmYQnnVnPkl0LeUv3HFdm4ckFaEDMjHR9+OBn7TOMPHRSKo1/PLPl/P5lD8ifln+2bc2t+JDsOKY6Qi/yXYscFinBoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=bbmfCI7x; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="bbmfCI7x"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-651d6347a69so1172738d50.0
        for <git@vger.kernel.org>; Fri, 15 May 2026 00:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778831263; cv=none;
        d=google.com; s=arc-20240605;
        b=HW/ZoPUeZt4fD6NTfwCnsQYLzlbjEShz23+/54pPhI8egU7sdCOAU7jfauolSRQxuj
         x8aureCWY3SsL4ka/3JDnnWpYTWU9teDkDdUg/+4FdTVn6D1xQJVHEuYo6eT/UxG3QSo
         0oeIUdjowoOYJznqOw9YOH2SUrjZdVeX6O64ck+Ms4mLTFOIHvAMZx5Tg4Qs7INW9exO
         s/9aeYXIAXsgA6FnxrtYH+Cao9IMGZWeEo0v0eP3stI1cPEaF33bLAhpPT31x217wbf6
         wYcPfpNecztVn/5/v5bB284oHkKGwqx5RXWNQUdq4m//xNIuIJNcEUBQN1ZW2u+7Z8v7
         n+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tC2T9Gr8QHToNHAXLBL3KsxgGr0RzxHfigqO1ic4QfY=;
        fh=RjFIMzR3oHfj413azwbO+VSmr9aHCptK7GYN6upZG6Y=;
        b=j66Xzbct1XX81lpY147Pl+g9rtwI000+3Ly86pX4F9OaGu1yEqA57XDjHvXbdp1ZF5
         i04ohZFIgpVlKU2UKkKNS3zVkmZlt+V2HkikH2bfF5PNgGPmZ0CecApMMJBCA1T8pfB/
         UmX4720YQhiLfX1G/sNseuYU4CIgYZFj4kog+t8xTXkl28EVEuK7pjjMOtZMKU0hUj+U
         PNEeaKtUxuuBX0I5nvNCfFrAHqGqvJK0b5CM5z5Dw06fi4nZ4m1QXuGZR8e/fUHfmTws
         ikKMcoewk6B7xcW8v2c1HZZcv60y20LoSPF8UQVKyE1GA3BjKtkBYVwZmXD6cKIULE39
         k5hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1778831263; x=1779436063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC2T9Gr8QHToNHAXLBL3KsxgGr0RzxHfigqO1ic4QfY=;
        b=bbmfCI7xLXhIvLPXB2/EoNwR8i0fjg+U7RJ6cvc++x0MFygz8bYhUpkeiupF/zjNu6
         TxwWH7cnbqib3+KFoUQFjl4GFNVX63qyrCOC5WrTj43KMwktoeREsUv0hJb9JzJ5PcW1
         UBqW3fYOmbd5tWtm9IlvvoEi1SEBO7T7ItuqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778831263; x=1779436063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tC2T9Gr8QHToNHAXLBL3KsxgGr0RzxHfigqO1ic4QfY=;
        b=ZXEQBgRGEWqRXPqJiBtwrimSs4SFZPnddxK+0TUIEnXWV/y+xBzRbph6uef7piC/NM
         MvgKLLKlSPrm6Yj7gIDaYUY1kGlHFyK1NPOMA1m3hrk9X7U7MjLkhWY900P6lphYK42n
         YlJFqiGx67MSzK6mwZ6HrvjafvmeqLMQ23wL+53URhju+k2xybJ6yxq1MwpQQhtLUVZ0
         fksOn2rnUBaaCrxpJ6E2G0qQuhW1SWADhfCLZ2cLNFORgnvWi4gr3a7HEli9B+Oviyjp
         acpxiZYkDSCM/55l3iDrPOc9pot8CF2Je7+qoCHUafumusKPW2GEZAhYaEFYgeVUcugf
         sYRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IePDeQ5MW6FyMlNkFi3YghpqMsB2D7lRBQapc4WFTbndG/KDgwdQUiMV/ZN+y510MLlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYBoOpGl7iL1R9gahVrI4yUWUrAm89HOjo+j6fB9NfdK4s6UH
	tiQ9KItFjOZ/SzSofHaeExqvJuXTAsYretSqeh67cAat0dJn8911Fq6Q0jlrQlERqTBnbzGDZQ/
	5u/jcPSOTVeIos4cFWIbp1lxCzP37etksFx2ZQM/toA==
X-Gm-Gg: Acq92OGUNBVsOXOhTJXMeryBSpkjJmcB1hHKLagxieaXwqJFviKGan73TW4QJ5Ik4Fr
	N8zinMiHzCUrAPfmMIlb1Jj8XZ/5MT3whItBdlA7Tv8/J7KazEDZC11k1o7wne/rUuWRfmaT0K6
	Tovq2ytQP1cAkcqfN89T819Kf1garC1+aASd88n9CNXBg2jq3+Uhlwg0BFUEWQF3dzRFnqacgsQ
	S+QrUvGliz36/wC+MAkZH6B0UbNbn4QKhkwORauO0vPPy2jxpcr3LQR7q7bXYICe4iGB4bscSdS
	s2WEuYrJajtzEzpxt+k=
X-Received: by 2002:a05:690c:e0b:b0:7b1:9036:a23a with SMTP id
 00721157ae682-7c7e6684f90mr68908607b3.14.1778831263550; Fri, 15 May 2026
 00:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2114.git.1778777491939.gitgitgadget@gmail.com> <20260515041641.GA81292@coredump.intra.peff.net>
In-Reply-To: <20260515041641.GA81292@coredump.intra.peff.net>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 15 May 2026 09:47:31 +0200
X-Gm-Features: AVHnY4KyTAOohRTp3ihrwmuM3z8X1r_sBMHcCArKCet4AgWObxge3KZX78-pDk4
Message-ID: <CAL71e4Mfq3SCO7vnTbFCxpzH9txWPTencV-vq-aQ=wJ7dPMV2g@mail.gmail.com>
Subject: Re: [PATCH] revision: use priority queue in limit_list()
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the reviews!

**Junio C Hamano**:
Good question about A..B. Since 1b4d8827 (revision: use
generation for A..B --topo-order queries, 2019-05-21), a plain `A..B`
with commit-graph avoids limit_list() entirely via init_topo_walk().
The commands I listed are those that still force `revs->limited =3D 1`
even with a commit-graph.

As you suggested, I ran benchmarks without commit-graph. On the same
2.3M-commit repo with `core.commitGraph=3Dfalse`:

    git rev-list --left-right --count HEAD~100...HEAD (3,751 sym-diff)

    baseline (no commit-graph):  67.0s
    patched  (no commit-graph):  43.1s   (1.6x speedup)

    baseline (with commit-graph): 21.2s
    patched  (with commit-graph):  8.5s   (2.5x speedup)

The gain is smaller without commit-graph because more time goes to
parsing commits from pack, but it's still a meaningful improvement.

**Derrick Stolee**:
Unfortunately git.git's mostly-linear history doesn't
trigger the quadratic behavior (the queue stays narrow). Even with
5,584 commits in the symmetric diff, `--left-right --count` finishes
in ~0.4s on git.git for both baseline and patched. A 50-pair
interleaved run shows no statistically significant difference:

    git rev-list --left-right --count v2.47.1...v2.54.0 (git.git, 5,584 com=
mits)
    50 interleaved paired runs:

    baseline: mean 393ms, stdev 13ms, median 392ms
    patched:  mean 396ms, stdev 14ms, median 393ms
    paired t-test: +2.9ms, t=3D1.16, p>0.05 (not significant)

There may be a tiny constant-factor overhead (~1%) from the heap's
bookkeeping on narrow queues (sift-up/sift-down vs simple pointer
splice), but it's well within noise and dwarfed by the 2.5-3x win
on wide queues.
The improvement is specific to merge-heavy DAGs where the active
frontier (queue width) grows large.

I also measured `--ancestry-path`, which hits the same limit_list()
bottleneck. 74% of CPU was in commit_list_insert_by_date():

    git log --oneline --ancestry-path HEAD~100..HEAD (monorepo, 100 results=
)

    baseline: 16.5s
    patched:   3.8s   (4.3x speedup)

You're right that `git log --graph` without commit-graph also goes
through limit_list(). I can add that to the description.

Regarding the O(N=C2=B7w) analysis in the cover letter vs commit message:
I'll move the key points into the commit message in v2.

The existing t/perf tests don't cover this path. p0001 doesn't
use --left-right and p6010 is merge-base specific. I could add a
perf test, though it would need a merge-heavy test repo to show the
difference. Would a synthetic one (like p6010 does) be useful?

**Jeff King**
Confirmed: unsorted_input is only set alongside no_walk, and
limit_list() is called after the no_walk early return.
So the incoming list is always date-sorted when limit_list() runs.

That said, even if unsorted input did reach this code, the prio_queue
maintains its sorted invariant on every prio_queue_put(), so the
output order would still be correct; the heap sorts by commit date
regardless of insertion order.

Your patch to convert revs.commits to a prio_queue sounds like a
natural next step; this change would indeed slot right in (the
initial drain-and-fill loop would just disappear).

On Fri, 15 May 2026 at 06:16, Jeff King <peff@peff.net> wrote:
>
> On Thu, May 14, 2026 at 04:51:31PM +0000, Kristofer Karlsson via GitGitGa=
dget wrote:
>
> > @@ -1451,6 +1447,7 @@ static int limit_list(struct rev_info *revs)
> >       struct commit_list *newlist =3D NULL;
> >       struct commit_list **p =3D &newlist;
> >       struct commit *interesting_cache =3D NULL;
> > +     struct prio_queue queue =3D { .compare =3D compare_commits_by_com=
mit_date };
> >
> >       if (revs->ancestry_path_implicit_bottoms) {
> >               collect_bottom_commits(original_list,
> > @@ -1461,6 +1458,11 @@ static int limit_list(struct rev_info *revs)
> >
> >       while (original_list) {
> >               struct commit *commit =3D pop_commit(&original_list);
> > +             prio_queue_put(&queue, commit);
> > +     }
> > +
> > +     while (queue.nr) {
> > +             struct commit *commit =3D prio_queue_get(&queue);
>
> Here we push the whole starting list into the prio-queue, which will let
> us pull the commits out in date order. But is the incoming list always
> in date order?
>
> If revs->unsorted_input, then we don't sort the initial list. So we'd
> now see the commits in a different order, and put them onto newlist in
> that different order.
>
> I _think_ it may not matter because we don't call limit_list() when
> revs->no_walk is set, and we only have revs->unsorted_input when no_walk
> is also set. If that wasn't true, it would get weird when limit_list()
> calls process_parents(), which uses commit_list_insert_by_date().
>
>
> I was on the lookout for this issue particularly because I have another
> patch which converts revs.commits to a prio_queue totally. And I
> remember running into issues (and the solution is that sometimes the
> prio_queue has a NULL comparator and acts like a LIFO queue). But if my
> analysis is right above, we can ignore that for now. And if we
> eventually move to revs.commits as a prio_queue, then it will just slot
> in nicely here (we can drop the queue generation step and just use it
> directly).
>
> The rest of the patch looks as I'd expect from what my other patch does.
>
> -Peff
