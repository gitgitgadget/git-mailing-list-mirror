Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05889373BF3
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436644; cv=pass; b=Z+sSBKl1r13/A0ujllMZUzutcwBsoyEZv3G8pj0kA7Fk+S+6hznZ6Kg00yn9w126RkX6TSEoZj5kJGEM+RQBGX/IiI3650IxuA51fUOmzSwqRI7u7D/oPDZ+u9/1R3zeDyIcOSwTwZ270XemjioCo4qTQtnZotsxUtoEr54LjIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436644; c=relaxed/simple;
	bh=mRKPnxscwNz7uEIP60p2P2mFvC6nahohu3xjXa+Ug24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qhtbx5JLwpHZdk+s8x6M/N6yMP3jzrUjG3cQUaD+IojCc6EUbc9FhYbt5CYY9JjTwVZgCcExE/SzPNIzogt8l55eXpGKGDwgPWwDm0j/M8dLgpve57jKOFtds26tbPb+gprDG3ERkK50rlk6M6O1PELTEYQ0xIw1GiJdTDPeE7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=epCqAJLB; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="epCqAJLB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cad8076b01so53875665ad.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 08:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783436642; cv=none;
        d=google.com; s=arc-20260327;
        b=dvEUH+h/4jGMdPyYuNkkMr9rX/ruMcG70i6agnbKjWLk7meILTff7tJZDQ4yGb6kI/
         BunqxDY9ATxC9JTLqsUjSST1TzCZs6Kb+aEDshzAIV4yrziVTcE3scvpANYQN1y6kFJI
         9os7WW/1aydllegf8KuhTvYQvMjeo3eaN42uNY85BSGm5ufULygqCvPI2ehpANSWerRd
         r+xB/6JggnQGWU289W72sPM2FbSO7qp+fS7WKAQmW/rYwDTssal5TPGLFRqT81cIfxN/
         Vc4uFajFoitxNSNw/jUVY9yv4ffry/UQDQe9AHdHrz/rU/XhHpu2zxukMdSfKH7XN9z5
         kcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8jGIA4LeZ6/Sh4qbdDJbZFjvXDCYwBjP6A34P/oQexA=;
        fh=dsGF57VkC56Lx6IrXG8LC15R93nyzaXlc4RLdtc5S7c=;
        b=QWwQB1y+mKgZEOSUp+roGPhqzU3fABd3iJG5+5Fgk/4sr/4BQ+1ClToBcfoWKlpqjn
         zDKp/c2Q+CG9KE2DYpLAkOLbnKKDAdlzEn5d+pvdw9l3WF0+PqxMevHz+I/x2mJ1IU/j
         oUSCf4YB0D1W/ao4XuWrWyUwYsQ2C/jOt2RXJkYsds3uDj+nLJVqW8wpZdGaFp8kHMiD
         oJrLsH7rB4dRWkeFLrvvOdT+fcLVRj3zJjiE1oWk+XfCavDoUKYkYHsQGcfS3SfqNpu9
         lOBCsnv3DcXuP7yuSG//mip85yD0KsFe8VgMwqQwEn99C6leBddnxXaoOXLmJBn/551S
         2F5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783436642; x=1784041442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8jGIA4LeZ6/Sh4qbdDJbZFjvXDCYwBjP6A34P/oQexA=;
        b=epCqAJLBc250Nd+8bN+i66ZBfPP3t98Z1MUZWC23fL3O8ONyKRjGz2lmVWE9ietdeh
         Gl0vU02XyK7SnvahfJiCxv8F5RlL83Oy0u9RxhWT0YRaOIYonN+SOpe67eb1kL0YsQZB
         Wz0MRirHC2SMqP1heSjMBamCA+OBD7Xe3yS1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436642; x=1784041442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jGIA4LeZ6/Sh4qbdDJbZFjvXDCYwBjP6A34P/oQexA=;
        b=pH+9BwExGE9KYbYDxRU/l4cEjuwwK7QBqBzRp1to0/uPspTgptC7OAAUCcXruF6GnY
         hfZ0++5YQuiGlstiTUq87J0AitsaDs0Xzp28GrNXggToeaWDgg/MoCNooOycpy1wsbmD
         AVFoahdWv+nzFLOKWhOR/D/kDp55p7uyPUfTsxnd+DeHXGAAwCpEd6SRC5tZMdbJPzfi
         ubwE18/RR0SVhkrYFtmVSnNWYTMimnrevK/SGCVr2ub+gsajP57zUhmqSiKiQGenyY61
         pFJrVxhc8uH9bzCb3DXQvyYHWJS2QwHW5tkmdWEMTGyX7FBz+xOj5wkn8eE/JcdVebFc
         1M3w==
X-Forwarded-Encrypted: i=1; AHgh+Rq7cnhGVUTUu6JZNhSESWfuGGxbuj8lHiMFBACkDTHERp3GZAbkBxdpM19f5nXMTVlZvbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9e9Ee4yMkmQo6OJKExyh1JJD4awaKO3wsGX0XzZKZx7SEzhxz
	iytFe4An8Qw8CiH2msGPp2Ggje5PioTP+rpmtfHNIyZrNnWaUyik8MKWD9tpz9fQTsZG8shqqCc
	tYEpSM6rWUb5iElqyo4GtLreQ8xQtKvX2Y2I30UgPLSPh40CV75Wh/jcSag==
X-Gm-Gg: AfdE7ck2Rd6G9UHB3KZ+vLUOHiR1JHps7GAhSp7GkNxa7HJh0FxQ3lXJ+wHMWoqbi8V
	BZdOm32rIV4Rav7vZy8rOXVf4Yt9wZQ9Lrn0Cvln6DnpkFkRi05/ghKCMdghSmOQD0DmBLt9EL6
	PblHfY9PEGVFQnBwg9yXtQWG2AUqueZUPylZ8gsZqO288diCl5OrSrYksfzeiByjZ3T8qjafHOx
	qvVKo5Y4QgJ8w7z53ks1mn0S7Qa4/j86GmaXxn2quEDAHNHwPchgHJjbpyQ+Hml331nBu7Cew==
X-Received: by 2002:a05:690e:1189:b0:667:9481:5b38 with SMTP id
 956f58d0204a3-66794816746mr870640d50.41.1783436245071; Tue, 07 Jul 2026
 07:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>
 <ak0D44nhSH/98WYD@nand.local>
In-Reply-To: <ak0D44nhSH/98WYD@nand.local>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 7 Jul 2026 16:57:13 +0200
X-Gm-Features: AVVi8Ce0bhcXbCOUdJ6yxrVgVR4zOYtGtRBCQRqlORieXBX0c0z1_fbCRpvO0Ds
Message-ID: <CAL71e4OuU1+KHd0TrcxDX2dyoWEJXmi86m8u+E7vtxhcSF6M1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] commit-graph: propagate topo_levels slab to all chain layers
To: Taylor Blau <me@ttaylorr.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 15:49, Taylor Blau <me@ttaylorr.com> wrote:
>
> I think that there is a more permanent fix, though, which would have not
> allowed this bug to evade both its author, and reviewer (me). I *think*
> that we may clear up some scoping issues if we removed g->topo_levels
> entirely, and instead stored it in the write_commit_graph_ctx struct.
>
> I haven't thought through the implications of doing so completely, so
> it's entirely possible that this idea is bunk for some other reason. But
> it was the first thing that came to mind, and so feels worth exploring
> to see if it might have prevented something like this from ever
> happening in the first place.
>

I looked into the structural change you suggested and I think
it's doable, though not quite as simple as just moving
it into ctx (since fill_commit_graph_info() doesn't have ctx).

I found three approaches:

(a) Thread topo_levels through the call chain. This would
affect:
- fill_commit_graph_info()
- fill_commit_in_graph()
- parse_commit_in_graph_one()
- parse_commit_in_graph()
- load_commit_graph_info()
- lookup_commit_in_graph().

This is the most direct approach, but it touches many functions
and some callers would need to pass in NULL which makes it a bit
noisy.

(b) Move topo_levels to struct object_database. Since
fill_commit_graph_info() can already reach the odb via
g->odb_source->odb, no signature changes are needed.
The write side becomes a single assignment:

    ctx.r->objects->topo_levels = &topo_levels;

and cleanup becomes:

    ctx.r->objects->topo_levels = NULL;

No chain walk needed and the diff is fairly small.
I am not sure about the semantics of it though -- should the odb
have a reference to topo_levels?

(c) Introduce a struct for the chain as a whole, separating it from
the per-layer struct commit_graph. Right now struct commit_graph
represents a single layer but also serves as the chain head, so
chain-wide state like topo_levels gets duplicated on every layer
(only logically -- the actual overhead is still small).
A dedicated chain struct could own topo_levels and the linked list
of layers. IMO this is the cleanest model but a larger refactoring.

I have a prototype of (b) that compiles and passes the test suite.

For now though, I think the minimal bugfix is the right thing to do.

Thanks,
Kristofer
