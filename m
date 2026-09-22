Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A0A548570
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081041; cv=pass; b=m1HQnobJ8ni6tJejgct7s/DSg4DaRxoMpDwNO4MwQhp0E4KCZRSboPeJlcTqvREW9njcwHFl9b+LBOxvD5E5Z2Kbg4CrX09NAMF7A2kfU0nsTO+sw47NsVRFJp9PMYDtdk6XpG42zkZayDnuJGLN/y7c7CTA9wjd0n9Sv4xNjfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081041; c=relaxed/simple;
	bh=KGTeTXlPI0In6sqzhNoRCjInj6rvjSjs7iThi0OZcD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5a/RxxfbQECBVm9N00VSGsyNiZP9vdTdaZEun/DZHGKpfGmKpR8FKbpsfCg3QUyDi9M044sJmehn5FzBQ88JNKvuqBdM7zAqoCml/oh8Ax+vdLmGDv/M+SZ9sypOrrHFZDAFstzhXpWxCjFYgv8SNe5MTY/gKR8j7Kyo1DOo8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdniB+OD; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdniB+OD"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f7so28066115ad.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 05:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790081039; cv=none;
        d=google.com; s=arc-20260327;
        b=MqRhKiYW2ngCv9mKbo0hD7baBsWkKng5bd0JyCwKYIf5S2WX7ayoq+/5HOz0Q5T0f3
         HM2dA72uexZ/sqB8zZHQlWRteKzYepC5ULllzGyqALSJDDAtgPpYqXOvIEjb4iqAVtn2
         6i9dkTE0py+UKVR0LcJF25TUPCnx8WjzaVhlNjcPSvYRHn9nnrA58DdI/wlxe61oXuhW
         Y9z02W3IX7FQ8XEgS1IYO6D4wuBtoUoDcqRZJjQxIT0rJjo6IE44sUFKtk4gIayxOWZd
         CodRG0KqC24RtFaERflFLUd/A5zCyxkt87ISrtESWcSagM+lON/FRrJE79ybzKlZQHRt
         hGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=slvyjc2CKKio0fPxeO+5Vbe4l9mOTNZR6ZYDLwKUM20=;
        fh=JwKIycEK1A425YJY8qLMxO6Yc11i7Y5uCpj/+wYJcqw=;
        b=mCgMCt1h6Yc3slMLfJMGbwvxbPxOKVOY1VZIKGInYmOfpRoZWeoBo42CTfVlCzNtPq
         RvRGczAM39HbBSvSj0k3E1wiJg+IZpOJBf6jUUVEJdoBJPwgqRFupsR/jE+CzVA4tmfT
         zEa3tiCY7ISOrKqE2K0zkzuj8Fm4TXlv+Vmo7Eo6aNpvfoWO3M8PQ7DE6JRjcOoUmyYu
         i85Lw4ZZ31pGD8ojaHf1Zbz0Hg7Z07Ts6JAQsKeL8doGghrsY9EdMEoxv+p7GU0RvA5t
         J48tKJtub3eW0WM/wFF+qysbeI6nEII8TCa0fJKbAPQn58/WbKyyQtcTX6EaDAWamtDH
         lZRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790081039; x=1790685839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=slvyjc2CKKio0fPxeO+5Vbe4l9mOTNZR6ZYDLwKUM20=;
        b=OdniB+ODzsaMExvwh30JFNhKSdkG2QBF3ghepy5+pYMQleYzvSaJfXmtwxwylEsuDn
         2X4sudUjA9sQdyFDNfFICCuUW2BBmRFMoBsu2819h2h4kqmGi45bI22+xrpApx7HzPhm
         x3rh2p3sZb57qyMAlnX6/mMCkb/49PHBBycU2MMtwFinqiTrjWbBsNCPAR29t7OvGpds
         WWHqS6kVI1LR9zAxsF1WIk89WKVqQ5hNYssklPjowzwkK6vDIXAG4GBEB8NyvKlYtl+y
         xwXQhcXOhH1RaKAMB/oa2IooqVPcCqRWofJBuTzJHVEXaNJRPldFx2OaUXV3lCmxrYMK
         J3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081039; x=1790685839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slvyjc2CKKio0fPxeO+5Vbe4l9mOTNZR6ZYDLwKUM20=;
        b=WVu+Mx47NsfgSw2dnucxjhzWSAqZpQXk8J7J/DyCdC1rS1zw0OXRw9Da8OQOsl3Z/0
         mVflSQCGYQjrGAqgKcVjMuJ8TDIMI7pZgJ113m+0hH7Q3yiSQyH4LHQNNkJ1Q6sTJDaF
         4nSbrk81cxQuKFlMI2CUYGNeugqHZpMwOwO4PxScxP1GYUBsXLx/McIFJ0LLMufZZbuK
         DmHBPZ5pxk29tLdLZXiZwVasqrrfxWS7so98k1SLHvg4RchIB5zH7Y3dPw3RpjVEzb2H
         plfbwvSXypry9aWv8nhDeb3qEBFN9edpqOHaMHhSxFN6n46MruxDxgBND2gD668OrVj1
         m1Dg==
X-Gm-Message-State: AFuF++l6P6GPWr85JURkVrJsHz7VSPB2qvsSIjRReFL1zQ7AtXNGLrKy
	MCCNFYJdVBgFdaEj/x1K0WuQsSfpQnP/Yyc5hslJtNBhYFPTLCPKdnYNOu8mgnoonsfONd/etFg
	mdTnpuAzG47lSVOSoW33u421mTrEqHsg=
X-Gm-Gg: AYBFou0sINE/v7GjSr4dk183ZF9bbtCckbKnbRNGeIVYhuBKDDu+snVHhkZbu45OxfQ
	pM0pnDQeqGNWOLsZGb/fnYqOnMEfGibuUuxUSarAJbDwQL9UOR8cr8o3vVF7/auklIZZWeADpcG
	yOf47yysrXleGebLmip6pOlpLIAvejEoLOKilCq8eGGyvvEHhPtr0sHKOKl5RAyxNQnhlxcRmCb
	MetFiztOtaYLP9IT2rCWptU3o5m6RwXOEZJBxW2ineUfvt3dOnC4We43mytgEc3e2jmso2EGjC9
	mozAFeL4BA2uSCGlA1K2IzNvAf5NrxD3pO34yjj4YQOU5ahwGI6tn9/7H9syScIcOhSfADCLDyA
	+HYRM+sCFA8Z0hovoplGpG0X0hDZ8CLohFiRxe+YRbFTDRGUfcIgoEvAi844OZfr7jQrLugAPFu
	8SdBOXZJ6A
X-Received: by 2002:a17:902:ec81:b0:2dd:c0ff:e723 with SMTP id
 d9443c01a7336-2df60b66f9fmr13170205ad.53.1790081038707; Tue, 22 Sep 2026
 05:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789853192.git.ben.knoble@gmail.com> <782fe91251111fbb28359574d860e4a6d2e45fc0.1789853192.git.ben.knoble@gmail.com>
 <2551b801-4cb3-4880-ac01-7d14a188ddd4@gmail.com>
In-Reply-To: <2551b801-4cb3-4880-ac01-7d14a188ddd4@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 22 Sep 2026 08:43:46 -0400
X-Gm-Features: AcwNN1XNvhDbSi2Ydb8ssYYRNpiDBT9qbae8rNaC1ujuY-VqSlr528zb5eoytI8
Message-ID: <CALnO6CDG4Emny7xESxN8GObaXb_P9gPHBZ857hrAvDjiMSqsKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/stash: merge index in-core
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, Taylor Blau <me@ttaylorr.com>, 
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>, Adam Johnson <me@adamj.eu>, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Victoria Dye <vdye@github.com>, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 9:17=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ben
>
> On 19/09/2026 22:26, D. Ben Knoble wrote:
> > Fortunately, we can achieve 2 goals at once: avoid round-tripping to th=
e
> > file-system (and invoking expensive subprocesses) by performing the
> > merge in-core. Since the results are never seen, we don't need to set
> > the usual branch and ancestor labels.
>
> When the merge succeeds without conflicts we use the result so it is
> seen. It would be clearer to say that "If there are conflicts we discard
> the result so ...". The rest of the commit message explains the problem
> nicely.

Indeed. This is what I get for (unusually) dashing off the commit
message up against the clock. Thanks!

> > @@ -669,29 +625,25 @@ static enum stash_apply_result do_apply_stash(con=
st char *prefix,
> >                   oideq(&c_tree, &info->i_tree)) {
> >                       has_index =3D 0;
> >               } else {
> > -                     struct strbuf out =3D STRBUF_INIT;
> > +                     struct merge_result result =3D { 0 };
> >
> > -                     if (diff_tree_binary(&out, &info->w_commit)) {
> > -                             strbuf_release(&out);
> > -                             return error(_("could not generate diff %=
s^!."),
> > -                                          oid_to_hex(&info->w_commit))=
;
> > -                     }
> > +                     init_basic_merge_options(&o, the_repository);
>
> This means we potentially use different diff algorithms when merging the
> index and when merging the work tree, let's use the _ui variant here
> instead.

Yep, you know I'd spotted that and wasn't expecting it to make a
meaningful difference. It's an easy swap, but I thought that (like
above, since we don't show the conflict results) the diff algorithm
wouldn't matter too much.

Maybe it affects the actual merge-ability, though, in which case I
agree using the same is important?

> > +                     o.verbosity =3D 0;
>
> Looking at the code in merge-ort.c it appears the verbosity option was
> used by the recursive strategy but isn't used anymore so I think we
> could drop this.

Intriguing. (Assuming the default "2") There's a "< 5" check in
path_msg() that wouldn't be affected by dropping this, and a "> 2"
check in checkout() that=E2=80=A6 also wouldn't be affected?

But it might matter if something is setting the verbosity elsewhere
(config, GIT_MERGE_VERBOSITY), and I think we really want this merge
to be quiet? I seem to remember reading commits in this area quieting
"git reset" and so on to keep the noise down.

So I'm inclined to leave it for now, especially in case it later does get u=
sed.

> > +                     oidcpy(&index_tree, &result.tree->object.oid);
> > +                     clear_merge_options(&o);
>
> Looking at replay.c:replay_revisions() I think this should be
>
> merge_finalize(&opts, &result);

Hm, possibly. It does look like that does more with the "result,"
which is probably needed. But it doesn't actually clear the merge
options.

On one hand, I thought it could be important not to reuse that struct
between merges. But if we do use the "ui" init, it might be ok?
replay_revisions() does use the same struct between calls to
merge_incore_nonrecursive().

Oh, but one other thing: we unconditionally reinit the merge options
later on in do_apply_stash(). We could conditionally initialize there
("if (has_index)"), I suppose?

> > diff --git a/merge-ort.c b/merge-ort.c
> > index c410a5d353..f69a49d48a 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -5035,8 +5035,6 @@ static void merge_start(struct merge_options *opt=
, struct merge_result *result)
> >       trace2_region_enter("merge", "sanity checks", opt->repo);
> >       assert(opt->repo);
> >
> > -     assert(opt->branch1 && opt->branch2);
>
> This, and the hunk below, make me nervous. Normally assertions like this
> exist because the pointers are unconditionally dereferenced later on.
> Looking at merge_3way() it asserts opt->ancestor is non-NULL and
> dereferences all three labels. t3903 does not appear to have test
> coverage for the index merge failing (if it did I think we'd see a
> SIGSEV), we should probably add a test that checks the command fails
> leaving the index and work tree untouched, and verifies the message on
> stderr.
>
> Lets set some simple, fixed, ancestor and branch names in
> do_apply_stash() above.

Funny, I was getting aborts before removing the asserts because I
hadn't set the labels, aha. Looks like we've come back around to
keeping the labels. I'll probably keep a similar structure as the
working tree merge uses, I think.

A fail-to-merge test also seems like a good idea. Let me mull on that.

Thanks for the review.

--=20
D. Ben Knoble
