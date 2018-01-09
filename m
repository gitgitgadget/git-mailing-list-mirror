Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E2C61F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935457AbeAIT0r (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:26:47 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:40618 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935447AbeAIT0q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:26:46 -0500
Received: by mail-qt0-f176.google.com with SMTP id u42so19188810qte.7
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ovNyTQldeq3HvacTbl6Id2BEcR+V4Uma+b5P21Hdyew=;
        b=Y7LcBf1Fj8hRE0j4qPhY1brbV8LZcmqEatAdmh0x90lJT50iI5LNborNES+fLAnQ3V
         nI1UZiXDZ9Hq1+HAz+8CIb0MKjSaE6HuBdbwCJRJr8S0F4c4/ewVqC37KKW7gxHZnpSY
         cQa3EdtiVam3LbriHuszbyOWyDdvgu7fqod1KN3ccgC4h0T7Ul2ia1ob8E0p+lb55njV
         VfuLl6gO/ztC5uJ5Hgh2+6fR54LOxWTL3+YBsvvtka4CNrzXJMqZP4XIyJMS3v6IA/sK
         1GHdNwx0MSNsIrdgv/ZpXoupWO47G60RixVJOupJpnVys5QbpSOz2x6Td8OotI7aItBN
         tNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ovNyTQldeq3HvacTbl6Id2BEcR+V4Uma+b5P21Hdyew=;
        b=E4P+eRKXG1j/ihbJ/NRQqXPYsnXVVWQAEOTfc7WdWZ+m/cQglqsMYJDV+xKICGGvTN
         o6cIwtp7E2TnNuCt6Dy3HqzOSQTQcoM0/RVkEqyuamP+TinNQQ0y/ZwwS2AWZF68kv/T
         vun8m2jlxuSDCAwQ9WUAn0rxd2Ch66lNJaO1femGGVV9nlCzPSNSGPlY5fJgc9QMEK/8
         npaQFBng1IioJ2E1z37mzxqlmFp+CCyqRrJvvuRa7GWMfZsrY8bXQjGb/ChEtjyfgAzH
         4hwsy2IgPVPSwmoEK16qcQz0DNRZlHXxFT/t3ne6/uDTErOlZW0J5XEIg28CodL9PZj9
         M9SQ==
X-Gm-Message-State: AKwxytfqIKqlO0dwL8lIyRXpm61oHshR288GZYd68Xny7XmR8pGtCF4t
        iXrmUqkP/EJsQhSyiRc9qEbyYd+E+ahnzjCi2APqgA==
X-Google-Smtp-Source: ACJfBovQ+ss8vffDt5krySkBiOZl7mYJAbAolDIBJXcI5uMZiIWTNDuYEoSNAW3+DHC00QZTpSg54hp8dUdtyj918Zg=
X-Received: by 10.237.38.35 with SMTP id z32mr23263286qtc.180.1515526005931;
 Tue, 09 Jan 2018 11:26:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 9 Jan 2018 11:26:44 -0800 (PST)
In-Reply-To: <b59bd56a-f88b-a65a-263f-2b6d2f57dd99@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-5-kaartic.sivaraam@gmail.com> <CAGZ79kZZf=zSfqFr9EV_Q408mG4cHTEQSOAMC7n_35oKgHJp2A@mail.gmail.com>
 <b59bd56a-f88b-a65a-263f-2b6d2f57dd99@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Jan 2018 11:26:44 -0800
Message-ID: <CAGZ79kZKMKZGWSvPMPHWJ9SeNQSegeiZ3SvMtK+gEYp1dFxYyA@mail.gmail.com>
Subject: Re: [PATCH 4/8] Doc/gitsubmodules: avoid abbreviations
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 9, 2018 at 8:06 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On Tuesday 09 January 2018 12:15 AM, Stefan Beller wrote:
>>>
>>> - * The command line for those commands that support taking submodule specs.
>>
>> ++ The command line for those commands that support taking submodules
>> as part of their pathspecs[1].
>> ++
>> ++[1] pathspec is an official term according to `man gitglossary`.
>>
>> Maybe?
>>
>
> Yeah, I actually did think 'specification' wasn't a the best fit for
> this (should have mentioned that somewhere) Now, the real term came out :)
>
> Just to be sure, that "[1] pathspec ..." part goes to the end of the
> document doesn't it?

The [1] part was just to highlight it for the sake of this discussion;
I would not include it into the man page.

Stefan
