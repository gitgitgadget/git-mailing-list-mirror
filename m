Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139B4202DD
	for <e@80x24.org>; Fri, 14 Jul 2017 06:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750914AbdGNG14 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 02:27:56 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35430 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdGNG1z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 02:27:55 -0400
Received: by mail-qk0-f182.google.com with SMTP id p73so4887464qka.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 23:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V3wwRcEYaUfqORHGxPkup1RoYVz8YW/0LSTUvtxh100=;
        b=Tur0GEsqw+ge/vkLEhFkG+wINkEeuEagj4zYFaM+FbTfqFMzdq11ahTOyqr3uAgeLg
         LTi9q76JtX9Oza/UgbC4irrYjl3PwRHS3P06ZO7lnCquACxCMpyzmWAW/2Nz0mfiY+SZ
         YIAedb9Jlcj/FaP3zlHcchh3kI//AP4NwGldMCdlUtF690SNHuw3PRL8msZDVCSX+4Fv
         ig0Fzx3OkcNgaj64du141N0Jg1eOI8n2YH7W+l0N8RT0q1VJA6tT7V2VhFiNytpvaAjT
         LSK8hAK72SqH7ezWtaM13xzZEvCB7qSpZwrDYv4PPJFIsUzfqvKSpw0ucWmHzmqJIekj
         LEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V3wwRcEYaUfqORHGxPkup1RoYVz8YW/0LSTUvtxh100=;
        b=kHu5IOqe1s3lre/b0i4KyNKC0m3X55bGClYEWCb9eOHy1AkVgNfic4Zs2NwULm2zpc
         J8h4ztAdDd2kZKe3lU6M8dOrQVXbsqhJA4BlfyydeQVEh3BYNSAiQud1T/KpZlMu2OtK
         NfPIGZ2PUFQsadNlw5tvSyxsV8JsNzWw68zIx8GS2fZ3DXfPgKrs9VHuql4K92gvRRKg
         HgfI2VidIRePFybWtTx1D3V9EGFdHMZX8WWFgFkpDtdk+WCFlkU2qMC/WUNnV9dFWrvU
         IivUfXLXPY/bZmC3hNHMaJ2NsoKRkeH9c2qpkiiXz+udiB9EvvOHqs8LFJyEbvGD31Ub
         InNg==
X-Gm-Message-State: AIVw113a4H7p28y0jResFuQ1/o74KKAf1mCGsAepZSeL6MsIIkvhzDBf
        4B/hJjQ5eMsgmAVJbVmUai1mp39upg==
X-Received: by 10.55.152.71 with SMTP id a68mr8789648qke.210.1500013674585;
 Thu, 13 Jul 2017 23:27:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Thu, 13 Jul 2017 23:27:53 -0700 (PDT)
In-Reply-To: <20170713205535.otzi3gjd63ubb2dm@sigill.intra.peff.net>
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
 <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net> <CAP8UFD3VnpMuMpcfRcTwL4nRpOF5URj6zsQqiEWYwo=1pi5Phw@mail.gmail.com>
 <20170713205535.otzi3gjd63ubb2dm@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 14 Jul 2017 08:27:53 +0200
Message-ID: <CAP8UFD1FXPtzHF1J5ZfcsmMiHrfXQOd=qEghJQp3eFYsVd-nxQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Teach 'run' perf script to read config files
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 10:55 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 13, 2017 at 08:57:01PM +0200, Christian Couder wrote:
>
>> >> We want to make it possible to store the parameters to the 'run'
>> >> script in a config file. This will make it easier to store, reuse,
>> >> share and compare parameters.
>> >
>> > Because perf-lib is built on test-lib, it already reads
>> > GIT-BUILD-OPTIONS.
>>
>> Actually the 'run' script also sources GIT-BUILD-OPTIONS, so maybe
>> this is not necessary.
>
> Ah, right. The one that comes via perf-lib gets the variables into the
> test scripts themselves. But anything "run" would need itself would come
> from the source it does itself. And that's where GIT_PERF_MAKE_OPTS has
> an effect.
>
>> Also are the variables in GIT-BUILD-OPTIONS exported already?
>
> No, I don't think so. But because both "run" and the scripts themselves
> source them, they're available more or less everywhere, except for
> sub-processes inside the scripts.

Ok, I see.

>> > And the Makefile copies several perf-related values
>> > into it, including GIT_PERF_MAKE_OPTS and GIT_PERF_REPEAT_COUNT. So you
>> > can already do:
>> >
>> >   echo 'GIT_PERF_REPEAT_COUNT = 10' >>config.mak
>> >   echo 'GIT_PERF_MAKE_OPTS = CFLAGS="-O2" DEVELOPER=1' >>config.mak
>> >   make
>>
>> The "make" here might not even be needed as in the 'run' script
>> "config.mak" is copied into the "build/$rev" directory where "make" is
>> run to build the $rev version.
>
> You need it to bake the config into GIT-BUILD-OPTIONS, which is the only
> thing that gets read by "run" and the perf scripts. If you are
> just setting MAKE_OPTS to things that your config.mak already sets, then
> yes, you can skip that one.

Thanks for the explanations.

The whole thing seems really complex to me though. And this makes me
think that people might want to specify different GIT-BUILD-OPTIONS
and config.mak files to be used when running perf tests, so that the
results from perf tests can easily be reproduced later even if they
have changed their build options in their development Git repo in the
meantime.

So perhaps the config file should make it possible to specify a
directory where all the build files (GIT-BUILD-OPTIONS, config.mak,
config.mak.autogen and config.status) that should be used should be
taken. And then it could also let people change some variables to
override what is in those files which is needed to run perf tests with
different parameters.
