Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27232202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933422AbdKAWVi (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:21:38 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:49685 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933336AbdKAWVh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:21:37 -0400
Received: by mail-qt0-f175.google.com with SMTP id k31so4574579qta.6
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JAFBPOkxOsxN9ZSr0QD4nUxjIRb39P6a+3qocFjSK0Y=;
        b=kH2ktbMGsowEGd/l3KgdXQa/3+vjU90YUk3T28cOVMtFsSHMYhX6pjxAGLbAMQFzk2
         n5JpG6YrfCVovGjqPuHr1tahUeCNJd8FZqzIFXxs6ICdQVd/00e0POp+ZddbMGju/k+M
         0KuYOU+y/KJskcjUuRkzz5W5AQHVWFTkffQimlIqEzystpIIJZTJEXLyakTwygU5IRko
         U+5uXPt23zTqXrqQ1Sw1UcZt2TERC1M5YlWoHvaayb0p5kJiM8TrrKap6FmkF4/Vjsp9
         o2fKztg0tHLWvZ2+lKSr+G+v6ARtA/mMSekgjGAzjy6iApQWdJphXgsHhP7+2yu+GIEE
         ve9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JAFBPOkxOsxN9ZSr0QD4nUxjIRb39P6a+3qocFjSK0Y=;
        b=naa6NhFmddsPaO5uy688x0TLkHG5EUmRel7ewZA3yFR/W3fPWLiSrtuDeAo+bG2AQq
         J8x+9YN8emffCrtwYR/b2RQkSGI16jq1FQtaHxBAJtqM0pUll9FkZ+TpaHKNIFzcc2R/
         2NW/2tMbg8ORdr+qaVdoicOXBWvQm3wBHfrab7Y94iO09WAUtMxb+PYWjLLC23CSjy2m
         zGhVH0j2eSbHq/LNJ0JCM3M29K+hQbjTlju6Ps0QwAXVT1Di+KUyJugDf9QFjQNy9Ag2
         iq9YMOCDoe2KUTgaQYa6qHZcEYmQZdzEqk/p3AF+2JtQd4uD4U5Wcg1cZNqdm3tmAkph
         He4Q==
X-Gm-Message-State: AMCzsaVduHP+QGayxeUBwCRh5RUQ5+ZXz3X+wZCe3aqLaB2Q+6GUa3xk
        PwFrdfnAJ1w9wpsyYRlrMJ8EczCgGNiXhMDNsEW4yQ==
X-Google-Smtp-Source: ABhQp+RV9CuGD2VGAgLXnT+wwHpX7JSiCYfu0Q0FVeixFCeL/MFU6lY2DNCOVVwaFtOMFTXYV6GUgcW0E9GtmQ66zrw=
X-Received: by 10.200.8.53 with SMTP id u50mr2364617qth.260.1509574896913;
 Wed, 01 Nov 2017 15:21:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 15:21:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1711012310250.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-7-sbeller@google.com> <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711011329300.6482@virtualbox> <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com>
 <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com> <alpine.DEB.2.21.1.1711012310250.6482@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 15:21:36 -0700
Message-ID: <CAGZ79kbOEM_W65Rym4yiDNHpFGTNWMYdh=aVPjThNWjEHPQong@mail.gmail.com>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> I know id prefer the first commit that introduced the blob. That's what
>> describing a commit does, it finds the oldest tag prior to the commit,
>> while --contains finds the first tag that contains the commit as an
>> ancestor.
>
> It is very easy to wish for "the oldest commit introducing a blob". But
> since we're in a DAG, this question is not necessarily easy to answer:
>
> - A - B - C
>     \   /
>       D
>
> Let's assume that all commits except A have the blob, and that B and D
> (for some reason) have the same author/committer dates.
>
> Do you identify B or D as the commit introducing the blob?

The current implementation gives C, though.
(assuming C is HEAD, and A is ancient)

With the --reverse flag one of B or D is given (not sure which,
depends on the exact order).
