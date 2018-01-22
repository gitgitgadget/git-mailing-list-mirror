Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9FC51F404
	for <e@80x24.org>; Mon, 22 Jan 2018 12:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbeAVMob (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 07:44:31 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:39739 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeAVMob (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 07:44:31 -0500
Received: by mail-io0-f180.google.com with SMTP id b198so9275934iof.6
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 04:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XSExrw1slO22VyYwK17xhoP/ukyaReNHmcLDoUrtRIM=;
        b=m8xxri3FehdLUXUlBXhpvzatRVbbLMw/4c+LPHwKRPTdQZWdZUQaSC5T2EOzOk3j3I
         WaolDaiUE7+Kp74HNURymD34yQEovZDdrRstyQ/rtFLuVJJWfNjqR4X/V3PimIMaL6qK
         2u6lwI63hX3+p8lFgp8FtY43KWNCsQP+p1z4TE61qb+sXrJB7HlTLbly+/eBAqtFZxUz
         2dIWPbtt2dGy1+Pux0WvDjhAUdcD7dNoJpe4KP/mhLu7GC3bmNyTb/8qagubA1fFaoT7
         0id8Su2WmRkEyf25yLVB/ze1Gyb5RxgMpIaekEyyGT1me4OgwhHaf13ISUj1PNvAb4Tf
         SQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XSExrw1slO22VyYwK17xhoP/ukyaReNHmcLDoUrtRIM=;
        b=aou7a9YK02gXidRbQ67cd1j63m5LMr6fjPfOZeprdFlH18OeSczPicfsfc0Kck2M7g
         W+BEKSBgzC5pm6ePIxxFnWULrOedPPMU+NEMJp8AZaF+mv4BDAFJ/j8EJlOBNXEb6tvr
         87KFfJpzFS2vban4F9dVYM9OhWeNioS30FsM6SX5zuwLfSulpTG+ulGJYQYXfT3ZRsjs
         DP66+jWHDUWI8X0FU9xfCbUHEEPVvNODG+fe0ez0oIOpNkUwWyb9xUDBgt36ijHSXv1z
         C+ZayzQerGv2zdNyhDwBeOcQSpqqtmlGPqTsX+D5CacZMXz+LmoVcoX+mcNuG/8kuMJU
         lLsQ==
X-Gm-Message-State: AKwxytcuX3Sep0Zcnhw4zrdbk56eVmfwu6AzPHIF5llR9BDLtFCMYib2
        2AvWlOvaR5zQabEh8uyRTac9Y1CqwX1i9gNrcdV1Tw==
X-Google-Smtp-Source: AH8x2275lIju8yRRmEM2MC2dy33dQn97IgCrX3P9QOtBOLcH4UisMRwh5A3B2fAwgMSuvdc7YgGNJEPqv8C4FYSkwt4=
X-Received: by 10.107.78.16 with SMTP id c16mr8199573iob.105.1516625070507;
 Mon, 22 Jan 2018 04:44:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.206.140 with HTTP; Mon, 22 Jan 2018 04:44:00 -0800 (PST)
In-Reply-To: <20180122114925.GA5980@ash>
References: <cover.1516617960.git.patryk.obara@gmail.com> <757646a6b42e8a0ceb50665a1fe6f588227d9873.1516617960.git.patryk.obara@gmail.com>
 <20180122114925.GA5980@ash>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Mon, 22 Jan 2018 13:44:00 +0100
X-Google-Sender-Auth: IOu2fMmY2OO8HrPyGieMNFhJHpw
Message-ID: <CAJfL8+QcfaypDagYDjCw=eFqUhhFZ5qyMgjQcoyshnvnh7aTmQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] sha1_file: convert hash_sha1_file to object_id
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 January 2018 at 12:49, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Jan 22, 2018 at 12:04:28PM +0100, Patryk Obara wrote:
>> @@ -969,7 +969,7 @@ static int ident_to_worktree(const char *path, const=
 char *src, size_t len,
>>
>>               /* step 4: substitute */
>>               strbuf_addstr(buf, "Id: ");
>> -             strbuf_add(buf, sha1_to_hex(sha1), 40);
>> +             strbuf_add(buf, sha1_to_hex(oid.hash), GIT_SHA1_HEXSZ);
>
> oid_to_hex()?

I didn't do it originally because the size of hash is explicitly
passed as the third parameter.
I should probably replace this line with:

strbuf_addstr(buf, oid_to_hex(&oid));

... since a hex representation is correctly 0-delimited anyway.
Will include in v3 unless there'll be some other suggestion :)

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
