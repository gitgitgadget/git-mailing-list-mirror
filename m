Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB731F51C
	for <e@80x24.org>; Wed, 23 May 2018 05:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeEWF2C (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 01:28:02 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33512 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753974AbeEWF16 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 01:27:58 -0400
Received: by mail-it0-f67.google.com with SMTP id e185-v6so13372366ita.0
        for <git@vger.kernel.org>; Tue, 22 May 2018 22:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+0HuVuWSdq7vxIt/WGvUHPMvIb3OgIbJlQy1BtgAfaU=;
        b=usYLXVm9HUtanz5qnFhMiM3olIStmDpGbGEW1mV7j8BotjOOX090qyS8/62GCTEPU3
         JGzy7D8uU9vhRWFK8fiwNa8FpZk8M8D2VHoD6sq62IkYHKlT07TLlMbR3wJLc9Rvt9QY
         uCUyhuhGAomjwCwNN3zP1aDgmA72O/ILQxBTvT6tQBvBaXBYQf3dHUJ79sAb1ZD2ae6r
         8xGRscLwbsaNZyeCGK8IarHdemxGn62ZlWKDpXdQdGpMX8gD7cYdNYG+ujc6FQkyumNN
         bxyjiyTn8Sn6B6bwN5uCOg8lHh2jhXKcNlE/RvfWm61nwcOgyOlOqKyx/k2M27pf/zGp
         d+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+0HuVuWSdq7vxIt/WGvUHPMvIb3OgIbJlQy1BtgAfaU=;
        b=Oo3oT8gbuMx3f/Bim8nCI8fsT6mXsJjYThqF3a9MpGeT/GJbBPuHF70l88cn26NKxG
         bfJ7TDuj/ibLm61lqu/4smnsq29E5D8b/cnMwLPjSf90hpcsXOcHsgIeTkMR59Cxg0bh
         adZIS5nYPzI3Aj/P+tgIMj+U96zKFHo5WNWBsJOKzs3P1QO9NJTUBhCLJL9XaKP7vIgV
         ur0eoAaZK5BEbBcISLP8vVyYnAk3VAE7SKQavZ4KWLnkjZZJLSa6vrOOHYhDDsef/0Qx
         dJUZLZ3Cbpf9w480o3c0GSAsrbhhnLd+a997oVylUfGyBN+70mvrg8Vrpx+Eslp3VNFW
         U3Aw==
X-Gm-Message-State: ALKqPwffMHox+DjKaXgSloft04zHagxHqQY6/QZyWg1H62eaQRih9f1Z
        bKgyIgwxjn/0112wEPVq5uRXE4vqE9cHR3lpj9g=
X-Google-Smtp-Source: AB8JxZowrsUmI4uG6ZANU5v0VcVi3Dnk3h80of3J4LmRsB+P6AwsWhY0nXXSYfq9242dyEy6qAkwScWIQvBkqcn2OJw=
X-Received: by 2002:a24:3d8c:: with SMTP id n134-v6mr1007315itn.40.1527053277398;
 Tue, 22 May 2018 22:27:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Tue, 22 May 2018 22:27:56
 -0700 (PDT)
In-Reply-To: <20180521114940.11288-1-szeder.dev@gmail.com>
References: <20180521055143.14701-1-chriscool@tuxfamily.org>
 <nycvar.QRO.7.76.6.1805211126140.77@tvgsbejvaqbjf.bet> <20180521114940.11288-1-szeder.dev@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 23 May 2018 07:27:56 +0200
Message-ID: <CAP8UFD1-dWLfK4EQMKrabneG+GcscBVZANpfZaOymQ4sWKzRnA@mail.gmail.com>
Subject: Re: [PATCH] t: make many tests depend less on the refs being files
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 1:49 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>> > diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
>> > index 8f5c811dd7..c3b89ae783 100755
>> > --- a/t/t9903-bash-prompt.sh
>> > +++ b/t/t9903-bash-prompt.sh
>> > @@ -148,7 +148,7 @@ test_expect_success 'prompt - inside .git director=
y' '
>> >  test_expect_success 'prompt - deep inside .git directory' '
>> >     printf " (GIT_DIR!)" >expected &&
>> >     (
>> > -           cd .git/refs/heads &&
>> > +           cd .git/objects &&
>> >             __git_ps1 >"$actual"
>> >     ) &&
>> >     test_cmp expected "$actual"
>>
>> This one looks wrong.
>
> It's right, though.
>
>> Why not `cd .git` instead?
>
> That case is covered in the previous test.
>
> Once upon a time it mattered how deep we were in the .git directory
> when running __git_ps1(), because it executed different branches of a
> long-ish if-elif chain.  For the prompt it doesn't matter anymore,
> because those ifs were eliminated, but for the completion script it
> still does, which brings us to:

Thanks for the explanations!

> Christian!  There is a similar test, '__git_find_repo_path - parent is
> a .git directory' in 't9902-completion.sh', which, too, performs a 'cd
> .git/refs/heads'.

Ok, I will take care of both of these tests in another patch.
