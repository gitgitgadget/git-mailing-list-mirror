Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B9F91F405
	for <e@80x24.org>; Wed, 19 Dec 2018 21:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbeLSVty (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 16:49:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35423 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbeLSVty (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 16:49:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so18752160ljb.2
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 13:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ssz2cdrxZftCbA0eIbNghh92i8SmtOZ9aRbOc81OGP0=;
        b=IfPPDhEDZVtqO6zbDGXixIKnrYePOlU9fPgbX+uO2z6RgdxU8OQ9AP+iiMIGg3duK0
         oVH3TrqFxP1zsOFWEr3d9KgmGX1jHVSXEY92oK4gIow8x+W2khG0RlE/CjR5Fjyf5MmW
         Fnpi8uqXz0hXwCangxiKFYEpovufm8Jyb1s/78Q3AGSdHbf+QR2Mnot5ZK/KHrhWHZld
         t99nmzrKVbR5ffcnxOnYUjBKH6G2+JtXyJ+sAtBfW8AZrhwz3GXD4SuI9WzRTq9yMCYs
         ZH7c28wSGzhInmSaqL46Z5PDs0T2ECYpJD5Jn4SECgYOVIjuUAmd4ezWayOW1f7sOmag
         a02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ssz2cdrxZftCbA0eIbNghh92i8SmtOZ9aRbOc81OGP0=;
        b=nhyFbDX0Eh2l5Boze9p/HSXqYDqmJcxbz4Y0U4Db4BRGUp/r4VvE7UTgK7eNDJH9st
         Dn0onrLtfKH47QSqGryYB3sd9SuIXjiHkOSS1akbCpkXVb1NI7g61KpPT9BPpaso+8QG
         qKaGLxnQg1ChhyVg8LhiPVh+i0Gs+ZKIubDmXFvBWwUps6/5cYMelTKF8w+h3OzXG3ao
         ngNI5ES1xJhGLRLde0zfAtU1cwwTMp8BdbbRDEI4lq52waiy4r/aoEtQvl6R6T99bwqk
         LeWUN9ZcRxIVveNjHm2KjDY+OzidVnTIrWTsOamq+/E7u0sAzfBqQWgBNo9j+Tv8xx6F
         Rg0g==
X-Gm-Message-State: AA+aEWbsDbZUQ120D4/fdvw0ivKbfQzADj6mIw1FxBJQ12tttIA85E7H
        7mF4T46GNObUYh/Ukb/B5THCkw9xgROP3xPw/ag=
X-Google-Smtp-Source: AFSGD/VxtkK+y6Dz703NgKLdYFyHz+PJRSxWTLt8JKCPYdHg+hQ5zXM13JPifCvL9zkorxwLZCabd0yrmX9wBZWJUdk=
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr13021725ljd.137.1545256192354;
 Wed, 19 Dec 2018 13:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-4-martin.agren@gmail.com> <20181219154853.GC14802@sigill.intra.peff.net>
In-Reply-To: <20181219154853.GC14802@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 19 Dec 2018 22:49:40 +0100
Message-ID: <CAN0heSr5KFK02XHk2rK39zEUoyoJCkqA=22qSkETehyKewM7GQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] setup: add `clear_repository_format()`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Dec 2018 at 16:48, Jeff King <peff@peff.net> wrote:
>
> On Tue, Dec 18, 2018 at 08:25:28AM +0100, Martin =C3=85gren wrote:
>
> > +void clear_repository_format(struct repository_format *format)
> > +{
> > +     string_list_clear(&format->unknown_extensions, 0);
> > +     free(format->work_tree);
> > +     free(format->partial_clone);
> > +     memset(format, 0, sizeof(*format));
> >  }
>
> For the callers that actually pick the values out, I think it might be a
> little less error-prone if they actually copied the strings and then
> called clear_repository_format(). That avoids leaks of values that they
> didn't know or care about (and the cost of an extra strdup for
> repository setup is not a big deal).
>
> Something like this on top of your patch, I guess (with the idea being
> that functions which return an error would clear the format, but a
> "successful" one would get returned back up the stack to
> setup_git_directory_gently(), which then clears it before returning.

Thanks for the suggestion. I'll ponder 1) how to go about this
robustifying, 2) how to present the result as part of a v2 series.

To Junio on the sidelines in a cast (hope you're feeling better!):
you can expect a v2 of this series.


Martin
