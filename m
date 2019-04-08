Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0C720248
	for <e@80x24.org>; Mon,  8 Apr 2019 06:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfDHGki (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 02:40:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35002 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHGki (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 02:40:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id s39so10601138edb.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 23:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSxq3p7URqD48kGOTMxpzjWi92cf4ANV4G1UY1JwOI0=;
        b=Pm0B9O66vSPhcTWDb3Dys6QGQGC9kK+elUNWCgJ8kghmWc+g1fDfX6dx5pQS3VrMUd
         Y2PusvvN+Ly/Vn6SFMBFhE86vD4vsD/IScXSJzESx7OFBmyUY9e6CpficfzhbaDP218f
         bs5OGTWjCYCQhPGbxAuvPDHcMqwm13Egc/o1Kfgr0nNs1BuYd9otVqkkuJFIc5jMrqAO
         9EgBsdWO13KJEDRXtZEsxiAzB5KwTQbpk9igsbROGHrdF4Xfsc56saJrloPIrV7SRpP9
         pjIZmcqLPLlxd9rwdrid5Ry4KVPd1Z2DJszvdG3o9UgjBqty1YweShk0Sy7uLjSiub08
         jV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSxq3p7URqD48kGOTMxpzjWi92cf4ANV4G1UY1JwOI0=;
        b=VxrNz3G99QdiUVDgcAUN9udyUJi7fs3pGxB3jTREpKYrxhz8A/lE1hUTmTg3aG+xSO
         DUzlrI3x7GBJhKv0WQYoG+dk6ktnXw9diy32t/LZs15S81preaSY9nza9Z3YmlGcegwX
         BbUlG8bRIY5bl18tMkpkcFJ+pWhnePW+R75fQlz5ojr5R3cawYmV2jHRWYxlJuGmRr+I
         JLzal/difuhynE/bQcGQzuke5hfk4XaaoLAfNfbhUSXxMNh522KEOIRzSFOzz1uHZwRw
         OSq1mJN9b9fYbHZhQQykxNjb5wPkXbLr8OFkOWPeEfJWY/fYx95u6nelMLyZRWGrh2RA
         VCjA==
X-Gm-Message-State: APjAAAUsya7tUTB44HG2Jige2McPLM88ZNaJ4syNsvU04VlCNTip+6/P
        xnnIHvQqe0MSzBe76ZVoldiIkVebuFgbojwdgLU=
X-Google-Smtp-Source: APXvYqwlcPLZvpT7b8SNTPLhqoI1sVc3ibdNG0KpL/72jBWOT+GRXFBtQAMS/4RL/FkUi6+JaFeHnxlprIdJiSOrydo=
X-Received: by 2002:a17:906:d503:: with SMTP id ge3mr15552044ejb.2.1554705636825;
 Sun, 07 Apr 2019 23:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190326220906.111879-1-jonathantanmy@google.com>
 <cover.1553895166.git.jonathantanmy@google.com> <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
 <20190404024710.GO32732@szeder.dev> <nycvar.QRO.7.76.6.1904051528130.41@tvgsbejvaqbjf.bet>
 <CAP8UFD1qK61MtJ-XeMuwY4W2V0CdHeZQC9rQap1M+nEeaLmBJQ@mail.gmail.com> <xmqqy34lb4vb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy34lb4vb.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 Apr 2019 08:40:23 +0200
Message-ID: <CAP8UFD0gmaZzfK7taS=1hj=sCEpLFt_Az60TxYeUqp2A7r25JQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] diff: batch fetching of missing blobs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 4:36 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >  #ifdef NO_FAST_WORKING_DIRECTORY
> >  #define FAST_WORKING_DIRECTORY 0
> > @@ -6489,7 +6490,7 @@ static void add_if_missing(struct oid_array *to_fetch,
> >
> >  void diffcore_std(struct diff_options *options)
> >  {
> > -    if (repository_format_partial_clone) {
> > +    if (has_promisor_remote()) {
>
> Hmph, I see quite a few references to the variable disappears
> between next and pu.  Is it that in the new world order, nobody
> outside the low-level object-access layer should look at the
> variable directly, but instead ask the has_promisor_remote()
> function?

Yeah, repository_format_partial_clone contains the remote configured
in extensions.partialclone, while in the new world order there can be
other promisor remotes than this one, and most of the code is only
interested in asking if we use any promisor remote.

> If so, can we at least document that?  Making it static
> (or at least renaming it) would have helped the compiler to notice
> this semantic merge conflict better.

Ok, I will see if I can make it static (or maybe rename it).

Patch 3f82acbca2 (Use promisor_remote_get_direct() and
has_promisor_remote(), 2019-04-01) in cc/multi-promisor starts with:

    Use promisor_remote_get_direct() and has_promisor_remote()

    Instead of using the repository_format_partial_clone global
    and fetch_objects() directly, let's use has_promisor_remote()
    and promisor_remote_get_direct().

    This way all the configured promisor remotes will be taken
    into account, not only the one specified by
    extensions.partialClone.

I will at least add something telling that in most cases
"repository_format_partial_clone" and fetch_objects() shouldn't be
used directly anymore.

> > @@ -6506,8 +6507,7 @@ void diffcore_std(struct diff_options *options)
> >              /*
> >               * NEEDSWORK: Consider deduplicating the OIDs sent.
> >               */
> > -            fetch_objects(repository_format_partial_clone,
> > -                      to_fetch.oid, to_fetch.nr);
> > +            promisor_remote_get_direct(to_fetch.oid, to_fetch.nr);
>
> Likewise between fetch_objects() and promisor_remote_get_direct().
> Shouldn't the underlying fetch_objects be hidden from general
> callers?

I will see if I can do that, though it has to be used in promisor-remote.c.
