Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7DD820281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbdI2Ui3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:38:29 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:45418 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbdI2Ui3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:38:29 -0400
Received: by mail-qt0-f174.google.com with SMTP id t46so1108836qtj.2
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jPTkJgPatC0XFlNASGS19QM3UgNn8lUzmA9HerOrJC4=;
        b=a1ZP/qhOoko4Pd/LBfBJPfSkFlXohYxs4RaSmybe2ucKh1ZKqihXlcOYMyZUwY9n4x
         uAHVi4RWfi4/miw3NXQ1BNr4qWPe09Fw/SlEG8lUMZx1YMqZDSEZmS2Sd5DRDPgymPhi
         O/8VkgwIs+LAyNgqtmKrh4zKOSyQ00fnvpwXyLJXsblzMf8++DfNn2nPkLO+uMr0zHLJ
         oEDSE1VTC+V2D+WqQecz+cx0fz9D9BRqKIkrRA//NrXwZFqKXGXnem4c+YxrXVl7cuQA
         sv6wpiZVFSSCHQodg/qP21LrvR1xdLgbfrZE/8OMCz/MUCBeAUrEBqRlWu+oGMPxI1bB
         xwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jPTkJgPatC0XFlNASGS19QM3UgNn8lUzmA9HerOrJC4=;
        b=rJgDQQqVuiqh8DUfNsXY/IYfHiRAfxkmKxdRxSbxyOSRtWXAY+lwkiQzNsh/7ACtvU
         GM8JMfIsKS+xyGGy/8Yap/Kcqu/j2QuHEKiLFOt1Bz6koDppePFMrl1X20qRvjBn8yOq
         oCMl1bRz7MrGu8nFLjw+6oG1iOcoIV9XPdTH8YaCPGbW8ikMVCT7qWOOBHt1kGwLSbvE
         dqfmHJff4245vnXj2HuWQTsONGnxz5K95K2DZmJePGL2SREpplMsO8M5k+1EgddqIg06
         ZhrxHDZGDAZ2v0eGelPyrDYi37FJOORLZmh3cB6mFgcBUnSw3sArqvSoS8v2mIQHXEtr
         8p4g==
X-Gm-Message-State: AMCzsaUEsgVMdrJbaziIPyxF8QheGBQdzo8QEcEY2/sunDX6drxz1p2g
        tPDpuWcvN1JKpr4U5LPgxzx4lnWEaoEq6V7J70U=
X-Google-Smtp-Source: AOwi7QDBjxDV7I5foKi9+A5BU4bTEDUBODGGq2L82Nafro0b4sfeNEgaOaBm668dtZe/vfPxch4gd2NR/IUMF6eV8bY=
X-Received: by 10.200.42.130 with SMTP id b2mr8355688qta.180.1506717508454;
 Fri, 29 Sep 2017 13:38:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.20.23 with HTTP; Fri, 29 Sep 2017 13:38:27 -0700 (PDT)
In-Reply-To: <CAL21BmkcVSEhEK+tAE-RNVabb0pnokYwbagueUrp9giZ3zqT8A@mail.gmail.com>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
 <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <20170928224244.pi34zwifnornssqk@sigill.intra.peff.net> <CAP8UFD13obkLWyuCGUpFxryr8DWfQ8W4JNn04ajO50PvF0SnXQ@mail.gmail.com>
 <20170929072354.fw4eclt56dmfj4a5@sigill.intra.peff.net> <CAP8UFD1-9dYSX-VKZSPN9Ei75V8mGC-wusieL45ArxxJ08tO9Q@mail.gmail.com>
 <CAL21BmkcVSEhEK+tAE-RNVabb0pnokYwbagueUrp9giZ3zqT8A@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 29 Sep 2017 23:38:27 +0300
Message-ID: <CAL21Bmma8gOYx9u4kxRaHJKcF3YsfrQP9=wdAiQX14f9uSPRAQ@mail.gmail.com>
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
To:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> About minor issues ( "tmp" vs "p2", variable scope, space indentation)
> - fully agree, I will fix it.
> ...
> So finally I think that I need to fix that minor issues and that's
> all.

I forgot about leak. I also need to add checking in mru_clear. That's
not beautiful solution but it works reliably.
Question remains the same - do you see something more to fix in this patch?

Thank you!
Olga
