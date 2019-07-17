Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C29B1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 01:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfGQBJT (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 21:09:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45803 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbfGQBJS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 21:09:18 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so43078787ioc.12
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 18:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OMX5PKTrH7tNH7IFbQLAhYCPVKQOzeqoGfMPoRH2T64=;
        b=PwA4SxFIlnc6LVVE38Eolckhx1CaREjo/k2cdiZxTGlIOhg++uecm/ZgQ6t9oImk0V
         sgeoffO6/jOzBEJiwrFpEGtCVCzg8iohiTkqqSWRNtL2O21PPhVCripuA8zTeiNQ6ZJ0
         gw60vR+ZnK+bD+ZEYF7M+72A+PxyCblMsjr0MomBBWELLTtcoRKpLbhPyKdgeZV1GmZA
         sVvt2hK3FEhgyYt1n097oLN9enkF0e9KJ9Nb4NyzZqkckxlLy5TiwfP8UoPLLte1gdcK
         VL0GkEl3ogSFa0hrUcshFvqMo9+9/C5T5FwFdXB+VFCfNzwpRtN72KZShNXDvEYKL93u
         55Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OMX5PKTrH7tNH7IFbQLAhYCPVKQOzeqoGfMPoRH2T64=;
        b=rSEMUI3jH3wan0a+FZoN9W9qdIDBq9J3EAjqnhfkg3v2Nftc5HS69dYeo3RuQfEv/1
         C+BMTxFtfFDf2ch3F3l7sWSqQqI8tgGMSl5lxhJS6szG7JjiOoxUF1oOGYJ2yFuP/iSR
         tqu58pHc2DBrz6+DJcpy/SBVwEr8szLHWJo0voWMMnIYoUv/SQj4J+m7RS/1rzrtb4Qp
         gZjormCUkDaPxibVUzvdQeQud55tFJbcLHbUKCFpcc6gZCLhSJgjIgZLmI7RkWQaQNvs
         aH06XnkCdE85s+WBTHqD++Bg+4U8Xxet0vdgkIIs+8IV6VHNkYQF7s1cNyXMBYQJQ5RF
         tfVA==
X-Gm-Message-State: APjAAAVwMIItDcvRm2/UU6i5GOg2w0jhLpZTwJrWS0+iU1CRGQ4aOwio
        NDZZ4SA6mqyZ20SbkqZFkcQBH1VB9cJLeJnpGv9L2g==
X-Google-Smtp-Source: APXvYqxKkqSMTFkq/lZ4b/OWGtlcand+fd146qrs5AmU7nMGWuTHVsrC8EEXuHt86LGpR4O3WmbHfj583FBhqJrLPvQ=
X-Received: by 2002:a02:9f84:: with SMTP id a4mr33791912jam.20.1563325757814;
 Tue, 16 Jul 2019 18:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <20190709211043.48597-1-emilyshaffer@google.com> <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
 <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com> <xmqq4l3l520f.fsf_-_@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l3l520f.fsf_-_@gitster-ct.c.googlers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 16 Jul 2019 18:09:06 -0700
Message-ID: <CAGyf7-EWuW5NX27YPeSb9+5iMU0pftUs-WxvUH1NqpGeNsXESg@mail.gmail.com>
Subject: Re: [RFC/PATCH] CodingGuidelines: spell out post-C89 rules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>, Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 16, 2019 at 10:21 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Even though we have been sticking to C89, there are a few handy
> features we borrow from more recent C language in our codebase after
> trying them in weather balloons and saw that nobody screamed.
>
> Spell them out.
>
> While at it, extend the existing variable declaration rule a bit to
> read better with the newly spelled out rule for the for loop.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> index 1169ff6c8e..53903b14c8 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -195,10 +195,24 @@ For C programs:
>     by e.g. "echo DEVELOPER=3D1 >>config.mak".
>
>   - We try to support a wide range of C compilers to compile Git with,
> -   including old ones. That means that you should not use C99
> -   initializers, even if a lot of compilers grok it.
> +   including old ones. That means that you should not use certain C99
> +   features, even if your compiler groks it.  There are a few
> +   exceptions:
>
> - - Variables have to be declared at the beginning of the block.
> +   . since early 2012 with e1327023ea, we have been using an enum
> +     definition whose last element is followed by a comma.

Is there a significance to the leading . here versus a leading - below?

> +
> +   . since mid 2017 with cbc0f81d and 512f41cf, we have been using
> +     designated initializers for struct and array.
> +
> +   These used to be forbidden, but we have not heard breakage report,
> +   so they are assumed to be safe.

With the placement here, is it possible that someone might read the
=E2=80=9CThese used to be forbidden=E2=80=9D as applying to the items that =
follow
after it, rather than the items that preceded it? Put a different way,
could there be some value in having some additional verbiage here that
indicates something along the lines of =E2=80=9CAside from those exceptions=
,
other C99 features are not allowed. Some common examples are:=E2=80=9D

Just a thought. (Pardon the suggestion from the peanut gallery!)

> +
> + - Variables have to be declared at the beginning of the block, before
> +   the first statement (i.e. -Wdeclaration-after-statement).
> +
> + - Declaring a variable in the for loop "for (int i =3D 0; i < 10; i++)"
> +   is still not allowed in this codebase.
>
>   - NULL pointers shall be written as NULL, not as 0.
>
>
