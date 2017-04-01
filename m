Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31A6B2096C
	for <e@80x24.org>; Sat,  1 Apr 2017 23:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbdDAXd2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 19:33:28 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35296 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbdDAXd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 19:33:27 -0400
Received: by mail-oi0-f53.google.com with SMTP id f193so94245054oib.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 16:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GhM8dnP2orqum4g6howJO3n4IWW+FBqBEKgZ7DIdGxM=;
        b=C/SCc1GtCOa12MBWhxNkF+VQTxnC9RgN1eEL0VxLDk44siV9LV/f6b8G2p7SCwiEep
         /ffShhCmKp6EFVy2jBBzKM3vMHwTppAqNpOvX+Ih2G5hNPjQGs3/iRdTisw69n51QIss
         3XtH04mgs4I+Svv65K2qSIn3LeUM2RLVnUrc2/61owIzwF0WWWKEuUqVE1BNp4UVDwEF
         hu2mjP2GNvbZVNIptBO4BqE2XznUp3TFpIJLg7ZJh7hQxe/vDgFla/6cBaTX4ullb8le
         Af8KeCf0+e5ofdD1NgJims39o/pZOVYqrHIGdeS1xvgxWW10zc7xYQLCRG/1lUQvCjxL
         zDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=GhM8dnP2orqum4g6howJO3n4IWW+FBqBEKgZ7DIdGxM=;
        b=ZePvnupd/8BlUKBjmIKOwouu+WJSZW0AJPEXH1p0ADRqZHEN4bAuTEw1DLwtbbJkv2
         jXJPX/NcMh55Sncrwv3pYLPtscEoguW2t0kru7IpQwi1iDJN8OFd3IamiC5CJqWd8qLX
         pfU3ct0mPz+pehsb4ON7fd+gHrgKDk9egF0uSn9g978A8RCUjoAaExE4IrQngnfWyj6S
         uU3N282AIL6FoHpdVLiT8gJl2fmQdEGENM5ZjMml9UdH5oUT+LXQKB1bbJfpSFtH1Y/Y
         IoCuOCE/Bwr/T+ZccRS9Vnln44FRkvten12fgo6G2HT9LQH7tXBe2f5p49uoAnRPDQeC
         nLSQ==
X-Gm-Message-State: AFeK/H0si/rAkxZi4RySxvq1PeKAD0gIkWFNeRPHrpW3u13SKCfyqjAqzNZxdly5+B7J6GrJWXAA+z0awKOtYQ==
X-Received: by 10.202.94.196 with SMTP id s187mr5606437oib.202.1491089606905;
 Sat, 01 Apr 2017 16:33:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.31.131 with HTTP; Sat, 1 Apr 2017 16:33:26 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <xmqqbmsgugt4.fsf@gitster.mtv.corp.google.com>
References: <CACBZZX6FcHcY7cYs6s_pv=E43cHNmzyUY5wrcuhPWWmUixCL+g@mail.gmail.com>
 <xmqqtw69vz9t.fsf@gitster.mtv.corp.google.com> <CACBZZX416M3YFDAACGAWCjJ4Xt0g78zpFF+iusMCarKb7SSfVw@mail.gmail.com>
 <xmqqbmsgugt4.fsf@gitster.mtv.corp.google.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 1 Apr 2017 19:33:26 -0400
Message-ID: <CAH8yC8mxdNFdpo0ZO0+XpnuHGTpp2NCiMCSE71j2Emt8-NRYDg@mail.gmail.com>
Subject: Re: Very promising results with libpcre2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Just to make sure that we are on the same page.  While I do not see
> the need to link with both variants and allow users to choose
> between them at runtime, I do not know if the whole world is ready
> to drop pcre1 and use pcre2 (the latter of which has only been
> around for a bit over two years).
>
> So we'd probably want to do
>
>  (1) keep USE_LIBPCRE and enable v1 when set;
>  (2) add USE_LIBPCRE2 and enable v2 when set;
>  (3) make sure to error out when both are set.
>
> or something like that.  It is tempting to allow us to say
>
>     make USE_LIBPCRE=2
>
> but the existing builds are likely to be depending on "is it set to
> anything? then use PCRE1" behaviour, so we unfortunately cannot take
> that route.

Yeah, that's the question I kinda had.

> make USE_LIBPCRE=2

I'd prefer a configure option for consistency. Maybe:

    --with-pcre  # Original PCRE
    --with-pcre1  # Alias
    --with-pcre2  # PCRE2

I prefer it because I usually do the following to see the interesting
things that's going on:

    ./configure --help

Often, I find a `--with-ssl` or similar. If `--with-ssl` fails, then I
go to the README and INSTALL to fine tune it.

By the way, if you are tweaking Configure, then consider adding a
--with-perl=X, too. Its consistent, it side steps the hard coded
/usr/bin/perl, and it signals to users its tunable.

Jeff
