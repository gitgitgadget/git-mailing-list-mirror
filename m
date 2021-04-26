Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBB8C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 21:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE78A611ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 21:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhDZVy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 17:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhDZVy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 17:54:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC814C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 14:54:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j4so51080101lfp.0
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8n7n3Ei+885pF8lLivZ2ceTfk3J6YKdAoAgm4MIWe5E=;
        b=d/pd9ofatgEmMjEP/wxcVqumftQJ+y173FFlLWiG0girSUZDKmjkuC2WBHcpNiOIXu
         /VIG7KICiYmUVr6txYzQFZd5gzQTKWQFr/gxyePPSg/pvLRwkVmN8JaQvHy/5jurUm5Z
         ukw46NJoJgfRwxo6Ey0R2kDrGwocpYEG6SnEeQsaBUi+hWIyf5UjOoCVcw2ajXyLLCeW
         A2/TTbMsS4YW3cJxzpw83NnLAieI+xrkySVW3ctqmljUvNx/J6Vyih48NGnJVHHF3czm
         r8EmOVjLI5/HUc6KGwxZsrCuCJHTkRMsmbpWxuNx9EwrCi6CN0BhbCLlIgkMxXup54jX
         mp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8n7n3Ei+885pF8lLivZ2ceTfk3J6YKdAoAgm4MIWe5E=;
        b=X6YR7WnIRgdO2bRtCuOYbSXpxCPmtHqn8cDI20v9F7+9GnIb1SZQ9dT76Viqo9pBe9
         FExzCxCbNWk7jZjp7SOyJPq8jjsmGNxz0otE7PXiG13IUhTVcT+QZnn/KObV3v+ZqHVx
         vgA3yrDrjx42p2Md3eSUcoKJ2/VDLUxIk08E8JDqor24Gu/usofSZ3w0+oBx9zZnPCOY
         xSg1775SDfdxRR5RoOt4aRDtD+ZtMK3LSRFJ46n56j9liZ6DRmt2PFRNpuN9fayOVPRU
         9jhmSTTpF4JdrX6vW70Qd6t1PGZTs8JiJl8D+f51wf/4qEjRvz2CYF1dHBBZFsVpg/xA
         ES0A==
X-Gm-Message-State: AOAM533MwxSAxrJ5GqbcPerMcf43XBVtHQbQjuygwTudAFkq7pQ0/rnM
        u8MrVDwCKzeCeCM9LgTLAYp9OZwMArNF1ejJtat64g==
X-Google-Smtp-Source: ABdhPJyuCnzMqxn5UDwoFlg0YIdSNQ0mcLN9zaLzJbAwRuH9k2Du023hAVPgYt0ygfprzVvjpxsYi0oCNSTlUMEdOr4=
X-Received: by 2002:a19:c30b:: with SMTP id t11mr1431181lff.421.1619474052305;
 Mon, 26 Apr 2021 14:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619104091.git.matheus.bernardino@usp.br>
 <5e0dee7beba083159f4277ddcd9e931859239bde.1619104091.git.matheus.bernardino@usp.br>
 <058f6ca4-a575-a463-e29b-9071c35e5bd3@gmail.com>
In-Reply-To: <058f6ca4-a575-a463-e29b-9071c35e5bd3@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 26 Apr 2021 18:54:00 -0300
Message-ID: <CAHd-oW6OawTsPNcecWK1cOLJgfBtP0QGPu-vXaRm7_AoZ6+k0Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] builtin/checkout.c: complete parallel checkout support
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 1:19 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 4/22/2021 11:17 AM, Matheus Tavares wrote:
> > There is one code path in builtin/checkout.c which still doesn't benefi=
t
> > from parallel checkout because it calls checkout_entry() directly,> ins=
tead of unpack_trees(). Let's add parallel checkout support for this
> > missing spot as well.
>
> I couldn't tell immediately from the patch what would trigger this
> code path. I had to trace the method calls to discover that it is
> for the case of a pathspec-limited checkout:
>
>         git checkout <ref> -- <pathspec>

Oops, I should have mentioned that in the commit message. Thanks for
pointing it out.

> I confirmed that this does work with this change, but it might be
> nice to have a test that verifies that parallelism is triggering for
> this case.
>
> Looking ahead to patches 4-6, which add tests, I do not see one for this
> code path. Yes, patch 7 will implicitly test it through optional
> settings, but it would be nice to verify that the code is actually using
> parallel workers. The test_checkout_workers helper in patch 4 should be
> helpful for this effort.
>
> Please point out the test that covers this case, in case I'm just not
> seeing it.

Hmm, there are some tests at t2081 and t2082 that check the
pathspec-limited case with parallel workers. For example the collision
tests run `test_checkout_workers 2 git checkout .`. We also test
direct pathnames in t2082, using `test_checkout_workers 2 git checkout
A B`.

> The good news is that I can see a difference. By alternating checkouts
> of the Git repository's "t" directory between v2.20 and v2.31.1, I can
> see these results for varying numbers of workers:
>
> Benchmark #1: 16 workers
>   Time (mean =C2=B1 =CF=83):     108.6 ms =C2=B1   5.2 ms    [User: 146.1=
 ms, System: 146.1 ms]
>   Range (min =E2=80=A6 max):    95.5 ms =E2=80=A6 124.9 ms    100 runs
>
> Benchmark #2: 8 workers
>   Time (mean =C2=B1 =CF=83):     104.8 ms =C2=B1   4.8 ms    [User: 128.3=
 ms, System: 131.7 ms]
>   Range (min =E2=80=A6 max):    94.2 ms =E2=80=A6 119.0 ms    100 runs
>
> Benchmark #3: 4 workers
>   Time (mean =C2=B1 =CF=83):     112.3 ms =C2=B1   6.2 ms    [User: 114.6=
 ms, System: 112.1 ms]
>   Range (min =E2=80=A6 max):   100.0 ms =E2=80=A6 127.4 ms    100 runs
>
> Benchmark #4: 2 workers
>   Time (mean =C2=B1 =CF=83):     124.2 ms =C2=B1   4.2 ms    [User: 106.5=
 ms, System: 102.0 ms]
>   Range (min =E2=80=A6 max):   114.8 ms =E2=80=A6 136.3 ms    100 runs
>
> Benchmark #5: sequential
>   Time (mean =C2=B1 =CF=83):     154.6 ms =C2=B1   6.7 ms    [User: 83.5 =
ms, System: 79.4 ms]
>   Range (min =E2=80=A6 max):   142.1 ms =E2=80=A6 176.0 ms    100 runs
>
> Summary
>   '8 workers' ran
>     1.04 =C2=B1 0.07 times faster than '16 workers'
>     1.07 =C2=B1 0.08 times faster than '4 workers'
>     1.19 =C2=B1 0.07 times faster than '2 workers'
>     1.48 =C2=B1 0.09 times faster than 'sequential'

Nice! Thanks for the benchmark!

> (Note: these time measurements are for the round-trip of two checkout
> commands.)
> > @@ -359,16 +360,22 @@ static int checkout_worktree(const struct checkou=
t_opts *opts,
> >       int nr_checkouts =3D 0, nr_unmerged =3D 0;
> >       int errs =3D 0;
> >       int pos;
> > +     int pc_workers, pc_threshold;
> > +     struct mem_pool ce_mem_pool;
> >
> >       state.force =3D 1;
> >       state.refresh_cache =3D 1;
> >       state.istate =3D &the_index;
> >
> > +     mem_pool_init(&ce_mem_pool, 0);
> > +     get_parallel_checkout_configs(&pc_workers, &pc_threshold);
> >       init_checkout_metadata(&state.meta, info->refname,
> >                              info->commit ? &info->commit->object.oid :=
 &info->oid,
> >                              NULL);
> >
> >       enable_delayed_checkout(&state);
> > +     if (pc_workers > 1)
> > +             init_parallel_checkout();
>
> I'm late to looking at your parallel checkout work, but I find this
> to be a really nice API to get things initialized.

Thanks :)
