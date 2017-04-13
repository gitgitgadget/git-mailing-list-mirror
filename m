Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB78220960
	for <e@80x24.org>; Thu, 13 Apr 2017 15:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbdDMPSW (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 11:18:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35862 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754007AbdDMPSU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 11:18:20 -0400
Received: by mail-io0-f195.google.com with SMTP id x86so13645662ioe.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=apFv5jwVK1+4V03zI6ZGXWP7joaRrNQnjJr72hiw804=;
        b=YE4cJUVPPXmVLe7Zn41jCWAxkhNcrMHc1CsPMTW5JP+jyP1Iqi0SaJFHNs6h+E2ui6
         06USfK3qTZ/lnRTwJ7rfKsDbwn96ynL3ptfmhL6nnZ5AstOZ+985BT0UzBWiCHrDdkoe
         0k4jjZctGlbEHx6jQufMuCRftTEU0QpkJYgJvoofPrEgZ0viHcJm0YFTy38revly3Chy
         3/T7eG/obfX7M3l4Q1xzK7+n43ber2Yph/Jf7YWB05SOnoxCIQBWYE69YA/PW6YuN3Vs
         MrtwgLYWo3Ioleu79jks34zgOf/Xeaqo0B/rqclPevwK3wxLQfll+YYXArxnt7gHPSCW
         FWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=apFv5jwVK1+4V03zI6ZGXWP7joaRrNQnjJr72hiw804=;
        b=DTSwhIy6sDDVc1EVk4JyONhO/sj80ilLQ5lpmNR+80ZLQwWaj3gM60cHSmlWOVIhDK
         penoYYyjW4G1RlTirU/dZNnyApgBMmyXSnJpsMfqdw/k+TEydH8tY1C/6CW3ojefMobJ
         NRs8JYhKjIscxAUfkLCSv+8gp1IB6BK4Ens8kK6YXkJWfzcsJg9sPwahAEVsnCHK8ciX
         Dp566qzoIzcj06q1OrbiRoZ77wMFRVrOTN1XSESjTAKNQpOCn4zil7tb4Zs9r/rkntzn
         /5bYsP4dQSW6OX9YggBnEbjaj6v1ADB8cl/gAdZb5IS7dYskQPQXzQ7ksvfXv0sUQmrl
         Y7tw==
X-Gm-Message-State: AN3rC/62tvuCE9pPOgsAnLY0Xif93g+wc8m+iea9JdCe1chiX/Gx84k3
        tVAPuldtFm6rh3VoamHYA9oq9RlsuGTt
X-Received: by 10.107.35.200 with SMTP id j191mr1962920ioj.33.1492096699953;
 Thu, 13 Apr 2017 08:18:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Thu, 13 Apr 2017 08:17:59 -0700 (PDT)
In-Reply-To: <CACBZZX6bYLRSUAy2GUYhBVet3tjzrBQ40L49KxetAvBdgx_x+w@mail.gmail.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com> <20170405130424.13803-6-tgc@jupiterrise.com>
 <CACBZZX6bYLRSUAy2GUYhBVet3tjzrBQ40L49KxetAvBdgx_x+w@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 13 Apr 2017 17:17:59 +0200
Message-ID: <CACBZZX56Fx+niwwsiJeMwvaZkuR3h4zxytu+xx_sanobMPGobg@mail.gmail.com>
Subject: Re: [PATCH 5/7] Add support for gnupg < 1.4
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2017 at 3:45 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Apr 5, 2017 at 3:04 PM, Tom G. Christensen <tgc@jupiterrise.com> =
wrote:
>> This adds an OLD_GNUPG define to the Makefile which when activated will
>> ensure git does not use the --keyid-format argument when calling the
>> 'gpg' program.
>> This is consistent with how 'gpg' was used in git < 2.10.0 and slightly
>> decreases security.
>
> This changes the code Linus Torvalds added in b624a3e67f to mitigate
> the evil32 project generating keys which looked the same for 32 bit
> signatures.
>
> I think this change makes sense, but the Makefile should have a
> slightly scarier warning, something like:
>
> "Define OLD_GNUPG if you need support for gnupg <1.4. Note that this
> will cause git to only show the first 32 bits of PGP keys instead of
> 64, and there's a wide variety of brute-forced 32 bit keys in the wild
> thanks to the evil32 project (https://evil32.com). Enabling this will
> make GPG work old versions, but you might be fooled into accepting

grammar fix: "work on older versions"....

> malicious keys as a result".
>
>> Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
>> ---
>>  Makefile        | 6 ++++++
>>  gpg-interface.c | 2 ++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index ca9f16d19..f8f585d21 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -386,6 +386,8 @@ all::
>>  #
>>  # to say "export LESS=3DFRX (and LV=3D-c) if the environment variable
>>  # LESS (and LV) is not set, respectively".
>> +#
>> +# Define OLD_GNUPG if you need support for gnupg < 1.4.
>>
>>  GIT-VERSION-FILE: FORCE
>>         @$(SHELL_PATH) ./GIT-VERSION-GEN
>> @@ -1529,6 +1531,10 @@ ifndef PAGER_ENV
>>  PAGER_ENV =3D LESS=3DFRX LV=3D-c
>>  endif
>>
>> +ifdef OLD_GNUPG
>> +       BASIC_CFLAGS +=3D -DOLD_GNUPG
>> +endif
>> +
>>  QUIET_SUBDIR0  =3D +$(MAKE) -C # space to separate -C and subdir
>>  QUIET_SUBDIR1  =3D
>>
>> diff --git a/gpg-interface.c b/gpg-interface.c
>> index e44cc27da..57f1ea792 100644
>> --- a/gpg-interface.c
>> +++ b/gpg-interface.c
>> @@ -224,7 +224,9 @@ int verify_signed_buffer(const char *payload, size_t=
 payload_size,
>>         argv_array_pushl(&gpg.args,
>>                          gpg_program,
>>                          "--status-fd=3D1",
>> +#ifndef OLD_GNUPG
>>                          "--keyid-format=3Dlong",
>> +#endif
>>                          "--verify", temp.filename.buf, "-",
>>                          NULL);
>>
>> --
>> 2.12.2
>>
