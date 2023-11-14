Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA017E
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHoUpMQ0"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEDDD4E
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 18:50:23 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-509c61e0cf4so6014091e87.2
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 18:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699930221; x=1700535021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6y3T0nSXmCWFXx/vi17q9C7ghJdpxvx6umNtD7wSc8U=;
        b=GHoUpMQ0VGED1WP9ZdQpwhLXirOiizH5C9SN45USpCd2Gvdd7Fkt8VAqAj6WdVyMYw
         B8ImTyyGYF7ku/M1Q/VXtjnYgn7pWpsjs+Dlig9mTl8WjF5h2Rv1WsF8Uz1fvqn0ZyVS
         fxu+JVf3iCYDaGc3+aAEOt2BqfGEA+d1L8eXP556wDzWYgED2XnaGwuUvLfjTidF3fta
         DaB1SoCsUvtQ13kFa7LaWzD7J8huBxzN/+QQLXEHvsGMtDJndamCHlC/FU/7Jxi1pyaQ
         wjkucQGqQiuC1BuNFZyOFh3TU+R/24EBvL9tLldvNMPENWyLzYRcxdlTvSqXD4ytVEtr
         xVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699930221; x=1700535021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6y3T0nSXmCWFXx/vi17q9C7ghJdpxvx6umNtD7wSc8U=;
        b=rYpngSzR6c1Rt6yz3BCKzb+L2TPV63JKm/B+1961+/lhTk5bwCsWX7KtRPTO1p6I6m
         Ngffd76Ku3D029BCHRIf69GnP68y12p45HLOTVNQVnJVaQnehLOjiRyLrTsxnWa+Y62Q
         UnjbzfgslL848/BB1OiYoCJ9Kr5cY96XggCrfmBDw0BtgZ4dDVyxOhPLJAupYOJDVwYi
         WtCMWjBTbjzqTJRTMdiJ1wzKL6b8CCrKytEItPQNt85+Q6DEl+UgHrs6kBawMyMxwI9E
         hk19xhBXsM5ZneeAIMrkR7lYHaSjtj/Ro/yzdB/Zmy5mY3ZKf7y64BN9hvu0oVBelx1W
         S9WA==
X-Gm-Message-State: AOJu0YygR8TvrMvPEejdIg7YN+I0BwFzJZNZpJPtgsMumxJxJHls18YI
	zGq2xGzMQgU+MO07sR985eS/LXvhVNSwwaKENzY=
X-Google-Smtp-Source: AGHT+IH5mxidAIpDhq3G0L+y4YLE515EgI/p0cjrIeCzq2iB0tQ0tyl1B+LXb/9g5eFtmRk90dOCbGSITopeeCWNSc0=
X-Received: by 2002:ac2:4e05:0:b0:507:9ff7:2ed4 with SMTP id
 e5-20020ac24e05000000b005079ff72ed4mr6673144lfr.43.1699930220849; Mon, 13 Nov
 2023 18:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697736516.git.me@ttaylorr.com> <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
 <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
 <20231113220254.GA2065691@coredump.intra.peff.net> <ZVKkgpiFaOwwDcdw@nand.local>
In-Reply-To: <ZVKkgpiFaOwwDcdw@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 13 Nov 2023 18:50:08 -0800
Message-ID: <CABPp-BEV8Mxu=4=TFN=0o9n+o69kKQfNZd_Rhr1swxqgKwd90g@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for `--write-pack`
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, 
	"Eric W. Biederman" <ebiederm@gmail.com>, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 2:34=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Mon, Nov 13, 2023 at 05:02:54PM -0500, Jeff King wrote:
> > On Fri, Nov 10, 2023 at 03:51:18PM -0800, Elijah Newren wrote:
> >
> > > This is unsafe; the object may need to be read later within the same
> > > merge. [...]
> > >
> > > I think (untested) that you could fix this by creating two packs
> > > instead of just one.  In particular, add a call to
> > > flush_odb_transcation() after the "redo_after_renames" block in
> > > merge_ort_nonrecursive_internal().
> >
> > It might not be too hard to just let in-process callers access the
> > objects we've written. A quick and dirty patch is below, which works
> > with the test you suggested (the test still fails because it finds a
> > conflict, but it gets past the "woah, I can't find that sha1" part).
>
> That's a very slick idea, and I think that this series has some legs to
> stand on now as a result.
>
> There are a few of interesting conclusions we can draw here:
>
>   1. This solves the recursive merge problem that Elijah mentioned
>      earlier where we could generate up to 2^N packs (where N is the
>      maximum depth of the recursive merge).
>
>   2. This also solves the case where the merge-ort code needs to read an
>      object that it wrote earlier on in the same process without having
>      to flush out intermediate packs. So in the best case we need only a
>      single pack (instead of two).
>
>   3. This also solves the 'replay' issue, *and* allows us to avoid the
>      tmp-objdir thing there entirely, since we can simulate object reads
>      in the bulk-checkin pack.
>
> So I think that this is a direction worth pursuing.

Agreed; this looks great.  It's basically bringing fast-import-like
functionality -- writing objects to a single new packfile while making
previous objects accessible to subsequent ones -- to additional
callers.

> In terms of making those lookups faster, I think that what you'd want is
> an oidmap. The overhead is slightly unfortunate, but I think that any
> other solution which requires keeping the written array in sorted order
> would in practice be more expensive as you have to constantly reallocate
> and copy portions of the array around to maintain its invariant.

When comparing the overhead of an oidmap to a bunch of inodes,
however, it seems relatively cheap.  :-)

> > I don't know if that is sufficient, though. Would other spawned
> > processes (hooks, external merge drivers, and so on) need to be able to
> > see these objects, too?
>
> Interesting point. In theory those processes could ask about newly
> created objects, and if they were spawned before the bulk-checkin pack
> was flushed, those lookups would fail.

One of the big design differences that I was pushing really hard with
git-replay was performance and things that came with it -- no
worktree, no per-commit hooks (which are nearly ruled out by no
worktree, but it's still worth calling out separately), etc.  A
post-operation hook could be fine, but would also not get to assume a
worktree.

merge-tree is the same as far as hooks; I'd rather just not have them,
but if we did, they'd be a post-operation hook.

In both cases, that makes hooks not much of a sticking point.

External merge drivers, however...

> But that requires that, e.g. for hooks, that we know a-priori the object
> ID of some newly-written objects. If you wanted to make those lookups
> succeed, I think there are a couple of options:
>
>   - teach child-processes about the bulk-checkin pack, and let them
>     perform the same fake lookup
>
>   - flush (but do not close) the bulk-checkin transaction
>
> In any event, I think that this is a sufficiently rare and niche case
> that we'd be OK to declare that you should not expect the above
> scenarios to work when using `--write-pack`. If someone does ask for
> that feature in the future, we could implement it relatively painlessly
> using one of the above options.

Seems reasonable to me.
