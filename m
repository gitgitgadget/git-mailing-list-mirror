Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5819D89E
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926404; cv=none; b=lpCZ9cu1izPjNs1Kurb4Ozov65Nq/9N0iDv4YyqaqNwrfWtrulPy+609Fuw2anUsNcSi92BWnLKmNYAAdJG52p1ZM/5cXxRAEP/4E0ohFoBUnfkrw5g3A7bfdOdlMn0Aqww/D7GWuWxel0PeplNu+SjsYr3DrXFkbzknFi6l0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926404; c=relaxed/simple;
	bh=feQVYU59mDwwuvz9I2cy3rVUaajyI3P7Lhu3AJ3pXqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbKXGvl7SqZs0Sswp76Xaq1lqQkXe4gIP6xtWnkriE8faKk13GVkaLfgUCTo4YI0eOn5GOAVCrplBLr7A5q3C9Mnc1oyJdIUaZ7XF34drz/22Lnkw3kOc5oxl8lYyvALGp0DZ39FQqQlv0s1SiBjAQR0DoJWmoY17VjKZEpTh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGQZRKxb; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGQZRKxb"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44e534a1fbeso2751cf.1
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721926402; x=1722531202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UV/UEPKUcduDGi+T6Tl4nRpcTElTcKi4cP33TRGFSg=;
        b=NGQZRKxbxoz6MATw4skSOhBRw3OGdu7srpR/MSljjAZlhihC4M5FfiHyTR3ev/M6M7
         HdN84mzF9q7SbbdDWsql+rQcvPrlRHADUQpMpfYI1SQ94Gpn6//WhT9sI59fixTfBZz2
         /qUAPtqq9Bhhnk2AjO2j3zN0WT2uQp542bkXhaecnUdc14WECJvDhA6e0OP2ymYaQc5U
         is3tClRy7IFBPuLJOQa1cFxJ2BUSxAtHYFBmOzf+j9RQgZdntku5vY45CvlGSySO/wOa
         lwO5RltOiKJ5M68hUCopbZ0z2jM2H30q5PDXZuXGX3MNyOQ8x2XDqAMnXtZpAv+SPpuw
         +f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721926402; x=1722531202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UV/UEPKUcduDGi+T6Tl4nRpcTElTcKi4cP33TRGFSg=;
        b=jgCg+m1vcDnmnMwF2XAXhDEgSwsPXvdCCk2zmxO+ic6h1+1AWmossVMrmrkoclXmzd
         L/FzQ+RO8WCgTen8TeOe0eBQ0vyIQiFlyEUwFiJzAb+fC24hizwXoA1Nrky7EJNWuS8C
         tyPnBIzE415cKEtiLuY6jTzgFk8GPP2swJubn+KqUcCUsQD9d5d1u3PyuK06ALKwTPOW
         HN5IayjGcaTXSFvD2AqE0jZ11341sOwyoV3mylxRwK5agQ8NpoBLnKKaRqdccjR6VCwm
         pWypGK6FlhL4yFVKElPDMvKlElxERHCDrFbIz4W48gEn60K8Gwi+pIL3FTiyekX/BaGI
         9JKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSmUMw+9fGqxTZeEXvr4K1LtA8ZLkRDzdJkIFHe+awj5ZLUd7lGMlxUehuOlpimeYNfFzqVRLLywoCFUx2B4OMdiBy
X-Gm-Message-State: AOJu0YxsWAhurqWw8fNKlgMOyZJs+/qi231eTkhX2Di2RbK4qWcLzGrT
	V64cl82n56Mh/1EAJEL4yJy+XkDARi1759k3FyJLiS5Z5rllz6SbnXxarAuMV7lnq2QOMTYWYlx
	QMfQzr7LrVPjNZOINiovh7t1bq3Oj53clfpjt
X-Google-Smtp-Source: AGHT+IH06HpTXSJgKeAPi/Q6iOueHYO/q+8atOawFEIkNCytCloJEtlJkBBKzomHBpHY3vH4WVOKrX5Wy/nPBqchzi4=
X-Received: by 2002:ac8:5ac5:0:b0:447:f891:d41d with SMTP id
 d75a77b69052e-44fea28eef2mr3226831cf.18.1721926399263; Thu, 25 Jul 2024
 09:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718173843.2411415-1-emilyshaffer@google.com>
 <xmqqh6cmmi8n.fsf@gitster.g> <00fa01dad96c$8fda8890$af8f99b0$@nexbridge.com>
In-Reply-To: <00fa01dad96c$8fda8890$af8f99b0$@nexbridge.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 25 Jul 2024 09:53:06 -0700
Message-ID: <CAJoAoZkUD5gc+M7AXpY08o=eYsz1M_vaZBMQXN6CAnWioDp2Gg@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: add platform support policy
To: rsbecker@nexbridge.com
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 4:45=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Thursday, July 18, 2024 6:46 PM, Junio C Hamano wrote:
> >Emily Shaffer <emilyshaffer@google.com> writes:
> >
> >> Supporting many platforms is only easy when we have the right tools to
> >> ensure that support.
> >
> >"easy" -> "possible".
> >
> >> +Compatible by next release
> >> +--------------------------
> >> +
> >> +To increase probability that compatibility issues introduced in a
> >> +release will be fixed in a later release:
> >> +
> >> +* You should send a bug report as soon as you notice the breakage on
> >> +your
> >> +  platform. The sooner you notice, the better; watching `seen` means
> >> +you can
> >> +  notice problems before they are considered "done with review";
> >> +whereas
> >> +  watching `master` means the stable branch could break for your
> >> +platform, but
> >> +  you have a decent chance of avoiding a tagged release breaking you.
> >> +See "The
> >> +  Policy" in the link:../howto/maintain-git.txt[maintainer's guide]
> >> +for an
> >
> >Running
> >
> >    $ make -C Documentation howto/maintain-git.html
> >    $ lynx Documentation/howto/maintain-git.html
> >
> >tells me that the title of the document is "How to maintain Git".
> >
> >> +  overview of which branches are used in git.git, and how.
> >
> >"git.git" -> "the Git project"
> >
> >> +Compatible on `master` and releases
> >> +-----------------------------------------
> >
> >Underline that signals what level the header is is drawn to the same col=
umn as the
> >header title itself, or you'd confuse the formatter.
> >
> >
> >> +To make sure all stable builds and regular releases work for your
> >> +platform the first time, you can make sure `master` doesn't break for=
 your
> >platform:
> >
> >"can" -> "want to"?
> >
> >But "to make sure X, you can make sure Y" feels a bit awkward.
> >
> >    To make sure ... work for your platform, help us avoid breaking the
> >    tip of `master` by merging topics that break your platform.
> >
> >> +* You should run nightly tests against the `next` branch and publish
> >> +breakage
> >> +  reports to the mailing list immediately when they happen.
> >
> >Can't it be daily instead of nightly ;-), or is it better than nothing i=
f you can afford to
> >run only once every other day?
> >
> >A topic (unless it is during the shuffle time around -rc0) usually spend=
s no less than
> >7 calendar days in 'next', so while I would appreciate if somebody runs =
tests twice a
> >day, in practice you should be able to catch a new breakage in 'next' if=
 you run a full
> >and thorough test twice a week.
> >
> >> +* You should either:
> >> +
> >> +** Provide VM access on-demand to a trusted developer working to fix =
the issue,
> >> +   so they can test their fix, OR
> >
> >"VM access on-demand" -> "on-demand access to your platform" (iow, physi=
cal
> >iron is also fine for our purpose).
> >
> >> +Compatible on `next`
> >> +--------------------
> >> +
> >> +To avoid reactive debugging and fixing when changes hit a release or
> >> +stable, you can aim to ensure `next` works for your platform. (See
> >> +"The Policy" in the link:../howto/maintain-git.txt[maintainer's
> >> +guide] for an overview of how `next` is used in the Git project.) To =
do that:
> >> +
> >> +* You should add a runner for your platform to the GitHub Actions or
> >> +GitLab CI
> >> +  suite.  This suite is run when any Git developer proposes a new
> >> +patch, and
> >> +  having a runner for your platform/configuration means every
> >> +developer will
> >> +  know if they break you, immediately.
> >> +
> >> +** If adding it to an existing CI suite is infeasible (due to archite=
cture
> >> +   constraints or for performance reasons), any other method which ru=
ns as
> >> +   automatically and quickly as possible works, too. For example, a s=
ervice
> >> +   which snoops on the mailing list and automatically runs tests on n=
ew [PATCH]
> >> +   emails, replying to the author with the results, would also be wit=
hin the
> >> +   spirit of this requirement.
> >
> >It would be very nice if they did this, indeed.  Explaining that somethi=
ng that
> >mechanically looks vastly different is within the spirit is a very good =
move.
> >
> >> +Minimum Requirements
> >> +--------------------
> >> +
> >> +Even if platform maintainers are willing to add tests or CI runners,
> >> +we will not consider helping to support platforms that do not meet
> >> +these minimum
> >> +requirements:
> >> +
> >> +* Has C99 or C11
> >
> >OK.
> >
> >> +* Has dependencies which were released in the past 10 years
> >
> >This is hard to understand and I wonder if we can clarify.  I get what y=
ou want to
> >say: suppose we rely on library X that is getting regular feature and se=
curity updates
> >in reasonable cadence, say every 6 months there is an upstream release o=
f library X,
> >but a niche platform has ported the library only once long time ago, and=
 hasn't
> >updated it ever since.  Now the Git project may consider helping a port =
to such a
> >platform if the initial port of library X was 8 years ago, but will not =
if it was 12 years
> >ago.
> >
> >But if Git depends on an ultra stable library whose last public release =
was 12 years
> >ago, disqualify everybody is not what this requirement wants to do.
> >
> >I attempted to formulate my version along ...
> >
> >    Keep up with the versions of dependencies (libraries, etc.) and
> >    not to lag behind compared to typical mainstream platforms by
> >    more than X years.
> >
> >... the above line, but to me it is no better than the original, so I fa=
iled miserably.  But
> >the idea I am bringing to the table here is that time of release is not =
absolute.  If
> >typical mainstream platforms consider a release of a library made 8 year=
s ago from
> >the upstream performant, functional, and secure enough and fit for use, =
we do not
> >consider that they are approaching the limit.  But if another platform u=
ses the same
> >library from 12 years ago, i.e.
> >lagging behind others by 4 years is a problem at the same graveness usin=
g another
> >library that was released 6 years ago, when other platforms are using a =
much
> >younger vintage of the same library released at 2 years ago.
> >
> >Having said all that, everything I removed from my quote I found agreeab=
le.  Very
> >well written.
>
> I am concerned about setting a specific limit here. The reason is that, a=
s a platform/community maintainer:
> 1.  I do not control the library versions that are available - in most ca=
ses
> 2. I do not control the available toolchain - in all cases
> 3. Support is required for all OS releases dating back 5 years from the c=
lose of sales - this is not actually a huge problem except for #1 and #2. H=
owever, it does not serious constraints on what toolchains are available. M=
ost of what we do is use static linkage to avoid a lot of compatibility iss=
ues, other than OpenSSL that has to be flexible based on the rate of CVEs r=
aised and solved.
> 4. Porting some new tools (e.g., GO, Rust, gcc, libc, glibc), is usually =
impossible no matter what my skill level based on platform prohibitions.

I actually think what level of control the platform maintainer has is
beside the point.

The intent of this line in the doc is to say: even if there is an
active maintainer and there are active users, Git developers need to
be able to use relatively modern tooling to be able to keep Git
healthy and evolving. The more Git development is locked into past
tooling, the less it can keep up with the needs of most of the
industry, and the higher the risk comes of Git being abandoned because
the cost to overhaul it to meet industry needs is too high. So, if a
platform isn't compatible with those reasonably modern tools (and I do
think "a C compiler that's less than 10 years out-of-date" is really
stretching the meaning of "modern"), sorry, but it's not workable for
us.

That is, it's not about whether the maintainer is virtuous and doing
everything in their power; it's about whether the platform itself is
feasible to support and whether the abilities of the platform line up
with the Git project's needs to make forward progress and keep up with
the times.

Whether or not that paraphrasal is something the rest of the Git
community agrees with, though, is the whole reason I sent this doc up
for review ;) So far I haven't seen any other disagreement than this
mail, but we also haven't gotten a ton of reviews on this patch, less
than half a dozen individuals. (By the way, "others may find Git too
far gone and build something new instead" is actually already
happening[1][2], including at Google.)

> I'm sorry to have to complain about this, but it is a reality of exotic, =
non-linux, platforms that are still being maintained and active (the last m=
ajor NonStop OS release was 11 months ago, and another is due to drop immin=
ently, so this is not a dead or dying platform). The last thing I want to h=
ave is having users locked out of future git versions, based on the increas=
ing adoption of git on NonStop that has been (immodestly said) mostly my fa=
ult. Can we solve this in some acceptable way?

As it stands, we currently don't have any tooling available to make
sure that changes we make work on NonStop, anyway - we basically need
to take your word for it when something breaks, and that's quite
difficult for the contributor base to cater to. So even if we were to
relax the minimum requirement bits here, we'd have difficulty
supporting NonStop in the capacity that you sound interested in. Do
you have any suggestions to make NonStop easier to support in that
regard?

I wonder if it is better worth explaining what maintenance branch
support users can expect - how long a given version will receive
security patches, what kind of backporting work platform maintainers
could reasonably do, and so on. Thoughts?

 - Emily

1: https://github.com/martinvonz/jj
2: https://sapling-scm.com/
