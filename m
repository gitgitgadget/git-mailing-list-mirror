Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261791F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149AbcHCUAi (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:00:38 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33648 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518AbcHCUAe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:00:34 -0400
Received: by mail-io0-f176.google.com with SMTP id 38so253651260iol.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 12:59:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t++Nx27v3SY9mC7JL703wUtOTpI4MSw+Iy/q85ni5W4=;
        b=lI/4k/hIbCkb2lTrORnPSduGNUwIdItm/VPXXpvumYXV9dk/ps2HZ3IyiH1BklX/wm
         nt2J41vIhUfFnSAEGAszrzIvBkNKONV7Yu6LpGiUdjv5BnoiQ3h/qpyNO1WF+K/X/yy7
         APZE58iZ8CQ9vsx8pYimwz15aH7ZWoz2xMvWeXsdn63dF7hcudn4mbect/AshIW0aDaR
         7o1brbNAaJpEeHGKECvCaDQB6RWCjYXEQ2n6hg+mMFfyVpZBipNCxbcdOLYLa4eo+5xk
         7btNUmk0JzO10hjdEBRiCyaJTuu2Kcnv5HznY9M2UPLYb1DUrryOjGqDGiWIA4bJjlLu
         jMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t++Nx27v3SY9mC7JL703wUtOTpI4MSw+Iy/q85ni5W4=;
        b=OhexOt1F2JIk+TkCmOMtore3v6fw80RqOhoRDG+OPgS21BdLrY9WxvsdRKYyMNItXS
         FSQIMjouttOHJ8+mjKDnW6Btu4kGHE89tP8MrqXCanWR8jh/8YZOIMrwpRbQT4r6FB+X
         H9m3OME5oT1XPY1aU/ptHNgvWPt1+3HgSYn9FTeemg8iENlbQWWTWSrGNUHSkNtsO/6V
         i57njteTqCDaEV4n/3nk1kqA2vTGhacIbslfj0ahT47dRQGQsTKqXi7EKYqaset8MX9c
         68QqvELTO9YLv4iDJOZec3FsGHAYsE8UhmCkZhb+rJUvAKDCn+jYXjfQbVMwVYTsI+p3
         yq3w==
X-Gm-Message-State: AEkoouuoMCm7C1zMSA/MQAXfSwrvv7BxPjO1FL0MLrn0alDeJYpSxjHi82AxmwY3L3GephuvC0QAciuBYGuwvjz8
X-Received: by 10.107.131.38 with SMTP id f38mr72591864iod.173.1470254374422;
 Wed, 03 Aug 2016 12:59:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 12:59:34 -0700 (PDT)
In-Reply-To: <20160803194913.cz6xiai3g5r3sghq@sigill.intra.peff.net>
References: <579CEF77.9070202@web.de> <20160801164723.mober7em6znt56w4@sigill.intra.peff.net>
 <xmqq8twgi4qp.fsf@gitster.mtv.corp.google.com> <20160801211131.6ernsu74ohod2cin@sigill.intra.peff.net>
 <xmqq60rkglym.fsf@gitster.mtv.corp.google.com> <20160803191334.jflia6cqxqx2uqjx@sigill.intra.peff.net>
 <CAPc5daVABao1UZdPk0BnJNkTtYYV74Tw_0CZ9-uj9sK92h+x7g@mail.gmail.com> <20160803194913.cz6xiai3g5r3sghq@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 12:59:34 -0700
Message-ID: <CAGZ79kYonA8pYfW68SC6YaZ84Gz2Eo_qXDxQJ14_62abcd8-Og@mail.gmail.com>
Subject: Re: [PATCH] pass constants as first argument to st_mult()
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 12:49 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 03, 2016 at 12:41:30PM -0700, Junio C Hamano wrote:
>
>> On Wed, Aug 3, 2016 at 12:13 PM, Jeff King <peff@peff.net> wrote:
>> > On Mon, Aug 01, 2016 at 03:31:45PM -0700, Junio C Hamano wrote:
>> >
>> > I think in my head I rewrite any multiplication like "N of M" as having
>> > "N" as the smaller number. I.e., it is conceptually simpler to me to
>> > count five 30's, then 30 five's (even though I do not implement it in my
>> > head as a sequence of additions, of course; I'd probably do that
>> > particular case as "half of ten 30's").
>> >
>> > I have no idea if that's cultural or not, though.

Well I think there is a difference between how you do the math in your head
and between the textbook question.

In textbook I would expect 5x30, because first we need to talk about the
object before the price of the object makes sense:
"I am interested in 5 apples, and each apple costs 30 yen, so I am paying
150 yen". Only that in Europe you would substitute the 30 by 0.84 Euros
(integer-> number with 2 values after comma, not quite a float).

When doing the math in your head you look for the easy tricks, i.e.
x5  = x10 /2 or such.

I think I'd find calloc intuitive as a typical textbook question, "I
want to have
space for "foos", which each cost 5 memory, go figure out how much I need
and hand it back to me".
