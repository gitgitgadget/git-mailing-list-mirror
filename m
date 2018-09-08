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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0741F428
	for <e@80x24.org>; Sat,  8 Sep 2018 20:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIIAt4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 20:49:56 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:44322 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeIIAt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 20:49:56 -0400
Received: by mail-ed1-f47.google.com with SMTP id s10-v6so13755161edb.11
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=K/KrLHBiNLpPmFfJHyUAm/4RW//Xx0xuUS1KiMZWdPw=;
        b=kaemI3mr8QMiBnIRNXyf3EQ/jdym43RLkk4H+AI/2qGNWYz/NylOuIlKyehXHUY8B3
         BBtXXnAednyrEiqRwXK+ZZMfyaHmSyxht+QH+IgNV284+k9bpmO1NVfWzZCIfHJULIET
         gohowIUy+lROFKGpew5cSRpWx1B9ggJ3/2DWOTUOSMUrPCKl+ZvzTHqSBWuCW5Q/2b3e
         ZPbLJv76Tz6UeR8lP+Z9GM+5EnU3LBMmwNhdLWdVzaiRQPwiAvutwpO/pKphOXqaCkjN
         YoShRpHPDXPLzYH4Jmhhd7hVxxqw+h+uyGTuOkVUpi9A7mJHTxb89vk+LVRUbjl7igqk
         OUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=K/KrLHBiNLpPmFfJHyUAm/4RW//Xx0xuUS1KiMZWdPw=;
        b=XIeQSZINvV/jG5ySUMNSWyZlCOiC7omWPUrGnQCsH6UeRrD9BQyIEMmaRw28Cxn9ol
         UQWaHiFTRV4C/StVI02qa7JKoZ+Hgdfh36de52Vz6JImdwWAaOByz4HgdE3CmEF4yjFg
         zGWpfe5WUyO1UH4j3KA6ex7vc12HvuU/ZWddgMRepFoLJFNGM38bNq3bpGn9AHxSLYLb
         W9e0d2uk1024o2NOr6n9F3oLYTldBZ7ZHNSGTwFi3FstD7BR0BkgYVZlHHIuhmfzXdkq
         9JKbF4UFEbwke+SXjkvS9msRARsLwpnarxTosB0ujzRGs8rLkevsGq4TbnjePGRZjCDy
         KYIg==
X-Gm-Message-State: APzg51DCn4Z0C5J1ntG+2p3aMTWMni2sgYgkPXjsAYN9prAXNMPrQY9Z
        A7ZyoyZULAD5ThBHtLbJPTs=
X-Google-Smtp-Source: ANB0VdZ8RnTApIvlBAS5ypUUWBm8JCQmsbnSITUS0/++3DyYCrwnUK4Nn0gBeX5hhLyPfTicvVCnGw==
X-Received: by 2002:a50:8c98:: with SMTP id q24-v6mr15726724edq.2.1536436981468;
        Sat, 08 Sep 2018 13:03:01 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id j10-v6sm6415771ede.5.2018.09.08.13.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 13:03:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stas Bekman <stas@stason.org>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: git silently ignores include directive with single quotes
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org> <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com> <a76c94c6-9fd7-4ed0-be2d-6fc1d021f476@stason.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <a76c94c6-9fd7-4ed0-be2d-6fc1d021f476@stason.org>
Date:   Sat, 08 Sep 2018 22:02:59 +0200
Message-ID: <87a7orrc3w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 08 2018, Stas Bekman wrote:

> On 2018-09-08 12:30 PM, Martin Ågren wrote:
>> Hi Stas
>>
>> On Sat, 8 Sep 2018 at 21:00, Stas Bekman <stas@stason.org> wrote:
>>> [include]
>>>         path = '../.gitconfig'
>
>> Actually, there is a test explicitly testing that 'missing include files
>> are ignored'. I couldn't find a motivation for this in 9b25a0b52e
>> (config: add include directive, 2012-02-06).
>
> And also to stress out, that the file is not missing.  At least in the
> world of unix, in particular its many shells, - command line arguments
> "xyz", 'xyz', xyz are often deemed to be the same if there are no spaces
> in the word. So that's why it took us a lot of trial and error to even
> consider the quotes in '../.gitconfig' as a problem. While git deems it
> different, to me:
>
>         path = '../.gitconfig'
>         path = "../.gitconfig"
>         path = ../.gitconfig
>
> appear to be the "same". So git needs to have a way to say otherwise.
>
> I realize I am going back to the issue of quoting here, after suggesting
> to ignore it. So to clarify I'm bringing it up only in the context of
> wanting git to tell the user what it wants, and not necessarily asking
> to support all the possible ways one could quote a filepath.

Aside from other issues here, in the "wold of unix" (not that we only
use the git config syntax on those sort of systems) you can't assume
that just because some quoting construct works in the shell, that it
works the same way in some random config format. If you look in your
/etc/ you'll find plenty of config formats where you can't use single,
double and no quotes interchangeably, so I don't see what hte confusion
is with that particular aspect of this.

Although as I mentioned in <87bm97rcih.fsf@evledraar.gmail.com> the fact
that we ignore missing includes definitely needs to be documented, but
that our quoting constructs in our config format behave like they do in
POSIX shells I see as a non-issue.
