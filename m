Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DFB34B682
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062034; cv=pass; b=F9CWZLYod8nilhSSpXPC7lvdEoYh4rfZqtics7TUBmqsP0mqRw10Ba4kMvIVhNze5K0VBqqXVT3udrucANxdv3/4luWfy8v0MIAKdrAVt11LxuN8cpwWtvd8Ou+GfjvdVP3oUuLQmU7ldG3dnJNuy4p8X1Ynh02lmU2eGrDwAIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062034; c=relaxed/simple;
	bh=GBbY3XUYxh7eFVKs8AwpiZPuwfA7y5tXTad3pKs9t5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuJwRIDhk50xfX/gWMuYEeCTlo0bFC1xhEAlvkOKCczDy1mczuay6+ht6/Z7A8uqAQcKEHBpcLcnq8m09si5Wk2GsLmF4HWpERrqAwVmgHzsQZwFY/6Q5vVCcM0bxoRXIRRsqQHHPUow0wmElhEF8xKKk18QHjkBLSPu8xO0DMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=eUhn3W7p; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="eUhn3W7p"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8114a4542b2so24202137b3.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 03:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785062032; cv=none;
        d=google.com; s=arc-20260327;
        b=TU+y+1r3vXjqZs6NrJhN800c513yNv0+28u3Q7lqKv6Oqb3ec4B2qdoPRdXK0wQ16t
         gPrthnEKi4JqIl/9JPgtIcbXcn7BRl0mctBQNqkmxPtO6eAXp/iDZUwpiqSZRCnsm2ro
         xqdj9DzTOkkJ2gTEO5MWqA6PAEoZYLzcm6hjinePscu4sYu05ucqNrU3eoEmCT+wICuW
         T9sE7OPtXmlhB7n8r8ip0pluioIDFytwRvi3oQz9aov0WBuoAQYtx+aZ2bHmvj8i/HC/
         jJBMPu6H+Hsa9INunBSoBOmk+IqC4ykgPUnGFWZNjdiQzUOvBbvm+hSoEGLlHoVNp6cz
         r61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=md1UMUeLBXAKKvW5OYW2+yRIjSLhEGduRVYRPsxvHvA=;
        fh=jkYX+0T2WKTI2DVhMjyDBn+ZL/Qv0nutvTos4WmDaKc=;
        b=Dt9UxeZkwR/SdsBmf7Tw+hltd6cx2p8E5lyTA0QYQlLIxV/TxBqxuANCYq/WO0D3vN
         7hk0fEadP7jMHr7IKK8opwVGjGmcSZP5YO+n0aiY/egVA9Qvs07sdsDMmyeqmX4azNG4
         1oIvSBA8yrpSUjXJVwP2zOHaZ84rwY//9eUaaC1U4+EDzp5p+X1Wp5l/mQ88NnASKpe+
         jqPS8Ih70s4TUIZSAm1xdVvdPb5VpnU4qpYL6w5Kpz4Se0aK9iMbatUaLokmZnCf+otA
         CPeB5uBfn5SzYCwR283qkDXz41VU/uUfW665S2uCaqwKjPOIqJZIHmIYgIFdwgAGY18k
         VY8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1785062032; x=1785666832; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=md1UMUeLBXAKKvW5OYW2+yRIjSLhEGduRVYRPsxvHvA=;
        b=eUhn3W7p0rb5B9+Fwj8FejqWoTPvERvs40VA8hKL6yvmRw+/U6Z9EMvuSWPVhcNAGW
         LcHC/yOw2avus6lpMOIsj/YRIfGNFf1+Dnd30muq6umcah8IVKXJcg+QwBtPMnbsamSn
         QrvAewiJH4Oz/wKUh9D33n5EfpnMP07HWnZJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785062032; x=1785666832;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=md1UMUeLBXAKKvW5OYW2+yRIjSLhEGduRVYRPsxvHvA=;
        b=h6rQ5TuwGj5axj9OZnA0faIEE/o22jHOI84H704B53GdXevDaTgYlj4b59aDKKWNnk
         +HhGnK0GNkIDV9WFugxlHz3PrJjINpqd8Sm7di7FgywUHhkkeLV+Julz4WlvTPnQsBQE
         RlzdDwiOiKG/Jj2wQjebSHx9ibd3RaV6udJGtSgzrLCAo6RdJa/DjdJz2qwazqLyICz6
         cHrmCQnwI5nfON/KxCn9uYqkiAeM3rNI6++e+rEOqYe4BQs3bMrSZ/B4sVYnbKbxgki8
         7DZmq1c3QrdEQE6v98RBqRMvtp4MpOpsQSRpjvLzr+GrjUPAMdA5P13nFErjK2dFIWFS
         4Y+g==
X-Forwarded-Encrypted: i=1; AHgh+Rp1vUEYjl4PjqD4vN7ItZ3ETUAYuOQUMQTrFONARzvJ2FWbgCyUrU5lmBDo9nrqmtuUUXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvpr1geK+f8lex9YWpj9m/m5Ighc1hprVUK+IGqY/YFak7YRFE
	gXNCU4F20BrvzFDSS4fC7aa5MTZe67GhjJsRoBoAB2QFjOFSA6xs/pdWWBS6sJF5Xr0r08+TSbE
	pt4k0cJM/ydQjp8qPp8Tqmg9kewz76OCz8AksFUGNiw==
X-Gm-Gg: AR+sD13UJwDWfFrsXACZC9msnhqwAaHBWPM6ENOrAIRulz7m2PiHY8R2zRgy3F9MrV6
	rKT1P5NQAG7zr3MIqdMZqFEGkKFqgOrRosK35BQuh3Cz8DQ/5oHWGj8wEI/7D0F0D3NitZTSTaW
	TgekWi74jIf262/mMzKZ1LqmGEQD1d7U/JqIgdZpBxwY4VT9+N9hgZVXW4cgFrftr7EU/XWovzN
	QXUo9Teju8XrD6qJakJn847mzteoHNgx1s6mFVksmh5y1Z2q6Diwur4CZlSgtw=
X-Received: by 2002:a05:690c:4d41:b0:80c:85e5:8751 with SMTP id
 00721157ae682-81f69e6bbb4mr18415527b3.58.1785062031737; Sun, 26 Jul 2026
 03:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
 <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com> <5ef4f08105bc5485444e824cec39e684692a9348.1783776466.git.gitgitgadget@gmail.com>
 <CABPp-BGvoZArZ65ge_2qabb9GQDbtWG=pP=g4bZDmAvX=yF=xA@mail.gmail.com>
In-Reply-To: <CABPp-BGvoZArZ65ge_2qabb9GQDbtWG=pP=g4bZDmAvX=yF=xA@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 26 Jul 2026 12:33:40 +0200
X-Gm-Features: AUfX_mwjzLqUhDMFLui9si2lXc0dOxAPCHzx6Q7gJECfIBjGYV-0LFcBeyVdgK0
Message-ID: <CAL71e4Mve9EbTkuWoGdtNTJJC5oj_W9enfSceMvH0FFm4T8ALA@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] Documentation/technical: add paint-down-to-common
 doc
To: Elijah Newren <newren@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Jul 2026 at 08:59, Elijah Newren <newren@gmail.com> wrote:
>
>
> Perhaps we could lump GENERATION_NUMBER_V1_MAX the same as INFINITY
> for this algorithm, since GENERATION_NUMBER_V1_MAX can also violate
> the ordering we want?

Oh, that's a nice catch. I had completely missed this V1_MAX
saturation case! I spent some time thinking about this edge-case
and fortunately I think it's very hard to trigger. You would need
to construct a graph with 1B generations, which is a very big git
graph indeed.

That said, regardless of how hard it is to trigger the code should
be correct. I agree that we could lump GENERATION_NUMBER_V1_MAX
together with GENERATION_NUMBER_INFINITY since they are both
topologically unordered values and naturally must be topologically
above any lower values.

I considered two approaches. Both are correct as far as I can tell
and both only matter for very large v1 graphs, so in practice
either should be fine.

Option A: remap V1_MAX to INFINITY at load time in
fill_commit_graph_info(). On the read side:

    uint32_t level = get_be32(...) >> 2;
    if (level >= GENERATION_NUMBER_V1_MAX)
        graph_data->generation = GENERATION_NUMBER_INFINITY;
    else
        graph_data->generation = level;

This is a fairly small change and everything downstream just
works. The write path already uses the separate topo_levels
slab so it would keep writing V1_MAX for backward compatibility.

The downside is that it conflates two distinct concepts: "not in
the commit-graph at all" and "in the graph but ordering has
saturated." This specifically affects the bloom filter checks
in blame.c, revision.c and last-modified.c where we check for
gen == INFINITY to mean specifically "not in the graph" because
a commit not in the graph cannot have a bloom filter.
With the remap, V1_MAX commits would unnecessarily skip bloom
filters. Not a correctness bug, but a performance regression
for those commits. Perhaps not a very important case though -- if
you have that many commits and notice performance issues you
should probably upgrade to v2 anyway.

That said, even if it technically works today, maybe new code
in the future would have stronger dependencies on the semantics
so it feels fragile.

Option B: introduce commit_graph_generation_topo_ceiling(r) that
returns the generation value where topological ordering is
no longer guaranteed -- V1_MAX for v1 graphs, INFINITY for v2 or
no graph. Then the early exit gates use:

    if (generation < state.topo_ceiling)
        /* in the topologically ordered region */

This keeps INFINITY meaning "not in the graph" and V1_MAX meaning
"saturated but present." Bloom filter checks continue to work
the same as before. It does introduce a new concept that callers
of the ordering gates need to be aware of, but the concept maps
directly to the underlying graph format difference.

I went with option B in my local v7 draft since it felt
like a less intrusive change, though it would be nice to hide
the v1/v2 differences more from the rest of the code.

Let me know if you have a preference or see issues with either
approach.

> I think what makes the min_generation cutoff safe is that callers
> passing a nonzero min_generation (remove_redundant() and
> repo_in_merge_bases_many()) don't need those deeper merge bases at
> all: they only need to determine reachability among the input commits,
> all of which sit at or above min_generation.
>
> Is there a risk that with the current wording of this paragraph that
> future callers might be tempted to pass a nonzero min_generation and
> still expect a complete MERGE_BASE_FIND_ALL result?

You are right, the wording is misleading. I can update it to
something like this instead (will polish it more, just a draft):

    Note: A non-zero min_generation floor means that you are not
    guaranteed to find any merge-base, it is purely useful for
    determining the ancestry relation between the input commits.
    If it is set, the walk can terminate as soon as we have passed
    the bottom commit, because we then know that there is no direct
    ancestry.

Thanks, I really appreciate the careful review and spotting
this edge case!
Kristofer
