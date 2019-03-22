Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3321E20248
	for <e@80x24.org>; Fri, 22 Mar 2019 11:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfCVLSf (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 07:18:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54881 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVLSe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 07:18:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so1760836wmj.4
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 04:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bk+EplGNtddd683dtTN5Bd/A01mp+XmBqHgGNS4/Ns8=;
        b=Tvn2fW7pa0hjIJbc5PveT5ZpAHQ88Gfzx/KDrNqUxMW+oTI+zjQIpkaq8zX3eotn9I
         BqgjB7Cfnuwr0D/Q7oYh28lQvg+q1OmYTgQQAe41JMOup7trtVGRfB4ln20uB2RdRDtJ
         EhCJPiju4q4wMe5vRF9VeRfXkA0VYR5kexIjYfVVH6L73v49Agf4kxf6pEsiKj1+s4aT
         2m/QHXNCaGCQ6KSI24CoGnKrTdB12bBYirSQ/wKOH93Yv+dhtdwfVJcasO7EerBLrbCn
         +CnGInrqN43toKdkSlG+OnC/SGCh982lxvmJrE1Y/QghNw61ltM55UgxWU43Jq+lRAKS
         jFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bk+EplGNtddd683dtTN5Bd/A01mp+XmBqHgGNS4/Ns8=;
        b=PV0r/SEBJfvtgAzgTomIOPUHKTbKkU2q+GhxOurhlAxQe9a5fukt/C0QXFPjEYMVQq
         AoEJXvdXXcISMHZvfPediIIvNM2dhMid8spW7TjWrBRvGdAFjcHt2g1n/ENXyYHKEWjn
         JNAB5hai8C/oMPFpYqAh8ziPcCTMfHVaHWW6yQ0lfGBzQ6/fE2K00z952nSlkvBK5aXU
         9KAVFtzoyaqdpi6ZAijGas94R4H7XKKKjHm+1kz3xFv8o93AiOC+VC01QTVuLo3V7FV1
         uUzZnXy1jDCqlnvzVTBqiZPz4EB68fekPFUdCFlhEHLHhPeBPGfD7PiJpNTU1BR2wOwq
         215A==
X-Gm-Message-State: APjAAAUmmTx55cQlmPI554wk9nQ/YtTA2YPK5M/p25uWRTrh2vxuK4hy
        RLWpv9nvi81NTEksfkUQF5s=
X-Google-Smtp-Source: APXvYqyUN5MFvWsOzq06aGerbOiZElPzeCOrcvKNeTVrEWbs++ZyLnOfakFDMx5sibG8DcWwwF0FOA==
X-Received: by 2002:a1c:2543:: with SMTP id l64mr2794628wml.116.1553253512053;
        Fri, 22 Mar 2019 04:18:32 -0700 (PDT)
Received: from szeder.dev (x4db501f9.dyn.telefonica.de. [77.181.1.249])
        by smtp.gmail.com with ESMTPSA id e135sm14229982wmg.24.2019.03.22.04.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 04:18:31 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:18:29 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: don't show progress percentages while
 expanding reachable commits
Message-ID: <20190322111829.GC22459@szeder.dev>
References: <20190119202121.3590-11-avarab@gmail.com>
 <20190322102817.19708-1-szeder.dev@gmail.com>
 <87lg17cgf5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lg17cgf5.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 12:11:26PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 22 2019, SZEDER Gábor wrote:
> 
> > Commit 49bbc57a57 (commit-graph write: emit a percentage for all
> > progress, 2019-01-19) was a bit overeager when it added progress
> > percentages to the "Expanding reachable commits in commit graph" phase
> > as well, because most of the time the number of commits that phase has
> > to iterate over is not known in advance and grows significantly, and,
> > consequently, we end up with nonsensical numbers:
> >
> >   $ git commit-graph write --reachable
> >   Expanding reachable commits in commit graph: 138606% (824706/595), done.
> >   [...]
> >
> >   $ git rev-parse v5.0 | git commit-graph write --stdin-commits
> >   Expanding reachable commits in commit graph: 81264400% (812644/1), done.
> >   [...]
> >
> > Therefore, don't show progress percentages in the "Expanding reachable
> > commits in commit graph" phase.
> 
> There's indeed a bug here as your examples show, but there *are* cases
> where it's correct, as the commit message for my patch on "master" shows
> there's cases where we correctly.
> 
> So this "fixes" things by always removing the progress, why not instead
> pass down the state to close_reachable() about what we're walking over,
> so we can always show progress, or at least in some cases?

The cases where it does display correct percentages are exceptional,
and doesn't worth the effort to try to find out whether ther current
operation happens to be such a case.

> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  commit-graph.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 017225ccea..60c06ce58f 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -672,13 +672,13 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
> >  	 * As this loop runs, oids->nr may grow, but not more
> >  	 * than the number of missing commits in the reachable
> >  	 * closure.
> >  	 */
> >  	if (report_progress)
> >  		progress = start_delayed_progress(
> > -			_("Expanding reachable commits in commit graph"), oids->nr);
> > +			_("Expanding reachable commits in commit graph"), 0);
> >  	for (i = 0; i < oids->nr; i++) {
> >  		display_progress(progress, i + 1);
> >  		commit = lookup_commit(the_repository, &oids->list[i]);
> >
> >  		if (commit && !parse_commit(commit))
> >  			add_missing_parents(oids, commit);
