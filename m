Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D95E1F576
	for <e@80x24.org>; Fri, 23 Feb 2018 10:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBWKan (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 05:30:43 -0500
Received: from mail-ot0-f181.google.com ([74.125.82.181]:35257 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeBWKal (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 05:30:41 -0500
Received: by mail-ot0-f181.google.com with SMTP id p8so7070531otf.2
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 02:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DdEqh2tah6cKG9LZofqtjU3g7r1UQu2TwXY07Q1YE28=;
        b=KPKUmQBlEEJclmTfe8wr2jh5Ttb/UYWC+tQkiSDd7Z3E/5lek2tULAQunvUbIJON8r
         Uz1Fln3r8n+8a1iBWfCMUKG5QUD26m466l74bQjjbT6h4SPUeUYEn662nKQu1q5PTlDg
         7Nhu6jejHINFv3+QMwWVKJCB1oHXFNPIcdHHHmIDNg3lRhe1S/RXbr9S8kTCSYLvgfqW
         zZVTzCAUvLbUkToODpjnYhF8k0uJ4s9O4cyZaJtvOAW32PmH7HksH2rfmbWlZxywVCuV
         H1pcpzgnhMlZma7JA2r4kvtI+wKBSQ2kYKvfWpo/vrhkvEgmdUejYhzAP1YejunuqhDP
         PicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DdEqh2tah6cKG9LZofqtjU3g7r1UQu2TwXY07Q1YE28=;
        b=ZmEXW0xOm+ck3blGBODgd5mk0lKjdXv0ivtmIZkSnmcqSyJlz0cErb94wQgik+V4qG
         royAHye/atfrXlIutS/bRzke8OtrfFG8jlA9+gl9aY4caxm7esFSv0Vy3jujJw4Tx5oX
         CipP7MvP01C0vJrrkaQ9YBVKVtEnhs3ya41MX+C+Qre5ThlDNsbfVJQluRmrM4IbQw9U
         MQO51tK35TkFN1pxTacHFHsmY36qkrc0toX7FP6YEIsR4VqhXIsyTokyEtvHlniqrdMW
         OjV7W5xpXY7vqgyJlr21ZZWgQKKN+t58mFpyXLyd9pOdHyzJn8XnE7yyTCL9mn/j9z6T
         4n2Q==
X-Gm-Message-State: APf1xPDeuc77HKEEaC8OUXnzhFY0PQH9sJxQ6OuQT2eLhm4xeEgH4FXG
        uSRv0VHek+9AWPff7RCun9U8qjlhFZv4RvgYU8w=
X-Google-Smtp-Source: AG47ELvSbbKs5uccWo3TQxOApVsTuAKPOjGHybnLRkqdSv2MXPrhpJ0TyiI8UIldttqHb1b7e2TuPrS0BVvLn0y42yI=
X-Received: by 10.157.24.42 with SMTP id b39mr734390ote.356.1519381840314;
 Fri, 23 Feb 2018 02:30:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 23 Feb 2018 02:30:09 -0800 (PST)
In-Reply-To: <CAM0VKjk17VgGAHr8jJXft4twij61KPLUDYSeHm6TXttksynd8Q@mail.gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-5-pclouds@gmail.com> <CAM0VKjk17VgGAHr8jJXft4twij61KPLUDYSeHm6TXttksynd8Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Feb 2018 17:30:09 +0700
Message-ID: <CACsJy8Avto9W_xUJLv+_uQMXLOsXDBz1Bo8kqZNhzs1dKKhb0A@mail.gmail.com>
Subject: Re: [PATCH v3 04/42] git-completion.bash: introduce __gitcomp_builtin
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 10:35 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>> +__gitcomp_builtin ()
>
> Please excuse the bikeshed at v3, but I don't like the name of this
> function.  It indicates that it completes builtins, but it completes
> options of builtins, and even then only the options of those using parse
> options.  Furthermore, the '__gitcomp' prefix is usually used for
> functions that merely put words into COMPREPLY, but this function does a
> whole lot more (getting the options from builtins, include and exclude
> options, caching).
>
> Alas I don't have any great name; __git_complete_options is better,
> because it uses the right function name prefix, but only slightly
> better, because it can't generally be used to complete options, as it
> won't work with scripts or with builtins not using parse options (though
> with time more scripts will be turned into builtins and more builtins
> will use parse options).  I'm not sure it's that match better to make it
> worth changing fourty-odd patches.

Since it's still on 'pu', renaming is still an option. I don't mind
renaming (and I'll need to check every patch anyway when I make
--rerere-autoupdate completable). Say "do" and I will.
--=20
Duy
