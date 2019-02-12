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
	by dcvr.yhbt.net (Postfix) with ESMTP id B475A1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 13:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfBLNQs (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 08:16:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33631 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbfBLNQr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 08:16:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so2680644wrw.0
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 05:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ie3UqBPbBU/8EXlV43YJTNfjbxZt6mSYmnwl8uMisk0=;
        b=B0oMaHoNe8mpcdhYq3QwOLBHwO04bEH9ZzKohDZ4Aw5p52DWga4SNnopagEsGGO2De
         0NobrwvE+LFfWVk76ef/naof/ilqBi5QN1Ud7miSqeaqu/APrOoHzKuX3ySZKd9wjfOu
         UGkLsnq8MUV4DXajJNyvFBH+xd6XYhLawgUYwBxyH9u1l94P5qHDngqqP1Mxy8HXTsBo
         GpAjcnrhyid9e3GGvw4imzloytQM1scl4iuqWR6p1/GoBNED6Gmoja0xlwjRZsAX/99j
         lmKXgAT/x9UTN5Jom8eLWPbiG/ni2+7SUXxJO2+YXipwyPssJNKLgaZv4dkAEUBHPwNb
         OY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Ie3UqBPbBU/8EXlV43YJTNfjbxZt6mSYmnwl8uMisk0=;
        b=sZy39syHpWUp+BW32/30UCY6usqdgQzzj8eVPvCeRmxOSfPnNUw/0GJBppV6EwXENs
         1u+uqRJNb5B0XupSZAWNbny3ZBYeTejMaBRDDcGnS6SPaLNacV8aKoVLNuY3Od/fs8CJ
         1N7hvPLFrGHv7MovfgdZE8vRZXSSlZDb69BES1NdbQ6ru8dSCxklNKTj56Rzav2D8FzZ
         wwJ8IsfZmG8STboH57xakgdbLK76vj8i59z2HLEOrBHXNa8PCBtCvbfC/+x5U1Mercco
         X21b6sQwkKxbojlMDVo/GuWC1OQNYEx2RSBl4d1GGGZY9e4lDKhGy7ruJ2Ox9fNi4VDP
         HnrA==
X-Gm-Message-State: AHQUAuYPJddvhid9RV9fnYmRzfxO3SCtcmKcaiGNruvvM31Wk4YYEt01
        tfgr2Nh+7BgaAhZsclcasXU=
X-Google-Smtp-Source: AHgI3IZYyHDqXG1Vt/OmqDuXhPOR2vPmynVW5Opi3wothrvgU66iRA9lNhk7fSONc6F0ZCAxBtK+BQ==
X-Received: by 2002:adf:f388:: with SMTP id m8mr3041685wro.133.1549977405972;
        Tue, 12 Feb 2019 05:16:45 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id c65sm4452805wma.24.2019.02.12.05.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 05:16:45 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com> <87sgwtjjbk.fsf@evledraar.gmail.com> <20190212124323.GA11677@ash> <CACsJy8D-FVGXHbqKf8BAVWEFchbF5LAN6x8UM5g7v_HLO29CLQ@mail.gmail.com> <87pnrxjghb.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <87pnrxjghb.fsf@evledraar.gmail.com>
Date:   Tue, 12 Feb 2019 14:16:45 +0100
Message-ID: <87o97hjgea.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 12 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Feb 12 2019, Duy Nguyen wrote:
>
>> On Tue, Feb 12, 2019 at 7:43 PM Duy Nguyen <pclouds@gmail.com> wrote:
>>> The test failures on NetBSD and Solaris/Sparc, not sure if we can do
>>> anything without test logs or access to these systems.
>>
>> Actually if you could tweak your ci script a bit to run tests with -v,
>> that would help.
>
> I vaguely remember doing that and running into some issue where it
> truncated the output, so e.g. I wouldn't see compile warnings on AIX
> because of the firehose of subsequent test output.
>
> But yeah, having this in some smart way would be great. I'd be most keen
> to just work towards offloading this to some smarter test runner as
> noted to Johannes upthread.
>
> I.e. a good test_for(SHA1, params) function would run the tests with
> "prove", and e.g. spot that tests so-and-so failed, and then run those
> specific ones with -v -x.
>
> That's how I was going to fix the log overflow problem, but I'd much
> rather not continue hacking on this gitlab-gccfarm-specific thing, and
> instead work towards something more general.

Also, I forgot to note that if you'd like to get a login on those boxes
you can just request an account as noted in
https://public-inbox.org/git/20180824152016.20286-1-avarab@gmail.com/
