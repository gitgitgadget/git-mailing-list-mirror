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
	by dcvr.yhbt.net (Postfix) with ESMTP id E00211F405
	for <e@80x24.org>; Wed, 19 Dec 2018 13:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbeLSNxb (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 08:53:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39145 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbeLSNxb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 08:53:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so6521456wmd.4
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 05:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=UAt9NLgefsX3wkssh3f6BJ7J1p5OxXc32Me8dGM/20g=;
        b=oXuqaIPuC0xKCoCVlOvsZlB43xwx2SDraFRwqRu5GtHQB2xcj0v14z4R8UVk4KiV03
         kw4THHoTxFPE17wjDnXqXeRoj6p2KFOdcZl+bLecqgkbr+LJWP3D7VhOT/H+5Bx04b0d
         Mvbnl1mYSX4iVcifyLT+t64YDu6e5hAwEYj8U5nUNC3Aaaaeik7LeT6STQdmQksm/OmJ
         9e2/Qm/p2J4acX7eIhYmLzvE/50t02/V02R78JYGPGk15+QkMG6k2OEEY7HNcTH6wbV3
         12KLb7OH9SjOvBY3cnOT2DmZ4OCc453P7Aeo/P8CfGY63Kqpyfjta3lHc35mCI+USe2E
         HuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=UAt9NLgefsX3wkssh3f6BJ7J1p5OxXc32Me8dGM/20g=;
        b=L6rq8XT84KwMeAHFGs6pkb1F1RWurVmzt68hi9Zqz+0xb9YSzr2Y7KZ31ec/HNGWFG
         32KAXTK2pX3JgRQKZYpqL+/aTvJIYX+aQGRJeTlUEOlc55YMwCSAv1HENwbgNGaOoZ9t
         6rhaD2kbWL6LmhGgfeld+J+vKHkjUd0E1tpoQU4/MrH1JrB5z9O4fi56rx9XKO5O/Ai7
         8fQV1HouZy/3LF45Itpi0aoCplUcoLBNv2KW0ryDDJd5UlWtOOSzGadhXx2am1rdbdCm
         ++EguEvcxwUkL0HH5UVmOf4p/s3fUzweXU0sq79hHaAK8rSTac39KO9KiV0uujxVTbyp
         UjtA==
X-Gm-Message-State: AA+aEWbbP32i4bs4SgUNtp2o1oXTe+eSQS/+UQDKA3kF3vswFuAg7oU1
        Jx6Qwx2MnCvaNcdWiDXvQoc=
X-Google-Smtp-Source: AFSGD/X6fuJh0iqFXYbLbtgm5zz+RfD9a+vhQd21755VycRjbChQiNNJRB3rsgWLXNImcSkSZEdqbg==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr7021210wmh.12.1545227609551;
        Wed, 19 Dec 2018 05:53:29 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id n5sm8396574wrr.94.2018.12.19.05.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:53:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org
Subject: Re: Can git choose perl at runtime?
References: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com> <CAPUEspgw2xYxNQN-0_nqQrWE4jhmMN-9aHgJ8NvLDcEKTrZNAw@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPUEspgw2xYxNQN-0_nqQrWE4jhmMN-9aHgJ8NvLDcEKTrZNAw@mail.gmail.com>
Date:   Wed, 19 Dec 2018 14:53:36 +0100
Message-ID: <878t0lfwrj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 19 2018, Carlo Arenas wrote:

> On Tue, Dec 18, 2018 at 7:29 PM John Passaro <john.a.passaro@gmail.com> wrote:
>>
>> I recently submitted my first patch using OSX and found the experience
>> frustrating, for reasons that have come up on the list before,
>> concerning git-send-email and perl dependencies that you need to be
>> root to update.
>
> you can install them somewhere else (your homedir, for example) and
> then instruct perl to look for them there by setting the PERL5LIB
> environment variable

Note that this is different. Cases I can think of:

 1. You have an entirely different perl + modules somewhere. E.g. maybe
    on OSX /usr/bin/perl v.s. some homebrew version of perl+CPAN. My WIP
    https://public-inbox.org/git/87a7l1fx8x.fsf@evledraar.gmail.com/
    addresses this.

 2. You're happy with /usr/bin/perl (or whatever git is compiled with),
    but miss some module(s). That's your suggestion here, but note that
    in this case you usually need a compiler (E-Mail SSL libs etc.),
    which may not be what the user wants.

    I.e. they can install a new perl+modules from their package manager
    easily, but can't as easily build their own modules for a system
    perl.

 3. Using a /usr/bin/perl + e.g. homebrew CPAN libs via a "modules over
    here" facility similar to #2 is likely to segfault (different ABI
    versions).

I think we're good if we just have #1 and if people have the #2 use-case
an additional core.perlLibs config of stuff to prepend to @INC (or maybe
entirly override, least we run into the segfault case in #3).

For that last bit see also 7a7bfc7adc ("perl: treat PERLLIB_EXTRA as an
extra path again", 2018-01-02). I.e. there's the use case of "@INC
instead of" and "@INC extra".

But probably you're happy with just #1 for now....
