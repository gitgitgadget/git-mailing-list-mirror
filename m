Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F3A1F404
	for <e@80x24.org>; Sun,  4 Mar 2018 02:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeCDChc (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 21:37:32 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:42147 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeCDChb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 21:37:31 -0500
Received: by mail-qt0-f180.google.com with SMTP id t6so16579776qtn.9
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 18:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=DR69Ezh7XB/BXMJr352Ht6r4xJUQPWAlagEfcmQDPb8=;
        b=EMbxLUkviClq+U2gXK0EnThgT+zk+yR2l+/Bk9BHOb2w2LfnxcYhjyVJsaHvoOxjrL
         S7H+oCeRjvKArfBQW7wj7aUlnVkPQF28HyoAor+kJi0dDBV1oXs9euzfN4g4qDbGBAz5
         XLpv2ppHYk+O2ur0MihWQdQE1C/4hhaU/dimKMm1aCltFRLdWdWuGaulgqKjK6Jrw6dj
         Av98Y9Y+imf+dI6xbibl7WPX40UpUz7s6lsHyQnAZG6AEDV1elvO784Z21naA6fxu1hE
         co0jrJHZzWgKQbqzm6SCv0H/kM2Cnw68OUdXqh55cq8Uh4QSC9ZaZCa1h9nq8DLa6jaB
         HECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=DR69Ezh7XB/BXMJr352Ht6r4xJUQPWAlagEfcmQDPb8=;
        b=F9GuEaMQ2JPRBh1NN2FQJBdo9++SeGR3AjqHKUM75ZY8ASOQA+iNi2an05sAUH+wD5
         olh2UkoP6JCwVF+PSYDOobHYHnpZ18uYt57Sr/DUqRq/GaP/P9ADiuHnz+8UpKHMjHmJ
         dTtxYpn+jYDi3+Hhf5JP47LXkfXF1BQcNxA7bk22l5NE0aGZMZTAuXlcyVtLtry/Loii
         9U5tb2xtzLloKgCbKHQJwrgYcqY4h4Xcb65TaMyx0X63GODzDvKlkFTgTD8oDAPmguDx
         DVlyWE2xA1uGXcUD5XLsXNVE+OSgQq+UxxNDN90/HZGsctzweP9HL4eqCQB9zjgKwBQB
         vCyg==
X-Gm-Message-State: AElRT7H90T1beiuGAA2zh5TNsp6iywVVdFmjFL5mqppdPLCdPqTlCYlE
        ZXNSvmfnfyNI+A3yyHk/I/KojlSatEsq7tFZaP8=
X-Google-Smtp-Source: AG47ELu0TSKi4CrXeGHJ3DJDAdoMt6PNsNtYUMQepcg7Mn1FiGSScGap6UTNEUKDn7cSMqixIeFgB+PrRIWdTQTR9oA=
X-Received: by 10.200.6.5 with SMTP id d5mr16443485qth.205.1520131050901; Sat,
 03 Mar 2018 18:37:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 18:37:30 -0800 (PST)
In-Reply-To: <20180303113637.26518-10-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com> <20180303113637.26518-10-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Mar 2018 21:37:30 -0500
X-Google-Sender-Auth: duLnbWz0pRqcckYV3dYSYfcEu1Q
Message-ID: <CAPig+cSkU8j-NiNeMP-F3VygF1sAoXP3qzn4fx7C1qxTZoO5+g@mail.gmail.com>
Subject: Re: [PATCH 09/44] object-store: free alt_odb_list
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 6:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> Free the memory and reset alt_odb_{list, tail} to NULL.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/object.c b/object.c
> @@ -450,8 +450,26 @@ void raw_object_store_init(struct raw_object_store *=
o)
> +static void free_alt_odb(struct alternate_object_database *alt)
> +{
> +       strbuf_release(&alt->scratch);
> +       oid_array_clear(&alt->loose_objects_cache);
> +}

This doesn't free the 'struct alternate_object_database' entry itself, righ=
t?

Is that intentional? Isn't the idea that this should free the entries too?

> +static void free_alt_odbs(struct raw_object_store *o)
> +{
> +       while (o->alt_odb_list) {
> +               free_alt_odb(o->alt_odb_list);
> +               o->alt_odb_list =3D o->alt_odb_list->next;
> +       }
> +}

Accessing an entry's 'next' member after invoking free_alt_odb() works
because the entry itself hasn't been freed (as noted above).

Is leaking the entries themselves intentional?

>  void raw_object_store_clear(struct raw_object_store *o)
>  {
>         FREE_AND_NULL(o->objectdir);
>         FREE_AND_NULL(o->alternate_db);
> +
> +       free_alt_odbs(o);
> +       o->alt_odb_tail =3D NULL;
>  }

The commit message talks about freeing memory and resetting
alt_odb_list and alt_odb_tail, but this code only resets alt_odb_tail.
