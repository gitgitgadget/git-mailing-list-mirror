Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0AB20248
	for <e@80x24.org>; Sat,  9 Mar 2019 19:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfCITDI (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 14:03:08 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33111 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfCITDI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 14:03:08 -0500
Received: by mail-vk1-f195.google.com with SMTP id r189so162937vkb.0
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 11:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TcQkZWp2jKoyBO5BfM6g6Kfr63PcKqhXJruMZ6eck4E=;
        b=cb5smrdsUuZU1YpiQZqQHn4FTpapjSETraAD3hwAIvFG/ewHnEYq5LLY2cUPQnRXul
         Fi9yT4l/tScX/PuMYNgnAOw8IruA+UojN7ttdU11RLm5KkGxi/9tjJZCxDwmzqrzMLrw
         gEbhb7Z0F7YMx+B/2Xku0LwrjfCcNA/HO3Z6czpoD6ngDJD1IGzv7XI2fd0bRl0vo+RV
         P5wQoUKTUb88lS36Ex0W9R6u+kr9zZLMx0h8j+rf1QcWIwEGUNVGcrEPDNd/RyJGdbxm
         ToJEwcuZDD1z4Viy9ZR1+BSZWkVVDd8vUoTi7ahXKjmnIOEhBJkks06mSa+df19K2FLq
         mNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TcQkZWp2jKoyBO5BfM6g6Kfr63PcKqhXJruMZ6eck4E=;
        b=UwFJ8PW4PpgJ+uhGQxVrfLBmrYJjQimA0z1mx0FBo4B8+6CzXVEGQn16tOQ85dQpiy
         VFNe8iwpVfrjnRYVJ4WKVTIWsSTLCV/UIF8HnxdE6WH+IPc3K4cxtCRPGjJ6MiUuDD1e
         8KKded6XFYOoaldB79CbZkQPWs0yUU5FfdqFkvsVEBZeEql/F9qFC0LT7R85CCbYhO3+
         id37bHgnFAqGgw3XjKUlpk08r3nZyynnYJXQDt32vCXo9XdIFOAeNzWqY/dqzHLuwQd5
         zakMUgWgtvyjtZ+0pnHaBVG9T6tPSa/pKuWTWZ1ThHOhfDfiLjfBNPd281JN7zNIRhUe
         89HA==
X-Gm-Message-State: APjAAAWdfgNGR6P9gQ6WH83rAh1u5D7QFZfpi2cSfS8E71xkgjjxqPmn
        SxBx89ypCxIEh7EvMXxmKPrtp5U6ZTcitJxsbOQ=
X-Google-Smtp-Source: APXvYqxur1+UJgfSlMNaWWjCPc5077kCTRsSYWozAnto+6GKn4atgLIfi4v6PyA0XXl7OIrbzJpnLV6fmD6Ua2GwxjM=
X-Received: by 2002:a1f:a14f:: with SMTP id k76mr12413489vke.15.1552158187119;
 Sat, 09 Mar 2019 11:03:07 -0800 (PST)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-9-pclouds@gmail.com>
In-Reply-To: <20190308101655.9767-9-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Mar 2019 11:02:56 -0800
Message-ID: <CABPp-BGg6k_=zjZ+vCGzh2hu5KnXf3=OMDGJ=eei0xmxh6trAQ@mail.gmail.com>
Subject: Re: [PATCH v1 08/11] restore: support --patch
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 2:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
>
> git-restore is different from git-checkout that it only restores the
> worktree by default, not both worktree and index. add--interactive
> needs some update to support this mode.

Nice!  That removes my frowny face from a few patches before...  :-)

> @@ -436,9 +436,10 @@ static int checkout_paths(const struct checkout_opts=
 *opts,
>                         patch_mode =3D "--patch=3Dcheckout";
>                 else if (opts->checkout_index && !opts->checkout_worktree=
)
>                         patch_mode =3D "--patch=3Dreset";
> +               else if (!opts->checkout_index && opts->checkout_worktree=
)
> +                       patch_mode =3D "--patch=3Dworktree";
>                 else
> -                       die(_("'%s' with only '%s' is not currently suppo=
rted"),
> -                           "--patch", "--worktree");
> +                       BUG("either flag must have been set");

Very minor nit: I suspect we'll never hit this, but do we want to make
the error message slightly more descriptive ("which flags"?) in case
someone doing refactoring work does?
