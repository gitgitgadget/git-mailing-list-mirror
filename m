Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C226158C
	for <git@vger.kernel.org>; Sat, 16 May 2026 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778919806; cv=pass; b=eVdniEVFaMK4SsLU0qjxpBE+JXZTvKvVpZjvZqhgV1mLKw6yDh3bYJZTLOVRhKmKz2YQ9UNC823Q9LzzIB1IfTkuKLfZyKS483xnjC+h+SnqLnQtxstot20PRSFAplMjbWygE2f3tpNjGTizbBVARfReItGkRo5em0VjcBM10/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778919806; c=relaxed/simple;
	bh=sHUGFVGA+eNA4PvxN2HomitrdD9O1s2KJ8ljBhYxBGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHnpsaS6pxJm3bbpw0Do437zsbP5IV3FZdSKXDYVkG/wHDQ084IWfp6W/7RBP+tq87p0zPG9g13regbgARb44BizoFTYgAGKK3zGOgUyznQuwwYljHmxTj17TUaf2KEilpytmHPj7SaBcJ3f/SyYXv4i5dAkXAixku1gjhsfAwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=JYMVobYV; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="JYMVobYV"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7c23248f3a3so1968867b3.1
        for <git@vger.kernel.org>; Sat, 16 May 2026 01:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778919803; cv=none;
        d=google.com; s=arc-20240605;
        b=VFGnpSZDPRfaav7rPGR0a0uLK6ZYziWNu71GnuuAF5FNOyf7Kt7KY38VhqYmrOPYS9
         EferQJKJuw1SMg50xIKywaF2yac07a+TRyWncsVUcHmM+bgNBw6/t0csYWBs14WyWCxf
         7LWyN/0kXM4LSpXnPFK5FjiglB0DKCDlen7GE/Pevmgm4HF/HSfmxhzADrnI5giUKH0M
         X7HX6ccMoBWj0CNT3ggdUrbcvvEOboBHYUZ72aopEKScOk6fRW+o3yQph0kiPYdoNPw4
         9ZfLCnXM37StmeHCsXTPLboNVWuBAATAoFUTwx96MciLB6lGHbaZevIDV4QhBPOjdBod
         9d5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RQzmPW8hW7MGA4SR5WyJrEIhlkXMA/dpbJSjzXAz1qM=;
        fh=jzh6cO1b5ANFzqkzwxxIVkqt8Yd3Vl6T977cVgIPW8U=;
        b=aiBMVK6vhwKkbhmlvvHU5v0WGbYh0L/x2OntkRyzDUSEUR+JvgeI8Qc43H05rkT6Ot
         jEAYMKeL7bfq6fI8JVy3l0I/Bnx9A3MdxdZls2x24XFmDBGx6m0/cYSkDQ1n7DQ0xQYR
         ML7l8lof+hSSOdZq+T0Fhu4LTm4q/wd3jTQsXm0HlUkohcipcCoK+eKWhk1DyVaLbTvo
         JBlgFhWOGWOqn+56PS84UIWgMdK5mIM2prcMOV8vPO5ViFXtEoml9szwildDFkHlObi1
         5wSmVd2FM5Y8byvT2pVMRoalNPyHXahn2Qt+m+BNpNjv0I9HWqt6z4tRyBMD2//DIA2z
         Iy/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1778919803; x=1779524603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQzmPW8hW7MGA4SR5WyJrEIhlkXMA/dpbJSjzXAz1qM=;
        b=JYMVobYViiz5PKmQC//ha9bUuO52g+FCEBRFEb/xJdNqpkCB7JANwHfnI9mThs5qE4
         suxJHXMRjYxYPd/RVRARJjLVYQ1tHa9EACjJc+/gzHIB4fZQ6F2WnEBBts4H7GcUa2KQ
         j/DKuZ2KyvHAQYqUFyPX1+KbdmBRRfReejPJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778919803; x=1779524603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQzmPW8hW7MGA4SR5WyJrEIhlkXMA/dpbJSjzXAz1qM=;
        b=ONjZTPHsRTWY5UL3SaNIPigL31xVas+B5jSDLYLRePp7N5trDlNzQgJxaTtzN+8xjq
         oSZZMQzimLutyKK7d4fqTQnaFFXBxymRVR8fMbJo8dLWAzcWnSYqXFEbzkOnf1zcSp39
         VxIW4VCjwYwqNVJJF31QTxXQ5KxcvbEnTjJSSvgD2XedXGDlKAdYU3IxAfrOqbXgPf9f
         h6H1Xk/SFHCV2UF6wt6idMRxt4D/yB06RWfBi+vTh7vxqYSLjYG/tkhXrAO1zELyZvZT
         hmfZa+hTfXuTgqPwOdjp8tvAp18tNeQ7uj0wEOkTFA221jm3rG8rS/Vs5upi6n8GnRO8
         eDuw==
X-Forwarded-Encrypted: i=1; AFNElJ+uRk7KYD3eBZn9v3qtdbJKDBgG06RsctP3KzBlD2W767FtBRojj78CKLbyG0v55FOmeds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+VpYMo2nLg6gdpcasEo8gYU6RNZUcXIWcF68Z4zS2EVkX0ga
	kL6Wco1CCL49edivEng1qax6EFD1UVkzvj07l02tOPmcwaRb/TOVP5ZpLTtLSyYGruMZHtXA9gW
	/kDC3O0IxTZPfCcJjcRTztsm3j7iDox6Yaz0h4ApEYk6yjnntjYupRBwhDw==
X-Gm-Gg: Acq92OHc/dGpgoTEWc8gbvgmPu2HEtDHN0QdegZjZuSmesVCzL2J0tqvXEmh8IgEvl4
	KNIS9UHDp2nTG3p53STyZyCBhB8bRTSdcxPkGPOQTIKbP9UvxUegRj2QZtQANCazchZX9PI5/lD
	EJ7t6G/FOyeilNCg4lBo2A4bYFFMaVazuUHwuAyDd6yBjg90/FBhu4lWAY6htpKHKoEiGITV2T7
	junr2evf7jzVqrGW9V9VMa8StS9QOsDc7n0DsA2PWVfhtAA8VmUCukxxEGjfGUBDw+91Z2p0k+N
	UsR3OI4FWsVSO2/xQcI=
X-Received: by 2002:a05:690c:7106:b0:7c5:1d66:8ccf with SMTP id
 00721157ae682-7c95c8f8d00mr83378167b3.42.1778919802858; Sat, 16 May 2026
 01:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2116.git.1778868463992.gitgitgadget@gmail.com> <20260515211459.GA158762@coredump.intra.peff.net>
In-Reply-To: <20260515211459.GA158762@coredump.intra.peff.net>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sat, 16 May 2026 10:23:11 +0200
X-Gm-Features: AVHnY4JAjWJejRYWl10gkEEVyzGdc9yP2aAJ6ndcIRJJRejJxMJushuu67cMYvc
Message-ID: <CAL71e4NoKiRMGngCc-FYNX9PH5fTd6xpzMsfONefp+JwJ1-3BA@mail.gmail.com>
Subject: Re: [PATCH] commit-reach: use the decoration hash for tips_reachable_from_bases()
To: Jeff King <peff@peff.net>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for testing this, Jeff! You're right, the patch as posted
regresses on your synthetic test case.

The issue is that when multiple refs point to the same commit,
add_decoration overwrites earlier entries,
so only one index gets stored. The marking itself is correct (the flag
is on the shared commit object,
so all duplicates get marked), but the j =3D=3D min_generation_index check
never fires for the minimum tip,
so early termination breaks. The DFS walks the entire graph instead of
stopping when all tips are found.

I have a fix for the early-termination bug (checking the flag at
min_generation_index instead of comparing indices),
but your suggestions about the API are well taken, I don't think the
decoration hash is the right tool here.
Since we only need set membership ("is this commit a tip?"), not a
mapping, an object-flags bit or commit-slab would
indeed be simpler and avoid the (void *)(i + 1) hack entirely.

I fixed it locally now for the linux test case and got a 4x speedup
there too - the problem was failing the early termination.
Some numbers when running against the linux repo on my machine:

Command          =E2=94=82 Baseline =E2=94=82     V1 (broken)     =E2=94=82=
     V2 (fixed)      =E2=94=82
--no-merged HEAD =E2=94=82 1.33s    =E2=94=82 2.01s (1.5x slower) =E2=94=82=
 0.31s (4.3x faster) =E2=94=82
--merged HEAD    =E2=94=82 1.35s    =E2=94=82 1.96s (1.5x slower) =E2=94=82=
 0.31s (4.3x faster) =E2=94=82

However, I'll still need to rethink the decoration map - I will come
back with a better patch shortly.

- Kristofer

On Fri, 15 May 2026 at 23:15, Jeff King <peff@peff.net> wrote:
>
> On Fri, May 15, 2026 at 06:07:43PM +0000, Kristofer Karlsson via GitGitGa=
dget wrote:
>
> > From: Kristofer Karlsson <krka@spotify.com>
> >
> > tips_reachable_from_bases() walks the commit graph from a set of base
> > commits to find which tip commits are reachable.  The inner loop does
> > a linear scan over the tips array to check whether each visited commit
> > is a tip, making the overall cost O(C * T) where C is commits walked
> > and T is the number of tips.
> >
> > Replace the linear scan with the decoration hash for lookups, reducing
> > the per-commit tip check from O(T) to O(1) and the overall cost from
> > O(C * T) to O(C + T).
> >
> > This function is called by `git for-each-ref --merged` and
> > `git branch/tag --contains/--no-contains` via reach_filter() in
> > ref-filter.c.
> >
> > Benchmark on a merge-heavy monorepo (2.3M commits, 10,000 refs):
> >
> >   Command                           Before    After   Speedup
> >   for-each-ref --merged HEAD        6.64s     1.66s     4.0x
> >   for-each-ref --no-merged HEAD     6.75s     1.74s     3.9x
> >   branch --merged HEAD              0.68s     0.61s      10%
> >   branch --no-merged HEAD           0.65s     0.61s       8%
> >   tag --merged HEAD                 0.12s     0.12s       -
> >
> > The large speedup for for-each-ref is because it checks all 10,000
> > refs as tips, making the O(T) inner loop expensive.  The branch
> > subcommand only checks local branches (fewer tips), so the improvement
> > is smaller.
>
> Hmm, I couldn't reproduce the speedup on something like linux.git (~1.4M
> commits) with a lot of synthetic branches. I'd think that old branches
> would be the most expensive, so I did:
>
>   old=3D$(git rev-list --reverse HEAD | head -n1)
>   seq --format=3D"update refs/heads/branch%g $old" 10000 |
>   git update-ref --stdin
>
> Running "git for-each-ref --no-merged HEAD" takes ~650ms with stock Git.
> But with your patch, it goes to ~830ms!
>
> So what am I missing about your repo that it is so slow in the first
> place?
>
> >      * Hacking the array index into the decoration value as (void *)(i =
+ 1)
> >        instead of storing a proper pointer
>
> The decoration API is not the most generic option here. There's an
> oidmap type, but you have to embed the hashmap bits into your struct,
> which is a lot of boilerplate if you're just storing an int. You can
> define a khash with a custom value type, and I think the existing
> oid_pos uses an int, which might be enough. All of those will store an
> extra copy of the oid, though for the sizes we're talking about that's
> not the end of the world.
>
> Since we're always mapping commits, you could define a commit-slab (each
> commit struct gets a unique id which we then index into a big array).
> See commit-slab.h for an example.
>
> I'm not very familiar with this code, but I wonder if we actually need
> to map at all. It looks like we are mostly interested in set inclusion,
> so perhaps an oidset() would work. Or even a bit in the object-flags.
>
> -Peff
