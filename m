Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 387C32047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbdHGRhj (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:37:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35517 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdHGRhi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:37:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id j68so995559pfc.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7zHo9Ww7ixww3F0RpYGVfTSziNOeujzCbYWL7mFuRl4=;
        b=A9Mn1s/0tJLDBPV+3F0g22Ss4el/Z1JT3bS1r7jQrSD8WzazUFrPXgzeTHpCs0KkuX
         mil9Xga+fGhyKZ5PbqMSlX0jpZo/vXSGvX8+/+jOum0ick3d6PVvgS3pbY2BP62XTh7F
         DUmnqUQpa+KO/8j1SbJiLJvPds84gnnksakBfp+o/jFnDysbXd4j/y7zoW7601EvM8H5
         H01YNXSEnwlzdRew5KRcgKL+GJtycBR10RNHlQ91s7kyY33+M3dkjT+SRYWRL7R2ct/f
         lacqt4AaCZqBclvm0DokTrmbp5oREVrcBHWEkUtaKpnhWmyrOtaEnPEitnCDNXEWZlVL
         65Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7zHo9Ww7ixww3F0RpYGVfTSziNOeujzCbYWL7mFuRl4=;
        b=UmtdThDG8iYQcOnCYVszhAgdTMaU3gW6NHzM2w+4LU5O+6HLtsrjXHPzzg5hXhJ7Gi
         rkkeB/VU1C2aQSa75uZL8HDe/Jnw1AtH8nvqdoNA7ed9UGnObzw6t+eimaPyWf5mkW95
         +WrmUL6dy9bYDxC8pk2qV4PLYZv/Y8iarj+N3oO/6QNh4Hbdrmic9AkIPTMmKPhrF7vQ
         JTvHGFJKeybVRyTl0zYaScxk/TZFmG7ETxgtlVzvQ+tIvvyD+ZBgAnJkBl7VeMzrXrPG
         LosXk/c8WbABHn2/MFHj0HTgSqiEhDcD+lW/zicbEYIkxSwuuGv5FP8u55TrU/zZO+AN
         ZaRQ==
X-Gm-Message-State: AHYfb5gBoryb/F5auD8kLw1a+KZftNWpyzY6GQVAke4skMpM7rAhKrTj
        kry25jmZ9YcjCOmPUO8dU4rMfY4fMQ==
X-Received: by 10.99.179.9 with SMTP id i9mr1234378pgf.413.1502127458353; Mon,
 07 Aug 2017 10:37:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Mon, 7 Aug 2017 10:37:37 -0700 (PDT)
In-Reply-To: <890d4028-1351-a7b9-1797-cf419d5f01e8@morey-chaisemartin.com>
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
 <71479602-fabc-1861-124b-90b26b952344@morey-chaisemartin.com>
 <CAN0heSoRXX_9-yzFf=2Obj_5WosLwK4UtrFrLsw8asdUea1+Yg@mail.gmail.com> <890d4028-1351-a7b9-1797-cf419d5f01e8@morey-chaisemartin.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 7 Aug 2017 19:37:37 +0200
Message-ID: <CAN0heSpSXRNgGeJ7TKOwPZJ3Puc1EvVUv1u84ghwDHhtE7=VHQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] imap-send: use curl by default
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 August 2017 at 19:10, Nicolas Morey-Chaisemartin
<nicolas@morey-chaisemartin.com> wrote:
>
>
> Le 07/08/2017 =C3=A0 18:37, Martin =C3=85gren a =C3=A9crit :
>> On 7 August 2017 at 16:04, Nicolas Morey-Chaisemartin
>> <nicolas@morey-chaisemartin.com> wrote:
>>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.c=
om>
>>> ---
>>>  imap-send.c | 6 ------
>>>  1 file changed, 6 deletions(-)
>>>
>>> diff --git a/imap-send.c b/imap-send.c
>>> index 90b8683ed..4ebc16437 100644
>>> --- a/imap-send.c
>>> +++ b/imap-send.c
>>> @@ -35,13 +35,7 @@ typedef void *SSL;
>>>  #include "http.h"
>>>  #endif
>>>
>>> -#if defined(USE_CURL_FOR_IMAP_SEND) && defined(NO_OPENSSL)
>>> -/* only available option */
>>>  #define USE_CURL_DEFAULT 1
>>> -#else
>>> -/* strictly opt in */
>>> -#define USE_CURL_DEFAULT 0
>>> -#endif
>>>
>>>  static int verbosity;
>>>  static int use_curl =3D USE_CURL_DEFAULT;
>> So this is now basically "static int use_curl =3D 1;".
>>
>> Do we need a compile-time escape-hatch in case someone really needs
>> to avoid curl, e.g., because they have a too old version? I suppose
>> there is a conceptual difference between the "default", i.e., the value
>> of USE_CURL_DEFAULT that is assigned to "use_curl", and the "default
>> default", i.e., the value that is normally assigned to USE_CURL_DEFAULT.
>>
>> Martin
>
> The curl code depends on USE_CURL_FOR_IMAP_SEND so even with use_curl =3D=
=3D 1, it won't be an issue for people without curl (or old one).

I have just looked at the sources and haven't thought too hard about it,
but doesn't it mean that compiling without USE_CURL_FOR_IMAP_SEND
results in a binary such that you must use --no-curl or get used to seeing
"warning: --curl not supported in this build"?

> I wasn't sure whether to drop the define or not and figure it might be wo=
rth keeping in case in change in the future for some reason.
> I don't mind dropping it and hardcofing the default to 1

I did not intend to suggest that. Just to be clear, I am very unfamiliar
with most of the Git codebase. Please don't take anything I say as
advice. :) As a question about something you have or haven't already
thought about, sure. :)

Martin
