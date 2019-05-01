Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F23D1F453
	for <e@80x24.org>; Wed,  1 May 2019 12:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEAMSi (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 08:18:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38318 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfEAMSi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 08:18:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id w11so8071600edl.5
        for <git@vger.kernel.org>; Wed, 01 May 2019 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=2yelyEB5RpEdrTrvS0uFo5EEd2GFl+IT0w/7yCuyeKs=;
        b=oWubGuJCLEcXtj1OeXia8Sw2B37moNBaRTdNAv1rRelzYi9EeWR4JZKQgxI/Y28PhM
         g1wjafCxd9j29pTpNHbVsz5h+G59szYZmH+RNMO6JXvTA+1Dd8C/tvP0LVr3wxE8qP6N
         MN8hcIlhErEv/W0JKphAJhIKbaMh4pDTP0IMfDSsGxQT8VOsiAUbKjNtmS7QtGs8ARRW
         BLYkXGf6P/P1UnM+CMlKFyEONszvGcSZpgfgXkmYyMYk7RmgQS+284JiaFDhn/dgYjQd
         gLko3WMCcfn5dH/CKqsAkPJOYILOYE1wO3PHZ3KabZ4iH2SkkEt6AIjqIzrYyzGPf1hz
         UBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=2yelyEB5RpEdrTrvS0uFo5EEd2GFl+IT0w/7yCuyeKs=;
        b=iLvZog7Cxi9N/16MBlPemMo1mInS2UBQF7NTszwFWuV/4ZW+KyGLcjLKXk1kdQamsN
         IOkToVTXqUevw7g+Q0vWnukbXpPSPme/DLoddd35pMb0ImPAPZVSmLwu+DjMw6hWPcMd
         oS++/uAPdEwXehjPW/YEx1wuq9UlWVyyCaiWD42q0jHQV0IqameVZMenup9OhpqZnIVn
         3xWHQPVBe9PQFXlABSBuVo4oAPXUr9ZLZF08lwDTt0Bb5JV1DCZHA7+lCW1QccDiOrZd
         07sizkSx9kvxi9dsr4/eJhQ7CCXk0KP/weYRl2HRLNEtim6MirydaBOhFbYt7G4e+RoU
         bSlA==
X-Gm-Message-State: APjAAAV7W1YtRkzrk7lxAiLbJZGhsLO4UaShJCBMh3gA0x6XS+3JwkRz
        Y1gEIvPtx3UWhyBLf1c6MsnUtyVLbvc=
X-Google-Smtp-Source: APXvYqwOyuZD1RzyrXm9SwS4rYaS4jHUJwVaoT8ft1R7Ilfs8+FmTRVFJmssth6Rngp/u2Ca3TEQwQ==
X-Received: by 2002:a50:9490:: with SMTP id s16mr13430635eda.260.1556713116506;
        Wed, 01 May 2019 05:18:36 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id s24sm10627305edq.79.2019.05.01.05.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 05:18:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Subject: Re: How to undo previously set configuration? (again)
References: <20190424004948.728326-1-sandals@crustytoothpaste.net> <20190424023438.GE98980@google.com> <20190424230744.GL6316@genre.crustytoothpaste.net> <87k1fis8gq.fsf@evledraar.gmail.com> <20190425143614.GA91608@google.com> <CACsJy8B5j2K=RU7N+h-i9HszuYuYd+fNmAftVDW-4nJ_o5z8Sw@mail.gmail.com> <20190430211415.GB16290@sigill.intra.peff.net> <CACsJy8B+hDqKnu+0tkPC42w+_6RhzYac1BxYtdyxctcARG=VCg@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8B+hDqKnu+0tkPC42w+_6RhzYac1BxYtdyxctcARG=VCg@mail.gmail.com>
Date:   Wed, 01 May 2019 14:18:34 +0200
Message-ID: <87r29iqsf9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 01 2019, Duy Nguyen wrote:

> On Wed, May 1, 2019 at 4:14 AM Jeff King <peff@peff.net> wrote:
>> It's definitely not implemented universally; each consumer of the config
>> option must decide on it (and it will probably always be that way to
>> some degree, since we don't know the semantics of each options; recall
>> that we may be holding config keys for other non-core programs, too).
>> And we just haven't retro-fitted a lot of those older options because
>> nobody has been bothered by it.
>>
>> That said, I am a proponent of having some kind of clearing mechanism
>> (and I was the one who added credential.helper's mechanism, which has
>> been mentioned in this thread).  I think it makes things a lot less
>> difficult if we don't have to change the syntax of the config files to
>> do it. With that constraint, that pretty much leaves:
>>
>>   1. Some sentinel value like the empty string. That one _probably_
>>      works in most cases, but there may be lists which want to represent
>>      the empty value. There could be other sentinel values (e.g.,
>>      "CLEAR") which are simply unlikely to be used as real values.
>>
>>   2. The boolean syntax (i.e., "[foo]bar" with no equals) is almost
>>      always bogus for a list. So that can work as a sentinel that is
>>      OK syntactically.
>
> Another question about the universal clearing mechanism, how does "git
> config" fit into this? It would be great if the user can actually see
> the same thing a git command sees to troubleshoot. Option 1 leaves the
> interpretation/guessing to the user, "git config" simply gives the raw
> input list before "clear" is processed. Option 2, "git config"
> probably can be taught to optionally clear when it sees the boolean
> syntax.

We can make it fancier, but we already deal with this, e.g. if you do
"git config -l" we'll show "include{,if}" directives at the same "level"
as other "normal" keys.

We also provide no way in "git config" to properly interpret a
value. E.g. does a "user.email" showing up twice for me mean I have two
E-Mails at the same time, or does the last one win? We both know the
answer, but git-config itself doesn't, and that information lives in
docs/code outside of it.

Similarly we'd just print a sequence of:

    user.name=foo
    user.email=bar
    exclude.key=user.*
    user.name=baz

And it would be up to some "smarter" reader of the config data to
realize that the end result is one where we have no "user.email" set,
and "user.name=baz".

But yeah, optionally having some new --list-normalized or
--list-after-excludes or whatever would be great, and presumably not
hard if we had some central "excludes" mechanism...
