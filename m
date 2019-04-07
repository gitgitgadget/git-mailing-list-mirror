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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2924020248
	for <e@80x24.org>; Sun,  7 Apr 2019 21:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfDGVAX (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 17:00:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40968 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDGVAW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 17:00:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id u2so5427749eds.8
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XqXHHDNqrhbmkWLD/RfdpMBCglVs38UEciiZhMJ8RTQ=;
        b=fsLrtMlgR+Y4UY3lNEbllV/nvp3/A4s1alNiEGqxYO1z3zXpid/md2rWaUhkoT0k7A
         yDEcD5iEXWGBwELM6fkJJx45gJTwFZk5xjzf4KCaySohICsY+h/Xull06aThOiIoCNb/
         ZpVqDZhFLmlLGD3Hvu9yNUn3eNwN71dK3fBpehT1jYYy/oCvhEe2uIkdTpck7eJlPGOP
         K1k9TJSkaMtNyV8Jmb5WjKHwREcVpmId3FfiJsYYZ5mosy7GIDeoMCTR5k7sL2y3XIwi
         hX3GBZYIw+20LLGEuE1amRG21wASqKXn8RzGDQ4Zh/iwiDNnTZ+56PpnM1gY8UxsSteG
         srBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XqXHHDNqrhbmkWLD/RfdpMBCglVs38UEciiZhMJ8RTQ=;
        b=jIJrXpLct8aQb0rHoZNmbq8v3MaVjuhZc7RDqEpSYPgBxscs0K0wpnRi3QH1MfQsCF
         HpZW8vst4hl1QAiGNokwnnihp4q0+vbSK8vZlNj1S/zQbxXyhqpmCeoGWoG2czQ9Jpbm
         wAVU22FDb8JDtYlMehJA5IJhlHak3wN1YOoKE03vFQua75orN4l+wTh9OL0M3x9ORUOk
         zMA5kNySKKv+q4Mh4hHr8AFBEFdcaEGRNIrBKMJWrzPLh/IA7KNp3yElNijPqLUgeh8t
         TZ1S27xs7T6TGmFqhYrB3omyQNjih07xelVuDKWPARMkrUNpIw1LEkfmpGgGk3ydL2HK
         eTTg==
X-Gm-Message-State: APjAAAWl8DRW95RoxBkG95lJljDOjBzhtK+L6/Cuagm0nZHDAd+Tjw6A
        6dsf2I/3EVUYN1Bby08Vf1w=
X-Google-Smtp-Source: APXvYqzD9etmifOnpdN8VjQ4MkUZAzn90GDz78s8+LmYyqsr3QidsBEc6sSrJb8i6zGKUUwJPavJUw==
X-Received: by 2002:a50:f108:: with SMTP id w8mr2588746edl.89.1554670821074;
        Sun, 07 Apr 2019 14:00:21 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id q1sm2201960eds.2.2019.04.07.14.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 14:00:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
References: <cover.1554435033.git.me@ttaylorr.com> <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com> <20190405105033.GT32732@szeder.dev> <20190405182412.GC2284@sigill.intra.peff.net> <20190405184229.GB8796@szeder.dev> <20190405185241.GG2284@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190405185241.GG2284@sigill.intra.peff.net>
Date:   Sun, 07 Apr 2019 23:00:19 +0200
Message-ID: <87a7h1a5uk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 05 2019, Jeff King wrote:

> On Fri, Apr 05, 2019 at 08:42:29PM +0200, SZEDER G=C3=A1bor wrote:
>
>> > > Don't run git commands upstream of a pipe, because the pipe hides
>> > > their exit code.  This applies to several other tests below as well.
>> >
>> > I disagree with that rule here. We're not testing "cat-file" in any
>> > meaningful way, but just getting some stock output from a known-good
>> > commit.
>>
>> It makes auditing harder and sets bad example.
>
> I disagree that it's a bad example. Just because a reader might not
> realize that it is sometimes OK and sometimes not, does not make it bad
> to do so in the OK case. It means the reader needs to understand the
> rule in order to correctly apply it.

FWIW I thought the rule was something to the effect of "we're hacking on
git, any change might segfault in some unexpected test, let's make sure
that fails right away", hence the blanket rule in t/README against "!
git <cmd>" in favor of "test_must_fail git <cmd>", and "don't feed the
output of a git command to a pipe" documented right after that.

> I am sympathetic to the auditing issue, though.
>
> I dunno. In this case it is not too bad to do:
>
>   git cat-file commit $commit >good-commit &&
>   perl ... <good-commit >broken-commit
>
> but I am not sure I am on board with a blanket rule of "git must never
> be on the left-hand side of a pipe".
>
>> > > Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
>> > > dependency?
>> >
>> > Heh, this was actually the subject of much discussion before the patch=
es
>> > hit the list. If you can write such a one-liner that is both readable
>> > and portable, please share it. I got disgusted with sed and suggested
>> > this perl.
>>
>> Hm, so the trivial s/// with '\n' in the replacement part is not
>> portable, then?  Oh, well.
>
> I don't think it is, but I could be wrong. POSIX does say that "\n"
> matches a newline in the pattern space, but nothing about it on the RHS
> of a substitution. I have a vague feeling of running into problems in
> the past, but I could just be misremembering.
>
> We also tried matching /^tree/ and using "a\" to append a line, but it
> was both hard to read and hit portability issues with bsd sed.
>
> -Peff
