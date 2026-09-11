Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651EA3C10B9
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167550; cv=pass; b=ktNG+82FSjQec1EzPkPEXITsa2IK3giohNnpd6M2yOj4/9iOdQEr+SKR1FjNUUX2Cgz5wMTLa29KSaHMeFznDVXLp66DsBATr0Botst7OyUj2iImLGSsogsFTgIH8GtdD5txEo3coXuqdhErDNUlIQQxAikTHtfLtfRwvJYGX/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167550; c=relaxed/simple;
	bh=fpycsqLkPCeeoIiqMrkllzhJiyGWuPBrYy7PCX7GviM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPH/S6Ykblu949gZoQOZ7c2UHba9DhqZ6TgtWpmWMQby7KAKQwsiTWuVi8AlZ61n5VD7ixdJjSxiVleyakl2x88Ul5pvjmdWOBrjycW30dZ4c2bErxfNmQswAAxr6Y4hXlg0y0x/dRJfzBSuABEHbvwIJEn6UTaW6mVCLUJ9tE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=yBAeIlXm; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="yBAeIlXm"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b1b1d128a0so1062865eaf.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 15:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789167547; cv=none;
        d=google.com; s=arc-20260327;
        b=LjKmmoK/rEmM1iS5RsxpzL4+/NByBhMFpPM7uVhImw/c2fH2FF6xyMm/MeP6eyynAL
         EeO73rd/76gPOTkAKVhYVvL2VJg4PgihF20DqRxzvHDOvVtS9G7qd7V4FGBCdZUamL2I
         YXyriIfdkVJWCnrlM/vFJT23AcoK1lfaAGs1v/nzH/9Y8W6nemaZuzYAkf6IlFOsuC0O
         CMMDB5xH1dYCcGGCgGy22Wbc721kU3POJhiUQtIfEK580h8chMmGtB+t3d5ZieIa37ER
         74aOHhL1ey6DRfYqd2IDTMIGy6Rc64LaxVprNdoAmilREShrC6Unjnw7VwJeN8nilQWH
         qYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rPtZVTV8rwITXnpd/xCx6nM5vbsCCP7J3/YTH5KeTk4=;
        fh=CP/raeoBM/gRFYoZxyadlLZgQI/bQwEAfTZZ7DZOj2o=;
        b=HjrOSVdiKFEfNodrwoJEgaq/uvD23yUD5Nbo3eH0kcAnrIoqFqHkoxhRRzIHSY8lo7
         grQVff9NsIun47SvBWFaRaA6TOuZunRU4HtCrizNeLyiy3bDXqmz28ZxdJM4dhE1I9yr
         J+4lZ/jWvl1AfBxPn0LjmO02s0XBBgaAqQsmtjFulpvuakV4nv9wQXgVGp68AEaHGfTj
         KTv1J4TcGItIynpzyrA2Ip+a/ZPEbW4/b25KLd4zyWZPULmLpLMoW92u51/TfjLaOr9S
         e2QY9XOUETjmbVB7Fucming3srz85A4+9daGjByHHnt6LOPyyMlTgJX3sZNS2+xaZS1C
         XGWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789167547; x=1789772347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rPtZVTV8rwITXnpd/xCx6nM5vbsCCP7J3/YTH5KeTk4=;
        b=yBAeIlXml0Axg6pHqwZyANNB2M+pouqAdmh9sY/f9g6QSYnHJbxqd3mz0Ah7UNpxna
         W1ymIvf36cU1ShpyMdupAcTmcD2kEI/O103IbRZ1Kv0djMSKSea2TKsIrhadCaL4djS7
         rtMoxWfmeMcTKZmeOPp2F/d9KgL9leE/mzJpySpZfGm4R0Kxpshglu9Nn1cCTPTN7Odg
         PSyBkI5/bzASjX8hydfop/3zPKtfbKX/W6l7te0iy/m7qL5C/D8mBVqFuMm5Rd6XkzKP
         i6T0bDPaYzAdr8OHXK8f8qGJrtqClr6Xqf4LEy9aDSIPzO72sOVNb3i3uuYnn2QK+Nt5
         5dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789167547; x=1789772347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPtZVTV8rwITXnpd/xCx6nM5vbsCCP7J3/YTH5KeTk4=;
        b=akqp0nUq2N7KEx3FodoNT+RZVy01pF88oOSQKzfYxta1j5rrWyUbWlT6pwYEBHb6oU
         UaOSsxj54wqtpth2sndw05TYJ6UlQ8AQ/JvIGLw41ZvCIcrT1rzJJY2dfbNi7B7Ytymy
         +jYQb5JVKytD0qZcaQjOPmwLJD8AnYFIEa2wH+xWpwcpEpXm4peTwWMNthrLqSHoQOof
         CN+/dricISqUcg1XTzMDx1N1IqFYY6xnL9ze7qcPBECIMqy8QBnhweG036+GptzkUOqz
         Y1FPEnkp4wakX9Z5LZHo+eyE8U0v/ABpL2mhfalWSoeHVeMmrVFFFv7FQ4J37s09Ht5p
         Iwxg==
X-Gm-Message-State: AFuF++lM1uXXimOwmWHsvodFeXGW5NcXJ9RMslD1BK1VPPZhFh6KDbEX
	9izv10D4goJC5x8g1pn+Oie6cFUGVQ9QBdgqXid11E6jecksf9HvDLmXJHDmaV9Sn07Huh7WNlN
	kPlhUiZJ/pPnScSMvt7LhY72FAeRe8SN7Dc1cmE5xDL9i9RCGulMzKbT4Og==
X-Gm-Gg: AYBFou1CA+uqGB6uYGHkj5DtNVN9DZwQW5wZK4ADNZS/IshuANXTHyZOuBOHN/JqbNc
	n+uFKbXJWtMZmCqXJUq7tF7fBC+otrjdrT4GR2VYEAhHVq8eXyBl93PQKukqN3xdr0bc1gMMw5H
	eR5Se4HEKvIMZyJ/D8zMSkYORsXrMcFwPy5BqQiLtoweWgL7tPCjTyQtlyurEZ18fPXUvzZc6hc
	cyT2ZbeDxfeuqlF71DJYOfXeBzc77D+ykry4JnGfXs9fW26uIRkQz9mHinELiVL4JUWAW4H5pUW
	qYEYn/sr0xEYPp+B1FZD/gTMg4i1DmXuJFy3R7P2w3VrZhR2VW1T2bE=
X-Received: by 2002:a05:6820:1625:b0:6b6:f384:9c7f with SMTP id
 006d021491bc7-6bf46bb2facmr6298983eaf.29.1789167547101; Fri, 11 Sep 2026
 15:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260910230506.1631656-1-tyler@tylercipriani.com> <20260910230506.1631656-2-tyler@tylercipriani.com>
 <aqOlx5dlprfc0bdO@pks.im>
In-Reply-To: <aqOlx5dlprfc0bdO@pks.im>
From: Tyler Cipriani <tyler@tylercipriani.com>
Date: Fri, 11 Sep 2026 16:58:55 -0600
X-Gm-Features: AcwNN1VcrxEXWBnU_ONGvZgTQluALKFtqZbSutOwNRcuRERFcyzHaEbkD85Q2IU
Message-ID: <CAHLx=OkhLqR8eQaW9q9W4SgpdtGoCrX4T7CwoGoxaT-fiuEUxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] push: check pushed ref for --force-if-includes
To: ps@pks.im
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, 
	Stefan Haller <lists@haller-berlin.de>, "D . Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:55=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Thu, Sep 10, 2026 at 05:05:05PM -0600, Tyler Cipriani wrote:
> > "--force-if-includes" ensures, "tip of the remote-tracking ref is
> > reachable from one of the 'reflog' entries of the local branch."
> >
> > But check_if_includes_upstream() uses the local per-branch reflog based
> > on the destination branch rather than the branch being pushed; using
> > ref->name vs. ref->peer_ref->name.
>
> So... in a `git push origin foo:bar` we look up the reflog for "bar" and
> not "foo"?

Exactly.

> > This can cause confusing rejections or unintended data loss.
> >
> > Using a command like:
> >
> >     git push --force-if-includes --force-with-lease origin src:main
> >
> > False rejections: when src is an up-to-date branch, but main is
> > out-of-date or nonexistent, then the includes check will fail telling
> > users the remote ref has been updated since the last checkout.
>
> Hm. "up-to-date branch" in relation to what? You mean if we had commits
> A, B and C, with C being the most recent commit, then "src" points to C
> and "main" points to B?

You got it. It should read something like: "False rejections: when src
is up-to-date with the tip of the remote ref, but..." etc.

I can clarify in a v4.

> > Data loss: when src is an orphan/out-dated branch, but main is
> > up-to-date, then the if-includes check will allow the push, clobbering
> > the remote main.
>
> Right, here "src" would point to B and "main" would point to C.
>
> > Find local reflog using ref->peer_ref. When using a refspec like
> > HEAD:refs/heads/main, we resolve HEAD. If HEAD is a branch, use that
> > branch's reflog.
> >
> > But if HEAD does not resolve to a branch (i.e. a detached HEAD), then w=
e
> > reject the push. HEAD's reflog is too broad to tell us if the history
> > being pushed includes the tip of the remote. Rejecting a detached HEAD
> > already happens today (if the same-named local branch lacks the remote
> > tip); now the detached HEAD state is explicitly rejected.
>
> Makes sense.
>
> > Skip deletions:
> >
> >     git push --force-if-includes --force-with-lease origin :main
> >
> > ref->deletion is set after apply_push_cas (which triggers
> > check_if_includes_upstream). The ref->peer_ref name is "(delete)".
> > Instead check with is_null_oid to detect and allow deletion.
>
> This part feels a bit off to me. Deletions are the most risky operation
> that we can do, so why would we want to just blindly allow them? There
> may be good reasons for this, but if so those should be documented as
> part of the commit message. It would probably even be sufficient to say
> "it has worked this way before, and we don't want to break that case".

For deletions, there's no history on our side to check. Also, there
was an existing test case that ensured deletions were allowed. I took
that as intent and opted to keep that behavior. I'll clarify in the
commit.

> > diff --git a/remote.c b/remote.c
> > index 00723b385e..326af76eeb 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -2806,7 +2806,29 @@ static int is_reachable_in_reflog(const char *lo=
cal, const struct ref *remote)
> >   */
> >  static void check_if_includes_upstream(struct ref *remote)
> >  {
> > -     struct ref *local =3D get_local_ref(remote->name);
> > +     struct ref *local;
> > +     const char *name;
> > +     int flag;
> > +
> > +     if (!remote->peer_ref)
> > +             return;
> > +
> > +     /* A deletion has no local history to check against. */
> > +     if (is_null_oid(&remote->peer_ref->new_oid))
> > +             return;
> > +
> > +     name =3D remote->peer_ref->name;
> > +     if (!strcmp(name, "HEAD")) {
> > +             name =3D refs_resolve_ref_unsafe(get_main_ref_store(the_r=
epository),
> > +                                            "HEAD", 0, NULL, &flag);
>
> Shouldn't we pass `RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE` here?
> Otherwise, the function will return "HEAD" even if it could not be
> resolved, and we don't want to recursively resolve symrefs, either.

RESOLVE_REF_READING: agreed. Will add.
RESOLVE_REF_NO_RECURSE: For the current (v3) state that only looks at
"HEAD" that makes sense. But I'd expect --force-if-includes to
resolve, e.g., STABLE -> HEAD -> refs/heads/main -- that is, to
recurse through multiple symlinks. Otherwise, we'd reject a push we
could verify.

> Also, is it sufficient to single out "HEAD" here? It could for example
> be that the user passes "HEAD~", an object ID or really any other
> revision, and these should probably not be considered reachable, either,
> right?

Oooh, great catch! Folks could put in tags or specific oids, none of
which have a reflog to check. These are rejected in v3, but only by
happenstance since they lack a reflog (and with bad advice about
running "git pull").

> Maybe we should instead verify whether this names a local reference and,
> if so, resolve potential symrefs to their target.

Yes, that makes sense. Resolve symrefs to the target branch, then
check the branch's reflog.

I'll try that in v4.

This comment left me spiraling for a bit about tags. Like: you can
push tags and a tag and a branch might point to the same commit. BUT
tags don't have reflogs, so I think it makes sense to reject those as
unverifiable here, too.

> > diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> > index cba26a872d..0c02151747 100755
> > --- a/t/t5533-push-cas.sh
> > +++ b/t/t5533-push-cas.sh
> > @@ -396,4 +396,69 @@ test_expect_success '"--force-if-includes" should =
allow deletes' '
> >       )
> >  '
> >
> > +test_expect_success '"--force-if-includes" should allow forced update =
when using differently named branches' '
> > +     setup_src_dup_dst &&
> > +     test_when_finished "rm -fr dst src dup" &&
> > +     (
> > +             cd src &&
> > +             git fetch &&
> > +             git switch -c newbranch origin/main &&
> > +             git rebase HEAD --onto HEAD^ &&
> > +             git push --force-if-includes --force-with-lease origin ne=
wbranch:main
> > +     )
> > +'
>
> Nit: missing empty line between these two tests.

Ack.

> Patrick

Thanks for the review!
