Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0D4201A7
	for <e@80x24.org>; Wed, 17 May 2017 18:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbdEQSwP (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 14:52:15 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33354 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdEQSwO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 14:52:14 -0400
Received: by mail-pg0-f45.google.com with SMTP id u187so11159363pgb.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 11:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qlp5Cs1lbKWa2B+CTNKKAOn7SEO8m6tOL5iKNG3ZEe4=;
        b=eIEwjtzvojt0MZKUosFvhiBvDUY06/DdmwEX+HFetWvqDeBycnfMdjcqX/10XD820T
         4+zaDUeprkKZXz1lCxGYOwt/fMgkTczv1sMYS4hTXaBKgsTvfFPsWNXDjWcvVqiXj1K8
         YzeSY7RflRPsw9lwPM54DtlJIH2N/UWxDtXLD8jd/fC6anftthOx6YJZWVP9dSYjMFLT
         758GiKhomuCTQlwyZz9cWLln87TFsPAfWncs3KXWtF50Cd1hKcjLZiPPe0Xti/wWli74
         rIaKka7GIgfckPUA4oHiTvAz0zcb5jjPR8iZ8mRy4iQJbBc2AdzJ1+6LLIfG/hAqLV/c
         YzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qlp5Cs1lbKWa2B+CTNKKAOn7SEO8m6tOL5iKNG3ZEe4=;
        b=kNt7xa0oeFT0SVlG7x5APV+cYpOI8pqpjUvUTtv4CEjXr8B53ry4QDI6nF4Ll9i9Ah
         pwCzM++pA/I+a11ZrUhWul88v5aE85/4HY2necOp0wHXv4ZJgjLyK47HlliGVY5xUjXO
         BLZxm4dX3Tqy3Ox/ORJhvQr40qWql/6q0nxoS7Tg3bMBSiIdxGtQ4eKqJlybfw9j0Q6a
         lqF3J7iHwGg/tSXMTTF4xu7IQIT3z7hT2jzz7EiX4j6FaueM8web/Y4oVT3ztjgSXu3E
         63U4v5kroWSLGHnT8cxNnpt4GXfugJX9cvI2xTtiuX1lqWKpcItOBPsXW38hjd3iXuEA
         oNbQ==
X-Gm-Message-State: AODbwcBkpwqbaJAICEp6r8XM/8OsyRbAWL/6RAcJUJKH+0kJG0ZytWMQ
        LuXedFo7G18nUmPJ8gwu4zCN/1R60b1V
X-Received: by 10.99.116.7 with SMTP id p7mr243502pgc.162.1495047133193; Wed,
 17 May 2017 11:52:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 17 May 2017 11:52:12 -0700 (PDT)
In-Reply-To: <20170517113824.31700-1-avarab@gmail.com>
References: <xmqqk25gvu12.fsf@gitster.mtv.corp.google.com> <20170517113824.31700-1-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 May 2017 11:52:12 -0700
Message-ID: <CAGZ79kZC98CxA69QjmX2s_SU6z1CSgKgwZeqvwiMRAQc6+S3xg@mail.gmail.com>
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

On Wed, May 17, 2017 at 4:38 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, May 17, 2017 at 9:09 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Wed, May 17, 2017 at 7:39 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>>>> From: Marc Stevens <marc@marc-stevens.nl>
>>>>
>>>> Some big-endian platforms define _BIG_ENDIAN, which the test at the
>>>> beginning of file has missed.  Also, when the input is not aligned,
>>>> some platforms trigger SIGBUS.
>>>>
>>>> This change corresponds to 33a694a9 ("Fix issues with a big endian
>>>> platform", 2017-05-15) in the history of the upstream repository
>>>> https://github.com/cr-marcstevens/sha1collisiondetection
>>>
>>> Then why not just update sha1dc from upstream instead of
>>> cherry-picking one patch from them?
>>
>> See the original message upthread.  I did the cherry-pick simply
>> because that was what Marc instructed the patch recipient to do ;-).
>
> Since that patch is now in Marc's upstream code we can just update to
> that.
>
> While we're at it let's see if Marc will take a patch so that we can
> use his code as-is with some Makefile trickery of our own, instead of
> having to solve merge conflicts each time we update from him. I'll
> submit a pull request for that shortly.
>
> And since if and when that pull request gets accepted we're at the
> point of being able to use the upstream code as-is & don't need to
> locally modify it, we can just use a submodule to track it.

As someone who works on submodules: YAY! This sounds
wonderful in the sense that more git developers experience the
sharp edges (if any) of submodules and would fix them.

With the reset work on submodules (checkout, reset,
ls-files, grep) and more in the works (better push/pull)
we may be close to prime time.

However we do distribute tarballs (well, Junio does),
which is not yet supported to include submodules.

I did follow the SHA1DC discussion just from the sideline,
how crucial is that library for us?

Also now that we discuss having submodules:
Would we just point the submodule URL to github\
and call it a day?

We could make a friendly fork of it and put it next to all the repositories
of https://git-blame.blogspot.com/p/git-public-repositories.html
and then use relative URLs in the .gitmodules file.

On a tangent, in an off-list discussion we discussed having
the git-annex tests as an optional submodule instead of an
"external" test, but in conclusion we considered that idea not
ideal to implement (because our tests are like contracts, we should
actually write our own tests and not rely on downstream to write
tests for us)

looking forward for a discussion here,
Stefan
