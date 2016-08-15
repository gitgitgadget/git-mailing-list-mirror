Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55C7F1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 18:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbcHOSyz (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 14:54:55 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34651 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbcHOSyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 14:54:54 -0400
Received: by mail-io0-f181.google.com with SMTP id q83so87526076iod.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 11:54:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4iVP/zYsBGgjkwKKlyPtwfrwUYDNT2VKujmmJGVkXy4=;
        b=Nn2v7MgJhylvn1GggEePrVc0c5AbfpD3+jKT0P2mU3GtGZGy5PpxIhMU1oZKwzcYfs
         5DwXul7IFB+cW9ySU/29rf+VN3DTtW7Vt7pyu1hQmjS9m4vHEldDbvVbnmuUQF1PIFQ3
         SWroXo9Ww3YiKuUcUrccnEcnn9adLrluYd2Ca2Qh/X/O5rmwIYkmgYviVuY11B42qyJS
         Gpy8IvMCg3MEA64kpYGo2CSRUJi2U1dumQRmPTkiCpmS3sl9WXfgUG62uGrrf9FjJCux
         lnfm7CVW3oU5wDHEzTnqbvA4NIZrJr0LPe4RhfeiibOWyAPJrTyFJsDvgQIvJ3CGPQMh
         6yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4iVP/zYsBGgjkwKKlyPtwfrwUYDNT2VKujmmJGVkXy4=;
        b=FL/Sp+F3dA8/zZ+K3hv0du5ywVpluDV1URdmR82JFRn4fdrMr6ew+uqOYMWkLQWY3P
         qktxbiC56LlCmzKxuCXbW82yj3XqZCjCn6qNzJvx+LxU0qnHs1uREDmYTOJqReq4hd32
         X3f4FjxokzpHXiK4ckkjaX4RnDoEa3p6E8JmUcVjbsySzSXQQS/O4yi9Cf2tTZQwxQiZ
         BuJBTicqWH97lgXthY1M9Gy8d+zBd2y7cedYiYR4HLV9qDXeoDEbwBNnIKj02qQdyMvT
         01J09xuJM8zR+cizvKVbMWO/gf0Cu7QGN08JiCs7lAmV27s51ONk+ewbTyPWmOMSdR3K
         mmOQ==
X-Gm-Message-State: AEkoousd+hiqWyES/2reTX1oXd1IKLdhfQ47uk29rWXmTj89ATtxMAD/0Pq3fLoAACNJOo4fqrdJW7k0k2LJsvha
X-Received: by 10.107.131.38 with SMTP id f38mr725451iod.173.1471287293733;
 Mon, 15 Aug 2016 11:54:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 15 Aug 2016 11:54:53 -0700 (PDT)
In-Reply-To: <20160815184730.eevqogqrxp2zp43q@sigill.intra.peff.net>
References: <20160815184021.12396-1-sbeller@google.com> <20160815184021.12396-2-sbeller@google.com>
 <20160815184730.eevqogqrxp2zp43q@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 15 Aug 2016 11:54:53 -0700
Message-ID: <CAGZ79kZq=dPsngaqAVOj6UhaJE0=eR==XSTSSQCmcUTKugeM0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkout: do not mention detach advice for explicit
 --detach option
To:	Jeff King <peff@peff.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 11:47 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 15, 2016 at 11:40:21AM -0700, Stefan Beller wrote:
>
>> When a user asked for a detached HEAD specifically with `--detach`,
>> we do not need to give advice on what a detached HEAD state entails as
>> we can assume they know what they're getting into as they asked for it.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>  Junio writes:
>>  > It might be controversial how the second from the last case should
>>  > behave, though.
>>
>>  I agree. I think if the advice is configured explicitly we can still give it.
>>  That makes the code a bit more complicated though.
>
> So....I guess. But has anybody in the history of git ever explicitly
> configured advice.* to true?

An admin/teacher of a university that wants to teach Git to students
in a class? Better be safe than sorry and explicitly ask for advice because...
we cannot trust the default?

>
> It has never produced any change of behavior, and the whole point of
> "advice.*" was that git would advise by default, and you would use
> advice.* to shut it up once you were sufficiently educated.

And now I am arguing that "by default" we should not give advice 100%
of the time, but only when we think it is appropriate. You may disagree
(as a teacher see above), so you can slightly change the setting to give
out advice more often again?

>
> I don't think doing it this way is _wrong_. It just feels sort of
> pointlessly over-engineered. It's also a little weird that all of the:
>
>   if (advice_foo)
>
> will trigger because "advice_foo" is set to -1. I think it does the
> right thing, but it feels like a bug (the value is now a tri-state, and
> we silently collapse two states into one).

I think this is what I did in some of the submodule code as well, which
is why I assumed it's ok (or rather the projects groupthink on how to do
"default on but still different than explicit on")

If you think this is wrong, what is the idiomatic way to solve this problem?

Thanks,
Stefan


>
> -Peff
