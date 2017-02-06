Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F93E1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 23:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbdBFXzg (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 18:55:36 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36384 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdBFXzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 18:55:35 -0500
Received: by mail-lf0-f43.google.com with SMTP id z134so53666161lff.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 15:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WFnSZNkxzvaRo9fVXO8IuOABMRJJbvk9UKT3vOZgRQg=;
        b=KeTNQANKmWv4LkNce6PHIYJg5R4zg5RyXe2qcGqgRCLqF0bmJRBn57+Xx8vy1kVcXh
         xDjStJwOGIoSgC9dijUAoWXfw6e/M6ANiDwB7yGGuOvg7rtJZwG+ELUsIOwuOqYmFJU4
         R/49EqvtgM5KzdZqFMak2i9JSAfzcMOCtc52S1vvi5WalNr0CC+WYcuHOl8SNIHUxe0O
         mmnBvuWoAZs2z/UELTLEDYAUh0LRvLLFHISqjQHsVDV1YZ0sEZ+2rcFOCWLbOR3c8vLp
         3xS/ebyh3nfEms0HJEtP2wf26kErP8eqEO2sAr57tiB2ERbIiezBuDIQVfP1746bglFL
         zbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WFnSZNkxzvaRo9fVXO8IuOABMRJJbvk9UKT3vOZgRQg=;
        b=GIPy2jI3N48SSGAiJDXc8gg5Vg8YrOWTDxflcKR3+wMhocBP0TLrtIXiR5cjOT4SV0
         J7iPV5mNHHoqns+A2QD+bKA3wimHLjUlsU+V8RzTWKr2ttRtZlhuPZWxENpwxtTpQHyc
         QtY5u6pYat204KJdKrb4QjyxTSnK5qi6IqVsM8neY3IMPxx0jb8lg6qA+ekywEK194v+
         ihlIFTyy1k8AHd8J9cztAKMbW3Jg8Kp6eX8wuNa08O1mey33fg/guVI3l7mbOdpgidLm
         V5s1gENgSrQOXS3hl7Mji4bC7wEu9OE3WKfWhDnizCCmJjwSHQ+q/yPYmg8ervto0eYK
         wPeA==
X-Gm-Message-State: AIkVDXJvtwkEE+kHNqXAeDJcrs6Hn4EKkvRQf8hvbIipgivNtHOxvsRMqypdW+lF7KWDQEMtfPIILqhdAP3rWw==
X-Received: by 10.25.24.152 with SMTP id 24mr4813677lfy.12.1486425332964; Mon,
 06 Feb 2017 15:55:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Mon, 6 Feb 2017 15:55:12 -0800 (PST)
In-Reply-To: <CAM0VKjm-HQFtDypcWgOdQrLyjAicOVLUsFby5_wE1hvTE1pTRQ@mail.gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com> <CA+P7+xqhjVQMXtO4gtQ_2VAVd3qrpVLncH6YpFHreVV2mHORxg@mail.gmail.com>
 <CA+P7+xpeyebN3pmSX09Avh1EvYVjALpBCQ9r2==q3SWTu3GMSw@mail.gmail.com>
 <CA+P7+xrAVM8C1dnEaY1VnTUwiCzoMzh+rbMqBknyBG27grs-uQ@mail.gmail.com> <CAM0VKjm-HQFtDypcWgOdQrLyjAicOVLUsFby5_wE1hvTE1pTRQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 6 Feb 2017 15:55:12 -0800
Message-ID: <CA+P7+xo7Kz0Zi_vK7qLEicFyrSms2aMXJCrdiEQ=sAHHsh3z7Q@mail.gmail.com>
Subject: Re: [PATCH 00/12] completion: speed up refs completion
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2017 at 11:36 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Mon, Feb 6, 2017 at 7:31 PM, Jacob Keller <jacob.keller@gmail.com> wro=
te:
>> On Fri, Feb 3, 2017 at 7:15 PM, Jacob Keller <jacob.keller@gmail.com> wr=
ote:
>>> I haven't had a chance to further investigate, but I tried this series
>>> out (from your github) and it appears that this series (or the
>>> previous series for __gitdir work) breaks "git log" ref completion.
>>> I'll have further details when I am able to investigate a it more.
>>>
>>> Thanks,
>>> Jake
>>
>> At first I had the same problem, but I verified by re-installing the
>> completion script and the problem appears to have gone away. I suspect
>> what happened is that the original time, I forgot to actually install
>> the new version of git, and only installed the completion script, so
>> when some of the commands were run with new options they (silently)
>> failed and the result was missing completion values.
>>
>> Once I properly re-installed everything it appears to work as
>> expected. I haven't found any other issues yet.
>
> Thanks, that's good to hear.
>
> Still, I'm a bit puzzled as to what exactly might have caused your
> problem.  Considering new options:
>
>   - the __gitdir()-related series added the 'git rev-parse
>     --absolute-git-dir' option, but only ever used it if you invoked
>     completion after 'git -C some/where'.
>
>  - The refs completion speedup didn't add any new options but started
>    to use two that it previously didn't:
>
>    - 'git for-each-ref --sort=3D<key>' option, but that's with us since
>      the earliest ever 'for-each-ref' version from more than a decade
>      ago...
>
>    - 'git for-each-ref' format modifier 'strip=3D2', which was
>      introduced in v2.7.1~15^2 (tag: do not show ambiguous tag names
>      as "tags/foo", 2016-01-25), only about a year ago.  Were you
>      using a pre-2.7.1 version when seeing the problems?
>
> G=C3=A1bor

Nope. I was using some version of next at some point recently (less
than a couple months old). I do not know exactly what caused it, and
I'm not really able to find out because I can't reproduce it any more.
(after a fresh make install).

Thanks,
Jake
