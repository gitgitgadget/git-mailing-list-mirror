Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920191F731
	for <e@80x24.org>; Sat, 10 Aug 2019 12:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfHJMlA (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 08:41:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38717 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHJMlA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 08:41:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id d17so143219215oth.5
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9y5V7DibcjlpvnXQucqumrumg13tgGv/8QDpJk4ctOo=;
        b=mxgpshkKEswebpgahKfNG9/K96ljJxRurMphHZOoPWKQqImrsw7CQKfB/pVMuQ+Ub/
         WYrJF1DCVes1hjWaM2E4EuSnrgO8KRIVycwgM3eKauSvFFWKsiB30exlx1OoFP4cVANY
         BoJ8bCQIEhV1SU9IhsL6bbItv6qy81ntdj8aUu3Zi+DTdOm68mAgXN5rFLSC0ObWnWu0
         d+G02mSCC/AUCQWvhlcNQq0P88szFByzyME+ZbRzZw1NiWyZgcP1K1IDQT9QDhX7RMxS
         ATJ57HiL3CTdM9gCLTJR9b4IqccSsGsSlmHPeQLvrQwhaf6SB+a35zQXZt+CK/yn4X9m
         ovkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9y5V7DibcjlpvnXQucqumrumg13tgGv/8QDpJk4ctOo=;
        b=K/nAHq0Ae8BvvqeBz8eYOW4sObwnyf+1pfIyiFGxJG5T/4Bc63Ulee1y9cVrbNtTWE
         afW7ZKHLkTsCeioRr1MUUH1nZVmgI7kaBfi95m+pPvK6bYZHNRgjnif6pJqiSpjuzd8C
         2XVZxtIc9eifySEKYyg90JPQvTM/iCdPQUp6CwrJ2Jatl5Fm+A7W5ZZM2VgL8Ai5FryT
         zt+7fRK+I7s71wvYTFvhONEbOhQIDfY84g08aosXIpUrX6tIOQV+3iLf3BXD90w0ilJW
         pfdnIa9y7F4EBCh74OsuYwIxeM8701GbKOscn3CY+5+DVaQRoacYc3Flpbb17Be+KyD6
         0dUw==
X-Gm-Message-State: APjAAAVWSb9lZ32Vn3yerL2PjECqK0aSVTEn9H8UemQ4ScItl8suCIcz
        aFgu9phfMFQl4C94jmvoJxmivytmHe3rJ9zwesM=
X-Google-Smtp-Source: APXvYqweundVn6wyvtEm8Y18CMEY654IpsUC83oMfVlJHsGxb9hLsJRj25hTWGxN0V/x3n3/DwN+ZKFkXzjDTVc7nZs=
X-Received: by 2002:a6b:b804:: with SMTP id i4mr14382307iof.205.1565440858910;
 Sat, 10 Aug 2019 05:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190807213945.10464-1-carenas@gmail.com> <20190809030210.18353-1-carenas@gmail.com>
 <CAPUEspiK7MTZPMktbU=_C_GPOH9vQiBmVUZp7GuR97RZS3onRQ@mail.gmail.com>
 <d239326e-11c3-5875-13a8-f4123baea6eb@web.de> <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
 <CAPUEspjVMbjdgBrW3qS3jwbd2ZfqMinfgGiasEZGwyZB-1c+QA@mail.gmail.com> <d8e55007-27bd-fcac-c918-bb712ec1bb8b@web.de>
In-Reply-To: <d8e55007-27bd-fcac-c918-bb712ec1bb8b@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 10 Aug 2019 05:40:46 -0700
Message-ID: <CAPUEsph+hjU2UstL=YW-2qKC3pGJrOwaw+VCiHH74HZ2=oupig@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/3] grep: almost no more leaks, hopefully no crashes
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        michal.kiedrowicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 10, 2019 at 12:57 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 10.08.19 um 05:05 schrieb Carlo Arenas:
> > in macOS (obviously testing without NED) the following is the output
> > of (a hacked version) of p7801 for maint (against chromium's
> > repository), with Ren=C3=A9's patch on top
>
> Do you mean p7820?  And what did you change?  Looking at the results you
> removed basic and extended from the list of regex engines, right?

correct, that was a weird typo there; apologize for the confusion.
you were correct about my changes; ironically, I didn't spell those
changes out to avoid confusion.

> Ugh, cloning https://chromium.googlesource.com/chromium/src.git sends
> more than 16GB across the wire.  Is that even the right repository?

noticed it was mentioned before by people[1] doing performance testing
on grep specifically and
thought it was better than try to come with another one, the linux
kernel wouldn't work in macOS
because it breaks "run" as it fails to checkout in a case insensitive
filesystem.

> Not
> sure if my machine can keep the relevant parts cached while grepping --
> I/O times could drown out any difference due to context allocation and
> memory allocator choice.  Let's see...

;), try setting /proc/sys/vm/swappiness to 0 or get more RAM

> I don't understand why my performance is lower by factor 2.5 than yours
> for all perl regex tests except 7820.15 (your 7820.4), where my system
> is two times faster.  Debian Testing, GCC 9.1.0, i5-9600K, 16GB RAM.

interesting; did you also see at most 100% of one CPU being used?
yours seem to be faster than mine so this might be representative of
single threaded performance.

> Anyway, nedmalloc is slower across the board, but the impact of my
> patch is in the noise.  Right?

yes, and there is a lot of noise.

Carlo

[1] https://public-inbox.org/git/e72330c6747218545cce1b6b1edfd1e448141a8f.1=
563570204.git.matheus.bernardino@usp.br/
