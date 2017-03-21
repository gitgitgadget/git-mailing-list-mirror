Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9798F2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 19:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758072AbdCUTLr (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 15:11:47 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36118 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758022AbdCUTLh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 15:11:37 -0400
Received: by mail-io0-f173.google.com with SMTP id l7so54198294ioe.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zOkPwVq4VN5UL6cqL0cQxzDzv0EnxaUZtJpD/DRcrzg=;
        b=c0CZu7zSrWYCf2ySsMKWQV01oFRpahqma5PinMBFqEzzVYnR7ag+EniuQibUrTGtnx
         gwmywcfnUeicmGsWKXVeEdPkUJIIkRO7ix6XW3e3gp1lNFzzBtIrpaHa4zlg4ep+38q/
         IHqomKa8F9YhWUiNhQa4vLquUvKO4mDw+y6GEks6DwcCs0FIOw01ESrj1iJ17Vy3zAgM
         nRiXiTSPX2IYAzcTncSxtA6M2Hq4peOTkchr3UjJVeBoQdofdpuFbNhWHHtyEvXjur3u
         cM1ba9u2P7Sz/ov2aqMX0Lw5pi5Mh+k7Dz5vILhA2J671Z4eY2qIZbp97Jo3vcQaA1x5
         MS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zOkPwVq4VN5UL6cqL0cQxzDzv0EnxaUZtJpD/DRcrzg=;
        b=DrM+MtZLoz2YeRkBkczGT88IHpTAvHmjQiJ79T9De7IGD6tHJZny2GqascgcVk02XJ
         IsRc5ysLSJ/hKLzl0aShIYZ3zr8yPRKRhxKxMpaEt8MkD6xG6ViwbNiI5+BS7NFlqre+
         9UF2QHRYjY+UCzC+xs/W5RnMapPyCcsYOVKNXYWKue8Huc6T93UmGVyuo/7YCJNP3YI+
         Nu9+2NRskC8sdDpqCOlYTv/Nq5VekN1gAWcR1g5ZWz0Hj/HMLGLoQSAyHxJbQKY1YOOz
         SnakY4HloRcaQnnJB/YTwqAUA0GBC4eV0EXj+SnMozG/CLcnFX/dAN4XtSyqEX4ZlfRH
         1RJw==
X-Gm-Message-State: AFeK/H170M50SiHG9tb0DYkfEnBwzeKC+kjF0+LKZemonKlt0ddGpxF5HDsSYPaKNg7Hm9CLgdQpbhlKWmzyxQ==
X-Received: by 10.107.150.201 with SMTP id y192mr38960648iod.33.1490123496025;
 Tue, 21 Mar 2017 12:11:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 21 Mar 2017 12:11:15 -0700 (PDT)
In-Reply-To: <xmqq37e6piae.fsf@gitster.mtv.corp.google.com>
References: <20170321125901.10652-1-avarab@gmail.com> <20170321125901.10652-16-avarab@gmail.com>
 <xmqq37e6piae.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 21 Mar 2017 20:11:15 +0100
Message-ID: <CACBZZX7yRRTQpcFZ9eO2_+HdB979p6URE+jsXJakxw7jpnOvmA@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] tag: implicitly supply --list given the -n option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 7:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the "tag" command to treat the "-n" invocation as a list-like
>> option in addition to --contains, --points-at etc.
>>
>> Most of the work for this was done in my earlier "tag: Implicitly
>> supply --list given another list-like option" commit, but I've split
>> off this patch since it's more contentious. Now these will be
>> synonymous:
>>
>>     git tag -n 100
>>     git tag -n --list 100
>
> Hmph.  I would understand if these meant the same thing:
>
>     git tag -l -n 100
>     git tag -l -n=3D100
>     git tag -l -n100
>
> with or without "-l".  And accepting any of the above three without "-l"
> instead of rejecting is a very good change, I would think.
>
> I however do not understand how accepting this:
>
>     git tag -n --list 100
>
> would be a good thing, as "100" an optional parameter to the "-n"
> option.
>
>> Whereas before the former would die. This doesn't technically
>> introduce any more ambiguity than the aforementioned change applied to
>> th other list-like options, but it does introduce the possibility for
>> more confusion, since instead of the latter of these dying:
>>
>>     git tag -n100
>>     git tag -n 100
>>
>> It now works entirely differently, i.e. invokes list mode with a
>> filter for "100" as a pattern. I.e. it's synonymous with:
>>
>>     git tag -n --list 100
>
> Ahhh, yuck.  OK, so in "git tag -n --list 100", 100 does not have
> anything to do with the -n option.  It is a pattern and -n specifies
> "just one line" by default.
>
> Oh, boy, that is confusing.  While it is very logical.
>
> Still I think it is OK as I can see why people who wanted to have
> '-n' in the first place may want
>
>     git tag -n -l <pattern>

Yeah I see now that this is rather badly explained. I'll fix this up
for v3. All of this worked already:

    $ ./git tag 100
    $ ./git tag -n -l 100
    100             tag: add tests for --with and --without
    $ ./git tag -l -n 100
    100             tag: add tests for --with and --without

So actually thinking about it again it doesn't add any more ambiguity
than we had before. The change is just strictly getting rid of the
need for -l for consistency with --contains, --points-at etc.

I see now that the whole thing that led me down this golden path was
that I was removing the failing "git tag -n 100" test, so while I was
still wrapping my mind around this I thought I was introducing some
*more* confusion, but really that test was just testing that it didn't
work, as opposed to "git tag -l -n 100".

I'm just going to squash this into the "tag: implicitly supply --list
given another list-like option" patch for v3 unless you have
objections, I think there's no reason to split this off any more than
splitting off e.g. --points-at etc.
