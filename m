Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475241FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 19:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbdJKTCa (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 15:02:30 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:48568 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbdJKTC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 15:02:29 -0400
Received: by mail-pf0-f182.google.com with SMTP id b79so1677707pfk.5
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=szlqLIr2znwLTJkyDEBT3QUJu6aX2eSkaqqUcW4c9gE=;
        b=Agt4UXADOvkDWXYdqf7qVRKTVFfZZrARDJujjjqJYWXVesY467cIeqdpzLG3iPg+2P
         8uaEXjMeaEZHbylBV9E6C5Tootu7sUDpMhD4I8BlbTKCXVegVW4Ix3lS5vIywqv+xaXy
         eZJ2o9C+w16r2S1ac6FpkI3QH0V1H7YwIyWd4paMxTcU7oYSN6y7jZAG6SjY7Im/9VBn
         w+YtkalR5wGv7QCamrsfN781kyTPMLXfFM5eIIrSYpyhkiRHw9GdYvsXlO8EuWC/Fhuc
         IjfUlTovE6Jo0Fq8iepMJakM/1M3tnNSRUKqCN4n2y9nIqI0HOcghDD1tomzSU3dL7cd
         8bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=szlqLIr2znwLTJkyDEBT3QUJu6aX2eSkaqqUcW4c9gE=;
        b=ESvtTkuls8bOlmujTTx/wQ6BaFAFh1xD5En70EgDWf4smR//ozHCjMapFY34Ijoa1N
         4omCEAL/iKaVncY0DNvZP3JkMowt4E+Rm6FTpTaU97Im0ha8dMh0TokncYFaJrMvkXk6
         p7KZRbeI4Q1o2MOnagxa9b4uWJ50ibcxBNU7aGogDwZine8bpxqRD73xBgPK/uWf2nLa
         5aDd/0vkBYh31+XpN9zEbs6CzDl6v92CkVc+zAhmwId3csfWtKnjMyo8mxs3pbg6S3pF
         8t18GuXkKLztrPcitb1vYxCOoSG/q2qZaw8X6EA4Q5KccZNDMRuaqWCQGFLE03eUz4lI
         pJHQ==
X-Gm-Message-State: AMCzsaVEt/p9IcDKKBOexHPnnjWGduuYO8CEqIzEmPcQ6NvJ0yif9ZNr
        KCYGh7TznUv7w+g8KUfI5en2d8W9200cEJ+2tLc=
X-Google-Smtp-Source: AOwi7QADPUnkBETn2kfYr8CLriNJ0aNJFKYdHoklrg3ztSd2JZaHNDLNEpylTAEppldKU6M4HINMWdMZ1tu1+JogcBc=
X-Received: by 10.98.62.195 with SMTP id y64mr17875pfj.140.1507748548823; Wed,
 11 Oct 2017 12:02:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Wed, 11 Oct 2017 12:02:27 -0700 (PDT)
In-Reply-To: <20171011183640.GC16800@alpha.vpn.ikke.info>
References: <20171009214543.12986-1-me@ikke.info> <20171011172310.2932-1-me@ikke.info>
 <CAN0heSqbD8TJu+_d11gj2eftG3gR+n0j621q_uSnuLQc9t_pbQ@mail.gmail.com> <20171011183640.GC16800@alpha.vpn.ikke.info>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 11 Oct 2017 21:02:27 +0200
Message-ID: <CAN0heSqJuE5RorQSf8yX3TF_giqL-Mt+DJ5-V08eH3=xi+Q9wA@mail.gmail.com>
Subject: Re: [PATCH] column: show auto columns when pager is active
To:     Kevin Daudt <me@ikke.info>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 October 2017 at 20:36, Kevin Daudt <me@ikke.info> wrote:
> On Wed, Oct 11, 2017 at 08:12:35PM +0200, Martin =C3=85gren wrote:
>> On 11 October 2017 at 19:23, Kevin Daudt <me@ikke.info> wrote:
>> I wonder if it's useful to set COLUMNS a bit lower so that this has to
>> split across more than one line (but not six), i.e., to do something
>> non-trivial. I suppose that might lower the chances of some weird
>> breakage slipping through.
>
> Yeah, I was doubting about that, but wouldn't this amount to testing
> whether git column is working properly, instead of just testing whether
> it's being done at all?

Right, I think you'd need a pretty crazy bug in order to slip through
all tests here.

>> These were just the thoughts that occurred to me, not sure if any of
>> them is particularly significant. Thanks for cleaning up after me.
>>
>
> np. Just as I posted earlier, I think you did not actually cause the bug
> (because this has never worked), it just made it visible to more users.

Well, the general bug/behavior was always there, but I regressed a
particular use-case. In 2.14, you could do `git tag` with column.ui=3Dauto
and it would do the columns-thing. But with ff1e72483, the behavior
changed. To add insult to injury, it might be non-obvious that the pager
is running, since with just a few tags, the pager simply exits silently.
So debugging this could probably be quite frustrating.

Martin
