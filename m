Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D74B61F404
	for <e@80x24.org>; Wed, 31 Jan 2018 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeAaUm1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 15:42:27 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:44267 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeAaUm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 15:42:26 -0500
Received: by mail-qk0-f177.google.com with SMTP id n188so5167032qkn.11
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 12:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BJ+pbCUoRNwsopTLMWmNGBYedRYZX4WkMt+TAAfWcps=;
        b=E72G6lemyX7BensBljKM0q7gu1+O0zRlpPhwidT6mQCQUhjTt5Qk203aQHQXEVescU
         iBgDf29+/z4Ghu0y7Uu7buIz9t5yrtiLdLVVzSh9tD97v9ifTCoOiJxy6a3x5Ex3xtBy
         8TiQfnk9O38CsZy8Qy5KFnBCcJiyYyUk+WhQlXSo/icN+K8qokfcg8cI1Xu0VO59M3tO
         v6NbO7W0AVQ7BuWf7xXghCffV+o5hv9gP3lGRrpSjWPOL7h6conDxmmqxak4UrD7f3uN
         h/mnUFZQmssb8RJNv1qtRP8+ju39CorzXJBix9EPIRDzXFa6zKuF3CDskjZIYeowisIo
         +m8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BJ+pbCUoRNwsopTLMWmNGBYedRYZX4WkMt+TAAfWcps=;
        b=iL8Sor9VHknq1Vf9gbEtEY+SUKdDCX8gTBhzX9rvmC7bUEKzyQo4Ar0gUjNJ4eUVRZ
         I72fncUo3G2e2FMZkD/56XOICmeWxglrQzW7jmqada5ZRcoMvhBUDEMVdNxENiwmP8tR
         b8X+MEYMav7VvG7PEuxLnAq6UewGbufqVLJxkm2l9Dfp5EmVTzaFA2kB0Oa/2kzEwjIc
         EIyzRemwt899xzDrGw0LktluRtDGuESuGuj5cU8GjerRb2MVdd2mXBI49M3nwnV3Q7kE
         EOq+ZmR199Bt5RiKh6Fa2HnylAZZNploGJvL9PVbDrjKSK0z+sEr3YaPNmaTohAD07ba
         spww==
X-Gm-Message-State: AKwxytei2WwvcjOxVOQYTpYRMNl2+GO1tY34gbveBq7wsG8jt5L+AM1N
        xQJ4bINUxbP0qYJsuHU4qYfeDaT/+NTFIHEebD4=
X-Google-Smtp-Source: AH8x224lTngmDJHdYbGeSu2Ekq3JYbOSb+4xaLmHYmeh/pbUUPc27lHXRfmiP3tdJxxzWsA266YMLeFBYHjWOUglnEE=
X-Received: by 10.55.143.193 with SMTP id r184mr47252963qkd.164.1517431346056;
 Wed, 31 Jan 2018 12:42:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Wed, 31 Jan 2018 12:42:25 -0800 (PST)
In-Reply-To: <20180131110547.20577-14-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180131110547.20577-14-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 31 Jan 2018 15:42:25 -0500
X-Google-Sender-Auth: d6vxD5bX_FjpXV2fZRdDrWunqDs
Message-ID: <CAPig+cSq9T=r6uEqwxtaCtD1RQkeiavF7M24AvM=fo4nYhrhag@mail.gmail.com>
Subject: Re: [PATCH v2 13/41] completion: use __gitcomp_builtin in _git_commit
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 6:05 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> The new comletable options are:

s/comletable/completable/

> --branch
> --gpg-sign
> --long
> --no-post-rewrite
> --null
> --porcelain
> --status
>
> --allow-empty is no longer completable because it's a hidden option
> since 4741edd549 (Remove deprecated OPTION_BOOLEAN for parsing arguments
> - 2013-08-03)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
