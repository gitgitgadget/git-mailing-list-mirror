Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5531F404
	for <e@80x24.org>; Sat, 31 Mar 2018 12:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeCaMIl (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 08:08:41 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:41513 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeCaMIk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 08:08:40 -0400
Received: by mail-ot0-f176.google.com with SMTP id i28-v6so11696588otf.8
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0RwTpXvl3FNLn/xeMWnSEdUaZYlK1z3YZNA/QrRQVZU=;
        b=YDbAfgZEC8+hHAQ+bnQ2DX/ji3YTVxHlwWuBs7PwwBt0KNcrXJYTWS4UF2i+ssCwFY
         iUlfLmV4Mu1WP/cPU8a2xu8cSVLygnSB61JJR98qlSsfqH2xuLybA+Q3Dt5dzeeyA3ZN
         hSd/BrvuRXBo/N8VQYGDD0+4tpkBg/UU0/QBP+i47saYhSYyGxtRAClj14NCQIkwha5K
         SqySFQhPs4k+YyXf4y0MDA83cvU1WgQToDkVLAq0gLOmuUNG3YzLtptYrl5WyADi0AzH
         S4SiSnNf+FxuSUUChHhbTBkagCKSuuBgOB3Sv0XzK2FmX0hVgAVjRqPoX3YwGv6Bg1lF
         SkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0RwTpXvl3FNLn/xeMWnSEdUaZYlK1z3YZNA/QrRQVZU=;
        b=PUkYG10YdRnbPs9Vuhg3o1t/htdSJC/WOJCtlqM4VqGFgPK+2jQEyBFhbCE7NHZzTh
         iBDdsj1dRIjZ0Wm1IudG/95jYu4GTUteT2dx635HnDy3JdedHNDIewyxh5loeeN7DtvD
         H8n71/IarxmfbfYAouwUoqTWhy89dH2Io4snG+US/T9bJzlo5vvYGioTz22qv/nVIdEJ
         p14k7AWkFENMSeUIFlr20KDgFBKOfu8QgeGQGGniQ0HGe7vNBxh5LNS55IhfeGErMkWE
         zQ/J7WZPXAXTHCMv1u6ZnYVEEB4TzW0VNYnz1R22uWkjWlN75C0HqA7aiGFo5H/ZVG6d
         wDzA==
X-Gm-Message-State: ALQs6tAvITippkrHzt+GTV5M+vRW/bYnhcCctMPXzJzuPr7jazx0A+oJ
        fL4iVl98WapLtOSJ9uG/REdnPM176WUq9rcMsF0=
X-Google-Smtp-Source: AIpwx48eIzrs1kOl7JwG2k/O8ya46ZLuVuP3CKTykMSElXsTSJFl5LLAPCInzmcBf8+qUZ6vzDlFzNqGG3L9k6wCkAQ=
X-Received: by 2002:a9d:24c7:: with SMTP id z65-v6mr1587159ota.152.1522498120227;
 Sat, 31 Mar 2018 05:08:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sat, 31 Mar 2018 05:08:09 -0700 (PDT)
In-Reply-To: <87efk0wk7f.fsf@evledraar.gmail.com>
References: <20180324063353.24722-1-pclouds@gmail.com> <20180331100311.32373-1-pclouds@gmail.com>
 <87efk0wk7f.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 31 Mar 2018 14:08:09 +0200
Message-ID: <CACsJy8AAApXdxPwt6Yoc-gESXFLVNW8O2u_LF6HUBJTAQaCsTw@mail.gmail.com>
Subject: Re: [PATCH v8 00/15] nd/pack-objects-pack-struct updates
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 1:36 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>> +GIT_TEST_SPLIT_INDEX forces split-index mode on the whole test suite.
>> +
>>  GIT_TEST_FULL_IN_PACK_ARRAY exercises the uncommon pack-objects code
>>  path where there are more than 1024 packs even if the actual number of
>>  packs in repository is below this limit.
>>
>> -GIT_TEST_OE_SIZE_BITS=3D<bits> exercises the uncommon pack-objects
>> -code path where we do not cache objecct size in memory and read it
>> -from existing packs on demand. This normally only happens when the
>> -object size is over 2GB. This variable forces the code path on any
>> -object larger than 2^<bits> bytes.
>
> The docs here say set these env variables, but actually
> GIT_TEST_FULL_IN_PACK_ARRAY is a special snowflake in requiring you to
> set a bool value.
>
> I'd set GIT_TEST_SPLIT_INDEX=3DYesPlease already in my test setup & just
> copied that as GIT_TEST_FULL_IN_PACK_ARRAY=3DYesPlease, but that'll error
> out since it's expecting bool, not the env variable to be set.
>
> I really don't care which we use, but let's use either if(getenv()) or
> if(git_env_bool()) consistently, and then have the docs either say "if
> set" or "if set to a boolean value (see git-config(1))".

I'll change GIT_TEST_SPLIT_INDEX to boolean too since I document it
here anyway. Will wait for a while though to see if anything else
should be part of v9.
--=20
Duy
