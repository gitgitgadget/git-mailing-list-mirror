Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB3220281
	for <e@80x24.org>; Thu, 21 Sep 2017 00:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbdIUAoY (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 20:44:24 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:52088 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdIUAoX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 20:44:23 -0400
Received: by mail-qt0-f169.google.com with SMTP id q4so4538823qtq.8
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 17:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K1y4l04j4rOl0DhuPD4+yG56YpOB4QDf9ephgYD2FqI=;
        b=oeRIjUwG56vM4+l56OB8iD2CklHwa6Jy8Ar3yhr8az+D7yTVsWf144F5yaPoNp3zrc
         Gj2P1yztDDxUZlce6Rr8fBBL1QzV55dToohMU25Jt1NpqLYLYlEXotuQ/3WkEqpu/KBw
         JcwoyDLvgEeIc67tkwBb32cf9sh4zqvZjheB9NqCe1rIRADHwne+UOpKKGp5SP2be6Gk
         +aL4IkAPTikXVNm+LKv9a5u9CeOfix/kKREY/JlgWFnH8UBdx/4SH0T7rXsoiMc16Y90
         ai1KtnxZRFxCcur2sjE2qctAX4jQ9lXNmuIiNx5rkhxbtIuOVhk0/An180s2s++KwkM+
         oK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K1y4l04j4rOl0DhuPD4+yG56YpOB4QDf9ephgYD2FqI=;
        b=K9xrb0Uz/lZUreZNNTYRPZT+o76dlgA5plEHpgNb+z6ofyi52+x0doLW/tlYGjUSmF
         L2h3dIBJTzfkf2D0q/La5HdyuuT0/IlY1QmlGmmNKeUMymIFWzWkH0RPKmCvoPzTzbtz
         zobM47hWT7g7ZazWl0/XfNXSwbbHRL53Iph4trA9DzeCPBY1kggEI6eFEFTqpJ3Kj39W
         IMhmT1gt/XUTW375tLCVofNGp8lboexRUEfBhsq/55Aorrij4bC4b2iPUMcigjCyq2D0
         ZRsYk+xjC3t19+JvPMDqQrnqZRz3JDAJv9Rx4zSRndA9a0GOlp03m6H+dnDbUf1Gn75u
         uB8g==
X-Gm-Message-State: AHPjjUhYtySWctVh43W53rRUrYX73d23EJYnUjCctUBJw1u7LJ1GuOlH
        /9hwJOI9+PDcLeS7ynQcq7Y/s1OlOmD0nCSobkvY2g==
X-Google-Smtp-Source: AOwi7QA7V1Xw+/oO+NaOCW0Qim0u7tbspD5uDNoHQB0X5RLsVP/ifrtURNxtoE0YlZ5ictij54iZn2+FO5u62fT98Tw=
X-Received: by 10.200.41.89 with SMTP id z25mr778039qtz.79.1505954662245; Wed,
 20 Sep 2017 17:44:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Wed, 20 Sep 2017 17:44:21 -0700 (PDT)
In-Reply-To: <0bc0b797-fb82-2300-6df1-dc5380e64c85@gmail.com>
References: <20170915192043.4516-1-benpeart@microsoft.com> <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-3-benpeart@microsoft.com> <CAGZ79kaJWDWGgqRGTdgc+RjVxAb52CpUCk2DCotSksni4cH1Ww@mail.gmail.com>
 <0bc0b797-fb82-2300-6df1-dc5380e64c85@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 20 Sep 2017 17:44:21 -0700
Message-ID: <CAGZ79kbW1GnaSz8qhCgV6BP23CWiYAzq_WbDVv_Yf1GN_3u=wQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/12] preload-index: add override to enable testing preload-index
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        David Turner <David.Turner@twosigma.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> To execute the preload code path, we need a minimum of 2 cache entries and 2
> threads so that each thread actually has work to do.  Otherwise the logic
> below that divides the work up would need to be updated as well.  The
> additional complexity didn't seem worth it just to enable the code path to
> execute with a single thread on a single cache entry.

[snip]

>
> That would require a larger patch that would update the work division and
> thread creation logic for little to no gain.

Oh I was not aware of the additional needed refactoring. (I assumed that
would *just work*, experience should have told me to have a look first).

>
> There are no new tests that take advantage of this new environment variable.
> Instead you can run the entire git test suite with it by running:
>
> GIT_FORCE_PRELOAD_TEXT=1 prove -j12 --state=all ./t[0-9]*.sh
>
> I can add that to the commit message to make it more obvious if desired.

it would have helped me being less confused as there was an "obvious"
easier and more correct alternative, which you just explained
is neither easier nor more correct as we probably do not desire that
anyway.

Thanks,
Stefan
