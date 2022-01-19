Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B644CC433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 10:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245022AbiASKUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 05:20:16 -0500
Received: from mout.web.de ([212.227.15.3]:38031 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbiASKUP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 05:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642587609;
        bh=6Iqtqc9FKCWzreCU/JSzyo+CWdSVK8QvLJBXMIHpG9k=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UIKitwmSwklwmmAGV0e8GpXCfcjkOsh8Zxyl+ciLbgLVhlaQiuBpgwFUpYHB6k5lG
         rDmLZBz+kauks9BIQG1rzo6csZ3g0eMHnvq+tBfGtVH8iYL7kAmLciiF++HtG3F10F
         B7lsAJomR1CqNh7wX0qSBGYAp3WALy1ELpmdQv74=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsJTC-1mKmnr2jPO-00trX5; Wed, 19
 Jan 2022 11:20:09 +0100
Message-ID: <55d5327a-9c6c-7fd8-b540-e710259c0694@web.de>
Date:   Wed, 19 Jan 2022 11:20:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: incorrect 'git (checkout|branch) -h' output with new --track
 modes (was: [PATCH v8 2/3] branch: add flags and config to inherit tracking)
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, chooglen@google.com,
        Junio C Hamano <gitster@pobox.com>
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1640039978.git.steadmon@google.com>
 <dcba40e2c4001611f837f612cc5ee7890c653aff.1640039978.git.steadmon@google.com>
 <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OE5UwlURBdWeH3Npqqcw1Uyoayt754QbHyaa0UetQoNS5P8j/Gu
 z5bMYUFNfs9KfnURvyiWUTy5Yl/40IIAh5hR0Tx9OAJsBKldGQiz7cmIsfZm9yRBEWuDvIv
 tr4IiBbDxuxC2Ig1XBPE5R4iZ9rn6uA1OAp9mFwgJ/n8XCyr1LW76+rXf8GS5s9LkX1z4U2
 XwFxTSJs6CpwdXEqtX7og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gH3Kgc9kAyY=:caRlHxUR+SZSfsQRKXbMTA
 yc5cocDYYF2Rde5ohRpMj4FK45RdzaR2JBKdvHw3bJi/LCl+I2W7ZiUjy1HP/cCQpRSoV4YFE
 FbqyD96WMzlXyhAlLy7t/7C0TrhtjkryudExm5EqWePt66j4n7pu6QhDVN3NWjReVwQRVSWlt
 zCYmiJ+g2U7fzng5srbdo6MsPz1GuGytKNe3JAlbkX76OWpd797JMOse2OkXmMfLc6dpwKrqV
 3z1g3bIwv1P5PLvcXqH4IMK3jI7oIj13/S8r5VOAITJe7UEiGHife1Fg729243GXRReZsaujB
 o+Efjk+MU08jFzmd9bYLoMqPgVyTnCrRFGl78GmnUautQOcmM7TPWMGVv8TGeV+yxsyDBkuVY
 QFHjZptfNSo2dZsiR58qZB6+591zOt85azkKF//ns9z/ympQh9BGmHSRrAKDne8V0omXyX5D5
 DJe9SRJycJQhjsWmOblg6dfJAUOQOlTH/jOUgZxB0C66PgJg4S60dC6L4vi6JEV98ovMP4by5
 r2p17YROPH90wCmt7LiXOZLD6vwtsvlF0JlwuuJz4/yPt6yR/KcV2vOdJ4XK7br8dG6YTG0YA
 mPEsVv4AxxEqLOgJKShDAExH+R1Y+Wl6PsZxeGGKkJWUwKiEppfpIgbpEpEYIls+KDjmu7gC+
 AX0CTfKkI5KQKjK2PzgRJjL6v434cwceCJfoxOlmwEmE2JSWF+JKFfdHTGf/iXW3X5WakyfSG
 8Wem1CV21RrESyDMfgpElAyepgmHtylqxkR/ZEYX9RttefBQ6BfrP4O2w2+xDMBDbk8wHBj44
 xocRLc0k/vYT1e1akC6n4kX8TSp4kXIY8wrr7Ow6LOsLuFW7heGRuyckX5i/duL23elipz7yM
 WLhEYIIMHUiNf1iZGTeGnfRVFjZQT9NlxTappRxj+W74S6ezJqNp33Wjmo9Papn/qEggxRgOW
 G/GrQizgk7KOzZTW/N2n/GrBmD3a/izlWNVw/vmuWuThlgd0xUB4yiHoq3tjw/t8OTeS89PVM
 3wKBrjIs1pgmFM7y8LoT6UTdcfxSNfVCzBmSeG3cks7iISDQf7Xs1G5nZh4cQIy4EQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.01.22 um 02:57 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Dec 20 2021, Josh Steadmon wrote:
>
>> Since we've added an argument to "--track", also add "--track=3Ddirect"=
 as
>> another way to explicitly get the original "--track" behavior ("--track=
"
>> without an argument still works as well).
>> [...]
>> -'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
>> +'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname>=
 [<start-point>]
>
> The usage info here is correct...

Actually it isn't, because optional arguments need the equal sign.  I.e.
this works as expected:

   git branch --track=3Ddirect branch

But this here interprets "direct" as a branch name (and branch as a
start point):

   git branch --track direct branch

The usage string could start with:

  'git branch' [--track | --track=3Ddirect | --track=3Dinherit | --no-trac=
k]

... or the less repetitive:

  'git branch' [--track[=3D(direct|inherit)] | --no-track]

Options with required arguments accept either whitespace or an equal
sign between option name and arg.  With PARSE_OPT_OPTARG we cannot
accept whitespace because we cannot decide whether the next thing after
the option name is an argument or the next parameter.

>
>> ---track::
>> +--track [inherit|direct]::
>
> ...as is this...

Same here:

   --track[=3D(direct|inherit)]

>
>> -		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git=
-pull(1))"),
>> -			BRANCH_TRACK_EXPLICIT),
>> +		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
>> +			N_("set branch tracking configuration"),
>> +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
>> +			parse_opt_tracking_mode),
> ....
>
>>  	struct option options[] =3D {
>>  		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at name=
d commit")),
>> -		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for n=
ew branch"),
>> -			BRANCH_TRACK_EXPLICIT),
>> +		OPT_CALLBACK_F('t', "track",  &opts->track, "direct|inherit",
>
> ... but these are not. I.e. we'll emit:
>
>     -t, --track[=3Ddirect|inherit]
>                           set branch tracking configuration
>
> I.e. implying that the valid uses are --track, --track=3Ddirect, and
> --trackinherit.

Well spotted.  It should be specified as "(direct|inherit)" (i.e. with
parens).

> It looks like the problem is (ab)use of PARSE_OPT_OPTARG, i.e. it was
> never meant for an enumeration of possible values, but for something
> like N_("mode"). It could be made to support that, but it would require
> some light patching of the releant bits of parse-options.c.

Could you please elaborate that point?  AFAIU PARSE_OPT_OPTARG just
requires arguments to be attached with equal signs and there is no
limitation regarding the number of possible argument values.

> The PARSE_OPT_LITERAL_ARGHELP should also be dropped if it's fixed to
> use a string like "mode".

That's true.  And it's also enabled automatically if the argument help
string contains any of the following characters: ()<>[]|.  So basically
it's never needed explicitly..

>
>> +			N_("set up tracking mode (see git-pull(1))"),
>
> Aside: In v5 the other reference was changed from using the
> "git-pull(1)" manpage syntax. See
> https://lore.kernel.org/git/cover.1638859949.git.steadmon@google.com/;
> It looks like this one should be changed too, but was missed.
>
>> +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
>> +			parse_opt_tracking_mode),
>
>
>

