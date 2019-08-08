Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA2BF1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 02:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfHHCfl (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 22:35:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42738 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfHHCfl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 22:35:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so112631819otn.9
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 19:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sz1SFDMPwknxCtiiBVmt/ZQwgPUFFCvMq8qZ8+1QzhY=;
        b=KwW6dOETB2DFz3CBHQGyWUHO96uKfPuvXGHIOjqUmhLRAElDON6UarlfVakF2490lk
         C1ttkNAj3m8w4BjM00RJODbU9JqJ+E/wf818DWMw/wfnSEDFWNMiitv9XMXXE1kLgZEx
         ZCCD8i3M8FTqwJ4eaeY4sYSvYEGogGozmy+9BCXDU15wNaIaiMnS3AZb2IhpCuBpU4ax
         HsbVWP5b8mpSDKmBpHlk1Bm+Kb5Zk7liAV1RlztYfrasCP9oFSOriupdD59TGpB2TGNv
         dvaneM0JUh8vHQszsV+wvj8SdFz/0S3kHQiVJ1KYftLdBeU9dpw8waWhCSqk22oN0LjO
         fHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sz1SFDMPwknxCtiiBVmt/ZQwgPUFFCvMq8qZ8+1QzhY=;
        b=Hl1QiuPeZS6ipL6gDWdqHqld9JY3PJPYZGy5EysOsDmRwERKY50jdX1A5/WpzFCRIv
         Yh1y5cydQ/PMtLxODI+/koZa7p9FMVDO+lZ6ikuNGg+mNBjYisyXPRGdJLKx16k/CioT
         iGPTDxlxuus+1cuxjMz4SrrN/VlC/EEBbPxyCGrrTeccUOwUT6tTB8wqO8v9VCpGPouc
         zi8sYQ+ey1myuMNdSekUSZOUOGeAYwMGXy0+R/Hz99lJqxWCw97lUHyaRFPyuYtfV1iP
         aTT45b2ZThOSr2iONTbpTci9G+Rv3YtaYTnFBAKm7KUr+gso3C+f2iXvc2wBpqCzXdtn
         vTFA==
X-Gm-Message-State: APjAAAVoU9qmAyeuZVBbU9HZzH/uYMeJKLnA2Uol1z5pFL7gQyxFO7q4
        vaP187VbMmv5/DFF4WSeXXjx1xUd0YiC4OfmQwE=
X-Google-Smtp-Source: APXvYqxA5iWBagV1UhySs0QjbGOQzzTiH+mpubP1IOyGkMT2C5mfCxbXhWeJlP3XM7MtI2E/myeSZDIQEQhAm3yDWW4=
X-Received: by 2002:a5d:968b:: with SMTP id m11mr6830401ion.16.1565231739885;
 Wed, 07 Aug 2019 19:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190806085014.47776-1-carenas@gmail.com> <20190806163658.66932-1-carenas@gmail.com>
 <20190806163658.66932-3-carenas@gmail.com> <ab8a378c-0a60-9554-b2dd-ecb3d05229cb@web.de>
 <CAPUEspip98Mq8FrKTOkEikZhaLPprZXf=E2x3d0b7=c7e5+Gyw@mail.gmail.com> <c7f08e19-88a7-ca7f-90b9-54465e621d49@web.de>
In-Reply-To: <c7f08e19-88a7-ca7f-90b9-54465e621d49@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 7 Aug 2019 19:35:28 -0700
Message-ID: <CAPUEspj4CrEk6u4+8a5UBisxWsXcwOrOPQ5s9TktA6dZx5s+uQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/3] grep: make PCRE2 aware of custom allocator
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 7, 2019 at 6:03 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 07.08.19 um 11:49 schrieb Carlo Arenas:
> > was hoping will perform better but it seems that testing can be done
> > only in windows
>
> nedmalloc works on other platforms as well.

I meant[1] it works reliably enough to be useful for performance testing.

goes without saying that the fact that I am using a virtualbox with 2
CPUs running Debian 10 on top of macOS (a macbook pro with 4 cores)
and the test uses by default 8 threads, doesn't help, but to share my
pain here is the result of running p7820 with my last reroll on top of
pu, comparing a build of the same code without NED (this tree) with
one with it (HEAD)

Test                                               this tree
HEAD
---------------------------------------------------------------------------=
----------------
7820.1: basic grep -i 'how.to'                     0.89(1.12+0.46)
0.95(1.23+0.49) +6.7%
7820.2: extended grep -i 'how.to'                  0.90(1.12+0.49)
0.92(1.19+0.46) +2.2%
7820.3: perl grep -i 'how.to'                      0.54(0.30+0.52)
0.53(0.39+0.52) -1.9%
7820.5: basic grep -i '^how to'                    0.89(1.13+0.47)
0.91(1.13+0.49) +2.2%
7820.6: extended grep -i '^how to'                 0.84(1.04+0.49)
0.94(1.27+0.47) +11.9%
7820.7: perl grep -i '^how to'                     0.49(0.34+0.47)
0.51(0.36+0.49) +4.1%
7820.9: basic grep -i '[how] to'                   1.51(2.31+0.51)
1.55(2.38+0.51) +2.6%
7820.10: extended grep -i '[how] to'               1.50(2.20+0.59)
1.56(2.30+0.62) +4.0%
7820.11: perl grep -i '[how] to'                   0.67(0.50+0.52)
0.62(0.50+0.55) -7.5%
7820.13: basic grep -i '\(e.t[^ ]*\|v.ry\) rare'   2.58(4.39+0.56)
2.64(4.45+0.60) +2.3%
7820.14: extended grep -i '(e.t[^ ]*|v.ry) rare'   2.60(4.41+0.56)
2.66(4.58+0.56) +2.3%
7820.15: perl grep -i '(e.t[^ ]*|v.ry) rare'       1.17(1.66+0.53)
1.23(1.84+0.45) +5.1%
7820.17: basic grep -i 'm\(=C3=BA\|u\)lt.b\(=C3=A6\|y\)te'   1.12(1.54+0.51=
)
1.14(1.70+0.44) +1.8%
7820.18: extended grep -i 'm(=C3=BA|u)lt.b(=C3=A6|y)te'      1.09(1.54+0.48=
)
1.14(1.62+0.49) +4.6%
7820.19: perl grep -i 'm(=C3=BA|u)lt.b(=C3=A6|y)te'          0.87(1.09+0.46=
)
0.90(1.20+0.43) +3.4%

and here one comparing two builds (both with NED)

Test                                               origin/pu
HEAD
---------------------------------------------------------------------------=
----------------
7820.1: basic grep -i 'how.to'                     1.00(1.24+0.55)
0.94(1.19+0.52) -6.0%
7820.2: extended grep -i 'how.to'                  0.90(1.15+0.49)
0.93(1.23+0.44) +3.3%
7820.3: perl grep -i 'how.to'                      0.52(0.37+0.51)
0.59(0.34+0.53) +13.5%
7820.5: basic grep -i '^how to'                    0.89(1.16+0.48)
0.90(1.17+0.47) +1.1%
7820.6: extended grep -i '^how to'                 0.92(1.17+0.50)
0.92(1.20+0.45) +0.0%
7820.7: perl grep -i '^how to'                     0.45(0.33+0.42)
0.54(0.29+0.57) +20.0%
7820.9: basic grep -i '[how] to'                   1.60(2.46+0.52)
1.61(2.39+0.62) +0.6%
7820.10: extended grep -i '[how] to'               1.71(2.67+0.56)
1.57(2.41+0.54) -8.2%
7820.11: perl grep -i '[how] to'                   0.66(0.61+0.51)
0.59(0.44+0.51) -10.6%
7820.13: basic grep -i '\(e.t[^ ]*\|v.ry\) rare'   2.69(4.49+0.66)
2.67(4.49+0.60) -0.7%
7820.14: extended grep -i '(e.t[^ ]*|v.ry) rare'   2.67(4.49+0.64)
2.64(4.54+0.54) -1.1%
7820.15: perl grep -i '(e.t[^ ]*|v.ry) rare'       1.23(1.80+0.47)
1.25(1.89+0.46) +1.6%
7820.17: basic grep -i 'm\(=C3=BA\|u\)lt.b\(=C3=A6\|y\)te'   1.13(1.64+0.47=
)
1.14(1.64+0.48) +0.9%
7820.18: extended grep -i 'm(=C3=BA|u)lt.b(=C3=A6|y)te'      1.16(1.68+0.46=
)
1.20(1.60+0.60) +3.4%
7820.19: perl grep -i 'm(=C3=BA|u)lt.b(=C3=A6|y)te'          0.90(1.16+0.48=
)
0.88(1.17+0.45) -2.2%

with the only relevant line (for my code) being 7820.19 where it would
seem it performs almost the same (eventhough just adding NED made it
initially worst)

note though that the fact there are 20% swings in parts of the code
that hasn't changed
or that where explicitly #ifdef out of my code changes doesn't give me
much confidence, but since the windows guys seem to be using NED by
default, I am hoping it works better there.

note also there were no segfaults (which is what was reported
originally) so something
else must be off.

> On Debian Testing with GCC
> 9.1.0 I need two changes to suppress some compiler warnings, though.
> Will post them as replies.
>
> "make USE_NED_ALLOCATOR=3D1 test" then reports these failures:
>
> t7816-grep-binary-pattern.sh                     (Wstat: 256 Tests: 145 F=
ailed: 5)
>   Failed tests:  48, 54, 57, 60, 63
>   Non-zero exit status: 1

you got me so excited I dusted and old PC and was downloading the debian IS=
O
when I realized the error was not a segfault[2] but my bug.

sorry about it; I would swear I run the full test and it was clean,
but it was most likely
with PCRE1 or the system malloc, and definitely too late at night.

Thanks for your help so far, and while I know it is VERY ugly v4 at
least addresses that
(and uncovered a couple more bugs), thanks also Junio for rerolling it
into pu so at least
we have a chance for it to build and run, and hopefully eventually pass.

Carlo

[1] https://public-inbox.org/git/20190806085014.47776-3-carenas@gmail.com/
[2] https://dev.azure.com/git/git/_build/results?buildId=3D832
