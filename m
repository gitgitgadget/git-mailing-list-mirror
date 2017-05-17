Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0116B201A7
	for <e@80x24.org>; Wed, 17 May 2017 19:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbdEQTpj (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 15:45:39 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:32896 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdEQTpi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 15:45:38 -0400
Received: by mail-it0-f68.google.com with SMTP id l145so2598570ita.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EscxAz/e5djkJ9G6OLEZM032WnYB+yCfmiaUJV7w5wQ=;
        b=cO+dBP23+o01WEmGfbfd5qDxxMO0tYSovh0GbK06rTwApObZMr5UemBfCT9qKX57Cg
         B9HDrn28lC5BzXpzpmPXMHX1XZ+MSdGezxo4eI8TwSpZxMlc4Cos2mYkzPCFc8sd0BDe
         UPia+eSfYLvEDG//I+y/0XcAPVFRFwCRrR9+L+cpmUnxD+BrIMMabrIVQWHblnwWwjXH
         yP/MIfPfOErCAKzL89DC9vuD+T2CC5OVdavaNd7M36X0ker2ulT2Bh9zWvAS1PgvbrUp
         95HwtX9R3S2czrKdVkPKrCJdEp1QAjTOIjfm713ca3YWebsBgni3UeVIsgRIjd9IkIdX
         ZjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EscxAz/e5djkJ9G6OLEZM032WnYB+yCfmiaUJV7w5wQ=;
        b=U7hg+nusTAfJQm/gvboulGnkNZkYpN30+3hmWPo6/PWgSOdAVIstOTinJ1RYHDkuKf
         s0rppVQgAU2Xjv8kK4cBwr7o6wMNCSD2QzZzzsShJPHYFntyg3RY0ULsANnljIYySRa9
         XRly0qZsuj+phU9C+66eqomdT+FxqiR+ZWjTORPU0mqSULl49cz8Z4UXfX7REyruWMeB
         yPQ1wwg5xjdt6udWEDtJETr1Icp/AHtkpzizDhAd2DADb07OS6yDhPUY+j5JHy+oT34k
         JYYiZbOIropW+ortk5XVpqMcXQcKKRl2oW9qpFjEh3R4WSw6MMDNhmDpNrJ6AFLN+Yd/
         thcA==
X-Gm-Message-State: AODbwcCiTU4wIxQkV2MhcnHP5eGU1/e2hQhhacpN3VpqNxNjlwQRqlGF
        0cYhMUgc/qHXJmEZuLvW9pjBsWDhRw==
X-Received: by 10.36.67.9 with SMTP id s9mr10463245itb.94.1495050337480; Wed,
 17 May 2017 12:45:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 17 May 2017 12:45:16 -0700 (PDT)
In-Reply-To: <CAGZ79kZC98CxA69QjmX2s_SU6z1CSgKgwZeqvwiMRAQc6+S3xg@mail.gmail.com>
References: <xmqqk25gvu12.fsf@gitster.mtv.corp.google.com> <20170517113824.31700-1-avarab@gmail.com>
 <CAGZ79kZC98CxA69QjmX2s_SU6z1CSgKgwZeqvwiMRAQc6+S3xg@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 17 May 2017 21:45:16 +0200
Message-ID: <CACBZZX6Gad32eZX6BTamNK016wu3HHLdYDB6JkUPNv=+mB3PKg@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] Use sha1collisiondetection as a submodule
To:     Stefan Beller <sbeller@google.com>
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

On Wed, May 17, 2017 at 8:52 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, May 17, 2017 at 4:38 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Wed, May 17, 2017 at 9:09 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> On Wed, May 17, 2017 at 7:39 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>>>> From: Marc Stevens <marc@marc-stevens.nl>
>>>>>
>>>>> Some big-endian platforms define _BIG_ENDIAN, which the test at the
>>>>> beginning of file has missed.  Also, when the input is not aligned,
>>>>> some platforms trigger SIGBUS.
>>>>>
>>>>> This change corresponds to 33a694a9 ("Fix issues with a big endian
>>>>> platform", 2017-05-15) in the history of the upstream repository
>>>>> https://github.com/cr-marcstevens/sha1collisiondetection
>>>>
>>>> Then why not just update sha1dc from upstream instead of
>>>> cherry-picking one patch from them?
>>>
>>> See the original message upthread.  I did the cherry-pick simply
>>> because that was what Marc instructed the patch recipient to do ;-).
>>
>> Since that patch is now in Marc's upstream code we can just update to
>> that.
>>
>> While we're at it let's see if Marc will take a patch so that we can
>> use his code as-is with some Makefile trickery of our own, instead of
>> having to solve merge conflicts each time we update from him. I'll
>> submit a pull request for that shortly.
>>
>> And since if and when that pull request gets accepted we're at the
>> point of being able to use the upstream code as-is & don't need to
>> locally modify it, we can just use a submodule to track it.
>
> As someone who works on submodules: YAY! This sounds
> wonderful in the sense that more git developers experience the
> sharp edges (if any) of submodules and would fix them.

Yeah I agree git.git should dogfood submodules, and this seemed like a
perfect opportunity for thaht.

As noted later in your mail everything may not be ready, so when I
submit a non-RFC version of this (after upstream pulls my changes,
hopefully), the 2nd and 3rd patches can just be dropped.

> With the reset work on submodules (checkout, reset,
> ls-files, grep) and more in the works (better push/pull)
> we may be close to prime time.
>
> However we do distribute tarballs (well, Junio does),
> which is not yet supported to include submodules.

Ouch. So there's no non-manual way with git-archive to make a tarball
release of a git project using submodules?

> I did follow the SHA1DC discussion just from the sideline,
> how crucial is that library for us?

Since 2.13.0 it's git's default sha1 implementation.

> Also now that we discuss having submodules:
> Would we just point the submodule URL to github\
> and call it a day?
>
> We could make a friendly fork of it and put it next to all the repositori=
es
> of https://git-blame.blogspot.com/p/git-public-repositories.html
> and then use relative URLs in the .gitmodules file.

Wouldn't we lose the ability to just "pull" the module to see if
upstream changed, i.e. now we'd need to manually munge the URL first.

If so having a fetchurl be a relative URL similar to git-push's
pushurl would solve it wouldn't it? I.e. a project like git could say
"here's my mirrors" different from "here's my upstream".
