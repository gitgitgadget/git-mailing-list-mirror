Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C961F404
	for <e@80x24.org>; Fri, 20 Apr 2018 18:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbeDTS2b (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 14:28:31 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:37025 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753627AbeDTS2a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 14:28:30 -0400
Received: by mail-wr0-f174.google.com with SMTP id f14-v6so25294381wre.4
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=1Oz041v4OTnJ1jV66IJULCxLDwfSLgMTX9OqVJddYO4=;
        b=Qu8KEg8vgbjyPnxL65Lj8lMjZklL8BE9C9HV84xNyH4/9jUzu074VbCNZn/oPotrOi
         Tv+pW3KK5+9IHlfv9afg6QjIQqlbj0KyJ8Fo7tf2E4WdIw1jSM6RcNo02AbblOtWaWEg
         sH3KDQX7qRSHTqBDfNPKpjiPrxG6gVg1RbAC/6UrAHF1O3mRGM7iriwI82KKtj4jJFoD
         V1V9AM+VLY4DZsS/0o7DFmdiLXqGwW59Am+K7m/bg/SL5Kr6zM1gz7B8TjQ0WF1hj20O
         DXn8aaOsjEGF4Oosk+RQVGlO4eH8qJk3GwOsx4umVxrFrkCK8JU5EWmCbgWAzlLnH+1g
         9Hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=1Oz041v4OTnJ1jV66IJULCxLDwfSLgMTX9OqVJddYO4=;
        b=A+xrsLu7KvseOR8MkRBJW9Nq7Pj1iQkgsn65g75rtmH6ou+PuBl92DLxb7Em0nACHP
         Qxg70X1y8TlzqJqvQEhlmtF5JPk7PWOjm0f9oEhvdhx7rTW0JS79X26j6gIPjXQF+4UF
         lDfCLSgJdWTbV8lrwpDm7RLzwMi6DoA98wJyebWIxsM2jxrpZoht37e6/jxNQaFPr0t8
         nUZDEldp5F8ZjeK7xIFr2D975epM52xHVs3YgCFx2r00Xz/TKK2GGr38s+FEtJfbPRM6
         v2JMyoWBaJWqGC/NaT9/2Ah7WdPmJHrwNO2xoCSAme6yWxO2PP9rIF3dcI4Of/Y7b9Tz
         5YEA==
X-Gm-Message-State: ALQs6tBBQd4JQQEtRImI7dLhuDLVM4es6TtBNlHU3TcICP4SZDOBoD2v
        N7aYP1lxDxaow3f7+d9YBRc=
X-Google-Smtp-Source: AIpwx4/Sec3iaFUvDMhLA6ikfbsJe17XD1ZiBmBKAYFueN6DCRg/hNKhNbPuBGAdPSm+/rrq8mn9Fg==
X-Received: by 10.28.11.207 with SMTP id 198mr2753331wml.70.1524248909602;
        Fri, 20 Apr 2018 11:28:29 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id k126sm3989643wmg.6.2018.04.20.11.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 11:28:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1] perf/aggregate: tighten option parsing
References: <20180420121041.32558-1-chriscool@tuxfamily.org> <CAPig+cSDYVGpaV-beNVG57r3YfQ=Ey5zuyHRkk_tf86NNRdY6w@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPig+cSDYVGpaV-beNVG57r3YfQ=Ey5zuyHRkk_tf86NNRdY6w@mail.gmail.com>
Date:   Fri, 20 Apr 2018 20:27:24 +0200
Message-ID: <87h8o5ensj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 20 2018, Eric Sunshine wrote:

> On Fri, Apr 20, 2018 at 8:10 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> When passing an option '--foo' that it does not recognize, the
>> aggregate.perl script should die with an helpful error message
>> like:
>>
>>   unknown option '--foo' at ./aggregate.perl line 80.
>>
>> rather than:
>>
>>   fatal: Needed a single revision
>>   rev-parse --verify --foo: command returned error: 128
>>
>> While at it let's also prevent something like
>> 'foo--sort-by=regression' to be handled as if
>> '--sort-by=regression' had been used.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
>> @@ -46,7 +46,7 @@ while (scalar @ARGV) {
>> -       if ($arg =~ /--sort-by(?:=(.*))?/) {
>> +       if ($arg =~ /^--sort-by(?:=(.*))?$/) {
>
> Makes sense.
>
>> @@ -76,6 +76,9 @@ while (scalar @ARGV) {
>> +       if ($arg =~ /^--.+$/) {
>> +               die "unknown option '$arg'";
>> +       }
>
> Nit: In this expression, the trailing +$ makes the match no tighter
> than the simpler /^--./, so the latter would be good enough.
>
> Not necessarily worth a re-roll.

Not that it matters in this case, but just as a bit of Perl rx pedantry,
yes his is tighter & more correct. You didn't consider how "." interacts
with newlines:

    $ perl -wE 'my @rx = (qr/^--./, qr/^--.+$/, qr/^--./m, qr/^--.+$/m, qr/^--./s, qr/^--.+$/s); for (@rx) { my $s = "--foo\n--bar"; say $_, "\t", ($s =~ $_ ? 1 : 0) }'
    (?^u:^--.)      1
    (?^u:^--.+$)    0
    (?^um:^--.)     1
    (?^um:^--.+$)   1
    (?^us:^--.)     1
    (?^us:^--.+$)   1

I don't think it matters here, not like someone will pass \n in options
to aggregate.perl...
