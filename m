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
	by dcvr.yhbt.net (Postfix) with ESMTP id DC1FD1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 20:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfGYU0x (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 16:26:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38428 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYU0w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 16:26:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so52098493wrr.5
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BLiE3h7w0lrtoH2alDoIlSMS0yIullXJIvPWkEo1WYE=;
        b=BblVQMU1V4wj/sWyinbcbx2kMt1/V/a97db2eoNfBVT6epdMeXcy7S2Cpunwn7H8Bs
         a+dvPFQiVgFVgcvInLmLSobsggUG3msIWQD4wTXl4S3Q8yvzBf52xIeeK7gEhVinpw35
         ACxFz2cFV9MdIwaLnIRSDJ1CIcjD0SfuUF9aLw2DFa6d7LsA1va+dwbKClKgZL+euD2s
         u7F44Bz0E/Ht722VfCTp22eNiArwYKTqx+OFqHf9m0Jj6x62boga40sECYO1GHJyuwFM
         xLPEq/knryeyZFnXThKCSKK6pIgZmhJPDhugoNjOvdIxxqkjdMnAFoth7ZXTg/8/KtJU
         7dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BLiE3h7w0lrtoH2alDoIlSMS0yIullXJIvPWkEo1WYE=;
        b=HnGkZt+iWsc/pPWJOjG6bm/s6t5aLmsh1iQR6ar9UBP+MbfCaxcaY8olqNzUP3zIdY
         Mm3lrzUc65PiaLq525jvwVaD/2C72OJUbwjowAZxoNHj5Vo8rN+V04NqwNtNslatgUyo
         43Wfc9T4PO0H+vH65zQ4fo8u4u97Cmti6OSvpmE38DKrhHPatSjFNA/bovU8b0bBwSgF
         Vv6GjOP9mW/mZIcu9fPpJX8F9JEmh9MMq6eEVgTpl7rTp3HHuwUYdXkRl+iEaYORPCWK
         MYruKb14zqUdDEXLGocmQA5covJaAM89Ph1SCiOtAKxRjIIHG5+LC0kHf/BC/m/WceUb
         cufg==
X-Gm-Message-State: APjAAAUMYycKGCDQXX+uUJTGWj7DoBb2TA5ACdkIe9p9Ev+EwQFJl//P
        6io33WVnP7jdmG3Bd/RJrwg=
X-Google-Smtp-Source: APXvYqy9GY5TxCyn/K7r9OGaxXXbLGXmENiZGl3DBaSUGpL8EDj38wEUilYJwTHpO8NfXPj/ARcuhw==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr79535570wrj.10.1564086409798;
        Thu, 25 Jul 2019 13:26:49 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-20-189.w86-222.abo.wanadoo.fr. [86.222.19.189])
        by smtp.gmail.com with ESMTPSA id o11sm46520654wmh.37.2019.07.25.13.26.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 13:26:49 -0700 (PDT)
Subject: Re: [RFC PATCH 0/9] rebase -i: extend rebase.missingCommitsCheck to
 `--edit-todo' and co.
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
 <ce6bdffd-0a04-803c-4a1e-0959342db01f@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <69ceed35-ced4-51e7-d724-1818ae45e9a6@gmail.com>
Date:   Thu, 25 Jul 2019 22:26:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <ce6bdffd-0a04-803c-4a1e-0959342db01f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 24/07/2019 à 15:29, Phillip Wood a écrit :
> Hi Alban
> 
> Thanks for working on this, it's great to see you back on the list and I
> think it would be a useful addition to rebase. Unfortunately I'm not
> sure about this implementation though (although the early bug fix
> patches are useful in their own right)
> 
> On 17/07/2019 15:39, Alban Gruin wrote:
>> To prevent mistakes when editing a branch, rebase features a knob,
>> rebase.missingCommitsCheck, to warn the user if a commit was dropped.
>> Unfortunately, this check is only effective for the initial edit, which
>> means that if you edit the todo list at a later point of the rebase and
>> dropped a commit, no warnings or errors would be issued.
>>
>> This adds the ability to check if commits were dropped when resuming a
>> rebase (with `rebase --continue'), when editing the todo list (with
>> `rebase --edit-todo'), or when reloading the todo list after an `exec'
>> command.
> 
> I'm not sure if we really need to check the todo list when continuing or
> after an exec command.

In which case I don’t really understand why there is an `error' mode if
one can completely bypass it with `--continue'.

> The official way to edit the todo list is to run
> 'git rebase --edit-todo' and I'm not sure if we support scripts writing
> to .git/rebase-merge/git-rebase-todo directly. If we only support the
> check after --edit-todo then I think the implementation can be
> simplified as we can just write a copy of the file before it is edited
> and don't need to check .git/rebase-merge/done. Additionally that would
> catch commits that are added by the user and then deleted in a later
> edit. They wont be in the original list so I don't think this series
> will detect their deletion.
> 

True -- but with this solution, if a bad command is introduced, there
will be false negatives.  Given the pitfall of my solution, this should
be an acceptable trade-off.

> At the extreme I have a script around rebase that runs 'rebase -i HEAD'
> and then fills in the todo list with a fake editor that adds 'reset ...'
> as the first line to set the starting point of the rebase. I think
> dscho's garden-shears script does something similar. Under the proposed
> scheme if I subsequently edit the todo list it will not catch any
> deleted commits as the original list is empty.
> 
> Best Wishes
> 
> Phillip
> 

Cheers,
Alban

