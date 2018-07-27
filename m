Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 107191F597
	for <e@80x24.org>; Fri, 27 Jul 2018 21:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389719AbeG0Wv4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 18:51:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38185 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389695AbeG0Wv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 18:51:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so6896415wmi.3
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TTgqF836TlVn+9q3sREcW4ZHw0iGW7R4wUQmnBlAexI=;
        b=n2Zd2qTTea58L/K4MOxvMR0RxTSj4L+/2OtECYMM95CafrUPXxBJu/RrMLnkwWyFb7
         Bf60uUevuDTN6D79HvYUsVy9/YMABgSSTOFXs6MxFhJJeAsjovJADd82DF5iu5pbgZvA
         BevdDRe3wIDy1PkoqsU19fLuu+VTKJZFf+kK11WqBO/tUg+APCPrJC9xbfIITVLS+EwC
         /T9d2CRq0IaXTiDjFNhmM3Njvyz8RM5nZZ7FcprwvNK9FaIzJ+4LjYnp92kpCIDXgaEr
         RNpn+GG2/sazQf69Y91+XjV5h2fNsLgQG7YqHn2yrA/mW7SpTTMtwmUXlXUhLJclhLsp
         UMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TTgqF836TlVn+9q3sREcW4ZHw0iGW7R4wUQmnBlAexI=;
        b=c0dums73zPHVhXB2wz6SCq/UT3LbAonHbZp9cBIi3m5h1+PIrWf5vyo/yztxWWQFiS
         6+NjXczHYz8mTYjuzfCQ9dxtRwgO+cVNKF2rPLCgjIC/sXLcg6gNvAFqdIkoqAwXesN7
         AOdnZJfFzQUf4/OLVaCyss2PPznh3CsT3S65QN1EOHGPojl7cJ+RKxUevPpcXG/gJJKC
         uYaE6docl/TTSH6A4qNP4GPo26/qJ6uSvS2Mhtgk2w5sCujNK5XPIhLH1dzPJ/lhguZA
         2p0zgr+qKIJee+GTzmnaPciwtOMYW6j850lWNvG7NhNG/pThcP28fFsn3AJ81fRr0rxR
         B9qA==
X-Gm-Message-State: AOUpUlHTnpOPisU051qlLzWhDYu2JHrT3kjwEdCmXlbHI0nGgMPBies3
        dhkYp870G8gDODfXIhrlgXg=
X-Google-Smtp-Source: AAOMgpfDmNUp3cb4Ye9Bo3XQyWxeO2OS/akz2KydD1eeXXksh3LnSxf+V7ZLjGoQUB0Ncpk4vTvg0w==
X-Received: by 2002:a1c:ec06:: with SMTP id k6-v6mr6041447wmh.39.1532726890490;
        Fri, 27 Jul 2018 14:28:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z2-v6sm3353760wma.3.2018.07.27.14.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 14:28:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 08/10] fsck: test & document {fetch,receive}.fsck.* config fallback
References: <20180525192811.25680-1-avarab@gmail.com>
        <20180727143720.14948-9-avarab@gmail.com>
Date:   Fri, 27 Jul 2018 14:28:09 -0700
In-Reply-To: <20180727143720.14948-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 27 Jul 2018 14:37:18 +0000")
Message-ID: <xmqqo9esl66u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Test and document that the {fetch,receive}.fsck.* family of variables
> doesn't fall back on the corresponding .fsck.* variables.
>
> This was alluded to in the existing documentation by saying that
> "receive" looks at receive.fsck.* and "fsck" looks at fsck.* etc., but
> it wasn't explicitly stated that there was no fallback, and if you'd
> e.g. like to configure the skipList you need to do that for all three.

Hmph, personally I felt that the updates so far made it clear and
explicit enough.

>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/config.txt        | 12 ++++++++++++
>  t/t5504-fetch-receive-strict.sh | 26 ++++++++++++++++++++++++--
>  2 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 8dace49daa..57c463c6e2 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1619,6 +1619,12 @@ The rest of the documentation discusses `fsck.*` for brevity, but the
>  same applies for the corresponding `receive.fsck.*` and
>  `fetch.<msg-id>.*`. variables.
>  +
> +Unlike variables like `color.ui` and `core.editor` the
> +`receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>` variables will not
> +fall back on the `fsck.<msg-id>` configuration if they aren't set. To

I do not think "Unlike ..." and mention of two sample variables
(color.ui and core.editor) adds much value to the paragraph,
primarily because it does not mention "color.status" etc. to show
what kind of fallback the sentence wants to discuss.  I actually
find the paragraph even clearer to read if it began with "The
`receive.fsck.<msgid>` and ...".

If you insist keeping that "Unlike..." thing, please have a comma
before "the `receive.fsck.<msg-id>`", but I'd recommend to remove
it.

> +uniformly configure the same fsck settings in different circumstances
> +all three of them they must all set to the same values.

That is not incorrect per-se, but I doubt it is a good idea to give
an impression that most people would want al three to be the same.

You want fsck.<msg-id>.* to be stricter to ensure you do not create
new problems, together with fsck.skipList to pardon mistakes that
have already happened, and with $transfer.fsck.<msg-id>, optionally
loosen certain class of breakage if a particular project has special
needs (e.g. the tool they use is known to produce incorrect
objects).  Which makes me expect that in most cases, fsck.<msg-id>.*
would be empty, fsck.skipList to be populated with known-bad ones,
and $transfer.fsck.<msg-id> may be empty, or may not be empty.

On the other hand, there may be value in allowing skipList to be
shared across three, though.  You may have known-bad ones and you'd
need to give a copy of that known-bad thing to other participants of
the project anyway.

