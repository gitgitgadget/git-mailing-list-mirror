Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2182A20899
	for <e@80x24.org>; Thu, 17 Aug 2017 18:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbdHQSTl (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 14:19:41 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33651 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbdHQSTk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 14:19:40 -0400
Received: by mail-pg0-f52.google.com with SMTP id t3so19907535pgt.0
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bADVi4w5vZ9w+sx/bjOUZtuWYhOt0Z4dt+VlhiS0RCQ=;
        b=YWGTIY0JEknx6jrfL/jSohOQbi8zlWfoO4ZrwCNPaGvNF6DrkVBA67eSAHm3kQrhUl
         8ebdssc1mbHLaqcD3nRKJU4l6bMzsYQZnJKHaYthmuMhpqmiDkNOufi1haVjSwzbiCvt
         Z8Oeu11J9/CB6sPWyhEvFMQJ5cmSDVZy1VSS0My+VZGIKaDCnxmAN8azTu6YyiyGInZ6
         120UmSitXLsCqnhRa79V/XbV8CG7ymQcKXVwLCTgVfFbNNfiTZx7nDJnAHe1zcGb+j8I
         mndV+9Aw5ULloseEIwR8EhIGXzaR+Q+v1HnqbwMSEa+mVYDl/GWSzxLXSGBJuCVsoo3z
         xl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bADVi4w5vZ9w+sx/bjOUZtuWYhOt0Z4dt+VlhiS0RCQ=;
        b=ackeJqbmP9hQSyWF2GFBcN6sgpYEH2i4rRCbVUQ4h6osr1W3wy4f34yrKgoBCmRnlx
         G8nk6YIl7CbdHb6389JXIug65OvzFLH9D2RrCSUnX+CBjo2iBGGCuw2i9xMEFkfkAFus
         RVmbzSxgBvhfAHqdj+/ZwOFzt55Ygpvc+a+nL42pO8NP+EL8SLxpZBeBc86lGVUELZDU
         pKWHbSM0r30mdxDRnIJdE3IAg0U7iM83bEZyEfrK1Exsu5WR54egQ2+pGtxkKDC/YCiv
         pEgwiFCRrfWRL+TVAy+0J9G05j42uqcqdMXJ5BZxLyJMN+T0A41UBVIK6YbofPWw2bbd
         SdJA==
X-Gm-Message-State: AHYfb5gL4NP986TTbbbHjVcUe596LtbYxI0lURlBSxUYJisaNaTiE7qO
        MovfcQxZwShsy6Axf7+GXbLS/nO7DQ==
X-Received: by 10.98.74.199 with SMTP id c68mr6164768pfj.242.1502993979613;
 Thu, 17 Aug 2017 11:19:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Thu, 17 Aug 2017 11:19:39 -0700 (PDT)
In-Reply-To: <20170816082022.5use3im2bq27wik4@sigill.intra.peff.net>
References: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
 <20170815102334.qc4w7akl44bti44x@sigill.intra.peff.net> <CAN0heSrUz2jU2ijeSjYRhvyXA8qpw=JoOhaK-4Fuyv4_1L6Gtw@mail.gmail.com>
 <20170816082022.5use3im2bq27wik4@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 17 Aug 2017 20:19:39 +0200
Message-ID: <CAN0heSqTu9F6Coi7qydO6OKd_ojiriHMuvqjj3C9ag6M_48YOQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] interpret-trailers: add --parse convenience option
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16 August 2017 at 10:20, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 15, 2017 at 01:26:53PM +0200, Martin =C3=85gren wrote:
>
>> >  This command reads some patches or commit messages from either the
>> > -<file> arguments or the standard input if no <file> is specified. The=
n
>> > -this command applies the arguments passed using the `--trailer`
>> > -option, if any, to the commit message part of each input file. The
>> > -result is emitted on the standard output.
>> > +<file> arguments or the standard input if no <file> is specified. If
>> > +`--parse` is specified, the output consists of the parsed trailers.
>> > +
>> > +Otherwise, the this command applies the arguments passed using the
>> > +`--trailer` option, if any, to the commit message part of each input
>> > +file. The result is emitted on the standard output.
>>
>> "the this"
>
> Thanks.
>
>> I think I get why you use --parse above (and in the synopsis), although
>> it kind of feels like it should be --only-input or perhaps "--only-input
>> (or --parse)".
>
> I really wanted to point people to --parse as the go-to option for the
> parsing mode for the sake of simplicity (in fact I initially considered
> not even exposing them at all). And I hoped that if they jumped to the
> definition of --parse, that would lead them to the other options.
>
> I dunno. I agree it is does not read particularly well. Probably the
> whole description section could be rewritten to cover the newly dual
> nature of the command a bit better. But I didn't want to disrupt the
> existing flow too much.

Certainly. It's not like I can offer a "better" way. After thinking
about this some more, I think this is a good example of "less is more".
It's possibly less precise or complete in some sense, but it's probably
much more useful and readable.
