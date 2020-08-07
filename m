Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64284C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45DBE2224D
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgHGWUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:20:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38228 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgHGWUm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 18:20:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id a14so2960200wra.5
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 15:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZboSiXQvbpEf0qjGjqUbNOmSX3tRWMTT9UrFyMHX0I=;
        b=o2BQz1KhoEKCrT/LiiMZPAluu8q3bvHi3zhIJUEytTDcfvyGXxXWcf9YLoJIU/rfVX
         J0atCbPx+ckYRuTbiAq+kE3Ultgasv6YrzBdUpjZnFIBXktlGaTI2uEgx46IjGjtp43r
         HQ1DV1Sq33byErI/6jRvLbIfbXrQ3JvIQb2htjMeh3NopK/atLzOYJ/tpWiz+l27REXA
         Ioy16nBusJQG71li5S+dC2P264YD71y2MuU5O34go8GncuiY4iGUKvzJCdNkl/i9Rk49
         LoX7uACpQ/UVGMTldvOCAvuXx5y9TZ9/Fv7MFE6RooPyvBXunJCcr7a52QqGz3NHtCU+
         WvEA==
X-Gm-Message-State: AOAM533tDtYGofRU4aR9ejO1fH/SKHEdC4jTePo+xBoCPaVX9UNcpuba
        fpzBX8IkC0VwbVPEOXhzu/80UAuRlwtWbRInDT0=
X-Google-Smtp-Source: ABdhPJybAO56gwEXQC+B17hrNa18PKmQWjjWXJs4u9riaDfAkElO056I03qDuvO8QWToRpVilsNXQn9oUVfZ3zaVZ98=
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr14517530wrx.277.1596838840789;
 Fri, 07 Aug 2020 15:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200801175840.1877-1-alipman88@gmail.com> <20200804220113.5909-1-alipman88@gmail.com>
 <CAP8UFD1Z1V6+iPO2CMOqdHhUGkmTdvCK+TDNtoOcX8QvC4coNQ@mail.gmail.com>
 <xmqqmu36f9pv.fsf@gitster.c.googlers.com> <CAPig+cT_1JNZOk7wZr3akdCmv7tn2RHieJd+A-usZ49jS0eCmA@mail.gmail.com>
 <xmqq364yf6tt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq364yf6tt.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Aug 2020 18:20:29 -0400
Message-ID: <CAPig+cTm8foBehQC3wVDN6Lx1SO8EGhApVbUfQ0iaBnDU7OxtA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Introduce --first-parent flag for git bisect
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Aaron Lipman <alipman88@gmail.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 7, 2020 at 6:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Consequently, I'm not in a
> > position to say whether or not there are any fundamental issues with
> > the changes made by any of these patches.
>
> Sorry, that wasn't what I meant.  A reroll would be done with an
> updated test, so I was asking your eyeball once again on that.

I eyeballed the test in the re-rolled [2/5] from a purely style
perspective (not a content perspective), and it looks fine. I could
say (and could previously have said) something about the lost exit
codes from the $(git rev-parse ...) invocations within the here-doc in
order to save Denton the trouble of eradicating them, but that seems
relatively minor. Re-thinking the unindented here-docs on the other
tests, I wonder now if that they might be easier to read if indented
with \-EOF (rather than using plain EOF), as well:

    test_output_expect_success '--first-parent' 'git rev-list ...' <<-\EOF
        E
        ...
        e8
        EOF

but I doubt that such a minor style change is worth a re-roll (and I
wouldn't ask Aaron to re-roll just for that).
