Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73333BBBA
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782511072; cv=pass; b=cRLTG1WvJY8TP2ULIboma+1J8U50nNwfjjohibQe1FR3JO7iIaPnVVZPD3Fu7ydqgAO5l8LgXHjPJoUNZCiaQymmc17unQR7h89MzAEkwBb9x3cGATRw0k/U0lKWrGgvZzl9qioHtqDtO1KCIqEMpTKQDdqOdALVtqvAmpBGUA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782511072; c=relaxed/simple;
	bh=uqzJvGe0OosVzmU+++G1CXfUW4ELbg+6MU06LLryvNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnmxmUi299owSwosQW6V3OohOIIVND5X7xkx7+Xp3zLa3jHLBllJ4kotDJSWazclVis369J6DVTuSWRy8/nXeaRr5R9nkgDb/qSYyOCxCugxWchcxe3iOQCg2mvbVHB98G2s7a/z7U+Xxs0a+SLjziNyUtKbD/QaK2wBO7ssS7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=alnH/MqI; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="alnH/MqI"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-664b2c00e12so467181d50.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782511069; cv=none;
        d=google.com; s=arc-20260327;
        b=GsnTeixtudKeyaVUMt5yIel4lxK1hX9uNNnzr6DZCm6CI543GvxuFd7AJIbdw9BU5G
         CaWIHK7t72tXgPPkJGdWa+pPDxcvJlIp79QjURG6qwahPN1LgcTtUdiUUGglwetr8viU
         XarPxaV2YCEWaMp7ZNbEfXA2RxhFJSmZxE7i0DJHmesk5dgmB6r36QFOGs3ST/rl6B1w
         ytS4AD+u2Pgxs6Gx3nAAW5EwmKAGTZlj6wQA+zRQi45EaSp313LPBhl4zYGNeJ/y3DgJ
         8KvJdvUfD6xnJzfXmZQ6RsIZ7cVixMo+QeSf2pltXeGXEYya/PZTMYZ0cpbphO+SLZOI
         uUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pgJwT1lc9fybT3NbrJ+2AOv5TW7IQzxS1OLZKX8FvAQ=;
        fh=Z9uvXJijsAy0fub3qmTL4Zr/3jejIOtjtd7oLjXcbjo=;
        b=Kwznfs2e8XzcQbyWuOhpAcgmWHsjOxkLxOkjPrW9K4HOAH9kr3B0XBqhXBlmO4s5aE
         GBiSteHpoagdF0+qpQPTP9HB3mCMNtITYVDEX+rjZRgi2N2I1TgQTlDf68t92FzKEZdl
         gVHIO605q8nZPBZ7MZ7peC97HChBPtoWQkI/pCzC1g3FBZzHcB3XI9h855f6XdInvfTV
         z8HN4Sh8+askAx0LC85/CTtGfIILSq5WU4fTf/rXgxOG38Pfkn6tOe4Z7PdmSxhQ0B/E
         eLxm+ZYCZFzJAAGQgosWvoWDA+FdT5Fg/3fz5+DsbaLKajuefNuMlh9S0pBI7mZ56kYw
         OYJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782511069; x=1783115869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgJwT1lc9fybT3NbrJ+2AOv5TW7IQzxS1OLZKX8FvAQ=;
        b=alnH/MqIpaQBYu398IKVtnjF100YnmQl4uuE40vZNLpuCkAwS1oxDl70+fHovI0kVe
         +WpGWlEFvzT3HVlZZdS9ISZw4WhNFlcORz0nrx4C7UFCedU+HB/ZMQ/K61/FCxoVfMsx
         ikKq5uGDqrYfsVd8Gh56ZT4/ezm2KjNshHJTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782511069; x=1783115869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pgJwT1lc9fybT3NbrJ+2AOv5TW7IQzxS1OLZKX8FvAQ=;
        b=BM1p4D7s5w4ZZaK/Qpn2eLicPwWQzhaGflIGQwVd6etR5gNOUJjB+dlZHJ9C9lXibL
         ha80NKQwDT+ixj+zUovUFxjuYgotnmhT/aLAsJM62Lyt3PglBeSE42J1ixgIHpHtqIDe
         n+J0o9szoI4mzLZ0HurD5hKm6YK7amXRTbe1QL0ycSFHAkcnv0z+411kh9DPwCjm6DAq
         DoX/VLZgdRnRXJOTDdB6MU2VqhK/OlVmcov0Ihv/a3pvydwH3gn3SFa9QqMAkHgnY+3H
         nf6vlLD/jc8oXBxlefamKcvQe0XtvFIPYoRvK3X7D6kFLyb7kn/PkTI1qKiXCh5c/pGC
         9jFg==
X-Forwarded-Encrypted: i=1; AHgh+RpuWVEDpGeT/UG9FBoXx2No9sYvnijNYyRumcOAxCkIZtByNwE29d4gcuEnrbHX0pk6aX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwePCVd/v+5EUEBUFWa4fdB/7bAETnvhEM+fYBPWtXdPIPKj61G
	YuK/A3gPuKZ+gy8e7dtOGh+vS7yVtyM2Tnm0o1XwoUBQSjosF0YA8NuMo5QWXwx8R+58KDVBvCd
	SJNLqRt+hFBIpUfP+5Mdb+XKGIR/fQErJ2hfGPHsIeQ==
X-Gm-Gg: AfdE7cmcRQdgXrGX3H3UI8jsC8G/OX7kInGyDUD5Xh2Zm6pBTZJl4LS88cK67lbKuZ1
	PSkn7KLR2Imbtn6bIy/5lw/KmIulC2MEsAbd/bDY69EvkUTVzRJjQBwVyNfqPsVA6xPAaJYjG2p
	Btu+laV8AwvlQLkXdgic67eoeYKr6lFXEZEUYvEamSQg4+PQWrZmNXS4UlnIQbbtoWV0iZi6iGg
	dWstXlhLDqCCTTfbUDPzlYaFhXpDtjrx+uwecDbRjMs/G2Wc0kyZ7WCeNPUmuHFb9UJF2JiNA==
X-Received: by 2002:a05:690e:418c:b0:64a:ce9a:ace2 with SMTP id
 956f58d0204a3-66487e61765mr7193152d50.56.1782511069519; Fri, 26 Jun 2026
 14:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com> <e82e0c72b6fc72b214f40efa9586c77790881f93.1782479286.git.gitgitgadget@gmail.com>
 <bd37b80d-9eff-496d-8f1f-436594968678@web.de>
In-Reply-To: <bd37b80d-9eff-496d-8f1f-436594968678@web.de>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 26 Jun 2026 23:57:37 +0200
X-Gm-Features: AVVi8CfiuJO2Sp0ES23_u1mF4MNMMvLvZPGeTlIUydFVIaJ2tI5QTTfwTtOHRpg
Message-ID: <CAL71e4O470P7i55C1yHyS9zjmDw2fY8J19KbywFgQkfvenBe1g@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] commit-reach: introduce struct paint_state with
 per-side counters
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2026 at 23:13, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> > +struct paint_state {
> > +     struct prio_queue queue;
> > +     int p1_count;
> > +     int p2_count;
> > +     int pending_merge_bases;
> > +};
> Can they become negative?  Wouldn't size_t be a more natural fit,
> matching nr from struct prio_queue?

Negative would be a clear indication of a bug though that's
not checked right now anyway. And since it's not checked
we might as well use size_t instead - and it would technically
be more correct though I struggle to imagine a case where
the number of active elements in the frontier exceeds 2^31
or whatever a signed int would give.

I am happy to change to size_t.

> And some bikeshedding:
>
> Why abbreviate?  parent1_count and parent2_count would be slightly
> easier to read and associate with PARENT1 and PARENT2.
>
> And pending_merge_bases is a counter as well.  Why not call it
> like that, pending_merge_base_count?   Well, that's pretty long.
> both_count?  That's quite generic and nondescript.  Call the other
> counters parents1 and parents2?  Nah.  Or parent1s and parent2s?
> Not sure why this inconsistency bothers me to begin with.

Fair point, I was thinking that the surrounding context is so small
that the naming almost doesn't matter - the terms don't
escape paint_down_to_common.

I am happy to change to something like:
parent1_count, parent2_count, mb_candidate_count
to make it more consistent.

It seems the mb_ prefix is already used for
merge bases in some files - best example is perhaps builtin/diff.c

I see in the codebase that we are using multiple styles,
perhaps depending on specific context.

- nr_ prefix: nr_objects, nr_paths_watching
- num_ prefix: num_commits, num_hashes, num_workers
- _count suffix: entry_count, max_count, skip_count

so I think _count suffix is a good choice at least - it matches
other usages where we typically just increment or decrement.

Thanks,
Kristofer
