Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E964F1F576
	for <e@80x24.org>; Wed,  7 Feb 2018 09:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbeBGJwF (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 04:52:05 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43449 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbeBGJwE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 04:52:04 -0500
Received: by mail-qk0-f193.google.com with SMTP id y204so296443qkb.10
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 01:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MJ1dfZcs8EArnv1yP+y6WDfV7W9K5eqkdQZGFewBqiQ=;
        b=cFfOtutaANJ4KctO7c+1R1l+n5DgCwkRdN7npRhiu13qB0mtcqfCZkAi/VAed9CXzr
         +omZ9Vcb394IAjsxBFRdd2AyyafMBNdFH++BnDmQ1rMir2qgmOKM/4Mw4YdGDbM6e4lt
         usJJXarFWDs9aNVde70gvMlE2OSofUdPJAXBQoB9bp79doDQu17kUGCg5+NU/p8Bwinw
         Bx/e9gfRICUDiiLEX1VDzwaBLyeYs2Nk1ck5ls1OKaQg4YEx+G41LQn73Ko37S2AgZYa
         K4eyRG8LLZXM7LoUiNmWPMMzXxAlBsDNLEBwU210qOm2uA/R9vkmVEsjfv4CyF26jrjA
         bmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MJ1dfZcs8EArnv1yP+y6WDfV7W9K5eqkdQZGFewBqiQ=;
        b=ncM/GU7btVoLYDREGMb2eVQ/5LEht3BUK27qmYaygRTOoEtcQOZjlV4CW1hkEYa+L9
         ba8NMs12rTrPFNN+f8MaLGqPddMZxG4SsuBGcov3pQQiVN2adQL27HDf+zZ+nJixqE12
         RLsppW3sW/ZowNsa3UK8xu+sbvv0DURJNvAYauKil7pb3wY2jOIzOfLBrdCu7RAM0hTr
         Ao2ud1UvOjt/Rc77Q87yZbRuMpHiD836LHMjqpH2aBjPNERvyRB7/RfU5ct7rzMH/PAs
         ZMiZ7bAE22gN0Tz5zA29BNrWiXKTkzX4EOYdm2QQOBLt/FLjy1fXpEsUDyRNbwTEN+i5
         kRqg==
X-Gm-Message-State: APf1xPCO7ldZsY/9U1xO68BjFdYgptwfVvkF56Lhyh8S+jrCzk8naS1t
        Oo0AuTRgAKgPcvkkNhZBbK5HAmStRrmTfMggyp0=
X-Google-Smtp-Source: AH8x226UsExQlSrXhWL/SasRC4kdM3eSj/l3lK8le9cH9LngQc6mHCTHyQR0C37b4qW0eEMBusWgJXaVA0tEkN3DOxU=
X-Received: by 10.55.123.69 with SMTP id w66mr7931297qkc.326.1517997123835;
 Wed, 07 Feb 2018 01:52:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Wed, 7 Feb 2018 01:52:03 -0800 (PST)
In-Reply-To: <CACsJy8CQLnzX6vijE+WHE3_nwqVfFiNWFb_rcA-Lw_fvGf=aFw@mail.gmail.com>
References: <20180201130221.15563-1-pclouds@gmail.com> <xmqqefm3cgd7.fsf@gitster-ct.c.googlers.com>
 <CACsJy8B5DYpSQnJiLK8r4naaBh0YWLGwn9FuvM6EhP74E4E_CA@mail.gmail.com>
 <xmqq8tc7b6yt.fsf@gitster-ct.c.googlers.com> <CACsJy8CQLnzX6vijE+WHE3_nwqVfFiNWFb_rcA-Lw_fvGf=aFw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Feb 2018 04:52:03 -0500
X-Google-Sender-Auth: cQlHi7b3wh7Jsv1Opf-wT5HaMEM
Message-ID: <CAPig+cR9RycfLz0C6tXA4iPXdqoyczfij8CBaU4MmRGRmuRhSQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] diff: add --stat-with-summary (was --compact-summary)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 5:20 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 6, 2018 at 1:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>> I actually think compact-summary was a good way to phrase it.
>>
>> Personally, I think it was a UI mistake that --summary can be given
>> independently with or without --stat (instead, there shouldn't have
>> been the --summary option, and instead when it was added, --stat
>> just should have gained an extra kind of output).  A single option
>> that can give both kinds of info may be a good way forward, so
>> another possibility may be --summary-in-stat (meaning: the info
>> given by summary is included in stat output).  I dunno.
>
> +Eric maybe he has some idea (sorry I forgot to include people from
> the last round).

What about the earlier suggestion[1] (and minor follow-ups[2,3]) of
making this another option to --stat= (for instance, --stat=compact)?
Did that idea get shot down or am I misunderstanding the question
here.

[1]: https://public-inbox.org/git/CAPig+cQLgs59JYxcmK30qY307ArwqJx6pNOo95Z39_jJ9+D6+g@mail.gmail.com/
[2]: https://public-inbox.org/git/CACsJy8B5qrN8T1aai3y3nfEc5baqn2Xkk6vZozMp5Lh-mPZ0VQ@mail.gmail.com/
[3]: https://public-inbox.org/git/CACsJy8CPHk+aXHr-mkHZi27s=c3+ny8D9CSuzOSO8PweviBcqQ@mail.gmail.com/
