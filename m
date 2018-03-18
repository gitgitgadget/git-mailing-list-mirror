Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0131F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 09:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeCRJSN (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 05:18:13 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33982 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeCRJSM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 05:18:12 -0400
Received: by mail-ot0-f194.google.com with SMTP id v4-v6so11328777otj.1
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 02:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YuvpDt9UBIFUuwhumbdtzQphXtshqa0d4aSq4+NdJcE=;
        b=fhbpjZxYPXHHpPNVu5MRBDgiLTt/9zno/Pms5a6rLcXCmMURftHxAGxZDXWfmggjf4
         wtcmwO42Qblp5UNHAstXsmHF5IAwo8tbgoCBedTXMqu3oFaLrnBj75wmo3EFxu2R0TZb
         XNf6+5sByo1QaJ16NhAHJWuKE8q8PLmMGCZeMbMPOQ3Et+/O1x7lSkdOxTUMkWbMiVD7
         OrI4CDkjr1rC2QbVp6opdVGaCTOUgOvPiJfkWiYXqMxgxquiS3w+QZsRyDR7uAynB4Si
         VKj4T3i8fpXm9fuU0znC0AqJCrLCUdfdbIBuo3/JwyR8ZXMWTXV+QeV4rtkBZlIrs/aB
         Bsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YuvpDt9UBIFUuwhumbdtzQphXtshqa0d4aSq4+NdJcE=;
        b=YnUuBNoupYI3cJ9GKlDR9lv6TEtjrY0jDGTxKBjV7TETuxmnDv/6AdCORypqjh1iok
         S+YAiGhTnhIAXw1d4OLC/aSZ1nECUUbukShGtnVY5i2mZYB26X61+2J8c7nnCb1m6QeS
         IwX+li5jFKaqUUp2Ps5aHBs8bKVh5XJ8r1KZsUuKzZYJOSrLC5zYHLgnoFLjJoXTKwmL
         R3OcR3ALkTaeQfqanm3q9oTcyCubb2nqYsr3FLa5OLQ8I+ZTtBy+vzwAfWFRXk2rcNp4
         zd1UmSTlW7bXcoA7svUPGdR9JyMK5S+maRtlHHGVTRGsAmi9eS0fDGAOMFFTeTmXYKNP
         vJ6w==
X-Gm-Message-State: AElRT7G97YhOn/Z3T1Jsg9qKfyPpAeNDGgf4H8SWTAFTk32582cwMbRZ
        mDHOeYUv4jFx2fCOaycMgV+6IiB2EsQ5GLcPj5E=
X-Google-Smtp-Source: AG47ELvK6AL8pqfufWT6yzg1UvNJVx2DJN9sY0Dxgmou+Ef/yUDRKcL09ofj+eT1PhFCMv1higHIlQ7NKZTxgkLPnoo=
X-Received: by 2002:a9d:36cc:: with SMTP id s12-v6mr5437941otd.304.1521364692006;
 Sun, 18 Mar 2018 02:18:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sun, 18 Mar 2018 02:17:41 -0700 (PDT)
In-Reply-To: <20180318090607.GA26226@flurp.local>
References: <20180317160832.GB15772@sigill.intra.peff.net> <20180318081834.16081-1-pclouds@gmail.com>
 <20180318090607.GA26226@flurp.local>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 18 Mar 2018 10:17:41 +0100
Message-ID: <CACsJy8BGZV1hHKNzDaFkt=9zfhzv+GR1JUN-fOcQRk_2+tctZA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: detect compiler and enable more warnings in DEVELOPER=1
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 10:06 AM, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
> On Sun, Mar 18, 2018 at 09:18:34AM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>> The set of extra warnings we enable when DEVELOPER has to be
>> conservative because we can't assume any compiler version the
>> developer may use. Detect the compiler version so we know when it's
>> safe to enable -Wextra and maybe more.
>>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>> diff --git a/detect-compiler b/detect-compiler
>> --- /dev/null
>> +++ b/detect-compiler
>> @@ -0,0 +1,50 @@
>> +get_version_line() {
>> +     "$CC" -v 2>&1 | grep ' version '
>> +}
>
> On MacOS, "cc -v" output is:
>
> --- >8 ---
> Apple LLVM version 9.0.0 (clang-900.0.39.2)
> Target: x86_64-apple-darwin16.7.0
> Thread model: posix
> InstalledDir: ...
> --- >8 ---

Does it still build ok for you with your changes squashed in? I think
the check for clang4/gcc6 and setting -Wextra in config.mak.dev may
backfire because clang9 probably has a lot more warnings enabled and
some of them we don't want and cause compile error...
--=20
Duy
