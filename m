Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E081F404
	for <e@80x24.org>; Wed, 21 Mar 2018 12:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeCUMV4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 08:21:56 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:55754 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCUMVy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 08:21:54 -0400
Received: by mail-wm0-f41.google.com with SMTP id t7so9338371wmh.5
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fAte7ywc8YbFxAWpaAusoZYQ5xNXoJaXOSGo9c/E6sQ=;
        b=uUWPzXnDdgMqZZIXpePImUfkq7UZa/kyLM1+fuwNTSEudEKyIYx4dai/p+Ib9VZYQp
         Ljpv+cIT6bQhR+mQ2AoIL8iHNlAYR4e/PWZc9FaJ7+xrfl8pZSEZ3EFoEq9s2H7PLDNU
         /QLzKy33s8ADARLCsTfrpunZZMjDmDo5jYpWW02CoHI43h2dK4U8Kx1NwBJKRuqzrBQ/
         Cz4P0XbHia5NT3asLXJSryaKBohPCop8nv1MbEPmn8dxohPtBeSk3rvMnhZBgtvsRLsw
         UJ/+Udh31eujwbcue9uhI2wPdj8kE9TZWAdfv2oFBj6vqW2ARS43PWwHna8LBFZIyhw9
         aipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fAte7ywc8YbFxAWpaAusoZYQ5xNXoJaXOSGo9c/E6sQ=;
        b=E24uqBJb97Q7jzClBza2/Td0tCgpOVXhGHGf3p4a7SHNJn6p5mV+W5EiMNtIwrCU3G
         sz5uw+Py5ZD7haNc/NbzhUuDOd/Y7czpoEEhK8eJ0jcKwn4jopShFa2+qi/PXZaYHl0V
         xRXL8pkp7tsZOyrtj8zosejn7px27ossZUZvzbKDrBizU3Jc09KhIcEwcwMZZPRiD/Sy
         VhmRfh0TkUbdsGdDzxLIaUwaUfUbzxhDlWnCdPDgvU2vt5NAwump+QVOwa3x3rHcS/wU
         uRTjBG0cf+oDzWDfOGJJMBypLvfiUU1ISWdeQa5+WdTgVEc9AmJYE4p6kKDj6PLGAoHc
         nN6A==
X-Gm-Message-State: AElRT7H6IVCOED2Pt4LwvKlT74AbyHBKxvJGujTbtxVAVrWy/ZbUpxCO
        XQTQHHzY+XF3bA7L06YWy3qPtxjH
X-Google-Smtp-Source: AG47ELtB2Zwl+eUiMUVtkpZdq0w+o3uIA6XfKqONh8r2WtMu8CCx0znmcrfXwA4cf4aqvYxntfwRNw==
X-Received: by 10.28.197.205 with SMTP id v196mr2695671wmf.39.1521634913623;
        Wed, 21 Mar 2018 05:21:53 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id s26sm4046267wrb.10.2018.03.21.05.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 05:21:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: [PATCH] doc: clarify non-recursion for ignore paths like `foo/`
References: <CAHnyXxSqtB=bSbA83V6HC6-aPCxw60h1iKQaa6ChwsmcUUCd0w@mail.gmail.com> <87muz1brgt.fsf@evledraar.gmail.com> <CAHnyXxQRfzAT75P7dxvdEEN_FRYCc7j97VEfL8tTUgVdeK-O+g@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAHnyXxQRfzAT75P7dxvdEEN_FRYCc7j97VEfL8tTUgVdeK-O+g@mail.gmail.com>
Date:   Wed, 21 Mar 2018 13:21:51 +0100
Message-ID: <87woy5y5y8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 21 2018, Dakota Hawkins wrote:

> Re-reading the section you quoted again a couple of times you're
> correct, but somehow that wasn't clear to me despite reading/searching
> for what I wanted to see several times.

FWIW I just knew this because I'd run into this the other day, so it was
fresh in my mind.

> While what I wrote may need improvement, I think there are a couple of
> valid concerns with the way this behavior is documented currently:
>
>   - Generally: Reading about pattern matching for .gitignore is
> awkward on its face, since positive matches have negative consequences
> (in other words `include = !match`).
>   - Specifically: This behavior that is specific to `foo/` matches is
> documented in the section for `!foo` matches. If you're trying to find
> the implications of `foo/` you may not have read about `!foo` as
> carefully.
>
> Since this behavior is practically applicable to both pattern formats,
> and since patterns in the sum of a repo's .gitignore files can get
> somewhat complicated, I think it would be a good idea to either:

I think it makes more sense to document it where it's documented now,
i.e. under how "!" works in general, since this is an edge case with
negative matching.

Whether you specify "foo" or "foo/" is then just an unrelated edge case
in how we match directories v.s. files, but doesn't per-se have anything
to do with how the inversion rules work, so I think it makes sense to
document it where we document the inversion rules.

I.e. you'd get the same for all of (assuming a directory "foo"):

    f*
    !*.txt

    foo
    !*.txt

    foo/
    !*.txt

So what we subsequently exclude just because it's deeper in the tree has
nothing to do with how the disambiguation syntax for matching the
directory looks like.

>   - Do this and basically explain the same behavior twice in two
> pattern format sections, or
>   - Pull the documentation for this behavior out into another section
> where users would be likely to find and understand it if they're
> looking into either pattern format

I think it can certainly be made clearer, but maybe with a practical
example (per above) where we also show the dir structure that
would/wouldn't be matched.

I just chimed in on this one because your patch says the docs are
"unclear" then "Explain this behavior (and its implications) more
explicitly" without a reference to the existing adjacent docs. I think
whatever we do we should be unifying these docs if they're amended, not
stating this twice.
