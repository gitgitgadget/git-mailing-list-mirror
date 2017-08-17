Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15791F667
	for <e@80x24.org>; Thu, 17 Aug 2017 05:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbdHQFev (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 01:34:51 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36519 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdHQFeu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 01:34:50 -0400
Received: by mail-it0-f51.google.com with SMTP id 77so26810313itj.1
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 22:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/smeS8jVH5UP52GZyxIZPOZWPMQ+/eOjQnnIeYXfdQU=;
        b=qU2sm1Bpy4xH9jOBy616yzOb2Mn+9QF/QIdD4GKUmITMhowkggicLEeNAU7EsBP2Iy
         aoOl6nS0C4WmEwuFmqbi6RPatRUbkp+eNjYYEjHdFf5Nl/s8XVMebvnzd6RVHLragAGo
         oKAZgIvaxIYR+Wyx9cV9Myh73UfoymoXOpBsK3VX6Waf167SaB72Mty069zioi+LxDCv
         eX944BcMVx6pdhuxl9aLIW/tFtyaQ8921UkI9qjUGXoSrlwaPBveuAyTttG/HH/pUA3D
         23FuVvL8b7IVh2oU5sAfPKxZN9/JBFAo+EhSL/B/FRMHCOLdYxYQL/Lc642+wn4lps6w
         WbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/smeS8jVH5UP52GZyxIZPOZWPMQ+/eOjQnnIeYXfdQU=;
        b=dRKi7faUHZEhZjBsX/ih3OO0jcmlw1Y3BOPc/OelQi6BYe0sSRXEDmtumr+Gbo6Fip
         hVla+/gIjo8/ClQ/fACuBVwO1pJ+9C4FEdDMDIpWVvrKoOmsx7Jxw611em+fIs1c3JaP
         N9+ySfkSGYC301gp/3uC5oLMY2xMGwbDihrEjx9NNesrHk5XGn1X/gVluUUimpyUSqAS
         dY+vwR6Tyk8l+QfMx4ACDx35KSJfCE4aTrz+hAhqTGwVqVG98Zdui6raPlhi1UDaCpY0
         48jifYMU01MPxAGgpCDLanr4j3CuOXqThMxpQ2dvHF7+RDw7fc+zXWkiI5Q2FSjBwB1p
         Dy2w==
X-Gm-Message-State: AHYfb5g9sNeEl9vGYgkQGRrhYiUajJE28wb6TxfThXOc374enX02CvWA
        WHfGAtf7Dn+mjri+wa1HHv/mMz9OjA==
X-Received: by 10.36.123.23 with SMTP id q23mr669542itc.69.1502948089881; Wed,
 16 Aug 2017 22:34:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.127.85 with HTTP; Wed, 16 Aug 2017 22:34:49 -0700 (PDT)
In-Reply-To: <xmqq8tijpkrv.fsf@gitster.mtv.corp.google.com>
References: <20170815173611.2267-1-chriscool@tuxfamily.org>
 <20170815111725.5d009b66@twelve2.svl.corp.google.com> <20170816002257.GG13924@aiede.mtv.corp.google.com>
 <CAP8UFD2jLdR7HTi-T6J_xWvxKyoQf_6pUTX1CWsd9v3TXh9FXw@mail.gmail.com> <xmqq8tijpkrv.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 17 Aug 2017 07:34:49 +0200
Message-ID: <CAP8UFD1H4Pb5e2_pioQ5neROc+64e55RfvRhiyz5Df5AwJg-FQ@mail.gmail.com>
Subject: Re: [PATCH] sub-process: print the cmd when a capability is unsupported
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2017 at 5:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>>> I am still wondering if protocol errors should be fatal,
>>>
>>> Yes, please.
>>
>> Unfortunately I think it would prevent new filters or new
>> sub-processes to work with older versions of Git.
>>
>> For example if filters are upgraded company wide to support the new
>> "delay" capability, that would force everyone using the filters to
>> upgrade Git.
>
> I must say that your filter is broken in that case,

Perhaps it is just sloppily written.

> and it is much
> more prudent to die than continuing.  Why is that upgraded filter
> asking for "delay" to an older Git that does not yet know it in the
> first place?

Maybe because in our tests (like in t/t0021/rot13-filter.pl) the
filter just outputs all its capabilities, so the filter writer thought
it should be ok to do the same.

> I just re-read the subprocess_handshake() codepath, and here is my
> understand.  The handshake_capabilities() function first advertises
> the set of capabilities it supports, so that the other side can pick
> and choose which ones to use and ask us to enable in its response.

Yeah, that sounds like the right thing the filter should do. Though I
think that if we really want the filters/subprocesses to always do
this, we have some work on our plate...

> The code under discussion in this thread comes after that, where we
> read the response that tells us what choice the other side made.  If
> we saw something that we never advertised, that indicates one of two
> things.  The other side, i.e. the "upgraded" filter, is not paying
> attention of the capabilities advertisement, and asking something
> its correct operation relies on, but we are not capable of giving
> that unknown feature and operate without it, so after that point the
> exchange of data is a garbage-in-garbage-out.

Maybe it is not paying attention and just following the bad example of
giving all the capabilities it supports even if it can work if some of
them are not supported.

In this case if we error out, we prevent everything to work even if it
could work if we just also "ignored" (though printing a warning is not
exactly ignoring and is the right and the least thing to do) what the
filter told us.

Anyway I don't really mind being very strict and just erroring out in
this case, but I think we should then emphasize more in our test
scripts (maybe by giving a good example) and perhaps also in the doc
that the filters/sub-processes should really pay attention and not
output any capability that are not supported by Git.
