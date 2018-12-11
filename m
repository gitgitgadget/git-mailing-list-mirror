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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4361820A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 12:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeLKMk2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 07:40:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34439 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKMk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 07:40:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so8922791wmd.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 04:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=GToDJi1tFpIOQK3LqFMm97lSZhlKNGigWS6k3G0dU28=;
        b=HnDePrcCG3qW9c28ZObR48KrE1OikrhwvLsCUwvdyHuWSA9KaoREp3f9xTmPvZpvd0
         DXI+zIFEMp5ztw5uC9BSur0plyOf6RtQNNherVD7N9GKjBEFio2S5UpjX2kmXjNV2vP1
         ZsYr1ciYthi0H2HyEBeklXR2H8G6dCHgb9vSTeyGUeYYjO1fod7YkmQEo/0wrBE13zuS
         pV+H5KRiVQeI96Jf3Zn3e5VdkfSc1kZTeTJgAAGjQJxoJM4ljx3+hDLTp0P71dkeDA2Q
         2xIkdOHCnEdOvx3pnKBHdDAhKm+rM/+sX8gFPPIgFvwoS0EMC5SKu75qHERnIGJ1KEFP
         +/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=GToDJi1tFpIOQK3LqFMm97lSZhlKNGigWS6k3G0dU28=;
        b=PjBSvVpZL8TFl3aQY6lr1cGlRBqRxWkl+UznbGPzz+uoBxVWp5314NZKMHMJlYJLCg
         9GgAXoy1plA3018VXk79Yjaa1kR2ymqGJcu6nZDCUEMibUoB6hulH6d+Vtes4aIhztwM
         bARO+xRf21oFtt+uOS7sK1jmzpDnozyrIfZGT+grjsj/rGmHFwg54SWICxA0VTkD3uWA
         ImNtqX4C9NVdS8XJ2dFkafThvkf2M3v/rKfPQfwvmK7TNlYU6cC/I8VoVlGxSLyxs01W
         sdc6vxKNxgkD5r4O4ccMj+x0GBODMtuKwEKd6vxP8K8bKHKWsIgLIoz+EQ1ktvasbKn8
         tPWQ==
X-Gm-Message-State: AA+aEWb44fANkh07rCxzaVpvkTAkOGz1FQ0PMaw86yjRzcBO2omN8ame
        jLLG6EdtQqATyDGVIkZldnB+LzQH
X-Google-Smtp-Source: AFSGD/Uep9FwtuRP3ZNHFpA0XG4zzJz8cOf4GLDlfDWM841dSOgyBOoe686vZGp45SkUMyt5UoHqHA==
X-Received: by 2002:a1c:2104:: with SMTP id h4-v6mr2007272wmh.130.1544532026093;
        Tue, 11 Dec 2018 04:40:26 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id t63sm1233211wmt.8.2018.12.11.04.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 04:40:25 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        paul.morelle@gmail.com, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com> <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet> <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com> <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet> <20181201200209.GC29120@sigill.intra.peff.net> <CAPig+cT6yo+wBHhkaAFK1REisOdtZsJNWEhoShcspzQsFeiWxQ@mail.gmail.com> <20181202033110.GA30004@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181202033110.GA30004@sigill.intra.peff.net>
Date:   Tue, 11 Dec 2018 13:40:25 +0100
Message-ID: <8736r4nsna.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 02 2018, Jeff King wrote:

> On Sat, Dec 01, 2018 at 09:28:47PM -0500, Eric Sunshine wrote:
>
>> On Sat, Dec 1, 2018 at 3:02 PM Jeff King <peff@peff.net> wrote:
>> > On Thu, Nov 29, 2018 at 09:32:48AM +0100, Johannes Schindelin wrote:
>> > > In reality, I think that it would even make sense to change the default to
>> > > reschedule failed `exec` commands. Which is why I suggested to also add a
>> > > config option.
>> >
>> > I sometimes add "x false" to the top of the todo list to stop and create
>> > new commits before the first one. That would be awkward if I could never
>> > get past that line. However, I think elsewhere a "pause" line has been
>> > discussed, which would serve the same purpose.
>>
>> Are you thinking of the "break" command (not "pause") which Dscho
>> already added[1]?
>>
>> [1]: 71f82465b1 (rebase -i: introduce the 'break' command, 2018-10-12)
>
> Yes, thanks (as you can see, I haven't actually used it yet ;) ).

Related: I got poked about a bug where someone was doing "exec bash" to
do the same, and would then CD to other repos, and git operations would
still be executed on the original repo because we set GIT_DIR=* in the
envioronment (but not for "break").

Not a big deal, but I wondered if that was a bug in itself, i.e. if we
need to set GIT_DIR et al in the environment for "exec". Isn't having
the current directory set to the checkout sufficient?
