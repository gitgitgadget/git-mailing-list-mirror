Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E271FD6A
	for <e@80x24.org>; Thu,  9 Feb 2017 00:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbdBIAK0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 19:10:26 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:34953 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbdBIAKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 19:10:25 -0500
Received: by mail-ot0-f179.google.com with SMTP id 65so995048otq.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 16:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=pWMyvRwIM1tsMspivx2q2+smmXZXP2fSKaKM2/bTp00=;
        b=MLTemd0XtHoDFNwCP/Y4xs6v5aW7td6FeRFWbpCfjGpETF2vbdbIgkJwKMTao4NuNs
         RmWt2ZVghT7RoUaGLCTZ0EgTS7rTQM8Xp3KCp4ukhaRwBt/DZ0GS8yj5sun5W/xCQUEi
         rTebO1iwOGOo/FoIDnZ/3lT/wx8q/xlV470oOCeNv1UCrlOpkcky8xOiD/9bZRpmNnhB
         XyNG+nKRIEARH124vIBj+IutH9/VwW1Rl3UUmley7K/pnF1pvgW2AygpW8JYGB5UMcnj
         3SKS9kfA0P0Mx2uEvCtoqDeho5pyzOS7hUwmcDlGsF7iAfvU36QowVCBkmBQOs80lj+Q
         xcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=pWMyvRwIM1tsMspivx2q2+smmXZXP2fSKaKM2/bTp00=;
        b=icVkSh0QsfRwlUeGtlXFOiB8G0ZDtWic9u3m26ijNPxL6EucL2estAPWcGrZ/+ezxo
         niHBVYpb6J8jmtyYAbKSpZjLn35mEbzS3oUumffyYfGKIVxHoTAjDwaqepav5cuHLJ4j
         tQm+tVXz+GmYw4DROObU+V57e6eO1c4d7bmf3iRhqLSP1INe7rXh+6dyAF5k+YcQEYjT
         2HLonPPnP3N6/8Cdal8pQVny2u2+eSf+07Gtrp+wxABy4PuD8q01REzdALYqFiHnv6no
         S5yGljouSKbdGlgaM2UpwE3mqTcyXaOxKqxCJo3BussT0Ifv2BbnhJsc3e5KIMVtb7vf
         nVWQ==
X-Gm-Message-State: AMke39lgcvEML2JFah4rxINLFWP7Zo/DQI0vCX1vWC9J5Wd8Ei42mra3HUI/zkCETMC3iW9EE9WenCqxYBwdtg==
X-Received: by 10.157.8.178 with SMTP id 47mr163540otf.188.1486599018988; Wed,
 08 Feb 2017 16:10:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.13.38 with HTTP; Wed, 8 Feb 2017 16:10:18 -0800 (PST)
In-Reply-To: <CAKepmagSysE_31Y3JJwhOKvD_kGfiyEXikep62g=cn9+=v_fZA@mail.gmail.com>
References: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
 <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de> <CAKepmagp2mXNviA2VdT=3EQtZi2LkA_5oG6=AbfkBGKP9Hqiiw@mail.gmail.com>
 <1aa20b4e-782f-a650-eab8-51218b838337@web.de> <CAJZjrdXjnDMi8gMY6f_UDbMZrZJ=AoPM+g01hqPCO2pB9csoOw@mail.gmail.com>
 <CAKepmagwMeky4jPZ-YFgPsZSsyOZZQ-kJSWV8QGg4cUNu-ZS8Q@mail.gmail.com>
 <CAJZjrdWouNaNKU2sX89Xh=QqSbdB7srwgufuquYL_1B7H324Yw@mail.gmail.com>
 <CAKepmai3fBZMS2dXaJyvnP36LooLh8yjn1T6vGG=Pi1B1LMaCQ@mail.gmail.com>
 <CAJZjrdUcxe_K91CQXz_TgGHgXMsKaddwG5+JEWJ53pv5_GO1zw@mail.gmail.com>
 <CAKepmahcaV1Ro_wObkFxezrZntL6JQ_ft+06_3ZSrxEz-yNjzA@mail.gmail.com>
 <CAKepmaidYd4tMRwSNoTTga8s6ji-pc87fZqtxdeDcDVpFhcPWA@mail.gmail.com> <CAKepmagSysE_31Y3JJwhOKvD_kGfiyEXikep62g=cn9+=v_fZA@mail.gmail.com>
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Wed, 8 Feb 2017 19:10:18 -0500
Message-ID: <CAKepmai0NbQmZ-8KCm71qh4cBd9HOzVD1M87TAMhGPYaH1HsHA@mail.gmail.com>
Subject: Re: Trying to use xfuncname without success.
Cc:     git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  where it has grabbed a line at 126 and is using that for the hunk header=
.

When I say that, I mean that it is using that line for *every* hunk
header, for every change, regardless if it has passed a hunk head that
it should have matched.





On Wed, Feb 8, 2017 at 7:01 PM, Jack Adrian Zappa <adrianh.bsc@gmail.com> w=
rote:
> Tried to copy the .git/config file over to the non-working repository
> and it didn't seem to do anything.  Could the git database be
> partially corrupted?
>
> On Wed, Feb 8, 2017 at 7:00 PM, Jack Adrian Zappa <adrianh.bsc@gmail.com>=
 wrote:
>> Well, it mostly works, but I'm getting some weirdness where it has
>> grabbed a line at 126 and is using that for the hunk header.  Strange
>> thing is, I move the file to another repository, commit it, make a
>> change to the fileand do a diff, and it gets the correct hunk header.
>>
>> I'm at a loss. :(
>>
>> On Wed, Feb 8, 2017 at 4:12 PM, Jack Adrian Zappa <adrianh.bsc@gmail.com=
> wrote:
>>> That was it.  I have a .gitattributes file in my home directory.
>>> Ahhh, but it's not in my %userprofile% directory, but in my ~
>>> directory.
>>>
>>> A bit confusing having 2 home directories.  I made a link to my
>>> .gitconfig, but forgot to make a link to my .gitattributes.
>>>
>>> Thanks.
>>>
>>>
>>> A
>>>
>>> On Wed, Feb 8, 2017 at 4:05 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>>>> Double check .gitattributes?
>>>>
>>>> On Feb 8, 2017 2:58 PM, "Jack Adrian Zappa" <adrianh.bsc@gmail.com> wr=
ote:
>>>>>
>>>>> Thanks Samuel,
>>>>>
>>>>> That example showed that there must be something wrong in my .git
>>>>> directory, because with it, I'm getting the correct output.  Moving
>>>>> the same lines to my .git/config didn't work.
>>>>>
>>>>> On Wed, Feb 8, 2017 at 3:46 PM, Samuel Lijin <sxlijin@gmail.com> wrot=
e:
>>>>> > I just put this togther: https://github.com/sxlijin/xfuncname-test
>>>>> >
>>>>> > Try cloning and then for any of config1 thru 3,
>>>>> >
>>>>> > $ cp configX .git/config
>>>>> > $ git diff HEAD^ -- test.natvis
>>>>> >
>>>>> > On Wed, Feb 8, 2017 at 2:42 PM, Jack Adrian Zappa
>>>>> > <adrianh.bsc@gmail.com> wrote:
>>>>> >> Thanks Samuel,
>>>>> >>
>>>>> >> So, the question is, what is causing this problem on my system?
>>>>> >>
>>>>> >> Anyone have an idea to help diagnose this problem?
>>>>> >>
>>>>> >> On Wed, Feb 8, 2017 at 3:24 PM, Samuel Lijin <sxlijin@gmail.com> w=
rote:
>>>>> >>> On Windows 7, it works for me in both CMD and Git Bash:
>>>>> >>>
>>>>> >>> $ git --version
>>>>> >>> git version 2.11.0.windows.3
>>>>> >>>
>>>>> >>> $ git diff HEAD^ --word-diff
>>>>> >>> diff --git a/test.natvis b/test.natvis
>>>>> >>> index 93396ad..1233b8c 100644
>>>>> >>> --- a/test.natvis
>>>>> >>> +++ b/test.natvis
>>>>> >>> @@ -18,6 +18,7 @@ test
>>>>> >>>
>>>>> >>>
>>>>> >>>       <!-- Non-blank line -->
>>>>> >>>       {+<Item Name=3D"added var">added_var</Item>+}
>>>>> >>>
>>>>> >>>
>>>>> >>>       <Item Name=3D"var2">var2</Item>
>>>>> >>>
>>>>> >>> On Wed, Feb 8, 2017 at 12:37 PM, Ren=C3=A9 Scharfe <l.s.r@web.de>=
 wrote:
>>>>> >>>> Am 08.02.2017 um 18:11 schrieb Jack Adrian Zappa:
>>>>> >>>>> Thanks Rene, but you seem to have missed the point.  NOTHING is
>>>>> >>>>> working.  No matter what I put there, it doesn't seem to get
>>>>> >>>>> matched.
>>>>> >>>>
>>>>> >>>> I'm not so sure about that.  With your example I get this diff
>>>>> >>>> without
>>>>> >>>> setting diff.natvis.xfuncname:
>>>>> >>>>
>>>>> >>>> diff --git a/a.natvis b/a.natvis
>>>>> >>>> index 7f9bdf5..bc3c090 100644
>>>>> >>>> --- a/a.natvis
>>>>> >>>> +++ b/a.natvis
>>>>> >>>> @@ -19,7 +19,7 @@
>>>>> >>>> xmlns=3D"http://schemas.microsoft.com/vstudio/debugger/natvis/20=
10">
>>>>> >>>>
>>>>> >>>>
>>>>> >>>>        <!-- Non-blank line -->
>>>>> >>>> -      <Item Name=3D"added var">added_var</Item>
>>>>> >>>> +      <Item Name=3D"added var">added_vars</Item>
>>>>> >>>>
>>>>> >>>>
>>>>> >>>>        <Item Name=3D"var2">var2</Item>
>>>>> >>>>
>>>>> >>>> Note the XML namespace in the hunk header.  It's put there by th=
e
>>>>> >>>> default rule because "xmlns" starts at the beginning of the line=
.
>>>>> >>>> Your
>>>>> >>>> diff has nothing there, which means the default rule is not used=
,
>>>>> >>>> i.e.
>>>>> >>>> your user-defined rule is in effect.
>>>>> >>>>
>>>>> >>>> Come to think of it, this line break in the middle of the
>>>>> >>>> AutoVisualizer
>>>>> >>>> tab might have been added by your email client unintentionally, =
so
>>>>> >>>> that
>>>>> >>>> we use different test files, which then of course results in
>>>>> >>>> different
>>>>> >>>> diffs.  Is that the case?
>>>>> >>>>
>>>>> >>>> Anyway, if I run the following two commands:
>>>>> >>>>
>>>>> >>>> $ git config diff.natvis.xfuncname "^[\t ]*<Type[\t
>>>>> >>>> ]+Name=3D\"([^\"]+)\".*$"
>>>>> >>>> $ echo '*.natvis diff=3Dnatvis' >.gitattributes
>>>>> >>>>
>>>>> >>>> ... then I get this, both on Linux (git version 2.11.1) and on
>>>>> >>>> Windows
>>>>> >>>> (git version 2.11.1.windows.1):
>>>>> >>>>
>>>>> >>>> diff --git a/a.natvis b/a.natvis
>>>>> >>>> index 7f9bdf5..bc3c090 100644
>>>>> >>>> --- a/a.natvis
>>>>> >>>> +++ b/a.natvis
>>>>> >>>> @@ -19,7 +19,7 @@ test
>>>>> >>>>
>>>>> >>>>
>>>>> >>>>        <!-- Non-blank line -->
>>>>> >>>> -      <Item Name=3D"added var">added_var</Item>
>>>>> >>>> +      <Item Name=3D"added var">added_vars</Item>
>>>>> >>>>
>>>>> >>>>
>>>>> >>>>        <Item Name=3D"var2">var2</Item>
>>>>> >>>>
>>>>> >>>>> Just to be sure, I tested your regex and again it didn't work.
>>>>> >>>>
>>>>> >>>> At this point I'm out of ideas, sorry. :(  The only way I was ab=
le to
>>>>> >>>> break it was due to mistyping the extension as "netvis" several =
times
>>>>> >>>> for some reason.
>>>>> >>>>
>>>>> >>>> Ren=C3=A9
