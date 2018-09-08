Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594E51F404
	for <e@80x24.org>; Sat,  8 Sep 2018 20:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeIIBP2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 21:15:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38132 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeIIBP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 21:15:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id h33-v6so13794792edb.5
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vi+C+dRdGCnCrIFVVROjSIMQygtfb++kAPRQDY8N+Oc=;
        b=bcOfE2N3VUWNn4x84tEVj+CpfRiYqS4tnDyBQU3iZIeBlySTkx/yuyluFntEdHTaj1
         /JxzAze1wVyjTi7Lh0jA4pQ/g5GcVT06fzokCfKSW9up5ysbR/bmKWABXmeBPLlFvKdn
         AqLFjOAjnrg4Yng58YaKejXexuvtKF1FKiDuoFSc4HjcYDTnSJ5coPdkufhVJVWkfmMV
         9RM2O7xTg7p1vz7FTkRBCH+7BD7nowAn0LLtLRR0kdMxsGJkmuYHWMkzQkxNE/pZKeLf
         a7kvNnHR8FV1h8I1UIBXSiHOB6bRi02wKG+LP87WK+azRAS4rthzcOt/er+l/bNfQj1H
         zf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vi+C+dRdGCnCrIFVVROjSIMQygtfb++kAPRQDY8N+Oc=;
        b=Lq8Gf4TjDYI4Qa1L2Jxdp2PxiEmyn1S2pAcCbH+2lT5KeQJHCl/h7IfsLBsZ1hOEXS
         jDS64lG5sm3jSKSS7CSOoJHs1+XU2Fdbh+LAKmGzD/1s9Q2O4SUOqdcpq8dsfx7pqaKH
         NeC9STIrnp5mLdtY6NNAxmfb0OAvZP62MoTsOEZmhMKWq91RmSiShfHCCnU5bWgVQb3M
         UidaCEFM7eIyQnN6q8iYmtrWxWc2WZcu7uqo/GBo/X01amm9BYtH1ZZ13/XhkxqPahMw
         SZfV3PYBjt2om6ChMzbzVoTmaAdKYV2mAaslv2jSmryaWSb+D6IrlrxKGEdricK298NL
         lytQ==
X-Gm-Message-State: APzg51AwssocViLQQ/m/0MWydtpe8dVMAfbpJBhlgH5oDgKsgYWa5+aQ
        AiB8AuvRSwqy8WPV1d+D6Fo=
X-Google-Smtp-Source: ANB0VdZDX1M6lV1C/rXkHPAN/MBXjj7yzpxKglljAW+yBofJPU+gEEUoBBccmInacZPoe+f50LJE7w==
X-Received: by 2002:a50:9732:: with SMTP id c47-v6mr14854839edb.89.1536438508463;
        Sat, 08 Sep 2018 13:28:28 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id k33-v6sm6263154edb.31.2018.09.08.13.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 13:28:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stas Bekman <stas@stason.org>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git silently ignores include directive with single quotes
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org> <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com> <a76c94c6-9fd7-4ed0-be2d-6fc1d021f476@stason.org> <87a7orrc3w.fsf@evledraar.gmail.com> <acf93aef-f1f8-1aab-a16d-9655402d445f@stason.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <acf93aef-f1f8-1aab-a16d-9655402d445f@stason.org>
Date:   Sat, 08 Sep 2018 22:28:26 +0200
Message-ID: <877ejvraxh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 08 2018, Stas Bekman wrote:

> On 2018-09-08 01:02 PM, Ævar Arnfjörð Bjarmason wrote:
>
>> Aside from other issues here, in the "wold of unix" (not that we only
>> use the git config syntax on those sort of systems) you can't assume
>> that just because some quoting construct works in the shell, that it
>> works the same way in some random config format. If you look in your
>> /etc/ you'll find plenty of config formats where you can't use single,
>> double and no quotes interchangeably, so I don't see what hte confusion
>> is with that particular aspect of this.
>>
>> Although as I mentioned in <87bm97rcih.fsf@evledraar.gmail.com> the fact
>> that we ignore missing includes definitely needs to be documented, but
>> that our quoting constructs in our config format behave like they do in
>> POSIX shells I see as a non-issue.
>
> I agree that I should make no such assumptions. Thank you. But it is a
> cross-platform problem. I remind that the original problem came from a
> simple command:
>
>  git config --local include.path '../.gitconfig'
>
> Which on linux removed the quotes and all was fine, and on windows the
> same command kept the quotes and the user was tearing his hair out
> trying to understand why the custom config was ignored.
>
> So you can say, don't use the quotes in first place. But what if you have:
>
>  git config --local include.path 'somewhere on the system/.gitconfig'
>
> you have to use single or double quotes inside the shell to keep it as a
> single argument, yet on some windows set ups it'll result in git
> ignoring this configuration directive, as the quotes will end up in git
> config file.
>
> I'd say at the very least 'git config' could have an option
> --verify-path or something similar and for it to validate that the path
> is there exactly as it adds it to .git/config at the time of running
> this command to help the user debug the situation. Of course this won't
> help if .git/config is modified manually. But it's a step towards
> supporting users.
>
> I hope this clarifies the situation.

Yeah, some version of this is sensible. There's at least a doc patch in
here somewhere, if not some "warn if missing" mode.

So don't take any of this as minimizing that aspect of your bug report.

*But*

There's just no way that "git" the tool can somehow in a sane way rescue
you from knowing the quoting rules of the shell on your system, which
differ wildly between the likes of Windows and Linux.

We guarantee that if you pass us the string "foo" it'll work the same
(for the purposes of config syntax, and most other things on all
systems).

We can't guarantee that just because on one system/shell "foo" means the
same as 'foo' when you type it into the terminal, but others it doesn't
that we'll treat it the same way, it's ultimately up to you to know the
quoting rules of your system shell.

On linux/bash I can also do "git config foo.bar <(some-command)", and
there's some systems where that'll be passed in as though (on
linux/bash) we'd passed in:

    git config foo.bar "<(some-command)"

What are we supposed to do with that? In particular in the case where
"foo.bar" is supposed to point to a valid filename, and
"<(some-command)" *is* a valid filename?
