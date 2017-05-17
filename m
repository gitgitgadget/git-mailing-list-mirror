Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92C2201A7
	for <e@80x24.org>; Wed, 17 May 2017 19:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbdEQT53 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 15:57:29 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36530 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbdEQT5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 15:57:24 -0400
Received: by mail-pg0-f42.google.com with SMTP id x64so11790106pgd.3
        for <git@vger.kernel.org>; Wed, 17 May 2017 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d66b0sAHsz+UvDdZKrKFCX7DC5HQ/xUWbGXhoh4r6HA=;
        b=GYA6O7gR1UZV0BJM9vrYw9nOPIYTcKCPpG8Gqh/RlLnW/nnhk3LXbAPIYkFGNsnUrb
         WheyyzvdchYL3iPF5m3NO/aVAlvkqPwhQ4BENr5FheD0YSrAko7iEAGD5DxYnjxDWyEK
         LE5C+k0mw8VtbqXsAF31KhPa1w/AHSPJpz8z2GFifDZqc350GiRmj06YiLAic0MHYrkB
         o9FWZf86UR64EwkbpMEWjMNoqJ+ddrDNX/XNh5vIKmjOtYIOnfaV/UbswDr5g5x0tnQz
         3zcjnRvWBHHnKiKv9zD+jPx2XGc8DoIAfT4SnfgmlhQKRPFdhjHcyWnUAKmHYzGU2IkM
         yVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d66b0sAHsz+UvDdZKrKFCX7DC5HQ/xUWbGXhoh4r6HA=;
        b=KA5WcyyDBH8/NQSkMa79my63Moq6/gTfmtE0eIGNr7nUcVHLS3/5cVIVYhFGETEWmt
         0p03riXXVckp+ZJYhQmo5PnaUjscHsHIjw4GKDRosLw62sNcKlVqKaM7cYzXyJVIHS1G
         BM51u9TrR7LeGHYGIZmvP8eA9mVgJswpfN7/otYWMNqI9NTObdPSZrWSUbXnxMbR3nXa
         1boy+xKX2OPr+pOnqs7mM4s3a0mEZYtFNWjYgeyJ1iYFPpTynBqKa7I+xyxTRJZsNsm7
         iCYmtrJ7ZL96h8thNmnuG2bf843sCzy8J0GRwe/po5eaanfrcjepLuy3H2Wv5PxJU9Ax
         VyZw==
X-Gm-Message-State: AODbwcD9xXZOvn2+TsiQ0P0I3fg5N0sgsmRDqqVj1D1uk7RUeAJxfjny
        3KQBx+7isvTfc1rtawA8PInLT+V8LzIa8E4=
X-Received: by 10.84.248.73 with SMTP id e9mr569182pln.76.1495051038935; Wed,
 17 May 2017 12:57:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 17 May 2017 12:57:18 -0700 (PDT)
In-Reply-To: <CACBZZX6Gad32eZX6BTamNK016wu3HHLdYDB6JkUPNv=+mB3PKg@mail.gmail.com>
References: <xmqqk25gvu12.fsf@gitster.mtv.corp.google.com> <20170517113824.31700-1-avarab@gmail.com>
 <CAGZ79kZC98CxA69QjmX2s_SU6z1CSgKgwZeqvwiMRAQc6+S3xg@mail.gmail.com> <CACBZZX6Gad32eZX6BTamNK016wu3HHLdYDB6JkUPNv=+mB3PKg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 May 2017 12:57:18 -0700
Message-ID: <CAGZ79kZXgjC84vsXtvPu_=ApJOkAwUjV1BCS2iETowF-sSrrvw@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] Use sha1collisiondetection as a submodule
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 12:45 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, May 17, 2017 at 8:52 PM, Stefan Beller <sbeller@google.com> wrote=
:
>> On Wed, May 17, 2017 at 4:38 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> On Wed, May 17, 2017 at 9:09 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>>
>>>>> On Wed, May 17, 2017 at 7:39 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>>>>> From: Marc Stevens <marc@marc-stevens.nl>
>>>>>>
>>>>>> Some big-endian platforms define _BIG_ENDIAN, which the test at the
>>>>>> beginning of file has missed.  Also, when the input is not aligned,
>>>>>> some platforms trigger SIGBUS.
>>>>>>
>>>>>> This change corresponds to 33a694a9 ("Fix issues with a big endian
>>>>>> platform", 2017-05-15) in the history of the upstream repository
>>>>>> https://github.com/cr-marcstevens/sha1collisiondetection
>>>>>
>>>>> Then why not just update sha1dc from upstream instead of
>>>>> cherry-picking one patch from them?
>>>>
>>>> See the original message upthread.  I did the cherry-pick simply
>>>> because that was what Marc instructed the patch recipient to do ;-).
>>>
>>> Since that patch is now in Marc's upstream code we can just update to
>>> that.
>>>
>>> While we're at it let's see if Marc will take a patch so that we can
>>> use his code as-is with some Makefile trickery of our own, instead of
>>> having to solve merge conflicts each time we update from him. I'll
>>> submit a pull request for that shortly.
>>>
>>> And since if and when that pull request gets accepted we're at the
>>> point of being able to use the upstream code as-is & don't need to
>>> locally modify it, we can just use a submodule to track it.
>>
>> As someone who works on submodules: YAY! This sounds
>> wonderful in the sense that more git developers experience the
>> sharp edges (if any) of submodules and would fix them.
>
> Yeah I agree git.git should dogfood submodules, and this seemed like a
> perfect opportunity for thaht.
>
> As noted later in your mail everything may not be ready, so when I
> submit a non-RFC version of this (after upstream pulls my changes,
> hopefully), the 2nd and 3rd patches can just be dropped.
>
>> With the reset work on submodules (checkout, reset,
>> ls-files, grep) and more in the works (better push/pull)
>> we may be close to prime time.
>>
>> However we do distribute tarballs (well, Junio does),
>> which is not yet supported to include submodules.
>
> Ouch. So there's no non-manual way with git-archive to make a tarball
> release of a git project using submodules?

Yes. Ouch.

>> We could make a friendly fork of it and put it next to all the repositor=
ies
>> of https://git-blame.blogspot.com/p/git-public-repositories.html
>> and then use relative URLs in the .gitmodules file.
>
> Wouldn't we lose the ability to just "pull" the module to see if
> upstream changed, i.e. now we'd need to manually munge the URL first.

I assumed more people would fetch git and trust the community rather
than people checking if SHA1DC is up-to-date, so I thought it is easier for
the minority to rewrite a URL.

> If so having a fetchurl be a relative URL similar to git-push's
> pushurl would solve it wouldn't it? I.e. a project like git could say
> "here's my mirrors" different from "here's my upstream".

I would think so.
