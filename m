Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794422120;
	b=w9R1T/D3r3nuQuxVBPZzKM9ZMXEo16Hpvgg1qH+iyzhjX5f4+bKxeKWfFCMwA+14f1+O
	 ZFhFA2fuzeEiye1qR4CVzMG+zIJPIuvBmdytm/YA2B5zg536LzwggFUICQP6wkPdEOzm3
	 M3BQPVAVdcNB7djSXrKb777TnqM1RIY2RnOJDYUYff0IvyyqG9dVY/ZpwB2RaKyzdQHGS
	 WWjY5y+f6B2Xk28xEpKPSMplHg2UuTuOW613fqwOYkztxj9OjT/eYo+wqNWf3LpdKpWVk
	 GNGvGWWNS/j0lFURELWLH3ZgBRXxWU1EPCIvbGXDCspICwLf4Z11zxY5SgZtxtm9iXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qa+qaH6ClKIpsgydbngMJIqv5DNkTM1W2bwxY3fudAI=;
	b=Vhccp6vO/ihQoKRC2pvXyonmL5SOE4HYAHIy8swDc3pf8y0guIRrEtU2Wz37FmA6l+La
	 tXT7baPtae7OlmMZTVTPcQNVXVcqNrjAsZzGKY6IpxKT34Qp75oMD9p98grXqQoz6M4Sh
	 f2rNKSoim0C9g+rInJY5zzSLHqoVGk7eT7tjXq5G0ILTyPECjZVEtYKUhAr/CdLrZQKF9
	 v7BZjUJGe+uAqrlTb+3Nxn75bXWPbG6iBdwgzttk0J8truQCDRvwSbhQKSevBYwS/AgNl
	 ou7QCdnKC5EV1sh0bxXJUeE884hlDdDoyj/LzvaBnNnFphZxHTqvZfAEPax/sU695OA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NW83HyQP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C1606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 18:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F7C1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NW83HyQP
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b5a6f2f27fso1383320b3a.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:35:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794422119; cv=none;
        d=google.com; s=arc-20260327;
        b=KaZJaOjN9CCiywtPPokmgERure2AaqmZa6K9N7h385uwM3Py+Q7Em4pBvHkwp38KDw
         wttwxvoBsqJ7Vy6JfeXRxUTw9oKSwINBmVJ+Ly0DpzumrlHrv374tzQ7CHg6zW8waShB
         CO1yPvKQjtu1bRGceA+BPaY5GUsg5fktjJiCOSONdVjrrN+xAn5qGtvzhEuCaIVYgQzV
         12IZ5cVZU/r/qDWCD6QkQUqXBJdOBSesHbWmQkEEH7HXWhu4nQq48TJpz7a9ku25LR86
         StvDtSBGhp4T/2h5zdXACq82vs14G0WRk5cDOHNZtxr00sLZhlqpSYM6L2aFTgyKcisn
         yUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qa+qaH6ClKIpsgydbngMJIqv5DNkTM1W2bwxY3fudAI=;
        fh=+vBiV35eWg1a4iHVhh3sreHlsReA7sd3jfHeaHAb0As=;
        b=F7mdWBkkqTxXnhKa/BM24pquaW0byR5y5/86y31QuLA2sYogpWyncRAD/sjTWLt7dk
         bx+zT2PyxgOuWdd6DMvAXPZbQbI81hhTcsxzYIdz2VJCBKsZ7CDzwbFAgWARZ4yE/ycx
         HOno2lfPd8NsgOPg9d79VOjwgAJ9MmtSijId8LncucCahKEzmU8B8iYGWDbmcvqsZpj/
         QDOUCOBvYL96mbziiZQlleMiLLE2gwM+ZdHXND/rpYzwOUopWwsRSFOY1aRZmH3gZPWa
         ae8lp6iGaZLH7DSKxKAO8sdSGJLirH3nipOdi7HG9EJG0EJFQogKdvKjq6lg5v/0WNac
         QzMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794422119; x=1795026919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qa+qaH6ClKIpsgydbngMJIqv5DNkTM1W2bwxY3fudAI=;
        b=NW83HyQPT54ASjkC88/5aKFVDnb/E6FmmCtKM2wnvT2paAIW/eEpZlM6B/yYC1XrPz
         tQ328jezBqZ68eygwLZojkvPf+s7zXofj+WNCplZsyIZKxNGToyt1H/n1L4kz/hGXeI+
         fFVtcH1veIzT6As91GJfa2tthyT//QlTaZ7URYuoGG3EntuoOSUuO6CMvseRNcTkgh3/
         f6GdSVccsKfcoK1J5V7IiqiHafdwfEZp+xnFSiTSFNJ4SFe1XcS+s6gCmJxiY6fjVUwZ
         ytcWjf99jYJAHKsI1iQVxKOamplt4gYlcBivBfX45lGvTAiEei/Q/huBTVQ3fFArXNL9
         bYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794422119; x=1795026919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qa+qaH6ClKIpsgydbngMJIqv5DNkTM1W2bwxY3fudAI=;
        b=aioGA/pQSgEpV7c/p9LCixLMYXRZfBNrkgavtPbY5qSG+5Ky4ARWzdGtI3pvuRDW9i
         jRnZDZnc+5knLu2w4y2xXo2NVLavVdJjLtaZ3m7J9/IN7VToSuU4C/QWvwfvA/hstEPb
         dGfhB0iOEpj2XhKvMYCxSIgo1rJWE8KPfXjusssiuHAFNkVLSLudNs/v+qtja8aEG3fo
         wFyD/6+Jhed2dCMwLZjuronSn88AlLWtVLdBGpnmTXzSssgqEyrjupSxQOWx0H7CpDN7
         mYPAYOGr0x0RJznAkU3Xi3WUupzCnGqYQpyMUZDaabpA20g+zoeov3RrT9a8xLb7+313
         okjA==
X-Forwarded-Encrypted: i=1; AL+hErHa6dUjYSRlR5K26YKqWS8D5LO2AR+rKt9ZIh31ZDFQ+W1+B8LotlvOVh18N03JwT230AU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8165V9D1UTAFWHJYyJxWVWGqwCtEjBGakE9kSX2qYSIZsEevU0
	zW9J+PDi78XXggudEAKWv6cQKgnaCT5/+j85um+rzaeXTVtKtCgWatEGTxh7U33B1OFv2FBQNui
	M8WYva/jcESEZ8sK9N/lxjIxUugWG4Mc=
X-Gm-Gg: AYBFou0x21o8CYru1ij0cmvCFafF/57tyhYQ61Q0bSV4f8YbPujF+AjfvE02O5dsFdw
	3C6gA/rhfC0KAwgznRigqfhsNfjr3JW3gGpeW5s9bbx28/8e2N85AcXQ5dyuSDzScWJIsK8lx3K
	cARQhC5yVPF2HEtpetKbrbHuvnDnv8Wc5FGCLKH9c+o7ObVFIn9FT9Tvz9AvsUl7uKnMNAqGFRB
	W9mTcVZlKg0eOuDCumyJ5t0JwWXSnllJX+czat7tPBbI1gCkXmmZd397wT7RHV2hlGLIYlkFGQ6
	UfY4nstj7zPNeGa7bN/e9fzs5Qi6c2bmxYMCOULuVbveyBhFmc8NKEjZkFjDZo1QkZ+6svNveIu
	Dd1BeyH59eEdDl/X876MmoPUfSIepKWl90nsZFlXqR3bUWnBrOszKyNuJ9kcFsGrf83Dd8wkPJX
	teRPfYuSqLnhJl85Wchb3o8W2E7LT+aFm5LM5IK7ajvzY7cgw5tdJj5jQ63694Vh2tCuvmOuOHz
	0veAoG6GZE7emgnYc0Y7hyvXJcjiogDjagmxg==
X-Received: by 2002:a05:6a00:1490:b0:89c:6036:c63 with SMTP id
 d2e1a72fcca58-8bc1c2a767bmr2992878b3a.32.1794422119272; Wed, 11 Nov 2026
 10:35:19 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com> <CAHwyqnVJ3eUQ9tkQE3rhQ8jFZjaD0tFUv41unE-NQ1WRiyfjBA@mail.gmail.com>
 <b64387b3-294e-49da-b40a-0e757956bafd@gmail.com> <xmqqcxsbnub5.fsf@gitster.g>
In-Reply-To: <xmqqcxsbnub5.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 11 Nov 2026 13:35:07 -0500
X-Gm-Features: AclHuK9KVzKc6sm21qq-78kB5ApHKQbLZ3z3jBIM8QslSkNYIDj98Fe8i8qDwgc
Message-ID: <CALnO6CCj3Jgzz4OKyRA23UPvHCtigmWg+Y9WXvKTHBa7PTV=Tw@mail.gmail.com>
Subject: Re: [PATCH v13 0/6] fetch: avoid fetching every branch of a new
 remote in a shallow repo
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Harald Nordgren <haraldnordgren@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 12:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Hi Harald
> >
> > On 11/11/2026 08:31, Harald Nordgren wrote:
> >> Hi, could I get some (hopefully final) reviews here?
> >
> > The diffstat for this series is
> >
> > 12 files changed, 593 insertions(+), 33 deletions(-)
> >
> > which will take a considerable amount of time to review properly. Yet
> > the cover letter which should explain the problem being solved, how it
> > is solved (i.e. the design and any trade-offs that entails, alternative=
s
> > that were discarded etc.) and anything notable in the implementation is=
 just
> >
> > Avoid fetching every branch of a new remote in a shallow repo.
> >
> > I've no idea from that how these patches relate to the discussion on
> > separating "which refs to fetch" from "where to store those refs" or
> > anything else. If you want people to volunteer their time to review you=
r
> > patches you need to make a effort to explain what those patches do.
>
> I would say that it is a fair comment.

Agreed. Sometimes the cover letter itself should evolve (beyond
"Changes since=E2=80=A6") as a series does.

> I understand what the first three wants to do.
>
>  1. We have had for a long time "git fetch --refmap=3Dfrom:to remote refs=
..."
>     given on the command line to decide how refs fetched are stored
>     separately from what refs are fetched.  This allows a configuration
>     to allow you to pretend that you give it all the time.
>
>  2. Preliminary refactoring of a helper that will gain second
>     callsite in the next step.
>
>  3. This allows "git fetch --refmap=3Dfrom:to remote" that does not
>     specify what to fetch (contrast it with 1. above) to default to
>     fetch refs that our local branches build on.  The net effect
>     with configured remote.<remote>.fetchRefmap is that "git fetch
>     remote" would only fetch and store selected refs from them, only
>     the ones that we "care about" (aka "build on").

I like these 3 as well, at least in terms of direction. I suspect
we're approaching diminishing returns there?

> I do not have strong opinion on the other 3 patches.  4. and 5. may
> help ergonomics by allowing to set up refmap from the command line
> option, but from my point of view it looks more like icing on the
> cake.

I think these are a reasonable idea, but I do not have time +
motivation to review them further.

> When we are working with only a subset of their branches, the first
> thing that comes to my mind is a "matching push" that does not need
> any fancy @{push} support.  Because of that, I am not interested in
> 6. very much.

As [6] was new to me, I've just given it a glance. It reminded me that
I'm not sure how an overlapping fetch + fetchRefmap configuration
behaves (I think previously we said the command line version does both
mappings). It's probably a good idea to make @{push} line up, but I'm
not sure how to manage the overlapping case.

> In any case, this topic one is keeping a topic by another author
> waiting to settle, so we have stronger incentive to see it move past
> the finish line.

I'm a bit out of sorts and don't recall what topic depends on this one
(and "git branch --remotes --contains =E2=80=A6/hn/fetch-refmap" didn't sho=
w
any); is the dependent topic waiting on --limited-fetch or just the
fetchRefmap parts? If the latter, after wrangling patch [6] we could
maybe merge those parts and give --limited-fetch time for more review?
idk.

--=20
D. Ben Knoble
