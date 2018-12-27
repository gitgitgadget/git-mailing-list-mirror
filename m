Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74F5211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 17:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeL0Rzt (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 12:55:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37192 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeL0Rzt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 12:55:49 -0500
Received: by mail-oi1-f194.google.com with SMTP id y23so15639676oia.4
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 09:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsrdPiOzYXVLvSB1CdytFYvvjE6OwPRFbLYHZqSO+N0=;
        b=e3SFFAPm481kzt4so6DN/gNAfQ+cb66lb+e8iaoBBm9TIFvOhwEa62nP5mC+mm6Xka
         gyYeanKCKd2cR31gAiWXPbcbtrpz6a3WKI/F9+eUO2Z6zbv/ZEuy1gKjGRqkVI7r4YK0
         3w3hGxyIGhrHf1X4/QGrtg+xTHDwrJ5dWXRPkD3ebGUXtcTDGN/HPUb/n8SC5vXBoivc
         uimVdw8ZDmPNqcMY/0rjdS/DhQ7k4dBNzOYDCLCC8EzS/Bt9ZPLiMPIAW9XiJk+egHtO
         RO60aq/mVZTI3MOtdt2a7KSJvIa/Si/Mk7+Zp5nANIxi3m0WB4v8CCkemxCl1YDf/R53
         5CAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsrdPiOzYXVLvSB1CdytFYvvjE6OwPRFbLYHZqSO+N0=;
        b=jx465vMhZKJPudtv6V8LryROBk90t4zmpxAtYqyOeEz96wU9tC4adOnmA8CIdqsuPK
         MuMZq7qWyKJEle/fvVcbOPV4XDS2dypW/52Fo6ZHUXxcRA9NpruTLLU+kv9/4xXnKjeu
         tsZ4ov1yfmwadc+gMjN5kyKqa/Krdyly7T7F+N5Y6FSraUJF+E25QJ01j1DOWz+EJcwl
         QzBqX1txrd2JHpwi/90+malCn33yNIrMdpiED84Hj6IqwuNTJ+A8A90Bq4ueDGyVxfqy
         T3H95MfJjPA1Ww8xREZvJDY2t35ZmaCz+a3692B3BeBORlqyVI09BT6lYzvB8X5ywSvt
         LupQ==
X-Gm-Message-State: AA+aEWZYkxH8X8qS4QcxUyPbqSJ5FDffLAEm5Bi05NQFvDCs6ByZSpd3
        vrbvODeocoUc84mE8BD0tOv6eMOTEKVDtRG2tdHtxBfy
X-Google-Smtp-Source: AFSGD/XlL0l//yihJF4vIicr60/qe573tzQlw1RQ34F3Z8GZG/1nxoLTz9fL7xtMUPTilyyX+ovUD1hBrGI/X6IGeT4=
X-Received: by 2002:a54:4713:: with SMTP id k19mr14676891oik.241.1545933348604;
 Thu, 27 Dec 2018 09:55:48 -0800 (PST)
MIME-Version: 1.0
References: <20181227023548.396-1-rosenp@gmail.com> <xmqqwonvpjiy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwonvpjiy.fsf@gitster-ct.c.googlers.com>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Thu, 27 Dec 2018 09:55:37 -0800
Message-ID: <CAKxU2N9egn6MbJeWUWFsyYpnwOCj4=mckmkJJtVJGhmQUt36aw@mail.gmail.com>
Subject: Re: [PATCH] imap-send: Fix compilation without deprecated OpenSSL APIs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 26, 2018 at 10:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Rosen Penev <rosenp@gmail.com> writes:
>
> > Initialization in OpenSSL has been deprecated in version 1.1.
>
> https://www.openssl.org/docs/man1.0.2/ssl/SSL_library_init.html says
>
>         SSL_library_init() must be called before any other action takes
>         place.
>
> https://www.openssl.org/docs/man1.1.0/ssl/SSL_library_init.html says
> the same.
Later on in the document it mentions that it is deprecated.
>
> Which makes it necessary for us to defend the following claim
>
> > This makes
> > compilation fail when deprecated APIs for OpenSSL are compile-time
> > disabled.
>
> as a valid problem description more rigorously.  To me, the cursory
> web-serfing I did above makes me suspect that an OpenSSL
> implementation with such a compile-time disabling _is_ buggy, as it
> forbids the API users to call an API function they are told to call
> before doing anything else.
I agree the man page is misleading. The changelog for 1.1.0 is very
clear though:

Added support for auto-initialisation and de-initialisation of the library.
     OpenSSL no longer requires explicit init or deinit routines to be called,
     except in certain circumstances. See the OPENSSL_init_crypto() and
     OPENSSL_init_ssl() man pages for further information.
     [Matt Caswell]

https://www.openssl.org/news/changelog.html#x12

>
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  imap-send.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/imap-send.c b/imap-send.c
> > index b4eb886e2..21f741c8c 100644
> > --- a/imap-send.c
> > +++ b/imap-send.c
> > @@ -284,8 +284,10 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
> >       int ret;
> >       X509 *cert;
> >
> > +#if (OPENSSL_VERSION_NUMBER < 0x10000000L)
>
> https://www.openssl.org/docs/man1.1.0/crypto/OPENSSL_VERSION_NUMBER.html
>
> says that OPENSSL_VERSION_NUMBER is of form 0xMNNFFPPS where M is
> major, NN is minor, FF is fix, PP is patch and S is status, and
> gives an example that 0x00906023 stands for 0.9.6.b beta 3 (M=0,
> NN=09, FF=06, PP=02 and S=3).  So "< 0x10000000L" means "anything
> with M smaller than 1".  IOW, we would no longer call _init() for
> e.g. "version 1.0.0 beta 0".  That contradicts with the first claim
> of the proposed log message ("deprecated in 1.1" implying that it is
> not yet deprecated in say 1.0.2).
This is a mistake. I will send a v2 to fix.

Oh I see what I did wrong. I mistakenly copied the above
OPENSSL_VERSION_NUMBER check without looking carefully at the number.
>
>
>
> >       SSL_library_init();
> >       SSL_load_error_strings();
> > +#endif
> >
> >       meth = SSLv23_method();
> >       if (!meth) {
