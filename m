Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B757C2036D
	for <e@80x24.org>; Sun, 19 Nov 2017 01:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdKSBZY (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 20:25:24 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43891 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765140AbdKSBSS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 20:18:18 -0500
Received: by mail-qk0-f194.google.com with SMTP id j202so3698255qke.10
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 17:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=H86ETMPpfWhwcmrkjHyWwi0BiO3s3paisJSXHDMjCD0=;
        b=o4QRKmmePhd0sXENX8zsI2f/QTMGmDNeoKF+A2VEXWtz06qjVg56ih6CF8A2d/pqMm
         WG3tsd66mJeOENt5FLPWymY+R/ODjIjKgE8ZPWhoGhoA6c5H19B/0q1ka7eH6yxlVznx
         0FBJSehWgwyU4V0axakf7yIMxCAzKrJxcPmozD8BG4OoQ5aSSyLP69SIVBWF41P/+LkD
         Is1n+DGVHnC+4z9x3yJ94K5ChYjTOzDHIFy+7v9hrfQzRZKNYtc2UYomJ7eut9HwgA3b
         H5S0rkYdIpMaCP6CnprRdVh1RrknXI2utdqIuNbP9+xuX/7SxUfXDBYPqQijnHBlm6sW
         0xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=H86ETMPpfWhwcmrkjHyWwi0BiO3s3paisJSXHDMjCD0=;
        b=r4JbunPxIx4mIthhkih/hTGYWOyt+9uH6/dqHYj2moHG2DOimQCksQrhAfMIs2KkeK
         4F6E3PYI5pVDHuPfCTftiE4BYcoTmx2e7sU0EJpPABSA1UkKvxLHYYFugNnsxG2A7z5J
         pJR6IOp0j6W9imG3T2br3uQpNcWgea7bPq6DKzYTNZBj1e9sf+QEMgDBEExlHEvb4hPl
         3KRLPEvq56AVlxzrmXTY4A/K2+53UuhD8Cds7/k8bd7grlIHaOrTtTKcgGYoCM3MSHyW
         s7Y7k7hIReDuV7RpHAS31KNybEL+ORul3GVw3MmT1GNfblYcDb2jVlSClyelCi6eM5fb
         8Qaw==
X-Gm-Message-State: AJaThX5Z3mjFIw267w9qcSsXMrb3o8UoQq0j83gbF/EASTGROps3AUAH
        iA1xzpmwtwXGwrNfU8UeJvlv85hZwx0c3T4FJY0=
X-Google-Smtp-Source: AGs4zMYCshibv0auCf2QaIIWLcVDQizPi9HlVFc/74l2y9+QXQ+1qZtZbXg2HuxReFV3kEedBK6RPhKw6Jo0K3jpZmc=
X-Received: by 10.55.42.75 with SMTP id q72mr15313419qkh.57.1511054298130;
 Sat, 18 Nov 2017 17:18:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sat, 18 Nov 2017 17:18:17 -0800 (PST)
In-Reply-To: <b5815f62-3ed4-58ea-6d32-b156e44cbe3f@web.de>
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de> <b5815f62-3ed4-58ea-6d32-b156e44cbe3f@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 18 Nov 2017 20:18:17 -0500
X-Google-Sender-Auth: IgCHSVCxgYgmN69TA-MwIO0izZA
Message-ID: <CAPig+cQTzBYLqHw5TRYFajTK2Uq2fE=q=h=b=VA43zdJs0_CMA@mail.gmail.com>
Subject: Re: [PATCH 1/6] t4051: add test for comments preceding function lines
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 18, 2017 at 1:04 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> When showing function context it would be helpful to show comments
> immediately before declarations, as they are most likely relevant.  Add
> a test for that.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-con=
text.sh
> @@ -85,6 +85,10 @@ test_expect_success 'setup' '
>> +test_expect_failure ' context includes comment' '
> +       grep "^ .*Hello comment" changed_hello.diff
> +'

This shows only that the the "* Hello comment." line is in the context
but says nothing about the entire comment block being included (which
patch 3/6 implements). Perhaps the test could be more thorough?

> diff --git a/t/t4051/hello.c b/t/t4051/hello.c
> index 63b1a1e4ef..73e767e178 100644
> --- a/t/t4051/hello.c
> +++ b/t/t4051/hello.c
> @@ -1,4 +1,7 @@
>
> +/*
> + * Hello comment.
> + */
>  static void hello(void)        // Begin of hello
>  {
