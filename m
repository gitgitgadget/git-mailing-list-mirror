Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06AC2208B4
	for <e@80x24.org>; Mon,  7 Aug 2017 16:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbdHGQhW (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 12:37:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33500 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdHGQhW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 12:37:22 -0400
Received: by mail-pf0-f194.google.com with SMTP id c65so869530pfl.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=reIn4QcitVly8SbXZbyf09/Mrn+x84QfISS5BYZN/60=;
        b=eFra0OyQ7IK3z9+Q2T6Jx6JxCHhMi1h/xbPFQDdff3Yyc2X7EzQdcUnlVdkFwhmvyl
         /PNL0HL7+CD2VXkNp9yGkEu/+Jy3A52QjC+N7v2kXzIR3z3whd13M2AEV/pK6TOWY3eP
         kI5G/nzyMnmkqbVEZt2TR2veSDCjknM4yHJPrrm6OPDF0pQ4XETVaCivmSxKN2mRxyOp
         zR79RSqfxltY7T4M9GyD4ceXRvFhCmNoIRADRlcY4XltvoWiUJed+Hx4UMYL34Hlg6Cu
         7KyW7c56pHZk5RyrcybDRQSnfsGVH0v/Z3+tQeencjE/4ek/3JRNZRz9MdHMXoXG2GMz
         mVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=reIn4QcitVly8SbXZbyf09/Mrn+x84QfISS5BYZN/60=;
        b=M+p7StpiVjjbWKPnDnXPJ5Wa9M9Z9wZ9RxvduQ5mQh/IdlWQXEM/ceHOK299FHTZDT
         RuM4EEZ1s5gLqLYtu+AZ4/O+RJW6h4mvicDbxDM6e2G94mPz/bDtKp9eL2jtiH7kbT4G
         xV2gPJuE2QQy/XySzXAlVl/XUr9PRBMDJmGD1BopxnrvZoaGI6qtZxmtoPtmch9KaJ4U
         trX7hAwVZUULdBAqKgup1q4aMC2xOhed+3x2+oSkZqqzuUqR6sJDDhRzEA4LHtK32W12
         W8er3slX0PA8u5u8u1latlexCEYKoXRN7NkHOrIOR0bsME3NLJY8mBFbO9I347TrXBSi
         EOHQ==
X-Gm-Message-State: AHYfb5jcHIvqEqmuBBPFfoQDQ2BNAjfuaDO0aExbt8O0Fxs8FIY0rY11
        d96xlfJeRF23V9DEak+ZmjWSzMWuOg==
X-Received: by 10.99.97.194 with SMTP id v185mr1067517pgb.165.1502123841668;
 Mon, 07 Aug 2017 09:37:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Mon, 7 Aug 2017 09:37:21 -0700 (PDT)
In-Reply-To: <71479602-fabc-1861-124b-90b26b952344@morey-chaisemartin.com>
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
 <71479602-fabc-1861-124b-90b26b952344@morey-chaisemartin.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 7 Aug 2017 18:37:21 +0200
Message-ID: <CAN0heSoRXX_9-yzFf=2Obj_5WosLwK4UtrFrLsw8asdUea1+Yg@mail.gmail.com>
Subject: Re: [PATCH 4/4] imap-send: use curl by default
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 August 2017 at 16:04, Nicolas Morey-Chaisemartin
<nicolas@morey-chaisemartin.com> wrote:
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> ---
>  imap-send.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 90b8683ed..4ebc16437 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -35,13 +35,7 @@ typedef void *SSL;
>  #include "http.h"
>  #endif
>
> -#if defined(USE_CURL_FOR_IMAP_SEND) && defined(NO_OPENSSL)
> -/* only available option */
>  #define USE_CURL_DEFAULT 1
> -#else
> -/* strictly opt in */
> -#define USE_CURL_DEFAULT 0
> -#endif
>
>  static int verbosity;
>  static int use_curl = USE_CURL_DEFAULT;

So this is now basically "static int use_curl = 1;".

Do we need a compile-time escape-hatch in case someone really needs
to avoid curl, e.g., because they have a too old version? I suppose
there is a conceptual difference between the "default", i.e., the value
of USE_CURL_DEFAULT that is assigned to "use_curl", and the "default
default", i.e., the value that is normally assigned to USE_CURL_DEFAULT.

Martin
