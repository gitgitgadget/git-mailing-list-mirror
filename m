Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6F7F20248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfCOQLo (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:11:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35908 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729545AbfCOQLn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:11:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id e4so8096029edi.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AAK6jKmz0kasO2wmFU6pX/6fjsGkvgK+HTUmHWzTEVQ=;
        b=cj8yTDL+w/mW+aSElWlivFa9XZJdGSb+9VhvwS14zV5BuAR2l4sQ2yz5sEFAGpB4XE
         t/BMHYVTHpnHKolXyiX8rEiIVXcS8HnHpJRTrMykoWt5TIJuLFO+KtCKN1mLMngpKk2j
         F2oB2FlIcYVPVtDEaP5I7S7wvY2SEUgkp6WJAH1qP0JHDkgz8xTrmzqNSoJd7iF+Y48G
         mmlmTPwfVSIZFHWxiECBhEZhGlYOoRRInHqy0r4WrCf24EEh12hdkTiOZqKCDmYdap8y
         wLy5ptNa6D/ko46eySBcbJDRpk5XZzm7kEocdbA8P69NcSiO9pIZhcsjlFnEQ8VvhG00
         chPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AAK6jKmz0kasO2wmFU6pX/6fjsGkvgK+HTUmHWzTEVQ=;
        b=jS6+Rwp9Ch4vk6MM8oYcdQa3uaN/ysg3vv3jJP9SthZyDuCiDH5QXbJeGyJN0k/SLW
         VnUSbp7EOmqjh8tCNRxy78X4ii+I6Ao+QgXqzcjfrGICMHqBUo6jLMuT/pkbmLi1g1og
         vSau368KZxTNMvbW0zDSzpbA9uzNk/VaZlnXC4nY4S6wXjHr0yrIPz5VUUdGSldHKtPf
         b+Ojtq3T7mx4WUqehxA3pIFeDdRd9NdQvkMUg02jmSw2L4ruDw9PHLkhZTmGXtXCrMSh
         iQhurZfmJBuh5TtvNhryiDZZBaCMt2n43Mb8dGLmmhZke7OFcU41nmzkJjM96Wpeqw/M
         a7HQ==
X-Gm-Message-State: APjAAAX/4ZsKOnVVoS/MMgXnOtqveFiHdPKjh+wM5E8Ts7e0LIyg+G9O
        qIOcnMhEJMeTydPk1+9G5nYLy8ghLso=
X-Google-Smtp-Source: APXvYqw0ZFyO9CAT83ofqSk3wGRTnPSe8MYRsXJMsfDOzAU0eRjqk/ttjmE9VTJnhLCshTBgXq+jTA==
X-Received: by 2002:a17:906:6d50:: with SMTP id a16mr2808641ejt.170.1552666301761;
        Fri, 15 Mar 2019 09:11:41 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id l5sm730271edr.75.2019.03.15.09.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 09:11:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] rebase: remove the rebase.useBuiltin setting
References: <87ef79bho5.fsf@evledraar.gmail.com> <20190315134548.24479-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1903151643300.41@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1903151643300.41@tvgsbejvaqbjf.bet>
Date:   Fri, 15 Mar 2019 17:11:40 +0100
Message-ID: <87wol09kxv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 15 2019, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Fri, 15 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Remove the rebase.useBuiltin setting, which was added as an escape
>> hatch to disable the builtin version of rebase first released with Git
>> 2.20.
>>
>> See [1] for the initial implementation of rebase.useBuiltin, and [2]
>> and [3] for the documentation and corresponding
>> GIT_TEST_REBASE_USE_BUILTIN option.
>>
>> Carrying the legacy version is a maintenance burden as seen in
>> 7e097e27d3 ("legacy-rebase: backport -C<n> and --whitespace=3D<option>
>> checks", 2018-11-20) and 9aea5e9286 ("rebase: fix regression in
>> rebase.useBuiltin=3Dfalse test mode", 2019-02-13). Since the built-in
>> version has been shown to be stable enough let's remove the legacy
>> version.
>>
>> As noted in [3] having use_builtin_rebase() shell out to get its
>> config doesn't make any sense anymore, that was done for the purposes
>> of spawning the legacy rebase without having modified any global
>> state. Let's instead handle this case in rebase_config().
>>
>> There's still a bunch of references to git-legacy-rebase in po/*.po,
>> but those will be dealt with in time by the i18n effort.
>>
>> Even though this configuration variable only existed for one release
>> let's not entirely delete the entry from the docs, but note its
>> absence. Individual versions of git tend to be around for a while due
>> to distro packaging timelines, so e.g. if we're "lucky" a given
>> version like 2.21 might be installed on say OSX for half a decade.
>>
>> That'll mean some people probably setting this in config, and then
>> when they later wonder if it's needed they can Google search the
>> config option name or check it in git-config. It also allows us to
>> refer to the docs from the warning for details.
>>
>> 1. 55071ea248 ("rebase: start implementing it as a builtin",
>>    2018-08-07)
>> 2. d8d0a546f0 ("rebase doc: document rebase.useBuiltin", 2018-11-14)
>> 3. 62c23938fa ("tests: add a special setup where rebase.useBuiltin is
>>    off", 2018-11-14)
>> 3. https://public-inbox.org/git/nycvar.QRO.7.76.6.1903141544110.41@tvgsb=
ejvaqbjf.bet/
>> ---
>
> With the obviously intended SOB line: ACK!

Urgh, Junio: If there's no other comments/concerns on v3 requiring a v4
this has my:

    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
