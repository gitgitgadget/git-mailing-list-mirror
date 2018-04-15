Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBB21F404
	for <e@80x24.org>; Sun, 15 Apr 2018 21:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeDOVN4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 17:13:56 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43060 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbeDOVNz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 17:13:55 -0400
Received: by mail-wr0-f196.google.com with SMTP id y7so20662508wrh.10
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VxA9m26uSDcdjuxtTGK5ToWgEhhnMS+YyxTb2Q0u3Vo=;
        b=jllQwCrIly3c27jaWrD389ywX7fQG8/SCfcpJe9Mx4LvW5OZOHSsNFm1TEjEOsc8+o
         ZqlBOOKOp/V1ZflDJ2WZSWcLn1KE/horVaoxXyNTZhKjAT1WhytHhylb88bjGwpF8fxF
         mWzp4WG/9i1HLjnEMhFpTZF4CbroEnUDXagRHHCBsqCnv37uXv+4mexYSnxxrqkAHy5n
         IZGTQpZYRGTywZZTZp/3Xe2qu13Pf7UKHIpeF4goAjHDgs8MgRtFNP/ST7n4iTESmbvQ
         pXPdJ76ywWRldWeq1xSyryKvofpWsqbI/Cbv8XN9J9pEz0gaZ+YnqQfXt/AKzbwMOzPM
         TrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VxA9m26uSDcdjuxtTGK5ToWgEhhnMS+YyxTb2Q0u3Vo=;
        b=W4E9IWTltFEXwHhH5bOH311eNcpR/Tz3EjjxNf9p0yrFNQfrRZGhnsKFUOUpMjs7Tj
         Haroj0rRujLOEbT1PfwKImbDa9+aiHqr5I66qUHzePWFowvsr5YzqCIBC8i9V1eXf992
         ucBV1yUSuiA18UbChg2Hv38+Im2/zMyTaGqHpwnn3PgXBN/9Pr49EIF7UIevV4XZiGnw
         eRgI+KP/Kc9AlrYwR3R9rcYcomN1iJxZSfCUMDq5OPM/ojBuOB4c7jZ1xMP6xRupZrs9
         K9krSrlANNhtqTciFWToWli+lKM7lDYddoadIPiJfNfk75xpWyDGturDjG3FqFSJlBPd
         mfqw==
X-Gm-Message-State: ALQs6tAatriYrHwQTxyyrxo48iSwfvHwdvAKFWAuj5wpCSEHwwEE5zZe
        yiFPKeLguCOpMIG96ipsVjQ=
X-Google-Smtp-Source: AIpwx49ytx05I4//Y5ltgnqynO4zjlz/iiXWzuYDTLzPL+pEulG7lGBc/WPXGwsatOTn6th6/Of4DQ==
X-Received: by 10.28.143.199 with SMTP id r190mr8041881wmd.132.1523826833675;
        Sun, 15 Apr 2018 14:13:53 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y9sm12972850wrg.46.2018.04.15.14.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 14:13:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Doron Behar <doron.behar@gmail.com>, git@vger.kernel.org
Subject: Re: Feature Request: Add diff.word-diff <mode> and perhaps diff.word-diff-regex <regex> configuration options to enable always using word-diffs in git diff
References: <20180414200227.b35bdkir6ygio5is@NUC.doronbehar.com>
        <87604tft6p.fsf@evledraar.gmail.com>
Date:   Mon, 16 Apr 2018 06:13:52 +0900
In-Reply-To: <87604tft6p.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 14 Apr 2018 22:07:26 +0200")
Message-ID: <xmqqbmek18bz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Sat, Apr 14 2018, Doron Behar wrote:
>
>> I've just came across the wonderful command line option for `git diff`:
>> `--word-diff`. It could be great to have a configuration option that
>> will enable this feature by default when running `git diff`.
>
> Do you know you can do:
>
>     git config --global alias.wdiff "diff --word-diff"

Correct, but it is a "you could instead do it this way" that is not
accompanied by a "you do not want to do what you said you want to
because.." answer.  Having the latter is often helpful to learn why
the suggestion is actually not a mere "you could" but is a "you are
better off doing it this way".

Even though it is discouraged, people script using the Porcelain
"git diff" command, and once users of such a configuration variable
is used in Doron's fork of Git, those scripts will break for them.

Using alias like you showed won't have such a problem.
