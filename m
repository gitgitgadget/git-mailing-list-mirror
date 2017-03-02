Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD7091F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 16:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754211AbdCBQDn (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 11:03:43 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34203 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754774AbdCBQDV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 11:03:21 -0500
Received: by mail-lf0-f47.google.com with SMTP id k202so35752464lfe.1
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 08:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MiHJCMNUKWXvZaZLON1wWX79CuAp1dxQcQNNGwCrZC8=;
        b=FMznBtEv8Mj0FBLx/Kc6TAw/b6zS6z8qHB+dAE3Yf4MblmkmO3rsutHW+EJ/46XwNL
         Oc2ROC39e+66cg+uRO9C3IHnMTNb4+Q+qq0vMYuolQB8iu6FE6Lp+LtYQRNSk53pC8jF
         tPLL4voYz7cS3GILUahJlaosdmwFCoblGZ4urd7QTagBR+8DQdLzSYKKFrx5NVAH3POX
         RX5Bqu7pQltVD5r38RaIWm4n+1oSr9RGDsV3wMKavam6h/+Z7kzvx9na2u6EoKgWut+7
         fZYfzwiLEMjua/4QFZAxjPNVjl2DqGErOYtlkPhPZBt1ROF4eBsbscu7LNb9oOO14Pu8
         AjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MiHJCMNUKWXvZaZLON1wWX79CuAp1dxQcQNNGwCrZC8=;
        b=hm9LLCLoHGK6TSrnJAP9Cb07ulvc2hBPKIwSp4vsq3gBpWTY8N4IJ6dg/liv/U5zGz
         XAXN3SJS/1OChCmyj4ePGBwUbH0T3qQKXdUBQhqsMB/0AEDRWiDa+t+z4ploNBjOcSOV
         23IpCUoc2u/C2giP7zcfXYzBmNLNMNlI7y4+e6RBFB0+Yl2dOWG5exjIu9IQzVFOWV/G
         8XttXBkQ7oXOdEPPQCUMRcQspu5kyBDcbNbcXFyYhFhOrkOu5lZS85n0D0MlGhiYgDo7
         y2ADq2NItOY8yPEo1AU2D+Myn05/h1U57PCmOHdFc+dYkRfDe12rC7Z4Bp4C7zGjjqHE
         GDeA==
X-Gm-Message-State: AMke39nQqMgC1CZbh10nCf6c5wzfK37wbhvWTLB6zUqLZ+mghd0wpsjJqZBs5NviDkIImpFwYmWbaWUBFVARNQ==
X-Received: by 10.46.9.76 with SMTP id 73mr5296662ljj.128.1488470008945; Thu,
 02 Mar 2017 07:53:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Thu, 2 Mar 2017 07:53:28 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1703021519330.3767@virtualbox>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
 <20170302105157.59791-1-larsxschneider@gmail.com> <alpine.DEB.2.20.1703021210170.3767@virtualbox>
 <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com> <alpine.DEB.2.20.1703021519330.3767@virtualbox>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 2 Mar 2017 16:53:28 +0100
Message-ID: <CAP8UFD0MDVMVOG=bbcEeRbKX+aTNKfLd9yZn5zW7T9KxeRsebQ@mail.gmail.com>
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 3:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
>> >> +set -e
>> >
>> > Is this really necessary? I really like to avoid `set -e`, in
>> > particular when we do pretty much everything in && chains anyway.
>>
>> Agreed, not really necessary here as we just invoke one command.  Out of
>> curiosity: Why do you try to avoid it? I set it by default in all my
>> scripts.
>
> I try to avoid it because it encourages a style that omits helpful error
> messages.

Yeah, we prefer to define and use a die() function like this:

die () {
    printf >&2 '%s\n' "$*"
    exit 1
}

do_something || die "meaningful error message"
