Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2789C1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 01:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbeDYB26 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 21:28:58 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:40284 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeDYB25 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 21:28:57 -0400
Received: by mail-wm0-f45.google.com with SMTP id j5so3851883wme.5
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 18:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bH3YmCWZLH7I5SUFV7mJTz3ye3zEcO/RwRJUqXXayDE=;
        b=TeSJf+hVlVGPtckTqVNQFe2Nvs0zAyticC1E1XeLMQsbHlJ5tcy8uJfUTxfk8kaDC1
         oRjJgiBY5JXzkz7kljQn1bt36KI8akzfoM3cPQsk+O2jMtwobO2OSTY64mm4bhoB45gU
         on+SdnJgu7UXL4KMXavcTDPgzyGeX+ZAhS0ttYdQlwkHZmPSoE9DfvRUtF5juZUVKT5Q
         S5P+pmEyR5r+7YX2o6cV9uHtfYPAAAOIlpXR+ZTqvvDpSFcFPVJZltWVHZjBQVA22rwv
         k+cwO9uCZ+ZIUzDrCaIxHHIQiqwwdbc4EC1KwwFQyvhFIbTjcwmd+jf7FwOOLq3X1CLt
         VSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bH3YmCWZLH7I5SUFV7mJTz3ye3zEcO/RwRJUqXXayDE=;
        b=YQ7ivHAklh7TzKpwV6jIJ224Hhi1ATTOQLMm9XJG+LNMvhumFaoRU7IQG1tmW9OLWn
         yKGeANbGyb/AiqjcpIsTFG3JYOtDjTBEQap3HxKAUu+DzUsX+P5msRlK8I/eZ/CH6M73
         ObNLNoWa87LPp/8LZKwEMb3jMiwOvN3Jwx4iX107BdfIpJddMqh6ChqtQMTvQ06CBJ23
         9ujZ+jV2yRR5AWg42ooZvi5UDbkIGWQKKxEt3pytk/4G4stOytL66FnUIcjSAe5dOCjG
         aTZT86k0CG+41sEcyBey5f3rtjSWzfLgKn3NkFX3cv88qn7MDoquoYJaHNFm5Ajj6Ccy
         c2QQ==
X-Gm-Message-State: ALQs6tAH6Gg5ahLYc/0R6WlMn++8k9H+2/ZlUo7uRQoc7gRyfyrFMjlX
        n4s/sWk6P2J8EwORMmT5aSs=
X-Google-Smtp-Source: AB8JxZp5LdK8HSYVYqh3NzOs2pK0AFR85Jdom0gxqHUR8sCFPEpdhkml+O0xER4DColUNwtsODUQ+w==
X-Received: by 10.28.218.80 with SMTP id r77mr3880897wmg.105.1524619735932;
        Tue, 24 Apr 2018 18:28:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b57-v6sm25974983wra.9.2018.04.24.18.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 18:28:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Dan Jacques <dnj@google.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Some add-on patches on top of dj/runtime-prefix
References: <cover.1524211375.git.johannes.schindelin@gmx.de>
        <cover.1524309209.git.johannes.schindelin@gmx.de>
        <xmqqzi1t74zo.fsf@gitster-ct.c.googlers.com>
        <xmqqvach74qe.fsf@gitster-ct.c.googlers.com>
        <xmqqa7tt72c9.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1804241646400.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 25 Apr 2018 10:28:54 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1804241646400.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 24 Apr 2018 16:48:04 +0200
        (DST)")
Message-ID: <xmqqr2n43wh5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thank you, and sorry for the trouble. I am just too used to a Continuous
> Integration setting with exactly one integration branch.

Fixing problems close to the source (i.e. picking an appropriately
aged base) and making sure everthing works near the tip ala CI style
are not opposing goals.  It just takes an extra step (i.e. trial
merge and testing the result) and discipline.  Until one gets used
to do it so much that one can do in one's sleep, that is ;-)

> I will make an effort in the future to figure out the best base branch for
> patches that do not apply cleanly on `master` but require more stuff from
> `next`/`pu`.

The easiest is to leave that to the maintainer most of the time, as
that is what maintainers do.

Thanks.

I really want to see that the runtime prefix stuff mature enough
during this cycle, so these follow-up patches are all very much
appreciated.
