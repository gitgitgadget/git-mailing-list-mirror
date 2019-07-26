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
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E721F462
	for <e@80x24.org>; Fri, 26 Jul 2019 20:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfGZUFf (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 16:05:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44241 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfGZUFf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 16:05:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so54208327edr.11
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 13:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PeOlix8IQQdCV9e1BX81+zA5dOLcLFiuqaHgIW/4HUE=;
        b=j4EZvUH4qxGPc7C7vANQNAVGU5mi0A6u4VDxoFm2E3V9etkO9gOe+sc30HlJcSdbO5
         uZYB4kiTI0u7ihEhj0t5UAUwQefJopCLNDq+Jt+2fT67NqMeuwhXohxfoW818kTWdWeQ
         N/KAeMGC0nRg7UoEZgjOLA/FEbT61LzhII6BTf9GUgQWCUrgns5mHm6/3NWoufkROMMJ
         Lx8oRKME6YMYJRecIa7E9EGYewK2yWQq6yQwHLSqG/D9m7hsoTtAXiueKPKnYomJL/Tz
         52AyY1TPiLPhv84NtbzFO+GqC+d48IESDAe5sru6FSzaZV4uX76Ismne03HXxXgsxaf9
         ph4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PeOlix8IQQdCV9e1BX81+zA5dOLcLFiuqaHgIW/4HUE=;
        b=cyw9FgKke2Bm/ByJyZ1fSOPM7mP4TgCr/rrCSkhVCYdqmwPFqRtbFrMB/4iMR+k4nM
         J4uwuAi+QQ/+loOlPXDHhmXOLVdtEDD1+fN2SB/5QEK7M9Cq0rRRUiJtGVaNM4JTAW5A
         ZPpyM6cPdWfR1DhGJ5r54HrNmYHrFsJH3SpcWX7l0pcXdaoZYnxfoCSaoe51rUgsSiaM
         q5jjw4QA9ealUfHNui9XjCibVGf2RGQSn94yjCMztEL41Yy0xZiFPt9VYBDW9tKP6qFw
         cqRjJ1orZ0P/pkFP8nqieJlklR2JOou+J5VB6LOhb5sermVK8Ab0jvtXzuKVvbbZT75a
         trVg==
X-Gm-Message-State: APjAAAU5+zByBHHlBt2bqNi5ZbVm0f7n8k/xaTvWX1Sfq0c5w04LZ/2h
        Mtiz3Fg612GeR2KRVgQX7SqMNa+yH74=
X-Google-Smtp-Source: APXvYqzuofZFDDACmNZwYhfOSUiD8bsID6VJSI36a7DEKkN7TcRLabcdoUOzWnE5P6RJQ2t41x3U9Q==
X-Received: by 2002:a05:6402:782:: with SMTP id d2mr85108755edy.80.1564171532928;
        Fri, 26 Jul 2019 13:05:32 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id d44sm14515893eda.75.2019.07.26.13.05.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 13:05:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
References: <20190721183115.14985-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet> <87muh57t5r.fsf@evledraar.gmail.com> <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com> <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet> <CAPUEspgytjywYHywGT4yAwYpQbMUicN4bpHfoD+M_HMe8YdPtg@mail.gmail.com> <nycvar.QRO.7.76.6.1907241245540.21907@tvgsbejvaqbjf.bet> <87lfwn70nb.fsf@evledraar.gmail.com> <xmqqpnlzqh3d.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907251143430.21907@tvgsbejvaqbjf.bet> <xmqqlfwmqnb5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907252021230.21907@tvgsbejvaqbjf.bet> <87ef2c7roy.fsf@evledraar.gmail.com> <CAPUEspgseYvKTNN6EkqjKo1zQXRjUzyiLMe0kJwnNu=F3ATmOA@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAPUEspgseYvKTNN6EkqjKo1zQXRjUzyiLMe0kJwnNu=F3ATmOA@mail.gmail.com>
Date:   Fri, 26 Jul 2019 22:05:31 +0200
Message-ID: <87blxg7e9g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 26 2019, Carlo Arenas wrote:

> On Fri, Jul 26, 2019 at 8:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> I'm not sure what a real fix for that is. Part of it is probably 8/8 in
>> the series I mention below, but more generally we'd need to be more
>> encoding aware at a much higher callsite than "grep". So e.g. we'd know
>> that we match "binary" data as not-UTF-8. Now we just throw arbitrary
>> bytes around and hope something sticks.
>
> I haven't look yet at your proposed changes, but my gut feeling is that
> the work to support invalid UTF in the yet unreleased PCRE version would
> be needed as part of it, and therefore it might be better to keep PCRE
> out of the main path until that gets released and can be relied upon.

I'm hoping my 8-part series is good enough to move it forward, but as
48de2a768c ("grep: remove the kwset optimization", .2019-07-01) shows we
can always just fall back on using regcomp instead.

> kwset is not going away with this series anyway, regardless of the no-kws=
et
> name on the branch.

The larger context here is that this is the 1st step of a 2-step series
to get rid of kwset. If I can pull that off successfully is another
matter, but that's the plan. After it's applied we just use it in the
pickaxe code, and it's relatively straightforward to convert that. See:
https://public-inbox.org/git/87v9x793qi.fsf@evledraar.gmail.com/

>> > If we're already deciding to paper over things, I'd much rather prefer
>> > the simpler patch, i.e. Carlo's.
>>
>> As I noted upthread PCRE's own docs promise undefined behavior and fire
>> and brimstone if that patch is applied. Those last two not
>> guaranteed. So we need another solution.
>
> in my original reply I mentioned I explicitly didn't do a test because of=
 this
> "undefined behavior", but I think it should be fair to mention that we are
> already affected by that because using the JIT fast path does skip any
> UTF-8 validations and is currently possible to get git into an infinite l=
oop
> or make it segfault when using PCRE.

Right, this is a good point that we should take notice of. I.e. this is
*not* a new bug per-se, you can do this on master and get a UTF-8 bug
from git.git:

    git grep -P '(*NO_JIT)[=C3=A6]'

> in that line, I am not sure I understand the pushback against making that
> explicit since it only makes both codepaths behave the same (bugs and
> risks of burning alike)

Because with my kwset series we're getting a lot more users of this
until-now obscure code, so we're finding old-but-new-to-us bugs.

We've had this bug dating all the way back to Duy's 18547aacf5
("grep/pcre: support utf-8", 2016-06-25). It was first released with git
2.10.

So why are we getting list discussion about it *now*? Because my kwset
series got merged to "next", and we apparently have a lot of users who'd
use fixed-string git-grep under locales, but never used PCRE via -P
explicitly before.

So it's worth getting the semantics right. As noted in the E-Mail I
linked to earlier my ulterior motive here is to get to a point where
we'll funnel all regex matching through PCRE implicitly if it's
available.

We need to get these UTF-8 edge cases right. I don't know if my recent
8-part series gets us 100% there, but hopefully it at least gets us
closer to it.
