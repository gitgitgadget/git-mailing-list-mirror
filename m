Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9D61F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 08:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeCRI0H (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 04:26:07 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:41133 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCRI0G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 04:26:06 -0400
Received: by mail-oi0-f44.google.com with SMTP id g5so11953917oiy.8
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hRaGhmnzlXQ2s9Hrr2mRyLkKZdBJ9hMXOFkOXIaYE3k=;
        b=gTXh7VkxLaq3sXNMKWQGcEhGu61L3v+hKSdD9fgXOoNijx2HWQfN2qigIk7x74RIlL
         Lnf5wEBlr2QkwuPxgQ5FJUuIl/+7GIFSrlUbaRR1Yxsslvbi++06BvorcQMFhKiVhyBj
         2brSZ6YnhAA+2nmNWlHcEwjIV/17X2ZavIH9gsO6bkpe3jplRqrxxB7sJM9bRVs0OrON
         EI+K2XR/Rxj1485cpjImwmI2O+F/8wAKDH72b/fNmroUnGOHLiV62w5QqGI90HitEsKv
         NtsKdlaisxszIFngI8cm/BwGeFI1I4H/DKcJ1IxTQ0YxoqaY6Outl+5gJBL7/A2Z+2/5
         9x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hRaGhmnzlXQ2s9Hrr2mRyLkKZdBJ9hMXOFkOXIaYE3k=;
        b=OxQJcQMa8NOkpCKRYn/ixkiVyxM+E89iSYH5pjnAM3HrRNP7QkstIeVDYskn2okmvb
         MaHmtxGNZcDSGLANimMLMezPckJk83P8HZXG9b0bznRIyCJwdmmuGj57A+h0MjtocNVJ
         ohqD8eICAD3dqWuPp4IfxZy+EoiuGkXZW43/A2RgtdqCQlF7kyEaTiHKdbT6btiW0uGN
         8R8YmfJbHXNIbPQLO9Lx/hPQCT+8hyFWcWDh1yOcCrgcKt+sWAWYYwvhE0ljRXS7RKbd
         SMNPGi1dDr796hGYyee+axG6UspJ9Y1XT/VNiWlatig2/dPzhUIt9ZSCV2cz9lko+SVf
         CvBw==
X-Gm-Message-State: AElRT7HR4v2+4aXdMVObP6WyY1RgjZR8hosRDeqRI46/Dt0sqlqFjfuy
        EZWIDQl8EK+W7dQA4r2FAA+jxHq7iGCRCdxWWeQ=
X-Google-Smtp-Source: AG47ELvzKBmEHGLYymzFN2NKW4mh4Hivur6i6ddAo4xKEPLwzAuxtiG/pa5ymt4i4ZKxkcn6N5RXRWvkUt0rt+CnszE=
X-Received: by 10.202.64.85 with SMTP id n82mr4861212oia.30.1521361565666;
 Sun, 18 Mar 2018 01:26:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sun, 18 Mar 2018 01:25:35 -0700 (PDT)
In-Reply-To: <CAPig+cTSqxLTDoq3xGAmf1xCyCX0jvwyoSL5GApgaNg5PVPGGg@mail.gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180317075421.22032-5-pclouds@gmail.com>
 <CAPig+cTSqxLTDoq3xGAmf1xCyCX0jvwyoSL5GApgaNg5PVPGGg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 18 Mar 2018 09:25:35 +0100
Message-ID: <CACsJy8CeXZJashmh+sLykRR4Mm_EwnASMVyB-4ztEcfQXU7MXw@mail.gmail.com>
Subject: Re: [PATCH 04/36] t/helper: merge test-lazy-init-name-hash into test-tool
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 3:11 AM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Sat, Mar 17, 2018 at 3:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> diff --git a/cache.h b/cache.h
>> @@ -333,7 +333,7 @@ struct index_state {
>> -extern int test_lazy_init_name_hash(struct index_state *istate, int try=
_threaded);
>> +extern int lazy_init_name_hash_for_testing(struct index_state *istate, =
int try_threaded);
>
> I get why you renamed this since the "main" function in the test
> program wants to be called 'test_lazy_init_name_hash'...
>
>> diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-in=
it-name-hash.c
>> @@ -9,6 +10,9 @@ static int perf;
>> +static int (*init_name_hash)(struct index_state *istate, int try_thread=
ed) =3D
>> +       lazy_init_name_hash_for_testing;
>> +
>> @@ -33,9 +37,9 @@ static void dump_run(void)
>>         if (single) {
>> -               test_lazy_init_name_hash(&the_index, 0);
>> +               init_name_hash(&the_index, 0);
>
> ... but I'm having trouble understanding why this indirection through
> 'init_name_hash' is used rather than just calling
> lazy_init_name_hash_for_testing() directly. Am I missing something
> obvious or is 'init_name_hash' just an unneeded artifact of an earlier
> iteration before the rename in cache.{c,h}?

Nope. It just feels too long to me and because we're already in the
test I don't feel the need to repeat _for_testing everywhere. If it's
confusing, I'll remove init_name_hash.
--=20
Duy
