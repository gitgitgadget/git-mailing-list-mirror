Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79781F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfHZS3L (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:29:11 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42117 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731490AbfHZS3L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:29:11 -0400
Received: by mail-vs1-f68.google.com with SMTP id b187so11631668vsc.9
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=re+Z62jpUudeo1PXZjWkib2Lqhs+R5E1ob040OryK+E=;
        b=C4qxw94mgqa+xWQmm5KgXGsZlaczdPnmVXfqwDELZa0wv6QAh2J7XNu+uJE7L2SYbx
         recIWTRM/DdDtCQNhuYnuz30rtdnAyt2hSFWt3nge+EA5j4Rcl1/6SqnFBloYBki8AZa
         Tavrou2JsyLzAGYPgKzycg7zIzzdtgT5bc1W4bZAc2ZhVTz1NqjNZeCmIHmv+81RsXZv
         G+cvpPX944PaJj0pZktZYJAi0hMO0p+xPYmP8u8hEZQichxKA4HCaYUWua38YmFBLLaA
         czs1lHy1n+WQfXqRxEwOBgPQQ1fMm7O8oR+zCFx/amspa3TbLaCMD3A8frUmXd6fKEb2
         4aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=re+Z62jpUudeo1PXZjWkib2Lqhs+R5E1ob040OryK+E=;
        b=LOcu01zlBlc5+vdsZcFHSXaYGAbPXDoJVPT0eGfZgk3CdRyx4HjiaLe3r3cqkHAnQQ
         cm8xVOAEZbsztqGiISlC1Qwu/nqB2Ez41qYkzNucaCc2WHcNsW5XDfsSwghNMBQxgfJf
         8+i5lTLY6tnn689d2B783S/kgX1K98+Vx18TPiYL3F4p4MuxuXEnEbHo2IEYCmNqtkTZ
         yPBpB/bNmCfOhVxldNMMByr6yR00byq4kRCyGeVO6u7q/0vhTj7N9fBbta4kzeZLgixc
         5mog8B0+XNPU4NgGC6zG8WmGoHEReZ9RFHE14duysZALW9LgyLYIlRI2rCaLVWffaEA/
         LcIw==
X-Gm-Message-State: APjAAAVoJIS37HgUdkodYyH/OPXpVnUQPNVgy3zPnEXcQq2fFH6Iu+3t
        Z3Cm6TPznowiWVPFRv/YPPaCnmGL4wXQ7oLm/qs=
X-Google-Smtp-Source: APXvYqyRr87KKUp6SwZz5jWJ90OemHd6/c6dNvjVGZN4BpC266iwga12HAYRMcfSKVz2e35B18P8ic1C+nVSUslolQk=
X-Received: by 2002:a67:f887:: with SMTP id h7mr8930749vso.116.1566844150655;
 Mon, 26 Aug 2019 11:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190825080640.GA31453@sigill.intra.peff.net> <20190825080821.GA31824@sigill.intra.peff.net>
In-Reply-To: <20190825080821.GA31824@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Aug 2019 11:28:58 -0700
Message-ID: <CABPp-BG3ScDk6_QcjyouqnHrXO2A1mWPEcPh5FnS1popKFzr-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] fast-import: duplicate parsed encoding string
To:     Jeff King <peff@peff.net>
Cc:     Mike Hommey <mh@glandium.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 1:08 AM Jeff King <peff@peff.net> wrote:
>
> We read each line of the fast-import stream into the command_buf strbuf.
> When reading a commit, we parse a line like "encoding foo" by storing a
> pointer to "foo", but not making a copy. We may then read an unbounded
> number of other lines (e.g., one for each modified file in the commit),
> each of which writes into command_buf.
>
> This works out in practice for small cases, because we hand off
> ownership of the heap buffer from command_buf to the cmd_hist array, and
> read new commands into a fresh heap buffer. And thus the pointer to
> "foo" remains valid as long as there aren't so many intermediate lines
> that we end up dropping the original "encoding" line from the history.
>
> But as the test modification shows, if we go over our default of 100
> lines, we end up with our encoding string pointing into freed heap
> memory. This seems to fail reliably by writing garbage into the output,
> but running under ASan definitely detects this as a user-after-free.

s/user-after-free/use-after-free/

> We can fix it by duplicating the encoding value, just as we do for other
> parsed lines (e.g., an author line ends up in parse_ident, which copies
> it to a new string).

Eek!  Thanks for fixing this up for me; patch looks good.
