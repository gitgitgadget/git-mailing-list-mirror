Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABEB3E867C
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758865; cv=pass; b=Yk2fHoIrm22BpPZ3DrpzykHIJdC3RQEwNllD4MBUzXZR2Cg61WRr+uxPIphRdN1/w16JQ7T2pmmCy0mgZKQOgqaKd0/1tz7ywkaXesPCLzWGvXfZ+dywY7MJqtp7JZFVUrh8cHgYR6+EMIvFnNOJyKPAv9yJkHFg6MxbNNmD224=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758865; c=relaxed/simple;
	bh=TWhNr+Lx5qR4ReGKAnOWazroZf7woy+YqGyk9eQKh+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RERE++zADcH2xLFveTW53msyDmba9CuNurcmCyIE8P/UDchgds4fRaRiJLg6mPxM9W2RzRXrAHyUMh5FvnfVAh6hjP2zzyDziXyMqpE8RFMLzjQilEoqSofLIK377SIRET0uKwG07q4JxpqErcHXgLqaPqu4Zb2t82Hno8x1AEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeUiUJAV; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeUiUJAV"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50912a097b0so34301091cf.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 07:47:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773758862; cv=none;
        d=google.com; s=arc-20240605;
        b=kRbsBoKtYrr50RJgSRTMx7MBKlvQv24iLLKUvZQWptOFOumLejxt5PeQPUgwVvNqo+
         TxzHjYuX0S943+ATWlh5xu3YJCNDXSE6OEj9OiGRGU5SQfN8qwwTAwxscI1R3mCNZNqk
         pxhM6espLTh7wZ7hnAsiCIZR7jToIP8Q1SqH2rGx5RzveKo/JYdxYB7+x4LPhO6jGJ91
         DHPN6aApVcusz2yiQzh3Eti2RqbDuuFd5qjBXNq6eth537kiUJB4XBUUK9S0BXJl3l1P
         oZc5UO8VkYMMASES4FTemoB10vbEC5LcSWYADKW/edcb1YYxY7sA+YDJvbsZiIIba64+
         VLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=spD9pUJEXhvjYVl75rEk4LuVVZG6XV19g4rVwFguFK8=;
        fh=70oNiejRY6ihB+RiiHBmrx0yF1R1IZdsfpzpOmYDq5Y=;
        b=bzPRGdmcEHSYEr0bgJ1ScZc7+lrWgFv6y0CC8OkhL1P95Bbh/+CtGIyOfrEjuZV68Z
         dzxn9tI2wLmDBn/v48epq3+azUl3OFs1UHvjgfmpe4q61UmTQX2HkhdYGb89dcWPys6p
         lLZpKf+sximvy4S0oWexvWB4SNRmc7kFe7E/48PZL748YWfh5ruvS+pDyc+OVOXw5lyZ
         k+0Si/aMJLRUmTtRpHrA8zqtDGDEpwDDvrWmo7eXVVPi0LT2fAe5EIDIHqWHUm/l87Ue
         M10RYGiFkdgh8+AEQWFLtk5TaxFG3+qeI/NwqLBSSbmNOJWHjPTvyzS0hYr9zXyc84oF
         pbQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773758862; x=1774363662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=spD9pUJEXhvjYVl75rEk4LuVVZG6XV19g4rVwFguFK8=;
        b=CeUiUJAV6J39iKnuWHih72CLmkmbRX8pYo082Foyd2Yf2rzgERgINF9Xk/mFBQRbE3
         OMIP5hYn0NPEt01742JzbPSCNIUN2fp5XNwKndaq0VBwy7gvzRr58pUL6MMpDyURhaNH
         aC1tXGnGcTBUkTL/qy66qjTcbjW4a9/I/a7QRbcnC5yp95I2+ht3Rf6kcS/BsNz0rLK3
         QcohPrsRyoCfoXpP+ZFKFgOSeoPIZDS8df3fgW4n/FL4FgD3Jy3/e4FuYzzkF0wZdOQe
         k6m/oV85BHs8vfWMxxYR45Lma4Tlb5Ee6w8qXnQ45iT9sbDEbs0XBm9FZHtq8VXJQp1/
         AFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773758862; x=1774363662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spD9pUJEXhvjYVl75rEk4LuVVZG6XV19g4rVwFguFK8=;
        b=WW1Zbf0zY0/KMKT1oH+UmO/rLtmQbL7vDXHHePWwoxkWymphtmoG5A4yPlOTRLM2GQ
         b9c8FVAHkAhnZNRn8QDC4WFXRRFja45Iw7+hXPrlstStos9qGtPQh+t7VAAeGoSKKgep
         1DHJ8efkmTlZwnY3S6qPPNujycCdEBqs+uq/mOvIebA6N3ruMNW566h9Rp/Jm/kQtnEZ
         rdvf0N0omQNQVgy5enAfP243LfeRm7cZfeMvttY6iVTbW3Oge1hu0JjW7V8JfVw4cED7
         oyGIJaEvpJ+r0JtrCj4ynAsJMajnRfHt/fIskvSiSw59DF/TuAGptec3SfWi5+hZ0TEO
         CvoQ==
X-Gm-Message-State: AOJu0YweSENonS0pkgQkiZFOhDbPnSpt/hjgcBeChObFKFVus7EJ5N2q
	XLp8YFHYUjWiHFJngn0gAIrqgL1Ct28IH66r5Ui5N6jQjJsBH+w2Sv+BELOyCwKeCCHxX/leJKd
	QoW7Kb1JWpOQjjPe+kq/RIC/++FDey1/L9+Olg4M=
X-Gm-Gg: ATEYQzy9RSpgZMb7j+A4O4R+aaNULg7ochzI68NbUWaD7IFZEJFEa8KyM2+Q58O+FJy
	duxh8tLBykQeteRdxk2feFfwglPymRDDqHhDj7c6ycBTLkGaFCkFKSRxG+tcFU+e9EMzmDbgXv5
	YJ+Si0V9aZDdiWKJi5vbpqAkecTvvcWm76ccA3l5mdJTJbAtlU4iAe3FlGNr1vOQ3EPCq3YKUYN
	M/lhMkcwSBEGWhngq3abNBQg7Pi/j2ci0SJQu4n/o+MRMfL9WdBEC5vgnoRW6rnv/gHONuW9xII
	E5W5uU2mcE3gWytnL9jo0d6GovtpUfgRIGR9gDZVI+sEip9z0F/lnf10rWQt8RwwnbZ2sY4w4re
	N0XOBqztHJqSGgNidlUzA1NhUBQ==
X-Received: by 2002:a05:622a:1194:b0:501:51fb:622c with SMTP id
 d75a77b69052e-50957e00cf5mr221765991cf.37.1773758861622; Tue, 17 Mar 2026
 07:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLd-1Mb5JG1H1PvE-kyjdznrLVFjwQiMLHtd2ETQ-igmXg@mail.gmail.com>
 <CAOLa=ZS6HtJrWd0kfsFASCbP2S9-MQq5Da3feA0WqY8ykZ0WTw@mail.gmail.com>
In-Reply-To: <CAOLa=ZS6HtJrWd0kfsFASCbP2S9-MQq5Da3feA0WqY8ykZ0WTw@mail.gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 17 Mar 2026 20:17:29 +0530
X-Gm-Features: AaiRm50VEerE3-k7el5hY0dU47XVHuo0sss9DdhxgK0h0q3VUQZ1ei9459aJ_4g
Message-ID: <CA+rGoLe70x2Ns5e8qHm3n-yvNxQbAc1b=Mqm31GDsMCOfJjNFw@mail.gmail.com>
Subject: Re: [GSoC][PROPOSAL] Improve the new git repo command
To: Karthik Nayak <karthik.188@gmail.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hey Karthik,

Thank you for taking time to go through the proposal.


> > * *Implementation:* I will implement an internal mapping
> >   structure so that calling `git repo info path`
> >   successfully identifies the category root and iterates
> >   through all keys starting with `path.*`, returning them
> >   dynamically.
> >
>
> This would definitely be nice to have. Have you also thought about glob
> pattern matching too? That way a user could do
>
>   $ git repo info "path*"
>
> And have it list all keys which start with path. Similar to how you plan
> to do category matching, but this can also do
>
>   $ git repo info "*object*"
>
> So any keys with object in it would match too. Either ways I'm just
> thinking out loud and not saying this is what you _should_ do.
>

I hadn't thought about globbing till now
but I have now given it a thought, I personally believe we don't need
globs (at least not now)

There are hardly 4 elements in the array `repo_info_field` as of now
even if we add all the paths I think it will not go beyond 20 elements.
And I think globbing is a problem we would have to debate after we get
to >= 30 elements,
globbing has its advantages, it gets insanely flexible but I don't
believe it is a current problem.
I could however add an RFC in the community bonding period.


> >   and explicitly evaluate the passed
> >   `struct repository *repo` pointer.
> >   I will thread this context down the call chain without
> >   breaking existing external callers.
> >
>
> It would be nice to collate some of the efforts already made in this
> direction, I know its not as simple [1] as passing in the repo since
> `is_bare_repository()` has a lot of callees.
>

After posting this proposal
I was tweaking around and found out repo->worktree
It holding a `NULL` value is directly supposed to indicate it is
`bare` if I am correct?

I maybe wrong here
But writing up a quick change where

static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
{
strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
return 0;
}

becomes

static int get_layout_bare(struct repository *repo, struct strbuf *buf)
{
strbuf_addstr(buf, (repo->worktree == NULL) ? "true" : "false");
return 0;
}

and removing the macro
#define USE_THE_REPOSITORY_VARIABLE

would work is what I have dug so far
I would of course not send a patch until GSoC starts
But I wanted to know if I am thinking in the right direction here?


> > * `path.git-dir`, `path.common-dir`, `path.worktree`.
> > * `path.objects`, `path.hooks`, `path.index`, and `path.grafts`.
> >
>
> This is the crux, but you should also probably involve some of the newer
> discussions around this. I added some pointers to Mansi's proposal, and
> perhaps that's something you should look into too. [2]
>

That's a great point
I will update this.

> > *Objective 4: Sparse Topology & Boundary Awareness* +
> > Modern Git workflows rely heavily on partial checkouts
> > and submodules, and `repo info` should report these
> > complex states natively.
> > * *Implementation:* I will implement `layout.is-sparse`
> >   to expose if the repository uses a sparse-checkout
> >   cone, and `path.superproject-working-tree` to instantly
> >   query if the current repository is a submodule.
> >
>
> Those may be good additions.
>
> > == 4. PROJECT TIMELINE
> >
> > === 4.1 Community Bonding Period (May 1 - May 24)
> >
> > * Attend the Git community GSoC sessions to introduce
> >   myself and establish a communication schedule.


> >   resolution works correctly across POSIX and Windows
> >   environments.
>
> I think this will take way more time than the two weeks allocated here,
> mostly because of the design decisions we need finalize on.
>

I agree,
I have actually changed a lot of my existing proposal
I had a very hard time picking which project to leave out of scope
since I like all the projects equally
But I did double the allocated time in my existing proposal,
I gave 4 weeks for paths and libification (Given that my above trail
of thinking is correct it is just a small change i.e repo->worktree)
I also gave 4 weeks for querying the prefixes

Gave a 3 weeks of buffer for path and libification and 2 weeks of
buffer for query.


> > *Weeks 10 - 12 (July 27 - August 16):*
> > * Implement the advanced topology and boundary keys
> >   (`layout.is-sparse` and `path.superproject-working-tree`).
> > * Run the full test suite and perform rigorous edge-case
> >   testing ensuring libification does not cause
> >   regressions.
> > * Buffer period for addressing mailing list feedback
> >   regarding the libification and sparse patches.
> >
>
> Overall I think this is trying to do many things in a short time frame.
> I would also consider the time it takes for reviews and iterations to
> land.
>



I just wanted to say that the proposal I posted is in a new thread
I understand making it inline is nice
But since a lot has changed
I thought of adding it in a new thread to justify it [1]


Regards,
- Jayatheerth

1 - https://lore.kernel.org/git/CA+rGoLd4ho5AmB3gWYP=yUUKJO=YqthxKX8R_rvN7V7exArn6Q@mail.gmail.com/T/#u
