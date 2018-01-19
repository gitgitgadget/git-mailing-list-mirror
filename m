Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6BF1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 21:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932305AbeASVst (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 16:48:49 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35991 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756461AbeASVss (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 16:48:48 -0500
Received: by mail-qt0-f175.google.com with SMTP id z11so7364395qtm.3
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 13:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rSZPLKCHrg/HTig+zzpH3sTLGNDprHlhrTm7rkO5r4g=;
        b=qWMgHqoFUVlqUkSV6AiebsXUS90vxVxA1p3IWS1eZriqZroVWuvo+kLIhtYIODEdNv
         ilFNHo9UNOjVLmldDy2Woqlw45fRbPsESIo3ws0aHq/AYzt5kxcWEwmaHI+lZjjj65W9
         XvHG0hlHma2uq/c7lBdtmMdcvhG4/qEp8QdbBfEEcsrXdfWb0EVP8BzXS6OHBE/wd6N3
         PnPCLah0LbRpaZWS8Q0Xtc8YluFaxbz8cESUUbPlUmUDXATgR1T2/xQN29xkNWkeqjKj
         rcgmVoPUPwBNnYLbPQRzcWFnoerSrSLMiup3t7gjKi8O3cAXhk/vBAbGPNDn71wtTj7s
         Rl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rSZPLKCHrg/HTig+zzpH3sTLGNDprHlhrTm7rkO5r4g=;
        b=JoZeat5DX7N3nubchyYZ7G4LoJy0wtTFYqnLEbsVAX2bOi65cX6oZ6c+baymqz9FuZ
         OPBIEzOYFoH8z5nk/oG4wOpu6nJ2F8KcVJn2ynDneevxxFeBKOtxJE5LfnyEaq6liTSM
         2dKhDSTIDITri/DwUdRgyxkqAMyQYgvHqiZTCJBIX7nzDXqAAp7uYr7jDt0U9kkh8ZOz
         /DRMRMjriDBc457U/zaSQ45kCBa/YPGvM79TFC6IcSZpzpKkYPT3Me9uuXsOBQYYIM/J
         JZHff2rQtzdd+57SXHf+gPhxB8V9XpY/9flEAIy0zPDrjSH8cHG5RcwliTQbvTGFO+I+
         MH/w==
X-Gm-Message-State: AKwxytfuIq0PrTuRrL6Z1CAStiVWLk3WaOJ9u/RTUKyrtumPsAc3nQWD
        gqKCZLGj+gU06A5BZzIaIlnlcBXzqKTsMBxWQDs=
X-Google-Smtp-Source: ACJfBot9XykHB25uADcmhqm4hqByDDk3e+G5hI60mXmUsRzFVhKro0T7QJMG/fgNAGYrWllF+BBBvkQVfKicYVZsMgY=
X-Received: by 10.55.204.18 with SMTP id r18mr69442300qki.212.1516398527623;
 Fri, 19 Jan 2018 13:48:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 19 Jan 2018 13:48:47 -0800 (PST)
In-Reply-To: <xmqqr2qlps7r.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119041825.727904-1-sandals@crustytoothpaste.net> <CAPig+cTOw5NsSmLHYcBEidDzNyiidJ0Dw1dF227KWDL9JrASvw@mail.gmail.com>
 <xmqqr2qlps7r.fsf@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 16:48:47 -0500
X-Google-Sender-Auth: d9Ff8Z23opgz_kKgFaTk2mO9iOQ
Message-ID: <CAPig+cRX2HpUPCnuf3aiZO71KmFgBR4JE_=NBA3UuwuRxrXR2Q@mail.gmail.com>
Subject: Re: [PATCH] repository: pre-initialize hash algo pointer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> Now that we know (due to Duy's excellent detective work[1]) that the
>> trigger is files with names differing only in case on case-insensitive
>> filesystems, the commit message can be updated appropriately.
>
> Thanks.  Let me apply the following and do a 2.16.1, hopefully by
> the end of day or mid tomorrow at the latest.  Test to protect the
> fix can come as a separate follow-up patch.
>
> -- >8 --
> Subject: [PATCH] repository: pre-initialize hash algo pointer
> [...]
> A "git clone" of a project that has two paths that differ only in
> case suffers from this if it is run on a case insensitive platform.
> When the command attempts to check out one of these two paths after
> checking out the other one, the checkout codepath needs to see if
> the version that is already on the filesystem (which should not
> happen if the FS were case sensitive), and it needs to exercise the
> hashing code.

Thanks, the amended commit message makes the reason for the patch more
concrete. There does seem to be a bit of a grammatical issue, however,
which makes it difficult to parse. Namely, "already on the filesystem
(...)" probably was meant to say "already on the filesystem (...) is
{something}".
