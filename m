Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743B420248
	for <e@80x24.org>; Tue, 26 Mar 2019 21:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfCZVaf (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 17:30:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46447 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbfCZVaf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 17:30:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so2237882pll.13
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lpHBJZ/eObyTPypeBfkAWx0DxnFI3jcaEn+UX3d6EO0=;
        b=ApZH83NjKo8ILoBQdNiH61ZgxR/tfFcz8TBVkBGyU5G4Uy2tkkeADKiYLaUy1sMJt+
         +9dzMkLOvUQL7HkH1pJzSnG3uISSsbqyVGpkw6L7U/F6zxzu6WSv6JGkip88ZD/jyupc
         gEVSB2hrGLMxe3SdICAh43huWwhyZLRDqLQSo848dQpYKWeKVLvt/RFIHNY/rXl3b2zE
         mr+BHoBL6i0nafY0tFHCLyHLthkQH6JejMvdpexBvz1Gf+3gUXLEA0tkT02MZLXDVwqG
         QcGsEJFkJtPusWYHIyepknGW+xymo/L8VeGByR5KU3fEQAusd+dkbaM9rVAHBQach4K4
         gzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lpHBJZ/eObyTPypeBfkAWx0DxnFI3jcaEn+UX3d6EO0=;
        b=qjuYujqPW4TlI/QuBg6MQ8WS09+4COW+KA20xKMfCWMFQmFp/J2bIEcPy8P7ifhVm8
         jTVZhJuZFyOzImxWoeyI6CdpbontjzF8NARYpwm88qTdXWo4cy4cWsuvYpYrrtbEC9+q
         AVi2yN6NoDtCfAAcganEDyJW4LsFIC1pvnCF2oM0cvSxBV2kPxCPIR3DLtEFy7UKLDeX
         uSO8O8Au7muK6I7NvgLJoFjY6Ke8rQ3YGgKV7+8JZVQpqRKDx0NMC1OggAzyI1PGHBpc
         Roe7lrvU+pQHTppC7PnBDe41D5qiQZnY68Aa9Zi7YhDxKsVfx4JqCTzQfVkTT/ZWQg9h
         Tkcg==
X-Gm-Message-State: APjAAAWhKSnvLYmsOFQ8Mdb1QgGdoI2/gHEXbR1a+qVQaQhDnwn4UZgf
        4jg+FfXa/ws2gNQPHGrRCIM=
X-Google-Smtp-Source: APXvYqwe6S9jlagRq9aXUuRRaqYXLPvtBVbRr1jDRPkvZ8r3xHYao3+0Zk9P4ih4mp+XoJlzjodv1g==
X-Received: by 2002:a17:902:396a:: with SMTP id e39mr11379232plg.220.1553635833657;
        Tue, 26 Mar 2019 14:30:33 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id h65sm30876165pfd.108.2019.03.26.14.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 14:30:32 -0700 (PDT)
Date:   Tue, 26 Mar 2019 14:30:31 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] rebase: learn --keep-base
Message-ID: <20190326213031.GA21504@dev-l>
References: <cover.1553354374.git.liu.denton@gmail.com>
 <87bm1xbt55.fsf@evledraar.gmail.com>
 <20190326175052.GA14922@dev-l>
 <878sx1bcgr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878sx1bcgr.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On Tue, Mar 26, 2019 at 09:35:48PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 26 2019, Denton Liu wrote:
> 
> > Hi Ævar,
> >
> > On Tue, Mar 26, 2019 at 03:35:34PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >>
> >> On Sat, Mar 23 2019, Denton Liu wrote:
> >>
> >> > This series teaches rebase the --keep-base option.
> >> >
> >> > 'git rebase --keep-base <upstream>' is equivalent to
> >> > 'git rebase --onto <upstream>... <upstream>' or
> >> > 'git rebase --onto $(git merge-base <upstream> HEAD) <upstream>' .
> >> >
> >> > This seems to be a common case that people (including myself!) run into; I was
> >> > able to find these StackOverflow posts about this use case:
> >> >
> >> > * https://stackoverflow.com/questions/53234798/can-i-rebase-on-a-branchs-fork-point-without-explicitly-specifying-the-parent
> >> > * https://stackoverflow.com/questions/41529128/how-do-you-rebase-only-changes-between-two-branches-into-another-branch
> >> > * https://stackoverflow.com/a/4207357
> >>
> >> Like with another series of yours I think this would be best squashed
> >> into one patch.
> >
> > Will do.
> >
> >>
> >> Maybe I've misunderstood this but isn't this like --fork-point except
> >> with just plain "git merge-base" instead of "git merge-base
> >> --fork-point", but then again 2/3 shows multiple base aren't supported,
> >> but merge-base supports that.
> >>
> >
> > --fork-point gets used to determine the _set of_ commits which are to be
> > rebased, whereas --keep-base (and --onto) determine the base where that
> > set of commits will be spliced. As a result, these two options cover
> > orthogonal use-cases.
> 
> Right. After playing with this a bit more though --fork-point is mostly
> there, it it does find the same fork point, as evidenced all your tests
> (that aren't asserting incompatibility with other options) passing with
> this:
> 
>     diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
>     index 9c2548423b..ab2d50e69a 100755
>     --- a/t/t3416-rebase-onto-threedots.sh
>     +++ b/t/t3416-rebase-onto-threedots.sh
>     @@ -116,7 +116,7 @@ test_expect_success 'rebase --keep-base master from topic' '
>             git checkout topic &&
>             git reset --hard G &&
> 
>     -       git rebase --keep-base master &&
>     +       git rebase $(git merge-base --fork-point master HEAD) &&
>             git rev-parse C >base.expect &&
>             git merge-base master HEAD >base.actual &&
>             test_cmp base.expect base.actual &&
>     @@ -140,7 +140,7 @@ test_expect_success 'rebase -i --keep-base master from topic' '
>             git reset --hard G &&
> 
>             set_fake_editor &&
>     -       EXPECT_COUNT=2 git rebase -i --keep-base master &&
>     +       EXPECT_COUNT=2 git rebase -i $(git merge-base --fork-point master HEAD) &&
>             git rev-parse C >base.expect &&
>             git merge-base master HEAD >base.actual &&
>             test_cmp base.expect base.actual &&
> 
> I've poked at some of this recently in
> https://public-inbox.org/git/20190221214059.9195-3-avarab@gmail.com/ as
> noted in the feedback there (I haven't gotten around to v2 yet) it's
> entirely possible that I haven't understood this at all :)
> 
> But it seems to me that this patch/implementation conflates two
> unrelated things.
> 
> Once is that we use --fork-point to mean that we're going to find the
> divergence point with "merge-base --fork-point". This gets you halfway
> to where you want to be, i.e. AFAICT the --keep-base and --fork-point
> will always find the same commit for "git rebase" and "git rebase
> --keep-base". See the "options.restrict_revision = get_fork_point(...)"
> part of the code.

I don't think this is true. The code that --keep-base uses to find the
merge base is get_oid_mb, see the relevant snippet

	if (strstr(options.onto_name, "...")) {
		if (get_oid_mb(options.onto_name, &merge_base) < 0)

whereas the --fork-point code uses get_fork_point, as you mentioned
above. As a result, they don't necessarily refer to the same commit in
the case where upstream is rewound.

> 
> The other, which you want to disable, is that --fork-point *also* says
> "OK, once we've found the divergence point, let's then rebase it on the
> latest upstream. Or in the example above the "master" part of "git
> merge-base --fork-point master HEAD".

Correct, I guess in essence this is what I'm doing.

> 
> Shouldn't --keep-base just be implemented in terms of skipping *that*
> part, i.e. we find the fork point using the upstream info, but then
> don't rebase *on* upstream.
> 
> The reason the distinction matters is because with your patch these two
> act differently:
> 
>     git rebase --keep-base
>     git rebase $(git merge-base @{u} HEAD)
> 
> The latter will skip work ("Current branch master is up to date"), but
> --keep-base will always re-rebase things. There's some cases where
> --fork-point does that, which I was trying to address with my linked WIP
> patch above.

I believe this is desired behaviour. Suppose we have this (modified)
graph from the git-merge-base docs, where B3 was formerly part of
origin/master but it was then rewound:

           ---o---o---B2--o---o---o---B (origin/master)
                   \
                    B3
                     \
                      Derived (local master)

If we run "git rebase --keep-base", we'll get the following graph:

           ---o---o---B2--o---o---o---B (origin/master)
                   \
                    Derived (local master)

which I believe is the desired behaviour (we're abandoning B3 since
upstream abandoned it).

I hope I'm understanding you correctly. Please let me know if I've
misinterpreted anything you've said or if anything I've said is unclear.

Thanks,

Denton

> 
> Whereas the thing you actually want to work is:
> 
>     git rebase -i --keep-base
>     git rebase -i $(git merge-base @{u} HEAD)
> 
> I.e. to have both of those allow you to re-arrange/fixup whatever and
> still rebase on the same divergence point with @{u}, and won't run
> rebase when there's no work to do unless you give it --force-rebase.
> 
> > reason that --onto already disallows multiple bases. If we have multiple
> > bases, how do we determine which one is the "true base" to use? It makes
> > more sense to error out and let the user manually specify it.
> 
> Ah, makes sense.
> 
> >> I'd find something like the "DISCUSSION ON FORK-POINT MODE" in
> >> git-merge-base helpful with examples of what we'd pick in the various
> >> scenarios, and also if whatever commit this picks was something you
> >> could have "git merge-base" spew out, so you could get what rebase would
> >> do here from other tooling (which maybe is possible, but I'm confused by
> >> the "no multiple bases"...).
> >
> > If I'm understanding you correctly then yes, this could be done with
> > other tooling. See the 0/3 for equivalent commands.
> >
> > Perhaps I should update the rebase documentation to mention that
> > --fork-point and --keep-base are orthogonal because it's unclear for
> > you, it's probably unclear for other users as well.
> >
> > Thanks,
> >
> > Denton
