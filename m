Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06031F859
	for <e@80x24.org>; Tue, 16 Aug 2016 20:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbcHPUoM (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 16:44:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53786 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbcHPUoM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 16:44:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F121F859;
	Tue, 16 Aug 2016 20:44:11 +0000 (UTC)
Date:	Tue, 16 Aug 2016 20:44:11 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
Cc:	meta@public-inbox.org, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20160816204411.GA31448@dcvr>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <xmqqa8gcej1p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa8gcej1p.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
> > * Should the public-inbox offer another link to patches 1-n, without
> >   the cover letter? Or should it add instructions:
> >
> >         If this is a patch series you can apply it locally as:
> >         curl <link> >tmpXXX
> >         git am tmpXXX && git am --skip && git am --continue

Currently for web users, I suggest:

	curl $URL >tmpXXX

	# open tmpXXXX and tag+copy to patchesXXX using MUA of choice:
	# (also seems to be what Jeff describes):
	mutt -f tmpXXX

	git am patchesXXXX

> I do not think it is sensible for "cover-letter" specific
> instructions.  However, I do not think it is unreasonable to either
> add another mbox.gz link or replace the behaviour of mbox.gz link so
> that you can grab a mbox that contains "this message and everything
> after it in the thread".  That way, I could open the first message,
> see something like this I found in your message:
> 
> >> Thread overview: 4+ messages in thread (expand / mbox.gz / Atom feed / [top])
> >> 2016-08-15 23:06 Jacob Keller [this message]
> >> 2016-08-15 23:07 ` [PATCH v6 1/3] diff.c: remove output_prefix_length field Jacob Keller
> >> 2016-08-15 23:07 ` [PATCH v6 2/3] graph: add support for --line-prefix on all graph-aware output Jacob Keller
> >> 2016-08-15 23:07 ` [PATCH v6 3/3] diff: add SUBMODULE_DIFF format to display submodule diff Jacob Keller
> 
> and then go to 1/3 and click that "this and everything that
> follows".

Adding more links might still fall down in cases where
fixup/squash patches are sent for specific patches in a series;
or when a v{N+1} series is posted in-reply-to an existing
series.

Perhaps adding checkbox next to each item might work as a
select-to-include-in-mbox download form.  However, I'm already
finding the lack of horizontal space disconcerting.

Maybe the YYYY-MM-DD could be shortened to YYYYMMDD.  It would
be closer to the date searching syntax used by mairix, as well
as the search enhancement I started working on earlier today:

  https://public-inbox.org/meta/20160816084926.29394-1-e@80x24.org/T/
  (still will deploy soonish)
