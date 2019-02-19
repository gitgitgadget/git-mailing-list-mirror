Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_RP_RNBL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3891F453
	for <e@80x24.org>; Tue, 19 Feb 2019 23:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfBSX7S (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 18:59:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52437 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfBSX7S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 18:59:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so4714740wml.2
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 15:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M+xXtH6VYkwCm90PbtQxA3+fCHFMeG+zGgNwG7/WnI0=;
        b=JXMOi1fGRgk0FKdCEvr0RwdyZBv+Et1uNQsT5RT0ghW3vncDLgGs7/lGR5l4NHkbai
         Pa8n3336OaAmdqqlEkGBIRC+grfmjwxFDeGBtUyj5W+ah5Az+sz72wdsQh7T7/Ifj5wI
         e8yvwksIUWpeR4DEVKII5xRwiCN7gM0+djlwurw17CHl4TZ4I/kqt63PRFAXuXAh1XxJ
         hOZWO5XwntRzOsLpRj3OPV3cny6MY5bc9BmKmLUDa1khxFYXDbcFvdGNsiusaD+EKDj7
         obXxWyHKYbnlj6UXuNwLluvrRxFV8+yclORYInCMecAq/dRQ6spUVxOp6SVVxFFMv4jP
         OB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M+xXtH6VYkwCm90PbtQxA3+fCHFMeG+zGgNwG7/WnI0=;
        b=dmthV+Sx/9HXqdX1DZmidhQRaeZaK0HTNXeZPywNasBEjfKEJMaF0P6JB8rzO5wcbe
         iKAOVtt8iw34xJNNg5JVA7a0/nr8nASRM1sC8wU9VJ35XGLpObZAdMxoJE0k1sXE0gwT
         8+O4IUZogi/3JU8KjUXcRw8ANesHDaSiOYbdvKxt8hFW9v50o1ZPF3gV0bDWl5uh8IY4
         uHI6rS5uDE3TAWpWEFKiqXhCt4YI/fkgP1kgK5qAlmyLSOX6ZMyTgmOggCocWZ6bS/pk
         iMrmTou5LdXLGz6ytKBV6HpIhi6ZBBob4qXmak1pFiTAWYqpEMYRAjw+VZWAIpYHAyIL
         vuuQ==
X-Gm-Message-State: AHQUAuaP42z/s/esLi9OpLAfeMtvQYGoAxzB7ge1XmeJbmphxoX4sE04
        vd9Slfj1RJ+0KmuF02liKPI=
X-Google-Smtp-Source: AHgI3Ibh7HiYKNRx37c6gjboTnVIGc52ToSQtTkhDPU0qWQUTLHVVKS5aJA94e3nzsw8uGu8hwGi+g==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr4439214wme.134.1550620755569;
        Tue, 19 Feb 2019 15:59:15 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id h137sm7198078wmg.41.2019.02.19.15.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 15:59:14 -0800 (PST)
Date:   Tue, 19 Feb 2019 23:59:13 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v12 18/26] stash: convert push to builtin
Message-ID: <20190219235913.GM6085@hank.intra.tgummerer.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
 <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com>
 <20190208113059.GV10587@szeder.dev>
 <20190210221712.GA9241@hank.intra.tgummerer.com>
 <20190211011306.GA31807@szeder.dev>
 <20190212231837.GI6085@hank.intra.tgummerer.com>
 <20190219002336.GN1622@szeder.dev>
 <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/19, Johannes Schindelin wrote:
> Hi Gábor & Thomas,
> 
> On Tue, 19 Feb 2019, SZEDER Gábor wrote:
> 
> > > I'll hopefully be in a position to
> > > send a patch with a proper log message why this is the right fix in
> > > the next couple of days.
> > > 
> > > diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> > > index c77f62c895..3dab488bd6 100644
> > > --- a/builtin/stash--helper.c
> > > +++ b/builtin/stash--helper.c
> > > @@ -231,6 +231,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
> > >  	struct tree *tree;
> > >  	struct lock_file lock_file = LOCK_INIT;
> > >  
> > > +	discard_cache();
> > >  	read_cache_preload(NULL);
> > >  	if (refresh_cache(REFRESH_QUIET))
> > >  		return -1;
> > > 
> 
> So this is working, but it is not the correct spot for that
> `discard_cache()`, as it forces unnecessary cycles on code paths calling
> `reset_tree()` (which corresponds to `git read-tree`, admittedly a bit
> confusing) with a fully up to date index.
> 
> The real fix, I believe, is this:
> 
> -- snip --
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 2d6dfce883..516dee0fa4 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1372,6 +1372,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
>  			}
>  		} else {
>  			struct child_process cp = CHILD_PROCESS_INIT;
> +			discard_cache();
>  			cp.git_cmd = 1;
>  			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
>  					 NULL);
> -- snap --
> 
> And the reason this is needed: we spawn a `git reset --hard` here, which
> will change the index, but outside of the current process. So the
> in-process copy is stale. And when the index' mtime does not help us
> detect that, we run into that test breakage.

Right, I agree with this assessment, and also agree that this is a
better place to discard the cache, rather than doing it in
'reset_tree()'.

> Now, I seriously believe that we missed the best time to move
> ps/stash-in-c into `next` for cooking. The best time would have been just
> after Paul submitted the latest patch series: we know for a fact that he
> is too busy to really take care of this patch series, so keeping it in
> `pu` puts everybody into that awkward spot where nobody wants to step on
> Paul's toes messing with his patch series, but where Paul also lacks the
> time to push it further, so everything is stuck in a limbo and is *so very
> much* not cooking at all. You might say that it has turned bad because we
> failed to stoke the fire appropriately.
> 
> Since it is now way too late in the v2.21.0 process, this problem is only
> exacerbated, because it won't even enter `next` "better late than never".
>
> To address this unfortunate situation, my current plan is to take over
> from Paul (we had been chatting about this privately in the past, and he
> is okay with this because of University eating all his time).
> 
> I will open the whole bag again, most likely squashing the late fixups
> into the patches that introduced the problems, re-review with a much finer
> comb than the patch series has enjoyed on the Git mailing list (even just
> a quick look at `do_apply_stash()` revealed an unnecessary `reset_tree()`
> call that *no* reviewer spotted, even I myself, but then, I am hardly
> solely responsible for that review), and most likely I'll even take my
> sweet little time changing the code to avoid more spawned Git processes.
> 
> It will take a long time, and the `stash` project that has been discussed
> recently to be given to GSoC students is no longer available, as I will
> take care of it before GSoC even starts, and I won't spend much time
> reviewing other people's code in the meantime.
>
> I will start that only after v2.21.0 final is out, obviously.
> 
> Once I submit a new iteration, it will look quite a bit different from
> before, and reviewers will have to re-review *everything*, wasting
> everybody's time even more. It will have to be re-reviewed in its entirety
> anyway because it has been *such* a long time since the latest review, and
> that's just the price we all have to pay for missing the right moment to
> advance this to `next`. Thomas, I will ask you to review, and Gábor, I
> will expect you to review that iteration, too, as you are now a bit
> familiar with the code, and I will really need your help here.
> 
> Anyway, that's my plan for now.

I must say I am not very happy about this plan.  The series has been
marked as "Will merge to 'next'" in previous iterations, but then we
found some issues that prevented that.  However I thought we were fine
fixing those on top at this point, rather than starting with a new
iteration again.

I was always under the impression that once the problem that was
discovered here was fixed we'd advance the series to 'next' with the
patch that comes out of this discussion on top.  Whether it's in next
shortly before 2.21 or not doesn't seem to make much of a difference
to me, as this wasn't going to make the 2.21 release anyway.  My hope
was that we could get it into 'next' shortly after 2.21 is released to
get the series some further exposure (which may well turn up some
other issues that we are not aware of yet, but such is the life of
software).

Sure there are some things that no reviewer spotted, but I'd think so
will there be next time and the time after that.  I don't believe that
code review can eliminate all issues, but I think we all did our best
to avoid a good chunk of them and unfortunately missed some in the
process.

Reviewing this series again in a slightly new form is not something I
am personally looking forward to.  I'd be more than happy to review
patches on top of this series, but after reading it many times over,
in slightly different versions, it gets harder and harder to review
and to find the motivation to review this.  Now if we really think
this series has to be completely overhauled, so be it, but I don't
think we would end up with a better end result than if we were to
continue to work on top of this.

> Ciao,
> Dscho

