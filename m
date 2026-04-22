Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10B399007
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776882302; cv=pass; b=Hv+jex5B20cXg+TzwqV+YmCoqTPRRYB8Pn+IvY03gjLxcT8nYVT9PeOkhy/e2omKXoUvcwCmHWAx+xui8aZCMreWqRexlVPs3DCd1liomWvSGBTPy9NcIa07u8qznankuWQKhSLDjgqDLGZxsoQiu648AIjGUcPqqMPcYK8cwGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776882302; c=relaxed/simple;
	bh=+SVKBivSfehWDXDcNy7Ww8ezNH2gnRYO5m7PM16yiUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQh2SIVIhkhBdJywMxqR3k96LCi55TWiufSQ/t8N01FcbQHa8HcP0mTWGdRXoN1ojyKzzIqV5S2XBPjRjkw4wxA5UfFhSXmSEIPhZ/rvweH4m5LJiSGSDJOLXeZenh3gyLmttOpmPBCM8gEbYslif3HGHZ/tDS5dTyl+gEweLbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc8Mi3H3; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc8Mi3H3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2589c26e3so52441435ad.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 11:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776882300; cv=none;
        d=google.com; s=arc-20240605;
        b=iD9H706NOMSJDxYemPZy8w9NtBDEYuiPCd8w7QcX2g+3BNellVGaJoLuY7pRHH1yuW
         IE//3aYwJxtEO9Vii12H+3ee07UtfEkDgGU5VD/Rc2VnToRAO8O3lsC0316O3l6GLnUo
         FgnA5j4gi3bySx69pJOyk4uChBB5Jv7DLI8zU+wWLm9Sul4+tLCkOmviic9nFKhhylD9
         gb50VUuWkQMHPFriOmQpWaz+v5Ruhy3RbJ+/c3CzLz8+owx/unE+CwkqEDjdZERZaarG
         e4wFu7y/d/aMMo/V+VS/15p/BgD7CPCbV47txHTstMO0zeif/vsj+9M88sxSp0OKcULb
         WWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pa+RvZzVfiKQDJrNHlyiM/w0BqRsCZpUxe3BTXb/ybs=;
        fh=YRp4XrKOda7rMviyQmVtSvJ26XINAn4+UTwSfHRS0Hg=;
        b=hkOQT4wdwTbYIM6fplTlEwSmFZ1nnks1qg4vuTxJMdNUZAnFYduQN5g3Em4XwBWJpu
         UthDXpN8rQ7suqKhYvtqb5bUz6FWneRU9S4W3IcBbFKoXIUrGAjhJ4C2kKyUrN3vAO9Y
         Q1+hvPQ/81fObEgJZiUC8UT6F3cerTjq4aOZoEKEOEVuR6Y6gobYPbW4rfKISvM/muSZ
         Lumws02aeTAohvjwbCFkT3LkFw3YWL7YwCng94L1b8UpqGY6j0wI57vU4ul6RYAfaPur
         bqeZcVzyAjSAwXU/Ur5l2D30DXLdJEE5n5qdrEWcmq1m4N2ykIFbgzu9BX9dM9xo9tNv
         2nyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776882300; x=1777487100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pa+RvZzVfiKQDJrNHlyiM/w0BqRsCZpUxe3BTXb/ybs=;
        b=bc8Mi3H3lrt+ufuDlClyoEWx3N86fO7r6bwtlDtwAkQGaZREu03KmNjr1x3reVBZ3v
         Yea/zT+jw9fbDUaFqTrP/R/IVpXFv46hUmILjqVdGA1Z5FLvcUFzwQXp0iDrbImARV1+
         fFaiFgLkk9CP3JZkYMpQBMMHgvmlFgNHSk04KYHSLXJECWJxsuYPQDeask1zlft5FiyM
         1PL4X0BFHs29u0bar601xADPkY/IrSnmkfP3Q4oU4+8QtQawypAFRN6Fr0qwaw88Vjm+
         YxpNrNpdSpNV53WvU2IH7Rnh5oMBQmdNrwwo/J56ZMHbqQiB9vnNotLqdMbl3UYLABPT
         HhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776882300; x=1777487100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pa+RvZzVfiKQDJrNHlyiM/w0BqRsCZpUxe3BTXb/ybs=;
        b=pIWSABSbQqf+YJq7qb3EKOPd8Qjl1iMPltYYiMUQtFb5uY6OtpZ1LNcHkfCLNGq5pr
         0zoaztw1jEqrLE68m07ZOmkpagQ2G8KxH96eXSQ6cFZhEB4ip9BdeQmJXjqbha8Ehbi4
         AY6M7ZB9qFWa6vpY1J4t7lwarT4Okp5yktk75ylqSfnZAQfqN0COq9/IWx8B/DjMYeOz
         FHMpizZB3REZkP3RCqXs5Hkhmvvvcyt5M2m230fJGr4ByCnxTnwBxb/suX8OpbEBxisQ
         +NTYpsJ7g5/baSkJrEx8LwqqYuv8PdGNFWQKy0Ryf6bTV3ZuGc0WxrwAsJrHhoiVWn7J
         qQBw==
X-Gm-Message-State: AOJu0YyjE21vNSk97ZyKPWOrfrHUYdK2JdvzKc93HX9kRMNI10iCWHaC
	r/BG8i9l1v5gsHEzJm0Xgz4B8hPHEtoJfGAH0IZg5Njt8Bolb8N6w1XlC4xmFtOT2VId9nxJqms
	bu6GlcHOLiwnqDZktlQA+wVqOG0YhXK4=
X-Gm-Gg: AeBDies2cFYk+N4hGzw/c8K3djvQR7036eaRO+KR/h4qMDL931Es+xxsVgZ90KDkjZf
	Bhovk4Xp8rsGMgs4EazNcCOw9Pj7DsaB65YKeItm3ZrbTYtmaDOmkD0tkpYR8OUL/mxYqMkzdq3
	QFEWvb4cPAYmUDyWBo3LCz84ILbe8adZ9Rpcq+yRS3gR1tI+9DCFRftHG89rnsENBeZCQuIFxVa
	txsgjUkhTl0JB/hwp9jfYNYlHMw3W+9zMltRF9tUBUTubu5pc5aAbbdjDWYn3b6o2tYOQrGCX94
	9b/ePYQ/tsUel6iL2b1nyqwWW/1mmwxzDpOzkp5vhMcSjCIFWZk2+JdFBkgXahIBdTM5WHOlXBh
	fJJq5wWP/KAYAki8=
X-Received: by 2002:a17:902:cece:b0:2b5:f105:52b2 with SMTP id
 d9443c01a7336-2b5f9eceba5mr256602655ad.9.1776882299767; Wed, 22 Apr 2026
 11:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418164736.2367523-2-mroik@delayed.space> <C60EE993-97DA-45F7-89DE-2F97ABB0F685@gmail.com>
 <aeUZUqSQI8FvRUco@exploit> <CALnO6CACfSyzyguX4623Dk3y+QEM_Dbmfko8dTyM1p3JxBjZFg@mail.gmail.com>
 <aeUqSltEWIWaPDh3@exploit>
In-Reply-To: <aeUqSltEWIWaPDh3@exploit>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 22 Apr 2026 14:24:48 -0400
X-Gm-Features: AQROBzDlu2CnjXtvxRWOqBpNs8_g3mrTEg5B9-VZm-BWk1HcYZr2li4tDLdvyZ4
Message-ID: <CALnO6CAjMAZhBk_WXW1wbKk1kpQScFtbY0R+mCxHTFB7=CcEDg@mail.gmail.com>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 4:31=E2=80=AFPM Mirko Faina <mroik@delayed.space> w=
rote:
> > > > >    if (revs->reverse_output_stage) {
> > > > > +        if (revs->reverse =3D=3D 2 && revs->max_count =3D=3D 0)
> > > > > +            return NULL;
> > > > > +
> >
> > PS: something I spotted on a second read. [Ignoring reverse=3Dafter
> > mode] This hunk looks to me like a nice little optimization (return
> > nothing if we know max_count says we yield no commits). Of course, I
> > could see that being viable early in the function, right? When asking
> > get_revision for commits, if max_count is 0, just return NULL.
> >
> > For reverse=3Dafter mode, this condition is only true if the max_count
> > was 0 in the previous conditional, also, since we use max_count=3D-1
> > before iterating get_revision_internal. That means the original
> > max_count isn't touched. At any rate, it _seems_ to me that the whole
> > function could benefit from this optimization=E2=80=A6 but I wonder if =
it is
> > _necessary_ for correctness of reverse=3Dafter in some way that I'm not
> > seeing? Since the current version doesn't need the early bailout, why
> > does reverse=3Dafter?
>
> Just to clarify, "reverse =3D 2" is "--reverse=3Dbefore" and not
> "--reverse=3Dafter".

Oh golly, sorry about that!

> With "reverse =3D 2", the snippet of code you're referencing is not an
> optimization but a requirement for correctness. With "reverse =3D 1" we
> just keep the max_count as is and it's used by get_revision_internal()
> to stop if that limit is reached. What we find in 'reversed' are already
> just the commits we need to return.
>
> With "reverse =3D 2", we first set max_count to -1 and then retrieve the
> whole history, then we set max_count to its original value. Then we
> return the commits on each call of get_revision(). Now, unlike with
> "reverse =3D 1", we have the whole history in 'reversed', because of that
> we need to know when to stop. That's the reason we decrement max_count
> only for "reverse =3D 2" and why "max_count =3D=3D 0" is checked only for
> "reverse =3D 2".

Ok, this explanation hasn't yet clicked=E2=80=A6

> > > > >        c =3D pop_commit(&revs->commits);
> > > > > +        if (revs->reverse =3D=3D 2)
> > > > > +            revs->max_count--;
> > > >
> > > > Hm. Why do we decrement here? Again, not an area I=E2=80=99m famili=
ar with, but a bit surprising.
> > >
> > > get_revision() (in revision.c) handles the reverse option and updates
> > > the "struct git_graph". get_revision() then calls
> > > get_revision_internal(), which handles commit boundaries and max_coun=
t,
> > > here is where it gets decreased. Since max_count gets decreased
> > > everytime get_revision_internal() is called, if we were to leave
> > > max_count as is before the walk (in get_revision() at line 4558), the
> > > walk would stop before reaching the root commit. This is why the curr=
ent
> > > --reverse option is applied only after commit limiting options. So
> > > instead we set max_count at -1 walking the whole history and storing =
it
> > > in 'reversed'. Now we're in "reverse_output_stage =3D 1", and in this
> > > state we never call get_revision_internal() again, instead we pop
> > > commits from 'reversed'. Because of this we have to handle max_count
> > > outside get_revision_internal(), so we decrement it in the snippet of
> > > code you referenced.
> > >
> > > A bit verbose but hopefully it'll get my point across.
> >
> > I don't 100% follow, but I'm out of my depth :)
> >
> > I think I see that get_revision() effectively has 2 modes pertaining
> > to reverse: reverse and reverse output stage (the former falls
> > directly into the latter, though).
> >
> > After some setup, the reverse mode calls get_revision_internal() as
> > you said. That decrements max_count as a way of counting how many
> > commits we've seen through the loop, so if we asked for 5 we'd only
> > process 5 commits.
> >
> > Then we fall into the output stage mode, which pops a commit [1].
> >
> > With this patch, in reverse=3Dafter we disable max_count in the first
> > (reverse) mode, as you said. Ok: we get the whole (filtered) history
> > then, at which point we can now shrink. That makes sense.
> >
> > Then in the reverse output stage mode, we pretend to have one less
> > max_count. That's what I can't figure out. Is it because of the
> > pop_commit()? I guess I'm not totally seeing how that interacted with
> > the max_count in the original code: does the current code yield one
> > extra commit in get_revision_internal() ?
>
> I'm not sure I understand what you're referencing with "Then in the
> reverse output stage mode, we pretend to have one less max_count".
>
> If you're referring to line 4573, then...
>
> > You wrote that "we never call get_revision_internal() again," but I
> > don't see why that's true with this patch and not true before it.
> >
> > I do agree that _somebody_ has to handle max_count after
> > get_revision() returns with reverse=3Dafter. I'm just not sure what
> >
> >     if (revs->reverse =3D=3D 2)
> >         revs->max_count--;
> >
> > is doing.
>
> ...we're not pretending we have fewer commits. Every subsequent call to
> get_revision() after the first call will never enter the branch at line
> 4548 and will only enter the branch at 4568. Everytime we pop a commit
> from 'reversed' we decrease max_count so we can limit only to the amount
> of commits the user wants.
>
> So, to recap, with "reverse =3D 2", on the first call to get_revision() w=
e
> walk the whole history and store it in 'reversed' in reversed order and
> return the first commit.
> On subsequent calls to get_revision() we do not walk the history again,
> we simply return the commits that have been stored in 'reversed'.
> Everytime we pop a commit we have to decrease max_count, and we check
> againts max_count to know if we shouldn't return anymore commits (by
> returning NULL).

=E2=80=A6but I think this one does. I think what I missed is that in all
"reverse" modes, get_revision() does some pre-computation and then
yields one at a time the commits. In traditional "after" mode, the
counting is done by get_revision_internal() [before reversal]. In the
new mode, get_revision takes on that responsibility of
get_revision_internal instead.

Hm. That suggests to me that get_revision's responsibilities are
becoming complex. Might be worth some version of a refactor, but idk
which.

> > Of course if I'm the only one confused and others make sense of it,
> > that's ok, too.
>
> No, I completely understand. I did have to retouch the function a few
> times after writing the tests :P
>
> > [1]: I traced this to 498bcd3159 (rev-list: fix --reverse interaction
> > with --parents, 2008-08-29), but I can't fathom what the pop is doing
> > there.
>
> It's pretty much doing the same thing it does now, it's returning stored
> commits. In both versions, the initial setup when "revs->reverse" is
> true, becomes "dead code" after the first call.

And this pop makes more sense now, too. Phew!
--=20
D. Ben Knoble
