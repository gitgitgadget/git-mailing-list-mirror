Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034A51F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 02:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbeJNJxk (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 05:53:40 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:44529 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeJNJxk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Oct 2018 05:53:40 -0400
Received: by mail-io1-f46.google.com with SMTP id s6-v6so1264583ioa.11
        for <git@vger.kernel.org>; Sat, 13 Oct 2018 19:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dana-is.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WDJLrOg09DFxRK7zkrhh31G+G0X+ZQi9HINJfmwYt4M=;
        b=1CNNAmxFrbjgvhaZQh1GYm/E62UQxMsBqT5Zh+XK4EJBlUoQPgvFoBm4H9Yul4HsiJ
         PRy7aVFMFB/Cus5V8Vi4HPKtVTbk2IPjwPQhfJTvh6SgE0s8ubkaq2VH5kVBKbQhCHos
         FIX4yagAjsmaqQJTUhox0WlpcZD6iLav2pDBG7hSV79H/HhviWqk9WrNAZzSKwEzDowD
         ScNkSXqK1XaPQhvoP1hvotL6K/Zj0VBrzG/5fsz1UT292JPRWBT8LZ/gobatxQDbgnVK
         74BVddbxhPpvOpNgYQrMwczI8LkWOoou+1Tlae1C5akNA17515M1cCGHEX7UNhg4xmLc
         dWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WDJLrOg09DFxRK7zkrhh31G+G0X+ZQi9HINJfmwYt4M=;
        b=FvxUFiGXgHgbtuzqQgb7FmnrSG2b+EitIBKFDKQNglhMsyZYzkmZe4u3CgC4r2UCan
         TPjroFLwVXpKBXbUwANXbbSq1HNvcPxEyu8brKGfHGbn4DghHIbpPi5Fs/G8xgPM/35/
         mDYTx03i+6AwJ8vDhlw+G9sh4XBMa2IPJJEvkNmqochKUh5Aj2WylxT9RnGzaIKUsTGH
         8fOCVXy7bh8oyaZPrxMZnrC4spMcAjMYAFd8wFUFXaXPOD8vbmC14ISG7GU049hwOce1
         8thP8tAl4gICJDkvKyZcmzsFAwAI9baQYVDk88KO/o3aPluyA0ou6vwNNxhhhzbUb5b2
         abPg==
X-Gm-Message-State: ABuFfohD2PFg18hvBkLMwhjrSd63HTgO9gbzYnts7Z2KHoD8OWCY5s1Q
        AZNlFkmqhog7JxDDhEK0Dr4w/w==
X-Google-Smtp-Source: ACcGV60d5MPdeNDUTJ47S2GKu5I7zusUwNOxAVeUrhk5R6NRUvy8t6aIWYgzfhXl5x6T+rh95vn39g==
X-Received: by 2002:a6b:310d:: with SMTP id j13-v6mr8460367ioa.250.1539483261186;
        Sat, 13 Oct 2018 19:14:21 -0700 (PDT)
Received: from heartswap.lan.dana.is (173-21-17-19.client.mchsi.com. [173.21.17.19])
        by smtp.gmail.com with ESMTPSA id v5-v6sm1879465ioe.61.2018.10.13.19.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 19:14:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [BUG] gitignore documentation inconsistent with actual behaviour
From:   dana <dana@dana.is>
In-Reply-To: <87bm80eo6h.fsf@evledraar.gmail.com>
Date:   Sat, 13 Oct 2018 21:14:19 -0500
Cc:     git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Andrew Gallant <jamslam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7F1D716-D8DE-40DA-AE3E-740BD28AB677@dana.is>
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
 <87bm80eo6h.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 Oct 2018, at 06:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>Our matching function comes from rsync originally, whose manpage says:
>
>   use =E2=80=99**=E2=80=99 to match anything, including slashes.
>
>I believe this is accurate as far as the implementation goes. You can
>also see the rather exhaustive tests here:
>https://github.com/git/git/blob/master/t/t3070-wildmatch.sh

Thanks. The tests are a little hard to follow at first glance, so i =
guess i'd
have to study them more to see what the semantics actually are. When i =
tested it
briefly it didn't seem like it was behaving as you described, but maybe =
i wasn't
paying close enough attention. In any case, i'm sure these will be =
useful.

On 11 Oct 2018, at 06:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>The reason I'm on this tangent is to ask whether if such a thing
>existed, if it's something you can see something like ripgrep
>using. I.e. ask git given its .gitignore and .gitattributes what thing
>matches one of its pathspecs instead of carrying your own =
bug-compatible
>implementation.

My impression is that it probably isn't practical to use something like =
that as
ripgrep's main pattern-matching facility =E2=80=94 for one thing there =
are performance
concerns, and for another it makes it dependent on git for some of its =
core
functionality (and it's not a git-specific tool). But i was going to say =
that
it'd be useful for testing, and when i e-mailed Andrew (the main ripgrep =
dev)
about this he said the same. I've CCed him on this message in case he =
has
anything to add.

dana

