Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850E41F453
	for <e@80x24.org>; Thu, 27 Sep 2018 08:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeI0PPg (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 11:15:36 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:37412 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeI0PPf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 11:15:35 -0400
Received: by mail-wr1-f46.google.com with SMTP id u12-v6so1689764wrr.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 01:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Hp5EzQUGCJ5e+Itt8S0vFo3o7v1PnG+8aW6woWor95w=;
        b=g7b70WFMRV7jxrlPITJceK3Wvw4c1C5tz4+wMrHgmmmBEjOFYEZTjg6AUQVgGm8kzP
         cLW6T8mNSL5BNl14TjUhM8kMJmL4IZ8pf54gLt0+9NPOhxvUOW3DB73J7GTLyWKceCwO
         vNYY5/bhQRsS8o0Yuu95rtZqqqJlDFh5UmNfHzn6KqkyN8ymmlux6QZRenOhzxISZwPt
         ObmVHAvitw3eZHnIXZzojENi/J74Nfvzz2HZ06RxsWaVDmRO36fUsuoRgBt94NmW/5Ap
         uj5Dxn2wo+NalDH7R3sWNYwRjGNC2MWMt7OE7jHiRjLZhs50pygIU1gtstKZSQGFYXP9
         7eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Hp5EzQUGCJ5e+Itt8S0vFo3o7v1PnG+8aW6woWor95w=;
        b=pDs0iv3hZR5UQyb1rxY7ngiLkZwaGOKbuwPyB47gY4ldTqgbwavu/h7UYGeqImD27L
         RfoGci8OAkGSbJK6cnbD9N2pFQ3+WbiVAzZ3fI3v/e2FzZPOBSiTkUUwK3quMOofNZA6
         mNdrORoYxq9j9rSgZ/vUMhmV+zyR9UL5qu7L+WyWVy1VLsWOcyVlJpmQkq7kRl2xKJdu
         mFJ+gjwLMoqdOxU8CK+xO683TaW3iioL9U2kuH2LUvUEip1yx1foVYf9zp3Jufr2FINR
         3L7mBV/PbwRovJOIrdz43JLXmCe5nT3T8vRwiyc0MqkJds/AT9w3b08gLAJ/ay0QRodX
         hZQA==
X-Gm-Message-State: ABuFfogOecTa5pq93tBtyqbfJyuZjFygk5W5U4K+ourLNhL7tdt7SYwh
        l1o4jVxhUNAydJhAOZwiQNw=
X-Google-Smtp-Source: ACcGV60tgOH0N6Zj04KFCCqDE0/LSSQMmeAw4fxD1IyghJbAtq9BvyfRNWcfudGDOCzFeh3ifz/3SA==
X-Received: by 2002:adf:e109:: with SMTP id d9-v6mr8106636wri.42.1538038702888;
        Thu, 27 Sep 2018 01:58:22 -0700 (PDT)
Received: from evledraar (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id v106-v6sm2220105wrc.85.2018.09.27.01.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 01:58:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>
Subject: Re: On shipping more of our technical docs as manpages
References: <20180921223558.65055-1-sbeller@google.com>
        <20180921223558.65055-2-sbeller@google.com>
        <87h8ihk7sl.fsf@evledraar.gmail.com>
        <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
        <20180926041517.GA2140@sigill.intra.peff.net>
        <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
        <87d0t0jghm.fsf@evledraar.gmail.com>
        <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
        <87a7o4je0t.fsf@evledraar.gmail.com>
        <20180926185812.GD30680@sigill.intra.peff.net>
        <878t3oj8em.fsf@evledraar.gmail.com>
        <CAGZ79kZOZL24Q=L-XkdrKRMjNg=dynQ+67qyD+iceg7GLru3yw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAGZ79kZOZL24Q=L-XkdrKRMjNg=dynQ+67qyD+iceg7GLru3yw@mail.gmail.com>
Date:   Thu, 27 Sep 2018 10:58:21 +0200
Message-ID: <874lebjp02.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 26 2018, Stefan Beller wrote:

> On Wed, Sep 26, 2018 at 1:44 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>
>> > And if we were going to generate something external, would it make more
>> > sense to write in a structured format like doxygen? I am not a big fan
>> > of it myself, but at least from there you can generate a more richly
>> > interconnected set of documentation.
>>
>> It's useful to have a single authoritative source for all documentation
>> that's easy to search through.
>
> If that is the case I would propose to keep it all in header files and
> organize the headers.
>
>> That includes stuff like perl585delta(1) which we'd stick in
>> Documentation/RelNotes, and "Internals and C Language Interface". Most
>> of what we'd put in Documentation/technical/api-* & headers is in
>> perlapi(1).
>
> This seems cool, but was also a recent introduction?
> perl400delta seems to yield nothing for me (which may be because
> I do not have an old version of perl installed?)

Depends on what you think is "recent" I suppose. Perl 5.4 is the first
version where deltas in POD format started being maintained
consistently, that version was released in mid-1997. Perl 4 was released
in 1991, see "perldoc perlhist". So ~everything consistently in POD has
been the case for ~20 years.
