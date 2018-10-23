Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CB01F453
	for <e@80x24.org>; Tue, 23 Oct 2018 20:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeJXE5l (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 00:57:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40032 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeJXE5l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 00:57:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so3123550wro.7
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+4/qDND+drPmGMdKvcQVMaORghLdmngEiZD8XA5UrR4=;
        b=P1//2Y0qLbb0P+pAi0pLHRTPdxFU9Uxq2GMI7dIi6gxt3HPoH/kQRYyBMUoGcJeiU3
         riCGsjjQWq64UoW27xTm3HayJpJgQOlq9cnZIrHTz05JhlALErPSO2qHV1G1q+/cFQja
         YIuX0PBWowbpWJa0Ds9u4kwCtZ0yEZYPPUDGoSBOs3vPYYRws9EcHNixHPUoqm4384m6
         d11+Fv0rl3ZFY+wP8Mcv5thCpS+negIhq1FqnvR+0Ao1f0eWLPSCNiNZS28WZseG9UoG
         IBC/2OfdoUUEI5JtYu04iLHhz89OLqjkx9BVkS9hx7nApXgik+WCfaPpUh/5W3jvpEKH
         whRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+4/qDND+drPmGMdKvcQVMaORghLdmngEiZD8XA5UrR4=;
        b=T9XYpvgzVEYFgnjHoAClMrAe3wEBgtnnXEwt/hRibIjAbA0aCEhuTjN+1IgnOdIZ1L
         UYU3XEQuJBSNHzD8KP7yZsNyVGG3AOlDA6AChEgKkq+rZRdTqbNyM03isaUZs8QWgGtQ
         p8eCOH9w14QMgH419cu3wCybSs/mArXCI6GBF4JVBXBm6IcCv5hdGR6vRpdpHHsZORl/
         PC4VUzlKZwfx709VSg0jKnav+09cUXh7YD24e1FixMzUkoFAtzfhnaAZdo3y0r6Nr4XF
         iq8UT7udxmLyqiEVSH8ZmpT6STYLC6xJZ7j+JQeih6xs7PPjhyf1qSg3ccxc7HSE06Ep
         Hc/w==
X-Gm-Message-State: AGRZ1gL+iMKEjawX1fty1K1Ug5O9vPwUh/Y9AJKyM2LHZ88eMFlRp0LC
        FcSsPAjewD6t2FYAYkR6Q1M=
X-Google-Smtp-Source: AJdET5ez/BPEPg40bIldbcTk8GU47tIlUyDu/ioLPW7EX1NEYgGHLHncg2Y3qGpyIUTjMpvrqEKS0g==
X-Received: by 2002:adf:e2c1:: with SMTP id d1-v6mr14436268wrj.26.1540326760415;
        Tue, 23 Oct 2018 13:32:40 -0700 (PDT)
Received: from localhost ([2.25.81.124])
        by smtp.gmail.com with ESMTPSA id x8-v6sm4773716wrd.54.2018.10.23.13.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 13:32:39 -0700 (PDT)
Date:   Tue, 23 Oct 2018 21:32:38 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] commit-reach: fix sorting commits by generation
Message-ID: <20181023203237.GF4883@hank.intra.tgummerer.com>
References: <20181022211037.22719-1-t.gummerer@gmail.com>
 <13bdda53-b751-182b-4aa8-d9a5c03f422d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13bdda53-b751-182b-4aa8-d9a5c03f422d@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/22, René Scharfe wrote:
> Am 22.10.2018 um 23:10 schrieb Thomas Gummerer:
> > compare_commit_by_gen is used to sort a list of pointers to 'struct
> > commit'.  The comparison function for qsort is called with pointers to
> > the objects it needs to compare, so when sorting a list of 'struct
> > commit *', the arguments are of type 'struct commit **'.  However,
> > currently the comparison function casts it's arguments to 'struct
> > commit *' and uses those, leading to out of bounds memory access and
> > potentially to wrong results.  Fix that.
> > 
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > 
> > I noticed this by running the test suite through valgrind.  I'm not
> > familiar with this code, so I'm not sure why this didn't cause any
> > issues or how they would manifest, but this seems like the right fix
> > for this function either way.
> 
> Right; I sent a similar patch a while ago, but it seems to have fallen
> through the cracks:
> 
> https://public-inbox.org/git/d1b58614-989f-5998-6c53-c19eee409a2f@web.de/

Whoops I didn't notice that, I only checked whether the problem still
exists in pu.  I'd be more than happy to go with your patch instead.

> Anyway, your implied question was discussed back then.  Derrick wrote:
> 
>    The reason to sort is to hopefully minimize the amount we walk by 
>    exploring the "lower" commits first. This is a performance-only thing, 
>    not a correctness issue (which is why the bug exists). Even then, it is 
>    just a heuristic.

Thanks for pointing that out!

> Does b6723e4671 in pu (commit-reach: fix first-parent heuristic) change
> that picture?  Did a quick test and found no performance difference with
> and without the fix on top, i.e. proper sorting didn't seem to matter.

I just gave 'test-tool reach can_all_from_reach' a try and got the
same results, with or without the fix the times are very similar.  I
haven't had time to follow the commit-graph series though, so I'm not
sure I used it correctly.  I tried it on the linux repository with the
following input:

X:v4.10
X:v4.9
X:v4.8
X:v4.7
X:v4.6
X:v4.5
X:v4.4
X:v4.3
X:v4.2
X:v4.1
Y:v3.10
Y:v3.9
Y:v3.8
Y:v3.7
Y:v3.6
Y:v3.5
Y:v3.4
Y:v3.3
Y:v3.2
Y:v3.1

> >  commit-reach.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/commit-reach.c b/commit-reach.c
> > index bc522d6840..9efddfd7a0 100644
> > --- a/commit-reach.c
> > +++ b/commit-reach.c
> > @@ -516,8 +516,8 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
> >  
> >  static int compare_commits_by_gen(const void *_a, const void *_b)
> >  {
> > -	const struct commit *a = (const struct commit *)_a;
> > -	const struct commit *b = (const struct commit *)_b;
> > +	const struct commit *a = *(const struct commit **)_a;
> > +	const struct commit *b = *(const struct commit **)_b;
> >  
> >  	if (a->generation < b->generation)
> >  		return -1;
> > 
> 
> Looks good to me.
> 
> René
