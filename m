Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FBCE1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 20:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932474AbeFNUmv (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 16:42:51 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34604 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755261AbeFNUmu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 16:42:50 -0400
Received: by mail-ua0-f196.google.com with SMTP id 74-v6so5041238uav.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 13:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cCZCvdkh6u0Gk7AVhitSOb6TkDM5TojgdH8QMKcLp7s=;
        b=VM0qbj/ngspcqRl24i/WSd0EomgncCiVhKt/VlTfpJXDZS8kjDyXo9WXPBZ4bxjeTQ
         /VftxE9l0JVvr3HtYMZSvKKZmp1njfm7CrBzzn3tIvtoIaR4H56JgZZ9Gj6KdmPrKuQf
         oUMRhapf4O87bsm9Ab7QhQNKXWBzRIhQUMqAUjj1wuQQDgvONUBcEKjNlWYkqYw0BtvA
         uVKTZTrMWs5S3se0sETo5QD//uD7xt5SiKsjWTa8hDytfbyRY5/C2EffX38sgZvZNhB7
         8/MieGKTq1+Scchb4pgXwJ6AVE5rWhYK/WECewR01NHlOWTOMr7dfvMpLmhx0hGtpsei
         VLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cCZCvdkh6u0Gk7AVhitSOb6TkDM5TojgdH8QMKcLp7s=;
        b=pkrBf/a3QqaupQnPt3kPJrhgpLwJSyrxGPjiEoAwscriDZydSqthOXN/v7U/9nT1yc
         di2PajdJbfYXOf/KF9ffWBIj6CJGDC05oJ5b43gq/PdxoEAev11lHfRb7JOe/ygpS2rF
         LrkYWghT9GyuqUpCTndIS9id2frkm3XZYY5zPXmuDi4zNiL6DQEkialPKqjOAjkznQt1
         aTdmH1mtRUu/hNFLCI0/2FSrD4UvvT9HBS7rqWkTYTlzA78oNbtChaKQqsEb51I+6GEL
         8zomKSe52aFyDw5xYQoVPX8VzmdOK83Ha+CGjGzq62AfT2PafLXeFE1nexbRCnh1b8Rt
         Sadg==
X-Gm-Message-State: APt69E3ConmoGhYJUAl2EIT3vAE4ISWxJjx3bGI6h2afcU3l/9anPhCS
        tu0scrnQuQeqN1kDJwTS2DAq8nxVvOe5PWJAQvw=
X-Google-Smtp-Source: ADUXVKLoll9bM/w2VArhEq1b04QVzlYHTNGT4gV4v5giHvECThvK/cW0edgipOHs9aM3viEYQxS6+Nh84ZkRzIov2Mc=
X-Received: by 2002:ab0:5e83:: with SMTP id y3-v6mr2848142uag.112.1529008969459;
 Thu, 14 Jun 2018 13:42:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 13:42:48
 -0700 (PDT)
In-Reply-To: <e5e50510-8297-6e1b-d446-d717b021c6f0@gmail.com>
References: <20180611135714.29378-1-alban.gruin@gmail.com> <20180613152211.12580-1-alban.gruin@gmail.com>
 <20180613152211.12580-3-alban.gruin@gmail.com> <xmqqlgbh2khq.fsf@gitster-ct.c.googlers.com>
 <e5e50510-8297-6e1b-d446-d717b021c6f0@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 14 Jun 2018 13:42:48 -0700
Message-ID: <CABPp-BHRK5eNRY-WC9gbzPvw0tZcN2GYgSnLv2UJNUBqsRR6Gw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 2/2] rebase--interactive: rewrite the edit-todo
 functionality in C
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Thu, Jun 14, 2018 at 1:24 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
> Le 14/06/2018 =C3=A0 22:14, Junio C Hamano a =C3=A9crit :
>> Alban Gruin <alban.gruin@gmail.com> writes:
>>
>>> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
>>> index ded5e291d..d2990b210 100644
>>> --- a/builtin/rebase--helper.c
>>> +++ b/builtin/rebase--helper.c
>>> @@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usa=
ge[] =3D {
>>>  int cmd_rebase__helper(int argc, const char **argv, const char *prefix=
)
>>>  {
>>>      struct replay_opts opts =3D REPLAY_OPTS_INIT;
>>> -    unsigned flags =3D 0, keep_empty =3D 0, rebase_merges =3D 0, write=
_edit_todo =3D 0;
>>> +    unsigned flags =3D 0, keep_empty =3D 0, rebase_merges =3D 0;
>>
>> Sorry, but where does "write_edit_todo =3D 0" in the preimage come from?
>>
>
> It comes from my conversion of append_todo_help()[0], on which this
> series is based.
>
> [0]
> https://public-inbox.org/git/20180607103012.22981-1-alban.gruin@gmail.com=
/

Given that both Junio and I had the same basic question, you'll
probably want to put dependency information into your cover letters.
If a series applies on master, then this isn't needed.  But if it
requires other changes that are in a topic in next or pu, you can name
the topic that it depends upon (e.g. ag/rebase-p, as from the "What's
cooking" emails or you can grab them as branchnames from
git://github.com/gitster/git).  If the dependency is something that
Junio hasn't picked up yet, provide a link to the other submission.

Others may have additional suggestions here...
