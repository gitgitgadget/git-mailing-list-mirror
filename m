Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748871F51C
	for <e@80x24.org>; Sun, 20 May 2018 15:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeETPlB (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 11:41:01 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:47018 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbeETPlA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 11:41:00 -0400
Received: by mail-ot0-f195.google.com with SMTP id t1-v6so14237055ott.13
        for <git@vger.kernel.org>; Sun, 20 May 2018 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8KwrzPbnOso5BTsxJ2PaH/r89RTItjbTXllQldX/Kfc=;
        b=Wt7TS0KtlH/hkZDSHt06B9gsXKwp02wnb9itNEr1zUYt9MMWBKswGlhvWuFajrv/+x
         YR97P6YRcLODXIVDTwaa+L8AhxP3IXytmAeUJJI3mF3z8xGMvkojyl6fqlt5tFI5eshJ
         iYHaUAsupAPNhc5U8gctPNwg6zG6XLCOHtmbV3Z+Run/oOBbjl8qotbRbhRkeReZMQlA
         ypX37rXRhRMUYwuez1uaNvJo067oD7VYmxATNUn06gQ/3BAn1GGOvtxS46m0DXc5NFTj
         yn+KUvLOZthbV4C56TyzwbXETV9yUIsVs5cDwf/shNCXcu5XkShKrjCI1AmIlVU9C9LK
         UXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8KwrzPbnOso5BTsxJ2PaH/r89RTItjbTXllQldX/Kfc=;
        b=kahmQeXCzowb3a/buYDkZu54P/4V4DNcPYDHtnKTjEHTGLm1818gbRYk5vg/YRnRsG
         Z5BFggzfkN8G8nKfJG1coBsC4KvdnnLBp1VB4j083vWBQ8je5nO1kL5tZ0GbrJHMerC8
         eUqU+8/5yfJV3Rfxf5Zpm6ECTJZjvKuEMxlmiy4EiN3cmHHeLJapuBedHqOYFDLtZvwI
         /QQd6Q+k/Oh9jP+FTWPxxhSkMwf59tu5DI76kgak0Qz6HQSt9CCeSWf65mIfY4vEu0js
         hu/P3XSE4LyoIY+gyxosOTa7ynNRnI51zHKCK8DxDug45cTwBDvXYB0NqIxySlBpnA+Y
         INyg==
X-Gm-Message-State: ALKqPwe4CQvkVGnWu68VcVtNPUe591JcCW2N/WvmT22FReHyISHh+Nn+
        QozN1VJWOajwMOWSHuae3l+XkDRiF8xY2BeHMug=
X-Google-Smtp-Source: AB8JxZpaQHJPgfTZMqbHwCYTzRjBljMx9LNVt+zEz7lxJOVp8tmRcNNlu28l9ibEC9TV9v50Ta84EwMMXJ+Df1cSuYc=
X-Received: by 2002:a9d:2fa6:: with SMTP id r35-v6mr12122172otb.356.1526830859963;
 Sun, 20 May 2018 08:40:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sun, 20 May 2018 08:40:29 -0700 (PDT)
In-Reply-To: <CAN0heSpdtiUVSYGsT+VnUaSy0BO+p+mnod6Ut4Y3UrNVVQkrbA@mail.gmail.com>
References: <20180520081244.14619-1-pclouds@gmail.com> <CAN0heSpdtiUVSYGsT+VnUaSy0BO+p+mnod6Ut4Y3UrNVVQkrbA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 20 May 2018 17:40:29 +0200
Message-ID: <CACsJy8DxvZXw=J=Hh-TKL-2B+dcj2OV-CzTUuBBBxecDuAQrZQ@mail.gmail.com>
Subject: Re: [PATCH] Use OPT_SET_INT_F() for cmdline option specification
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 20, 2018 at 11:15 AM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> On 20 May 2018 at 10:12, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclou=
ds@gmail.com> wrote:
>> The only thing these commands need is extra parseopt flags which can be
>> passed in by OPT_SET_INT_F() and it is a bit more compact than full
>> struct initialization.
>
>> diff --git a/archive.c b/archive.c
>> index 93ab175b0b..4fe7bec60c 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -411,11 +411,9 @@ static void parse_treeish_arg(const char **argv,
>>  }
>>
>>  #define OPT__COMPR(s, v, h, p) \
>> -       { OPTION_SET_INT, (s), NULL, (v), NULL, (h), \
>> -         PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (p) }
>> +       OPT_SET_INT_F(s, NULL, v, h, p, PARSE_OPT_NONEG)
>>  #define OPT__COMPR_HIDDEN(s, v, p) \
>> -       { OPTION_SET_INT, (s), NULL, (v), NULL, "", \
>> -         PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p=
) }
>> +       OPT_SET_INT_F(s, NULL, v, "", p, PARSE_OPT_NONEG | PARSE_OPT_HID=
DEN)
>
> Right. We have NULLs in the fifth and the second-to-last positions, and
> we use PARSE_OPT_NOARG.  By switching to OPT_SET_INT_F we get those for
> free.
>
> Do we want to keep "(s)" instead of "s", just to be safe? And same for
> "(v)", "(p)". Macro expansion always makes me paranoid.

They are still wrapped in () in the end by OPT_SET_INT_F() so the
expanded struct initialization  is the same. I think we're fine here.

>> diff --git a/builtin/am.c b/builtin/am.c
>> index d834f9e62b..666287b497 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -2231,12 +2231,12 @@ int cmd_am(int argc, const char **argv, const ch=
ar *prefix)
>>                         N_("pass -b flag to git-mailinfo"), KEEP_NON_PAT=
CH),
>>                 OPT_BOOL('m', "message-id", &state.message_id,
>>                         N_("pass -m flag to git-mailinfo")),
>> -               { OPTION_SET_INT, 0, "keep-cr", &keep_cr, NULL,
>> -                 N_("pass --keep-cr flag to git-mailsplit for mbox form=
at"),
>> -                 PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
>> -               { OPTION_SET_INT, 0, "no-keep-cr", &keep_cr, NULL,
>> -                 N_("do not pass --keep-cr flag to git-mailsplit indepe=
ndent of am.keepcr"),
>> -                 PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
>> +               OPT_SET_INT_F(0, "keep-cr", &keep_cr,
>> +                       N_("pass --keep-cr flag to git-mailsplit for mbo=
x format"),
>> +                       1, PARSE_OPT_NONEG),
>> +               OPT_SET_INT_F(0, "no-keep-cr", &keep_cr,
>> +                       N_("do not pass --keep-cr flag to git-mailsplit =
for mbox format"),
>> +                       0, PARSE_OPT_NONEG),
>
> I found `-w` and `--word-diff` useful. You actually change the N_("...")
> for `--no-keep-cr` here: [-independent of am.keepcr-]{+for mbox format+}
> Copy-paste mistake?

Oops. You're correct. Fixed in v2.

>
> Other than that, `--word-diff` has a very structured appearance and
> nothing stood out. The ordering is different (f goes at the end in the
> post-image), which makes the diff busier than it would have had to be.
> (That's obviously nothing this patch can do anything about.)
>
> Martin
--=20
Duy
