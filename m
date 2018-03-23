Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 485001F404
	for <e@80x24.org>; Fri, 23 Mar 2018 22:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeCWWHf (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 18:07:35 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46517 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeCWWHe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 18:07:34 -0400
Received: by mail-qk0-f194.google.com with SMTP id o184so14510952qkd.13
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 15:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=cvgv7v50k5CDmhHELtA0BvrTvgXlRiz659JRRiYoFjI=;
        b=tTpdqJ24BbIyu3v1Nhp7mc3wA3CpAawEzDO4PKXreoxEYb5gKq0SR2Xm+5hm/itSvb
         s+mBCVQgiX05oNyjCAKuxyhEXe1+kughEQVWWtRQsAao/G9gq9e5mC8/seLmL29sPwY3
         TMgjtD/UaPpijzmQxdWv7uRIcqfLwNlkC1UshJxGBefm9Rp4OadvZ3OmPWn2DaNZ6hyP
         Y9DZtwana+Zg/029AkC7TBaHTGBfXwj6S2Ji1sAJaWklbI5ygHKh9MijWs7vmnI1qXeZ
         gvw/OGqNR0yv79NDJMNs3r6bSBEnZk+xi7H3uBjtCb9zXSso0W8TrkUb3K7sW437378Z
         SplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=cvgv7v50k5CDmhHELtA0BvrTvgXlRiz659JRRiYoFjI=;
        b=N9/oMNlheWKwsEO9JETJbsI4TAracu9YJPxJFPvNhKcQJVNpQ/Iv+HWNQM7Moo5o6e
         n+03jzA3oSiRTa92Rh//pvhdeGpi6XAw7ZFZj+ZryWv1YBAZp6LX2Ik5suInZqocel96
         6jDSlmd6SFE7fg5XCRjJ6REwMWwXhX56P0fwKZjSKE/02oOBWezAABmDcQiSEN7T1HmX
         mJBdtHVEVflDyy8UfscqS6qg4YK1vqpMvZXn9gtdoxq79di/p4CZ0UPXXFweQjEcPycY
         GahAQgqOtWlSopWJr36m1SAZWVu4djLgCKvYkw0lOmsuWaId635UQsriHD/aWcLutITM
         19yw==
X-Gm-Message-State: AElRT7Ejln5xG2MobpKnPpufteIOKRSTZhOOIZZZWQzgpM0jdkSkITFF
        XI+28U8aA9j+c3j4GXJaXipMwSiwklaAfOww6Dk=
X-Google-Smtp-Source: AG47ELsqoIiA2szBWtYDhdc8Fj8674HpWByCgGtZQhtoAr4e1Sisn9Q9hajN9lErEQaR6yVokju9+UHJ/imHZuT51xI=
X-Received: by 10.55.198.217 with SMTP id s86mr42381499qkl.153.1521842853448;
 Fri, 23 Mar 2018 15:07:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 23 Mar 2018 15:07:33 -0700 (PDT)
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com> <20180323172121.17725-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Mar 2018 18:07:33 -0400
X-Google-Sender-Auth: SWOnYCtSWYMGE_9NgDRSvWPd-jg
Message-ID: <CAPig+cQ=u2xVaptpVzVd3g_RO+9kTWVitD4V7zpZFuL+a3wmtg@mail.gmail.com>
Subject: Re: [PATCH 00/27] sb/object-store updates
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 1:20 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Interdiff is big due to the "objects." to "objects->" conversion
> (blame Brandon for his suggestion, don't blame me :D)
>
> diff --git a/packfile.c b/packfile.c
> @@ -1938,7 +1939,7 @@ static int add_promisor_object(const struct object_=
id *oid,
>         /*
>          * If this is a tree, commit, or tag, the objects it refers
> -        * to are also promisor objects. (Blobs refer to no objects.)
> +        * to are also promisor objects-> (Blobs refer to no objects->)
>          */

Meh.
