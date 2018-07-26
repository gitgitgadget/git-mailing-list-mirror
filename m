Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C0D1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 17:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbeGZTCK (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 15:02:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33985 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732036AbeGZTCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 15:02:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so2541320wrt.1
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1quPanXw5xMS2vZfpFisU9pgnNnT0kpq3dRcH7PIkOY=;
        b=hhWmhrjSp1FqztDqNj4EcmpcE1Z8U1CstTKLW8J0fwaC3+G8KPHiNjwagDj4h47yMU
         sJ3G3DUlmq6JkN1EEJ7/1Jb6Au9vA2Ru+fye3uVOhl0+K9xVBcnaBxaj8qZ1+PThfBpu
         0PK1lxMLinYkIm3NwOwtIDv0nEbbvjwo9OndvzDK3FgtYFkrfn0WFTB8f+MWWSI4UDTx
         R/XNlFI6b6KOTGY4OAXWGQozPegJ2EDeUxJ8ijfRPEy1RrdaL267eyzaEjdq+B75AuMW
         Rh8ymnrtbE7Z7bxl+VER1qyGC9y6BJDTAfaklf/PIiWrnrbyFpxDyEX5f8mB9R3cETZK
         HHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1quPanXw5xMS2vZfpFisU9pgnNnT0kpq3dRcH7PIkOY=;
        b=bNdeVx/Rm3JcGFsMqNZ/JP7Kp09HC8Iu7ADqffKvjcbMQ6cMyujnh7hRPq3H+zz7qH
         ZanHhvnCnWyu1np/S9hnNAWiE8okLaabEiXeeQ45GyR69tEcd4/L31Kyvd3jZbABRJg/
         ZvLSW4bAoQ/qLt+uqXsvOqFUklqRXPkvh/ZcccsWbkArOA3mf9HualR3m8y47/NKfDeU
         /GyWC0XpJ6/e0cZZTrXpdqnUrLm6VEDvPzkrHI5UmuSpfZej3IQymhmwxRKG5rKfH05H
         hBvoU5kFHZ9voxauFJ/7Cfd6Gx57vvD5UBPKH21zKNW7lWIXogvWVdf0XD5rpDiqWQnu
         6/WA==
X-Gm-Message-State: AOUpUlEF7dKW+hEsvcSYNRMG/zVnQUPmvPmrOiL8HKA2b0xiQrURVq/2
        TLnSeSjId5lZFXfHovudD30=
X-Google-Smtp-Source: AAOMgpf2m2j6qpRmHrxptF1UVegeblGFf+NugsSUl8Of7qV43sygJoM3/B1kzHXtON6QVsZpB5yOIw==
X-Received: by 2002:adf:fa45:: with SMTP id y5-v6mr2475879wrr.138.1532627057245;
        Thu, 26 Jul 2018 10:44:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x184-v6sm2710235wmg.24.2018.07.26.10.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 10:44:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     knu@idaemons.org, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script properly
References: <86a7qwpt9g.knu@iDaemons.org>
        <xmqqa7qww6uk.fsf@gitster-ct.c.googlers.com>
        <CAPig+cQWA+sE3iH89kQGWgS+0HQDK-V5++S0+F6_dpfOCfXxDg@mail.gmail.com>
        <xmqqpnzlla1p.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807261347040.71@tvgsbejvaqbjf.bet>
Date:   Thu, 26 Jul 2018 10:44:15 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807261347040.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 26 Jul 2018 14:07:07 +0200 (DST)")
Message-ID: <xmqqbmatrixc.fsf@gitster-ct.c.googlers.com>
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
> On Tue, 17 Jul 2018, Junio C Hamano wrote:
>
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 2d189da2f1..b0cef509ab 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -81,11 +81,13 @@ test_expect_success 'rebase -i writes out .git/rebase-merge/author-script in "ed
>
> You missed a very long line here.
>
>>  	set_fake_editor &&
>>  	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
>>  	test -f .git/rebase-merge/author-script &&
>
> Why do we need this, if we already have an `eval` later on?

You are commenting on a wrong version.  Comment on the original.
