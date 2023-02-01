Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5539C636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 22:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjBAWrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 17:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjBAWrj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 17:47:39 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1AC6DB0C
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 14:47:28 -0800 (PST)
Received: (qmail 6340 invoked by uid 109); 1 Feb 2023 22:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 22:47:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25114 invoked by uid 111); 1 Feb 2023 22:47:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 17:47:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 17:47:26 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rafael Dulfer <rafael@dulfer.be>, git@vger.kernel.org,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Rafael Dulfer <rafael.dulfer@gmail.com>
Subject: Re: [PATCH] rev-list: clarify git-log default date format
Message-ID: <Y9rr/hfnrV2zmyWf@coredump.intra.peff.net>
References: <20230201155712.86577-1-rafael@dulfer.be>
 <xmqq5ycl1c6h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5ycl1c6h.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 10:19:02AM -0800, Junio C Hamano wrote:

> > -	- there is no comma after the day-of-week
> > +	- There is no comma after the day-of-week
> >  
> > -	- the time zone is omitted when the local time zone is used
> > +	- The time zone is omitted when the local time zone is used
> > +
> > +	- Day-of-month and month are switched around
> > +
> > +	- Time-of-day and the year are switched around
> > +
> > +As a result, the format looks as follows: `Thu Jan 1 00:00:00 1970 +0000` with `+0000` being omitted when the local time zone is used.
> 
> All of the above may technically be correct, but I wonder if it
> makes it easier to follow to simply stop saying "is similar to".
> That is
> 
>     The default format `--date=default` shows a single line with
>     three-letter day of the week, three-letter month, day-of-month,
>     hour-minute-second in the "HH:MM:SS" format, followed by 4-digit
>     year, plus timezone information unless the local time zone is
>     used (e.g. "Thu Jan 1 00:00:00 1970 +0000").
> 
> or something like that.

Yes, I agree with your suggestion. When you can explain something as
"like X, but Y" it is helpful when Y is short. When it becomes much
longer, than simply spelling out what X is becomes more helpful.

-Peff
