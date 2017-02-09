Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDCF81FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 00:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbdBIABf (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 19:01:35 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:36308 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbdBIABe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 19:01:34 -0500
Received: by mail-ot0-f177.google.com with SMTP id 32so811024oth.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 16:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=ZWE9RCwGzftwdd9hbaVkD/ReTEZtlLokowz9uq8h5G4=;
        b=qm98oQ4B2EtuYXy7yR+8rNoXQoLZSU/g/FaskPC+7Y1Q/Xk19G1NE4h17DV9O3A0TT
         4ry/YhRwRGICM+OfcQkWFT429wBmoLh4mHRjHo5DOQCT2zhZa/Iu6uMk/GL02FaT8xeh
         PNbi6acEkr29wLw3wW20HkCCWqNocE1Wf35xshu3m5yk6l1/A09MEH1JOXzyc7W2OfSU
         eRdRwrV6QuJncXYETqLdm6O5TevygazGqhegLtfdZt1byn0hAKmnXh/WRZy+vUjduta9
         R/07/WnBOo/AzTRocIKAVEznUMUTUW0SqOauyh1d9elmLF1rz7VUWJUzOs8SvPcAbfk6
         N9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=ZWE9RCwGzftwdd9hbaVkD/ReTEZtlLokowz9uq8h5G4=;
        b=gLSLVdFvHUEDSIb6MsUOqYjgysmiK2GEeACa8cBsNNVPd6PKsdEgNTAvXoYEHq2XSO
         bRMD0gZW4F+3Cnc2qG8dB8xWQ/kLssvSfOS/UF4Lj+I+u8CNVV170YcjWkWg3XCxcB+8
         pbmGESa5Mf34SLK5LxAslCtwka0wfIA7x4DXxyUxLnFjaqTPQHiynFejluWtuTN8tC35
         dVoI0eCygmxG9kkeKykLfpsosDxLMMQeXHSeJRVDRJ3VKgU8Y6CrT/mCfB4L+tPqxaVM
         uVg2WIsP/U0X1oUq7i2vCtqotMYliiiA91J3nCEbfL8NXRq9y349dDop12UVHQkHobMd
         WqbQ==
X-Gm-Message-State: AMke39m6pXf+Mi3qIiVTiVWtNGNaqwplPMHe0aewI2z8KZzP5j2lyvkeB0TJcqy4v1h7HjIrydNV1438it5QMw==
X-Received: by 10.157.51.19 with SMTP id f19mr139568otc.18.1486598434820; Wed,
 08 Feb 2017 16:00:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.13.38 with HTTP; Wed, 8 Feb 2017 16:00:34 -0800 (PST)
In-Reply-To: <CAKepmahcaV1Ro_wObkFxezrZntL6JQ_ft+06_3ZSrxEz-yNjzA@mail.gmail.com>
References: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
 <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de> <CAKepmagp2mXNviA2VdT=3EQtZi2LkA_5oG6=AbfkBGKP9Hqiiw@mail.gmail.com>
 <1aa20b4e-782f-a650-eab8-51218b838337@web.de> <CAJZjrdXjnDMi8gMY6f_UDbMZrZJ=AoPM+g01hqPCO2pB9csoOw@mail.gmail.com>
 <CAKepmagwMeky4jPZ-YFgPsZSsyOZZQ-kJSWV8QGg4cUNu-ZS8Q@mail.gmail.com>
 <CAJZjrdWouNaNKU2sX89Xh=QqSbdB7srwgufuquYL_1B7H324Yw@mail.gmail.com>
 <CAKepmai3fBZMS2dXaJyvnP36LooLh8yjn1T6vGG=Pi1B1LMaCQ@mail.gmail.com>
 <CAJZjrdUcxe_K91CQXz_TgGHgXMsKaddwG5+JEWJ53pv5_GO1zw@mail.gmail.com> <CAKepmahcaV1Ro_wObkFxezrZntL6JQ_ft+06_3ZSrxEz-yNjzA@mail.gmail.com>
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Wed, 8 Feb 2017 19:00:34 -0500
Message-ID: <CAKepmaidYd4tMRwSNoTTga8s6ji-pc87fZqtxdeDcDVpFhcPWA@mail.gmail.com>
Subject: Re: Trying to use xfuncname without success.
Cc:     git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Well, it mostly works, but I'm getting some weirdness where it has
grabbed a line at 126 and is using that for the hunk header.  Strange
thing is, I move the file to another repository, commit it, make a
change to the fileand do a diff, and it gets the correct hunk header.

I'm at a loss. :(

On Wed, Feb 8, 2017 at 4:12 PM, Jack Adrian Zappa <adrianh.bsc@gmail.com> w=
rote:
> That was it.  I have a .gitattributes file in my home directory.
> Ahhh, but it's not in my %userprofile% directory, but in my ~
> directory.
>
> A bit confusing having 2 home directories.  I made a link to my
> .gitconfig, but forgot to make a link to my .gitattributes.
>
> Thanks.
>
>
> A
>
> On Wed, Feb 8, 2017 at 4:05 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>> Double check .gitattributes?
>>
>> On Feb 8, 2017 2:58 PM, "Jack Adrian Zappa" <adrianh.bsc@gmail.com> wrot=
e:
>>>
>>> Thanks Samuel,
>>>
>>> That example showed that there must be something wrong in my .git
>>> directory, because with it, I'm getting the correct output.  Moving
>>> the same lines to my .git/config didn't work.
>>>
>>> On Wed, Feb 8, 2017 at 3:46 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>>> > I just put this togther: https://github.com/sxlijin/xfuncname-test
>>> >
>>> > Try cloning and then for any of config1 thru 3,
>>> >
>>> > $ cp configX .git/config
>>> > $ git diff HEAD^ -- test.natvis
>>> >
>>> > On Wed, Feb 8, 2017 at 2:42 PM, Jack Adrian Zappa
>>> > <adrianh.bsc@gmail.com> wrote:
>>> >> Thanks Samuel,
>>> >>
>>> >> So, the question is, what is causing this problem on my system?
>>> >>
>>> >> Anyone have an idea to help diagnose this problem?
>>> >>
>>> >> On Wed, Feb 8, 2017 at 3:24 PM, Samuel Lijin <sxlijin@gmail.com> wro=
te:
>>> >>> On Windows 7, it works for me in both CMD and Git Bash:
>>> >>>
>>> >>> $ git --version
>>> >>> git version 2.11.0.windows.3
>>> >>>
>>> >>> $ git diff HEAD^ --word-diff
>>> >>> diff --git a/test.natvis b/test.natvis
>>> >>> index 93396ad..1233b8c 100644
>>> >>> --- a/test.natvis
>>> >>> +++ b/test.natvis
>>> >>> @@ -18,6 +18,7 @@ test
>>> >>>
>>> >>>
>>> >>>       <!-- Non-blank line -->
>>> >>>       {+<Item Name=3D"added var">added_var</Item>+}
>>> >>>
>>> >>>
>>> >>>       <Item Name=3D"var2">var2</Item>
>>> >>>
>>> >>> On Wed, Feb 8, 2017 at 12:37 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> w=
rote:
>>> >>>> Am 08.02.2017 um 18:11 schrieb Jack Adrian Zappa:
>>> >>>>> Thanks Rene, but you seem to have missed the point.  NOTHING is
>>> >>>>> working.  No matter what I put there, it doesn't seem to get
>>> >>>>> matched.
>>> >>>>
>>> >>>> I'm not so sure about that.  With your example I get this diff
>>> >>>> without
>>> >>>> setting diff.natvis.xfuncname:
>>> >>>>
>>> >>>> diff --git a/a.natvis b/a.natvis
>>> >>>> index 7f9bdf5..bc3c090 100644
>>> >>>> --- a/a.natvis
>>> >>>> +++ b/a.natvis
>>> >>>> @@ -19,7 +19,7 @@
>>> >>>> xmlns=3D"http://schemas.microsoft.com/vstudio/debugger/natvis/2010=
">
>>> >>>>
>>> >>>>
>>> >>>>        <!-- Non-blank line -->
>>> >>>> -      <Item Name=3D"added var">added_var</Item>
>>> >>>> +      <Item Name=3D"added var">added_vars</Item>
>>> >>>>
>>> >>>>
>>> >>>>        <Item Name=3D"var2">var2</Item>
>>> >>>>
>>> >>>> Note the XML namespace in the hunk header.  It's put there by the
>>> >>>> default rule because "xmlns" starts at the beginning of the line.
>>> >>>> Your
>>> >>>> diff has nothing there, which means the default rule is not used,
>>> >>>> i.e.
>>> >>>> your user-defined rule is in effect.
>>> >>>>
>>> >>>> Come to think of it, this line break in the middle of the
>>> >>>> AutoVisualizer
>>> >>>> tab might have been added by your email client unintentionally, so
>>> >>>> that
>>> >>>> we use different test files, which then of course results in
>>> >>>> different
>>> >>>> diffs.  Is that the case?
>>> >>>>
>>> >>>> Anyway, if I run the following two commands:
>>> >>>>
>>> >>>> $ git config diff.natvis.xfuncname "^[\t ]*<Type[\t
>>> >>>> ]+Name=3D\"([^\"]+)\".*$"
>>> >>>> $ echo '*.natvis diff=3Dnatvis' >.gitattributes
>>> >>>>
>>> >>>> ... then I get this, both on Linux (git version 2.11.1) and on
>>> >>>> Windows
>>> >>>> (git version 2.11.1.windows.1):
>>> >>>>
>>> >>>> diff --git a/a.natvis b/a.natvis
>>> >>>> index 7f9bdf5..bc3c090 100644
>>> >>>> --- a/a.natvis
>>> >>>> +++ b/a.natvis
>>> >>>> @@ -19,7 +19,7 @@ test
>>> >>>>
>>> >>>>
>>> >>>>        <!-- Non-blank line -->
>>> >>>> -      <Item Name=3D"added var">added_var</Item>
>>> >>>> +      <Item Name=3D"added var">added_vars</Item>
>>> >>>>
>>> >>>>
>>> >>>>        <Item Name=3D"var2">var2</Item>
>>> >>>>
>>> >>>>> Just to be sure, I tested your regex and again it didn't work.
>>> >>>>
>>> >>>> At this point I'm out of ideas, sorry. :(  The only way I was able=
 to
>>> >>>> break it was due to mistyping the extension as "netvis" several ti=
mes
>>> >>>> for some reason.
>>> >>>>
>>> >>>> Ren=C3=A9
