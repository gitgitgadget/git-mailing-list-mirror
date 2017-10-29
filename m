Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428A2202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 19:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbdJ2TCX (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 15:02:23 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43802 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbdJ2TCW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 15:02:22 -0400
Received: by mail-qk0-f193.google.com with SMTP id w134so13758701qkb.0
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=eAKn9VE2FPsLfvCsd1J1DXMchV2gHFYmWvBVRXSsWxo=;
        b=JOFdUugQR4u67sMx8AvFhUHpddnR0RbHQQwawNqF8o4gP6+p6dZHsXvTbBaXQFYe5l
         GnspP3KuFrKy6/u5NJJjKC3OOxiTVP/tMaVIN3yez+qhlreEjgvAwxWEVJsjEhI+qv3M
         Ua+3nQWsxwEgAmKvg+jCpw5AAZwu1bjJwpZzdy1WS1B8havTEpdIIE6FY168s7TVCNuu
         RypZL/Ag8c5wEvo16f0kTl+IzBQYkUBGUeFxw9tEh02dx6/nwKys/0idB3gnSuBNo4Zk
         P7lDW4I8STjn1fZ4dEqvN20sG6SZ3MzUb/FBFO+yOgCo39hAjmqaWyoUcf/vVocfFJ3w
         mQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=eAKn9VE2FPsLfvCsd1J1DXMchV2gHFYmWvBVRXSsWxo=;
        b=fk5ziBkTEfscDatNQbp2qtcvD+rPGT8XNckX/dUvlax74oASfr1wTgJkauNT/2OvEI
         bULYMFO1P6mDX0WFLAWSCa4iij5Etuf4PC80dUZRDWooB5pKg15LlXpECKu8rUIcCngf
         uV2SqdhUmfZgsTn5BgtPEiJSaDbONXPzSHE/lNEBnCYVdjDjrXD6OJqPOHkHPRwUHw9c
         lTCvk8zSItNBrWzTaRV0XkziigWNi91jPiQjHs9fZhtp8PzEsSUXn2tadIYz7P/nrtVK
         R6wFLmcoWWuD5hTyE6VsRCLTT+G0tdm4lSzB2hXTvubABIOewEMHpy42e9N4vz0hd847
         zQbA==
X-Gm-Message-State: AMCzsaVGq/d6JAH8peH2CPnaC9guDNy4rRAbAQEphsAa+ksf05vyMSFa
        MM0mEJnT3iLoJFiNWLCdk5QZqsRnrj7JNjzXswU=
X-Google-Smtp-Source: ABhQp+QMeZMmUPVfCNYj5dgKe/IsAeXfIx6dlyX8gK2+ThPnso59npoc08nR0EjqDNx+CB3g+RSKKJDWXXqBdUaNetw=
X-Received: by 10.55.109.5 with SMTP id i5mr10150668qkc.73.1509303741268; Sun,
 29 Oct 2017 12:02:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Sun, 29 Oct 2017 12:02:20 -0700 (PDT)
In-Reply-To: <20171029175712.ijqirnghcgeufqae@genre.crustytoothpaste.net>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net>
 <20171028181239.59458-4-sandals@crustytoothpaste.net> <CAPig+cTrAxWczJ5qX2qE-hqoo6hA2QCom25HYB7v48rVnPgTow@mail.gmail.com>
 <20171029175712.ijqirnghcgeufqae@genre.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Oct 2017 15:02:20 -0400
X-Google-Sender-Auth: vMEKN7NKTeghEMHRN3UrTkRP8m4
Message-ID: <CAPig+cRtexDJYMCUR1rGZjJOBRuDbhxP==US2VdNPhSWzeL6LA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Integrate hash algorithm support with repo setup
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 1:57 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sat, Oct 28, 2017 at 09:44:07PM -0400, Eric Sunshine wrote:
>> > +#define current_hash the_repository->hash_algo
>>
>> The all-lowercase name "current_hash" seems likely to conflict with a
>> variable name some day; the fact that it is also a #define makes such
>> a collision even more worrisome. Although it is retrieving the "hash
>> algorithm", when reading the terse name "current_hash", one may
>> instead intuitively think it is referring to a hash _value_ (not an
>> algorithm).
>
> I can do CURRENT_HASH_ALGO or CURRENT_HASH instead if you think that's
> an improvement.  I originally omitted the "algo" portion to keep it
> short.

I don't have strong feelings about it aside from worrying about a
"current_hash" name clash or a reader misunderstanding what it
represents.

Does "current" need to be in the name? What about HASH_ALGO or REPO_HASH_ALGO?

> Alternatively, we could have a current_hash() (or current_hash_algo())
> inline function if people like that better.

hash_algo() or repo_hash_algo()?
