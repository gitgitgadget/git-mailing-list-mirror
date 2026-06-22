Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374F3911CF
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116991; cv=pass; b=GTBxU/Y8WmPfQCuEatVyVBBRt0se/GAyqGp2EJnSD0q9lyP0tUbErl4kgWDyUDRAOWlH02V1cSch94yE0qijkLuUXraRfZFlsIAVXmXY9IRoINTQ5JyAGFku5Ce64uZ4s9pX9gHbcWqPqy6rGFi7mZdZS4Im7SoRpmibLf28zUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116991; c=relaxed/simple;
	bh=4/gB/TB8AjHU8JUD8W3NNjmnBj5AJ+RVDsjPqt5yhFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPUMj1zOdFGqHwHs9y9Xb3TSw28qrvvj870aEvj3xTGJK2W6/2CNC+83dVojXqHT9T8skKN9fnsSLal5ylSGdxTfoiIF5lvpRK61whlLwjyJMGuUNj7lclXu5sajyBNPcu4nXwu1fY+zGhpYl+1XvC4hNd4Fu+ShVFnaefjEECo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=DqMRITGv; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="DqMRITGv"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66077e90382so3986554d50.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 01:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782116984; cv=none;
        d=google.com; s=arc-20240605;
        b=M/0r5eS4W/UMV8eH42neDz0VYsyREa4qQQQcHdWsB5TmaTMQ+9A1o1B62e12wfajoS
         Y+eRZ8f0ER6+rPvqLTUE3+MPkv88riggUfqTMDNKkJT5Q7lg87qhCBfr0FQp37t7D9Of
         BYshQ5gREOBr0yDuDUF7jH7Qvum7X9ufG06DwFk7tqdAwYpI0nEm9dHnfgkMSZ+xu6Dq
         ftOteWIqU2YWXadpZm8OSmaAHqbiZomu8A6i1JnY940HjUk3Odx++zOXTcJe03B/JXqz
         iQdACKsrUcXNlGStSM+9hqsWr7PFDBS2nAGxgIaYiVeofSkCn1kTH5vM9+adGjBOxImU
         Lq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4/gB/TB8AjHU8JUD8W3NNjmnBj5AJ+RVDsjPqt5yhFA=;
        fh=9NCx9QqTi7VQrpGmPkkJ42irSw3F3SAZHMwjnlROCRk=;
        b=VxACnnbgstiE67Q6UWQTX5ae1QJyX7UzGs8DdS3YAn0v6vxmfVUWPkPCwrZAvpDkLn
         HTfiHHDg0Mdj6p8P02zuaANjgP2a+d+JRP+Su48aep6beUFwU+1tEBbOcBPmA57/MJEt
         N5Sm9Ilz8Dfcal+CNzRZtiBb5Gt9Xl6Xc5RaN1GVH3MkCFyfP3UsEq6JuHQAxNhRIQxW
         Uv82/fQYwKVgtIsEhGjxmLGB/a3suVy6ZZazSAUzNhJbNxsodCN8sE/1/G5PUwvYKMD2
         AT39lZg7ETfXI3PqhvcSKRBmpft7pQC7okmjMMrd9hIZ3xT1X8yGB8C7K42z5iyjKuUd
         j7Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782116984; x=1782721784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4/gB/TB8AjHU8JUD8W3NNjmnBj5AJ+RVDsjPqt5yhFA=;
        b=DqMRITGvffIt2aly5p2hQiE4V/YFwp2f9hyGOBBz1oK4j2rjgQAtbvjJC5ogycYMN/
         D3PQihwU+pqEKKe3KlDbp1Ly2GRH7dK616FbjM9de2MlJCpp1MNwIfQK5V7CtvtbUvFj
         D7/OOcrT8Jn6zmZewc2il/PvOV7we/K/727Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782116984; x=1782721784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/gB/TB8AjHU8JUD8W3NNjmnBj5AJ+RVDsjPqt5yhFA=;
        b=oQ+NshGUcpBpn88Nn1GR9Ew6rMN73Ybibibe8Z3J4xdn9t8oAYi4l18ZDLgZjwboPd
         CSD8s0eo2FldGLPAH0aXXKVphpk8OLLFESdhA9dGD//oPtc590vJ/M4qX6VTVrUlsADz
         xfioyxo0PMjeMbwzRITqOC+qpkxcuf607JsD9PvrnNyqH4ajV686FYlPcWWcVl1242jT
         d/+QaSPAtvyyRlwg9JIod13A/jqLVBD8EVvC96Dld7vDPvlKBOsVwisVvlv4gTezPEho
         PtY2JTs0UniTGPd1jIzoz6HqI/HJN0QyjPftZrZJtV2r9x9lVcPRkRwpkaV8PbKRSd5I
         112Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp0L+YcW6R711OFhQZOrbDffKaJD6BxJHrMKga/2Y0UAj8xb6zdNwxkYZJW7Z5/Y6a8j+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrmEiW1FqhMmv0tteH4TFOU4OAHfsaHGUYyzSvfp+r2mNIBPD
	TeZfN0B2NlBLN7pLaFTZUpjZo4MJRn54EQdowYN3WT8LqRAoR+43DJuzGj0Pv6SzBQngg4ArFZF
	coKsoQZvlpBmrO0A3wyrZoOffPaThMa1xqGKXXJckmA==
X-Gm-Gg: AfdE7cnmws9t40E49iy6cO+r9OnGqWMcu3hKDjpf+juGoCpYZNkvIEwPuOEEMJTvEwL
	kTi9TavxL0klfWYV7oFRwEUQG2Em5xmog+Xo79Z5Wdjb54+WBCusRXWZ9duPnMpF4Sa/JNsq4JO
	wOrDUWlOIZtGxg4nKMFs21IXMu6p/ElKeH4efsxGP7rux/o3XTkIMWGUlJZJfUOZucmfqjqsNDx
	RW7JeVejRrO/fkRtgya590bGw+5nqgyZLavFxiF9FIZBANIr+np/iBwTr9psR4MOvTJ7fVvuA==
X-Received: by 2002:a53:ac8b:0:b0:660:e9e9:f75e with SMTP id
 956f58d0204a3-66312d72074mr8568527d50.9.1782116983915; Mon, 22 Jun 2026
 01:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
 <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
 <20260617202744.GA3465855@coredump.intra.peff.net> <CAN5EUNSQY2oK7BE4J9Y8APfkP6eJxta050OUu=RoJYhXOjX_OA@mail.gmail.com>
 <20260618160504.GA818042@coredump.intra.peff.net> <CAL71e4MAtD4MqE-22UyYaNFVYcFgYmffngihhovEChVfHLmEdA@mail.gmail.com>
 <20260621180556.GD2206349@coredump.intra.peff.net>
In-Reply-To: <20260621180556.GD2206349@coredump.intra.peff.net>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 22 Jun 2026 10:29:33 +0200
X-Gm-Features: AVVi8Cd3ziC0upJ5SUh96JGnovq8mnWZm2cy-qElKAK22NvK2S4vO96p7UGnxOc
Message-ID: <CAL71e4NCV5uPJ-LsEQmy2R3gAjF8C60E=YL24tTABaxs+QBSXA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
To: Jeff King <peff@peff.net>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org, ayu.chandekar@gmail.com, 
	chandrapratap3519@gmail.com, christian.couder@gmail.com, gitster@pobox.com, 
	jltobler@gmail.com, karthik.188@gmail.com, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Jun 2026 at 20:05, Jeff King <peff@peff.net> wrote:
> Looks like that happens via rewrite_parents(), which always writes into
> commit_queue. I guess it doesn't matter because in topo mode we are
> always pulling off of the topo_walk_info queue anyway? It does make me
> wonder if there is a lurking bug around history simplification and
> --topo-order, though.

Thanks for the analysis. You are right that rewrite_one() leaks
parents into commit_queue that are never consumed in topo mode.
I have not explored the graph code very much, so I cannot say
how this affects the lookahead.

I am thinking that revs->commits is somewhat multi-purpose
-- it serves as initial tips, work queue, topo sort buffer,
boundary staging, and reverse output buffer depending on mode
and phase. Now that we have two representations (commits and
commit_queue) it is both multi-purpose and unclear which one to
use. That is not a great situation.

I originally just set out to optimize the prio queue usage
and speed up expensive walks, but I think I also need to be a good
citizen and help clean up some of the mess that comes with having two
separate containers (I am not sure exactly how yet - maybe even
adding _more containers but with more semantically clear purpose).

> > As for the multi-element peek question, I think I would either opt
> > for draining into a buffer if it's really needed, though when looking
> > at the code here I think multi-element peeking is not truly needed.
> > It seems like the logic just checks if there is at least another
> > element after the peek, but it does not try to read the actual value,
> > so we can just check the queue size instead.
>
> We do look at some characteristics of the commit we find by peeking, but
> I'm not sure how much it matters if we get the _next_ commit that will
> be shown, or if any arbitrary commit is OK.

I am not sure if arbitrary order is valid - I think simply having an
intermediate buffer where the filtering has been applied would be sufficient.
I think the peeking approach is wrong - peeking into the second element
doesn't work since after processing the first element the second element
could have changed. I prototyped something locally that uses
a lookahead buffer instead and it seems to work and then we don't need
to manually filter on get_commit_action - get_revision_internal will
apply the right filtering. Will reply with that finding in the right place
though.

Thanks,
Kristofer
