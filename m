Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2A11F89C
	for <e@80x24.org>; Mon, 16 Jan 2017 04:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750888AbdAPELE (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 23:11:04 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34950 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750843AbdAPELD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 23:11:03 -0500
Received: by mail-lf0-f67.google.com with SMTP id v186so11053681lfa.2
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 20:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CT9BTY+ORx7JH0VKiD+Oy144hKQkIAccZJcZBD5tM2c=;
        b=MdzVNLwRP5+mA6ZOpS6xBgZus0smhJYCSo1efu8fDtBiSeFLV0f5xiIKQvKBooVhJj
         P5NxxF+Bd9UqGDhOKwgrfdf4ty0JIwPusyU3cuqTWMqfHQzaK64itoF8OeCEUTYcfDeF
         t9qINQptLP0JYxSo3hfazbNQNa07K1p1pPwQxV80toR8GSskAF5zT6xqDmVZtCpIeED+
         nKSvVwCeYfeSPFDWut5pFxr0EZyuhYpxAEdA2bhFO4m3V4xCotbySzxHuAkUNXos9iv0
         nqmh5XZ3FCuqBDNh9SiYlL7oOtt8VrZu85vJtu1GfRwb1Pb3qhLx6G4+mXY5ikXlBUio
         SpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CT9BTY+ORx7JH0VKiD+Oy144hKQkIAccZJcZBD5tM2c=;
        b=Y26xB7xe/oZgc6c5ahCZT1lI0vA8gccPj68UlH1pj7M/blgSCRx+eL+tQcd+F7z0CJ
         4Fpj8xCk4yrZoJ2Mv9ql3QSJE4QOw7hyDLUfpw7vTw7zZSIX5/DTtp7dStgJwvbJXW0g
         2N6D+QY00QZ6TIbGE10JVqoA20OyUEOXXXP0Mw+iXUYK9si9YAcdtl+07NuqnjJWk+Jt
         ZWWGSIumdks03Xt4E+9MaHlFDqlvEtObHSeqvENGyONTawO/cQStdbqcrtmE01XHp4za
         3lk9P8byPno8RPPQ7lSgLlVG1x3vo5MXc0Ia8UTHGxK6GNwvkYBZSHrxvH9Up+Pw21Fy
         XyFA==
X-Gm-Message-State: AIkVDXJzQNdWCs2PNryPTktN0PKTcOi6iwDpTiWSiNIrG13lXvu6vIYwY7QFu+AHtpumSH9fN22Ad+07tAO9xg==
X-Received: by 10.25.24.152 with SMTP id 24mr11570915lfy.12.1484539861673;
 Sun, 15 Jan 2017 20:11:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Sun, 15 Jan 2017 20:10:41 -0800 (PST)
In-Reply-To: <20170114180550.ebra5qexewetuoyk@sigill.intra.peff.net>
References: <cover.1481642927.git.johannes.schindelin@gmx.de>
 <cover.1483370556.git.johannes.schindelin@gmx.de> <bc1a6c21c9ab2f55882c363e802bfcf37e49d79f.1483370556.git.johannes.schindelin@gmx.de>
 <xmqqk2a0ktxr.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701141856240.3469@virtualbox>
 <20170114180550.ebra5qexewetuoyk@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 15 Jan 2017 20:10:41 -0800
Message-ID: <CA+P7+xrujKPCxCH9NSvhkxsrs1JojwdgsRvvedZhUVXucsG0QQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/38] sequencer: avoid unnecessary curly braces
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2017 at 10:05 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Jan 14, 2017 at 06:57:13PM +0100, Johannes Schindelin wrote:
>
>> On Thu, 12 Jan 2017, Junio C Hamano wrote:
>>
>> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> >
>> > >
>> > > - if (!commit->parents) {
>> > > + if (!commit->parents)
>> > >           parent = NULL;
>> > > - }
>> > >   else if (commit->parents->next) {
>> > >           /* Reverting or cherry-picking a merge commit */
>> > >           int cnt;
>> >
>> > The result becomes
>> >
>> >     if (...)
>> >             single statement;
>> >     else if (...) {
>> >             multiple;
>> >                 statements;
>> >         }
>> >
>> > which is not quite an improvement.
>>
>> Yet, this used to be the coding style of Git, and your statement comes
>> quite as a surprise to me.
>
> Yeah, I thought we were OK with:
>
>   if (cond)
>         single statement;
>   else {
>         multiple;
>         statements;
>   }
>
> but not the other way around:
>
>   if (cond) {
>         multiple;
>         statements;
>   } else
>         single statement;
>
> I don't know if the "else if" changes that or not, but I certainly have
> written things like your patch does.
>
> -Peff

Personally, I am of the faith that if any branch of the
if-then-else-if-then-else blocks needs braces, then all branches
should use braces. However, I think that

if (condition)
  <line>
else {
  <block>
}

is reasonably close to this, as the main part can still clearly see
the if condition pretty well.

Thanks,
Jake
