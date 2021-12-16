Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5251C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 09:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhLPJrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 04:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbhLPJqU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 04:46:20 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5C9C06175C
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 01:46:17 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id v203so63098299ybe.6
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 01:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pAMFgUwavb/f6BbP50O+83MeFMHA4ItdpntddKn86Po=;
        b=XKfy8nq1Xg7Sh4f+qgLavbseFsRLV05ImTbvNBL7aeH5md1UEy/uY+7cAre6fEYioi
         zizLwUVkyN86htYmOdeautB+IVG+aekdB3OsAW36U1xJmZCC/dwlN7PSBDqqa+v1VBF9
         kgRduLZnCksmqVlB7ux5KwY6++1w5VjYHZwyAvfyBxzq891wuFemG6+ae1lIRIMxs0FY
         +4crdKMYYjkM3vDKW1qMvgus81ROO/VDBig1lu+rdLf9VjaEdlJ69HqVVWnGtkbGwrBB
         UvNVF+gQRqb4o3iUEZVrbu5F+k5jpWZkV2dcWllDj5dA6Ymk3sCJPhmwiCXrrwfb+bwf
         wFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pAMFgUwavb/f6BbP50O+83MeFMHA4ItdpntddKn86Po=;
        b=PnX5yGtn2itWNJTIlROjMBAIFiySUqVYhYc+T5rCoRPJarHe2TXonTEEL7cVZjJtd3
         WJxfilXH2L/jv8fdkd/rI5XkAjxY/pwwBEr2Xa7WSjsXoDeOJ2p3CZAvdOX0E/QCllsY
         TO9kFEzPm/7SIfD+8ovwXTj7ou4fU0W1i1BZ7h5AFWJAX7oll0sAWvKM8CWXdWXQVZv4
         X1l7wy4MwD85/Qab5wPy+YjcTpryuQ9I5xqxhcTjkqrDLAdGAEpPXRAFS1LhuVQHUE/8
         QB8j+lSYSZ0epBvhyIsa92asz28In8JGcQnjwGiFa3z40dam9baqfASA/XTq/uEHRkuf
         SsMg==
X-Gm-Message-State: AOAM532RcnTso51DEwi9s0SSk502+FQKweLFEVCXxawWeLa1uLZzZj2z
        Cq9G0UY5OO+Xk07WM7RhSCEbz5grqsbohsHmyvgnCoOCh9I=
X-Google-Smtp-Source: ABdhPJwFFN6Fj/Zp0T/CjL+sSpfTPvPMKdzlc34Ogr0sX+ozfJzPQBByewfI3CS2g2pgTqu18bSBlqC2gpX3bAbHFSE=
X-Received: by 2002:a25:d248:: with SMTP id j69mr11995575ybg.693.1639647976256;
 Thu, 16 Dec 2021 01:46:16 -0800 (PST)
MIME-Version: 1.0
References: <YboaAe4LWySOoAe7@coredump.intra.peff.net> <YbohRy22vBuDZsG4@nand.local>
In-Reply-To: <YbohRy22vBuDZsG4@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 16 Dec 2021 10:46:05 +0100
Message-ID: <CAP8UFD2pL3V2ty_TGiXkbDMG5YMUA815K=pW4zopGf57yiTheA@mail.gmail.com>
Subject: Re: taking a break from Git
To:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 15, 2021 at 6:09 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Dec 15, 2021 at 11:38:25AM -0500, Jeff King wrote:
> > Hey all,
> >
> > I'm going to be offline and completely absent from the mailing list for
> > five months starting at the end of December. After that, things are up
> > in the air, but I may not be as involved in the project as I have been.
> >
> > Sorry, there's no juicy gossip or drama to share. I still like everyone=
,
> > and think it's a cool project. ;) After 15 years, it just feels like
> > it's time for a break and to perhaps apply my brain to something else
> > for a while.
>
> I am going to miss seeing patches and review from you tremendously.

Yeah, you will be missed a lot Peff!

[...]

> I am a better programmer and Git contributor directly because of Peff's
> efforts. I am sure that anybody who has been fortunate enough to get
> review or advice from Peff feels the same as I do.

Yeah, I feel the same too.

> > There are a couple logistical things related to this:
> >
> >   - I'm planning to step down from Git's Project Leadership Committee
> >     (the entity that represents Git within Software Freedom Conservancy=
,
> >     and which occasionally makes decisions on things like our project
> >     funds or assets like the trademark).
> >
> >     That leaves Junio, =C3=86var, and Christian on the PLC, and the cha=
rter
> >     calls for having at least 3 members. So I don't technically need to
> >     be replaced, but maybe it's an opportunity for somebody else to get
> >     involved.
> >
> >     We don't have a formal process here. The last discussion on adding
> >     new members was this thread from a few years ago:
> >
> >       https://lore.kernel.org/git/20180816224138.GA15490@sigill.intra.p=
eff.net/
>
> I would be honored to serve on the PLC if that is something others would
> be in favor of, too. I can talk a little bit about my background and
> thoughts here in a separate thread from this one.

I am in favor of you serving on the PLC and I would appreciate it if
others would nominate themself or others either publicly or privately
by emailing git@sfconservancy.org. I think it's a good idea to open
this up every few years.

> >   - I maintain the git-scm.com site (well, insofar as anybody does).
> >     There are a few regulars who review and merge pull requests at
> >     https://github.com/git/git-scm.com, but more help is always welcome
> >     there.
> >
> >     The production parts of the site run on Heroku and Cloudflare. They
> >     don't need touched often, though we do trigger a manual update and
> >     flush the caches right after Junio releases, so that the site is
> >     updated immediately.  The Git PLC has the necessary credentials for
> >     those sites, though in practice I think I'm the only one there that
> >     touched it. Taylor (cc'd) has been helping out with that and also
> >     has access.
>
> Yes, I have credentials to our Heroku and Cloudfare accounts, and (I
> believe) write access to the git-scm.com repository on GitHub. So I can
> help do some light triage there, and at least prevent the site from
> bit-rotting.
>
> I've been doing the post-release manual update and cache purging as part
> of my usual release routine for the past several releases, so I don't
> mind continuing to do that, either.

Thanks for doing this!

> >   - I really am going to stop reading the list. Even if you cc me. So
> >     please don't get mad if I don't review your patches, or respond to
> >     bug reports. :)
>
> Please do ;). Enjoy your well deserved time off, and thank you.

Yeah, thanks!
