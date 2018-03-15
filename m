Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC3C1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 14:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeCOO5R (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 10:57:17 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:36741 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbeCOO5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 10:57:16 -0400
Received: by mail-ot0-f177.google.com with SMTP id 108-v6so7161222otv.3
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YpyyUvlEbmvEvbjBaWI1vD148I7FmvM9g6xoq0FzZYw=;
        b=NwtwkxdGKRP0h08iQ1mUfFYr+PoiLTlpPFslzl2YzR43u6scu1wqr0H/fxYmOmJCXI
         fjdHD46XtHtoViV9cNjFOP8IWSwb3vZqh8Imgy2tcxlQXLiGbYyT6bWRlrWDnK8qvqyz
         0+6KtA5mQJooGXY+O5o/IIlYvSrNG2D1Jen1grCskrh6dL312L8yBXqrj5vGmLuhim5d
         0xLDWxmZUCJf76o7Ua+/ALQV08KdSrqJGC1v+12Azs9dMk20tEm3awg3t7V/2M0VJD2D
         IFaX9bVbWSegCiAHGMlJVkJUlnckNLk63oPpMIwJDGyMpewq23JMP9k9Xtad/dW3KNze
         Po2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YpyyUvlEbmvEvbjBaWI1vD148I7FmvM9g6xoq0FzZYw=;
        b=iJbC9lUSsOr1VsfpLY0+l/ogu26mNAw8VFQ7lymqeRYpz0xpvFt0vcQhIZYoBsn8pQ
         TARVlBu6QjNvSTmKko0+JV/HMOAbocVOl97HU9Ffs+J54/pWcHTiFd+a+5wh6ZrqaGsN
         Yy0WR03YY+3F/C29jVN1zlczVrZuLfFCobk3W0qWMEqJs9SWeFMUQzrciW+KOsiJ1Z/C
         gnCZsPHE5ZpW++HNm+Q88V6CezQk+hwKTZaycsyDhoPYWeZWPdFQ3DYnfZ596upi610+
         R7zc7VJP4P0xfsFlouosb4LnN0KGYHx4GZ2Tj5MUeaRhbmebOz/sZDc9CAmF5GLYsYly
         E78Q==
X-Gm-Message-State: AElRT7GwGs4f9xoputhg6SvALUr/JUiQYkXKMOXf7mqTSAmZHvuaGALI
        XH1L5KDXZru4oDTgpo/6ME2RpDQltEXQUsf3wUw=
X-Google-Smtp-Source: AG47ELsUPtDmqLw1nNLWewVc1z54YN4+O2n8fOR1ysk+NDIk6MVGLNXbkJL/44afiry+sVDOsvHAVUrdnm6yYRi//2o=
X-Received: by 10.157.40.18 with SMTP id m18mr5376093otb.245.1521125836244;
 Thu, 15 Mar 2018 07:57:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:34a2:0:0:0:0:0 with HTTP; Thu, 15 Mar 2018 07:57:15
 -0700 (PDT)
In-Reply-To: <20180315141220.GB27748@sigill.intra.peff.net>
References: <20180315130359.6108-1-michele@locati.it> <20180315141220.GB27748@sigill.intra.peff.net>
From:   Michele Locati <michele@locati.it>
Date:   Thu, 15 Mar 2018 15:57:15 +0100
X-Google-Sender-Auth: MiBBvnW0SO64pRc0bBd5ASm7yWM
Message-ID: <CAGen01iZTs1FC3tsuMF9SAS0QcKxN0Sk1CPeZ+YNyh5X8sdgtg@mail.gmail.com>
Subject: Re: [PATCH] filter-branch: return 2 when nothing to rewrite
To:     Jeff King <peff@peff.net>
Cc:     Michele Locati <michele@locati.it>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-15 15:12 GMT+01:00 Jeff King <peff@peff.net>:
> On Thu, Mar 15, 2018 at 02:03:59PM +0100, Michele Locati wrote:
>
>> Using the --state-branch option allows us to perform incremental filtering.
>> This may lead to having nothing to rewrite in subsequent filtering, so we need
>> a way to recognize this case.
>> So, let's exit with 2 instead of 1 when this "error" occurs.
>
> That sounds like a good feature. It doesn't look like we use "2" for
> anything else currently.
>
>> ---
>>  git-filter-branch.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This should probably get a mention in the manpage at
> Documentation/git-filter-branch.txt, too.


Yes, I agree it would be useful. What about this addition right after the
"Remap to ancestor" section?

EXIT CODE
---------

In general, this command will fail with an exit status of `1` in case of errors.
When the filter can't fine anything to rewrite, the exit status is `2`.


--
Michele
