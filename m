Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED045DF59
	for <git@vger.kernel.org>; Mon, 18 May 2026 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115145; cv=pass; b=XDT0Nxa+NpyGuMY5CaVpgWH3bPIPdHUzvqn/OcJfd+zAaZiOzt0eLOJae3xVURMbWoZUkzXAM//qSUjyqy8rJ17/soa5wAwx2w9AEBHw9GHnp9DmlWyHxAxUq/Jw3P0SEJHVK/GNxlYanlDPSC5zPswbYLVDfjA6YEBgx7nDCkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115145; c=relaxed/simple;
	bh=8yPx+eK2TNIPbD4Y6Y6m9TBea/RnbqmUicmuUvCfGu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kF3T+1nlU6SJOL301+Tj7ZS2vAj8e6tvNNt0UC+dVXvh2GYqfZ/dO0LmxdhW2Ee5K1puLMHFxXaFif3QH6em8rBekQLTzTSQ5+y/t0K6QkCYLKCQ3S9vVjLuRpp9ldcjlk8uShBx7RlufH1gkFiqAHhWQGsqUYOPs4CnE3jMx38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=jec8RWP1; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="jec8RWP1"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bf14e33f5bso17786957b3.1
        for <git@vger.kernel.org>; Mon, 18 May 2026 07:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779115143; cv=none;
        d=google.com; s=arc-20240605;
        b=JLaKaf9xODjnUo9Gsjez6wpRd8k2lJ5GviL3BZyzW1WOWZDx8AUBPaCXb8vNDVeyRN
         4im6txvCEbvgk2UcX4nQgGN61xGpx1qVMATSSlYBF2L/eGhzoeeWVHxkjyXguG2IpprI
         mkY0Uo7EfpnIirZmVn8TZF5ZTlbFUKY4z4T6yFbM4/a7vwBvqND24pguDwnZN/pivS/O
         VytOVIy+A3PZ084sZ07xWlhkS8ZKitFit0e9s7ZsTrbsG6cV5Rlu1JPDFqV7oIVwIRvE
         M9f9lQgcA2AgY6IjksDqLFs5UlF+xAPxybxJlb7gipBdb1KN0JgCuR1H2UVPaRoF18uv
         va7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZwtmnHZL3FUPAj0y+pGYENoT3GHkYAtIqWssmJJCdpE=;
        fh=/AHsnsY5clFQJJQkylLu8mb701/c/0TVNSB/zcH7yjQ=;
        b=faQWakl0ofnuhgFyhycjTYU9tO7TPi1qFWvdGHBfbzVL1kFilF+xxU6VUPPpfoFzZE
         TK1yC5z2nLm00CPEWHRghZxeoxv4nrX7zZZMYdlKGDxANcDeQRczE4ixeqECHAv2aiYa
         cU6h79g2hzCEzM8VPXC8ChiyvGIREfm3Sd7xbNIbbK/FOevnjPez94gnb2E5ChLNeWUS
         MPNcrOCgnjTUb0jUfcXf+rLVw8zlD6odUvB36eomW63do76b6CoKkBUnuV/IUbIFyaDB
         1Iqtp4GazQ6xoU+oCCgDVXkOIk4RukTq2YAOdC0rHaNijAnqN7iRTwkMAz8r9YyOWMOb
         eeuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1779115143; x=1779719943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwtmnHZL3FUPAj0y+pGYENoT3GHkYAtIqWssmJJCdpE=;
        b=jec8RWP1tPoMGNSTstlBeDi04PJ9IgROqxO4kvHBzmb/oERMQ1BTOQBn5GPFOGb+Vq
         6/1f5aYCy2AukNvh7pyEaG+sGOg2AhRyMJPuUVHN9RLxHSj3gDWuMF4VddIcRSgXr2PZ
         hEyjB7MnGqQUHSYdPA2o0bV6rJYl4p5JtZwAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779115143; x=1779719943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwtmnHZL3FUPAj0y+pGYENoT3GHkYAtIqWssmJJCdpE=;
        b=QIIHM1ApCfRpWhWmaJrFAUACb5lrAip6WMpTg2jcC6SOuDRHXEAyWpES56nfXt7D8Y
         fY2yfgSmbvZxHG6ysqacuFo3D/UX3EjWSABKmLXrp9VQk22f2nxFvbdWPJhtvURH6NQs
         bVZkLUkg+jcA4fBxQbK7klqNAkVWGIQUGkjNaJd8HmQot4+Ntkbd5Pafu9tU+FLqB+5U
         h1WePo2FvVz4Gwuh//qEv2kp8+HmfMBlBL6kh/75DpDQtKrvjtYrVW1GGPCng/NmzJKi
         DpiLFDkh0Y3R68TF2TsOOihQumCEhhsotKt3Zfm4fu2K/uxR0gQQxcecdQN5X1cBhr/v
         n22g==
X-Forwarded-Encrypted: i=1; AFNElJ+e/NdSuKHHE96HZYatoD54OPbcotpZXmYi739ab6biCxlmDJYCqYZ+g/CEJKbcPSlL5Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/0cb3CWMib/Mhcz5LZGupI9aoMy9v3V9MGLhEB9Ttm+bsVXe
	AjYOCLSQbZab3ybJW+5PTeElNye455U900YOMw4qvrFMdwWGOSdt+CEATdke7mao2SxRjmdM7WW
	mOXHbn6VOggjn0sHcFzfs0YmIrZe4/Rw0gAxw2z97nQ==
X-Gm-Gg: Acq92OF3tO6rL6fWbO6zYv8iU9oNSFpgIlHFDJXD8LDUQTsetXi10/lZxxLuOATmsZE
	s9i8VnVcXRdZn9yx52cnGmKjLqbVXcub4aLgsIrrZirq7uYfn6ysDDHJwbZwu+Ya3llXAEocYvr
	UidAfGhmCWsliP2VHcaqmDS5bbzRsfeeq4p7au1Kjgn/qb+X2OOY/H54iPaiWMQBFFbNHKATK2a
	UEPC2ys/9VCV+C4TqrjuYCDd+nXRjjwBWECMMYRKcRdV1gTasfuwpte0M+SSmB+XcG772ZhfLhM
	R6QQ3BZPUIVW04f6sFU=
X-Received: by 2002:a05:690c:c513:b0:7bd:9899:f90d with SMTP id
 00721157ae682-7c959e867f7mr173926097b3.16.1779115142972; Mon, 18 May 2026
 07:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2110.git.1778566286543.gitgitgadget@gmail.com> <c5b333f1-0db6-4aec-a369-6503cb924e7f@gmail.com>
In-Reply-To: <c5b333f1-0db6-4aec-a369-6503cb924e7f@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 18 May 2026 16:38:51 +0200
X-Gm-Features: AVHnY4L_DIWYE1zua8VmHG_Jh44B4hsoSahKR6mK-Zu-k1rMPZHv7BPx0pK7unQ
Message-ID: <CAL71e4NosWg_UwZ6fn0FuaTS89U6Sm9PWAx=gTjFMzMCsEOw6w@mail.gmail.com>
Subject: Re: [PATCH] merge: use repo_in_merge_bases for octopus up-to-date check
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Good question! No, this was intended only as a code cleanup and
semantic simplification.
The code path seems like an edge case, so benchmarking it did not seem
worthwhile.
The main win as I see it is clearer semantics for what it's doing and
the optimization is just a bonus.

Checking if repo_get_merge_bases(HEAD, J) == J is better expressed as
repo_in_merge_bases(J, HEAD)

repo_in_merge_bases should probably be renamed to something like
repo_is_ancestor, since its comment says:
Is "commit" an ancestor of (i.e. reachable from) the "reference"?
but I can understand that it may be painful to rename it in practice.

If I do a mental rename, this becomes simpler to reason about:

Checking if repo_get_merge_bases(HEAD, J) == J is better expressed as
repo_is_ancestor(J, HEAD)

- Kristofer

On Mon, 18 May 2026 at 14:20, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/12/2026 2:11 AM, Kristofer Karlsson via GitGitGadget wrote:
> > From: Kristofer Karlsson <krka@spotify.com>
> >
> > The octopus merge path checks whether each remote head is already
> > an ancestor of HEAD by computing all merge-bases via
> > repo_get_merge_bases() and comparing the first result's OID to
> > the remote head.  This is more expensive than necessary:
> > repo_get_merge_bases() calls paint_down_to_common() with
> > min_generation=0, performs the full STALE drain, and may run
> > remove_redundant(), when all we need is a yes/no reachability
> > answer.
> >
> > Replace this with repo_in_merge_bases(), which answers the
> > is-ancestor question directly.  When generation numbers are
> > available, repo_in_merge_bases() uses can_all_from_reach() -- a
> > DFS bounded by generation number that stops as soon as the target
> > is found or ruled out, without entering paint_down_to_common() at
> > all.  Without generation numbers, it still benefits from a tighter
> > min_generation floor.
> >
> > Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> > ---
> >     merge: use repo_in_merge_bases for octopus up-to-date check
> >
> >     While reviewing callers of repo_get_merge_bases() for a different patch,
> >     I noticed the octopus up-to-date loop in builtin/merge.c computes full
> >     merge-bases only to check whether each remote head is an ancestor of
> >     HEAD.
> >
> >     The existing code calls repo_get_merge_bases(), takes the first result,
> >     frees the list, and compares the OID to the remote head. This is
> >     equivalent to an is-ancestor check, which repo_in_merge_bases() answers
> >     directly.
> >
> >     Using repo_in_merge_bases() simplifies the code (-14/+4 lines) and
> >     avoids unnecessary work: with generation numbers it uses
> >     can_all_from_reach() instead of paint_down_to_common(), and without
> >     generation numbers it still benefits from a tighter min_generation
> >     floor. In practice this only matters for octopus merges on repos with
> >     deep history, so the main value here is the simplification.
>
> The code change looks right to me. Do you have any performance numbers
> to share? Or was this motivated mostly as an opportunity for code cleanup?
>
> Thanks,
> -Stolee
>
>
