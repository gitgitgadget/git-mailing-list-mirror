Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843C91F403
	for <e@80x24.org>; Sun,  3 Jun 2018 15:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeFCPBP (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 11:01:15 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37176 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751321AbeFCPBO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 11:01:14 -0400
Received: by mail-ot0-f193.google.com with SMTP id 101-v6so12158400oth.4
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=obdULkMICD1hO6AG06HpYIp6MXqkn23G8vttn84FapY=;
        b=N2A4n2BbvMnMIr2sQQv/UTpxG2nYejfYVaJsu3B0PFQQo4XlFlsEfoSGfhZqsqJG9U
         +JUHOELab3nReYqFeAWvfvCqT7kTQIif7rEeaSCRrNt4FIYD0/rIJ3mPjQpUgfk3W5nE
         675njB+mGR/4QHlTFB/p+Z1P75MzKDjipTNfByeDcUttBBfeT+KD5kCTNeiDUq5UrpFi
         /6utSgtusuafT2bVU97EXvOOVbJD9vy5ny+ZtFaqQXq2FTiTY43uZDDQiOAN7GJSpWf6
         zaI90WDVXEit8K7Mc8JEZ2GontSBZiEw0+iei9aXwzw3rLn/ahWoxIeZNVnaVMVUxPJw
         7HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=obdULkMICD1hO6AG06HpYIp6MXqkn23G8vttn84FapY=;
        b=auHwVmJSTIMJbqRiYZr5sFe3gWq5cDmoxEhyydKMsoxJIS6k/kNh37KD083pespdf+
         Lp/C5oRdjHfqgE8iEW4AlSF5qORw5936h+vZAYXnYiiGitJGUMfdHJWL9SJPzGEzDg6z
         S1/kt/Jk33BNvYhV7XMGuAF2SATa2uO0XbtKXOlgiqxH7C3E9yi+AyzyYtXXKfbZ3Oy/
         Va2h25Zno2a9Mrz6ARVtnVLwV9A0StG0khbBx9ZYt4Tmbo7f0+duUxBhoXEXAlnRHXwe
         KjLj5Uegh1CBsxB3Gk94ojD3GvJH26UBXH4Z+bdempJZWgKjTDFAj8Q2XsiT/j22gNtH
         biRg==
X-Gm-Message-State: ALKqPwc27DBpQmzsu4gdBF1LKdLKPg+m6PxVNIlz9CrwRSrUnY+2iAVt
        kqK2uF3i1aaMFNtmkBWZgwEV/EuhBVEmvF/1oAY=
X-Google-Smtp-Source: ADUXVKKyIguoC9s0BN/ekZPJIADu8yIaqwt/Y6y2Ay7qkkZfr8JkZ6hdIBksrcxHYnP/mky5+aR1uPrXo0Rv3lXnbAU=
X-Received: by 2002:a9d:2f91:: with SMTP id r17-v6mr13233408otb.356.1528038074191;
 Sun, 03 Jun 2018 08:01:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 08:00:43 -0700 (PDT)
In-Reply-To: <CAPig+cQ8p=V7nCJDgJvD2f7pAjykBjN_4BnjY0XHPugE3yL_Tg@mail.gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-4-pclouds@gmail.com>
 <CAPig+cQ8p=V7nCJDgJvD2f7pAjykBjN_4BnjY0XHPugE3yL_Tg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 3 Jun 2018 17:00:43 +0200
Message-ID: <CACsJy8BorDWr-MyfDGrDQ+dWP5OvtFjXqEW-m=TxOFJrZ+62tg@mail.gmail.com>
Subject: Re: [PATCH 03/22] builtin/config.c: mark more strings for translation
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 3, 2018 at 11:01 AM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Sat, Jun 2, 2018 at 12:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> There are also some minor adjustments in the strings.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>> diff --git a/builtin/config.c b/builtin/config.c
>> @@ -746,7 +746,7 @@ int cmd_config(int argc, const char **argv, const ch=
ar *prefix)
>>                 if (ret =3D=3D CONFIG_NOTHING_SET)
>>                         error(_("cannot overwrite multiple values with a=
 single value\n"
>> -                       "       Use a regexp, --add or --replace-all to =
change %s."), argv[0]);
>> +                       "       Use a regexp, --add or --replace-all to =
change %s"), argv[0]);
>
> Perhaps?
>
>     cannot overwrite multiple values with a single value;
>     use a regexp, --add or --replace-all to change %s

I'll probably leave these multi sentence errors alone. There's some
work going on about these multiple sentence messages. We can come back
after that series settles.

>> @@ -819,7 +819,7 @@ int cmd_config(int argc, const char **argv, const ch=
ar *prefix)
>>                 if (ret =3D=3D 0)
>> -                       die("No such section!");
>> +                       die(_("no such section!"));
>> @@ -830,7 +830,7 @@ int cmd_config(int argc, const char **argv, const ch=
ar *prefix)
>>                 if (ret =3D=3D 0)
>> -                       die("No such section!");
>> +                       die(_("no such section!"));
>
> In other patches, you dropped the trailing "!"; perhaps do so for
> these two also?
>
> Maybe even:
>
>     die(_("no such section: %s", whatever);
>
> Though, that may be out of scope of this patch series.

Might as well do it while I'm at it. I'll do it in a separate patch
though and try to keep these i18n patches about _() only.
--=20
Duy
