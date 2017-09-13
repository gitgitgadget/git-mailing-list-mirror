Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF01E20286
	for <e@80x24.org>; Wed, 13 Sep 2017 23:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdIMXaK (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 19:30:10 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:46980 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdIMXaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 19:30:09 -0400
Received: by mail-it0-f51.google.com with SMTP id 6so1017925itl.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 16:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DFKH57SajQttZ3rmxRPl6g1ieEoY+3fHhb3GJF7Z++s=;
        b=DhgKM/TLlHnyd+5HYDhgza6Q5SYpmMroikaG3zgoBD8E2gYbnQ7ydaotvFqtXDqXiA
         eD7eJFBA+GjHV+S15ug93ax3XMQDduBYwy5PCnt5pXu/e4NUIZIxdhkyZNV7+WLR+77P
         DleI/zDHOTmI4lAPZrdvYmgoS/EEjysqD0n5Vx7YoNX0DFO68qXQkP5Se+OCmnSsEsvo
         GaASGWt74b3kS9nV584/um8SPuIjnRCUyVovtSD5eI/ktkLFtSVwHvaBUnnUO/KAgC6E
         0mcUDOddI2wU5jMTUbF26AcfAFcGRgz44a1lEo7Ci+949eGr98MN8g904HrgZd7edEUe
         cVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DFKH57SajQttZ3rmxRPl6g1ieEoY+3fHhb3GJF7Z++s=;
        b=aR0rPJ3QEUOjDWOS3A/k6JUlqw8iw7+MNBWwOpJRmjMXSl6h/yTNIA9cwLXs2voWzO
         fb9aXb3C8QbHZbgLpncfFaa9uFYEA918E+60PWJTp7+/GiE9mWrucquOcTBUICO+bLnN
         RRfoQk7UCD08yhjpa5yuF6N7o8e3e7Dias9F2DwBrz6acBBCF1Qvy2HR1bbi8fk6DnyE
         cNjwhZPondzv87NebyONCjHJI+nLCnRG31IOK0LH9wVz3dLx4+5ORkTPtFQiyVYdw4nM
         ZEmvcIWLGOXzSiw5ihTkzWKq8O7LyxvRRoe5xHG1Ek6G5pLIeEjGTgBPzw1CtwRDTVSf
         d65A==
X-Gm-Message-State: AHPjjUjXk11TK4DwMkhlW3HDoeuMyp18jfkFduZSXoTbEJmrhVmqbI3G
        /ve6vejdGYq5OEP0kr5rEMDMS76CXGQvw3pmSGQ=
X-Google-Smtp-Source: AOwi7QCvw5aW9obJ9XS3/a2uWqtZ3EzdNphwRPBP1zWTBvWGow7AYRUHODtjhXe9KV8zOyo1cJwf3jVpBksnH76GiFA=
X-Received: by 10.36.199.130 with SMTP id t124mr731668itg.2.1505345408386;
 Wed, 13 Sep 2017 16:30:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.103 with HTTP; Wed, 13 Sep 2017 16:30:07 -0700 (PDT)
In-Reply-To: <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com> <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Sep 2017 16:30:07 -0700
X-Google-Sender-Auth: OID_YOGoLhUVs2-wxA83ZPeYj_M
Message-ID: <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
Subject: Re: RFC v3: Another proposed hash function transition plan
To:     demerphq <demerphq@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 6:43 AM, demerphq <demerphq@gmail.com> wrote:
>
> SHA3 however uses a completely different design where it mixes a 1088
> bit block into a 1600 bit state, for a leverage of 2:3, and the excess
> is *preserved between each block*.

Yes. And considering that the SHA1 attack was actually predicated on
the fact that each block was independent (no extra state between), I
do think SHA3 is a better model.

So I'd rather see SHA3-256 than SHA256.

              Linus
