Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9059D1FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 08:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbdJZI2x (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 04:28:53 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:49243 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbdJZI2t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 04:28:49 -0400
Received: by mail-qt0-f193.google.com with SMTP id k31so3275682qta.6
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 01:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rdBTgAe1sZGkGr9zlDcjGHkBRFTcV5c6mlEfbkZuUp0=;
        b=TGC3zoLrhH31/HwB6kBhmOT5nU4dED/TJHhPaY5Y3G9x6shJYijLRBqlMR8+14aRbS
         InxIc5BstX8TxdPBwpulpe4cKlPss6uTjRyexJFcTvpHgHQoRD6otMd/EpuwBuM8muSl
         fKeiwbJeeVfW1lGLbD0F32ZIHibRzDuS3ccqjH4ZuCTm30I/WjxXAMiO51G61i2JyP5Y
         ssYu02U4NtLdcbwGnEWovPWacmF1QDXtIGsisWl7ilQhOMpnW+OLutyzXgdke5bwyJFT
         +nxI+ErsV6dT4gUMkehQvNlDRNBqWetTxgk0dX6YgtTERkPoMPNwpYI8e3AkckQQmz7h
         h92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rdBTgAe1sZGkGr9zlDcjGHkBRFTcV5c6mlEfbkZuUp0=;
        b=sAhT93THtoSnqPoNahGAw8L+DrRE3iYvyzMGVHHKaY6+4DAUgTtRRQUFHXeJJ/N6gC
         D375t9iZGyOp+uQ0WCL0dhZ3mkn/JEBgcLuUqHFwJQ33tGb8HM19/IxnY3g96rdWKZqK
         aEndaIFr+tZmovLpRUwpaB+60aN0GeJLDOqCnHNYnEB7pj7aPV4SWsBqzSFHUKmXrS6S
         YmtGihogSNH72mmpgrSbiLXrblwapLkK3up35AUgj1OW7SiQ3BLMNuix2vvnHFjfMmCZ
         WqBURadQVPn9CHyPoupZA2LmtTzX7Usd6Oyj1jmkotaBPsi2N6tYVUYeAsXfznnh2Zj5
         23hQ==
X-Gm-Message-State: AMCzsaXzqSolElaEfeIMdNlTjRHZcuyqbiyxqpJrTB7qcjNZjxPmsuDo
        adPzONPFW8CzEdDeHmpUdfrN0jntbSXsxW/feEI=
X-Google-Smtp-Source: ABhQp+SgHicwQAU1uhGOnUrutP6aoacUKWRATptvJE8YxE7sGgZkMYtNhcPKzmvTVa5iMxBrxR5ZaXl58dJcDyy4EaM=
X-Received: by 10.200.35.248 with SMTP id r53mr32965368qtr.110.1509006529113;
 Thu, 26 Oct 2017 01:28:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Thu, 26 Oct 2017 01:28:48 -0700 (PDT)
In-Reply-To: <6ecab31e7ed05f5e79ecd454b133a2bfa6ac9ab7.1509005669.git.mhagger@alum.mit.edu>
References: <6ecab31e7ed05f5e79ecd454b133a2bfa6ac9ab7.1509005669.git.mhagger@alum.mit.edu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 26 Oct 2017 04:28:48 -0400
X-Google-Sender-Auth: KLSGCwV8vjsGiz1qlxLf3__-pkU
Message-ID: <CAPig+cTv4YW0m0PLH+UucEHjgQkbCsOunPrkKVDrPQXNkd=GAg@mail.gmail.com>
Subject: Re: [PATCH] t0000: check whether the shell supports the "local" keyword
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 4:18 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Add a test balloon to see if we get complaints from anybody who is
> using a shell that doesn't support the "local" keyword. If so, this
> test can be reverted. If not, we might want to consider using "local"
> in shell code throughout the git code base.

I would guess that the number of people who actually run the Git test
suite is microscopic compared to the number of people who use Git
itself. It is not clear, therefore, that lack of reports of failure of
the new test would imply that "local" can safely be used throughout
the Git code base. At best, it might indicate that "local" can be used
in the tests.

Or, am I missing something?

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> This has been discussed on the mailing list [1,2].
>
> Michael
>
> [1] https://public-inbox.org/git/CAPig+cRLB=dGD=+Af=yYL3M709LRpeUrtvcDLo9iBKYy2HAW-w@mail.gmail.com/
> [2] https://public-inbox.org/git/20160601163747.GA10721@sigill.intra.peff.net/
>
>  t/t0000-basic.sh | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 1aa5093f36..7fd87dd544 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -20,6 +20,31 @@ modification *should* take notice and update the test vectors here.
>
>  . ./test-lib.sh
>
> +try_local_x () {
> +       local x="local" &&
> +       echo "$x"
> +}
> +
> +# This test is an experiment to check whether any Git users are using
> +# Shells that don't support the "local" keyword. "local" is not
> +# POSIX-standard, but it is very widely supported by POSIX-compliant
> +# shells, and if it doesn't cause problems for people, we would like
> +# to be able to use it in Git code.
> +#
> +# For now, this is the only test that requires "local". If your shell
> +# fails this test, you can ignore the failure, but please report the
> +# problem to the Git mailing list <git@vger.kernel.org>, as it might
> +# convince us to continue avoiding the use of "local".
> +test_expect_success 'verify that the running shell supports "local"' '
> +       x="notlocal" &&
> +       echo "local" >expected1 &&
> +       try_local_x >actual1 &&
> +       test_cmp expected1 actual1 &&
> +       echo "notlocal" >expected2 &&
> +       echo "$x" >actual2 &&
> +       test_cmp expected2 actual2
> +'
> +
>  ################################################################
>  # git init has been done in an empty repository.
>  # make sure it is empty.
> --
> 2.14.1
