Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A54F7979
	for <git@vger.kernel.org>; Tue, 19 May 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187218; cv=pass; b=NQrDvOhahghmV0BLM7b5uZXqtfUH7Yqy1hzzhMo8OS1WagztXcgynrzhawns7VrrXCsa1QHtTFBRy8sjb/b9yFVxDX4zEY+G3gWsRLoqBULgA5KVuqB67FwLoArI0MFa1ys6D3uL29L6feRFrnOdyiiU5VjoPH6Jj1BNTIY+HBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187218; c=relaxed/simple;
	bh=WNoUi5cOn6d/kaw+yMBbrIDgAtU9jfF2PZ+YCsIfZ/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4GIOp3i30XvXP12wU5ZcLuNRPapNj9E0wmepwbC1yoHfDJp/nOSIVKzPMvypCTSY+aylUOMWK8treCRLxCkaPh8jiKSFZg1zH9pzuv29/GlJzqWc0fa3Z4axRYpqEpcFGGsUwKqdZzvNbs/VM886WVsDhqJTF9aUG3935MFOac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBNNZPDX; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBNNZPDX"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd85ebb368fso404808266b.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 03:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779187214; cv=none;
        d=google.com; s=arc-20240605;
        b=QWdqOQpT3j1XzOWlZUukobS32o2bLinwlp+gVpS23cnExgbpR4K2G9+XwI+OSfO1AK
         PHmLiwrgwIt9gyg/nZrkrYzAXmuMO2PVTMhS8mfH2MjHqlVrfp38EctGf7nOn8naMNaf
         TcB2YknD5iDbuicLVbe4qRfypbSTnRYQ/2FqAmwNQERxiP1XT0iF+m5PXmojR2Hfa9Kl
         KQk1Po6R62+rEKJ9Gt3XiMlnWWfDWQR1RihjBQt5GuUpZ03JaGoAcXGh6A5IZCm4iXfK
         9S59U1M9DABZ7yIcE7z9d87nwqS/djT9zqMygt5/30vUe9fQA/JeIHBVtM4ODZrzI9gq
         05Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b3luwvPK0ihrPCYm5/uGwtUAFyk8LvhjpURvotXpMxY=;
        fh=AJjigEql8Rz359Pzq9mkbQ6Jf2MFtkhRF3z8rc5av8A=;
        b=LFR5dS1fEb0M9cHGcDMKThg2xj+7Qgzs2d7zXACKRrxp+nJ397SXGP+lYywklQpieM
         5oA3u+BTcH3aOp9x19bcNWL0dDENMaWb8aN1NOK8KOep4rp1s5gOLs11uU0tnJqB93pk
         ihfbrVgD6Pv8+r1IgFrLN7WytLSVygkbExBdVXdZ4hXoVT1WnokJgR/hKPT0wFEjhckM
         od1Cqpj4sYSxVZu0jAHl+lRWnt22AkDAz6INrOQLFa/4AI2fT0ZZqDGwXfy2VP4kBhUI
         rA33qgwAtaMrVXQFznPbBUZ+15gpYXaMwgo+56gMRXc9TqlqOmCSiyVj1FqqUCya/khF
         4EJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779187214; x=1779792014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b3luwvPK0ihrPCYm5/uGwtUAFyk8LvhjpURvotXpMxY=;
        b=DBNNZPDXdcuazmmGwBBtiO93tGRM1MUwAIILC4n28qq0a+xu1a/4Ukpr+s5INcKTFM
         8K0FI4YpXUpE4T8diImPnDjfVMig2cyRYqMm0dkn4MgJeWP6vX36X6CBfVO345/U4SXN
         +wQH9uE5+6aO51oIa4B7ttOgj03BYfzW1hUL8wB2ejd4gN0n6ikwCJ6Soj5IO/5sFkeA
         YT4crdwr4fsG1BY1sOPBIFyzTgaLDn3AMaXMB1/xy3qcwqSKui3UoJFdUWyGgJAMpQ4Z
         v6o7NeK6d6ykU7++qOLPNQGI2DXwOcrAF1rypvEak344BSm7Rdd7+h8c7aDnBIGf46i6
         WQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779187214; x=1779792014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3luwvPK0ihrPCYm5/uGwtUAFyk8LvhjpURvotXpMxY=;
        b=ghadd4zaSrRNXBvPluITOzKq1NcCtLV9Q7GOshk/QASYbBH+qSCkCLBZ0p57hftUdu
         fUT2LFMqbPW1ef95zIseIGKBmARWSPagox8WS3W62qld8uSz+2B1101V+ossRaMZw/BK
         xUqQy7n5RLvQYClMO4joJly3LeaGIUSni0n6NRBdCWiMlGqQ80oSMyPMmclESC3lo+DI
         SaAW13JBJ23+SNcnfCd0TQ0J3tG4MoYx2pzSdSC7hXYgPJbI/2UU5dlY6GKKzhxRDBRN
         E9xZ5c/bm8Y9sMFTXo8pGLkboq2KFax5Qu/E/KhZd6SCtCl4djonrvhVILJd98HbhE9O
         3kBg==
X-Forwarded-Encrypted: i=1; AFNElJ+9wKxba+0c81wydfVtMEVqYuA4BAZLj94OFp+8YGW58zmP9dQ8Ql8i8dAATEugWTxK9Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXn30Jl/xyq0WN77b1XGXd8uDjj3KUrroKOUbjrJGp16+leRE
	MNz9vn3HQ4bSxePFFw5PHpTCX5W0MbBvFmqzGutKgZ6G77vve+nxCl/H5MAcTdq+jkV7HT5/4ML
	UyZAzrP4t5zmMaBW36KiFoIS09kVeZuQ=
X-Gm-Gg: Acq92OESRjtzqF2ayPmH01fntGI9gKs/1ZtXXhHixNGnpVILZhE0RmTmHQmLLKYNWzP
	KAVlxIhwzbkwLKvJFvzBpgXRbLghPM1qeuSUILf3uNHN5BOy28lFVgQgfbH/nJbBIwfKMHM0nKN
	RuLc5gMh/5O/Ty5cL7W2hf17HmcOvhEHOe1np7PhqtzbhNkZ2ZxdIDz7eYlyhG8zhnG/HqQXJCV
	gHQMiVb6CgqT/daEbAASuLBh+y6+KUae73/6YW3gdzd3MnlROUxusIxqqF10P1AePJXtP3JzCoA
	40Qn3kdPGa4AR0qOohRbepQ0e4j3IRIiq2FtK7LiZpe0OkdHXvIuYmQAq5eZBoHO1X+UJPZOdJv
	YeQGel1nwiQk8/qJFgbmwKg5MiizbSq5K
X-Received: by 2002:a17:907:2d13:b0:bd5:2c3c:616a with SMTP id
 a640c23a62f3a-bd52c3c6261mr766061966b.37.1779187214173; Tue, 19 May 2026
 03:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
 <26d887d2-6ec2-4af1-b0bd-8e9b017bb4dd@gmail.com> <CAN5EUNQCsKD0CJqDi43i2JVBQQChAZVt_THQ1wGpdeydNHHCFw@mail.gmail.com>
 <2e8b9b1b-6a69-4e94-95ea-7f587435bfce@gmail.com> <CA+J6zkTGgeNuH0eusTy+t8LO3bjygSz4svJB=K4R5ASmBdd0uQ@mail.gmail.com>
 <CAN5EUNQoKRqt3FGLmzRGpPU1nO5jCAogP8Wm9gBZXuPbMNbQAw@mail.gmail.com>
In-Reply-To: <CAN5EUNQoKRqt3FGLmzRGpPU1nO5jCAogP8Wm9gBZXuPbMNbQAw@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 19 May 2026 16:09:46 +0530
X-Gm-Features: AVHnY4KZHJoJkerW2QLwDYoUYNSgL54el2uU_3ilO9fo1OmAGOk02FRmNpIXVyI
Message-ID: <CA+J6zkSj+Bfa70h-wW8JRcWtUbFiYJyrdpdLJZ16fY7u7gwECg@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 0/1] graph: add indentation for commits preceded
 by a root
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, gitster@pobox.com, 
	christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 May 2026 at 18:57, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> Hi Chandra, Phillip,
>
> > > >
> > > > I have mixed feelings about which approach to choose.
> > > > The idea of a blank line was thought at
> > > > https://lore.kernel.org/git/xmqq8s8vvw9m.fsf@gitster.c.googlers.com/
> > > > but Junio argued against it for having an extra row because the
> > > > indentation he proposed didn't collapse, however I find indentation +
> > > > no collapse the most confusing one.
> > > > I'd say that I'm fine with both approaches, blank line or indentation
> > > > + collapse.
> > >
> > > I'm afraid I don't understand this - what does it mean for the
> > > indentation to collapse, or not collapse.
>
> Collapsing would be when branches move to the left, eg:
>
>   *
>   |\     <- merge
>   | *
>   |/     <- collapse
>   *
> > > Looking at the examples Junio
> > > gave they look quite nice to me, though I'd find it clearer if
> > >
> > >
> > >   | | *  12345678 2021-01-14 merge xxxxx@xxxx into the history
> > >   | | |\
> > >   | | | \
> > >   | | *  \  23456789 2021-01-12 merge citest into the main history
> > >   | | |\  * 5505e019c2 2014-07-09 initial xxxxxx@xxxx
> > >   | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest)
> > > Added defau
> > >   | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from
> > > f7daf088)
> > >
> > > was rendered as
> > >
> > >
> > >   | | *  12345678 2021-01-14 merge xxxxx@xxxx into the history
> > >   | | |\
> > >   | | | *  5505e019c2 2014-07-09 initial xxxxxx@xxxx
> > >   | | *    23456789 2021-01-12 merge citest into the main history
> > >   | | |\
> > >   | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest)
> > > Added defau
> > >   | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from
> > > f7daf088)
> >
> > It probably *does* look clearer here, but I have the same reservations
> > against this as Junio: the break won't be as noticeable when --graph is
> > *not* used with --oneline.
> >
> > > >>> without the patch:
> > > >>>
> > > >>>     * A root
> > > >>>     * B root
> > > >>>     * C root
> > > >>>     * D1 child
> > > >>>     * D root
> > > >>>
> > > >>> with the patch, the indentation cascades:
> > > >>>
> > > >>>     * A root
> > > >>>       * B root
> > > >>>         * C root
> > > >>>           * D1 child
> > > >>>        _ /
> > > >>>       /
> > > >>>      /
> > > >>>     * D root
> > > >
> > > >    * A root
> > > >
> > > >    * B root
> > > >
> > > >    * C root
> > > >
> > > >    * D1 child
> > > >
> > > >    * D root
> > > >
> > > > Here I think a blank line looks worse, too much space for just 5
> > > > commits and becomes one extra line which if this were like up to 7 or
> > > > more parentless commits one after the other would be more noticeable.
> > >
> > > But there shouldn't be a blank line between D and D1 so the two
> > > alternatives take up the same amount of vertical space, the main
> > > difference being whether D1 appears next to D
> > >
> > >      * A root     * A root
> > >                     * B root
> > >      * B root         * C root
> > >                         * D1 child
> > >      * C root         _/
> > >                     /
> > >      * D1 child    /
> > >      * D root     * D root
> > >
> > > Of course if the indentation was smarter it would take up less room and
> > > look better than having blank lines
> > >
> > >      * A root
> > >        * B root
> > >          * C root
> > >      * D1 child
> > >      * D root
> >
> > Right, this would be ideal but that would require too much change to the
> > existing graphing logic, and should be its own patch.
>
> For the examples I'll use the term parentless instead of root, as
> boundary commits are excluded even if they are roots.
> By having is_parentless as a flag in 'git_graph' that every stage can
> access we could modify the rendering and maybe completely drop the
> commit placeholders, working on it for v4 but currently renders like
> this
>
>     * A parentless
>       * B parentless
>         * C parentless
>   * D1 child
>   * D parentless
>
> (A has indentation when it could not have, but that would require a
> lookahead if the next commit is also parentless)
> But definitely a step forward.
>
> Do we want cascading or just a fixed indentation?
>
>     * A parentless
>     * B parentless
>     * C parentless
>   * D1 child
>   * D parentless
>
> By being indented it indicates that it is parentless and that the one
> below doesn't relate to it, but cascading looks clearer.

Agreed, let's keep the cascading.

> >
> > > > But there are cases that blank line might be better:
> > > >
> > > >    * 10_A2
> > > >    * 10_A1
> > > >    * 10_A
> > > >      *   10_M
> > > >     /|\
> > > >    | | * 10_D
> > > >    | * 10_C
> > > >    * 10_B
> > > >
> > > > Feels like a shower of commits instead of an indented merge.
> > >
> > > Yes, that is a bit confusing. I think the thing I find confusing with
> > > this approach is that we're treating the commit rendered below the root
> > > commit specially, rather than treating the root commit itself specially.
> > > To me it is the root commit that's the odd one out because it does not
> > > have any parents, but we treat the commit that's rendered below as the
> > > odd one by indenting it relative to its parents.
> >
> > I guess that would make the examples look something like this:
> >
> >   * A root
> >   * B root
> >   * C root
> > * D1 child
> > * D root
> >
> > No cascading, and no need for that massive _ / collapse line.
> >
> > * 10_A2
> > * 10_A1
> >  \
> >   * 10_A
> > *   10_M
> > | \ \
> > | | * 10_D
> > | * 10_C
> > * 10_B
> >
> > I say it looks better than the alternatives, but I'm not sure if this will
> > be easy to implement. The diagonal connection line (\) will need to
> > be printed before printing the actual root commit, which will require
> > lookahead logic.
> >
> > I'd prefer to avoid major surgery on the codebase.
>
> Octopus merges need a pre-commit phase where an additional row
> increases the space around a commit with multiple parents to make room
> for it.
> A new phase can be created similarly to pre-commit as pre-root where
> the connection edge (\) can be printed before the indented commit.
>
> So far this is the comparison:
>
> indentation at root:
>
>     * A parentless
>   * B1 child
>    \
>     * B parentless
>   * C1 child
>   * C parentless
>
> indentation AFTER the root (current v3):
>
>   * A parentless
>     * B1 child
>    /
>   * B parentless
>     * C1 child
>    /
>   * C parentless
>
> Karthik mentioned that by indenting the parentless, we lose the
> consistency of having the roots on their real column and now some are
> indented and some are not.
> The biggest winner having the parentless indented are the merge commits:
>
>   * A child
>   * A child
>     \
>       * A parentless
>   *-.   B child
>   | \ \
>   | |  * C parentless
>   | * D parentless
>   * E parentless
>
> which IMO looks clearer than the commit shower:
>
>   * A child
>   * A child
>   * A parentless
>     *   B child
>    /|\
>   | | * C parentless
>   | * D parentless
>   * E parentless

I guess we're deciding between cleaner root (parentless) commits and
cleaner merge commits. I favour merge commits because they appear
much more frequently in most codebases.

> >
> >
> > Thanks,
> > Chandra.
>
> Regards
>
> --
> Pablo
