Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FDB31F453
	for <e@80x24.org>; Wed, 30 Jan 2019 10:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfA3KXy (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 05:23:54 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:34293 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfA3KXy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 05:23:54 -0500
Received: by mail-lj1-f173.google.com with SMTP id u89-v6so20286388lje.1
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 02:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PLhHpVAcYQQwtjeCFid1g6O+cWXxTRaaoIHu31jAMlM=;
        b=pUDISgDushLJ8hCUhQ8WhtZWb5N9Kmqlt0g2Zi2fKP+R9LB/HpDhwHZrQRv8tsaFwQ
         3Og3+0YZ0iMrZv45ME0i3kgP3JaLao9cIr2QDlhYpYfoXlX3FgRrEw8tncylCOweFi7Y
         HoJEhSKoJGKlA1unLgXbtOGe/LnkB+XdshpsUSbHLCk8fvd9DhCpIyC/ZQF0+Vx86lh9
         wXMc09VaDR6Sa+C+/4gaGAiE9o1TQuD1QR8wwPBKZDXRq/W+OM7nf7Lnur924FaLYPEq
         cB5nabHdvRqGUu3WAq2CU1NriXT0P/tvnXjcKqlP8gNYP0FcHm/ZYA5S0WkukPBUctFV
         a7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PLhHpVAcYQQwtjeCFid1g6O+cWXxTRaaoIHu31jAMlM=;
        b=jsnVNOIg+WdmGAR4WnmMyIsOu2x/e8IU0vvwVPWx8enqkEJzKRu/NqfySxxLN7p+SI
         yviFIULWCMH8pki/Gv/ygokPue1xLVfUl/OK9FrRwNlF2bduA7rA9JjBnroDd0aDenjL
         8pGFRFRfOI5/DkIJBlynL3kPKpnnqVlnmxdXexXwMMJafMknZXQxMc4vuBUXKl+IqTLa
         J9Uj+P5t4rOBtT60vvSW9JaDFxTA3MMMttnJ2vrmF+bB2If2Xwl1HcPopunqnv0SJgsF
         aIRYipQi47rXUgoSqJ4BYyRkIuTkc4hRZp2BeErOD4bKH4QOAkZp862dz1dSeHTm1p1p
         RbRw==
X-Gm-Message-State: AJcUukcl6W+YsJV4wAbmzW0gEcNCMmC0pzb3v9m47FJ32P4gPnXjsP7I
        GCGFMxa35OZN0U9dMWW9gzzv1JNFQWxSlglIPKA=
X-Google-Smtp-Source: ALg8bN7ufLMvv+BWYyVkoU5i7oADD5b50s10gRA5jByhMW5GrBtF28gSGp+Vv8XtrY8G1h0xbVA7enKunR0GdfPBf7Q=
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr21493015ljk.80.1548843831687;
 Wed, 30 Jan 2019 02:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20190129051859.12830-1-koraktor@gmail.com> <20190129130031.GA22211@sigill.intra.peff.net>
 <xmqqmunj8ifc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmunj8ifc.fsf@gitster-ct.c.googlers.com>
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Wed, 30 Jan 2019 11:23:14 +0100
Message-ID: <CA+xP2Sb1--LQJs+GXqKVE3FjNHujSn6Q-Ow=-LEHtRLcFJJMGA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Add tests for describe with --work-tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Di., 29. Jan. 2019 um 18:47 Uhr schrieb Junio C Hamano <gitster@pobox.co=
m>:
>
> Jeff King <peff@peff.net> writes:
>
> > The usual style is to put the whole snippet into single-quotes, and the=
n
> > double-quote as appropriate within it. Like:
> >
> >   test_expect_failure 'describe --dirty with --work-tree' '
> >       (
> >               cd "$TEST_DIRECTORY" &&
> >               git --git-dir "$TRASH_DIRECTORY/.git" ...etc
> >
> > Those variables will be expanded when test_expect_failure eval's the
> > snippet.
>
> Good.

Ok, thanks. I=E2=80=99ll change this in the next reroll.

>
> >> +    grep 'A-\d\+-g[0-9a-f]\+' '$TRASH_DIRECTORY/out'
> >
> > Using "\d" isn't portable.
>
> True, but not just \d.  I think using \ before special characters to
> force an otherwise basic regular expression to be ERE (i.e. \+ at
> the end) is a GNUism.
>

I guess I=E2=80=99ll use the even broader but apparently more portable A-*[=
0-9a-f]
then. It=E2=80=99s used in the other checks, so this should be OK?

> > This regex is pretty broad. What are we checking here? If I understand
> > the previous discussion, we just care that it doesn't have "dirty" in
> > it, right? I don't think this regex does that, because it doesn't ancho=
r
> > the end of string.
> >
> > If that's indeed what we're checking, then an easier check is perhaps:
> >
> >   ! grep dirty ...
>
> Good.

This was copied and pasted from the existing check for describe with a
clean working tree. So this should be changed, too.
