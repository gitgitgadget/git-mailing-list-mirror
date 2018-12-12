Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A540820A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 00:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLLAmk (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 19:42:40 -0500
Received: from mail-yw1-f43.google.com ([209.85.161.43]:46738 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLAmk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 19:42:40 -0500
Received: by mail-yw1-f43.google.com with SMTP id t13so6261126ywe.13
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 16:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXefcjX4c1t4/7y5KCF7cysBlyiQJlfXZOWeXjwYbCE=;
        b=I7/2ePEmdmuADdbnGwdWDihHNrfQtKkJDBBz1N5orOlVOlPPaYP8FCMVYRakD0zr64
         aCziosMTUfE/xAcvUoicJqsKSXV69IfY62h7kbw1/IxJB2DmVu17m57D7gQ8u2+sk3li
         0bmTXCgDqSQbAAZtAH/S8mTSe0wD4vDuM2vUPCBJGxwOy4HNLAdV4RIMIhvJHPAgI70g
         i3vugtVRcWiMMXOtEkRrlb+lsAN6DTV/kM7cNGFRJ1KHAW3mKmeMNGSj6XsfWf7i9VK+
         RFv71rGoqNzc65PwLIQ9JHt2SNR4Xp00PW5p91FNUsN4HhWloJCqchT2dNTFzFWe/xN0
         vGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXefcjX4c1t4/7y5KCF7cysBlyiQJlfXZOWeXjwYbCE=;
        b=KRm/k1s3IkGuq0455x5kwYTsnveE3naG0mopUnQxPJk2s1ruHMccw0sse8ryBc0Iia
         CcepUmEhjK204LD74fax7oO7yrxU/i6bmXmYlyTkOa/8XdauI+OK139H1x5rhfszLjON
         zASKgT2HxWRcQ1kUn/YTAZvvGtQPtxzqcR5b79KvyhoacOS+/uPVvzfbnOP0PXoYV8N0
         BXlm1auNW5WyeuAOeQTGDeUvr4x63M6JsOV4IZhKxu3FxzPg9ZiHRCtVDZodIEjDAUBG
         jdNjYw4nKG8L5Tp4XJF45fqrXl12PFuAfsjakDrS4a3J2v8ecY52H6EK4Rf9tHwQHHBO
         zaaA==
X-Gm-Message-State: AA+aEWaF1ACLIV2Cvid9Y3btIRVM5ZHrYMcRfbc9IiqsYOJ+jl6LY7m8
        02KAoos5Zf6JToBEt9TN9J5irPQZBPJ+H1xpmHw=
X-Google-Smtp-Source: AFSGD/U74aDJVbVpRfVxRKlJ5qSsHvOAPbpWR/WdJwcSSjZ0cMt0egBms1sWgM/UFTxKDQHObHUh2MYBqKSWP7591Ic=
X-Received: by 2002:a81:27d0:: with SMTP id n199mr19082309ywn.350.1544575358700;
 Tue, 11 Dec 2018 16:42:38 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181207170456.8994-1-tboegi@web.de>
 <CAAXzdLVTjCVDmBik-j9B_Z_2wgSj=_6baqmjmGEGBFOsjkyOsw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1812100938140.43@tvgsbejvaqbjf.bet> <CAAXzdLUKhCfvqdvsPryeMGJ2ttJxof4sUcyTx-xd5p2BaoryiQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1812111429320.43@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1812111429320.43@tvgsbejvaqbjf.bet>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Tue, 11 Dec 2018 18:42:34 -0600
Message-ID: <CAAXzdLU7dJGOW689tDkYuRYko1zYHXMcj_2PaVa0qStYA7ELNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 7:39 AM Johannes Schindelin wrote:
> I have no intention of flaming anybody. That is simply a
> misrepresentation.

you may see yourself "through a glass darkly", but i dont. this language is not
constructive:

> > - pc-windows
> > - pc-win
> > - win
>
> I find all of those horrible.

one windows triplet in use is "x86_64-pc-windows", used by Rust:

https://forge.rust-lang.org/other-installation-methods.html

which is how i came about my suggestions - again they arent great but they arent
misleading as "Win32" is.

> It is a long established convention to talk about the Win32 API as the set
> of functions developed for Windows NT and backported to Windows 95.
>
> There is no benefit in abandoning that convention just to please you.

Quoting from Wikipedia (emphasis mine):

> The **Windows API**, informally **WinAPI**, is Microsoft's core set of
> application programming interfaces (APIs) available in the Microsoft Windows
> operating systems. The name **Windows API** collectively refers to several
> different platform implementations that are often referred to by their own
> names (for example, **Win32** API)

and:

> Microsoft eventually changed the name of the then current **Win32** API family
> into **Windows API**, and made it into a catch-all term for both past and
> future API versions.

http://wikipedia.org/wiki/Windows_API

and quoting directly from Microsoft:

> The **Windows API** can be used in all Windows-based desktop applications, and
> the same functions are generally supported on 32-bit and 64-bit Windows.

http://docs.microsoft.com/windows/desktop/apiindex/api-index-portal

So again, "Win32" refers specifically to the old 32-bit only version of the API,
while:

- windows-api
- win-api
- winapi

refer to the current version.

> If you want to change something that has been in use for a long time, you
> have to have good reasons. None of your arguments convinces me so far that
> you have any good reason to change these.

i am certainly not interested in convincing you. i figured you wouldve gleaned
this from the fact that i removed you from the CC. Nevertheless, see above
links.

> If anyone truly cares about an issue to be fixed, I would expect more
> assisting, and less distracting, to do wonders.

hmm:

- http://public-inbox.org/git/CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com
- http://public-inbox.org/git/CAAXzdLXmJ1YKiTF17b=ZfkM3HtJCNkvVMQNU=riW8R42VLid_Q@mail.gmail.com
- http://public-inbox.org/git/CAAXzdLWByGC+B_XdDiJwounoPgMAsMq=EuOSx9bdV-f5vQUhnA@mail.gmail.com
- http://public-inbox.org/git/CAAXzdLXCEeZdkCXT+-0n=Fn7_=Nz5cm+6xr0w-cd6B1om028uA@mail.gmail.com
- http://public-inbox.org/git/CAAXzdLU3dsCabgYKnD9c7iWZcXx1cfO3tisJ7r0dNjiiTHk1mA@mail.gmail.com
- http://public-inbox.org/git/CAAXzdLWBSD5coxqbyRN_d9B1e4AA-Q6VQ7iRo8BPuhBKDicMRQ@mail.gmail.com
- http://public-inbox.org/git/CAAXzdLX4jU7+i1W1A_Q1LpPFa1D4FYVPW5rcMnqr_tDHEJn+tw@mail.gmail.com
- http://public-inbox.org/git/CAAXzdLWtDw09umyr23qZkv2jQ6_mTeFXbktgb-f6S2w6Zf1Egg@mail.gmail.com
