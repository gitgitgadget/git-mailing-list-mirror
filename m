Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6601F731
	for <e@80x24.org>; Sat, 10 Aug 2019 03:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfHJDFc (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 23:05:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40672 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHJDFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 23:05:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id c34so147709otb.7
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 20:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NC1WvDwuUPF+0rQe0ACj4smwVv2ZqipsS2vWuGki/Zw=;
        b=ICq/5K5rfBQ2hzl//AH3Oq8zCeGpHuwXbETDnQOizCPe6Dj+j34dRX2eaztX2mo4I9
         MaylQ/Ex7Tt0nhvyp9d1Dm6p/LotfvdrSh/DevabQd37DjQ9SXyKuO1uW1T2Hn0JfjP3
         R2rGCYEpk2wj3habB9GnlzClOFFfqS4RlQiQztBxFafd7EDYcPgPCPZy90hztYqqIaOy
         HyyNlqIpgse2m4fjxGuYoM45SC+YweKkMGe7PsFFwt5VUHCjDMgUOwd/mlKihcJ2OLXw
         4Qo+U68DvGiC+53JPSZSSeuJHnE+Vqrpc/bcaDw9AIfX+PAMWcqalH/z9Jlu9LOy3ALm
         gSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NC1WvDwuUPF+0rQe0ACj4smwVv2ZqipsS2vWuGki/Zw=;
        b=DMdsHVckNdYueFWXeqP8CBTvJe5sEYKzBiHNd2Abfkng4ffnLpoN8H4nFVwSAk7faD
         YPNkbkyqvQ2Ndp4w4N+kZWF3O3cxjDzeQbA/l61yL7U5kP9Cj/7SZS56s1rDEGXiyKUU
         ysV/Dug5XhX1+78DkhX/5J2BWz4lQpsvIB4giDuTAeD7pncvK8ZQJShhdDxU4d9WGH2g
         L1okhZyF/Z4/zTpND2mGPmYFsVqjBaAlgMFJKPRiD+nLtMMqqLdegOCzRQ6X+n+qUucS
         v2zL0wfUONe42zRw3dWiHE8dW5n6mtYJUu1DAMULWXatBTVfmqkg2DfAXSm639EzR6O1
         LOJw==
X-Gm-Message-State: APjAAAUg0UgGfMc8xbgc9FeTqeRqvD1Jg3L473kCO8LY4YlZXR8zUE25
        JL8kw5R0u/U685UHsPed2HuNVr/9epIQnUTJYWQ=
X-Google-Smtp-Source: APXvYqyv+w3zGeFik+svocxaZEvupr5vuLNACJyp1JDud0e4FI+TaO/My8LbhloRjGaydnCHbi51SCMPPRGCgiCfXY4=
X-Received: by 2002:a05:6638:c8:: with SMTP id w8mr200234jao.52.1565406330788;
 Fri, 09 Aug 2019 20:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190807213945.10464-1-carenas@gmail.com> <20190809030210.18353-1-carenas@gmail.com>
 <CAPUEspiK7MTZPMktbU=_C_GPOH9vQiBmVUZp7GuR97RZS3onRQ@mail.gmail.com>
 <d239326e-11c3-5875-13a8-f4123baea6eb@web.de> <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 9 Aug 2019 20:05:16 -0700
Message-ID: <CAPUEspjVMbjdgBrW3qS3jwbd2ZfqMinfgGiasEZGwyZB-1c+QA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/3] grep: almost no more leaks, hopefully no crashes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com, michal.kiedrowicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 9, 2019 at 2:26 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> FWIW I am very much in favor of this approach.

FWIW this is (almost) exactly what I had in mind with my first reply,
except I wanted to make setting of the global context be conditioned
to having NED enabled to avoid possible performance issues in
environments were NED is not even usable.

in macOS (obviously testing without NED) the following is the output
of (a hacked version) of p7801 for maint (against chromium's
repository), with Ren=C3=A9's patch on top

Test                                       HEAD^               HEAD
---------------------------------------------------------------------------=
-----------
7820.1: perl grep 'how.to'                 0.51(0.35+1.11)
0.48(0.33+1.16) -5.9%
7820.2: perl grep '^how to'                0.47(0.33+1.08)
0.45(0.34+1.11) -4.3%
7820.3: perl grep '[how] to'               0.49(0.40+1.11)
0.53(0.41+1.13) +8.2%
7820.4: perl grep '(e.t[^ ]*|v.ry) rare'   68.72(68.77+1.14)
72.10(72.15+1.20) +4.9%
7820.5: perl grep 'm(=C3=BA|u)lt.b(=C3=A6|y)te'      0.48(0.35+1.12)
0.50(0.40+1.23) +4.2%

and this is with my squashed[2] changed on top of that :

Test                                       HEAD^               HEAD
---------------------------------------------------------------------------=
-----------
7820.1: perl grep 'how.to'                 0.48(0.36+1.16)
0.46(0.33+1.09) -4.2%
7820.2: perl grep '^how to'                0.45(0.34+1.12)
0.42(0.29+0.99) -6.7%
7820.3: perl grep '[how] to'               0.48(0.40+1.13)
0.52(0.43+1.16) +8.3%
7820.4: perl grep '(e.t[^ ]*|v.ry) rare'   69.12(69.10+1.07)
69.19(69.19+1.18) +0.1%
7820.5: perl grep 'm(=C3=BA|u)lt.b(=C3=A6|y)te'      0.49(0.38+1.17)
0.46(0.35+1.13) -6.1%

the degenerate case is not something we can't fix anyway, since it is
likely a locking issue inside PCRE2 (I see at most 1 CPU doing work),
and the numbers are noisy because of the other problems I mentioned
before (hardcoded to 8 threads, running in a laptop with low number of
cores), which is why testing for performance regressions in windows is
strongly encouraged, regardless

Carlo

[1] https://public-inbox.org/git/CAPUEspgH1v1zo7smzQWCV4rX9pKVKLV84gDSfCPdT=
7LffQxUWw@mail.gmail.com/
[2] https://public-inbox.org/git/20190810030315.7519-1-carenas@gmail.com/
