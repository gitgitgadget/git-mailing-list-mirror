Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341801F406
	for <e@80x24.org>; Sat, 16 Dec 2017 18:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757125AbdLPScJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 13:32:09 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46243 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756882AbdLPScI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 13:32:08 -0500
Received: by mail-qt0-f194.google.com with SMTP id r39so15742921qtr.13
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 10:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=bGJ5oU5Fs9bpV5HDnSXRmHONzx4JI6fXDgfVfFZ000I=;
        b=Y7eGJM5f4Y3lmeKipxTU2nFOU2ldfEjFvtU5qnLhLbK4tCnVUrn4+C3kOhygl/A0x9
         vYFW7Hwm4GYCLijCy6V04AzY2CLXlzn0gqnfCU0V6Hu/yvUwd57MyClhrP5MFtPca0n0
         v6R+IIhKZ+qGC/JKu49EkZuGlGbLXcyqsWXlPFBUPwU4yrn9WDDQkr2n8LJPtJKntERj
         j+1vXhZEXfmph0FWcMyNPHY+o/rXUyuUgXhFYahztWi+PYdTWZQ/vDZfYl8p5IsdZaT4
         D/4ltpyHsLv+RScS6zcGfl2Faeo5VtzyhqfTzUW8+nNMiWDeE7cq6b96KJA+s5By5cb4
         gq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=bGJ5oU5Fs9bpV5HDnSXRmHONzx4JI6fXDgfVfFZ000I=;
        b=QW0WXCRaB2UpkpB8cRbQ0MWRPz9mU29NHn7x4r+orI3VrrW8P1+xUVaGmEzgB9bFT0
         YZgeeBfFiz5u2YUXkc69x91lYn5YG0dVImIF0pT7n+P82qiZyll8OeRuXloyGKAK8td7
         Ls0PB/OmOAJOPMgopyHT47BRSwUIHngK2mmNt6uA9US/ONHnXeWLcFigMG+dfQKGNvut
         M/l46k0GCviKtxvf0la8ogO9VceHJOgKVvP/GmsAFYCRAelncX+2e1C8tPSoku+cjxjm
         1qj1HKTPzBi2l+8ukf+2TcqGUwVwgvUASGfc5yCyfXpiMGHMKiaOVMF7dc9MiLVgkMDp
         ScVw==
X-Gm-Message-State: AKGB3mLZZuPY3K2NzTk4NRxVcwEs0IY4HW4H1PBe17nt9f0sY8TP0omz
        V7wBFYexMzlu74GbTp+n97m5sujw4CcmSMkihHg=
X-Google-Smtp-Source: ACJfBosWwG9YghJeVn73Rwbnl1dQBsYJhrdAVJNo1/ZlB0Kz1bIbIB0KFiT5hS6pQmBZUw4dqBB1JJ0d+B/6yeJVOq8=
X-Received: by 10.237.59.22 with SMTP id p22mr28028656qte.34.1513449127985;
 Sat, 16 Dec 2017 10:32:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Sat, 16 Dec 2017 10:32:07 -0800 (PST)
In-Reply-To: <20171216125819.11263-1-szeder.dev@gmail.com>
References: <20171216125418.10743-2-szeder.dev@gmail.com> <20171216125819.11263-1-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Dec 2017 13:32:07 -0500
X-Google-Sender-Auth: h7Yk9I6qfbXlwjVy3cv3S7krJ90
Message-ID: <CAPig+cTL5hU6R=L3M2i0kfM6_zMLvcHWvNooAr8BU3VQ=X0_Ww@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] travis-ci: only print test failures if there are
 test results available
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 16, 2017 at 7:58 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> When a build job running the test suite fails, our
> 'ci/print-test-failures.sh' script scans all 't/test-results/*.exit'
> files to find failed tests and prints their verbose output.  However,
> if a build job were to fail before it ever gets to run the test suite,
> then there will be no files to match the above pattern and the shell
> will take the pattern literally, resulting in errors like this in the
> trace log:
>
>   cat: t/test-results/*.exit: No such file or directory
>   -----------------------------------------------------------------------=
-
>   t/test-results/*.out...
>   -----------------------------------------------------------------------=
-
>   cat: t/test-results/*.out: No such file or directory
>
> Check upfront and proceed only if there are any such files present.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
> @@ -8,6 +8,12 @@
> +if test t/test-results/*.exit =3D "t/test-results/*.exit"

Isn't the above going to cause 'test' to error out?

    $ mkdir -p t/test-results
    $ >t/test-results/a.exit
    $ >t/test-results/b.exit
    $ test t/test-results/*.exit =3D 't/test-results/*.exit'
    -bash: test: too many arguments

I'd think you'd want to capture the result of the expansion of
t/test-result/*.exit as a string and compare that instead.

> +then
> +       echo "Build job failed before the tests could have been run"
> +       exit
> +fi
