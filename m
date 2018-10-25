Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D8D1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 03:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeJYMXx (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 08:23:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38347 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJYMXx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 08:23:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id d10-v6so7705291wrs.5
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 20:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IjmmwRNLq9irQjo+c3Ale0RiX/5vI5Flqp5KGQMeCM0=;
        b=rThC56fmVUu92VnMfV6uUfph2hnGuIfm/FU2ff7cNdNhhu3hHwo8jL+qJD2eO/lRne
         n9tRBYpdnC6mlthDIQLfq+iIkDZpPkbsuv9MxTd8sHSf2MFqH7No0u0TauPvpNJHnfYZ
         lWZMxr9PNNQWNpbhJQsyjzML0ief/lnL/hjEgftH+tOlwf6dEv3RuIlXnirKbJyzx7iO
         VLRTZNK68uvD1Kseska5XjuIbiMhjdnv5rLn/AwD8Mmny6CvUMW9mPsAjCzjsXlLMjds
         4L5tnfiGMe6brHWwYik9tqVVwUjierLfqvJdjpzlQtJJ8ZR8EnRKWHil3BLyagCtJuMt
         /1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IjmmwRNLq9irQjo+c3Ale0RiX/5vI5Flqp5KGQMeCM0=;
        b=AxSHSQgjGGay7RiCfZGoHKGikKx42RrWazHV40BiDYE/0ngZ7LukbHW0El31Oz7m+/
         QuG2sKr2h/HuS7FwS1JH1H2iAoELdvY27HJRxeiw7SBHDew0lUHEGDxz/G9U+GsTpJd1
         ccoY5AiHat/QYqnYC+2e1+TbO+SXbmBsAxiXfoMvSof7dY2Ki6wIuLl5+X5ZSLTvZoIN
         xeuyRptF3IuLeVdiVbyBvwi0Uy7rphJEjMVwDobQvpG0Dr8J9/oNWok3O3FXGtPHaDap
         OqmUGPmnqewj/Mxs3q/hXOhfrjznS+kdVfXEJtLRB6JIZZf+oD9/R5de7mXXO/t4pGaG
         I5rg==
X-Gm-Message-State: AGRZ1gIGod9k6jKTs/tYXP/Nfh4gyYXTwo0qhyt5VF85ztyVBL2yaV9n
        H0DpDSnyTqFJDGWU8mRFCLA=
X-Google-Smtp-Source: AJdET5fyHrP97ns/YqtHdKeFGmpBpfDWba9z3jB0ci0QDkAgbs6Wsel9eGWNBqp0T53IGcXmuS6PNQ==
X-Received: by 2002:adf:e18e:: with SMTP id k14-v6mr2489296wri.36.1540439579040;
        Wed, 24 Oct 2018 20:52:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x197-v6sm887650wme.15.2018.10.24.20.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 20:52:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
References: <20181022153633.31757-1-pclouds@gmail.com>
        <878t2pd6yu.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1810231126470.4546@tvgsbejvaqbjf.bet>
        <8736sxc6gt.fsf@evledraar.gmail.com>
        <CACsJy8CX78EbANbv8a354djJaO6dKRpXshHhHJTspJvOSewgpA@mail.gmail.com>
        <871s8gd32p.fsf@evledraar.gmail.com>
        <CACsJy8Dex3VYEXmvRZv5_ot1-cwjJtir=kvupzKe7-Z2qPZw+Q@mail.gmail.com>
Date:   Thu, 25 Oct 2018 12:52:55 +0900
In-Reply-To: <CACsJy8Dex3VYEXmvRZv5_ot1-cwjJtir=kvupzKe7-Z2qPZw+Q@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 24 Oct 2018 16:41:57 +0200")
Message-ID: <xmqqh8halm20.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> The person who writes
>
>  printf(_("%s"), getenv("foo"));
>
> may not go through the same thought process as with complexFunction().
> If _() calls getenv(), because you the order of parameter evaluation
> is unspecified, you cannot be sure if getenv("foo") will be called
> before or after the one inside _(). One of them may screw up the
> other.

Yup, sometimes we've been sloppy but we should strive to mimick
efforts like f4ef5173 ("determine_author_info(): copy getenv
output", 2014-08-27).
