Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB913603D1
	for <git@vger.kernel.org>; Mon, 25 May 2026 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706067; cv=pass; b=JrFYOotuWA5eIrTJKXo6+irs2xsrDCqtQ2J5o1evfSy+9fDxAM+kPMf+0Ucwvb5w4fp220EAIJBvMCffAVSpH9CtI5GGzgTdCKM5YfTAA/UeeTJXoN6Wx/9PKk4ekvViGZxZNb7xYsww0OJiK2mOxQ21W5yHSmFku4szl49x8HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706067; c=relaxed/simple;
	bh=0wO0jOxLx41cXAQmqoFdcLPjcbIR2PQm+DfjCgf3Bvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ts4V6HUsVuGTzxIStArEGE5/LMLg+tuUNVGyDL3zCgvsJ1YuQ5qzE203lxj4dp2eK3Jd1EEkBqGvV9Fl064E5GkvZM/Vjq5s44XfhzsTbmfuUE0N7TajvNIZtqupiint9M8PR24s0jxjqI2HiMGGi0iSbFPCvHDO4Wyqim8yXmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=YjQbSrUl; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="YjQbSrUl"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7cb343d343fso86758147b3.2
        for <git@vger.kernel.org>; Mon, 25 May 2026 03:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779706065; cv=none;
        d=google.com; s=arc-20240605;
        b=NiUgJxbtsc+NXj2oAvTf5Y5+C3pEqCAYhyuZa46EeXek0KZdjWxjHC3kToDE1gla62
         AJPj9zlWBR+Agc0JfIrW72sEEloNpP/Tol5vLQVPOfvmbjzoUZtkUKB+FThHEioohQJ9
         cyaWQMWPgVyDO9HqxKGDVUnOZIMS4we5kKJ9cHmR7L+O1X01GJv+GllHzqOgK4kBjQO4
         xvR7UIoWvUqPi+qI5GIvVM3mJUAlWrQZ82Wlr7ZcY05EpQrU5kipJvesHf1RXhIhHBy2
         fGHRRrgRPJBDgS0H2ZdgUmxriZk2+7mtG181lhc9vcNjGLwg07Gsy/vfv2gCgOY9FIU0
         zofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zlTCvd5BqH5uhSJwD3Oout+QyNDQEbgZDnBsr7iHhlA=;
        fh=k2OjgMYzhiBpKhkuaKneBbKI8QBa+51qmrT2pvg2GQY=;
        b=DAkeXfTtOi/ofk7+yXUVq3Nsnl0/UHe/dTff9QOIAAIAPGvnavyg47o+PGwn5rp9Ya
         3YcEp8qQsw3YACronfyjOLhNVpNTFHsJj0KeRR0Q3luazseVg7Rq8mj4mJ4qF/pOTT5+
         EUaO9wAOagIu6SJM/UU4yJzPWvHZeyEib9wVc6TM8irb9vju9SrpYn7cYFFKMOtt96JL
         Ns0qKCZOEMXLx8qXosXMLh3Ot8IM+yFmqUke45QNfhdYZkJyIWa0PV9exYBdpISThr2n
         /ma90HVAn1V+wEpOa36KlDYLzqgU8FXrousyRZc36U01qGoEli7aVfq0Wwq+H3A89sAz
         dGtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1779706065; x=1780310865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlTCvd5BqH5uhSJwD3Oout+QyNDQEbgZDnBsr7iHhlA=;
        b=YjQbSrUlIAu6vk6Wl3azd+3PKwbGj9s0rvdaI4FkPwQ5LYa7nHpOdCZy2kNkBZSf/p
         gG3mauVIP3PkZOtl0Gl9sWrqzKPYKP0O6AT8NIyWAWhh5nDKsx3NCYlTObcFpcg8O3SR
         cDZ5ZbpniVHjImW2J/KKcFOpFBX68Hr2j2cqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706065; x=1780310865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zlTCvd5BqH5uhSJwD3Oout+QyNDQEbgZDnBsr7iHhlA=;
        b=AB04ubS2iJergpikAGXKkP9atTRnrOPwkt1IdSdtZmL03SZSEpNCiChHHLMbeqjYmg
         lSDVKYIqZAi1GJxqXR1tM59k4oCywi/QKDk124spTp5pzaV1zcjd63lj/g3UewiZHMx2
         6S/ln4dnFBiW1CwFsJnZC/Q1rJ0lWTq6f4FZ0cYi8o7S7Ooy/EfqLub5Isu3V3PR04vM
         GQ+/EFxX0RCzuswV9YE2jQ4qRiPU51c4A4ecbf0MX3YbuHv4l+T/DYXrESuqXD8pRP6r
         64GGlzdzC3+ps5TB5PCGsjw0L6Te+yRQp51WREJe8EejxYP/rSG5lW/Q4yaXF8jNPYVh
         vHPw==
X-Forwarded-Encrypted: i=1; AFNElJ9ETjwqKjHVAIXuqGB1ESkwUq9V0NTu6dGIN2GGW3lghRMXg5gocNmRAAXqezlK9THdk3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGWgNhlUu/yZ4SSyGncxHzhYiqsuP3EjYN8AoNZfBct40KwLr
	hXFFg2tfGR4fEbqIFHZuHCfr4EoLvKBVFY6RBye+J/VvTnNuS69Kp8H61oKPwLpnsWnY0Ex37OC
	DPMziuDaj/D3aI5M8JJvYeckhocsw4XNSJ8VzbxSc+g==
X-Gm-Gg: Acq92OGrGlNSAVCljHOYHxrtLBt+Kt1QzJW8Bw10sxTqUpbFUWA6CAZF7TiWyWnr61O
	dLY7FnH0CHPx/TbYSp8Tb8yXzt44+Lrq6O4mM2/oYjnpy4cceE9vdThegwfbEF2uMdzLK6UCMPO
	rHxPZSIY9yK1LdVZmzbFvkyjzGQ3Kf8eOY6iEBbC6tFkFgevhxTGl50zWOnB37me6hSfm7qEAxP
	XseI7a0ok0IULgT1xd85Z/XUUzZurEU130Ecn2Or6MVO6shuwe+Fdq5BtLzPR+SBZL/wA2rzMB7
	UqsxsUDj
X-Received: by 2002:a05:690c:67c4:b0:79a:c40d:b734 with SMTP id
 00721157ae682-7d3371aeaeamr168317007b3.48.1779706064625; Mon, 25 May 2026
 03:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
 <20260525064755.GA2737798@coredump.intra.peff.net> <CAL71e4MOH2iPve19dKixLHSgpC3ZAZz59zLWEWRoxW1a7vhMwg@mail.gmail.com>
 <20260525095506.GA3868724@coredump.intra.peff.net>
In-Reply-To: <20260525095506.GA3868724@coredump.intra.peff.net>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 25 May 2026 12:47:32 +0200
X-Gm-Features: AVHnY4JAAHsZO3BDfi51fo6KaJet7dH71j4K1oNnWpR1XV173MNZS6FeKNryiAs
Message-ID: <CAL71e4P0Ls9r0oAOeFoEUzD8Z+fBNKGAvLi-1zH+gb_nV=Ro7Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] commit-reach: replace queue_has_nonstale with a counter
To: Jeff King <peff@peff.net>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good point, it may not truly be amortized O(1) =E2=80=94 you can construct =
cases
where all the interesting commits cluster at the front and the cache is
repeatedly invalidated.

That said, I started thinking about what happens if we upgrade the cache
on every enqueue, and I think there is a clean O(1) solution that
eliminates scanning entirely.

The key observation: commits transition from non-stale to stale but
never the other way. So if we track the lowest-priority non-stale
commit in the queue and maintain it on every enqueue, we get a tight
invariant:

struct nonstale_queue {
      struct prio_queue pq;
      struct commit *max_nonstale;
};

static void nonstale_queue_put(struct nonstale_queue *nsq,
                             struct commit *commit) {
        prio_queue_put(&nsq->pq, commit);
        if (commit->object.flags & STALE)
                return;
        if (!nsq->max_nonstale ||
            nsq->pq.compare(nsq->max_nonstale, commit,
                            nsq->pq.cb_data) < 0)
                nsq->max_nonstale =3D commit;
}

static struct commit *nonstale_queue_get(struct nonstale_queue *nsq)
{
      struct commit *commit =3D prio_queue_get(&nsq->pq);
      if (commit =3D=3D nsq->max_nonstale) nsq->max_nonstale =3D NULL;
      return commit;
}

The loop condition becomes while (nsq.max_nonstale).

Why this works:

1. max_nonstale always points to the lowest-priority non-stale entry
we have seen. Everything behind it in the priority order was stale
at enqueue time, and stale is a one-way transition, so it stays
stale.
2. When max_nonstale is popped, every remaining entry has lower
priority and is therefore stale. The popped commit's parents get
enqueued though, and if any are non-stale they restore
max_nonstale via nonstale_queue_put().
3. If max_nonstale becomes stale between pops (e.g. painted from
both sides), we don't notice immediately =E2=80=94 the walk does a few
extra iterations until it's popped. That's a small bounded cost.

This seems like the best of both worlds: O(1) like the counter
approach but with the simplicity of the cache, and no new flags.

I have it implemented and tested it locally and the performance is identica=
l
to the cache version on the monorepo.

I can push an updated v2 patch with this approach later, unless something
else pops up from the discussions (maybe I am wrong about all this!)

-- Kristofer

On Mon, 25 May 2026 at 11:55, Jeff King <peff@peff.net> wrote:
>
> On Mon, May 25, 2026 at 09:59:59AM +0200, Kristofer Karlsson wrote:
>
> > That's an excellent approach! Much cleaner in general.
> >
> > I benchmarked it against the counter on a monorepo with wide-frontier D=
AGs
> > (2.4M commits, component import merges). Using merge-base --all to bypa=
ss
> > the early-exit optimization from kk/paint-down-to-common-optim:
> >
> >                Baseline    Cache   Counter
> >     import(A)    8079ms   3686ms    3723ms
> >     import(B)    5498ms   3993ms    4038ms
> >     import(C)    4350ms   1748ms    1766ms
> >
> > The cache performs on par with the counter - within noise on all three
> > cases. No new flags needed, much simpler diff.
> > The amortized O(1) is just as good as true O(1) in practice, and it avo=
ids
> > the ENQUEUED flag and counter bookkeeping entirely.
>
> I'm not sure if it's technically amortized O(1), as I think in the worst
> case we are still quadratic. That would happen if we've cached some
> non-stale X, then pop it and put on some new commit Y. And then the next
> round we have no cache (X was popped), but have to walk the whole queue
> to find Y.
>
> So I think it's more of a "heuristically O(1)" or something.
>
> > I went with back-to-front scanning as you suggested
>
> Out of curiosity, did you also time it front-to-back? What I wonder is
> if we might commonly hit that worst case for back-to-front when we're
> continually popping and inserting one new commit at the front of the
> queue. If there's a bunch of stale cruft in the back end of the queue,
> we'll walk over it repeatedly to find the new commit, and our cache will
> never (or seldom) remain valid. (I know it's a heap, not a real queue,
> but I think the far end of the array will still tend to represent stuff
> that is further away from being popped due to the heap property).
>
> Whereas looking from front to back, we are likely to cache something
> that is going to be popped soon. But in that case we find it quickly,
> and the longer we search the more likely it is to hang around in the
> queue and remain valid.
>
> > and also clear the cache when the cached entry goes stale.
>
> I think this happens naturally when we call into queue_has_nonstale().
> We only use the cached value if it's still non-stale. If it's gone stale
> then we either find a new commit, or if we can't then we return false
> (everything is stale). I guess the stale commit is left in the cache in
> the latter case, but it doesn't matter because the loop ends anyway (and
> even if it didn't, it is OK to repeatedly ignore the stale commit, as
> doing so is O(1) and we have nothing better to cache).
>
> That said, it is probably only one line to explicitly set it to NULL in
> queue_has_nonstale(), so I am OK with that. ;)
>
> If you're proposing to notice when we set the STALE flag on a commit
> which matches the cached value, I'd prefer to avoid that, just because
> it muddies up the code.
>
> > I can rewrite the patchset with this approach and add you as co-author =
or
> > suggested-by? Or I think I can wait for you to push it yourself.
> > You did all the work here, and just didn't have enough data points to
> > motivate it?
>
> I think testing and writing the commit messages will be more work than
> the code. I am happy to live on in a trailer if you will do those other
> parts. ;)
>
> -Peff
