Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6C7202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 19:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbdGLTNA (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 15:13:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34048 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbdGLTM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 15:12:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id p204so732589wmg.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=gyNr4H9JybGT6J6rL+dJf4vU0e+65DITFx73XX6Yhi4=;
        b=F94ARoieg/5XKirqnVrXDXtahCUhc9j1sCvFlVfJ92jiracjVI3hBMW+LWTa+/IPlW
         dnPdVgWBiGAXtjhNdh0uWyuZprLSK8I3dxFQK2sNNIWi9CSngzX4obZ5gwTaZqAsQXEq
         kO3FZAMLaNtiqYLaN33Z1CBieRIc8iVKoSeamQUen+pUqTBgs/DpTk7x95XXlHsYayKU
         WsMFmqXX/it6RFQk9KDuVyorRwQdpllJCR+Bj/KnsH4PGnLcCof8dc/8Z/8w9gpS++Z0
         j3iAfuIBi18O19W94g+Yvt2pVDG/0fRjSfrBaAeG4IwsIt0QeCGWDzgayBnxFRFZWDrQ
         NYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=gyNr4H9JybGT6J6rL+dJf4vU0e+65DITFx73XX6Yhi4=;
        b=qD6DMn3955/I79YzaNoLAtUFtMKyvJ0UbmvX+adGlqCDxMG/kIAJGAhu69t/PEf8yf
         C1kneaUllDOPOV9MtDahLTHn0uX0d3IRRsesPkJhZcn6/pC3U0utzAo8yNwaMykxPyzN
         ua6iZRl52/TffKsEMVFQhir6L8TyG0HdxOduheMipnZDJqnpMmRsOOfUuAtOzGljJF2D
         IikTpS8csxx2TK/WzEwuctz1YOEKa0oLLz8kdTwFcfp+tppLu61VuGApb/f091nTap9V
         90i7GJKzXUtwAYncImWjf2FGfCJFZciu1XNCRnYRu6Mgbm2LliKBo0RcjGjW1G3Od7oB
         gFsg==
X-Gm-Message-State: AIVw112MxUGEN3/qircktxI4RSwb7MkTXnN9BzRUhMg3ORS8eePJsSax
        KVTHGdtIR4xwuA==
X-Received: by 10.28.225.5 with SMTP id y5mr3759209wmg.18.1499886777716;
        Wed, 12 Jul 2017 12:12:57 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id k45sm2781057wrk.45.2017.07.12.12.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2017 12:12:56 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dVN4B-0004gk-JU; Wed, 12 Jul 2017 21:12:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?Q?R?= =?utf-8?Q?en=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net> <4d4f2af7-60b9-5866-50bc-ecf002f74cba@gmail.com> <xmqqeftn3s7t.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqeftn3s7t.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 12 Jul 2017 21:12:55 +0200
Message-ID: <87d195zcy0.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 11 2017, Junio C. Hamano jotted:

> Ben Peart <peartben@gmail.com> writes:
>
>>> If this patch can survive a few releases without complaint,
>>> then we can feel more confident that designated initializers
>>> are widely supported by our user base.  It also is an
>>> indication that other C99 features may be supported, but not
>>> a guarantee (e.g., gcc had designated initializers before
>>> C99 existed).
>>
>> Correct.  MSVC also supports designated initializers but does not
>> fully support C99.
>
> Thanks for a datapoint.
>
> Just so that people do not misunderstand, it is not our goal to
> declare that now you need a fully C99 compiler to build Git.
>
> When deciding what shell scripting tools with what options in our
> scripted Porcelains and tests, we use POSIX.1 as a rough guideline.
> We say "let's not use this, as it is not even in POSIX" but we never
> say "use of it is OK because it is in POSIX", and we sometimes even
> say "even it is in POSIX, various implementation of it is buggy and
> it does not work properly in practice" to certain things [*1*].
>
> C89 has been the base of such a guideline for our C programs, and
> people must not to view this patch as an attempt to raise the base
> to C99.  It is rather an attempt to see how far we can safely raise
> the base by checking some selected useful new features [*2*] that we
> have had occasions to wish that they were available, and designated
> initializer for structure fields is one of them.
>
> We may find out that, after starting with "C89, plus this and that
> feature that are known to be commonly supported", the guideline may
> become more succinct to say "C99, minus this and that feature that
> are not usable on some platforms", if it turns out that majority of
> the systems that are not fully C99 have all of the things we care
> about.  We do not know yet, and we are only at the beginning of the
> journey to find it out.

I think in the context of this desire Johannes Sixt's "Actually, I'm
serious [about let's compile with c++]"[1] should be given some more
consideration.

I've just compiled Git with it and it passes all tests. I think the
endeavor is worthwhile in itself as C++ source-level compatibility for
git.git is clearly easy to achieve, and would effectively give us access
to more compilers (albeit in different modes, but they may discover
novel bugs that also apply to the C mode code).

Most of his patch is just avoiding C++ keywords, e.g. new -> wen, try ->
try_, this -> this_, namespace -> name_space, template -> templ
etc. It's going to be relatively easy to avoid a few keywords as
variable names, especially if we set up CI for it via Travis.

But why do it? Aside from the "more compilers" argument, we may find
that it's going to be much easier to use some C99 features we want by
having C++ source-level compatibility, and on compilers like that may
not support those features in C use the C++ mode that may support those.

I don't know enough about e.g. MSVC to say if that's the case, but if so
that might be an easier way to use some C99 features.

If not C++ support would be interesting for other reasons. Johannes
Sixt: It would be very nice to get those patches on-list.

1. 962da692-8874-191c-59d4-65b9562cf87f@kdbg.org
   (https://public-inbox.org/git/962da692-8874-191c-59d4-65b9562cf87f@kdbg.org/)

> [Footnote]
>
> *1* Like `backtick` command substitutions that is very hard to make
>     them nest properly and impossible to mix portably with quoting.
>
> *2* New, relative to our current practice, that is.
