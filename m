Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6FB01F461
	for <e@80x24.org>; Wed, 24 Jul 2019 01:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfGXBru (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 21:47:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38016 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfGXBru (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 21:47:50 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so10962918ioa.5
        for <git@vger.kernel.org>; Tue, 23 Jul 2019 18:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LejtcmHZF1eToQ2SnvEpPB5gJFKsnO1iWinPo4EKAw0=;
        b=b8hQBXB/cOErTQxRXUHYDylrw+H1rLB7rQmkf5LQ8o2R6KWjHqpVduB/kio3Cb/L32
         Z8BFdM1YxDi6G8WMAlWHx76j78a+DVdZUIi2qphkcfNjBl1vDLrG0hYHqc9TY5VaM63l
         0wBV/SR8Tw4hNU4VFoFe3Nmp16h3stQUncOGy3JzvJP9BSZDvZnbj08KuSLdgwtGCyNS
         lyLFSKhgFMwUF8vNEmQXhP1kr492Kgf9CknE27YFDQnhvXev0J2DK2QEAuJTYMjq4kA2
         UYj2D/ebT3AFpAfpEf1NgkkvD7DFYgdH6++FZ55OkumjcaBYgOjTbNLwQHyi9hA7HlrW
         eTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LejtcmHZF1eToQ2SnvEpPB5gJFKsnO1iWinPo4EKAw0=;
        b=bzJ5A7pfPo12BZ5bWrQS6/zOLQ7kYYxIU9gKBu/VSS/rURlbFBLLExWZMDIHy17MoL
         6hdCiOXguQeVlK7gTR7rp3xmHhKN8ojSb6UJw3uGXqMCcXhGGUjXWGp9X7HJKHXEEDkt
         I+Mx+bLl8MjXinNVkrJXEObU2cdBE6AafCV6LSnT98Pw4pmjm1F1S+uyllwb87tuL2Xj
         yzJKMk6jTfntPaHsPpL1/z9vCHpxTweZgl2tk1IkG4wzGjxUcl91o8yMGi0DN0FwGD+G
         FfN57KDtfvjQ62k+5xRNWRvwx7ZYuXHBndFuIQk4XtydsbV7bCK0PU3dq6KXArgf2pCZ
         himw==
X-Gm-Message-State: APjAAAXbLwy3iEiYX47qKw8SoWuJqRA0ra1J/uVovD4Ogj9zqd04b38U
        6Hi4SqqsbBCaD45uGi19W+qAFnSEbwM0OuBWzbo=
X-Google-Smtp-Source: APXvYqw/UgmUdNmcj0xn4xvJJko1PMVaA+sny2GO+iqNsgG+dLgCxhDxPOoJpcoK3Zg9r84xAAL/nb26Lq7dl3jVic8=
X-Received: by 2002:a05:6602:220a:: with SMTP id n10mr9974250ion.205.1563932869760;
 Tue, 23 Jul 2019 18:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190721183115.14985-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet>
 <87muh57t5r.fsf@evledraar.gmail.com> <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 23 Jul 2019 18:47:38 -0700
Message-ID: <CAPUEspgytjywYHywGT4yAwYpQbMUicN4bpHfoD+M_HMe8YdPtg@mail.gmail.com>
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 23, 2019 at 5:47 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> So when PCRE2 complains about the top two bits not being 0x80, it fails
> to parse the bytes correctly (byte 2 is 0xbb, whose two top bits are
> indeed 0x80).

the error is confusing but it is not coming from the pattern, but from
what PCRE2 calls
the subject.

meaning that while going through the repository it found content that
it tried to match but
that it is not valid UTF-8, like all the png and a few txt files that
are not encoded as
UTF-8 (ex: t/t3900/ISO8859-1.txt).

> Maybe this is a bug in your PCRE2 version? Mine is 10.33... and this
> does not happen here... But then, I don't need the `-I` option, and my
> output looks like this:

-I was just an attempt to workaround the obvious binary files (like
PNG); I'll assume you
should be able to reproduce if using a non JIT enabled PCRE2,
regardless of version.

my point was that unlike in your report, I didn't have any test cases
failing, because
AFAIK there are no test cases using broken UTF-8 (the ones with binary data are
actually valid zero terminated UTF-8 strings)

Carlo
