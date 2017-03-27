Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3841FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 18:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbdC0SGv (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 14:06:51 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36562 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbdC0SGt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 14:06:49 -0400
Received: by mail-it0-f44.google.com with SMTP id e75so29370534itd.1
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 11:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ziYMJ1hbMaCV+93z5IF0Fi3qwHt4VuobN6SWiM5wWj4=;
        b=m6SC14YSwiAwnFYnJe12T5SMuDo4Mb0UTpaJEBLkdpvssVt5B5bEl8tOgeul7dQwTX
         X1Rxwld3easwKqe6K0ZCmFaIYLiuLtEcX84bpwtROD6zuhvLI/NVexAvFyxgBLWLHV9+
         iN1MwMzac/ZJiCebIIaFtCeYH0A/xTXqtFhTk0bBoF9uO0291bCagksu7xw90sxBwrYl
         259pUQccYBWKHmq58u4vky0aswT9WAxj63pAs8yzOUQgZi4JKQvei5fAlhbkdTSqiSnM
         ey1BPkmpkY6w+49BjbhfEPLqeBN+9DrSEuJJ82ZdwtU8eOAkILuLM+2rom7dkPjUgDEq
         f+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ziYMJ1hbMaCV+93z5IF0Fi3qwHt4VuobN6SWiM5wWj4=;
        b=Ap9BdmiocOyf5JvvM2mOlmvajmxC27SteYNBXIWOhUYWJ9UO8ZM0S0PYfDMCUnoPml
         t+mACHDnNhSlfo/EYGWHXByE9HFAEIKJQitRVKibjzOpVQpvsZ4rgDhfc0w0gbMJ076i
         fExeaohrexDMGozhIj5w3rh2sjykiR9376o2mP9O9I69dQtvyruHkApSTjbwOwNhoRvR
         u4YbUl33R0NMYaaq5HI0xHNZ6Ujt7MtYQnFZZXnClEU/sORTly/kacXVV9Jv9twrsyQf
         WOiXstThHKpnXVfDhpeX6GPm2QDv5G+kDt+E64EXz98HYpWiEorsojbka/aOO+Nr2Z9C
         bs4A==
X-Gm-Message-State: AFeK/H0LYdIlzZ39m9IVfNb3MbiBHjK6xd7UdQpe1rRpaIy/EdXBJBUZziXXvz+MfQsmX5fK10VwuD4O1ew0mw==
X-Received: by 10.107.32.199 with SMTP id g190mr24682066iog.117.1490637972030;
 Mon, 27 Mar 2017 11:06:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 27 Mar 2017 11:05:51 -0700 (PDT)
In-Reply-To: <xmqqshly1um4.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8874l8t.fsf@gitster.mtv.corp.google.com> <20170327111655.29941-1-avarab@gmail.com>
 <xmqqshly1um4.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 27 Mar 2017 20:05:51 +0200
Message-ID: <CACBZZX5nMuQ7jumdxShynaQ_F8Av3fudbbBZ4iG2Jv9wcjh5_g@mail.gmail.com>
Subject: Re: [PATCH v3] rev-parse: match @{upstream}, @{u} and @{push} case-insensitively
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2017 at 7:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Before this change:
>>
>>     |----------------+-----+------+-----|
>>     | What?          | CI? | CIP? | AG? |
>>     |----------------+-----+------+-----|
>>     | sha1           | Y   | -    | N   |
>>     | describeOutput | N   | N    | N   |
>>     | refname        | N   | N    | N   |
>>     | @{<date>}      | Y   | Y    | Y   |
>>     | @{<n>}         | N/A | N/A  | N   |
>>     | @{-<n>}        | N/A | N/A  | N   |
>>     | @{upstream}    | N   | Y    | N   |
>>     | @{push}        | N   | Y    | N   |
>>     | ^{<type>}      | N   | Y    | N   |
>>     | ^{/regex}      | N   | N    | N   |
>>     |----------------+-----+------+-----|
>>
>> After it:
>>
>>     |----------------+-----+------+-----|
>>     | What?          | CI? | CIP? | AG? |
>>     |----------------+-----+------+-----|
>>     | sha1           | Y   | -    | N   |
>>     | describeOutput | N   | N    | N   |
>>     | refname        | N   | N    | N   |
>>     | @{<date>}      | Y   | Y    | Y   |
>>     | @{<n>}         | N/A | N/A  | N   |
>>     | @{-<n>}        | N/A | N/A  | N   |
>>     | @{upstream}    | Y   | -    | N   |
>>     | @{push}        | Y   | -    | N   |
>>     | ^{<type>}      | N   | Y    | N   |
>>     | ^{/regex}      | N   | N    | N   |
>>     |----------------+-----+------+-----|
>
> As we are not touching ^{<type>} or ^{/regex}, and it is obvious
> numbers do not have cases, I'll trim this down to focus only on
> things that are relevant while queuing:
>
>     Before this change:
>
>         |----------------+-----+------+-----|
>         | What?          | CI? | CIP? | AG? |
>         |----------------+-----+------+-----|
>         | @{<date>}      | Y   | Y    | Y   |
>         | @{upstream}    | N   | Y    | N   |
>         | @{push}        | N   | Y    | N   |
>         |----------------+-----+------+-----|
>
>     After it:
>
>         |----------------+-----+------+-----|
>         | What?          | CI? | CIP? | AG? |
>         |----------------+-----+------+-----|
>         | @{<date>}      | Y   | Y    | Y   |
>         | @{upstream}    | Y   | Y    | N   |
>         | @{push}        | Y   | Y    | N   |
>         |----------------+-----+------+-----|
>
> should be sufficient to highlight that it was possible to safely
> make these two things case insensitive, and we made so.
>
> For that matter, I do not know the value of AG? field---it only
> serves to show that @{<approxidate>} is an odd-man out and cannot be
> used as a good example to follow, but I am too lazy to remove it ;-)
>
>> Makes sense, replaced that note with that summary. Here's hopefully a
>> final v3 with that change. I've omitted the other two patches as noted
>> in the discussion about those two, I don't think it makes sense to
>> include them.
>
> Thanks.
>
>> @@ -122,6 +123,9 @@ refs/remotes/myfork/mybranch
>>  Note in the example that we set up a triangular workflow, where we pull
>>  from one location and push to another. In a non-triangular workflow,
>>  '@\{push}' is the same as '@\{upstream}', and there is no need for it.
>> ++
>> +This suffix is accepted when spelled in uppercase, and means the same
>> +thing no matter the case.
>
> As the above text (including the original) does not explicitly say
> that lowercase spelling is canonical, the new text is prone to be
> misinterpreted that only the uppercase version is accepted.  I'll
> do s/is accepted/is also accepted/ while queuing, but please holler
> if there are better ways to phrase this.

All of the above sounds good, thanks for fixing it up.
