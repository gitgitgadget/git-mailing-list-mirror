Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD8A1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 20:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdBHUr5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 15:47:57 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33686 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbdBHUry (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 15:47:54 -0500
Received: by mail-ua0-f193.google.com with SMTP id d5so13836650uag.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 12:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JHNr8pafqULrYgWbhZ/ivf4ys2mE7tTvEyYpFvYnAA8=;
        b=ZiYRga4Qbv4RKv5Nltj9AGKni5t8nxAQ8mRo4R68bSmr6Ki9kz9kx5l3nP/FzDIzt2
         Btw6zBVeaILGzTMC9vqHcEx8+3XlDmOFbSlDXS4aia4SE9Jg0GPSUqlJm2+JdFBETW+l
         E8T9+ri6+NVLa8xW94DaW/a6CTBLxTb1BvE7yNbi7qOM3lmb3iYO7htZ+o39egwym8PP
         vmnRntt7ZByA7s9/jaU0roW6M2wKpbGocTXn3iGd9Wd46kN7XrJAbootYr8K8pI9EL9P
         bKqg0C3QChJgysOMxCkerg7bbj1tGA5Osk2eKIkwtSBePNhKJoQwGoCybubSPI7nxm8I
         uKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JHNr8pafqULrYgWbhZ/ivf4ys2mE7tTvEyYpFvYnAA8=;
        b=JxdlagDJOx9hv6c7FwAJA8SZmjriXgkKh3Ujr6zcTKMkwd45/Tl6zbSVHotH40t27o
         gc+eeCVHOI0onZC3Tpv9FsBAzZeYPT4ZPP3w5UrlSXBeNlI4NEOcyE33eOw+R4a+vJlF
         uVzTsXRTEazqG2YycRdvVJJVqjOEhHJXrc/PqXUUW7+sEE5+BdjByPBDDrfFh/0Fhm9Y
         rB+U0+Q1v4EMaUHMF9RLgoHB1X5//skZxq/FtOT0bedP//F4Vu7yOjSl8jV9yB0WxBJO
         Fw7JGTfTNCBz+xBRM1jak4p4ZYlgN6zXeGqrEhgCTECZhitl3xRZtu3BRpvyZdu76RZ1
         B1KQ==
X-Gm-Message-State: AIkVDXLvgmkv9J7KLXCbyh0Y7qu47IYxIdcxJ+R2XeVvczO6wNf/36SqXx7WEqUEs+c5TC+U2BEqVFLzdyR4fQ==
X-Received: by 10.159.48.85 with SMTP id i21mr12009774uab.73.1486586830437;
 Wed, 08 Feb 2017 12:47:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Wed, 8 Feb 2017 12:46:30 -0800 (PST)
In-Reply-To: <CAKepmagwMeky4jPZ-YFgPsZSsyOZZQ-kJSWV8QGg4cUNu-ZS8Q@mail.gmail.com>
References: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
 <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de> <CAKepmagp2mXNviA2VdT=3EQtZi2LkA_5oG6=AbfkBGKP9Hqiiw@mail.gmail.com>
 <1aa20b4e-782f-a650-eab8-51218b838337@web.de> <CAJZjrdXjnDMi8gMY6f_UDbMZrZJ=AoPM+g01hqPCO2pB9csoOw@mail.gmail.com>
 <CAKepmagwMeky4jPZ-YFgPsZSsyOZZQ-kJSWV8QGg4cUNu-ZS8Q@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 8 Feb 2017 14:46:30 -0600
Message-ID: <CAJZjrdWouNaNKU2sX89Xh=QqSbdB7srwgufuquYL_1B7H324Yw@mail.gmail.com>
Subject: Re: Trying to use xfuncname without success.
To:     Jack Adrian Zappa <adrianh.bsc@gmail.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just put this togther: https://github.com/sxlijin/xfuncname-test

Try cloning and then for any of config1 thru 3,

$ cp configX .git/config
$ git diff HEAD^ -- test.natvis

On Wed, Feb 8, 2017 at 2:42 PM, Jack Adrian Zappa <adrianh.bsc@gmail.com> w=
rote:
> Thanks Samuel,
>
> So, the question is, what is causing this problem on my system?
>
> Anyone have an idea to help diagnose this problem?
>
> On Wed, Feb 8, 2017 at 3:24 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>> On Windows 7, it works for me in both CMD and Git Bash:
>>
>> $ git --version
>> git version 2.11.0.windows.3
>>
>> $ git diff HEAD^ --word-diff
>> diff --git a/test.natvis b/test.natvis
>> index 93396ad..1233b8c 100644
>> --- a/test.natvis
>> +++ b/test.natvis
>> @@ -18,6 +18,7 @@ test
>>
>>
>>       <!-- Non-blank line -->
>>       {+<Item Name=3D"added var">added_var</Item>+}
>>
>>
>>       <Item Name=3D"var2">var2</Item>
>>
>> On Wed, Feb 8, 2017 at 12:37 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>> Am 08.02.2017 um 18:11 schrieb Jack Adrian Zappa:
>>>> Thanks Rene, but you seem to have missed the point.  NOTHING is
>>>> working.  No matter what I put there, it doesn't seem to get matched.
>>>
>>> I'm not so sure about that.  With your example I get this diff without
>>> setting diff.natvis.xfuncname:
>>>
>>> diff --git a/a.natvis b/a.natvis
>>> index 7f9bdf5..bc3c090 100644
>>> --- a/a.natvis
>>> +++ b/a.natvis
>>> @@ -19,7 +19,7 @@ xmlns=3D"http://schemas.microsoft.com/vstudio/debugge=
r/natvis/2010">
>>>
>>>
>>>        <!-- Non-blank line -->
>>> -      <Item Name=3D"added var">added_var</Item>
>>> +      <Item Name=3D"added var">added_vars</Item>
>>>
>>>
>>>        <Item Name=3D"var2">var2</Item>
>>>
>>> Note the XML namespace in the hunk header.  It's put there by the
>>> default rule because "xmlns" starts at the beginning of the line.  Your
>>> diff has nothing there, which means the default rule is not used, i.e.
>>> your user-defined rule is in effect.
>>>
>>> Come to think of it, this line break in the middle of the AutoVisualize=
r
>>> tab might have been added by your email client unintentionally, so that
>>> we use different test files, which then of course results in different
>>> diffs.  Is that the case?
>>>
>>> Anyway, if I run the following two commands:
>>>
>>> $ git config diff.natvis.xfuncname "^[\t ]*<Type[\t ]+Name=3D\"([^\"]+)=
\".*$"
>>> $ echo '*.natvis diff=3Dnatvis' >.gitattributes
>>>
>>> ... then I get this, both on Linux (git version 2.11.1) and on Windows
>>> (git version 2.11.1.windows.1):
>>>
>>> diff --git a/a.natvis b/a.natvis
>>> index 7f9bdf5..bc3c090 100644
>>> --- a/a.natvis
>>> +++ b/a.natvis
>>> @@ -19,7 +19,7 @@ test
>>>
>>>
>>>        <!-- Non-blank line -->
>>> -      <Item Name=3D"added var">added_var</Item>
>>> +      <Item Name=3D"added var">added_vars</Item>
>>>
>>>
>>>        <Item Name=3D"var2">var2</Item>
>>>
>>>> Just to be sure, I tested your regex and again it didn't work.
>>>
>>> At this point I'm out of ideas, sorry. :(  The only way I was able to
>>> break it was due to mistyping the extension as "netvis" several times
>>> for some reason.
>>>
>>> Ren=C3=A9
