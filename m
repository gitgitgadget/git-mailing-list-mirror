Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2041F453
	for <e@80x24.org>; Fri,  9 Nov 2018 20:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeKJGdC (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 01:33:02 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34356 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJGdC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 01:33:02 -0500
Received: by mail-ed1-f68.google.com with SMTP id w19-v6so2830153eds.1
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 12:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C0BLZ2e/XdB7ncNlLBqG4sesPumocJgKke3TGaAqus4=;
        b=m8T7PpfoB4psawMEk28HADCfUY9uOHFcvd5o/en/WEhLSISZAuWzVpVDzY450ZZmRo
         ECyEk1uNe5LKj4t8bfKw/hOnQsDqBX0K2evhnmci+gNhYCCJM2tsClfan+yxc5U0O6lh
         eTbCFCURAT4TrX8hojqTrasxs92frshvJ5tUT8oLRCaJeVhYBRn+iRed0oJAtObrzyMJ
         DmQXutVQdTzdAT0oMwQsALUpwisedHQn9pfdcAI4BXxTyDRbGO3kD3zfWZwlSKsk0Xb8
         1scFVS/xiPdgHYz5dH9moTnBYVz9D5mX1epTF22556a/0NtcQr56G9JxFyDQqTxdjUTZ
         RFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C0BLZ2e/XdB7ncNlLBqG4sesPumocJgKke3TGaAqus4=;
        b=f7Xdnm3SXfEw5ynclqAKLWP4bXpmMS2PGIawOb6WLmmO2eK6YEtgg9wPyAtsxMo7E6
         +ksf9WV7BJsYQGke2014A9SaUzeu5wCiNUwH9IOiMg+xObZN37pjmBykpzoK2w/ESvKj
         qeSWf1aCoQEBRZkqiHDk8/iARmFkhqV0ddg2fKUVZZpjga/QbfJqTVPElcr+iI+1keVq
         OoZgu7xaVTHHD1yO4TVbFKfW8Gzm6z1ntLcceO08uV5QcsgU3k0nNCjf//geXWm0HEul
         K6i5T3d9k4Kc9QJwknKhJF2TGqIeyPZzRT4fKp210KowUy9dyZ464Q6FXnrJZ+/TSEEv
         4NOw==
X-Gm-Message-State: AGRZ1gL0bXtD44ODZckFbi2KhlJUuieeY3I3vC8YS/TIDqzhMberJvfU
        r/3l8EITpSOoBwhjbSq9jXiCgKW8o7nP7XMvOWsvaw==
X-Google-Smtp-Source: AJdET5c8YTk0Asx78FRSfJ197ByF5a9kNUV6+qNFxnI/pff6QWIawl4STiMAZA6CLizKUaCBuYvEYWpNtb87ZH95FEo=
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17-v6mr2844048ejb.70.1541796644462;
 Fri, 09 Nov 2018 12:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20181030220817.61691-2-sbeller@google.com> <20181108205255.193402-1-sbeller@google.com>
 <CAN0heSrF7zU=5NGHD9AUcRZgGHoCmrbBwYqJ-6YUM4xg3r+8Rg@mail.gmail.com>
In-Reply-To: <CAN0heSrF7zU=5NGHD9AUcRZgGHoCmrbBwYqJ-6YUM4xg3r+8Rg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Nov 2018 12:50:33 -0800
Message-ID: <CAGZ79kZRYNjjevWqra2e72rUM3Lu9y1tEL5dDGBLhPKe1o_bGA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: add pending semantic patches
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 8, 2018 at 8:56 PM Martin =C3=85gren <martin.agren@gmail.com> w=
rote:
> I haven't followed the original discussion too carefully, so I'll read
> this like someone new to the topic probably would.

Thanks!

> A nit, perhaps, but I was genuinely confused at first. The subject is
> "Makefile: add pending semantic patches", but this patch doesn't add
> any. It adds Makefile-support for such patches though, and it defines
> the entire concept of pending semantic patches. How about "coccicheck:
> introduce 'pending' semantic patches"?
>
> > Add a description and place on how to use coccinelle for large refactor=
ings
> > that happen only once.
>
> A bit confused about "and place". Based on my understanding from reading
> the remainder of this patch, maybe:
>
>   Teach `make coccicheck` to avoid patches named "*.pending.cocci" and
>   handle them separately in a new `make coccicheck-pending` instead.
>   This means that we can separate "critical" patches from "FYI" patches.
>   The former target can continue causing Travis to fail its static
>   analysis job, while the latter can let us keep an eye on ongoing
>   (pending) transitions without them causing too much fallout.
>
>   Document the intended use-cases and processes around these two
>   targets.

Both suggested title and new commit message make sense.

>
> >  This directory provides examples of Coccinelle (http://coccinelle.lip6=
.fr/)
> >  semantic patches that might be useful to developers.
> > +
> > +There are two types of semantic patches:
> > +
> > + * Using the semantic transformation to check for bad patterns in the =
code;
> > +   This is what the original target 'make coccicheck' is designed to d=
o and
>
> Is it relevant that this was the "original" target? (Genuine question.)

No. I can omit that part.

>
> > +   it is expected that any resulting patch indicates a regression.
> > +   The patches resulting from 'make coccicheck' are small and infreque=
nt,
> > +   so once they are found, they can be sent to the mailing list as per=
 usual.
> > +
> > +   Example for introducing new patterns:
> > +   67947c34ae (convert "hashcmp() !=3D 0" to "!hasheq()", 2018-08-28)
> > +   b84c783882 (fsck: s/++i > 1/i++/, 2018-10-24)
> > +
> > +   Example of fixes using this approach:
> > +   248f66ed8e (run-command: use strbuf_addstr() for adding a string to
> > +               a strbuf, 2018-03-25)
> > +   f919ffebed (Use MOVE_ARRAY, 2018-01-22)
> > +
> > +   These types of semantic patches are usually part of testing, c.f.
> > +   0860a7641b (travis-ci: fail if Coccinelle static analysis found som=
ething
> > +               to transform, 2018-07-23)
>
> Very nicely described, nice with the examples to quickly give a feeling
> about how/when to use this.

Thanks.


>
> > + * Using semantic transformations in large scale refactorings througho=
ut
> > +   the code base.
> > +
> > +   When applying the semantic patch into a real patch, sending it to t=
he
> > +   mailing list in the usual way, such a patch would be expected to ha=
ve a
> > +   lot of textual and semantic conflicts as such large scale refactori=
ngs
> > +   change function signatures that are used widely in the code base.
> > +   A textual conflict would arise if surrounding code near any call of=
 such
> > +   function changes. A semantic conflict arises when other patch serie=
s in
> > +   flight introduce calls to such functions.
>
> OK, I'm with you.
>
> > +   So to aid these large scale refactorings, semantic patches can be u=
sed,
> > +   using the process as follows:
> > +
> > +   1) Figure out what kind of large scale refactoring we need
> > +      -> This is usually done by another unrelated series.
>
> "This"? The figuring out, or the refactoring? Also, "unrelated"?

The need and type of what kind of large scale refactoring are
usually determined by a patch series, that is not refactoring for the
sake of refactoring, but it wants to achieve a specific goal, unrelated
to large refactorings per se.

The large refactoring is just another tool that a developer can use
to make their original series happen much faster.

So "unrelated" =3D=3D "not the large scale refactoring, as that may
come as an preparatory series, but to have a preparatory series
it may be good to showcase why we need the preparatory series"

>
> > +   2) Create the sematic patch needed for the large scale refactoring
>
> s/sematic/semantic/

yup.

>
> > +      and store it in contrib/coccinelle/*.pending.cocci
> > +      -> The suffix containing 'pending' is important to differentiate
> > +      this case from the other use case of checking for bad patterns.
>
> Good.
>
> > +   3) Apply the semantic patch only partially, where needed for the pa=
tch series
> > +      that motivates the large scale refactoring and then build that s=
eries
> > +      on top of it.
> > +      By applying the semantic patch only partially where needed, the =
series
> > +      is less likely to conflict with other series in flight.
> > +      To make it possible to apply the semantic patch partially, there=
 needs
> > +      to be mechanism for backwards compatibility to keep those places=
 working
> > +      where the semantic patch is not applied. This can be done via a
> > +      wrapper function that has the exact name and signature as the fu=
nction
> > +      to be changed.
> > +
> > +   4) Send the series as usual, including only the needed parts of the
> > +      large scale refactoring
>
> Trailing period.

ok.

> OK, I think I get it, but I wonder if this might not work equally well
> or better under certain circumstances:
>
>   - introduce new API

The  "new API" is similar enough to the old API and may even be
a superset.

>   - add pending semantic patch
>   - convert quiet areas to use the new API
>
> On the other hand, listing all possible flows might be needlessly
> limiting. I guess it boils down to this:
>
> "Create a pending semantic patch. Make sure the old way of doing things
> still works. Apply the semantic patch to the quieter areas of the
> codebase. If in doubt, convert fewer places in the original series --
> remaining spots can always be converted at a later time."

That's the gist of it. :)

Thanks for the review,
Stefan
