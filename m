Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A32520958
	for <e@80x24.org>; Wed, 29 Mar 2017 22:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932557AbdC2WW2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 18:22:28 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34133 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932377AbdC2WW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 18:22:28 -0400
Received: by mail-ot0-f196.google.com with SMTP id y88so2893216ota.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=N6XhZiRKXG49hK2yoVe0atCm2333lTm1fc2OyESPG4w=;
        b=cMCeUyo1lvrradWLUpsX/GfbJt0SibnC38Vn5VYvn6CIou3Uf65A19aeHP9eUgdhPm
         6brbSq0zEk6bcGv9Xoec2TTUt+8fbPsnAAXLHCbcHeSQfetbTbzMnwOUbJv3WNVCXgHO
         yjHBnAYIjIuNnK7yTUR5D1GvYxMQ6NlCDQ9SQaosf6ygxdniyW0Qz8b6KBAhXO5lw82v
         CMRZ1AiCPVr7FxTAr/Cd8axpphW4AmvR+TAqKlJcL9cvSJBjUjFni1qCPr3kHXerxL7T
         6fw8tAPio+xeT9tDtR8TUxcDeRX14pCE+s2rTvucAN9WuHVdkqB6syAiu2y6kowziMZW
         +x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=N6XhZiRKXG49hK2yoVe0atCm2333lTm1fc2OyESPG4w=;
        b=ZKqLjogVOPNZMhhsb+Y7QvEMWbiDGCAtOmQXZjpqkxilZyHwOuUXshE/iKbD4dUXVg
         2OnPEusgKfHp8G/7OkhZhsi1Zm9AXTfmqkyzRf2aMBMzzG1Zo6zGXmO0yD+LEt0+iEVk
         BttMM1lhCrnL5HAmE3vAopoPcN5H7iRZtBRQeqmU6r7j4GKbqZdZUD06G/7kraf+EaVl
         A15PiViyEwDF1Ol2CsRAIvvYQpPYSyVpiUelZJ1yHlpwyukpkxkQW3hycj9AJo3wrgbJ
         Pspcux6Od9UjF+63Q+3EBE1wGt2pq8KuQsKcj2j5SJ8q1uHkpyzkYMddJVmeDCrIP0iY
         Ul/g==
X-Gm-Message-State: AFeK/H0O/POIm1xu+cix0yLe4VKH1/SLm03TDluFjHriX0xu+5JroF2lpprNhRmeQdOh+3kFIPqnhRnamqsXjQ==
X-Received: by 10.157.8.129 with SMTP id 1mr1560663otf.123.1490826146779; Wed,
 29 Mar 2017 15:22:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.31.131 with HTTP; Wed, 29 Mar 2017 15:22:26 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <CACBZZX70oXn7McjavzvK5S30EXjXQhLixhb=WYbKCKYXVo1KBA@mail.gmail.com>
References: <39b203e9-c3a9-80c3-ec24-649e04ef5620@atlas-elektronik.com>
 <20170329135703.18860-1-avarab@gmail.com> <20170329181228.n4t77pashdnirl3a@sigill.intra.peff.net>
 <CACBZZX70oXn7McjavzvK5S30EXjXQhLixhb=WYbKCKYXVo1KBA@mail.gmail.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 29 Mar 2017 18:22:26 -0400
Message-ID: <CAH8yC8mkndAWP46M2L7TX8HF_y4xa5X29-Q--bA6Prurpya48Q@mail.gmail.com>
Subject: Re: [PATCH v3] perl: regenerate perl.mak if perl -V changes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        stefan.naewe@atlas-elektronik.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Now the logic added in commit ee9be06770 ("perl: detect new files in
>>> MakeMaker builds", 2012-07-27) is extended to regenerate
>>> perl/perl.mak if there's any change to "perl -V".
>>
>> Nice. This fix is way simpler than I feared.
>>
>>> This will in some cases redundantly trigger perl/perl.mak to be
>>> re-made, e.g. if @INC is modified in ways the build process doesn't
>>> care about through sitecustomize.pl, but the common case is that we
>>> just do the right thing and re-generate perl/perl.mak when needed.
>>
>> I think that's fine. There's a related bug that the generation of
>> perl/perl.mak via recursive-make is sometimes racy. So that _might_
>> trigger more often as a result of this, but I think the solution is to
>> fix that race, not try to pretend it won't happen. :)
>
> We'll also redundantly trigger if you upgrade to a minor new perl
> version, but I think that's squarely in "who cares" territory. This'll
> only impact people working on git, and *occasionally* they might get a
> 100 ms hit when running make, as opposed to a cryptic error where
> they'll likely stare at it for a bit before running "make clean".

+1, I don't mind extra config or build times as long as things "just
work" for the common case.

I was trying to figure out the use case that I was seeing. I was
envisioning someone with Perl 4 in /usr/local who complained it would
break some one-off setup. In the common case, the guy running Perl 4
should do the extra work, not the majority of users operating under
the common case.

Jeff
