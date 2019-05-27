Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93F8E1F462
	for <e@80x24.org>; Mon, 27 May 2019 05:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfE0FLr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 01:11:47 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:33363 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfE0FLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 01:11:46 -0400
Received: by mail-ot1-f54.google.com with SMTP id 66so13764001otq.0
        for <git@vger.kernel.org>; Sun, 26 May 2019 22:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXasfRr3WVu2QjVB3Hhn5ipS22vpBKkSL+FCce/SicI=;
        b=tgToL53USDRt57zL+KNCVHoYsBMxDkZel5zE4BMQr4SI/bsJfwovfH0PsmMBPWmjGX
         B3tMJKQnDK8OfZNDI09BsSE5QGyd+BqppLkOxWvxjGyDxYr28CPWPenLfDgFhE1w8q7a
         C1BxfPiTt2RePo1ZjddtW8To4+rtgD2+v6gCs4hylSpDGNeSxAmrtE3HVlXwa2B89VQD
         RiWTo5BWKg/v4cr1MrpYAgcTyNbsLwEYYWLaCN+WF3n/NHC1UQNLAPM3NxAjfhQMMUCd
         0dX6HA8BT2Qhhxh3rusbFQYsjRj82McrKhOm7JEQe8YnIIWZQc1ZVqriu6P+zXFc47MX
         Jn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXasfRr3WVu2QjVB3Hhn5ipS22vpBKkSL+FCce/SicI=;
        b=YFk9VF6k/n+Psk8Ys6FzCpBlWiwPj6W/e7o6JaBdSnvm/n2WDsjV1d6wFkm/V229eH
         G8zbkjIKojPK2ch2fM/Uu25vkVvP5KKlOWA0wGfyvMHFhL7DXnDw48yReehSuq2Cev3+
         ufVHFH+OWzoNf6NnWDKhdXUpvNnja2DpNIwHknl1K0AuAY2YJgQ5emwy/gBlXlBSGoZD
         UfGeoPSNvEnmSNyEr3yUr3PAauWEDJPr00FIbfDkn8vaxxG0dJmp1vgEygAiwzvTPH4B
         wfJqs6rhAwkDLXiD4ysEcpL/TWVH0wDTylPPjZx5P5UDgFQZWSovX0OuEhHqA8F9YjiV
         2YxA==
X-Gm-Message-State: APjAAAXZnn4iqVgUW4jEvRrvBRVraSIf4wXCxNvJyaxbbd7MU1GBhA3D
        3I95THR2oKjxurUHbr/UYQkEKuouCe9s+EF6/wRY4pjqmnw=
X-Google-Smtp-Source: APXvYqxENpqum4JOT3XO9Hgoq6D0hzeeWIVF27RYJe3M+BYKfPiT346mfQzlFn/I01T4pKUZYPGXRsOET1MiOLHPjtI=
X-Received: by 2002:a9d:7a99:: with SMTP id l25mr21844364otn.80.1558933905916;
 Sun, 26 May 2019 22:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
 <20190524070644.GF25694@sigill.intra.peff.net> <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
 <20190524081337.GA9082@sigill.intra.peff.net>
In-Reply-To: <20190524081337.GA9082@sigill.intra.peff.net>
From:   Keegan Carruthers-Smith <keegan.csmith@gmail.com>
Date:   Mon, 27 May 2019 07:11:34 +0200
Message-ID: <CAMVcy0TgmWPccokMeUmaPSkj=6QhZfaACEEqoSqqqL4g3WSwSA@mail.gmail.com>
Subject: Re: git archive generates tar with malformed pax extended attribute
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 May 2019 at 10:13, Jeff King <peff@peff.net> wrote:

> It's possible Git is doing the wrong thing on the writing side, but
> given that newer versions of bsdtar handle it fine, I'd guess that the
> old one simply had problems consuming poorly formed symlink filenames.

I agree that the reader should be able to handle it best-effort.
Especially given both bsdtar and gnutar seem to not choke on it. I
mentioned go's archive/tar chokes on it, so reported that issue
https://github.com/golang/go/issues/32264

-Keegan
