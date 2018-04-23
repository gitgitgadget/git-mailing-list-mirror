Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C551F424
	for <e@80x24.org>; Mon, 23 Apr 2018 16:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755418AbeDWQjw (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 12:39:52 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46746 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755134AbeDWQjv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 12:39:51 -0400
Received: by mail-oi0-f67.google.com with SMTP id y15-v6so6923048oia.13
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=NKnZBWUbslZ40c/DtBKvv84SJ+jLuPsnjwPAMLnyXWM=;
        b=jYBNGpEH0x2ZuUANox3QLz16NgxNVjDSOW3u5XeJ/a65pu+TMr1HDGR7xTC2LURnMx
         se/jn2d/zjtgTOeTrplVoADnece78qGupy9DIftCSKtFz742iljUnWw0g6fnNxidC6G0
         AkU1h6a60aC3Vf0TcKCjzbzyfSJAf4+JLtWVgPg7L89uN2KvjnkiEhlTOtiuN3oL0/Yp
         +ES07Xqken6pKDwYvKyLCpZqgrQ/1Ikwf5/aWy6KXzdRR2v6ZgI727gGY5aHKzm0imPI
         b/msjg3MT9nLvVZ4KurwfIFhSuEMNBgcnlRq56g/uNrvDMJe1NoGo9j2NzRHXZyD8pCU
         zdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=NKnZBWUbslZ40c/DtBKvv84SJ+jLuPsnjwPAMLnyXWM=;
        b=SNspMS8ij8UTdUdSAl/tA7kXP9U8VJ7qq58h/GW+qL9Jpn0kCSJM9cCKuX0DJTlZWX
         4nEUJk8tXlWZxQEFuVolRn+cc9j8DugNQAyKUg6ZwqZP2AIFsvh1EOCMrPUfzDtXyOyd
         1Qp7HLIJepPgBtSFIVtJrd+PiRiZy4aa5sXnMiP3Q6z/FtFV6hxr3xrRE5QvFIUxR48j
         OEEEx5s77g9+FbEj38EyorWXZicc1IuG/4nSZILqvc+bGUEE0nwEfEueEBueI2ZA/Bmu
         b0fba2TIL6uFl0O7IxUoCXFAfcQVbLU0OKdBceUq3tgQX/aBkTPUNq9Uq2Aw5Es6q2Ny
         +sDA==
X-Gm-Message-State: ALQs6tBZkJiva0doSyyfeL+Jl5nj59iVaphWhdr48cX1Y0YOwBJBRdrg
        S6F3RD816tt4xVqey6PfuoxAQaHxkG04RoMPPIA=
X-Google-Smtp-Source: AIpwx49aNcBQLPbKm3jADURCJ9xiTUbwmdWqfGO7ce4TGxVEJaVxdbK4CPtonlMpBGK7lbWgVhZO6SMgzznHM879vb0=
X-Received: by 2002:aca:5314:: with SMTP id h20-v6mr7973339oib.86.1524501590681;
 Mon, 23 Apr 2018 09:39:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.112.67 with HTTP; Mon, 23 Apr 2018 09:39:50 -0700 (PDT)
In-Reply-To: <20180422174902.GJ14631@genre.crustytoothpaste.net>
References: <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
 <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
 <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com>
 <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com>
 <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com>
 <CA+FnnTzFomd91d1F6O-a28hXQ6PxOiBd44da4nSVW0MuDKgkmw@mail.gmail.com>
 <CAPig+cTw5GjB4VgFD2teDvMuyGPFFoNSCqbXbarEXCe3fVdLjQ@mail.gmail.com>
 <CA+FnnTzkZS7HP61Ck3y5p0EC7J_h=ToR5tq5cvEpJ79vYuSxZw@mail.gmail.com>
 <CAPig+cT0ogLmiviWhdZTLxDM7+VN3hk7wgkKnvX96Ym-yXR5bA@mail.gmail.com>
 <5adc355c.rJrv6ddtapM9C9H5%perryh@pluto.rain.com> <20180422174902.GJ14631@genre.crustytoothpaste.net>
From:   Igor Korot <ikorot01@gmail.com>
Date:   Mon, 23 Apr 2018 11:39:50 -0500
Message-ID: <CA+FnnTxD1JbeNFt1K4OU7JMWvyXpRiYLmZJSiqm=DqmSca3_LQ@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Perry Hutchison <perryh@pluto.rain.com>,
        Igor Korot <ikorot01@gmail.com>, git <git@vger.kernel.org>,
        sunshine@sunshineco.us
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Brian,

On Sun, Apr 22, 2018 at 12:49 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Apr 22, 2018 at 12:10:20AM -0700, Perry Hutchison wrote:
>> Eric Sunshine <sunshine@sunshineco.us> wrote:
>> > On Sun, Apr 22, 2018 at 1:15 AM, Igor Korot <ikorot01@gmail.com> wrote:
>> > > MyMac:git-2.17.0 igorkorot$ cat config.mak
>> > > NO_GETTEXT=Yes
>> > > NO_OPENSSL=Yes
>> > >
>> > > MyMac:dbhandler igorkorot$ /Users/igorkorot/git-2.17.0/git pull
>> > > fatal: unable to access
>> > > 'https://github.com/oneeyeman1/dbhandler.git/': error:1407742E:SSL
>> > > routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
>> > > MyMac:dbhandler igorkorot$
>> >
>> > Try re-building with OpenSSL enabled (remove NO_OPENSSL from
>> > config.make). You may need to build/install OpenSSL yourself to get
>> > this to work.
>>
>> Explanation:  "tlsv1 alert protocol version" means that the server
>> requires its clients to use a newer version of TLS than what was
>> used in the local build of git.
>
> I think the issue here is that you're using a crypto library which may
> only support TLS 1.0 on 10.8[0].  GitHub requires TLS 1.2 as of
> recently.  So this isn't really a problem with Git, so much as it's an
> incompatibility between the version of the crypto library you're using
> and GitHub.
>
> I expect that due to the PCI DSS rules prohibiting new deployment of TLS
> 1.0, you'll continue to run into this issue more and more unless you
> upgrade to an OS or crypto library that supports TLS 1.2.  As of June
> 30, TLS 1.0 will be pretty much dead on the Internet.

Yes, openSSL on OSX 10.8 is old. I will t to update it tonight.
But as a developer I'm trying to stay with whatever OS provides.
Because upgrading will actually means that I will have to recompile an re-test
everything I made, since I will be working on a brand new system.

This is however is an unfortunate event when I will have to upgrade...

Than you.

>
> [0] I surmised this from https://www.ssllabs.com/ssltest/clients.html,
> but I don't use macOS so can't speak for certain.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
