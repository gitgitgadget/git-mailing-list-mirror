Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E651FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 14:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933708AbeAHOqd (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 09:46:33 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:38069 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933601AbeAHOqa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 09:46:30 -0500
Received: by mail-ot0-f179.google.com with SMTP id h2so9391589oti.5
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 06:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JfYIYzvn9iSU688mTplaegXir87+YNbE4dyWcZSwEzs=;
        b=a8nasD5H8pUTswDhK2H9Jn7+Z0teUVy9EBXEeRmKfxpNWMERBHLVSkStI8xR5p8k7m
         4M3M+tbNDu6szKdM86jFQgSgLW/5mEwzuxbfwdcYHHFWjOCEGJ9Nu5xvHx0Z1VqStEZb
         yTadgFQ4SP1VcSEPK5ATiPMFQcvjJCewE38KmYtBMCmRfRaquJaRmn/8425EFrZ+PcaA
         A4siR9+NG4Jur8qAkBJUUKY3nZIJh3M5Bn3hB+YJ/3X50nC8I6G9SQRQuJi4p2P32DUy
         FdCtwvBR69jz0XBNeKtRA3Opc9ngbKjZnBa+aID3vlKIv1bpA8iHL1qIsRVyGZYQYFjy
         cm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JfYIYzvn9iSU688mTplaegXir87+YNbE4dyWcZSwEzs=;
        b=k1pKbDBhR7dv0srmZpHy6vU+WM2uPUPp2VmqK6jZK398cxF5XYy7hBEDY+SDVaM1sG
         saN7zkpFH4EkKp2hz+115CEjYJeiFPIaw3FGxgHeCdQk9KKbFVMUKzXkzijJF8CLcOC/
         bJJ4J1MZMJ5HFg43C6ai+i1f+28MVMclgEQMDbqoXVdLnGdA9stdxOrKAar/+WQH885j
         wp/U4cbI0Z7bsmafqUN37G+/C91gQb2ANRUCL7qCYtZSAfSEluC4K5nIYIjHwUPDEfGu
         ApwVWw8/Dkl7t38ni4c52jVtFzyiXoSX7EltQniWO/VB3B7kK1++k385WwmYYXDOU64h
         s+YQ==
X-Gm-Message-State: AKwxytdH7A3ssx7l1rtEyf9lb2N2l9zcccsw+jpc/r0xhK+aktxMAhzE
        9CnCBxG1J/5qvJRYCo6vMaTE2quj6jrBRq+94B0=
X-Google-Smtp-Source: ACJfBosWiLGmYbr1WzgpIXs9fk6x12vOlmXjyc6T5ZZU9yD3+nrB/pwkHkt2JnYK66le6WK9dxHtupF6MIfnnduzeH8=
X-Received: by 10.157.13.233 with SMTP id 96mr2455357ots.331.1515422789887;
 Mon, 08 Jan 2018 06:46:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.73.21 with HTTP; Mon, 8 Jan 2018 06:46:09 -0800 (PST)
In-Reply-To: <CAJs94Ea52CcNvBxXVeZLvgsaS4YPiXaeDvRm2zUopoLVowgm+Q@mail.gmail.com>
References: <CAJs94Eas59UxZ+490AUSOuB37i+JBEvbCnGBMVpKi1G469OTbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801081452290.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAJs94Ea52CcNvBxXVeZLvgsaS4YPiXaeDvRm2zUopoLVowgm+Q@mail.gmail.com>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Mon, 8 Jan 2018 17:46:09 +0300
Message-ID: <CAJs94Ea_Kf5RFMuPreBOGYEjhECdQP2F7m=-wDkf9xRnQFPfhA@mail.gmail.com>
Subject: Re: rebase preserve-merges: incorrect merge commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-08 17:42 GMT+03:00 Matwey V. Kornilov <matwey.kornilov@gmail.com>:
> 2018-01-08 16:56 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> Hi Matwey,
>>
>> On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
>>
>>> I think that rebase preserve-merges algorithm needs further
>>> improvements. Probably, you already know it.
>>
>> Yes. preserve-merges is a fundamentally flawed design.
>>
>> Please have a look here:
>>
>>         https://github.com/git/git/pull/447
>>
>> Since we are in a feature freeze in preparation for v2.16.0, I will
>> submit these patch series shortly after v2.16.0 is released.
>>
>>> As far as I understand the root cause of this that when new merge
>>> commit is created by rebase it is done simply by git merge
>>> $new_parents without taking into account any actual state of the
>>> initial merge commit.
>>
>> Indeed. preserve-merges does not allow commits to be reordered. (Actually,
>> it *does* allow it, but then fails to handle it correctly.) We even have
>> test cases that mark this as "known breakage".
>>
>> But really, I do not think it is worth trying to fix the broken design.
>> Better to go with the new recreate-merges. (I am biased, of course,
>> because I invented recreate-merges. But then, I also invented
>> preserve-merges, so ...)
>
> Well. I just checked --recreate-merges=no-rebase-cousins from the PR
> and found that it produces the same wrong result in my test example.
> The topology is reproduced correctly, but merge-commit content is
> broken.
> I did git rebase --recreate-merges=no-rebase-cousins --onto abc-0.1 v0.1 abc-0.2

Indeed, exactly as you still say in the documentation: "Merge conflict
resolutions or manual amendments to merge commits are not preserved."
My initial point is that they have to be preserved. Probably in
recreate-merges, if preserve-merges is discontinued.

>
>>
>> Ciao,
>> Johannes
>>
>
>
>
> --
> With best regards,
> Matwey V. Kornilov



-- 
With best regards,
Matwey V. Kornilov
