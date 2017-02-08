Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29C821FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 21:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbdBHVEg (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 16:04:36 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36000 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdBHVEf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 16:04:35 -0500
Received: by mail-oi0-f53.google.com with SMTP id u143so89450941oif.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 13:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HzCxZ38XFAo48Ruo83nsCLfJhGnNmgGuk5eequczSTE=;
        b=sIzGutcOjxq9+DCT3zGOM0e8KRWJlenzDvg03TXs8hOOuVBlmqw2KCpUSn/SRVwzbJ
         p6EdDbpLeeJLU468cxfWZlVDRygEObfYbbS3zDxIH2Z1ptVpXNIKO/LalZx0RXA2sWau
         hvts9pbTnDgtCXNEwO7kRr7Hd4aMzsgMxvGhDqGhW5KrXAK0YUiBtXU+A9Ynp692irDQ
         FmijijF0NvUzebjK6DSKQp5HKfCjUmHtyK3Jos5Odae7c9x9fttQgCbUB7zXCboYW8zD
         dz8Cwpq9GfNTK2pRP+0OXIxscNE06mEmgKjeWZOG9P1CpDDYVvmQRAq5esLDE6wKm48c
         x9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HzCxZ38XFAo48Ruo83nsCLfJhGnNmgGuk5eequczSTE=;
        b=SIUbo8/PJcfNYpvjtXsNYv2DSaoGs1976EomK3Br8+nZrg9mtQMLTIWqTeY1Zn3LKX
         8pcFh15BN9Es8BoO9K06Q1W/y6JM1/ziBJzaPc172S30udUAXTrVGhb+50bvKEKYbzAA
         xeA0tH4V55fQZf+rQZz2nhRmwxBkMtjRFBx/XspeETC86JydmfyXqIb7xx4W8KCtBz2Y
         p6f/8nMQKNM/eiSKSzS0Jt8xg9ZpFeI3+pI10cjlsuFH0nI1IhMs/+Rk7r3Rq3kk9uM4
         RW3GhlbmRAr0xJzo0b5PYs9zQ9IBNKOEeC53yb1nRyV9/0RMwzf44rNaB8hKICGIc4nH
         O1rw==
X-Gm-Message-State: AMke39muiFx4P8uL6V71tlz7viz3OYuYthOsXUF8I24LFWZf8D9G2wU50m3RyWuFOGey9weRZjjyaW5zyWOpcQ==
X-Received: by 10.202.234.87 with SMTP id i84mr12126588oih.64.1486587836034;
 Wed, 08 Feb 2017 13:03:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.13.38 with HTTP; Wed, 8 Feb 2017 13:03:55 -0800 (PST)
In-Reply-To: <CAJZjrdWouNaNKU2sX89Xh=QqSbdB7srwgufuquYL_1B7H324Yw@mail.gmail.com>
References: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
 <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de> <CAKepmagp2mXNviA2VdT=3EQtZi2LkA_5oG6=AbfkBGKP9Hqiiw@mail.gmail.com>
 <1aa20b4e-782f-a650-eab8-51218b838337@web.de> <CAJZjrdXjnDMi8gMY6f_UDbMZrZJ=AoPM+g01hqPCO2pB9csoOw@mail.gmail.com>
 <CAKepmagwMeky4jPZ-YFgPsZSsyOZZQ-kJSWV8QGg4cUNu-ZS8Q@mail.gmail.com> <CAJZjrdWouNaNKU2sX89Xh=QqSbdB7srwgufuquYL_1B7H324Yw@mail.gmail.com>
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Wed, 8 Feb 2017 16:03:55 -0500
Message-ID: <CAKepmahgo2mbzc1Ws6vi6kRzqsD=UWcOGi0w+dz3FbgafEBmFw@mail.gmail.com>
Subject: Re: Trying to use xfuncname without success.
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Samuel,

That example showed that there must be something wrong in my .git
directory, because with it, I'm getting the correct output.  Moving
the same lines to my .git/config didn't work.

On Wed, Feb 8, 2017 at 3:46 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
> I just put this togther: https://github.com/sxlijin/xfuncname-test
>
> Try cloning and then for any of config1 thru 3,
>
> $ cp configX .git/config
> $ git diff HEAD^ -- test.natvis
>
> On Wed, Feb 8, 2017 at 2:42 PM, Jack Adrian Zappa <adrianh.bsc@gmail.com>=
 wrote:
>> Thanks Samuel,
>>
>> So, the question is, what is causing this problem on my system?
>>
>> Anyone have an idea to help diagnose this problem?
>>
>> On Wed, Feb 8, 2017 at 3:24 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>>> On Windows 7, it works for me in both CMD and Git Bash:
>>>
>>> $ git --version
>>> git version 2.11.0.windows.3
>>>
>>> $ git diff HEAD^ --word-diff
>>> diff --git a/test.natvis b/test.natvis
>>> index 93396ad..1233b8c 100644
>>> --- a/test.natvis
>>> +++ b/test.natvis
>>> @@ -18,6 +18,7 @@ test
>>>
>>>
>>>       <!-- Non-blank line -->
>>>       {+<Item Name=3D"added var">added_var</Item>+}
>>>
>>>
>>>       <Item Name=3D"var2">var2</Item>
>>>
>>> On Wed, Feb 8, 2017 at 12:37 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
>>>> Am 08.02.2017 um 18:11 schrieb Jack Adrian Zappa:
>>>>> Thanks Rene, but you seem to have missed the point.  NOTHING is
>>>>> working.  No matter what I put there, it doesn't seem to get matched.
>>>>
>>>> I'm not so sure about that.  With your example I get this diff without
>>>> setting diff.natvis.xfuncname:
>>>>
>>>> diff --git a/a.natvis b/a.natvis
>>>> index 7f9bdf5..bc3c090 100644
>>>> --- a/a.natvis
>>>> +++ b/a.natvis
>>>> @@ -19,7 +19,7 @@ xmlns=3D"http://schemas.microsoft.com/vstudio/debugg=
er/natvis/2010">
>>>>
>>>>
>>>>        <!-- Non-blank line -->
>>>> -      <Item Name=3D"added var">added_var</Item>
>>>> +      <Item Name=3D"added var">added_vars</Item>
>>>>
>>>>
>>>>        <Item Name=3D"var2">var2</Item>
>>>>
>>>> Note the XML namespace in the hunk header.  It's put there by the
>>>> default rule because "xmlns" starts at the beginning of the line.  You=
r
>>>> diff has nothing there, which means the default rule is not used, i.e.
>>>> your user-defined rule is in effect.
>>>>
>>>> Come to think of it, this line break in the middle of the AutoVisualiz=
er
>>>> tab might have been added by your email client unintentionally, so tha=
t
>>>> we use different test files, which then of course results in different
>>>> diffs.  Is that the case?
>>>>
>>>> Anyway, if I run the following two commands:
>>>>
>>>> $ git config diff.natvis.xfuncname "^[\t ]*<Type[\t ]+Name=3D\"([^\"]+=
)\".*$"
>>>> $ echo '*.natvis diff=3Dnatvis' >.gitattributes
>>>>
>>>> ... then I get this, both on Linux (git version 2.11.1) and on Windows
>>>> (git version 2.11.1.windows.1):
>>>>
>>>> diff --git a/a.natvis b/a.natvis
>>>> index 7f9bdf5..bc3c090 100644
>>>> --- a/a.natvis
>>>> +++ b/a.natvis
>>>> @@ -19,7 +19,7 @@ test
>>>>
>>>>
>>>>        <!-- Non-blank line -->
>>>> -      <Item Name=3D"added var">added_var</Item>
>>>> +      <Item Name=3D"added var">added_vars</Item>
>>>>
>>>>
>>>>        <Item Name=3D"var2">var2</Item>
>>>>
>>>>> Just to be sure, I tested your regex and again it didn't work.
>>>>
>>>> At this point I'm out of ideas, sorry. :(  The only way I was able to
>>>> break it was due to mistyping the extension as "netvis" several times
>>>> for some reason.
>>>>
>>>> Ren=C3=A9
