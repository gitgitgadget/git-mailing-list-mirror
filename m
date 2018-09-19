Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677D21F453
	for <e@80x24.org>; Wed, 19 Sep 2018 17:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbeISXBl (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 19:01:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44470 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeISXBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 19:01:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so5530912edb.11
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=L9bzlBsVOKbZSQyT0EEbqOJ+G1AcPZxcmgoQNGnwRS0=;
        b=QXODA1umxVVYJTo3wY95DJjXCi+qp93bWLuvo2bhrZcIFyTC/3/u6OMKb/NeHJ3smJ
         aWnBxwI+gPu6dOADQUR62FbHmZXtj+3e8AQJ2/dn8wvFX1cBQvpc2yMFgbfTSg4NXQdV
         IiBJa/sC1erI8S5rbqJlLd2WqXWslCfap/e7x3Up3t9anGB9hjvwVp9NSfB8U4oLW58K
         8u9kG9wFk9J/3AIY66S5wsXifdl7Tv01LQ82hcklMwSy8VOhCezUkSSru/2epO8NJeCR
         l0tpayZV47AvWEYU14U5Hpaz5qe10wm5jju7Iz4uPPUDdiZwN+nSW3W3qyteuCcQNG14
         Ua4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=L9bzlBsVOKbZSQyT0EEbqOJ+G1AcPZxcmgoQNGnwRS0=;
        b=V+IWKSglnOjBzOBA1+7q3SQoPaJ/n1G9YnPox40G15VlmBCNjwDnrgyzw5j40Rkxf3
         q/B8gq9xHr+pFRiNMlyl5i2a+yhmDu7a1XXMpH+cg/sjCY7f9In8gT19tWihjtm+CxSB
         ZvCIaPJVwMapfTVvmaAVBSYUv4owiewH+ail8haiFhSiBijhiru61b7qExxu7sTDrvwd
         kn1zN6RqAEHUVENYdOrE1ggimXVe2neVSCcwNOx8IJqdSR5LwJca5kuGJUHevIWDECB/
         Ha8gqhD0Xm6nbWQj/e5FbYqm1wWpgztgir7W67GVhr2kVKxLWkOcOmHpmygaFrr49yh7
         iU1Q==
X-Gm-Message-State: APzg51A10hTfb8PfodIU8BzHjXxyCM3uK1WLTw8S9VCHgQ7kx2iDs37C
        r6x/PH9a+1b2tMV8eLAKtCo=
X-Google-Smtp-Source: ANB0Vda3hrCQXyFfxB3JS+KgQy2T3PBiJy86alxZ38PNlFgqpgRxOrDRNZJSTVQh/rM02g+2PDSD9w==
X-Received: by 2002:a50:9a02:: with SMTP id o2-v6mr58418382edb.236.1537377766093;
        Wed, 19 Sep 2018 10:22:46 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id b20-v6sm1998048edc.30.2018.09.19.10.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 10:22:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reflog expire: add progress output
References: <20180919141016.27930-1-avarab@gmail.com> <CACsJy8CX8xspbsW7Ta3aOD6LHh55ZaJ0tdrYeWDP_Vyw70NXtA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8CX8xspbsW7Ta3aOD6LHh55ZaJ0tdrYeWDP_Vyw70NXtA@mail.gmail.com>
Date:   Wed, 19 Sep 2018 19:22:44 +0200
Message-ID: <87tvmljtaz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 19 2018, Duy Nguyen wrote:

> On Wed, Sep 19, 2018 at 4:23 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Before this change the "git reflog expire" command didn't report any
>> progress.
>
> I love these progress additions you've been pushing lately :)
>
>> diff --git a/builtin/reflog.c b/builtin/reflog.c
>> index 3acef5a0ab..d3075ee75a 100644
>> --- a/builtin/reflog.c
>> +++ b/builtin/reflog.c
>> @@ -10,6 +10,7 @@
>>  #include "diff.h"
>>  #include "revision.h"
>>  #include "reachable.h"
>> +#include "progress.h"
>>
>>  /* NEEDSWORK: switch to using parse_options */
>>  static const char reflog_expire_usage[] =
>> @@ -225,14 +226,20 @@ static void mark_reachable(struct expire_reflog_policy_cb *cb)
>>         struct commit_list *pending;
>>         timestamp_t expire_limit = cb->mark_limit;
>>         struct commit_list *leftover = NULL;
>> +       struct progress *progress = NULL;
>> +       int i = 0;
>>
>>         for (pending = cb->mark_list; pending; pending = pending->next)
>>                 pending->item->object.flags &= ~REACHABLE;
>>
>>         pending = cb->mark_list;
>> +       progress = start_delayed_progress(
>> +               _("Marking unreachable commits in reflog for expiry"), 0);
>
> Maybe just "Searching expired reflog entries" or something like that.
> It's not technically as accurate, but I think it's easier to
> understand by by new people.

Or "Pruning reflog entries"? I was aiming for some combination of a)
making it clear what we're doing (pruning stuff) b) that we're doing it
on a subset of the counter of the (very large) values we're showing.

So the current one has "a" && "b", "Searching..." has neither, and
"Pruning..." has "a" but not "b".

Maybe making a && b clear isn't that important, but I'm currently
leaning towards keeping the current one because it's not *that* long and
makes things clearer to the user.

> Do we have --quiet option or something that needs to completely
> suppress this progress thing?

Yes. I also see my commit graph process patches sitting in "next" broke
the "git gc --quiet" mode, and I'll need to submit something on top
(which'll be easy), and submit a v2 on this (pending further
comments...).

Is there a better way to test that (fake up the file descriptor check)
in the tests other than adding getenv("GIT_TEST...") to the progress.c
logic?

>>         while (pending) {
>>                 struct commit_list *parent;
>>                 struct commit *commit = pop_commit(&pending);
>> +
>> +               display_progress(progress, ++i);
>
> maybe rename it to commit_count or something and leave "i" for
> temporary/short lived usage.

Good point. Willdo.

>>                 if (commit->object.flags & REACHABLE)
>>                         continue;
>>                 if (parse_commit(commit))
>> @@ -253,6 +260,7 @@ static void mark_reachable(struct expire_reflog_policy_cb *cb)
>>                 }
>>         }
>>         cb->mark_list = leftover;
>> +       stop_progress(&progress);
>>  }
>>
>>  static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, struct object_id *oid)
>> --
>> 2.19.0.444.g18242da7ef
>>
