Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6517215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756218AbeEASKV (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:10:21 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:46216 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756175AbeEASKU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:10:20 -0400
Received: by mail-qt0-f174.google.com with SMTP id m16-v6so15434057qtg.13
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WQqLWOz56UnhrX8JI8NHhwLoyvIpYb1ZsNFN4udVc+U=;
        b=uiM1nv6wk8ESGz3wk3wwUpwOYYzOymG7dYB5SWdAHivHHlbmqWSvBAeCMJwA4YNvqH
         Hb2lnBhn7jXMbbe0oE1vscRqhvSC8AyS4S/2dTqnJzgp0CbJ+0P/BtDWEHuCRaUMahvA
         xJW899U3oHKSTlDyz5bD0TyzGDbunbgNa/lQeTKNYIQMsL5b6ni4bR3YQx2bj71glIT2
         mKvdONbnW4eE/lft+Ge30rMBjeZLQx91HQKu2//trj+UI9VWb9VUvmC37zuL7f3iVzBI
         SqVWvGrIWuhrjhdSk4h4HhQMm2tsA/b+sDR5kR5Pgh0xqm+kFWivvP4Ie54mUKLlzRKb
         1ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WQqLWOz56UnhrX8JI8NHhwLoyvIpYb1ZsNFN4udVc+U=;
        b=Km14H7M7KFbRSESpTinrPAgAr8VnViby5mB/Z3txPtD+24L1lZ+q8DE9EydVLzZnbT
         M5jFLRjwK+Vf9RwaOesxfyh3W9stpPkUZTRATiuowFd47m1LtNO2bSW2k7bldYBjrCp6
         TzzgABPMjxZOltnukNkGR2TpPKslSz/q6tlsYBVQTEl7BfRtvn/tVC55ZrPgY463whPi
         i3xa+I4nE7gOhg4MBquANOMGMHVemyXun9VXtOsONnbSk8gaSqEJZnUGpTY1boQywN3B
         tzyfF/QKXJwMPnVwZpAh4JHtMMH4ciI6AeQXug77xZ0EChLDa9VRT2RmZmOS1jVBnaR6
         C/DQ==
X-Gm-Message-State: ALQs6tCAjfsFGFi/KXyMNx+g4HBWA8Um8lfxH4U6huTGr/u1HKdLMIiE
        59DMUM2mQvG5wYZS5gjk3FWzyLDHW38+a3QsBLQ=
X-Google-Smtp-Source: AB8JxZpzUqX6LABGcKof/LHTLyuqSN96zuAsNdx5+idxN39E0xPO4lni1cOarbNTZId8t9ZvLC0lSgikH1OpheJCUPo=
X-Received: by 2002:ac8:17d1:: with SMTP id r17-v6mr13781772qtk.314.1525198219872;
 Tue, 01 May 2018 11:10:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Tue, 1 May 2018 11:10:19 -0700 (PDT)
In-Reply-To: <5cd81e58-7cd4-f5df-14e8-2ba3d221e128@kdbg.org>
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com> <918c69be-89ce-c66d-92ee-4821e9412793@kdbg.org>
 <nycvar.QRO.7.76.6.1805011351330.79@tvgsbejvaqbjf.bet> <5cd81e58-7cd4-f5df-14e8-2ba3d221e128@kdbg.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 1 May 2018 14:10:19 -0400
X-Google-Sender-Auth: 1T0DOoD8vempWMTf3hQlDMcBkgA
Message-ID: <CAPig+cS9pKSXG-9uZo7dhnz2yAnv9VnnuS_B-DMG2cWmGuKcow@mail.gmail.com>
Subject: Re: js/no-pager-shorthand [was: What's cooking in git.git (Apr 2018,
 #04; Mon, 30)]
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 10:58 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 01.05.2018 um 13:57 schrieb Johannes Schindelin:
>> On Mon, 30 Apr 2018, Johannes Sixt wrote:
>>> Am 30.04.2018 um 05:25 schrieb Junio C Hamano:
>>>> * js/no-pager-shorthand (2018-04-25) 1 commit
>>>>    - git: add -N as a short option for --no-pager
>>>
>>> I find -P is not that bad after all.
>>
>> To me, `-P` would suggest the positive action --pager rather than the
>> negative --no-pager.
> >
>> Your use case is quite the corner case, I hope you realize that, as it
>> seems that everybody else is fine with having -FRX as default options for
>> `less`... And with copy/pasting from the `less` output. So introducing a
>> sweet short option for --no-pager, for the benefit of maybe even only one
>> user, seems quite... unusual.
>
> Given the ambivalence (or inconclusiveness), I retract this patch without
> offering a replacement for the time being.

Although paged output is generally nice, I frequently find myself
typing --no-pager numerous times during the day, so I, for one,
welcome having a short option (and would be sad to see this patch
retracted). As with Hannes, I too find -P a reasonably intuitive and
easy-to-remember short option.
