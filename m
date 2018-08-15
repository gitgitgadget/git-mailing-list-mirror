Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9691F404
	for <e@80x24.org>; Wed, 15 Aug 2018 19:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeHOWPP (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 18:15:15 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37171 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeHOWPP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 18:15:15 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so3426281itf.2
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kUGgP5z5ow9xjrCooeDykdZ6GQYWwv4ysNolK2tBPrI=;
        b=SkLD18+DiGPLwZIPozu5lmM3/25OgszPQ2DW4Mt7zi7z7X5zClUv+PRIdORvUxqS24
         kI00d3N986W6WYyEBsb9amhgkwIffJnOvHuJyjRut8DjCFaJfZXlS8AmTklg3amUDrdn
         TWZcl179kW9pKlaClHe1gOIZnO6MfkR0TUxlkMvR7U8PIO78fcLT1byK58F3PCk32FUN
         e3qP96GYxQrEcFsBG9G50dT118PHVxFOXZtq6jaWEQXGqLgEbT6QvWR35ml7Khgfyc7m
         uV5zoOULXYejSq7l4jXEsyXYHZEkVZ3FYCTxi2d3+kwAQe32sWeG4+MYoaxUTRVO8uY6
         1+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kUGgP5z5ow9xjrCooeDykdZ6GQYWwv4ysNolK2tBPrI=;
        b=Gs+MmGg+aaXoRQ/urBbPLKkcrW1oevRmb+D5nSMHl4U5txs9cPb5cek9sLo779Ljke
         6imGZ7j5F0hJykT8U2w/Xql17+jv1QegWNfwJwpPhWE9XbUeM+rcI327vY18DRRam1Vy
         z82Ak0/wEaWMNlYOXpCyOUusFaRQVQMW+moO4LEC+hTzdDHckHbjwjOOqqlIlR7EzbWU
         zHC4BKx+uzf+POcZga7t0VLEXnWVptp2IbkRZIhhc19mtBUy9KSES3MsIIvRUb4eSKFk
         fwQMawr+wtmUpnHp+RPvU+Fc57n1z43SI1IovzqndE6qLr7zg9CbenzIqVvVBNAoc0j0
         4xcA==
X-Gm-Message-State: AOUpUlFQJ6WG6GCeRVlEjp4nquHgfV8cGlZ1GZ0IYst5IvRvxa7gevmn
        uY1t4rtTwCnyq+LZcv19yxoscIyjhm67Wo+ONDI=
X-Google-Smtp-Source: AA+uWPy3RplDfWpXWbF6vq8vcT/VPTeLidUDzNExMOT3/QywYQcCAZAZha24B5zi7DCt3dn694HNW/9V153ZHMYJ7TQ=
X-Received: by 2002:a02:c50b:: with SMTP id s11-v6mr24261738jam.61.1534360907678;
 Wed, 15 Aug 2018 12:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180813161441.16824-1-pclouds@gmail.com> <20180813161441.16824-9-pclouds@gmail.com>
 <CAGZ79kbs+4_D95+F5km0ODPb1_7tPXMivet35Pq+4vut1ZS9dw@mail.gmail.com>
In-Reply-To: <CAGZ79kbs+4_D95+F5km0ODPb1_7tPXMivet35Pq+4vut1ZS9dw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 21:21:21 +0200
Message-ID: <CACsJy8AJh16X5HPf6GqfBn-6JwiDn=3505d0+e38bNOxOTg76Q@mail.gmail.com>
Subject: Re: [PATCH 08/24] unpack-trees: remove 'extern' on function declaration
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 9:10 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Mon, Aug 13, 2018 at 9:15 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
>
> This removes the only existing extern keyword, which was added by
> Linus in  933bf40a5c6 (Start moving unpack-trees to "struct tree_desc",
> 2007-08-09). All other callers do not have this noise word as it was
> simply never
> present there despite the old age of unpack-trees.h. Interesting history.

Linus did not add 'extern' though. It was Johannes a year ago in
16da134b1f (read-trees: refactor the unpack_trees() part -
2006-07-30). Man this function is _old_.
--=20
Duy
