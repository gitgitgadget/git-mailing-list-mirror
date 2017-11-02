Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 301B2202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 06:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbdKBGFX (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 02:05:23 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:47480 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbdKBGFW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 02:05:22 -0400
Received: by mail-wm0-f52.google.com with SMTP id r196so8557138wmf.2
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 23:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rqPoa9nmh6ViwmQfUiPdC8UjYtnfYnNyOZnRZQTJTM0=;
        b=nDm8YxOcuWfChaA9FWElR7rtZmYp+jaAYeHO2h6HN0TEn9NjlKraicolzJduVcEml8
         L5iez3GhWvqYwXncntVAAFewGAv5aRJfUrlKNWMgJdt7tz1NhHBqvFeKH4qvr35vMDxs
         yc0rR4XsjaJOjCOPctgg9RpnV7MLHeZq0tpSCFnoh6XLgD5bOWnfLFevPLuHmmqa8vny
         bSBc5QVzIl1tSKc68fEymj/kP6ugHMMLqeW7mF2iRrz7t9EIhQ6fb/uoKmjKrA6fMX+A
         XXPfQQ6dikd8nzXT1TeeJ2L9NHkRbUNGy9S05Daj/tADg63cGRs5Q7yf7ImugatgNeTd
         8IOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rqPoa9nmh6ViwmQfUiPdC8UjYtnfYnNyOZnRZQTJTM0=;
        b=TpoSZMdq19jyLGuhvOE+tWSxTZD6DQoy7vjxjQSJB7L5kH76Z5mEr93hTByZyCBuHF
         +c4GtXz6HlvaTpRlLMY5tnvQSV23mSiJMwi0UpbAevrtgZx+NR6+g3vDjLwKKdGA4esk
         b72z+PmgE8VN9FfwAMaH70IS6+gcSR3dbs8f9Rszc7giQ7wvSwfrxNN4clNZJFKqdmi7
         XKft7jTnwc2eaQ84ugE3IFclgaRiTatLlRvuCccVD3fF2zLAOkvqsWX5ZkSuNfhfQTXn
         2bLG+fHTF4yw+wSxzH34LVZ3Lq6V42fMiEyxbZE/rXeieZgY1b4HESZNFEcxzwRUUEwb
         f/Zg==
X-Gm-Message-State: AMCzsaWuyBV5Gv1f8QVK4PXw9sJPCSIqpHPq25XBDxVBiHeuh9zIvCuf
        9D2baUml6h2lhWFMRuhmOzB5as+ig2dMhdaoXFA=
X-Google-Smtp-Source: ABhQp+Q0/Q+cNDTFRc19ptuQiLrY+1Xckcf9Inqo7GEryu5E7NB8tYgkLe6mRbu8babjg5oLFEw3tvf/BX9IMEdvJtY=
X-Received: by 10.80.208.222 with SMTP id g30mr2931736edf.246.1509602720962;
 Wed, 01 Nov 2017 23:05:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Wed, 1 Nov 2017 23:05:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1711012340290.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-7-sbeller@google.com> <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711011329300.6482@virtualbox> <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com>
 <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com> <alpine.DEB.2.21.1.1711012310250.6482@virtualbox>
 <CAGZ79kbOEM_W65Rym4yiDNHpFGTNWMYdh=aVPjThNWjEHPQong@mail.gmail.com> <alpine.DEB.2.21.1.1711012340290.6482@virtualbox>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 1 Nov 2017 23:05:00 -0700
Message-ID: <CA+P7+xqw9zKNUkn9P-qA57ADSB5G_7Sd0JCc6SaK6bBf9-Jhtg@mail.gmail.com>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 1, 2017 at 3:41 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Wed, 1 Nov 2017, Stefan Beller wrote:
>
>> >> I know id prefer the first commit that introduced the blob. That's
>> >> what describing a commit does, it finds the oldest tag prior to the
>> >> commit, while --contains finds the first tag that contains the commit
>> >> as an ancestor.
>> >
>> > It is very easy to wish for "the oldest commit introducing a blob". But
>> > since we're in a DAG, this question is not necessarily easy to answer:
>> >
>> > - A - B - C
>> >     \   /
>> >       D
>> >
>> > Let's assume that all commits except A have the blob, and that B and D
>> > (for some reason) have the same author/committer dates.
>> >
>> > Do you identify B or D as the commit introducing the blob?
>>
>> The current implementation gives C, though.
>> (assuming C is HEAD, and A is ancient)
>>
>> With the --reverse flag one of B or D is given (not sure which,
>> depends on the exact order).
>
> Sure, but it is still a tricky thing. Imagine
>
> - A1 - B1 - A2 - B2 - B3
>
> where all the B* commits have the blob. Do you really want to report B1
> rather than B2 as the commit introducing the blob? (I would prefer B2...)
>
> Ciao,
> Dscho

Yes, but I'd rather we find either B1 or B2, rather than B3, or in the
first case, I'd rather we *at least* provide B or D, rather than C.

Or:

A - B1 - C -E - ... - Z
  \ B2 /

In this example, if everything except a had the blob, we'd find z,
which I think isn't as useful as finding one of B or D.

Sure we can't find a perfect answer, but I'd rather find a commit
which introduced as blob as one that adds the blob, rather than one
that happens to point to it because it has history which includes it.

I think both questions are valuable, the first is "which commit last
had this blob", the second  is "which commit first introduced this
blob", neither of which can always give a definitive answer. It really
depends on what question you're asking up front.

Thanks,
Jake
