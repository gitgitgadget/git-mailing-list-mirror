Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C411F404
	for <e@80x24.org>; Fri, 30 Mar 2018 14:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeC3OPi (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 10:15:38 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:54167 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeC3OPh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 10:15:37 -0400
Received: by mail-wm0-f41.google.com with SMTP id p9so15781266wmc.3
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=xOTr2E+95gzrhJ3AJiy7MjeZTG76ecVfnJrK2j17so8=;
        b=e4HRA1cVHNJxG+OqM9ulh/ZcjDrcf0Yx7MlzN4agpniPCql2xWi8JVFjq9M9RgyHQc
         aVqpXkP654AYQnce20nQAj+VZ3m2QPV4DySud5QcTfJXFaEOM3CAcxELELrnT7XbjDHb
         3dS3Zv4VkeEqV4TTRMbHR+R7I71gSnwl29t9n5LneG97RFOEGoSGXpkFnTKmhs0FB3Ke
         Tz3XNul2w0/oo1PWnt27EyfGKx7nLsJ2R0mtBLmPCcv4poApxPmHyXLkK31W04IgSxtf
         ZeOd/DAbgRcjc8ctHGqqESSu5QUu8c4gsaAHXwNQL7Wy7nwcWCib822x1XyejCkA2Qzs
         6ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=xOTr2E+95gzrhJ3AJiy7MjeZTG76ecVfnJrK2j17so8=;
        b=EUnIL0NfbaRsw9jk7LQYxD9qwUMl9j1d+YL3cAsi8eX4VPGsZedIY9/DMtaCewmhOj
         qWVpE67uKo/3WqUOawgBhQqFUceoa/+o9fl84sQUPbgicnkep4A3gIfdu6bixKputhgg
         43T/uCRaLWzu9o7XL+tD1xi6MmoroUCndf8f/YSnI11g/+eGqwe/Nd22yizN6i9cBE3z
         fQ+7R4VdDgAjXylRPMmPQMH+vYBtaMRZVgVj72mrHYbsfQG/Fb6kY0jVWhcMHsIUfdzX
         yDEkAiWXxyE1hamw1ZfX1gROAn5mkuhpDEXxmJAv3KhsZPfZo3zd8AHXbx05hU0hQpt5
         +afA==
X-Gm-Message-State: AElRT7HBozZJW/2tP91a0BgLPkJYGXlVlOwZR9nyP/rNSRS4AG3yzJL6
        8HxfuZ/vhc5LJ6CfLGK4cvw=
X-Google-Smtp-Source: AIpwx49PkRU9wnn+rDQhGeGJz/EdR+rEFJBDTbbvc1XVhqTstHcD/FDzTQO9YCtc+wG066OQrvp12A==
X-Received: by 10.80.129.167 with SMTP id 36mr2999305ede.13.1522419336724;
        Fri, 30 Mar 2018 07:15:36 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id e12sm5483167edm.85.2018.03.30.07.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 07:15:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
        <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
        <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
        <20180329194159.GB2939@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
Date:   Fri, 30 Mar 2018 16:15:34 +0200
Message-ID: <87in9dwsxl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 30 2018, Johannes Schindelin wrote:

> On Thu, 29 Mar 2018, Jeff King wrote:
>
>> On Thu, Mar 29, 2018 at 11:15:33AM -0700, Stefan Beller wrote:
>>
>> > > When calling `git config --unset abc.a` on this file, it leaves this
>> > > (invalid) config behind:
>> > >
>> > >         [
>> > >         [xyz]
>> > >                 key = value
>> > >
>> > > The reason is that we try to search for the beginning of the line (or
>> > > for the end of the preceding section header on the same line) that
>> > > defines abc.a, but as an optimization, we subtract 2 from the offset
>> > > pointing just after the definition before we call
>> > > find_beginning_of_line(). That function, however, *also* performs that
>> > > optimization and promptly fails to find the section header correctly.
>> >
>> > This commit message would be more convincing if we had it in test form.
>>
>> I agree a test might be nice. But I don't find the commit message
>> unconvincing at all. It explains pretty clearly why the bug occurs, and
>> you can verify it by looking at find_beginning_of_line.
>>
>> >     [abc]a
>> >
>> > is not written by Git, but would be written from an outside tool or person
>> > and we barely cope with it?
>>
>> Yes, I don't think git would ever write onto the same line. But clearly
>> we should handle anything that's syntactically valid.
>
> I was tempted to add the test case, because it is easy to test it.
>
> But I then decided *not* to add it. Why? Testing is a balance between "can
> do" and "need to do".
>
> Can you imagine that I did *not* run the entire test suite before
> submitting this patch series, because it takes an incredible *90 minutes*
> to run *on a fast Windows machine*?

I think if it's worth fixing it's worth testing for, a future change to
the config code could easily introduce a regression for this, and
particularly in this type of code obscure edge cases like this can point
to bugs elsewhere.

We have the EXPENSIVE_ON_WINDOWS prerequisite already in master from an
earlier series of mine, maybe we could use that here, or add some other
prereq like OVERLY_EXHAUSTIVE which by default could depend on
EXPENSIVE_ON_WINDOWS, i.e. we'd have a set of overly pedantic tests that
we skip on Windows by default, as there's no reason to suspect they're
platform-dependent, but we'd like to know if they regress.
