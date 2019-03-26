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
	by dcvr.yhbt.net (Postfix) with ESMTP id 58168202BB
	for <e@80x24.org>; Tue, 26 Mar 2019 11:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfCZLAo (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 07:00:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44590 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCZLAn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 07:00:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id x10so10289209edh.11
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 04:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2mU+QRU5z7vhzwwKOUQhZiVvoOp98Yq1dvbv73NoUOI=;
        b=UuaHcN/ApLjZuEItSBPzWUG2RUxOuLltsur1UZwk97BFIkNEDr9p4vbpQNRC+qSFUa
         JYiKalPQZT5iFwxvAr9YbeMJJQdTskg3SDNKDFzkiU6c95eUVbLcfW241vRvnZZRqdUp
         Zt+BFzoAsuNKDayKV/72WanwkOUx99h/ZVDOvi1+8nniCWKjKr0LpHTGSKdT347ujPJc
         UTLk+vcGEO1YpX/xmZPg0HlQPaBJFP4JYDqDTLpALtGfS9kmYWuquV3d8Wvxqt9NVThp
         WuyGvd/cc72ia0Y9KpbmIuh79JjVUxvnoh74YwdQxwcF3yOxE3qOWPDgVcCkrV4GqFG3
         zedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=2mU+QRU5z7vhzwwKOUQhZiVvoOp98Yq1dvbv73NoUOI=;
        b=Yxk/qoZAF/ww/M+Tv0+cihspg4CInCN46QJqckF6zB5w2bt30sV0EVy7ZC9zvRtQtY
         YtEH79kGxfCStbimwF8qTasuRk7IjDuX4eVR8Qf/9bJourObJ1pYlmMN7m2sbFsprf1p
         YvbbtRskucwXvBUAZh7MxYyeAsBmJRp9jceII0ye4YC7CDhKnUJp1zfWmagThCej20ye
         RAeQz1bVcIqO51Jn2QbbCtDZGYP+F2vWicvv1teA+Ngp7pZ/2xSe/4jop0vEkg++5HDz
         ZHdhmUfWn29ybfcfhLtzMcOwiBbdeyRI6D+FGhs7Z/gvIwZzhr0k2AAvjN4iR1Cpjffw
         EaXQ==
X-Gm-Message-State: APjAAAXmP2UGRdeb9gOQFqQs8qbGf/WCex2NmBkNOWd437rXa+iSTt4l
        NlkfZsmM/iSHYUZRiuTskaI=
X-Google-Smtp-Source: APXvYqwGSfjrJTscGlDRWvGLLZQTZb6flU5YvNt1aGGzblTrJkDgYGGpQ3sVcd7/wN0jyKouyW8ueA==
X-Received: by 2002:a17:906:498a:: with SMTP id p10mr17190754eju.158.1553598041072;
        Tue, 26 Mar 2019 04:00:41 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id w5sm899312eda.63.2019.03.26.04.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 04:00:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: allow for configuring option abbreviation
References: <pull.167.git.gitgitgadget@gmail.com> <20190325202329.26033-2-avarab@gmail.com> <CAPig+cR0Ldt3EpQ683ZFNFXggfsTrdeZ3R-V6pDBZNA1N3c+xg@mail.gmail.com> <87o95ybmgf.fsf@evledraar.gmail.com> <CACsJy8Bk=Z8BaVeAhKzF4PWYLLG76cADooHKNw+Xy3EztZL1DQ@mail.gmail.com> <87lg12b13p.fsf@evledraar.gmail.com> <CACsJy8BpToq2VAzFo61dz7Hco42Sbka5qQm3ACn_6aejUxAKOg@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8BpToq2VAzFo61dz7Hco42Sbka5qQm3ACn_6aejUxAKOg@mail.gmail.com>
Date:   Tue, 26 Mar 2019 12:00:39 +0100
Message-ID: <87ef6tc33c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 26 2019, Duy Nguyen wrote:

> On Tue, Mar 26, 2019 at 1:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> I don't see how a new "abbreviatedOptions" is plausibly going to crowd
>> out anything else, sounds pretty unambiguous to me.
>
> By crowded I mean a lot of configuration variables under "core"
>
>> By my count out of the the existing GIT_* variables in git.txt around
>> 1/3 are already configurable via config, another 1/3 (all the GIT_TRACE
>> stuff) is something we've wanted to have configurable in the past (but
>> nobody's gotten around to writing patches for).
>>
>> I think it's fair to say that when we normally add user-configurable
>> stuff we do it as config, not as new env vars.
>
> I disagree that not every configuration knob has to be a configuration
> variable, especially when core.* more or less becomes a dictionary
> that you can't really read anymore (unless you know the key to look
> for). But I see you're dead set on adding config vars. Go ahead.

I don't mean to pile on in this thread, and cards on the table: In terms
of stuff I can be bothered to write a patch for and stuff I *really*
want in git, this thing is maybe on a 2/10 out of a 1-10 scale.

I.e. I'd use it, and it would probably save my ass *somewhere* down the
line, the motivation was being bitten in the past, so once I spotted
Johannes's series I was reminded to clean it up & submit it. But I
wouldn't care enough to carry a forked git with this (unlike some other
stuff).

I just wanted to elaborate *in general* on the question of "why config
and not env".

I don't think everything we find reason to add a knob for needs to be a
config variable. E.g. I can't think of a reason for why the
GIT_*_PATHSPECS variables should be. That seems like the sort of thing
you'd only tweak for a *specific* git invocation. I wouldn't oppose it
being config if someone had a compelling reason & patch, but can't think
of one myself.

What I wanted to get across in the above replies to you/Eric, but
probably did a bad job of is that separate & aside from the merits of
any given new config variable there's the problem of being a "zookeeper"
with large git installations.

I.e. you don't even pick the animals, or feed them, but if the zoo's on
fire or overflowing with poop it's your problem.

So I have some servers where I'm in charge of maintaining/upgrading git,
and it's on me if crap breaks in the aggregate, but I'm not writing
anyone's individual scripts for them, and the runtime envs for those
might be varied.

It's for those sorts of cases where having the flexibility of turning
something on either in the env or via system-wide or user-wide config is
handy. I.e. in this case I might say:

    "You can run your scripts, but you'll be in 'strict mode' and need
    to spell out your options, because I'm not getting out of bed if
    your random job using git breaks because you were lazy and did a
    'git init --ba'".

I don't think this is a use-case that's obvious, so it's worth
elaborating on it. I suspect a lot of devs/users on this list have
advanced git use-cases, but they're all ones where the git processes
they care about/need to maintain run as a child of their login shell, or
equivalent. In that case the config v.s. env var distinction mostly
doesn't matter.
