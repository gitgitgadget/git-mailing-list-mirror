Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BF891F453
	for <e@80x24.org>; Fri,  8 Feb 2019 17:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfBHRZp (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 12:25:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40713 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHRZp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 12:25:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so4228901wmc.5
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 09:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b5ZPUVnJnHjFy06TAd1/AdZzIOaEK1jDJEUPBfwtKvg=;
        b=k4vXv7pe4vSz5cUqG4bcasyGh5alivRDeh9XsZQX57heveGdmFXjCzOcdztMC/Q8yf
         t8bFFxIBvQzxTXSWyZNCLmGM7iXZmVWBSj3TIls4jL/XUv3t8DLy7n37r/sxIU9KBxzO
         xE5DFNPymAMKmYrLJ3mAUyyt6a+S7kr27Szxaauqr7vhnT5yl4fy845+zJk2ZjmpgtKd
         welIlr3Jb66+WufAnxHO6976I7EubzqNtgaRU+1rY8udWe5x0YBZGD/C8uPpkOKokweH
         tVHq2T/YHfhXAcMBnhrBw+EnKc/nAvhbe3SfRt/W66vyGF3VrYKL0CsIN+7xRR7elmYB
         tvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b5ZPUVnJnHjFy06TAd1/AdZzIOaEK1jDJEUPBfwtKvg=;
        b=fUsbRVJivwy9I4SxQrzpbq3SdU258qfl6K+FuisP0gnz4SaFvYGC+JGA/YHdE1UbCE
         xz0HX6haXeInzTUvt+MoN/egPrdujOLfZnDSmB77MWEWkVGtA1g8C9l4+Wm28KyDPeW3
         lotoNwnWsH4+1Rchcgv5OTmIAztmJkssREzKwlFovH3ikOyE0XFmjUvbwgAJTENd2GeP
         TV3GonvnFnJAhNB86FYeluHyw6OcK2a2bIIamHVC0kFrojU6TMr+sQeXzEGRmlgSi/+w
         6ETPR0YMpwNBS5czb9d5ItX0Ujdpp1+ltjZK+j+FqEmtczFJeYSRKHqmJJUeCGJb+haW
         q9Kw==
X-Gm-Message-State: AHQUAuYH7MHuiY/bwwBzhRBUhSNnK7yhMey9Evc+Y9Rm5u6mso7s8uN7
        mC8UMAdvY+Q5533fcR0yqBU=
X-Google-Smtp-Source: AHgI3IY8bdHwTlifo4EzCj4yDc1vNZDOMB1gNzdeEhvkk269Rd0PWWeO/stzsAa2vnjBPOAost2kSA==
X-Received: by 2002:a1c:a401:: with SMTP id n1mr13033508wme.101.1549646743371;
        Fri, 08 Feb 2019 09:25:43 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t4sm4111039wrb.64.2019.02.08.09.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 09:25:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: make sure we build Git parallel
References: <20190207183736.9299-1-szeder.dev@gmail.com>
        <xmqqbm3npgox.fsf@gitster-ct.c.googlers.com>
        <xmqq1s4jpgh6.fsf@gitster-ct.c.googlers.com>
        <xmqqsgwzo0ib.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1902072331060.41@tvgsbejvaqbjf.bet>
        <xmqqh8dfmawn.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1902081110310.41@tvgsbejvaqbjf.bet>
Date:   Fri, 08 Feb 2019 09:25:41 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1902081110310.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 8 Feb 2019 11:10:54 +0100 (STD)")
Message-ID: <xmqqva1ukx9m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 7 Feb 2019, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> >>  
>> >> +# Clear MAKEFLAGS that may come from the outside world.
>> >> +export MAKEFLAGS=
>> >> +
>> ...
>> I meant to clear it at the beginning, where I "export MAKEFLAGS=".
>> Did your MUA ate the equal sign at the end, mistaking it with part
>> of text/plain; format=flawed or something?
>
> I could have sworn that there was no equal sign yesterday.
>
> Sorry for the noise,

Don't be.  Mistakes happen and watching stupid mistakes for each
other is part of the teamwork I very much appreciate.

Will apply on top of Szeder's fix.  Thanks.
