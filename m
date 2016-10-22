Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 977E01F4F8
	for <e@80x24.org>; Sat, 22 Oct 2016 09:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936612AbcJVJTG convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 22 Oct 2016 05:19:06 -0400
Received: from elnino.lfos.de ([46.165.227.75]:3236 "EHLO elnino.lfos.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S936463AbcJVJTD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 05:19:03 -0400
Received: by elnino.lfos.de (OpenSMTPD) with ESMTPSA id 5e77faef (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sat, 22 Oct 2016 11:19:01 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     git@vger.kernel.org
From:   Lukas Fleischer <lfleischer@lfos.de>
In-Reply-To: <CA+P7+xq25LcdmtzmBNChiGhGratcdp7m0EOsQuEh68=gJQ9HNQ@mail.gmail.com>
Cc:     "Jeff King" <peff@peff.net>,
        "Git mailing list" <git@vger.kernel.org>
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
 <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net>
 <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
 <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net>
 <xmqqa8dzhtki.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq25LcdmtzmBNChiGhGratcdp7m0EOsQuEh68=gJQ9HNQ@mail.gmail.com>
Message-ID: <147712794056.12237.1478296296628149440@typhoon.fritz.box>
User-Agent: alot/0.3.7
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
Date:   Sat, 22 Oct 2016 11:19:00 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 20 Oct 2016 at 19:27:58, Jacob Keller wrote:
> [...]
> I still think we're misunderstanding. I want git commit to complain
> *only* under the following circumstance:
> 
> I run "git add -p" and put a partial change into the index in <file>.
> There are still other parts which were not added to the index yet.
> Thus, the index version of the file and the actual file differ.
> 
> Then, I (accidentally) run "git commit <file>"
> [...]

This reminded me of something that bothered me for a while. It's not
100% on-topic but still quite related so I thought I'd bring it up.

When working on a feature, I usually try to make atomic changes from the
beginning and use `git commit -a` to commit them one after another. This
works fine most of the time. Sometimes I notice only after making some
changes that it might be better to split the working tree changes into
several commits.

In that case, I git-add the relevant hunks and then, unfortunately, I
often run `git commit -a` instead of `git commit` (muscle memory bites
me), so I need to do all the splitting work again.

It's not much of an issue but would it be worthwhile to add an optional
feature (configurable) that warns you when using --all with staged
changes (which are not new files)? Are there others having the same
issue? Do you think this should be implemented as part of an alias
instead?

Regards,
Lukas
