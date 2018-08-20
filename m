Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB6F1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 08:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeHTMGe (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 08:06:34 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:52100 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTMGd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 08:06:33 -0400
Received: by mail-wm0-f48.google.com with SMTP id y2-v6so13425088wma.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=i0dY2dM1VtBy8y81X14saRv/xuHbkd2kJHdU4dAVYgo=;
        b=aTCKtM0ktVSskKm0e3OsMgit6X9jDT6HwfRjyPyQO4Pwt/yze9X1NZQm0Puiw4+dfU
         dX2yjAg8wRLzcykJHlrn3FXpClGFzYNtHZfJevnCfikg1z+/1Tez9KV71DZPZ8m8lu2T
         AcZj1HWlnly48eoggZLiATgxnzWl6MwYNdY0gMzupLkQUchVTLFvc0Jk53NrmD/MQY2E
         H/ZJh3hZKsvdaPapw1/dcOzaTxhzYbkedy72WRxqf1y3H3kyEaTstsT+CVqCSxVtG+y3
         ZlOkHIgS4+GKS934bGkPYJmfIDhx7e4Mk3SahJusM+E0XrJVwuQchHQMn3UR/Ed15DEu
         rtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=i0dY2dM1VtBy8y81X14saRv/xuHbkd2kJHdU4dAVYgo=;
        b=RNwwpxQxnMZuqnrWUcz8x1bpeknx7EkAhxH4wA7RttIJiP5LU7aDNiNWrj+xx/u48I
         9rIkCTBH9auYjkJ0Q8Szhzaf43IGGyLwyeCbDnp1rc9DAYoOZJK3u/Najix71eQiyuiF
         BjOFzUfUtoHmWJ1xYU8knrB+yqft1XU/CCtPsUsJNFXEeDRqc4dhEK357RoGzNU/1Clq
         FEMtfVrSHQvx9/rVRFEB9vr4YXyEKsB5siBDIyXdElg/QAcyLPrpBzOsoL1SuiVVuJnP
         aPgYbKLcXBVGkogDzLxyDhrulEAwrNdNFflQE+tC/UTx267WD33Tmg2UgeE5ygP/nS2U
         trAg==
X-Gm-Message-State: AOUpUlEWHUl1qN9EwBwIickii5quG/5AWi4gZydQkoFQu+ulh3+QzbKm
        fhrMRbu8a9YRX3V2WnBq7h8Ychv+
X-Google-Smtp-Source: AA+uWPwKySme3+uzhn8YcQRovsgb0yYRFr1IlDY/+dKMnX3dBm3bG57mlKReV8vBpmFnlx0mr4jloA==
X-Received: by 2002:a1c:e189:: with SMTP id y131-v6mr24464843wmg.44.1534755106836;
        Mon, 20 Aug 2018 01:51:46 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id u4-v6sm7583810wro.47.2018.08.20.01.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 01:51:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Pawe=C5=82?= Paruzel <pawelparuzel95@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Simon Ruderich <simon@ruderich.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: Draft of Git Rev News edition 42
References: <CAP8UFD2V8NQxGAhWvGK1q7uozcE+dpwHcgRw8SVsT4T=7zJXXA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAP8UFD2V8NQxGAhWvGK1q7uozcE+dpwHcgRw8SVsT4T=7zJXXA@mail.gmail.com>
Date:   Mon, 20 Aug 2018 10:51:44 +0200
Message-ID: <87y3d1pgin.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 20 2018, Christian Couder wrote:

> Hi,
>
> A draft of a new Git Rev News edition is available here:
>
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-42.md
>
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
>
>   https://github.com/git/git.github.io/issues/305
>
> You can also reply to this email.
>
> In general all kinds of contribution, for example proofreading,
> suggestions for articles or links, help on the issues in GitHub, and
> so on, are very much appreciated.
>
> I tried to cc everyone who appears in this edition, but maybe I missed
> some people, sorry about that.
>
> Jakub, Markus, Gabriel and me plan to publish this edition on
> Wednesday August 22nd.

Let's mention that we've picked SHA-256 as NewHash, as a follow-up to
last month's edition which covered the discussion around the NewHash
selection. I've submitted a PR for that here:
https://github.com/git/git.github.io/pull/307/files
