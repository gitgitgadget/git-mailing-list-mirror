Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62481FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 03:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbdJLDwi (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 23:52:38 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:51343 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdJLDwh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 23:52:37 -0400
Received: by mail-qt0-f181.google.com with SMTP id q4so11376557qtq.8
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 20:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q2UbMFKtrWG+iqijdTndYQpzirenBi9YG06DWhHSlOU=;
        b=is7qplyu1L+uak4tdXLalqXTQUYV4qEKtqcQzr6SgMZkvs9sIxGm0Ag9mqLMlrnrRu
         q7H2iOjZm7uhkQvL5XlkaulQIxSF/8g0E6Zch1uYbReX1tdpG58QhpLeDnwBmeqI+jTB
         h1AOq0SSguZ0D7ViEfAKBgn2e2m38QmvXbMIyyGMRzOWnhz94dKJSDMv4CXhx0GDW4zn
         RtT7iJ9B+1U/L8/iueRanpSbkNC5AgCDOEYvDP+8e3v/AEA894/kiP8PrMCXJDNZm/rn
         jL33UVU20NyQ+e+JqPYa4C4CVnuG6H9AisZFBDxNLrhy7oYZHs+qhCtQKvUdTADPZD9f
         IbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q2UbMFKtrWG+iqijdTndYQpzirenBi9YG06DWhHSlOU=;
        b=b/qv5x21AW0eTN7H/DCH/UvSsfiXLYygTHmSv6MEnjUuNUHuHeZnG5fnMDzHqIminh
         7xUQQq6KqVc0+rn9zYnBEizitBa9y1GKveXyGQLAHjhkmN9a2o8FhkQ0uUV4CFLY2r92
         IkUEyZlmV1ruEXHbrPkhDidmd+NRWJyj9b2fysTUlQ811wuzzsO74w8aRTHFvj0fy+7m
         pI5UlxkWW9k7WrvuHw0b2GvZVpB9qKxdGf/rMrRKZBbS3vD44c1fW/2InNmO0MA5ZvfC
         ySVI1gc6Kd9DetP0SlwLEbc1fJDZ98wbA5vWhKAk8LcgMSQEMXfpgvgjhXpNjf6xb6Ly
         pR8w==
X-Gm-Message-State: AMCzsaXXpwGaTpHVrlFPVLJE17PNPnEDd1dEujqZl1BgDLA03nOeiWbs
        nxKOMht8u+ZCnlYFJ84E7JJa/q3hebb0tbRcXDs=
X-Google-Smtp-Source: AOwi7QBtNhmlPYG8arzYmjABWh2vs0fe8Clfapu5oylX0fqNmFWeh5SVlsyZm8I/Li7L6/PWTqJoPRRBsOSdl6Ed6ho=
X-Received: by 10.200.40.142 with SMTP id i14mr1714318qti.326.1507780356946;
 Wed, 11 Oct 2017 20:52:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.32.226 with HTTP; Wed, 11 Oct 2017 20:52:36 -0700 (PDT)
In-Reply-To: <CAC2Jkr+ZDUxd9JcKvVwZqCHVW+Bpp2CbdyehwgKV_Ru-Uqxo8A@mail.gmail.com>
References: <20171011180350.99888-1-takahito.ogawa@datagrid.co.jp>
 <xmqqr2u92nkr.fsf@gitster.mtv.corp.google.com> <CAC2Jkr+ZDUxd9JcKvVwZqCHVW+Bpp2CbdyehwgKV_Ru-Uqxo8A@mail.gmail.com>
From:   =?UTF-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Date:   Thu, 12 Oct 2017 12:52:36 +0900
Message-ID: <CAC2Jkr+zFy9q4Xnzxcqj6rq9+TOs2sO9J5Wx9ccd3oiY4N20uA@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-stash.txt: correct "git stash" behavior with no arguments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Takahito Ogawa <takahito.ogawa@datagrid.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As you point,

    git stash

without any argument is equivalent to both of

    git stash save
    git stash push

. The original sentence is correct.

2017-10-12 12:31 GMT+09:00 =E5=B0=8F=E5=B7=9D=E6=81=AD=E5=8F=B2 <aiueogawa2=
17@gmail.com>:
> As you point,
>
>     git stash
>
> without any argument is equivalent to both of
> git stash save and
>
>
> 2017-10-12 9:53 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
>> Takahito Ogawa <aiueogawa217@gmail.com> writes:
>>
>>> @@ -33,7 +33,7 @@ and reverts the working directory to match the `HEAD`
>>> commit.
>>>  The modifications stashed away by this command can be listed with
>>>  `git stash list`, inspected with `git stash show`, and restored
>>>  (potentially on top of a different commit) with `git stash apply`.
>>> -Calling `git stash` without any arguments is equivalent to `git stash
>>> save`.
>>> +Calling `git stash` without any arguments is equivalent to `git stash
>>> push`.
>>
>> Hmph.  Is there any difference between
>>
>>         git stash save
>>         git stash push
>>
>> without any other argument?  Aren't they equivalent to
>>
>>         git stash
>>
>> without any argument, which is what this sentence explains?
>>
>
