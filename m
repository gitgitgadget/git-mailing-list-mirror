Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E460A1F404
	for <e@80x24.org>; Sat, 11 Aug 2018 13:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeHKPut (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 11:50:49 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32855 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeHKPut (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 11:50:49 -0400
Received: by mail-it0-f65.google.com with SMTP id d16-v6so7173893itj.0
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1cPOlKNHs7+w5fHPxYLKxEWdG0pTbrgUMv1DQJwJUIA=;
        b=U/wmPn9CUhOW56H+MhpqysbMop39hIwMyhOtu7QowAhwrfDQKVIhqmAnJXf4GSPXfs
         epxTQdjJhR9qgCK54+A2udPWRbytGSZEIzVY+BUGHMAABMi/+gCai62HakWcFrR69MPc
         LcrFSRRFwcBw6x0FiaEPEmd5TadToux5k5nMr6tv9YjlSk9HNm/voK27ts6+9f4tb/wU
         r3nYHJLuOnykSI3UAJ2JMyc+vVkr5nuSpuM7iea6znsp+zVKrCiaXAi3Qts0wZmmr5BY
         cLqosVHBOTcEjOyx0PYtnnYsuSqlZzC3knOuJxHoF6azss81aJ1LWACO2zMIIRk+v22E
         9tPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1cPOlKNHs7+w5fHPxYLKxEWdG0pTbrgUMv1DQJwJUIA=;
        b=qUSFQLcSnzsDov2fxDy28orjyhgOmqV5X4tu2WVHge+l5ZJ3kBwNv8Dy/nKsf9eOu0
         QduI+KPptqUpQz2d+gJ3MQhS4Vs78kfCOwIr1RDa8LwnkjueIxNYYQhT4dSEgMxMdUn0
         14BK/+hVknxt3hJL5gplkMKhzSrEhDFtqID6lCIzNUfa3Fpuos/NIYDUyCauAroXiJYB
         +o2KWzTJRk75uq4FiHCJDs4YR07yXfN3P3zFGTqHnTil4w8UI43gcuUUknB3Q92976Rq
         OqvAqGFeVZyxiGJgfNSy1Y/6FwjyeSz1P85R3HDw1hdo6JJl8LkPJeQYbASVcDqP9eJ7
         0ogw==
X-Gm-Message-State: AOUpUlFe6XyWIgmIF+OHQFjnzhEPhpqh7T36RRyqrtbzDI2EYBk83tCc
        UCndpV1+urkdjEqJ5LUTUbFL33ODNLdm3Hz1rgHUU3Q1
X-Google-Smtp-Source: AA+uWPzN+86Q7TN4fuJ7kfv6nW18rh3YfOn9sBOzEqVg5T815bWYDi/lgQIaICfTvYFHqKOBnoEqLJrI1qzUPsIviZ8=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr5735032itf.78.1533993399192;
 Sat, 11 Aug 2018 06:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180807190110.16216-1-pclouds@gmail.com> <20180810153608.30051-1-pclouds@gmail.com>
 <20180810153608.30051-2-pclouds@gmail.com> <20180811100905.1511-1-szeder.dev@gmail.com>
In-Reply-To: <20180811100905.1511-1-szeder.dev@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 11 Aug 2018 15:16:12 +0200
Message-ID: <CACsJy8BeRYVvWvTQU+bj+hSQ3DFw0mHtSjtOg9zVSsXznpU=Xw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] clone: report duplicate entries on
 case-insensitive filesystems
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 12:09 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>
>
> > Paths that only differ in case work fine in a case-sensitive
> > filesystems, but if those repos are cloned in a case-insensitive one,
> > you'll get problems. The first thing to notice is "git status" will
> > never be clean with no indication what exactly is "dirty".
> >
> > This patch helps the situation a bit by pointing out the problem at
> > clone time. Even though this patch talks about case sensitivity, the
> > patch makes no assumption about folding rules by the filesystem. It
> > simply observes that if an entry has been already checked out at clone
> > time when we're about to write a new path, some folding rules are
> > behind this.
> >
> > This patch is tested with vim-colorschemes repository on a JFS partitio=
n
> > with case insensitive support on Linux. This repository has two files
> > darkBlue.vim and darkblue.vim.
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
>
> This patch makes 'clone http repository' in
> 't5551-http-fetch-smart.sh' fail with:
>
>   --- exp 2018-08-11 02:29:45.216641851 +0000
>   +++ actual.smudged      2018-08-11 02:29:45.264642318 +0000
>   @@ -15,3 +15,5 @@
>    < Pragma: no-cache
>    < Cache-Control: no-cache, max-age=3D0, must-revalidate
>    < Content-Type: application/x-git-upload-pack-result
>   +> warning: the following paths have collided and only one from the sam=
e
>   +> colliding group is in the working tree:

I was careless and checked the wrong variable (should have checked
nr_duplicates not state.nr_duplicates; the second is a pointer). So we
always get this warning (and with no following list of files)

>     I also notice that this patch doesn't add any tests... :)

This is platform specific and I was to be frank a bit lazy. Will
consider adding a test with CASE_INSENSITIVE_FS after this.
--=20
Duy
