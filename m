Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395461FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 15:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbcGLP0O (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 11:26:14 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34791 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbcGLP0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 11:26:12 -0400
Received: by mail-yw0-f176.google.com with SMTP id i12so16698831ywa.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 08:26:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lodNvigM6f1UqH/f/sWDsRYKJomu8CU02Maa7NAN+iU=;
        b=0nUAy6CfHq64V7kudd0YVv5Fl60OjfkayKxLHgee+pFAldiKIN1+cNDYu/iZLv/KBm
         r5Xod2Wm/EZd2ZPQVoXg5beqlJwDdseGIAWoEP8KDsOGePN/lNFrhfDQXj6xAnjl4PCz
         lsoY6rgbwp5uYluE3qHuWGVYakEN4E8w3UQGZxOd3AOjsjCDZd+He0Xsmrhh/07+jwth
         vUlzKVZ/PM3Gn8EOqnNWEql0/d9uNDDzd/OdUWhLHl5tpceKG/dw0TbhOu8f9l1e9ZE8
         RE5ln+8LYfzCAV2CsZg/NSHOYAFTovbBVUs9tsNY5bwZrQKP0Cbj/wBvfPVsw6VD8DGo
         6kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lodNvigM6f1UqH/f/sWDsRYKJomu8CU02Maa7NAN+iU=;
        b=JfF+PhgsLolDr2yEVXIxWRtORAqlQNl7JyjII1h1flmtlT860qHV2KOKzH+/Oq0fcR
         zJ3LC12zflgvD3HcZWxuHGKdNI0nHzWqaGzpZA3X/NdRTEasmBzBL4juZWZVUo+w8jGw
         3ueyJSyWcCqsSVUjWq7RkYYe+OT7ML4VcQyPfsbdxTVUb+LyA3JjesIv+VV3A+MEraNQ
         nFmz3C7HzySXK72KGgDbQzFNzag67domyVWCDr49fjVqq/k6NzgVvWwftHv7XpTCbmLi
         dYlT4/Ue1zlkgXhqCWvJs+gBhrylLGs+N3XZb8Lxfr1Bbasd2fLxtwyrDH96qC+J9Qo7
         zkuQ==
X-Gm-Message-State: ALyK8tKsBNRW+1oZbHjas/eSM5FGQcDWtnP6PmKLYjSVmpDDCxQZJz1fGZlV7/VHM92K8nQZYzWAw34M3Fdtcg==
X-Received: by 10.37.118.130 with SMTP id r124mr2041967ybc.80.1468337171437;
 Tue, 12 Jul 2016 08:26:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.240.66 with HTTP; Tue, 12 Jul 2016 08:25:51 -0700 (PDT)
In-Reply-To: <20160712151630.GE613@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607120927410.6426@virtualbox> <xmqqpoqj6i3d.fsf@gitster.mtv.corp.google.com>
 <20160712151630.GE613@sigill.intra.peff.net>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Tue, 12 Jul 2016 08:25:51 -0700
X-Google-Sender-Auth: zfryYiPegO12fQ70XDRcIjKNbkc
Message-ID: <CAPc5daWcb5bfgsxMP0vCrQ7gBdeYBgefzPNHztaaCKzqbCv2aQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.9.1
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 8:16 AM, Jeff King <peff@peff.net> wrote:
>>
>> But moving the internal time representation used in various fields
>> like commit->date to time_t is likely to be a wrong thing to do,
>> because the first problem with "unsigned long", i.e. "may not be
>> wide enough", is not limited to "not wide enough to hold time_t".
>> It also includes "it may not be wide enough to hold time somebody
>> else recorded in existing objects".
>
> But that's a problem no matter what size we choose.

Yes, if somebody's time_t is larger than my intmax_t, the problem
cannot be solved for me, if that timestamp is too far in the future or
in the past.

But that is not the problem I am pointing out. I heard earlier in the
thread that time_t on one system was 32-bit (was it Linux?) but I think
they have "long long". Choosing time_t is strictly inferior choice when
we already know that a platform with not-wide-enough time_t need to
be supported, and a type that is wider than that is available.

I was envisioning that we would have typedef <sometime> gittime_t
with conversion helpers between it and time_t that allow us to do some
range checks while at it.
