Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05833DEE6
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343745; cv=pass; b=YGMwx7jZgfUCF2SjDTPPUhV2JrQlIttIeOgeO1A62FTPg0VnF02hSRPDXVBaufq4bdeWTGvoBawbgi8sTYaSJzp8NQeJx0iAo7vYe+eXZ5xjkoa8gnVhq2bSJS1HgqzmKrXPI1cplDqdFi8KKtbUeUHJQNsnRcpPj6Lgrsakvfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343745; c=relaxed/simple;
	bh=U8srrEKTtZhQKxc3sDk+8X3qAe90GjlNOhsAF5oNfyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1zzem5SJFa4fvrCNiozsHXo3lkmA3eb8wmGz/uy/vieMgVUv/fUCm7DFDUaOb3iDSOq9bP92zc7hP76ChoQ29tiV/lixIEig/JWwoqeSTXSa3Ahu6FA0YZcpsAr1kzrbldNVxNcquvYrRlB0sLpyavweFQS4ikQhLYvGH1yTnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=YelSwBRr; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="YelSwBRr"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7e1c3f47d78so19549287b3.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 02:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781343740; cv=none;
        d=google.com; s=arc-20240605;
        b=XqGYrgv89it1U1UNDnQYvD/0K6SnNJ4X3va/APzlvkmMbnO0plsqWmQvw97hIZlxUc
         h2RYq/g1Kmu6vhVufyh83zNXhZGVxK8r/z7DQ1acdfpwk+4NL+6tp5dTorMUsgbiPOq+
         c7JR6SYP00ZXVPnSCc3dLYyCemC7s13UrHNcjZAsGJlI5AQk8qpK7T2vGVvLNWtDOGIV
         X3PCNoWq9IBw8IJilChq2xyEOHrHyLGc3tX0dscW8Vv4pP7SrXpvx4OMZsfiLW/UwJ1+
         hvtom8hOmPHxzeu1zEyZEiTbEe1o2hQW+/g+b8iv18b1rIkCMel6z0CVm2fKOqEpr6ES
         aJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gp01Gg9d3qEjgaBE8k3jKSLE9qbtPiF1YOu+AdNoHng=;
        fh=2qQh3Twk/9BXP2JN1YJEg5XG37bzhSBn4OXZs4ZhyG4=;
        b=QLwAofjQ1XMnjS14NfCdQDtlLmpJphxsrtaN1vP6Cjv80fQw8stXSfEwBm+QHAhAmx
         jKEXbBdZmESGd8i3/NGiF5QAEN9SsovOkuTYZEhcO9cHKb2n5ObROkZL5oKcFp5X9Gr5
         YXulZkqWXXg7HVYfMV8SLGS+WBZjolTCkyvsztik+9D3FmV4x3/B3JfwlRmXkWd7ZeFh
         hwWDR4uVp/JF6G5d45sBMhZ/KEb9NnNHUWRBNw0sLm8P4lapbQ33qync+tiK2Sf0VdrA
         JTdyZyDOpYOUgcuuApHOkCpDUBP3nTeGUUlqvFrVKx+fEruslHKfWGZ9ZGo3c/AwKai1
         iE9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1781343740; x=1781948540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp01Gg9d3qEjgaBE8k3jKSLE9qbtPiF1YOu+AdNoHng=;
        b=YelSwBRr+NpQYC+DhzlVeNNKXWrxzYycCQegsv+asNEXjvtP0+a/jMeaoshLvGgjjs
         uGzPQodtK38rH6UXi4g8EAbkVkDwW2hBzPH8h0xlCYwFRbmcvjUg+etxjmN4XLeRZgpA
         wjmxTA16iYOqfu5j5bSPetsVTm8HcNmDVoIIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781343740; x=1781948540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp01Gg9d3qEjgaBE8k3jKSLE9qbtPiF1YOu+AdNoHng=;
        b=p6PEjNVzhoquBZf9T4QZV0XHdc9nqGR2Fv68Ao+eGFbw1LSFevfPjqMIRWuB/bX61f
         Wn6fyA47AJjRP73BqE+yCmYAB1QP4+Q82mr1bli1UiM5uMKKP+0LV/qqNZcAsbe3FSeo
         tD0c/o5/dMaZ3jeXgpoKspfcS5MB1qjw9UBzbub8Nuq21cIXxLhQdZsRPuD97az3rp3B
         Y+3Izadwkqrw0ijcN/JRqZWCMbB3lhDV+uXZPsdK4O306ZfQ/txjWxvp5CRM5pTca1q3
         uCfWZlnwqJIzxqXKQd+W/nYlRupLMnnRBY0oEytsPYJ4R1hlXext21ryfYiuk2sEG3Wm
         xehA==
X-Gm-Message-State: AOJu0YzC//SK8U8mIzrVU1zpJWGfoMS1vnt6C6sYUFziU7uoZtT1H6ew
	6pxigSsoniAFFmVW2z9x25GVCW8kF0wVrmNbZQcprlxLvgNp1jjvV8i3/PSXt4zccO8qfNbOLCE
	YGBK5+hDeTiw5GYdkzjyyYAoKoqDu+UQNvO9DR6mwVSwIYH/oCyzwP8E=
X-Gm-Gg: Acq92OGZ8rihVhwXLc4gEAMgPE0xmhHRSeoApfay0UiAQAGeLTpQKnVFFUKHrSId8MG
	idZxOuxL2pyKF9pfwY3uZpHbPQ/424R+GB/u+HK/uhoX3O4QUDOtmP2obxO5EdNzfbF6RF4sa7m
	Aaa/9zHtZY8fzk88ay9nb42aZ+doKmZJ6u4VVf2L1l8sDbcPyy3LBNArPxuiFW6XWxuiH6r0c5T
	dEXhMEuYQZRaq6SvZ5wZijAAy4PyozXSxnfIy1Fl2HY78ijaY20uyU3dNmqsaym+nkSBL2N73DY
	BGXsLu0=
X-Received: by 2002:a05:690c:e34b:b0:7b9:ed52:deed with SMTP id
 00721157ae682-7f7b822c2femr63547007b3.26.1781343740304; Sat, 13 Jun 2026
 02:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL71e4Mp7ewv0UGS8j=iTq6quyxLXzrr0uNDbWR8JKaOsTSVyA@mail.gmail.com>
 <0b3f7429-a4fb-4f7a-bf7b-5a0edeb1db52@gmail.com> <CAL71e4OmPzpCXh-zZ8NsT6L4zVKnXV1gqiFZ2w0XgMJhD=LArQ@mail.gmail.com>
 <8d0902ca-98b7-44a4-a23b-51de44ab6daa@gmail.com> <CAL71e4MFb3UUKBr1P4ZwtK3o1gvUHMs+siCpLTXKkW6Vx=BxRg@mail.gmail.com>
 <8c06cc48-d036-4d01-98d3-e94b5edb389c@gmail.com>
In-Reply-To: <8c06cc48-d036-4d01-98d3-e94b5edb389c@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sat, 13 Jun 2026 11:42:08 +0200
X-Gm-Features: AVVi8Cds4esW9eXPjtVt1J5uPIWpZGM1GabOJqh17ugmjXSQyOnLlP8vHy1qzEU
Message-ID: <CAL71e4NRvmDagFAJE-0HYwiLPSfhVVQO2qZe-EJPVXxeC4PWqg@mail.gmail.com>
Subject: Re: [RFC] commit-reach: terminate merge-base walk when one paint side
 is exhausted
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jun 2026 at 17:48, Derrick Stolee <stolee@gmail.com> wrote:
> Suppose developers are merging into 'main' frequently. On occasion,
> the tip of 'main' is merged into a new 'release' branch. Thus, the
> first-parent history of 'release' is long and completely separate
> from the commit history of 'main'. To reach the queue_has_nonstale()
> exit condition, we'd need to walk the entire history.
>
> However, if we focus on the single-side condition you are proposing,
> we can stop walking once everything in the queue that is reachable
> form 'main' is also reachable from that top merge-base.

Exactly - I have a similar example and a minimal reproduction idea
for the current problem:
Consider two graph shapes for `git merge-base H B`:

    Shape 1 (fast):       Shape 2 (slow):

        H   B                 H   B
        |   |                 |   |
        A   |                 A   |
         \ /                 / \ /
          C                 X   C
          |                 |   |
          ...                \ /
                              D
                              |
                              ...

In shape 2, A is a merge commit with parents C and X.  X
branches off from an older commit D on the main line and gets
merged back.  This is extremely common in repositories that
use merge commits (monorepos, release-branch workflows).

In both shapes, C is the only merge-base.  But in shape 2, the
walk through X's ancestry is P1-only: STALE propagates through
C's ancestors but never reaches D's lineage.  The max_nonstale
pointer stays alive until D's entire history is drained.

On a 2.5M-commit monorepo, we measured this directly by creating
test commits with `git commit-tree`:

    Shape 1: 10ms
    Shape 2: 4.85s

Both running with stock git 2.53 and both found the merge-base C.

A single merge bypass to old history is enough to force the walk
through the entire graph.  In practice, master's history contains
many such merge commits, which is why we consistently see 5-7s
wall-clock time for merge-base queries.

With per-side tracking, the P2 side exhausts immediately after C
is found (B's only parent C has been processed), and the walk
terminates in 6ms regardless of how deep the P1-only bypass goes.

As you noted, the "release branch" shape is another case where
this helps -- the main side exhausts at the merge-base while
release's first-parent history is entirely one-sided.

> But I think your single-sided approach is a better way to get the gains
> that you want. I think that case is much more likely to occur.

Thanks for working through this with me. I started thinking the idea
itself is not strong enough on its own, so I have attempted to
write a more formal correctness proof covering the
drain phase, result exactness, and the INFINITY/finite region
boundary. It is too long to inline (~2000 words) and the high
level argument is already in this thread, so linking it here
instead - I consider it optional reading, since it's not really
light reading and we can likely make progress without it:

    https://gist.github.com/spkrka/621695aa464df2a8c1837e9abca822e3

The proof assumes finite generation numbers (commit-graph
present). The side-exhaustion check is guarded by
generation < INFINITY in the implementation.

I am far from an expert in logical proofs though, so this may
not be strong enough to be useful, but it may be possible to
fix it - or it will uncover some flaw that invalidates the idea.

> Thanks for your persistence in working on this through my
> misunderstanding.
>

To be fair, I think this was more a case of me not being fully
able to explain the idea with enough precision initially, so I
appreciate getting the opportunity to refine it with your very useful
example case.

Thanks,
Kristofer
