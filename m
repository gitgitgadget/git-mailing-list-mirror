Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F3F1FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 00:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbdBIACB (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 19:02:01 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33128 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdBIACA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 19:02:00 -0500
Received: by mail-oi0-f50.google.com with SMTP id w204so91936052oiw.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 16:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WoeQQjv1Sl/pB0nwvpzjubyZ/FH+WH+UDE/2W0p+FVk=;
        b=Eui2aQPvlsgeSfQKDqjwXq2lQMCWv5MOyKBdiV6ioC78aGhGhryEI2NRjxFyNwYTs1
         hcKi81mScFfbmTJ1ghcFOLM/Vnk0Ow8DAA5zJki3kAKyJpzs2PRT2vEv4ACt8GrHqp/1
         Am4hi5p2Pm8CNjI5QGectsNQ3rR8A0GvcpoMCyevQDElPRCyuEJDi/lKrqJdifBAlb9m
         Py4H5GqcwLC7xGHdWjT0WEoaZFCVFWAZD1YaE319vOah4R6QqAZJBIcSfMVO9ZUzzjbv
         S4o6X3gC6mbIU3w2MnsNsApT7XM/BtUF13mGgllykAtvsPgyCnUOZYjK0LFL+61z9kQq
         63yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WoeQQjv1Sl/pB0nwvpzjubyZ/FH+WH+UDE/2W0p+FVk=;
        b=QvS9Mu2jfxiqwVTMzRwnLoPYcxCSSBs4raQTMHpZU4LeNZZQVC4SP2I4ORe4jeGMJg
         fSeL9CR8rhNTOSsxGfpK5Yz5t+ryXl11oyum4o6Mf3TlS6R+pm1Sr61SKgQjOkgmca3t
         /fX7/Y4pat/MvfZlNDg/6lYYvjYjW3TKWwVs2vc6NgEcry35k2FTJGndKLTy7WbHKx5m
         vRuJ+RlC45sFNx5rxr0AwQaCDTX15SGoYf04G7aGehrHWMsRk+UWxkKZyoMjeFjKINL2
         fpXBTU2bjrhVf9edsIOJxKqWRWstQCM4RfmSyCP4RntuM+Quqf3il/yZt2CyW+BMepkI
         T/kA==
X-Gm-Message-State: AMke39mx/xYEY5MnWDQPCSoOXzP939+jVqXRp+YT727IE856G6xFf0YgHjDN30XOgohX7pExSNLxbm+KiC1Kow==
X-Received: by 10.202.190.136 with SMTP id o130mr130967oif.14.1486598514418;
 Wed, 08 Feb 2017 16:01:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.13.38 with HTTP; Wed, 8 Feb 2017 16:01:53 -0800 (PST)
In-Reply-To: <CAKepmaidYd4tMRwSNoTTga8s6ji-pc87fZqtxdeDcDVpFhcPWA@mail.gmail.com>
References: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
 <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de> <CAKepmagp2mXNviA2VdT=3EQtZi2LkA_5oG6=AbfkBGKP9Hqiiw@mail.gmail.com>
 <1aa20b4e-782f-a650-eab8-51218b838337@web.de> <CAJZjrdXjnDMi8gMY6f_UDbMZrZJ=AoPM+g01hqPCO2pB9csoOw@mail.gmail.com>
 <CAKepmagwMeky4jPZ-YFgPsZSsyOZZQ-kJSWV8QGg4cUNu-ZS8Q@mail.gmail.com>
 <CAJZjrdWouNaNKU2sX89Xh=QqSbdB7srwgufuquYL_1B7H324Yw@mail.gmail.com>
 <CAKepmai3fBZMS2dXaJyvnP36LooLh8yjn1T6vGG=Pi1B1LMaCQ@mail.gmail.com>
 <CAJZjrdUcxe_K91CQXz_TgGHgXMsKaddwG5+JEWJ53pv5_GO1zw@mail.gmail.com>
 <CAKepmahcaV1Ro_wObkFxezrZntL6JQ_ft+06_3ZSrxEz-yNjzA@mail.gmail.com> <CAKepmaidYd4tMRwSNoTTga8s6ji-pc87fZqtxdeDcDVpFhcPWA@mail.gmail.com>
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Wed, 8 Feb 2017 19:01:53 -0500
Message-ID: <CAKepmagSysE_31Y3JJwhOKvD_kGfiyEXikep62g=cn9+=v_fZA@mail.gmail.com>
Subject: Re: Trying to use xfuncname without success.
To:     Jack Adrian Zappa <adrianh.bsc@gmail.com>
Cc:     git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tried to copy the .git/config file over to the non-working repository
and it didn't seem to do anything.  Could the git database be
partially corrupted?

On Wed, Feb 8, 2017 at 7:00 PM, Jack Adrian Zappa <adrianh.bsc@gmail.com> w=
rote:
> Well, it mostly works, but I'm getting some weirdness where it has
> grabbed a line at 126 and is using that for the hunk header.  Strange
> thing is, I move the file to another repository, commit it, make a
> change to the fileand do a diff, and it gets the correct hunk header.
>
> I'm at a loss. :(
>
> On Wed, Feb 8, 2017 at 4:12 PM, Jack Adrian Zappa <adrianh.bsc@gmail.com>=
 wrote:
>> That was it.  I have a .gitattributes file in my home directory.
>> Ahhh, but it's not in my %userprofile% directory, but in my ~
>> directory.
>>
>> A bit confusing having 2 home directories.  I made a link to my
>> .gitconfig, but forgot to make a link to my .gitattributes.
>>
>> Thanks.
>>
>>
>> A
>>
>> On Wed, Feb 8, 2017 at 4:05 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>>> Double check .gitattributes?
>>>
>>> On Feb 8, 2017 2:58 PM, "Jack Adrian Zappa" <adrianh.bsc@gmail.com> wro=
te:
>>>>
>>>> Thanks Samuel,
>>>>
>>>> That example showed that there must be something wrong in my .git
>>>> directory, because with it, I'm getting the correct output.  Moving
>>>> the same lines to my .git/config didn't work.
>>>>
>>>> On Wed, Feb 8, 2017 at 3:46 PM, Samuel Lijin <sxlijin@gmail.com> wrote=
:
>>>> > I just put this togther: https://github.com/sxlijin/xfuncname-test
>>>> >
>>>> > Try cloning and then for any of config1 thru 3,
>>>> >
>>>> > $ cp configX .git/config
>>>> > $ git diff HEAD^ -- test.natvis
>>>> >
>>>> > On Wed, Feb 8, 2017 at 2:42 PM, Jack Adrian Zappa
>>>> > <adrianh.bsc@gmail.com> wrote:
>>>> >> Thanks Samuel,
>>>> >>
>>>> >> So, the question is, what is causing this problem on my system?
>>>> >>
>>>> >> Anyone have an idea to help diagnose this problem?
>>>> >>
>>>> >> On Wed, Feb 8, 2017 at 3:24 PM, Samuel Lijin <sxlijin@gmail.com> wr=
ote:
>>>> >>> On Windows 7, it works for me in both CMD and Git Bash:
>>>> >>>
>>>> >>> $ git --version
>>>> >>> git version 2.11.0.windows.3
>>>> >>>
>>>> >>> $ git diff HEAD^ --word-diff
>>>> >>> diff --git a/test.natvis b/test.natvis
>>>> >>> index 93396ad..1233b8c 100644
>>>> >>> --- a/test.natvis
>>>> >>> +++ b/test.natvis
>>>> >>> @@ -18,6 +18,7 @@ test
>>>> >>>
>>>> >>>
>>>> >>>       <!-- Non-blank line -->
>>>> >>>       {+<Item Name=3D"added var">added_var</Item>+}
>>>> >>>
>>>> >>>
>>>> >>>       <Item Name=3D"var2">var2</Item>
>>>> >>>
>>>> >>> On Wed, Feb 8, 2017 at 12:37 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> =
wrote:
>>>> >>>> Am 08.02.2017 um 18:11 schrieb Jack Adrian Zappa:
>>>> >>>>> Thanks Rene, but you seem to have missed the point.  NOTHING is
>>>> >>>>> working.  No matter what I put there, it doesn't seem to get
>>>> >>>>> matched.
>>>> >>>>
>>>> >>>> I'm not so sure about that.  With your example I get this diff
>>>> >>>> without
>>>> >>>> setting diff.natvis.xfuncname:
>>>> >>>>
>>>> >>>> diff --git a/a.natvis b/a.natvis
>>>> >>>> index 7f9bdf5..bc3c090 100644
>>>> >>>> --- a/a.natvis
>>>> >>>> +++ b/a.natvis
>>>> >>>> @@ -19,7 +19,7 @@
>>>> >>>> xmlns=3D"http://schemas.microsoft.com/vstudio/debugger/natvis/201=
0">
>>>> >>>>
>>>> >>>>
>>>> >>>>        <!-- Non-blank line -->
>>>> >>>> -      <Item Name=3D"added var">added_var</Item>
>>>> >>>> +      <Item Name=3D"added var">added_vars</Item>
>>>> >>>>
>>>> >>>>
>>>> >>>>        <Item Name=3D"var2">var2</Item>
>>>> >>>>
>>>> >>>> Note the XML namespace in the hunk header.  It's put there by the
>>>> >>>> default rule because "xmlns" starts at the beginning of the line.
>>>> >>>> Your
>>>> >>>> diff has nothing there, which means the default rule is not used,
>>>> >>>> i.e.
>>>> >>>> your user-defined rule is in effect.
>>>> >>>>
>>>> >>>> Come to think of it, this line break in the middle of the
>>>> >>>> AutoVisualizer
>>>> >>>> tab might have been added by your email client unintentionally, s=
o
>>>> >>>> that
>>>> >>>> we use different test files, which then of course results in
>>>> >>>> different
>>>> >>>> diffs.  Is that the case?
>>>> >>>>
>>>> >>>> Anyway, if I run the following two commands:
>>>> >>>>
>>>> >>>> $ git config diff.natvis.xfuncname "^[\t ]*<Type[\t
>>>> >>>> ]+Name=3D\"([^\"]+)\".*$"
>>>> >>>> $ echo '*.natvis diff=3Dnatvis' >.gitattributes
>>>> >>>>
>>>> >>>> ... then I get this, both on Linux (git version 2.11.1) and on
>>>> >>>> Windows
>>>> >>>> (git version 2.11.1.windows.1):
>>>> >>>>
>>>> >>>> diff --git a/a.natvis b/a.natvis
>>>> >>>> index 7f9bdf5..bc3c090 100644
>>>> >>>> --- a/a.natvis
>>>> >>>> +++ b/a.natvis
>>>> >>>> @@ -19,7 +19,7 @@ test
>>>> >>>>
>>>> >>>>
>>>> >>>>        <!-- Non-blank line -->
>>>> >>>> -      <Item Name=3D"added var">added_var</Item>
>>>> >>>> +      <Item Name=3D"added var">added_vars</Item>
>>>> >>>>
>>>> >>>>
>>>> >>>>        <Item Name=3D"var2">var2</Item>
>>>> >>>>
>>>> >>>>> Just to be sure, I tested your regex and again it didn't work.
>>>> >>>>
>>>> >>>> At this point I'm out of ideas, sorry. :(  The only way I was abl=
e to
>>>> >>>> break it was due to mistyping the extension as "netvis" several t=
imes
>>>> >>>> for some reason.
>>>> >>>>
>>>> >>>> Ren=C3=A9
