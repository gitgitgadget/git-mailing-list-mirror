Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AED32035F
	for <e@80x24.org>; Tue, 25 Oct 2016 13:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758563AbcJYNDR (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 09:03:17 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34195 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754077AbcJYNDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 09:03:16 -0400
Received: by mail-oi0-f46.google.com with SMTP id t73so97087221oie.1
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 06:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H3oifYGZKV7VvoNQp3Z2PDLvc5JJGO3hqbcNwsnmR5Y=;
        b=UWYxPEw2IFEZbH/E3Y74q4WoHzLGisfoCLnpt6exWSh/YXZhoqhC4GypU5nuFMQDAy
         sq6Gj77J4VeqUrPGUcs0Cc2wiexvu9zKy/p6PIalGAjh+H4PGNJlkqifypAFURmNVHDs
         btzLR4dTclBpBNWjn5SAJdKwLKJigc9uz9O2ZFg+hy/Af0FPgQDYE9t97W0iP0QeTKVd
         cktYzUSP6dcGk3snCWsyZ456JMMYLHXXaeyI4o28uD56TE7L7UTVRFJ1e9RIojxnWlxM
         OttILDK43xvfLew+h2S0PzQ0uvcAD5riyLDcpxl3MzM9kDagMg65RMuQgTWI1MP3KQ2Q
         bA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H3oifYGZKV7VvoNQp3Z2PDLvc5JJGO3hqbcNwsnmR5Y=;
        b=GxSwVuGee+hu2g9Ovbod9s1vF02IqOTpsEag+PvaAUL7RpDPif/aHEZsqVBn6pQzCQ
         r6Ws77Ta9FDyu0kMR2KD90rM4nM5QpmlyH+U/42XATDuLC8ZeaNgoJt7TEwKiqF/6kcS
         EuFkbSgJ07ivCpmWZ9CV/erQsPiaI2XHLQn8gh6EYZD7hYMAyy+VFkddYJr2WtfpqHTx
         TwYEqqqOrKHHumkLzY83K/I4UDs2C3gWHHffRVf2uMsyZWsIEG4//NIniuQ/3NXn//Wz
         Cntsk0QlK6+Zk7t9MI9U0fGnMXMNCDVupMIp3cg68zA8OuARuK1FjcjdxJ45x3eCOP7C
         cupA==
X-Gm-Message-State: ABUngvcnN4GcUfnxAgrrNl9CBqlngnebXDF10Y2JiQygR6sFJcV3/3gXblEgqkEy1H5LLzmxoM/gioThE2NWHg==
X-Received: by 10.107.44.17 with SMTP id s17mr16086711ios.212.1477400595705;
 Tue, 25 Oct 2016 06:03:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 06:02:45 -0700 (PDT)
In-Reply-To: <20161025125856.p2paxt7erl2szptv@sigill.intra.peff.net>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee> <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee> <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net> <CACsJy8CroyynVMctbPhuVr2VVQB7YyfcxDaMT25BikQ4R4We0Q@mail.gmail.com>
 <20161010142818.lglwrxpks6l6aqrm@sigill.intra.peff.net> <CACsJy8B_AQxm1=vF8i4FPtinq0id1QZPrqp9vvAmAgUns_kgGg@mail.gmail.com>
 <20161025125856.p2paxt7erl2szptv@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 20:02:45 +0700
Message-ID: <CACsJy8AdwpoTRaaPBtmwipRP84Q=kUAabagYeMkHmT2kE3m+pw@mail.gmail.com>
Subject: Re: %C(auto) not working as expected
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 7:58 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 25, 2016 at 07:52:21PM +0700, Duy Nguyen wrote:
>
>> > Yeah, adding a "%C(enable-auto-color)" or something would be backwards
>> > compatible and less painful than using "%C(auto)" everywhere. I do
>> > wonder if anybody actually _wants_ the "always show color, even if
>> > --no-color" behavior. I'm having trouble thinking of a good use for it.
>> >
>> > IOW, I'm wondering if anyone would disagree that the current behavior is
>> > simply buggy.
>>
>> Silence in two weeks. I vote (*) making %(<color-name>) honor --color
>> and turning the %(auto, no-op, for both log family and for-each-ref.
>> We could keep old behavior behind some environment variable if it's
>> not much work so it keeps working while people come here and tell us
>> about their use cases.
>
> Yeah, sorry.

Just to be clear (after re-reading my mail), the unwritten part after
"Silence in two weeks" was "so nobody disagreed with you", not "how is
your progress?". It's great that you keep working on this regardless
:D
-- 
Duy
