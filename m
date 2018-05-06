Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4D8200B9
	for <e@80x24.org>; Sun,  6 May 2018 18:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeEFSDF (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 14:03:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38042 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeEFSDE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 14:03:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id m198-v6so11667285wmg.3
        for <git@vger.kernel.org>; Sun, 06 May 2018 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tVglMSOOgVVOYhPGbgoQHmJtAgK9KA1e1yiaM68fffk=;
        b=CeLlL4dx7AHxw+LNEzw2skwZcgXr6urCgZRnvjLdItmhpnCCAZOqauApSfjg9r6J74
         PdaRSM7InzcN3QXtp3AVYW81doCyV9gLQ/IbvhLeFivt5qb4R0hJj6xs7jbgJlKgDSHL
         USnyNavR1wlQeNXEq4taoYqxD1S0SwhAJwSPBGKzcdxfRxRGG1qea5GzC/U/GZFoql/V
         iaeNdDqBNW+DYu86z5tMGTM0IRn3Z4cqqNCpOU2sFT3r29HHa/m4Jtv/NxT7mudZNMQU
         A8I88aj10V0AGnWMywbDm2xi7m+o1vwzISi7+Mss4C9raqjPGV6c+3QSAaXxO934JLgD
         aTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=tVglMSOOgVVOYhPGbgoQHmJtAgK9KA1e1yiaM68fffk=;
        b=SWM3W7W4xCkF+DRiaV6cBPQ4+QQtyG1OF0qiYlqHbhnDHRLOxokWXNhslTWClLY/NB
         Irg8zjS7InaZ8no1wBVCpu47ShFnFrbFbSSzWLX3uxdnrALm+Ukb7rXwwLEdWKfB7QyU
         chD0niy4ki88/83szNTOQNC8F/EPP1VKnd8kwh4k0rTIZ7jzQIjTjLAQmfadEd5RivkH
         DqavBYteZlpnrn3PwXVjPnqfgkk4OALcsRsdjsSxiG+BNPGUTHx+7Sbyy6t1E8VJ0oeK
         /IWqU7Kd588KTMY+DmNC721PMiZby5syCaKdNHnOatLNYkFA/7NkDL5+4YrOSIvpDiM/
         a1rQ==
X-Gm-Message-State: ALQs6tAybpHG2X9I1+HemZqWTN8Ig1UNpyB9HAasML+o6eGF4A4AulLX
        5R0oIC/NoOJcVdd4mCK6WPB4AVgl
X-Google-Smtp-Source: AB8JxZr2AXc4Yqjg/iP2s6IK3azY1mTdlrSQ7PPJ6GYl1t4RQG0dDAolS86b+CunL/C7kF1hLNJPFA==
X-Received: by 2002:a50:bc02:: with SMTP id j2-v6mr40201750edh.172.1525629782966;
        Sun, 06 May 2018 11:03:02 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id m20-v6sm11202092edq.46.2018.05.06.11.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 May 2018 11:03:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 7/7] contrib/git-jump/git-jump: jump to match column in addition to line
References: <20180421034530.GB24606@syl.local>
        <cover.1525488108.git.me@ttaylorr.com>
        <326d07b48654ab2a64d09eb17d995a26d06bcdb1.1525488108.git.me@ttaylorr.com>
        <CAN0heSoiOd-oXj_0kJbc2qQCQAortCuXERpxF4Cro8pi4x1eBQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAN0heSoiOd-oXj_0kJbc2qQCQAortCuXERpxF4Cro8pi4x1eBQ@mail.gmail.com>
Date:   Sun, 06 May 2018 20:03:01 +0200
Message-ID: <87d0y8y84q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 06 2018, Martin Ågren wrote:

> On 5 May 2018 at 04:43, Taylor Blau <me@ttaylorr.com> wrote:
>> Take advantage of 'git-grep(1)''s new option, '--column' in order to
>> teach Peff's 'git-jump' script how to jump to the correct column for any
>> given match.
>>
>> 'git-grep(1)''s output is in the correct format for Vim's jump list, so
>> no additional cleanup is necessary.
>
>> diff --git a/contrib/git-jump/README b/contrib/git-jump/README
>> index 4484bda410..7630e16854 100644
>
>>  # use the silver searcher for git jump grep
>> -git config jump.grepCmd "ag --column"
>> +git config jump.grepCmd "ag"
>
> I think this change originates from Ævar's comment that it "also makes
> sense to update the example added in 007d06aa57 [...] which seems to
> have added jump.grepCmd as a workaround for not having this" [1].
>
> Somehow though, this approach seems a bit backwards to me. I do believe
> that your series reduces the reasons for using `jump.grepCmd`, but
> regressing this example usage of `jump.grepCmd` seems a bit hostile. If
> someone wants to use `ag`, wouldn't we want to hint that they will
> probably want to use `--column`?
>
> Is there some other `ag --column --foo` that we can give, where `--foo`
> is not yet in `git grep`? ;-)
>
> Martin
>
> [1] https://public-inbox.org/git/874lk2e4he.fsf@evledraar.gmail.com/

Yeah it doesn't make sense to drop --column here, FWIW what I had in
mind was something closer to:

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 4484bda410..357f79371a 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -25,6 +25,13 @@ git-jump will feed this to the editor:
 foo.c:2: printf("hello word!\n");
 -----------------------------------

+Or, when running 'git jump grep' column numbers will also be emitted,
+e.g. `git jump grep "hello"' would return:
+
+-----------------------------------
+foo.c:2:10: printf("hello word!\n");
+-----------------------------------
+
 Obviously this trivial case isn't that interesting; you could just open
 `foo.c` yourself. But when you have many changes scattered across a
 project, you can use the editor's support to "jump" from point to point.

I.e. let's note what the output format is now like for 'grep', and no
need to change the jump.grepCmd.

The above patch may be incorrect when it comes to the line numbe /
column number / format, I just wrote that by hand.
