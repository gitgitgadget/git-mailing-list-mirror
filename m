Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C621F404
	for <e@80x24.org>; Sun,  8 Apr 2018 21:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeDHVKm (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 17:10:42 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:45391 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752953AbeDHVKk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 17:10:40 -0400
Received: by mail-oi0-f51.google.com with SMTP id 71-v6so5778191oie.12
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sy9w3//Nhp1Gs/U1PFsUfUIRE0MGzIstmnWuj51auRQ=;
        b=AnZM7aWvkQW97w7dVdZ+0ZXKjYRfRQmg+M+jDH3UzQRTnUez0q7HDJkHWzymu7x+nw
         yrdiPKKsQqN5/0mOoxMBet5USAzMdorrFAW9EiAYyHxWJ4ESxJX8Xl8awqJvLRMGN8cJ
         0Zmg+uihEkCnbhfF4lQ+GJv6IB+l25TMVKSlatOyBh5ehClpFTebjM58yO3Eiav6e3KJ
         gaKnbDTsyPr+nwBX74lsGgbrc22TezTY8OsKdD5mKm/wiGMKQbj8vvciHD58r4ikkcMO
         LhTITPYz4E+7vI3kuL5HAAALECr8IJuYI5wnTCvEVmTkZSOXwU1spwYh5dGbrhafQTIn
         fhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sy9w3//Nhp1Gs/U1PFsUfUIRE0MGzIstmnWuj51auRQ=;
        b=J5MmRgKcLI4JHzVZfgx6xliW0omSQyKFENK4CjcFPrr0nPkUnnwOHWE2+G682vQUIH
         v/63vpvAPzvYTeHxiGcogtBeRdvGBZEaMmOAGL+e45PxM3tGi2N2lSxdUOt+8KXBE5oa
         Pbi78LTU02t1thVVD5aqCMnfYsAFuf8+U2aM6Ghv6cK4FnY8TyI4ldFhA+gPrbuoCpk+
         Hoe9JGeYGgkDZ8DddMpwgo92wpw/Pd08v7LTEgwnT3FFVxI+vNHtq8E0/8+JcnoL4UBy
         7+VVDGbC66ZwWZp7qy+GkBhrobOqpyvWk8dLPBMPosyRiPp9CFydPOClrclkUVVTWeu0
         kvyg==
X-Gm-Message-State: AElRT7Gfwzr4PDn1+w/l+Q/wT/nzYwavv/45dVG0+fy0Vd+j4m0c4C0U
        V4pr4NeTvhekxLob5wqqMOgGVpeo2myavPGSPlAyFg==
X-Google-Smtp-Source: AIpwx4+lDI/NbVV3mqmzKxU6WRGN8pq7Pf2VOQ5fUFdqBVlEeqqC8vDlxOGhF3hnrhPnN1+wu/ni9XQzA7Y/S3m2zHU=
X-Received: by 2002:aca:1a04:: with SMTP id a4-v6mr21122208oia.245.1523221839799;
 Sun, 08 Apr 2018 14:10:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.102.138 with HTTP; Sun, 8 Apr 2018 14:10:39 -0700 (PDT)
In-Reply-To: <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com> <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
From:   Igor Korot <ikorot01@gmail.com>
Date:   Sun, 8 Apr 2018 17:10:39 -0400
Message-ID: <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Eric,
First of, I already have Xcode installed along with the Developer Tools.
Second, here is the list of the different dylib files I found on my system:

MyMac:/ igorkorot$ find . -name libSystem.B.dylib
./Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk/usr/lib/libSystem.B.dylib
./Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk/usr/lib/libSystem.B.dylib
./Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/lib/libSystem.B.dylib
./usr/lib/libSystem.B.dylib

I'm hoping that the dylib in the MacOSX10.9 directory does have that
symbol and maybe if I can check I can export this directory and let
the linker pick it up.

And apparently I was wrong:

MyMac:/ igorkorot$ nm -gU
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/lib/libSystem.B.dylib
| grep strlcpy
MyMac:/ igorkorot$ nm -gU
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk/usr/lib/libSystem.B.dylib
| grep strlcpy
MyMac:/ igorkorot$

I can try to build from source as this becomes my last resort. ;-)

Thank you.


On Sat, Apr 7, 2018 at 3:32 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Apr 6, 2018 at 10:20 PM, Igor Korot <ikorot01@gmail.com> wrote:
>>>> dyld: lazy symbol binding failed: Symbol not found: ___strlcpy_chk
>>>>   Referenced from: /usr/local/git/libexec/git-core/git
>>>>   Expected in: /usr/lib/libSystem.B.dylib
>>>
>>> It's not clear what installer you used? Was it the package from
>>> git-scm? Was it from Homebrew?
>>
>> I just tried the git-scm installer and got exactly the same error
>> during the runtime.
>
> Have you tried any of the suggestions at these pages for resolving this issue?
>
> https://stackoverflow.com/questions/22920497/git-mountain-lion-dyld-lazy-symbol-binding-failed-symbol-not-found-str
>
> https://stackoverflow.com/questions/20929689/git-commands-not-working-in-mac-terminal-dyld-symbol-not-found-strlcpy-ch
>
>>> I would guess that, even if the git-scm installer no longer supports
>>> 10.8, it is likely that Homebrew does. Have you tried it?
>>
>> I don't want to pollute my system with Homebrew.
>>
>>> If both those options fail, you can always build from source.
>>
>> Where do I get the soure code? And how do I build it?
>> I guess I have only one option left. ;-)
>
> Source code for the latest release is at:
> https://github.com/git/git/archive/v2.17.0.zip
>
> To build it, you'll need to have the MacOS Developer Tools installed.
> It's also quite likely that you'll need to build some prerequisite
> libraries; at minimum OpenSSL. You may be able to skip other libraries
> if you don't care about the functionality. Build settings which you
> may need to adjust to disable dependence on libraries in which you're
> not interested are documented at the top of Makefile. Place overrides
> for those settings in a file named config.mak in the git directory.
