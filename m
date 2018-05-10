Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217061F406
	for <e@80x24.org>; Thu, 10 May 2018 17:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966596AbeEJRRB (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:17:01 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:37084 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJRRA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:17:00 -0400
Received: by mail-yb0-f180.google.com with SMTP id i13-v6so903469ybl.4
        for <git@vger.kernel.org>; Thu, 10 May 2018 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xWTGpfuqalJtaMCiY1Ifd8/RP4PbGrCM1tETsnDvPLs=;
        b=iAalrKKqo7ji/OXYgo1yeIMn3FV2LlG9NHkclvSf11pFEvra/HhjyvZ5RJB/7oDJ+r
         rxNLKoK24Aol5Toy+8O8i5+Do8BuFcB2mObOEeYs7wWyD4djyv4e17ntyyRY4H4lxm0L
         MLgww/C+u6I/0eZs+x1dBNw672zWbmt1bV98KmOSRUoM4Aw0iOtcDSqPrevQHiMWd9tH
         oXKvL5QoL03yApO8qlzx3mWpAALw+wrJGX18mNDys0YHMOY5RhRTru2UYvjh4GLXTbor
         sUgvXRI2fTUCZHNDBeKA/doHSm4MOJvHFEOXcqxNkqvVhVCm0D0teZNoQVYYPY72U22v
         +2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xWTGpfuqalJtaMCiY1Ifd8/RP4PbGrCM1tETsnDvPLs=;
        b=o+NL5pSgi/tdjH/6XqbekiMVug2onzGxPA4mMMU+BI6qrLS58yDoTnrOgglkvnzf9s
         4OjLt1IXOZd87Nuz2Nid43XQ2z/iO0gX0fCSRPiY3LTQ+LfMzskiR99p0E+O/ExJcf+c
         xJwsfyE14qRutcDIkx/TTLKl6zGsTZruVzpRkJdpZYydTWDOxTStbyFuKkIOj7YkbSEP
         Ny7k+lT3wqVI+5EG+MuMClKjlqd7GJMoEVuTNClSEJ/4M6yYzHX0S/tiuLIU9XGDXKmX
         N/SR4RJlDxe9dJWt/S55iCkPmcsz/PoaWUwr3sKju+Mt8wdVBuhL7hY+M9VsKMMMLAbz
         EQXQ==
X-Gm-Message-State: ALKqPwddR4VF6zVF/pvoZy43pqtOVbkkN5MnzS0Es1poITzkNCzdA9EY
        FA08/sY0HhexB5Q/VAAv8jAYBKwBVlBtbhsosMvNww==
X-Google-Smtp-Source: AB8JxZqjAU0xKdWTPBXjGF8ZcEhIEtxjISArZQtP65zJbgXRNBI+OUFi9nldDTA21cIw64OeD/+O8BgpzqwO3v1fbBA=
X-Received: by 2002:a25:dc4d:: with SMTP id y74-v6mr3731ybe.247.1525972619223;
 Thu, 10 May 2018 10:16:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 10 May 2018 10:16:58
 -0700 (PDT)
In-Reply-To: <20180510141927.23590-2-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com> <20180510141927.23590-2-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 May 2018 10:16:58 -0700
Message-ID: <CAGZ79kYnzQM-mcAm7Q3C=q+uhvt8MYvWrhkUrsyu1FbM2=1Z8g@mail.gmail.com>
Subject: Re: [PATCH 1/9] Add and use generic name->id mapping code for color
 slot parsing
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 7:19 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:

>  7 files changed, 82 insertions(+), 112 deletions(-)

Nice!


>
> +static const char *color_branch_slots[] =3D {
> +       [BRANCH_COLOR_RESET]    =3D "reset",

In 512f41cfac5 (clean.c: use designated initializer, 2017-07-14)
we thought we'll do it once and see if anyone complains
(and it shipped v2.15.0, 2017-10-29), and so far
nobody complained half a year later. So designated initializers
are all good now? Do we want to mention this decision in the
commit message?

If so, the patch looks good!
Thanks,
Stefan
