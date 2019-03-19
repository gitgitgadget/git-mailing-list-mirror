Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE1C20248
	for <e@80x24.org>; Tue, 19 Mar 2019 03:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCSD4B (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 23:56:01 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35316 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCSD4A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 23:56:00 -0400
Received: by mail-wm1-f41.google.com with SMTP id f8so281795wmh.0
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 20:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Bl1y6PYOkjOOgEUp5Y2XNuGg95n5ZxtL8OlcMAzdiXA=;
        b=gMuvpIxMliTZp8PF18vGiqkIWGx3kquO5C8+0VcXkA27QLWqmqjMm3wWjhEks9n6vU
         Dmg7I2Qw25rEnxXPfrhvbuJRwDB4UNKSV2WgEiDZRigsLTIr4OeV3AE2y2YYkb4nCPHQ
         4tma9S1s7HFZsEgoOT34JIxUDWZ35IyJcoZ8KPAQF9Oj53SU7XvB7FTh6dz5cKCKavdW
         bFkw/cVDQNlejpF7Nna3HhrszPbT0kPKxdNKvqVWZ1qk7T3Ex/cGlP+isgiMmKMXkDz5
         5sPmVHsbyMew/yebwCfhVcAb9TkEujD7FxUmmc03xgdG6JT/a2aXA9Ug9oBxF71YGyAu
         6QHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Bl1y6PYOkjOOgEUp5Y2XNuGg95n5ZxtL8OlcMAzdiXA=;
        b=IvT3LlwjYZWoFxCBfkxPC+byPxteWDby09vQmSDQ3W8JTKpE39YSQTOWDsbVW95dUI
         Aw12DC3F/NHYbn5x0PH0BV6WFHPP568yGQ1ErdNpyFFhIe1kl0K0Q+38eHWIbHytOsEj
         RPeLOz7ZcRIbongR+QVZMSJloW9ulscbCO2Pr4msXRYotvX2oLZd6y4h/WbyDaUB0SNa
         N17w4IVY4cjLLwMXQPnefXpzKMlkPkf+7pu54X9sEWVHKxScG3MEhWWxVwQeTgrDJleB
         Q5gEe1k4YGMwKUAC6b3gx5kX4P3dOyETHOla4mOZvmOhIxcznHVNPU+loLwePEfPdogq
         x0zg==
X-Gm-Message-State: APjAAAXGsFYzxtkhLaGkgkD6NwQrgljESTKZJ7kgdA256y6Nrc5ZvZeQ
        m2mq0uU96e3keIOtn6lYF/Q=
X-Google-Smtp-Source: APXvYqwMMNiWaaYl0DpqVJOGnqEtGDYW3uursCpVWTBxvQ5Fq6KjV733m3VfAEZXE5ExHg/jT5gKsQ==
X-Received: by 2002:a1c:751a:: with SMTP id o26mr1655082wmc.10.1552967757883;
        Mon, 18 Mar 2019 20:55:57 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r15sm8676053wrt.37.2019.03.18.20.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 20:55:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
References: <20190317144747.2418514-1-martin.agren@gmail.com>
        <20190319024645.GA6173@sigill.intra.peff.net>
        <20190319025945.GB6173@sigill.intra.peff.net>
Date:   Tue, 19 Mar 2019 12:55:54 +0900
In-Reply-To: <20190319025945.GB6173@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 18 Mar 2019 22:59:46 -0400")
Message-ID: <xmqqr2b3y0tx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So in my mind, the endgame is that we eventually drop asciidoc in favor
> of asciidoctor. The repo at:
>
>   https://github.com/asciidoc/asciidoc
>
> says:
>
>   NOTE: This implementation is written in Python 2, which EOLs in Jan
>   2020. AsciiDoc development is being continued under @asciidoctor.

;-)

> I'm not sure when is the right time to switch. If we can get the output
> at parity, I don't think asciidoctor is too onerous to install (and we
> don't have to worry about ancient platforms, as they can use
> pre-formatted manpages).

One minor thing that bothers me abit is the continuity of the
pre-formatted pages when I switch to asciidoctor to update them.

I do not mind having to see a huge diff in the "git log -p" output
run in pre-formatted manpages and htmldocs repositories at the
boundary due to e.g. the differences how lines are broken or folded
between the formatters, but by the time we have to transition, the
efforts by you, Martin and friends to allow us compare the formatted
docs would have made the real differences to empty (or at least
negligible).  Knock knock...



