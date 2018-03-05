Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A12C1F576
	for <e@80x24.org>; Mon,  5 Mar 2018 09:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeCEJzX (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 04:55:23 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:32892 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932872AbeCEJzT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 04:55:19 -0500
Received: by mail-oi0-f53.google.com with SMTP id e9so4936006oii.0
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 01:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XVJYzEA8N20DTQTXPgD3vzxG6Ci5CYO4YGAQ6kGJYH4=;
        b=o/Ec5LjGJ8EWzplFhjKbtiDgybRNBtaeVbMj9dQxkgO+mY8+b7ECHNQ1R/5xW3bhwC
         16moJx5dZOyOhZB+oJ+vP8m0nUjqpJv1JLxg2BhSfnP3h2sWy2z/a8wbOCQ/pZ2ooGxv
         xYJ+jjhqr7RLoo8gg9gmZGe1tn/IGkPR2Q9YuQQOBHOyJkO7Pkt2QHu/Mhwvepvp+6pv
         ImFb28CUouRhQxN07B/VQJxeyr5unH+Yy9DojMnGgWM0iENNqmf+uSpxC3AWS+ry2gVP
         9P/X4pDWKt+3Ui/H+L7NILsHT8/QTzfJpjtbpIdrbxC5R3ymQ1USXY915ZOgORSinIGq
         YTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XVJYzEA8N20DTQTXPgD3vzxG6Ci5CYO4YGAQ6kGJYH4=;
        b=TivSXKuoppg1Lk9RPyucmirlGSe3co28WGlOHvIhKaboJNdgwVs8Z6xo8XIm5WGFwY
         H18B0J3YWfdKXjqy8dr+0DuzabTQXb0fyzgOQf1nt+K4ATjotIwvKHy7zs7cR4Uc/jU7
         NIKAz8BPhRio4ABiTZk7P5LzLmYcIECyOHhwWghFFmcuk4nPjIfV5e4+wdeGKDCGfosr
         pXRx1wplu99gWU2bTlqqwrpXpoUdRCoLYqWWImTso9ovvIzW9qXxwxtvq0NCDbAwcFsO
         8Nsexj39FrHn35WmAVoTbN0NCf8cSHy47+1u/PeJqicSL+ITlLITXgxFwjOlOxXQACMn
         0UzA==
X-Gm-Message-State: APf1xPBiZG2TksWTukSagf5D92Z7lZQ98e9qlWHuXyznHGTHLvbYDlfW
        mTm7+tZU9MnGIU+9/4mvcYozzjH0vGGSYL194S0=
X-Google-Smtp-Source: AG47ELtpWITu10Aq48bzx+A5hTpCEQTZGgB+Is1S5Gpk0r0zkhnCTVqYcRE8WX2FYi9ENlUO3BEPX56W4h74Vp9UHts=
X-Received: by 10.202.64.85 with SMTP id n82mr9191656oia.30.1520243718687;
 Mon, 05 Mar 2018 01:55:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 5 Mar 2018 01:54:48 -0800 (PST)
In-Reply-To: <CAPig+cSkU8j-NiNeMP-F3VygF1sAoXP3qzn4fx7C1qxTZoO5+g@mail.gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com> <20180303113637.26518-10-pclouds@gmail.com>
 <CAPig+cSkU8j-NiNeMP-F3VygF1sAoXP3qzn4fx7C1qxTZoO5+g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Mar 2018 16:54:48 +0700
Message-ID: <CACsJy8AH08k-=DATSn63T_4uVmjNoGn8m6k4=ZTq5RbO386k7A@mail.gmail.com>
Subject: Re: [PATCH 09/44] object-store: free alt_odb_list
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 4, 2018 at 9:37 AM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Sat, Mar 3, 2018 at 6:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
>> Free the memory and reset alt_odb_{list, tail} to NULL.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>> diff --git a/object.c b/object.c
>> @@ -450,8 +450,26 @@ void raw_object_store_init(struct raw_object_store =
*o)
>> +static void free_alt_odb(struct alternate_object_database *alt)
>> +{
>> +       strbuf_release(&alt->scratch);
>> +       oid_array_clear(&alt->loose_objects_cache);
>> +}
>
> This doesn't free the 'struct alternate_object_database' entry itself, ri=
ght?
>
> Is that intentional? Isn't the idea that this should free the entries too=
?

I think "alt" should be freed too. But since this series is more about
refactoring, and we're still in the middle of converting to struct
repository/raw_object_store, I don't mind "leaking a bit" (the current
state is leaking freely when most things are global). Once the
conversion is done, I think we could have some nice test that creates
and destroys the object store gracefully, then tools like valgrind.
asan... can help clean up these leaks.
--=20
Duy
