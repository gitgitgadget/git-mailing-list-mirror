Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD73563D4
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979143; cv=pass; b=NLtHL6bAKMeS6Hl6nNwiKow5RNG4ufS215/Re9D4tyk6Fr/QT+2PkX8ZiNJNX0A3KOy2ostDt98y/vq3GzP9K+0eQOg4ex3/s7506bMy7SSMGXsn5wpRCZ1zC5vn6bUZ6xA1H25/x0HLYhc3Ej2c37/sqsj5AvWB+P4HX4CV7EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979143; c=relaxed/simple;
	bh=CAyTFqOI8LXLViw0jl2ftcVpWAeAZUkgeC0GNrwN3Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rV+DaH2DRS9loAecXpV2+nfZQ/QWCrIoQ5Vdn+19H29CYcpGuqY07rIfVphjzaTHihXZWw18rwQauc50W5Y7RFlu+ixEor1wBVJYZX62ROcaHMvKy/tLMvCmTp8+n1ptF9NHXLi++n9/5v7mnDLeWxJntVy/aH85r9D2S4HKbp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+BQHdsy; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+BQHdsy"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3591cc98871so3316794a91.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 14:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776979141; cv=none;
        d=google.com; s=arc-20240605;
        b=fyb383D1f1vjSaCUoz4HIcrhNsvJCvXs7e6mC0FtQxSMTGJMexBNHJzbJAK30iy+Gu
         xHVdyzwxAW4HuPMhQ4oeVEDxwD2c9bovGWqD24HxmHGjrlElliWgxLXVqsEbhijqRBUF
         FfRth/e4eZt+ZqvvyvjUderehYYBcN/j2bH/rsWFVJNWLNpEc8wdQi06rkLiFN4RB5a4
         iwYUHi+9B/UGMu6QrlxQ/ycO1WE/8wwmo9c4kqgeQ6SEDPaa1WYLaL5CVXlMqnVKi9Wx
         tRlaQbrL6NkLdjjsA71hRJTCjDsos+RYMSGc92/fPH7h2mp0wZlctYVeY8oAQ1FInGY6
         vNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+hiRXxk3FrBUH3BtIuFGKrvyyn0pYXS+DKZENPvgHvY=;
        fh=7C13Yara6diLW3o1hgquesR7ciM/ftgxAeePVQ59NFA=;
        b=jrTDkeulH0uLsthb50hUz4WsB2VhjtoxQNIut+kUvdv28TTxakwjk5gYZcmT64Svlh
         sEhjZZrad1JUrMlBqcRPN2nMY14jrxO3Tz3rwXEECKt0lrhPBE6Ugq/f9otXcphIRvIz
         dWO2jHaU9goM25NUwDfCKjDqVZGXbn4jV9R0QmPAIg0/Bl8khSYXlZ63vnuBlFwPwj29
         d9fGEJfOsyZvhy/EmUwSTZhFwfT2drCcOqAVnu3YQc5SdzlL+98YK2gRxRN1EHmjXJby
         xA+p1xn5xHDlLQM0V89kqt9e4DFOAWmBGs2cQzIEjwjXz/65a/OfH/5hYRWCrU5PkI6g
         Ydlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776979141; x=1777583941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hiRXxk3FrBUH3BtIuFGKrvyyn0pYXS+DKZENPvgHvY=;
        b=j+BQHdsyT2G8pSK2N/5dF9cYIIapN4xHhGah0labWvusz1FRG35xV9orES/9YwqxHA
         RhV/gT6wWklCM07njU8P9VFAfOT4t0uY4nO2ClqjHIxiiZ2bmDtJac0KZvTxrEO3qdrj
         BUypvvf/wK/DodcByX+57m7KK8FZkpKojsjZbcu7i6rgAT3lVvVOjTYmIaQaqEamx3A7
         78XRd1OZgdnaIjK6CWOsm2mXZVhvaLQzT0WPqSeuvVnWdDTUgNf+P0XDHYJpQdtYbs1L
         nb+LMksoJ5UrQ8snMeSCSrJnKncGqUAf6/34+eUrM3hLydbFv2p5qO3M1F/j+dukzOBU
         cXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979141; x=1777583941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+hiRXxk3FrBUH3BtIuFGKrvyyn0pYXS+DKZENPvgHvY=;
        b=r/p39vEFxrGHwoGG4YI/o4gmpHhC+neilICJ1SgfulUMcSY65LuPs7gu8OgUFmORTj
         uCvD5xCPzuvwIvLATF3L5WhOCtgnGEBT2r2HlpEa2CxoIBv2S1aHKNHsFOtfINiQQOqU
         bPGhXe4uUpom3PH4G225FCE/n78S0B3CBbzipII2VuO4Bchyurf3XDNA56sT9LARyRt6
         ebIx2mOtstdPmrwjK6n8bY8/F96w+12gNoIHVnQhbNmaZz4CYpfkCO4KuLQAWoAscKQ5
         oK9Yoj+t+Uqgfpa9cKSc/2J/70YPvhvcWZNTmwhLMRahDyvoBmkA3/Ki12o6YjA5ik9X
         VEcA==
X-Gm-Message-State: AOJu0YwtkXHPlM/svqMs9oZavn4MmDGGU+xwIUkCOn7zvE8h+q/M0b1r
	021pCOgD22yibJJhhVZ7YyLWzemFthNXHt6SLxiZWTUQtZSsVwFOVdKa3s5SPp+Zzu5MYs53E46
	JZbrdvEZCkavWgTflT6lOn8M9cZR12ns=
X-Gm-Gg: AeBDietryBNlcOljfcQ+t5PdU7BQv5R1WPKFdbCd0x8g3b8oTurqxqW4zNj8XiEbZCy
	FzpxFtwGM7jVT1UF3B9j4F30Jfyi5JSK0qx2LVDw5Sp0IGvTKH+PB8MKIMQiklFtN3uMkyxbKwp
	56l1/e1zWQtRuDldblmqubcdp4ZRNJKwfFt5jmI7VVwX7C/QBEiZiFUTxRulslpWN/95gObtjUV
	nDqTXcMJNcvp3ZUuzEdpcJvOSmY6qqs+R4IcVppHz2lz5w1+sXF//j1XujHFx56OOgRB+7zlIMh
	IvJQA0LDSTFWQeGGFVQ5RV98orGHkL2DyvLnjJE2NR3I28U8Lxn0MpOu/9jtNcW8yKONuI7zPxN
	DI+wLx8XePKKotkE=
X-Received: by 2002:a17:90b:5107:b0:35e:3aec:718b with SMTP id
 98e67ed59e1d1-3614046e12amr26913740a91.15.1776979141451; Thu, 23 Apr 2026
 14:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
 <20260422-b4-pks-history-fixup-v1-2-48d4484243de@pks.im> <CALnO6CCBA=OSvKT8D6-YR1S=x3VOa_MpzWfK6FJWPSXq0ysMPg@mail.gmail.com>
 <aenCRKxak1l6GE3H@pks.im>
In-Reply-To: <aenCRKxak1l6GE3H@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 23 Apr 2026 17:18:50 -0400
X-Gm-Features: AQROBzCh2LY_cEZausQS8SusplWUO1wLFsA3T1QWEdCTVXuFL3dXNP9sfMVAl_I
Message-ID: <CALnO6CAZQxvqEqDhahFs7NcjENrU=Dg=cbFDkEeAE3+h_3R+8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/history: introduce "fixup" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 2:55=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Apr 22, 2026 at 03:06:12PM -0400, D. Ben Knoble wrote:
> > On Wed, Apr 22, 2026 at 6:30=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > > diff --git a/Documentation/git-history.adoc b/Documentation/git-histo=
ry.adoc
> > > index 24dc907033..3cdfc8ba02 100644
> > > --- a/Documentation/git-history.adoc
> > > +++ b/Documentation/git-history.adoc
> > > @@ -53,6 +55,19 @@ COMMANDS
> > >
> > >  The following commands are available to rewrite history in different=
 ways:
> > >
> > > +`fixup <commit>`::
> > > +       Apply the currently staged changes to the specified commit. T=
he staged
> > > +       changes are incorporated into the target commit's tree via a =
three-way
> > > +       merge, using HEAD's tree as the merge base, which is equivale=
nt to
> > > +       linkgit:git-cherry-pick[1].
> >
> > I'm not quite sure what, as a user of "git history fixup," I'm
> > supposed to take from this. Does it make conflicts less likely when
> > creating the new fixup? I imagine it doesn't help with conflicts
> > between <commit> and HEAD that newly arise.
> >
> > Anyway, I'd think the mechanics are less relevant than the end-user
> > behavior at this point in the doc, unless the equivalence with
> > cherry-pick is supposed to tell me something about that behavior.
>
> There's at least two more or less obvious variants to do this:
>
>   - You generate the diff between HEAD and index and then try to reapply
>     the patch on top of the target commit.
>
>   - You perform the three-way merge.
>
> The second item is definitely more robust compared to generating the
> diff and reapplying it, and we use the exact same strategy to perform
> cherry-picks nowadays.
>
> > > diff --git a/builtin/history.c b/builtin/history.c
> > > index 549e352c74..6299f0dfa9 100644
> > > --- a/builtin/history.c
> > > +++ b/builtin/history.c
> [snip]
> > > +       /*
> > > +        * Perform the three-way merge to reapply changes in the inde=
x onto the
> > > +        * target commit. This is using basically the same logic as a
> > > +        * cherry-pick, where the base commit is our HEAD, ours is th=
e original
> > > +        * tree and theirs is the index tree.
> > > +        */
> >
> > OTOH, this explanation helps quite a bit here :)
>
> Hm, okay. I felt that this explanation here is even more technical. How
> about:
>
>     `fixup <commit>`::
>         Apply the currently staged changes to the specified commit. This
>         is done by performing a three-way merge between the HEAD commit,
>         the target commit and the tree generated from staged changes.
>         This is using the same logic as linkgit:git-cherry-pick[1].
>
> Not sure that this is an improvement? Happy to hear other suggestions.
>
> Thanks!
>
> Patrick

Hm. I think what I meant is that the in-code comment makes sense to
describe internals; for users, I'm not sure what I should get out of
that description of fixup.

What I (think I) really care about is that it behaves a bit like `git
rebase -i` with a "fixup" command (modulo conflicts). Especially since
this is quite a bit more porcelain than plumbing, no?

Idk. If the 3-way merge is valuable to keep, maybe it belongs in a
second paragraph just to push it out of the way of the primary
description ("Apply the currently staged changes to the specified
commit")?

Thanks.

--=20
D. Ben Knoble
