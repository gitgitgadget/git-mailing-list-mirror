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
	by dcvr.yhbt.net (Postfix) with ESMTP id B39151F404
	for <e@80x24.org>; Sun,  8 Apr 2018 22:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeDHWhW (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 18:37:22 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:40627 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeDHWhV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 18:37:21 -0400
Received: by mail-oi0-f44.google.com with SMTP id x9-v6so5887418oig.7
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 15:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p/i0aI1i9yXp8ulbPeOXmeUa5l4NDvEpPocxWK2t4Rw=;
        b=nEr+VVntd/seh97U8Xk9dD/m1R3nvUn3ho9NthU9XcbOWEiMSbqWVsBc+Mk2k/I8RV
         3iqdgwmu3ZxPwlTDV2/3jozEQAUyaVOdoCLV0Xpk/ahieYuI+OqtkTsjj77xScJn6PH9
         K9ia4hIalaZ1cF7SM5ORHnMIVjXz3F3eSKB7ojwRaSne2MI12VgX5efoyqfz9rIXkCm4
         TsZLIanYxG6KxIID10VklTkUX6NhQwyNTs92gvcq6lXe4Hqplc2fx9H9Kyxselwfa2Qt
         397/dzBjSQPQg6QK0mbv/VD7EDeu+0zNzaZgliX19csq/Ks10XnBTEnevTkcLpERfnby
         g67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p/i0aI1i9yXp8ulbPeOXmeUa5l4NDvEpPocxWK2t4Rw=;
        b=oUvFVbmjmy9mYt/dbDhu/HhLGyK9srVVerco79U4OxrUyBRhEyUfeI1JTYZkcnr945
         6jAKIT3LmPWT0iKBvxCmm8/yYhdNWuzhm5uJRCNuXTcWoIuVoP5fhXmSq2fAdxlX8UMM
         xIC0CcXtpCbdGVnv+4g0PMemsa4jUo135NuOqF4dhTM0Bn38TffUO8XMhzzyz+BNPnZS
         2BpdswlKs8V3MJplQ6CU/D7cJFQEfwmAAnVBjAKGRE49sZuTYf0JmMWRH78iTsmD31s4
         A5RbD3mIdaPH+blGJjoWpPEBqm7DrgugVst22jEnFWO9NCk2hu8wEan3k6FHM+KgdtAm
         mMJw==
X-Gm-Message-State: ALQs6tAfJ4cVG8jQ6VrlhR9eLaMkI28fO664m5tUxyq1wqepBeUyeeQ1
        R4A96cG1qMQ1eK7RlOJ/4dEKj5kQCoWEwiB7btGw9Q==
X-Google-Smtp-Source: AIpwx487/SterNWfsQfZ6yVYDqOf9mlqW5VS7eaj1Uxcn5xe4/eFmUAHHVIpxyI0pc8OCtUukTjzUE6KNvh5CdXeYEQ=
X-Received: by 2002:aca:f5d8:: with SMTP id t207-v6mr12822236oih.357.1523227040938;
 Sun, 08 Apr 2018 15:37:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.102.138 with HTTP; Sun, 8 Apr 2018 15:37:20 -0700 (PDT)
In-Reply-To: <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
 <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com> <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
From:   Igor Korot <ikorot01@gmail.com>
Date:   Sun, 8 Apr 2018 18:37:20 -0400
Message-ID: <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric,
Sorry for multiple e-mails. I'm just trying to go thru with this.

This is what I tried:

[code]
MyMac:git-2.17.0 igorkorot$ make configure
GIT_VERSION = 2.17.0
    GEN configure
/bin/sh: autoconf: command not found
make: *** [configure] Error 127
MyMac:git-2.17.0 igorkorot$
[/code]

Does this mean that something is a miss?

Thank you.


On Sun, Apr 8, 2018 at 5:10 PM, Igor Korot <ikorot01@gmail.com> wrote:
> Hi, Eric,
> First of, I already have Xcode installed along with the Developer Tools.
> Second, here is the list of the different dylib files I found on my system:
>
> MyMac:/ igorkorot$ find . -name libSystem.B.dylib
> ./Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk/usr/lib/libSystem.B.dylib
> ./Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk/usr/lib/libSystem.B.dylib
> ./Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/lib/libSystem.B.dylib
> ./usr/lib/libSystem.B.dylib
>
> I'm hoping that the dylib in the MacOSX10.9 directory does have that
> symbol and maybe if I can check I can export this directory and let
> the linker pick it up.
>
> And apparently I was wrong:
>
> MyMac:/ igorkorot$ nm -gU
> /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/lib/libSystem.B.dylib
> | grep strlcpy
> MyMac:/ igorkorot$ nm -gU
> /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk/usr/lib/libSystem.B.dylib
> | grep strlcpy
> MyMac:/ igorkorot$
>
> I can try to build from source as this becomes my last resort. ;-)
>
> Thank you.
>
>
> On Sat, Apr 7, 2018 at 3:32 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Fri, Apr 6, 2018 at 10:20 PM, Igor Korot <ikorot01@gmail.com> wrote:
>>>>> dyld: lazy symbol binding failed: Symbol not found: ___strlcpy_chk
>>>>>   Referenced from: /usr/local/git/libexec/git-core/git
>>>>>   Expected in: /usr/lib/libSystem.B.dylib
>>>>
>>>> It's not clear what installer you used? Was it the package from
>>>> git-scm? Was it from Homebrew?
>>>
>>> I just tried the git-scm installer and got exactly the same error
>>> during the runtime.
>>
>> Have you tried any of the suggestions at these pages for resolving this issue?
>>
>> https://stackoverflow.com/questions/22920497/git-mountain-lion-dyld-lazy-symbol-binding-failed-symbol-not-found-str
>>
>> https://stackoverflow.com/questions/20929689/git-commands-not-working-in-mac-terminal-dyld-symbol-not-found-strlcpy-ch
>>
>>>> I would guess that, even if the git-scm installer no longer supports
>>>> 10.8, it is likely that Homebrew does. Have you tried it?
>>>
>>> I don't want to pollute my system with Homebrew.
>>>
>>>> If both those options fail, you can always build from source.
>>>
>>> Where do I get the soure code? And how do I build it?
>>> I guess I have only one option left. ;-)
>>
>> Source code for the latest release is at:
>> https://github.com/git/git/archive/v2.17.0.zip
>>
>> To build it, you'll need to have the MacOS Developer Tools installed.
>> It's also quite likely that you'll need to build some prerequisite
>> libraries; at minimum OpenSSL. You may be able to skip other libraries
>> if you don't care about the functionality. Build settings which you
>> may need to adjust to disable dependence on libraries in which you're
>> not interested are documented at the top of Makefile. Place overrides
>> for those settings in a file named config.mak in the git directory.
