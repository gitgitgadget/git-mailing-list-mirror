Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A291F462
	for <e@80x24.org>; Wed, 24 Jul 2019 20:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403893AbfGXUUn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 16:20:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37756 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391160AbfGXUUm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 16:20:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so48236470eds.4
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QBDsQDTB1XCgLG+ywTl6hluIeaq1uVjSpdfsdaJG5tE=;
        b=JwqsRJIFgswCFghV559gUS5LO4rtji0Vg3FTSflMddlLTC6t10GMpOxN40FtYSDND/
         KkY3y0B/D9xKZBapn7raIhJkeXJck5kPrD+HNATOqtp49wnuPWKjuF2/y3kSst65Cr/4
         Gl2ia4XGBaE1i6fq/JKn+nLEl/Ymjl1+Bi52eSDNOMg5ZHS+pzznts0KjmUzAjD4BwPJ
         bkQ6VBhMb7t0YxkVzxQXoZhL4yogCls31gWdWKs7bl3NbpfmAOE76xDp3WXSZN1JIZ9x
         uO2WFjDvfJCmznGHAcrgLHlQv4Hhub4pvXvcy7cQBl/mDW1udXQ6cV8plO4HqSfs+RwK
         sbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=QBDsQDTB1XCgLG+ywTl6hluIeaq1uVjSpdfsdaJG5tE=;
        b=Kdjb6LG0oSIb4mVJzanIY2+exGazPvF27Gjm5Y7uCiODfVU4jgbI4TAhAV7kDsno0G
         o5zSlJvJCjckmFaJjGCI4Ubf+txHE+vQGH+X8kZK77mil8jowXbRqemt+qrUWV3nC2JT
         fm77WBS6hXeYtv+SY1/NkDd8tZ7KZYQcGgnmN2/Ubqhws1S4ob32fWDFvwOtrLkjCo2v
         E8DnEoFUKr8geOZ/UrmnjbMB+ZuulPbLueL0hTzfv5OorgV3VKNdI0wXEuR/wCK9R2R4
         rqRYZhacH1f+UI5zO1nVZ8Tjmbe6JF9QAzfD4EewcTO6onef3pt9oI0rQO+Svv/ZY9I9
         zeWg==
X-Gm-Message-State: APjAAAXgjWVmFbT/V311xib5KyMKl7eEHjZWrJUt0js3T4kT2/G2zrH3
        jyo3QalhI/DH07CeMvsOidQ=
X-Google-Smtp-Source: APXvYqziEDPW3lY1y3CJtTzunXvqyw9Qsy0MalAzsOyYpF0IW0qt8wpKFOGX5S5Nw7SQbEtgHcUx3g==
X-Received: by 2002:a17:906:1599:: with SMTP id k25mr63218733ejd.281.1563999640473;
        Wed, 24 Jul 2019 13:20:40 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id u9sm13266195edm.71.2019.07.24.13.20.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:20:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] grep: stop "using" a custom JIT stack with PCRE v2
References: <20190721194052.15440-1-carenas@gmail.com> <20190724151415.3698-3-avarab@gmail.com> <xmqqwog7qu2r.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqwog7qu2r.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 24 Jul 2019 22:06:09 +0200
Message-ID: <87imrr6vv2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 24 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Since we've haven't had any reports of users running into
>> PCRE2_ERROR_JIT_STACKLIMIT in the wild I think we can safely assume
>> that we can just use the library defaults instead and drop this
>> code.
>
> Does everybody use pcre2 with JIT with Git these days, or only those
> who want to live near the bleeding edge?

My informal survey of various package recipies suggests that all the big
*nix distros are using it by default now, so we have a lot of users in
the wild, including in the just-released Debian stable.

So I'm confidend that if there were issues with e.g. it dying on
patterns in practical use we'd have heard about them.

>> This won't change with the wider use of PCRE v2 in
>> ed0479ce3d ("Merge branch 'ab/no-kwset' into next", 2019-07-15), a
>> fixed string search is not a "large or complicated pattern".
>
> In any case, if we were not "using" the custom stack anyway for v2,
> this change does not hurt anybody, possibly other than those who
> will learn about pcre2 support by reading this message and experiments
> with larger patterns.  And it should be simple to wire it back if it
> becomes necessary later.

*nod*
