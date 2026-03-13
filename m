Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F63F38C406
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405815; cv=none; b=dCqf9BQm/YBu8RvCFPWNlz7n2w1o1OW8M3Qm9oNmir2hFFMTOj9J3FXX471GdYRCCP8wY/GBjBrkSvlHe1RC95A/qWCMOOzLyBy4GTrQ0g5gaCEJK+I/q7zOz6GDlsVahucnd1+sVvUebd8WOdEgyq10iJFcWIWy3gb+F2ucgms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405815; c=relaxed/simple;
	bh=AksxbQRqUbkQ89BVo9nSjwLQYarJEEMxDigzmvvWBl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHvZFS3iLgKFVyC+ekHH3QApBclgbL8cSQi1p0j0iGI5BCt0/554lClFluoGrZ14HbFP1k9tE+5DArlHYuG5Hth+P4KCM237mZO7TDjfIx7aUrdvWaJ07Mld6mAF/ZWp6L3mDELsEKdpUjFcXKjsSNdLrAZczmtWpGfsos+MNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMGvB/JJ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMGvB/JJ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cd73c4a827so205525185a.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773405813; x=1774010613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzWx/V9EHsbS/p/2imjGl+0gaGlnzdZO6G+7vz3PNUI=;
        b=SMGvB/JJf6IsBsBbQ77Mj6RcspTlrPwJ3c5GMONaHvkPBXh6E1lj0IKMMkSxvOIrdQ
         BNmHOpNEVQACTFicG4FzQnTkeElJ4CWjIsZOuBU3WgrouhRKNlXBJ2HholqRS1y6cjbe
         9V4XC590a8OuIWvJ3wGsl7H4MfMWSUGvxjY49K+Rx1Nm3WwlWJBJto57Tz2Q0wgC9+Xm
         qZVHXwkhSn3SjuW9z+bpvG+IzypUVSTSdMk72cvNOPyO9d+iwy+nYItk/zwHfJ+aMIMJ
         /58vxMcaFYUc3IFo/IFd9nPoufDJSne3+huKS1FBQ8kzVihWrdkQa/kDl2sU5ScNuJxR
         UQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773405813; x=1774010613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzWx/V9EHsbS/p/2imjGl+0gaGlnzdZO6G+7vz3PNUI=;
        b=SJb9S4wUKm1iu9e8NicLUyUjw8euqv/AibTJ/qbN2O/PyPzehqF9L9FddL2qrciV//
         8+A/xoKeRPhcSiSeuckS/HbTQq88/L1Whsp/AdFChCxgAUTTh/4DTy1f+np1IQNz01rv
         XMjtYUmANym0k1RQA2iOfVX/GEnf7YjiuMdiK6ex7oPyDjyhWg7EoJipOeXT8uD+T8IG
         PBAb4zmFLiEOfbH14+vMhh2B7RgyCSh57j1h6JyTe4c93eGBO1vgDBCWJ+6TMPVR1Grc
         ZsA8myEF9OUjDbi6gNkKhiXR6kBm5SvsE+mBBE4ATHICV6WK7xLUy/xhHIgRIOUbgFaW
         /iUA==
X-Gm-Message-State: AOJu0Yz6ZctcszRlANktS60GBcF03KL608og48HlOIcam4j48oJ2A2Yf
	Eahj4bNFo9goa8varcj9N4TuOAmSS+UQZIyXTfEhqTGMZRpZl+y9FO9m6FjOzg==
X-Gm-Gg: ATEYQzypvI1RI2toBMNP+bcNuUbkgR6liVAw6n58QE7ytnSSRKHa/QUY/qWcYrVzJd1
	JYAVeVMjX2Kv2eC68jw5MUm98lFTCDATJCTQM41FTRXpIbwvnx1j/Md3HCWd+u2hBvcHdZO4PUo
	HpP3GMXqVEBtiXs323qUqAv04AwcO8Rn9EJrHKz/PBj5tKQN59QqLVft06i3g1WNok8sr2DIGlU
	Vov7rT1QYyrILnG7JajQKkkKsLDvqR0yCkypC2hbCD1YHKi2WI5tSA9nHdfpqPXPjKxpBLcwmkb
	oKaKLtJsQs8LuQvW7I5yLi0TGwxh2O/W2+9Es/kbpD4wmEta7OQeFql4f5gnFA8TB2azyqJ1zfR
	4O5XbHVNvxY95rAp56AIVhjmTqvrc5Qze5lGRbridGXHUXIZfaH5cvbowl2cJOBCshIRpmL336q
	a/kAO8joXE8CG3n5IhqpfaK5nJeYHWcCmP1VNqo7zz08750K4orVsIGUSqMgkDpBjCmYbRHztmP
	TTxETGFMA==
X-Received: by 2002:a05:622a:1a87:b0:502:9b85:a609 with SMTP id d75a77b69052e-50957cdf6demr40323171cf.30.1773405812766;
        Fri, 13 Mar 2026 05:43:32 -0700 (PDT)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a146218sm51873691cf.30.2026.03.13.05.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 05:43:32 -0700 (PDT)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	peff@peff.net,
	gitgitgadget@gmail.com,
	christian.couder@gmail.com,
	hanxin.hx@bytedance.com
Subject: Re: [PATCH v3] promisor-remote: prevent lazy-fetch recursion in child fetch
Date: Fri, 13 Mar 2026 06:43:29 -0600
Message-ID: <20260313124329.75626-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <abJqySqfdFoY8cEu@pks.im>
References: <abJqySqfdFoY8cEu@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> I must be misunderstanding something here, but how is it that a commit
> can be garbage collected if a ref points to it? That shouldn't ever
> happen, as reachable commits should not be pruned.
>
> Or do you mean to say that the commits don't exist on the server side
> anymore?

Sloppy wording on my part — "GC'd" is wrong. These refs pointed at
commits that were promised but never materialized on the partial
clone. The ~77K broken refs looked like:

  error: refs/prefetch/remotes/origin/claude/add-azure-dependencies-EaaDn \
         does not point to a valid object!

They were created by git maintenance --task=prefetch, which runs
git fetch --prefetch --prune and writes refs/prefetch/remotes/origin/<branch>
pointing at the remote tip. On a blob:none partial clone it fetches
commit/tree metadata, but some referenced commits were never
actually downloaded before the upstream branches (ephemeral
CI/automation branches, force-pushed and deleted within days)
disappeared.

This is a red herring for the patch though. The stale prefetch refs
explain why the outer fetch got a thin pack — the client advertised
haves from promised-but-absent commits. But the recursion (depth-1
to depth-2+) is entirely inside fetch_objects() with noop
negotiation, independent of any refs.

I'll fix the commit message wording in a v4 if you'd like.

> That's certainly curious. Do you maybe have multiple remotes attached to
> the repository, or are you dropping/modifying the object filter at some
> point?
>
> All subsequent fetches need to use the same object filter as you've used
> during the initial clone, otherwise you may run into a situation as you
> have described. But in theory, Git knows to continue using the filter.

Nobody intentionally changed the filter. What happened is the
lazy-fetch child kept re-writing it. fetch_objects() hardcodes
--filter=blob:none on the child argv, and the child's
builtin/fetch.c writes the active filter to config.

23547c40 ("fetch: do not override partial clone filter", 2020)
guards this write behind a check for an already-set filter. But I
was unsetting remote.origin.partialclonefilter manually trying to
stop the storm, so the guard passed and the next lazy-fetch child
wrote it right back:

  21:45  (unset)     manual git config --unset
  22:05  blob:none   re-written by a lazy-fetch child
  22:11  (unset)     manual unset again
  23:11  blob:none   re-written again
  23:13  (unset)     manual unset
  23:28  blob:none   re-written (caught live by a config-mtime trap)

The actual mitigation was unsetting remote.origin.promisor too —
with no promisor remote, fix_unresolved_deltas() skips the prefetch
entirely.

This is arguably a separate bug: fetch_objects() should probably
pass -c remote.<name>.partialclonefilter=blob:none to override for
the single invocation, rather than --filter=blob:none which
persists to config. Not in scope for this patch, but I could follow
up separately if there's interest.

Paul
