Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33592018E
	for <e@80x24.org>; Sat,  9 Jul 2016 15:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742AbcGIPnF (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 11:43:05 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37809 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751579AbcGIPnD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jul 2016 11:43:03 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jul 2016 11:43:03 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 00B8E200F0
	for <git@vger.kernel.org>; Sat,  9 Jul 2016 11:34:20 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Sat, 09 Jul 2016 11:34:20 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=vJV24
	xrtlkgjePtgX/Ioi9V61wo=; b=h8/5+UCMWVmlPYimAkSvJi+AvF3O5C/nyEr5f
	ANajgX3q9jbptiDFrVWmqNa33wErjHapO8CsR8TdwJ/WJ1z6WUPhLeQR3cuwQjtr
	OIVOq1AlNvNWqVBLQijSIxUcwyN8uWNUvL0kEzu67PfmFIjkN0Nuw1Vn789ZNNFU
	TCfgEs=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=vJV24xrtlkgjePtgX/Ioi9V61wo=; b=jFpw7
	JibKJRJXvbofxXx3OH1fzBPAjFEzwjCTNhtM1RO4zTpoU/o674quHOFz1R4Ud6oI
	4c8AEKByx1j2yvUwsxxig56tmA81x25/atIRJss7rkCpAvVzngZgoN4XCe9EU+T9
	PKXm5e6uezT46Kd/v9uSrJE0REmEbSAmBqYT1g=
X-Sasl-enc: t/adigcsR21JJQlvhihTBJ1AN75+ElEATbHKrfHJaTLY 1468078460
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com [209.85.215.47])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9DBE2F29F3
	for <git@vger.kernel.org>; Sat,  9 Jul 2016 11:34:20 -0400 (EDT)
Received: by mail-lf0-f47.google.com with SMTP id h129so44899845lfh.1
        for <git@vger.kernel.org>; Sat, 09 Jul 2016 08:34:20 -0700 (PDT)
X-Gm-Message-State: ALyK8tIDYhscQlhPL3yksXa9kY8F2oP6tpqEs3nXkSvPMvSEcTeB4ScA6DrdnJHxjVqJLVEp40iSW//3IMVolA==
X-Received: by 10.46.5.13 with SMTP id 13mr2823745ljf.66.1468078459542; Sat,
 09 Jul 2016 08:34:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.23.4 with HTTP; Sat, 9 Jul 2016 08:34:18 -0700 (PDT)
In-Reply-To: <CA+P7+xpVbSbHP-j1c+zQjMALb_C5eOb-c23290AbVjufxOHqoQ@mail.gmail.com>
References: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de>
 <20160705202820.GA14496@sigill.intra.peff.net> <20160705204447.GB14496@sigill.intra.peff.net>
 <CA+P7+xqODaXn2NFY-=Ktr1stzR1mu6_ZO7Lfgj7AEzhzxhLAbw@mail.gmail.com>
 <alpine.DEB.2.20.1607060857240.6426@virtualbox> <d1e0e688-a309-2a01-4ee2-c1af9d71cea0@drmicha.warpmail.net>
 <alpine.DEB.2.20.1607061514200.6426@virtualbox> <CA+P7+xpVbSbHP-j1c+zQjMALb_C5eOb-c23290AbVjufxOHqoQ@mail.gmail.com>
From:	Michael J Gruber <git@drmicha.warpmail.net>
Date:	Sat, 9 Jul 2016 17:34:18 +0200
X-Gmail-Original-Message-ID: <CAA19uiQLBUyrdrk6w4kZ572cEdEDNqm30J6Ut3yemU4Rwx6Qcw@mail.gmail.com>
Message-ID: <CAA19uiQLBUyrdrk6w4kZ572cEdEDNqm30J6Ut3yemU4Rwx6Qcw@mail.gmail.com>
Subject: Re: Over-/underquoting, was Re: [PATCH] revert: clarify seemingly
 bogus OPT_END repetition
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

2016-07-06 22:15 GMT+02:00 Jacob Keller <jacob.keller@gmail.com>:
> On Wed, Jul 6, 2016 at 6:16 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
...
>>> It is not unheard of that a MUA can collapse and expand properly quoted
>>> parts on request...
>>
>> Sure. Show me some kick-ass, scriptable mail client and I will have a
>> look.
>>
>
> Yep, I haven't found a mail client that really works for me either :(

Every other day I want to get rid of Thunderbird... always on the
verge of going (back) to mutt, though I do need some calendar
integration and such.

Until the day when the scriptable mua we wish for comes upon us, may I
recommend the "QuoteCollapse" extension to Thunderbird that transforms
those huge quotes into neat short headlines with a twist(y).

Michael
