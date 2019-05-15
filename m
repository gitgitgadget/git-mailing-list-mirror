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
	by dcvr.yhbt.net (Postfix) with ESMTP id E3A231F461
	for <e@80x24.org>; Wed, 15 May 2019 12:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfEOK7V (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 06:59:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46672 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfEOK7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 06:59:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id f37so3473726edb.13
        for <git@vger.kernel.org>; Wed, 15 May 2019 03:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=iCu8mZGZ+FduDXPomYMX5vnEyDtMkxsAIp0GAFYi1vU=;
        b=HLpLEXMjBlJJer7JZMSgQGYPKj8qTwjOtAsRnwule2gI6Z1aylSYIuFFLQPdiC1JPm
         XUVRseEJ5vIfmXX3YBFy0p7fukO8T7Hs2D3TSTPL5QYkxxCfvDwN5kjk3DWghRpqGKEg
         IzFe2oDoT2eE1CtYLSD55hiWojhVrW48AYxnyr/mq4WOEovC1BJnEq2SoVkhq2q1A64W
         eT8HTwyrCCDwyDYQnpySXGZeuNdfLIi34aLOdKReXf7UMFyFzPEnyv5hyxeZIjWvJrxo
         9hFCGqbwz8hHMVaKO29Jfrlbovqm9J8uYnCk24qIJm8UjsTHItpzWjzb/lHB4hWavkke
         gGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=iCu8mZGZ+FduDXPomYMX5vnEyDtMkxsAIp0GAFYi1vU=;
        b=liybvYxEZkJ7P8jnE4eOwwJcRrxG6RKZ8R/e1NNoXkQmiH97+Lnsy0wUTBDogi5Jra
         wTHUynmJd9N8fcFi7wrF8iidAzH/mAMyvXTskSLKiCQiMyPwclYp+lbVl0SdbHpaFYHy
         sp9BXHLYYFTfMLxR2Gwyc2dBdtkIe3DjY27W1AnE9eyOn+8eMRZHCrkd8YiX3XuAarCL
         NXOAdAz36IrLeBKekp0Umcj+cRr8vCWgBWobf0e/JFAtkGCdyJDXmOq5r/vfYTJcuvhJ
         1ms9NaSZnWDIrQNeHdUuBMqtZJcgfDHR8YcqTM+1TeS5qjUAZHCQxj23c1zS8mV+O4ka
         7w4w==
X-Gm-Message-State: APjAAAXcyNIIdiCdsLdQ09ODHj3ZNJC0WhMf5hE8lASRrUu34L9JLaJx
        VUpsElU4/cadMSkcKUhrYOsPdmoB
X-Google-Smtp-Source: APXvYqw57Pd83dcMzY7E3+ciCqXdm0CQWfY6vS6/p8dar9e0pZb7X7gXHiUpflY1BwaO/YkhdZomwg==
X-Received: by 2002:a17:906:2481:: with SMTP id e1mr32481600ejb.22.1557917958432;
        Wed, 15 May 2019 03:59:18 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id e43sm671893edb.38.2019.05.15.03.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 03:59:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Poughon Victor <Victor.Poughon@cnes.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feedback on git-restore
References: <3E55146A6A81B44A9CB69CAB65908CEA6B91353C@TW-MBX-P01.cnesnet.ad.cnes.fr> <20190515103031.GA29149@ash>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190515103031.GA29149@ash>
Date:   Wed, 15 May 2019 12:59:17 +0200
Message-ID: <87d0kkvv96.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 15 2019, Duy Nguyen wrote:

> On Wed, May 15, 2019 at 09:38:59AM +0000, Poughon Victor wrote:
>> Hi
>>
>> I came across a description of a new git command currently in
>> development called 'git restore'. Since it's still not out, and the
>> original poster [1] seemed to ask for feedback, I though I'd send
>> some here. Hope that's ok!
>>
>
> Absolutely. And this is even better because other people could also
> comment on.
>
>> Reading the documentation [2] I find it very confusing. In
>> particular when comparing the following two commands:
>>
>> $ git restore --staged file
>> $ git restore --worktree file
>>
>> With the current proposal, the first will restore the index from
>> HEAD, while the second will restore the worktree from the index. In
>> other words, the source for the restore is different in both
>> commands, even though neither specify a source!
>>
>> This means that git-restore really does two different things
>> depending on some other not obvious context. Unfortunately that's
>> typical of the (often criticized) obscure interface of git. To be
>> fair that behavior is documented in [2]. But still, having a
>> variable default value for --source depending on other arguments is
>> very confusing.
>
> I think it depends on whether use actively use the index, or you
> mostly ignore it and always do "git commit -a" and friends.
>
> When you do use the index, the "worktree <-> index <-> HEAD" is the
> three stages that you are aware, in that order, and restoring from the
> "next" stage is expected.
>
> It does feel natural for me that we "restore worktree from the index"
> and "restore index from HEAD". But maybe I'm just too used to the old
> way of thinking? Let's see what other people say.
>
> This is also consistent with other commands, for example "git diff
> --staged/--cached" compares the index and HEAD and "git diff" compares
> worktree and the index. You would need extra effort e.g. "git diff
> HEAD" to compare the worktree and HEAD.
>
> If your workflow ignores the index, which should always match HEAD,
> then different default source is practically gone, since
> index == HEAD.

I haven't had time to follow the whole restore/switch effort in any
detail.

One thing that would be really useful (and maybe it even exists, I just
haven't seen it in the mails) is some abbreviated cheatsheet style doc
of before/after in the UI. Similar to cheatsheets like e.g.:

    https://git.wiki.kernel.org/images-git/7/78/Git-svn-cheatsheet.pdf
    http://unix4admins.blogspot.com/2013/03/unix-commands-comparison-sheet.html

As far as I can tell the best examples are your changes to
s/checkout/[reset|switch]/ in various existing docs, that's great, but
isn't so easy to understand at a glance.

>> So in summary, I'd make two recommendations for this command's UX:
>> 1. Make --source default value always HEAD if unspecified
>> 2. Rename --staged to --index
>
> This --index vs --staged was discussed and --staged is a compromise.
> The problem is --index means something different in existing
> commands. It specifies that you want to target both the index _and_
> worktree. --cached on the other hand only targets the index [1].
>
> It's confusing, yes. But --index/--cached is part of Git and we cannot
> just ignore our baggage and redefine --index to "just index". That
> will create more confusion and inconsistency between commands.
> "--index" is simply not available.
>
> So the compromise is we leave --index/--cached alone and gradually
> move to the --staged/--worktree combo (for other commands as well).
> Eventually I hope people will move to the second pair and mostly
> forget about --index/--cached. And in a very long long time in the
> future, maybe we can deprecate/remove/redefine --index/--cached.

We had some discussion around such UI changes in
https://public-inbox.org/git/87zhtqvm66.fsf@evledraar.gmail.com/

I'm not expecting us to agree any more on that ui.version config point
today than then.

But I do think it would be really useful in such a cheatsheet to have a
third column of "here's what the 2nd column look like if we were writing
git today / weren't worried about backwards compatibility".

It would allow us to at least clearly document what we wanted to do, but
decided not to for backwards compatibility, and perhaps such a
lightweight design doc could even inform future steps about deprecation
and/or "ui.version" config etc.

> [1] https://github.com/git/git/blob/pu/Documentation/gitcli.txt#L179-L199
>
>> Some examples of those:
>>
>> $ git restore --index file # reset the index from HEAD
>> $ git restore --worktree file # reset the worktree from HEAD
>
> I should also note that --worktree is the default, you can just write
>
> $ git restore file
>
> and achieve the same thing. Writing --worktree is only needed when you
> want to make it clear to the reader you're restoring the worktree.
>
>> $ git restore --worktree --source=index file # reset the worktree from the index
>> $ git restore --index --worktree file # reset both the index and worktree from HEAD
>> $ git restore file # reset the worktree from HEAD
>>
>> [1] https://news.ycombinator.com/item?id=19907960
>> [2] https://github.com/git/git/blob/pu/Documentation/git-restore.txt
>>
>> Best,
>> Victor
>>
>>
>>
