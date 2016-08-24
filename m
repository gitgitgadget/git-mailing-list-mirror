Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21251F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 15:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbcHXPyB (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 11:54:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:64004 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754281AbcHXPyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 11:54:00 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MdWO8-1bmRsS1iJQ-00PLex; Wed, 24 Aug 2016 17:53:52
 +0200
Date:   Wed, 24 Aug 2016 17:53:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/15] sequencer: lib'ify do_recursive_merge()
In-Reply-To: <CAPig+cTCotTDT83x9=q5ORR1ZWR9oewvXiun9sjvEbTV8OuChA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608241753150.4924@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <e00df1449af0d8c55000a93c734d8a241b1cb5f0.1471968378.git.johannes.schindelin@gmx.de> <CAPig+cTCotTDT83x9=q5ORR1ZWR9oewvXiun9sjvEbTV8OuChA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HLUCC3poqWA/bzIfpL17kIrHYqOJzJEJAP6+nJL0yHFvU5aVA98
 VoCjF83MycyZav78gly6acFkT3LqwquByswO/1TcGIplMHo4lH/0dpTGeLlLAReTyiTLqAg
 V5mgyI4aI1cBq/Bt5y4YqlnV37dWuoneLPJeYeVI1blaZIQptbddLnnFXR0lkjyijqBtOOj
 c8gTSNL8Uu2ig5WUdkBRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Alh9Z3NbI7Y=:BiuGRFnQ7zaGlKA1nxUH0l
 wE4tAn1IFk5eCGjmP7JRVbPM9sxaW8EZpBqj+19TQZ08mHSa6hzsss5ozZAhTNtHRPqf36Pfa
 ORImUxzKo1HEcOOT578C/bDmMWvRicUDrEDnc4UZK/If88sxMa3snSJYKPaER7kR+pV2JQhC1
 zwz2qn/Pq4BkO6rU7fbTFtvR3bD28ODuQ21FuMpMfw/JnE5lOZd/AzxaFuQtCHoYjJtexItfc
 JFFpPJJCEPLUNJ/xUjIzeF862XV5Y0zR4TY3Ne3vAg4FxtWQlJdmXFoMC7H2BHNf0O6Wx9Vvz
 g21IAFBrWVABl/zhGMdNbGfXQd13kO5K8+HxgHfEGP1H4wakSQ6IbSqxF20OQhQQph3AxHsFK
 xYJ5Y8aQPSo9SqR/RIXqWcFEhSVQ3GxCu3WH6tgCxYgsGFTTQerl70hB2ldhTSx25FfG/n5v8
 q+5BfipMgdxYRiD3sbeaWAnuVGa7f4Sjw2IqM4MgF0h6K9xFknpAV6xV44/C+7IdKFCwgUumi
 +Dq1zlokFFlShiXf3qSxwebLTK5YQi3IW/xwTAj7gNJjPRexmVy5gPBNQH8N7CiGp3hIC0k1e
 Qw9HirXo2lGmUEo7VxCdCMghu+rTf0w9HbDZZYrTjNIMneDsFjn1jjiynxTDFSJzPAVLlh5J7
 WlI6xojTBQOt8xWCOXtDGc9le0WHUvPkzVfWh9G9waTa3qh1E2/3jEVBh+v6fmrRvPlCUGfel
 NoVNp0xfjyXPGdmVqdeGhmbwrR2NU9qd9IlYIaW0dXRynfRQTK91r2QC/ZGZ5uJzxhr4wOKNl
 ik8WOSt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 24 Aug 2016, Eric Sunshine wrote:

> On Tue, Aug 23, 2016 at 12:06 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > To be truly useful, the sequencer should never die() but always return
> > an error.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/sequencer.c b/sequencer.c
> > @@ -303,7 +303,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
> >         if (active_cache_changed &&
> >             write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
> >                 /* TRANSLATORS: %s will be "revert" or "cherry-pick" */
> > -               die(_("%s: Unable to write new index file"), action_name(opts));
> > +               return error(_("%s: Unable to write new index file"),
> > +                       action_name(opts));
> 
> Does this need to rollback the lockfile before returning?
> 
> A cursory scan of read-cache.c:do_write_locked_index() seems to
> indicate that lockfile disposition is not handled automatically in
> case of error (unless I'm misreading).

As mentioned elsewhere in this thread: an atexit() handler is tasked with
rolling back uncommitted lockfiles.

Ciao,
Dscho
