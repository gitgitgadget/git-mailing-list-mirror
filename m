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
	by dcvr.yhbt.net (Postfix) with ESMTP id E5FC71F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeH0X3A (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:29:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44458 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0X3A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:29:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so87759wro.11
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=1VrCX70caj+nH4jN1l22Qbn2UeRQ1XgFGi/eIjAM9gY=;
        b=RB9rpne+ivZ409N+0t13OZHM+p2Az0/WTNDExen+trgHh/49sSaJ4p5TeWots+4af7
         gFjpMmqCfuOd7sddkL+1LgJ4jiquwnLkFaF97eZezMb2C8p8roGhymtdI9Rp2ovFdwyj
         53w6e34RtEMS69uQGxTq5RrnIRqn7PUyOa0q4/JiY9wFP6H8F47zzKGqUl/GNlXGSMym
         +yWed5mhhEiIljHGBUHbyWrPh9CfKjuLZdUnIZf3z5y2utoiE0pcsM/EAxHkDx5HYRh2
         eSICoJnkxyAIWv+CCmlKM6Tbl7xli4I5UQG8FXWGyAWdbBzU8tdJTyVbH/J4Jig5Q4Xn
         1+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=1VrCX70caj+nH4jN1l22Qbn2UeRQ1XgFGi/eIjAM9gY=;
        b=EGfxB0jEo05d1NiLztwy/CY7NwuIS6tTUbHdhxrDj0I5o0wzCiB5lKEPNvIzeeR2EX
         51Tc8OZhmqryztgM79FEeKuSBLqi2bNwk3J9z+A9f/fIl4bqz0GO0bO/cFrRn9WESTFc
         Bu0nclkzjdkxxonmCIkRu6+1DHrYABSFXfbm18VerM9PJSrT42Mg/UTVqU4QSdAqOCPm
         +do/msS9KZMkPoJi8+pJ/xCxpkGLfDS7LWNvlVtrruKBUMrsC/yF2AIfpMJ2tr7N3Jbc
         IIlrOT88IXqusI5Yx2Z9XGqbtSRNOE8Z0OZjoLhZOy4/y7O6Cf91muVwFIS0L0xAPrLZ
         Jddw==
X-Gm-Message-State: APzg51ASnwI6GyH+J+M4mhXcfvUJe2iYRP3m2nmRUs6U51mNkUVRRaKk
        4tKgGjhg3oua1Nw6WZqIAG4=
X-Google-Smtp-Source: ANB0VdarJF9lCja/AZzNTERDeo4JXBX2H5NPD0+WMwOEWFmvrGLDLZ2K4MvkJgfzN824Jy3Dox/08Q==
X-Received: by 2002:a5d:5088:: with SMTP id a8-v6mr9157303wrt.37.1535398859487;
        Mon, 27 Aug 2018 12:40:59 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id j6-v6sm56682wru.64.2018.08.27.12.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 12:40:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Scott Johnson <jaywir3@gmail.com>, git@vger.kernel.org,
        Constantin =?utf-8?Q?Wei=C3=9Fer?= <i7c@posteo.de>
Subject: Re: Would a config var for --force-with-lease be useful?
References: <CAEFop40OJ5MRwM8zxE44yB0f2Fxw9YsUdM1e-H=Nn9e=sAGJ=w@mail.gmail.com> <xmqqin3vk3yv.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqin3vk3yv.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 27 Aug 2018 21:40:57 +0200
Message-ID: <87o9dnegxi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 27 2018, Junio C Hamano wrote:

> Scott Johnson <jaywir3@gmail.com> writes:
>
>> Hello Everyone:
>>
>> I'm considering writing a patch that adds a configuration variable
>> that will allow the user to default the command:
>>
>> git push --force
>>
>> to:
>>
>> git push --force-with-lease
>
> I actually consider "--force-with-lease" that does not say "this is
> what exactly I am expecting to replace with my version" a fairly
> dangerous form to recommend to the general public, unless their use
> of "git fetch" (or "git pull") is disciplined.  In the extreme case,
> if you habitually do "git fetch origin" only to update the remote
> tracking branches (so that you can do things like "git log ..origin"
> to see what others have been doing while you were offline), using
> "--force-with-lease" offers no value over "--force", as you're
> likely to find your remote-tracking ref to be up-to-date, but it no
> longer is what you based on your decision that replacing the tip
> with your version is safe.
>
> So, from that point of view, I would recommend thinking twice before
> considering to add such a configuration variable.

Last year there was a proposal for such a patch in:
https://public-inbox.org/git/1499116727-757-1-git-send-email-f@mazzo.li/

This was after/during a long discussion starting with:
https://public-inbox.org/git/CACBZZX7MeX-6RHgh2Fa9+YL03mjxs8xmyE86HnVxBxjMYizcig@mail.gmail.com/

It appears the only patch that got in from that discussion was my
f17d642d3b ("push: document & test --force-with-lease with multiple
remotes", 2017-04-19) (https://github.com/git/git/commit/f17d642d3b)

I still think something like such a config variable would be useful, as
noted in https://public-inbox.org/git/8760f4bmig.fsf@gmail.com/ Junio
voiced similar objections at the time.

It would be great to have some patch like this for consideration, but
give that thread a read first to see what some of the objections were /
various points raised for/against doing that.
