Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106021F609
	for <e@80x24.org>; Wed, 28 Nov 2018 21:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeK2I5P (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 03:57:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42142 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeK2I5P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 03:57:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so157356edp.9
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 13:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9P78+DdGYW2ipKPOdZHwJ0xQDLMQ021h42EzYfuwTG4=;
        b=cdZMMFe3WE9uYXpq2o6c+qJS6jGkoz8wsLUnQSrSIcmqykXlYsGG8csXwLVOwRIYJb
         rH1OgXvZ1zIvFGWN+cCgVhVUQRiBYG/+1SIghWiRaBMuVJ7MU9FDZe6O1VhXr/jyow9W
         D7HBj3wIUgSV6i53KKiH65dM4U8UqcHU6B7MTLv5AY5vqaJFrMa+85UIzC9i43Jv7dhz
         zL0GQTphSIzSxd5XtWlBqI5UGfSrlCanE+c5ijxkcODIs2uF+6zbPNtKV4nugdVhQHs+
         LVVBCCH7fEGcWEfOzGSPFQ6gKZB8VjiR0shfKJl/UDWHbmKRooKpVyMo/P0XX8GvZVHu
         QWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9P78+DdGYW2ipKPOdZHwJ0xQDLMQ021h42EzYfuwTG4=;
        b=ckBNF4xviASnuQ5oemAT17fRHDrDUlcSwkKLaz2qoRodjsUf+D+wBUW2SDAj9FfLOR
         /fOblyyLCKAAxx33Erjd9NWpYX6d2aW6628w5FFsI3vm/j2vqQ2MXQDTcj51sj9P5pud
         RUcDnsU+i3c1krB+OtPDD7WCQCrHv3uOM+sPfb7gtiJznt1yKQXEu8ecQzznEuJba3KW
         rlwj3qgy2k1zMcU5UlQD304KzRvzbBRHobuHKyfCzBuLqKpGcDTV8cIG1y13jbZRLLW9
         aNh8REjJIFuDf1jE0zE2p5GOwrJzSxPvXChjHVHYkqK9w6AQ5I0YibvzqeAC/er5Gad1
         TMwQ==
X-Gm-Message-State: AA+aEWaZvMQ3/TgrRc2pu3cYKwqMzgIYHew3CTy2QYqTPObXoGHoIF8c
        P1ialn+jNlGp/RrDg6YDXTlGNuyB
X-Google-Smtp-Source: AFSGD/UQyKmHeBxhaUa8+vVaUssQJbHqYBXlYQ2HBA4AWyazhkkjhN+pMf2IF7IKihxIuaoVAKduSw==
X-Received: by 2002:a50:91a8:: with SMTP id g37mr31476470eda.216.1543442049969;
        Wed, 28 Nov 2018 13:54:09 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id b2sm53246ede.30.2018.11.28.13.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 13:54:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Per Lundberg <per.lundberg@hibox.tv>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        "Clemens Buchacher" <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        "Kevin Ballard" <kevin@sb.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <20181111095254.30473-1-pclouds@gmail.com>
        <875zxa6xzp.fsf@evledraar.gmail.com>
        <871s7r4wuv.fsf@evledraar.gmail.com>
        <20181112232209.GK890086@genre.crustytoothpaste.net>
        <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
        <xmqqzhtwuhpc.fsf@gitster-ct.c.googlers.com>
        <87mupuzhfx.fsf@evledraar.gmail.com>
        <xmqqa7ltua2s.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqa7ltua2s.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 28 Nov 2018 22:54:08 +0100
Message-ID: <875zwgzx4v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 28 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> What do you think about some patch like that which retains the plumbing
>> behavior for things like read-tree, doesn't introduce "precious" or
>> "trashable", and just makes you specify "[checkout|merge|...] --force"
>> in cases where we'd have clobbering?
>
> Whether you like it or not, don't people's automation use tons of
> invocations of "git merge", "git checkout", etc.?  You'd be breaking
> them by such a change.

I'm so sympathetic to this argument that I tried to convince you of
something like this around a year and a half ago:
https://public-inbox.org/git/CACBZZX59KXPOEjiUKtZLN6zjO_xpiWve7Xga6q-53J2LwvfZyw@mail.gmail.com/
:)

I was probing for what your current stance on this sort of thing is,
because discussions like this tend to get bogged down in the irrelevant
distraction of whether something is plumbing or porcelain, which almost
none of our users care about, and we've effectively stopped caring about
ourselves.

But we must have some viable way to repair warts in the tools, and
losing user data is a *big* wart.

I don't think something like the endgame you've described in
https://public-inbox.org/git/xmqqzhtwuhpc.fsf@gitster-ct.c.googlers.com/
is ever going to work. Novice git users (the vast majority) are not
going to diligently update both .gitignore and some .gitattribute
mechanism in lockstep. I'd bet most git users haven't read more than a
few paragraphs of our entire documentation at best.

So what's the way forward? I think ultimately we must move to something
where we effectively version the entire CLI UI similar to stable API
versions. I.e. for things like this that would break some things (or
Duy's new "split checkout") introduce them as flags first, then bundle
up all such flags and cut a major release "Git 3, 4, ...", and
eventually remove old functionality.

> Other than that, if we never had Git before and do not have to worry
> about existing users, I'd think it would be a lot closer to the ideal
> than today's system if "checkout <tree> foo.o" rejected overwriting
> "foo.o" that is not tracked in the current index but matches an ignore
> pattern, and required a "--force" option to overwrite it.
>
> A user, during a conflict resolution, may say "I want this 'git
> checkout foo/' to ignore conflicted paths in that directory, so I
> would give "--force" option to it, but now "--force" also implies
> that I am willing to clobber ignored paths, which means I cannot use
> it".
>
> I would think that a proper automation needs per-path hint from the
> user and/or the project, not just a single-size-fits-all --force
> option, and "unlike all the *.o ignored files that are expendable,
> this vendor-supplied-object.o is not" is one way to give such a
> per-path hint.
>
>> This would give scripts which relied on our stable plumbing consistent
>> behavior, while helping users who're using our main porcelain not to
>> lose data. I could then add a --force option to the likes of read-tree
>> (on by default), so you could get porcelain-like behavior with
>> --no-force.
>
> At that low level, I suspect that a single size fits all "--force"
> would work even less well.

Yeah I don't think the one-size-fits-all way out of this is a single
--force flag.
