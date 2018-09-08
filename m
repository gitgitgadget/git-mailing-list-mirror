Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50FC61F404
	for <e@80x24.org>; Sat,  8 Sep 2018 22:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeIIDUU (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 23:20:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45801 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeIIDUU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 23:20:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id p52-v6so13861674eda.12
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9rOeIyCezM3fed6Qgz6xOhqd78By+Kc4cIKY/lN1lqs=;
        b=aPq3ViaHH5wPqfm3mokY/YpgPfdp+x9ZpcFaLS5bIzUqEDiX91hW6ppSz0yN4mlNOh
         VqRPkjVMnEv7puRob+Bqfo+UipJ2pQEx2oBOyMmMSrOEgo4rx1HoVxquwX8N9xdh6NNG
         g0Jmado0scSm74Ju28vtrfXmZa0nD8rNGDZlQkBm2ZY4dwwaNp3oOFos7A4y2dWE3vR0
         +je9QkrPu4Qtc1aKg5WuKmbQVP97PrQB4ZTJKdRct3fmVrf1nIDOsnNg/48tQnD0zuYB
         DS7J3sO8AG/nWwdwPtY2NTBv4s/MJhP85XT1AEX52xOrlCCauvs89rYibCY5HeMQ2oSZ
         BrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9rOeIyCezM3fed6Qgz6xOhqd78By+Kc4cIKY/lN1lqs=;
        b=MacGdHy5Q6kdIT9/7AjMFSqQD14vdfE3IIRvu8ShrNrpyv48xmVRmelzLDciRqzmPC
         1LNrLkfn3iNOMD1llk31nyAQTKdpjN4ZoPv1It1dqm+Pbu3lUtVs70wim2GqoEY2HBRi
         jQkAYSpToP295aNfwD0HAZdGPYIcGXCQQ6in6FZAsv3uQZlsYkjrjM6mqb9AQvQr0ndI
         xycSgn3r0r9mQ6tPXg5d599CEas7nkzIVkI4frzqLFT4EtsnrMxxsjHdM0H9oBsq6Rga
         jNPXkbVXEZGLfVDad+7VuV2+Pp7QBkOTbqekPrtrkCwX4b0QMY3vTo0grp2a17lDc7y+
         XRVw==
X-Gm-Message-State: APzg51B7cKj0jliaExpre98DGkqqOTG4HxU/wRA1hYexie6Id7xnbpaM
        uI+x9Quxg33KoU5CbkNF/jI=
X-Google-Smtp-Source: ANB0Vdby32zLoAKL+NnDtigA/SVIu3uI9aML0LpnWRXG0CZm6z7pcht7Z5dSOZvk0h2XOwDHhULwOw==
X-Received: by 2002:aa7:dc49:: with SMTP id g9-v6mr15402989edu.115.1536445979348;
        Sat, 08 Sep 2018 15:32:59 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id r23-v6sm6699665edi.17.2018.09.08.15.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 15:32:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        stas@stason.org, Git Mailing List <git@vger.kernel.org>
Subject: Re: git silently ignores include directive with single quotes
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org> <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com> <87bm97rcih.fsf@evledraar.gmail.com> <20180908211436.GA31560@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180908211436.GA31560@sigill.intra.peff.net>
Date:   Sun, 09 Sep 2018 00:32:57 +0200
Message-ID: <87musr7h7q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 08 2018, Jeff King wrote:

> On Sat, Sep 08, 2018 at 09:54:14PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> The reason missing includes are ignored is that the way this is expected
>> to be used is e.g.:
>>
>>     [include]
>>         path ~/.gitconfig.work
>>
>> Where .gitconfig.work is some configuration you're going to drop into
>> place on your $dayjob servers, but not on your personal machine, even
>> though you sync the same ~/.gitconfig everywhere.
>>
>> A lot of people who use includes rely on this, but I see from this
>> thread this should be better documented.
>
> Right, this was an intentional choice at the time the feature was added,
> to support this kind of feature. I'd note also that it mirrors other
> misspelled keys. E.g.:
>
>   [include]
>   psth = whatever
>
> will also not generate an error. This is also intentional, for two
> reasons:
>
>   1. Git's config format has always been designed to carry extra keys
>      used by third-party scripts and porcelain. So we don't actually
>      know the complete set of valid keys. (Though you could make an
>      argument that git-core could stake out include.* as its own).
>
>   2. It makes using multiple git versions easier in some ways (though
>      also harder in others). A config key that isn't known to the
>      current version will be quietly ignored.
>
> Of course those things mean that true spelling mistakes are harder to
> catch as such, because Git doesn't know that's what they are. And here
> I'm talking config _keys_, not values. So I'm just explaining the
> philosophical thinking that led to the "missing file is a silent noop".
> It doesn't _have_ to behave the same.
>
> That said, it _does_ behave the same and people are likely depending on
> it at this point. So if we introduce a warning, for example, there needs
> to be some way to suppress it.
>
> Probably:
>
>   [include]
>   warnOnMissing = false
>   path = ...
>
> would be enough (with the default being "true").
>
> You could even do:
>
>   [include]
>   warnOnMissing = false
>   path = one
>   warnOnMissing = true
>   path = two
>
> to treat two includes differently (though I'm not sure why you would
> want to).

I think this is introducing a brand new caveat into our *.ini syntax,
i.e. that we're sensitive to the order in which we're parsing
*different* keys.

I.e. we already had the concept that some keys override existing sets
(e.g. user.name), but not that a x.y=foo controls the behavior of a
subsequent a.b=bar, or the other way around.

This also makes programmatic (via "git config") editing of the config
hard, we'd need to introduce something like:

    git config -f ~/.gitconfig a.b bar
    git config -f ~/.gitconfig --before a.b x.y foo

To set a.b=bar before x.y=foo, or --after or whatever.

>> If we were to make nonexisting files an error, we'd need something like
>> an extension of the includeIf syntax added in 3efd0bedc6 ("config: add
>> conditional include", 2017-03-01) 3efd0bedc6 ("config: add conditional
>> include", 2017-03-01). I.e.:
>>
>>     [includeIfcond "test -e ~/.gitconfig.work"]
>>         path = ~/.gitconfig.work
>>
>> Or something like that, this is getting increasingly harder to shove
>> into the *.ini config syntax.
>
> I think it would be simpler to just introduce a new key that's a variant
> of "path". Like:
>
>   [include]
>   maybePath = ~/.gitconfig.work
>
> Though if it really is just a warning, the "warnOnMissing" above would
> make that unnecessary (and it also scales better if we have to end up
> adding more behavior tweaks in the future).

Yeah, we could do that, and it wouldn't break the model described above,
We can make that work, but this would be nasty. E.g. are we going to
treat EACCES and ENOENT the same way in this construct?
