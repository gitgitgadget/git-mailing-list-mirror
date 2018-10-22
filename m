Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E691F453
	for <e@80x24.org>; Mon, 22 Oct 2018 18:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeJWDOC (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 23:14:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46386 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbeJWDOC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 23:14:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so2485493edq.13
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 11:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yqZHB5Usu4IZ7ZWk5hQ0vnLAwoEP2DpWSc1lqFaIC1c=;
        b=gyxsAq1AGnWW31AddGUvsAVQqjiRjKQqWenxQp0qB8iQXGWLhciBT4xP3huRdlJx4D
         I3v+RcUMtZ5ESFDjpgkvPRqEeIZmia/OmwH5LXIe7nWxnNf8ZufSMEc1eVF3eO/wB8sN
         ONGPlVQSzPasscTHr5NSJlKihUuvjxjFoYyuVcNC9a4CLQVZ6eEk/p9xMJUF7v46EjF/
         Tj3rc3EaHpENIqELCv5gNcwNb23Kn40q2+xbiZVAGw2fIsQ5YOJ0a+uclJpu+Zvi84fD
         uI6ZknLYWFUIZZF5glyQJtFII1BJTORAxOpPUh4SryfbnRuT+pS+pB0TOwWYPSk2Q75t
         fPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yqZHB5Usu4IZ7ZWk5hQ0vnLAwoEP2DpWSc1lqFaIC1c=;
        b=lfuVgoHFs9MXvazq5xAIX47733oaAplQRmGbzQdTz1gJajih0bgAOxDMGDyIJ7sedh
         sL2qCogSWkXkRtHQMm+PgjK655T3xJIczYxL6YMX7e6yoVgjG8C2K9Vxd8rCqMX93mpu
         difkQl2DuIoqjUKQw1j8SCx0xh1EVMeXCFzId4WSWReNUxreBOMVar6Aw9jaIiB8pVBq
         BJTCQGczeI/XNPNRcBBHbmWYBXI64aJ7J08xleXPh12vGelrGQU2wLi2IBu4ARGOfSR/
         0Y3YR9YoCR5rSXMVTGSj6qEbN5uNjwax1gw646eC+bXz5kDD2OSiFc/HolXEYvlRRBHj
         hJOg==
X-Gm-Message-State: ABuFfogr5mQzMAWq03HTlpB79PHAWC00EDafWpG6glSXRcmeUbBIpYQu
        ohgk7GIvCfLo/PMchuHy3HZ/fciKEfcl+fe1NR3wif9Nnp2BZA==
X-Google-Smtp-Source: ACcGV61Cxq3/qVgQkTpZuRQB7brgOA/qFA0fZtCIA9XAm+M0Q1edEn8EqVJpAnOtL1vPpqcY4CUohwegNweHuQ5xpgg=
X-Received: by 2002:aa7:d9cf:: with SMTP id v15-v6mr13714456eds.25.1540234458207;
 Mon, 22 Oct 2018 11:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com> <20181022173935.GG30222@szeder.dev>
In-Reply-To: <20181022173935.GG30222@szeder.dev>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 Oct 2018 11:54:06 -0700
Message-ID: <CAGZ79kboyakR=dARH60ZJmyN=kT+-X0SSDjgz3aswpkUd+bZmg@mail.gmail.com>
Subject: Re: New semantic patches vs. in-flight topics [was: Re: [PATCH 00/19]
 Bring more repository handles into our code base]
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 10:39 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>
> On Tue, Oct 16, 2018 at 04:35:31PM -0700, Stefan Beller wrote:
> > the last patch (applying the semantic patches) has been omitted as that
> > would produce a lot of merge conflicts. Without that patch, this merges
> > cleanly to next.
> >
> > As for when to apply the semantic patches, I wondered if we would prefe=
r a dirty merge
> > (created via "make coccicheck && git apply contrib/coccinelle/the_repos=
itory.cocci.patch")
> > of the semantic patches, or if we'd actually trickle in the changes ove=
r some time?
>
> >     This series takes another approach as it doesn't change the signatu=
re of
> >     functions, but introduces new functions that can deal with arbitrar=
y
> >     repositories, keeping the old function signature around using a sha=
llow wrapper.
> >
> >     Additionally each patch adds a semantic patch, that would port from=
 the old to
> >     the new function. These semantic patches are all applied in the ver=
y last patch,
> >     but we could omit applying the last patch if it causes too many mer=
ge conflicts
> >     and trickl in the semantic patches over time when there are no merg=
e conflicts.
>
> I don't really like how this or the previous RFC patch series deal
> with semantic patches (or how some past patch series dealt with them,
> for that matter), for various reasons:
>
>   - Applying the transformations from several semantic patches in one
>     single patch makes it harder to review it, because we won't know
>     which change came from which semantic patch.

Good point, so to improve the series sb/more-repo-in-api, I could
send the application of the semantic patch just after each patch
that adds another semantic patching rule? I personally dislike
applying the semantic patch in the same patch as where the
semantic rule was introduced, as then the mechanical conversions
(from the semantic patch) drown out reviewers attention to the
manual changes.

>     For comparison, see the patch series adding hasheq()/oideq(),
>     merged in 769af0fd9e (Merge branch 'jk/cocci', 2018-09-17), in
>     particular the four "convert <this> to <that>" patches.

The four patches "convert <this> to <that> only contain the semantic
patch as well as its effects, the manual changes are separated out
to later patches, which is quite nice.

>   - 'make coccicheck' won't run clean (and the static analysis build
>     job on Travis CI will fail) for all commits following adding the
>     new semantic patches but before applying the resulting
>     transformations.
>
>   - These semantic patches interact badly with 'pu' and 'next',
>     because those integration branches can contain topic branches
>     adding new code that should be transformed by these semanic
>     patches.

And I thought of this as a feature. There is no merge conflict and it
still compiles, which makes Junios work easy.

Of course it put the load elsewhere. :/

For the sake of a good history, I would think running 'make coccicheck'
and applying the resulting patches would be best as part of the (dirty)
merge of any topic that proposes new semantic patches, but that would
add load to Junio as it would be an extra step during the merge.

One could argue that the step of applying such transformations into
the dirty merge is cheaper than resolving merge conflicts that are
had when the topic includes the transformation.

>     Consequently, 'make coccicheck' won't run clean and the
>     static analysis build job will fail until all those topics reach
>     'master', and the remaining transformations are applied on top.
>
>     This was (and still is!) an issue with the hasheq()/oideq() series
>     as well: that series was added on 2018-08-28, and the static
>     analysis build job is red on 'pu' ever since.  See the follow-up
>     patch e43d2dcce1 (more oideq/hasheq conversions, 2018-10-02), and
>     one more follow-up will be necessary after the builtin stash topic
>     is merged to 'master'.

In my understanding this follow up is a feature, as it helps to avoid
merge conflicts with other topics in flight.

>     This makes it harder to review other patch series.

as 'make coccicheck' is an integral part of your review?

>   - Is it really necessary to carry these semantic patches in-tree?
>     Let me ellaborate.  There are basically two main use cases for
>     semantic patches:
>
>       - To avoid undesirable code patterns, e.g. we should not use
>         sha1_to_hex(oid.hash) or strbuf_addf(&sb, "fixed string"), but
>         use oid_to_hex(&oid) or strbuf_addstr(&sb, "fixed string")
>         instead.  Note that in these cases we don't remove the
>         functions sha1_to_hex() or strbuf_addf(), because there are
>         good reasons to use them in other scenarios.
>
>         Our semantic patches under 'contrib/coccinelle/' fall into
>         this category, and we have 'make coccicheck' and the static
>         analysis build job on Travis CI to catch these undesirable
>         code patterns preferably early, and to prevent them from
>         entering our codebase.
>
>       - To perform one-off code transformations, e.g. to modify a
>         function's name and/or signature and convert all its
>         callsites; see e.g. commits abef9020e3 (sha1_file: convert
>         sha1_object_info* to object_id, 2018-03-12) and b4f5aca40e
>         (sha1_file: convert read_sha1_file to struct object_id,
>         2018-03-12).
>
>         As far as I understand this patch series falls into this
>         category: once the conversion is complete the old functions
>         will be removed.  After that there will be no use for these
>         semanic patches.
>
>         Having said that, it's certainly easier to double-check the
>         resulting transformations when one can apply the semantic
>         patches locally, and doing so is easier when the semantic
>         patches are in tree than when they must be copy-pasted from a
>         commit message.
>
> OK, that was already long.  Now, can we do better?
>
> How about introducing the concept of "pending" semantic patches,
> stored in 'contrib/coccinelle/<name>.pending.cocci' files, modifying
> 'make coccicheck' to skip them, and adding the new 'make
> coccicheck-pending' target to make it convenient to apply them, e.g.
> something like the simple patch at the end.
>
> So the process would go something like this:
>
>   - A new semantic patch should be added as "pending", e.g. to the
>     file 'the_repository.pending.cocci', together with the resulting
>     transformations in the same commit.
>
>     This way neither 'make coccicheck' nor the static analysis build
>     job would complain in the topic branch or in the two integration
>     branches.  And if they do complain, then we would know right away
>     that they complain because of a well-established semantic patch.
>     Yet, anyone interested could run 'make coccicheck-pending' to see
>     where are we heading.
>
>   - The author of the "pending" semanting patch should then keep an
>     eye on already cooking topics: whether any of them contain new
>     code that should be transformed, and how they progress to
>     'master', and sending followup patch(es) with the remaining
>     transformations when applicable.
>
>     Futhermore, the author should also pay attention to any new topics
>     that branch off after the "pending" semantic patch, and whether
>     any of them introduce code to be transformed, warning their
>     authors as necessary.
>
>   - Finally, after all the dust settled, the dev should follow up with
>     a patch to:
>
>       - promote the "penging" patch to '<name>.cocci', if its purpose
>         is to avoid undesirable code patterns in the future, or
>
>       - remove the semantic patch, if it was used in a one-off
>         transformation.
>
> Thoughts?

I like the approach of having separate classes of semantic patches:
(a) the regular "we need to keep checking these" as they address
    undesirable code patterns, which is what we currently have,
    and what 'make coccicheck' would complain about.
(b) The pending patches as you propose. However I would
    argue that we'd not want to include the transformation into
    the same patch as then the patch will have merge conflicts.
    Ideally we'd have an automated process/bot that would apply
    all pending semantic patches onto master and then checks for
    conflicts in HEAD..pu, and only sends off the non-conflicting
    diffs as a topic.
    Then after a couple integration cycles we'd have all pending
    changes in, with no conflicts on Junios side.

So I think we should add a patch like you post, but we would
need to discuss the exact approach how to deal with pending
patches. Is it the original dev who should push forward on their
own pending patches, or does it become a pooled effort?

Thanks for starting this discussion!
Stefan
