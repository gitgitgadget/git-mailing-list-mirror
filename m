Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ACFF200B9
	for <e@80x24.org>; Tue,  8 May 2018 15:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755187AbeEHPfm (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 11:35:42 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33490 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755242AbeEHPfj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 11:35:39 -0400
Received: by mail-oi0-f66.google.com with SMTP id k5-v6so21903398oiw.0
        for <git@vger.kernel.org>; Tue, 08 May 2018 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wXYK1VHIdvgzb9OVpwGSxiR12Gh8aH4BMjts6hRJa3A=;
        b=O/QGRbr7KN0REzONji81VgzufxTSbilIn4ySuxI7z5vhYVGac3EaohIrMzExhNSDE0
         CY549OKqoHFv32mBVVy6jl9IpmxHswhQQMygPhlFm+CA+hc6QfZ7SZ/OztXTYpdUV3wp
         /qxMvXZ9Qbk72H8dokFYSN/2vZXc44wRy3+I9nsh5Q2SRAmDx3XheEs2LS6rVklIs6YE
         HYUP7x+BBftrOmtGI99W+GQxA/ojgciZj1U+D45gET/mkHrGSUyVDuZlBXsAsYrOj+68
         kyQIKCtpCe9l9MFUzuLQvLyX9w67W6jeAJWMSb7A+vbuWsLiJaeUGEXjtrD+WF1c/6K1
         vIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wXYK1VHIdvgzb9OVpwGSxiR12Gh8aH4BMjts6hRJa3A=;
        b=gYau4k5gPKMuH8m1poBo632j0kpQyO3V2VBGFS4HWxpt5P21Rqqg/pV8k7gn6wy2C1
         DZqDDB87TrUGyp24Ig+7MtwEvYbhX5ZDXk7Ul0ALWthNv0YCfVs22mTcRof5GByXBNPb
         Z906NTBUSxwhf6SfNHNgpT7apOWOMFdGzoqoBr8XoDWWj7n0yk2cM59QJBj7ytTJ1NYz
         ugudMjbtuH4nOTbL4Bxc9iLjR3Au5COXPU4jr6Op/uu8ekqA335JTANeR/hqIjCUz8ri
         V8c/9nSs1d3VWIS3QemlToDu8vt/sGtXoVYtV0VS8ZJZh2V286E9N1Q91kxIYsQlcw8K
         z5bQ==
X-Gm-Message-State: ALQs6tDgS0W/s5CBFEIC+mK2nljdTFMhjYKSCHvt3b3RhI+m46rzEcNy
        L4NJyp+83G/H2onReM3xIHiVpofbqJUilq0FaqA=
X-Google-Smtp-Source: AB8JxZo/6U4AEPhJj5hb9dbZm9qPmKeVK7b7jPmHEwBMH8eMxkiTrlEpccri4O59dc5X9UplJ4I4JyWtyNvTECinS8o=
X-Received: by 2002:aca:ce42:: with SMTP id e63-v6mr27876744oig.34.1525793738430;
 Tue, 08 May 2018 08:35:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Tue, 8 May 2018 08:35:08 -0700 (PDT)
In-Reply-To: <20180501184016.15061-5-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com> <20180501184016.15061-1-avarab@gmail.com>
 <20180501184016.15061-5-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 8 May 2018 17:35:08 +0200
Message-ID: <CACsJy8AkfNfupdr1MqZSaxNCbPwBVzxXNMMqPvwif0NtuCxDaA@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] cache.h: add comment explaining the order in object_type
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 8:40 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> The order in the enum might seem arbitrary, and isn't explained by
> 72518e9c26 ("more lightweight revalidation while reusing deflated
> stream in packing", 2006-09-03) which added it.
>
> Derrick Stolee suggested that it's ordered topologically in
> 5f8b1ec1-258d-1acc-133e-a7c248b4083e@gmail.com. Makes sense to me, add
> that as a comment.
>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  cache.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index 77b7acebb6..354903c3ea 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -376,6 +376,14 @@ extern void free_name_hash(struct index_state *istat=
e);
>  enum object_type {
>         OBJ_BAD =3D -1,
>         OBJ_NONE =3D 0,
> +       /*
> +        * Why have our our "real" object types in this order? They're
> +        * ordered topologically:
> +        *
> +        * tag(4)    -> commit(1), tree(2), blob(3)
> +        * commit(1) -> tree(2)
> +        * tree(2)   -> blob(3)
> +        */

I think it's more important that these constants are part of the pack
file format. Even if it follows some order now, when a new object type
comes, you cannot just reorder to keep things look nice because then
you break pack file access.

I'm afraid this comment suggests that these numbers are just about
order, which is very wrong.

>         OBJ_COMMIT =3D 1,
>         OBJ_TREE =3D 2,
>         OBJ_BLOB =3D 3,
--=20
Duy
