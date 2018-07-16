Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B633C1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeGPXmd (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:42:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46216 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbeGPXmd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:42:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id s11-v6so33478803wra.13
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=417GKgOk9Aa4DhAb6Oo1QhHnSI242yjoGhB4Qav5yjk=;
        b=cK1ad5a59uvbIg2sfVCXxajEuXvzNQL9oHUi2KAk3CrX0zxTI0tXIYFr2cQ2E7jbHM
         bj9OjxtzLhURhQMhAZ9Dl1Zvy1HA2/gzZkiAj6Qq4MWX/GtuSjZ6gnkOtABgGske4rZp
         vteGAgpx9UeR+oAXGrl4NnLVZxWJnJlluiH/xgvUaq7VQ0sXpVa6ZbVQ5NLASm499t4r
         n3wVb7MRdPHLvXjqDr5iHHkHs6B2atG1gWaOtYQGADAQwbAeTuzm6F07QifdXcd2xozv
         eNK7xw+4YUJQ1YhLfQ3/ZIkwZGKaPrEHb2WHeuwoqAWp2UFMR4CDQyDxZRXp3vR/u6kF
         DoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=417GKgOk9Aa4DhAb6Oo1QhHnSI242yjoGhB4Qav5yjk=;
        b=hJ5P0D/w8NovqgivXHp6YMyEFKxo0sr+gvlUg6/ds1d6oKSxqlCaBOYWc7tXYfmQOS
         /G3THIxbl/BjZpAtHzyAW5cVFpnFZ26NcQF3roAsk3/2UNf6LB/S1yMDPTFrws13u1mL
         x1LbWylUz5Q5a6c73RACyeAAdD8SIRNhG8jvVELd9PFSAK4EH7dvUJTQfzqqsEnTjee9
         jzfX3CiLIh/YlzlDM1qUBt0XZiHZEw9WZsanXfkZseZkbpM2Ec0VZ+KXquRT/oaE21on
         aPISoC8jE7v5KBtOkv0SQxgrByFG6KM9YCmqfNIRVonijveRcDoSvKUnXBPfUhUCpOFO
         wJGQ==
X-Gm-Message-State: AOUpUlESmSQ4BxVxxSm2gvaGiZwLi9wZSGJXXKQw3bnVjFR6rDQ5mwH7
        G6sUgafv+XbCk/rvHsEV5OE=
X-Google-Smtp-Source: AAOMgpfLH6EHWBSKsPJ/ZBaOOF8NcpKSCB7va7frzoTz0A+P9qjQwq6UZZDNrpbWuxFWTUjGl88fUw==
X-Received: by 2002:adf:a3d6:: with SMTP id m22-v6mr13748217wrb.1.1531782775894;
        Mon, 16 Jul 2018 16:12:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w4-v6sm18410031wrt.40.2018.07.16.16.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 16:12:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/9] gpg-interface: introduce new config to select per gpg format program
References: <cover.1531208187.git.henning.schild@siemens.com>
        <4905c1907a866c0fd1a4dac978dd6ca3e468ac43.1531208187.git.henning.schild@siemens.com>
        <20180710165412.GE23624@sigill.intra.peff.net>
        <20180710165638.GF23624@sigill.intra.peff.net>
        <20180714181347.GE1042117@genre.crustytoothpaste.net>
        <20180716213510.GJ25189@sigill.intra.peff.net>
        <xmqq36wisv3h.fsf@gitster-ct.c.googlers.com>
        <20180716222354.GA12482@sigill.intra.peff.net>
Date:   Mon, 16 Jul 2018 16:12:54 -0700
In-Reply-To: <20180716222354.GA12482@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 16 Jul 2018 18:23:54 -0400")
Message-ID: <xmqqo9f6rczt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 16, 2018 at 02:56:34PM -0700, Junio C Hamano wrote:
>
>> >> I'm okay with us forcing "openpgp".  That seems sane enough for now, and
>> >> if people scream loudly, we can loosen it.
>> >
>> > Well, I specifically meant "are you sure subsections like this are a
>> > good idea". But it seems like people think so?
>> 
>> I admit that I did not even consider that there may be better tool
>> than using subsections to record this information.  What are the
>> possibilities you have in mind (if you have one)?
>
> I don't think there is another tool except two-level options, like
> "gpg.openpgpprogram" and "gpg.x509program".
>
> Although those are a bit ugly, I just wondered if they might make things
> simpler, since AFAIK we are not planning to add more config options
> here. Like gpg.x509.someotherflag, nor gpg.someothertool.program.
>
> Of course one reason _for_ the tri-level is that we might one day add
> gpg.x509.someotherflag, and this gives us room to do it with less
> awkwardness (i.e., a proliferation of gpg.x509someflag options).

Yes, and signingtool.<name>.<key> is probably a good (ultra-)long
term direction.  Preparing the code may be quite a lot of work that
nobody may be interested in, and nothing other than the GPG family
might materialize for a long time, but if we can cheaply prepare
external interface less dependent on GPG/PGP, that by itself would
be a good thing to have, I would guess.

Thanks.
