Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099081F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbeL1UNt (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:13:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39657 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388040AbeL1UNs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:13:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so21838356wra.6
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 12:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=Qo4Uu5gpaU2nBbrevsOa4Bo7ldsf6FM/PuBJwbewhgA=;
        b=Q15R08N6kh+jlcVr7Smnx6TNetastwc1wJTFl04JlG8InMW8S5PafvErKgBDvxityR
         wByYh5QIiI5/s81iyZvZEpuy+Enj1XHm9CpIXPx0W44yGliOzuRzXNXTz8QArHMEX7iy
         SDCbiXpWcrILU4huSRkmWolAYfrAKvyDD7CjIjAl0QWh5JYY/xuhAMkp/az6pegYSZgX
         qGVNnlU+YHOKZSeRImBGsnm+kbF4to6nrYQ7R0/pu0UzzIMia46owFTC2xIzMMFfkjD2
         diGn+yU00Sl9Uw/1D1ht0scT3otcdWeQKyZSQI/9wmI+d+rdWLvKJ14FCHgQW1t7kG6k
         JFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=Qo4Uu5gpaU2nBbrevsOa4Bo7ldsf6FM/PuBJwbewhgA=;
        b=qV1CFLvDMDbdMRSvWTk48OHylIzXTKiENtUd5w0A0CFYvB+Zi0qyFoLIwJ/C6E3Fwv
         Wcm9a9GoFJYNFQImANfXiAF4gRERkvf1dsddZ7dtbqLR+CeyJYLly9bSeN1T3f8AJYla
         eZCqr8FCd9NN1raDknjxTpfmBHlM/wTsAvLP//MG3XUuRGXbFuI1EnSax4XX6KrMOHIH
         Ize3JnR2wpz1XP14Sh6ItU925fgXwi1tAIVEgb261VJsd1Q1n6oYxymJKJmYVOR/6FzI
         THG11cZocjDAbSTAmuuAAukDj7su2n76m1WAP1n+YuC//v499clsBWJ+ga38t3Jo38iU
         aVtw==
X-Gm-Message-State: AJcUukevN6N25jyTLLHTIsrSw1hHJHi40ccbc9OhCvz9ztyavEdUU9WK
        SMlGr9TJnafKxooxgbIQ74E=
X-Google-Smtp-Source: ALg8bN5S9VOEApu7T8Lf/rp/klcT1T64cGDDvi7dLHx03L+K1HXPyrHEuxDSH2ajrAWLCwOGdspYmg==
X-Received: by 2002:adf:fb4c:: with SMTP id c12mr25401908wrs.297.1546028025761;
        Fri, 28 Dec 2018 12:13:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z9sm24372648wrs.63.2018.12.28.12.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 12:13:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <randall.s.becker@rogers.com>
Cc:     "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Git List'" <git@vger.kernel.org>,
        "'Randall S. Becker'" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v1 2/4] config.mak.uname: support for modern HPE NonStop config.
Date:   Fri, 28 Dec 2018 12:07:09 -0800
References: <20181226230523.16572-1-randall.s.becker@rogers.com>
        <20181226230523.16572-3-randall.s.becker@rogers.com>
        <CAPig+cQ4p8kgAWji3r6WnudZdT4TOG15s1ip6p5SXmTec25mPw@mail.gmail.com>
        <000601d49e0b$e11d7520$a3585f60$@rogers.com>
Message-ID: <xmqqa7kpmmtj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <randall.s.becker@rogers.com> writes:

> On December 27, 2018 12:03, Eric Sunshine wrote:
>> On Wed, Dec 26, 2018 at 6:05 PM <randall.s.becker@rogers.com> wrote:
>> > A number of configuration options are not automatically detected by
>> > configure mechanisms, including the location of Perl and Python.
>> > [...]
>> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> > ---
>> > diff --git a/config.mak.uname b/config.mak.uname @@ -441,26 +441,45
>> @@
>> > ifeq ($(uname_S),NONSTOP_KERNEL)
>> >         # Our's are in ${prefix}/bin (perl might also be in /usr/bin/perl).
>> > -       PERL_PATH = ${prefix}/bin/perl
>> > -       PYTHON_PATH = ${prefix}/bin/python
>> > +       PERL_PATH = /usr/bin/perl
>> > +       PYTHON_PATH = /usr/bin/python
>> 
>> Is the in-code comment about ${prefix} still applicable after this change?
>
> The ${prefix} is not applicable on this platform for perl and
> python. Those locations must be in /usr/bin and are managed by the
> Operating System vendor not by customers. The change is wrapped in
> an IF so is only applicable to NonStop.

So the answer is "Our's are in ${prefix}/bin..." is no longer
correct?  If so, this patch must remove that stale comment at the
same time, no?
