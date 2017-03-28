Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2DD20958
	for <e@80x24.org>; Tue, 28 Mar 2017 06:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbdC1G11 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 02:27:27 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35600 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbdC1G11 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 02:27:27 -0400
Received: by mail-lf0-f47.google.com with SMTP id j90so32471632lfk.2
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 23:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=DU5iW9/lL+KrIuxEbYZB5A4GCRffh61hOYtTWaogeTs=;
        b=S/pk/cficN0+Y5fN/D4fba++g6QsVsqOFuTcKbhHH++r3JcLSvSyFY+1aUFNXKWWy2
         9u7wn6IFb1nQ4kyRuGXp1DDWrQInIHjFOaCdJQc6ajIncbnsZTgv9aHctWOtyCQbuxUs
         Nz53YJTPzALXtZR8lUSSsIED4TXgkNunMXTWMQXyPmDozqTgMiUO2STx9FLufJ7eAZwF
         9QdNbUbYyT5ueXMHaDs5/7LfteZHazguhVvsaSJQAoPAJmF+KAW28grcgRPG2CHRl9Bq
         OI/0XjUOYO7+jwoxD2rqXemp2pxOlOveOl5jh049tRhuIpD0foKNUxJJ677oF0sPmuvD
         G4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=DU5iW9/lL+KrIuxEbYZB5A4GCRffh61hOYtTWaogeTs=;
        b=fHLSG0koTqbehbWqFKgBMLR311l0KLHir0nCDuNRx7WMBC34GT5WGQmjgOG2xjP+xg
         ORqJMkd7c48PRIAX8DLLMP3bTI4st8F/qQe24izrO01pQqN4k654SZC7dEf4nScjaeEf
         Te3/tidW4F9siwwboKUPxGNspFxXoOdhrwxAIdNz6iblvOyomz+rDgP4p1nm0O0LnkDa
         Qx5jobpUq2qn/Ywcr8U8IzctT0229/nS9oWUKrGYa51BXV1P5qL2ytNYT194O5fRC1kZ
         1VspUy+C611UjsX1FK/5lDjHKvwId7ZrDBu/bYc7oAgdoEYJgvq96Z2L6wWD7NSUR/bF
         pgRQ==
X-Gm-Message-State: AFeK/H3ElTHMldJoHeWvZNYCeibQdCXttTl9VgYvvaoLaPP2EdUamvlDtA0S73L1ZaTpQhAaVvHUoDuhX8+Gng==
X-Received: by 10.25.216.28 with SMTP id p28mr12412957lfg.164.1490682444786;
 Mon, 27 Mar 2017 23:27:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.10 with HTTP; Mon, 27 Mar 2017 23:27:24 -0700 (PDT)
In-Reply-To: <20170327163108.QoV1fm8z7%pickfire@riseup.net>
References: <20170320164154.xBcU6rG0C%pickfire@riseup.net> <CAGZ79kbF+O6tgn-4ivmOza3QGA4oFyJS=9eGHYZ1HQgw6+rEtQ@mail.gmail.com>
 <20170321060526.sXz0cdJwc%pickfire@riseup.net> <alpine.DEB.2.20.1703231827060.3767@virtualbox>
 <20170325021703.Tjq7i-hO7%pickfire@riseup.net> <alpine.DEB.2.20.1703271700130.14958@virtualbox>
 <20170327163108.QoV1fm8z7%pickfire@riseup.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Mar 2017 08:27:24 +0200
Message-ID: <CAP8UFD0i8SV0S7ntpTLBLZF1rFRp-ExdOy=V_-v3eWX98BEqLg@mail.gmail.com>
Subject: Re: Re: Re: Re: GSoC Project | Convert interactive rebase to C
To:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2017 at 6:31 PM, Pickfire <pickfire@riseup.net> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
>> On Sat, 25 Mar 2017, Ivan Tham wrote:
>>
>> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> > > On Tue, 21 Mar 2017, Ivan Tham wrote:
>> > > > Stefan Beller <sbeller@google.com> wrote:
>> > > > > On Mon, Mar 20, 2017 at 9:41 AM, Ivan Tham <pickfire@riseup.net> wrote:
>> > > > >
>> > > > > > I am interested to work on "Convert interactive rebase to C"
>> > > > >
>> > > > > +cc Johannes, who recently worked on rebase and the sequencer.
>> > >
>> > > Glad you are interested! Please note that large parts of the
>> > > interactive rebase are already in C now, but there is enough work left
>> > > in that corner.
>> >
>> > Glad to hear that, I would really like to see interactive rebase in C.
>>
>> Please note that a notable part already made it into C in v2.12.1. There
>> are still a few loose ends to tie, of course; it still makes for a great
>> head start on your project, methinks.
>
> Ah, that's great.
>
> And while I was working on the microproject (shell patterns in user diff),
> I can't produce the output of t/t4034-diff-words.sh manually with:

I don't think it's a good idea to discuss a microproject in the same
thread where a project is discussed.
I would suggest to move it in another thread where you describe in
more details what you want to do and why, what you expect and what
happened, and so on.

[...]

> That's does not just happens to cpp builtins, it happens to bibtex as well.
> Is it that I had missed some configuration since I have tested this on a
> few machines?

From a very quick look the problem seems related to how
test_decode_color() is used or not.
