Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D03F1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeHVTgm (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:36:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45883 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVTgl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:36:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so2057339wrb.12
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ywz9bVoE1DzxV9MhnsdwwWFnI4wZgqy/yb9tIIgg0Kc=;
        b=PuFeskhrXR8RyYSMAeJzri85LCXWrXluFfq8HNgJnanw8kDC7whoNsk7aAwaXq2ua7
         2/XbiQpkAQISJ1+e4rQVjHIw13TW7oxDjgFOMoEyCMdYuTVSf683UAQoX7VRDnVtpu90
         St0n22b4z+XquHZbcg1TsUrDX2xtkei6hkrzxyYJquetVKMg1ZewYV5sE/RS/T94FJPA
         vaEHaAgbSiwGNmFk4KjvZ9pFiMifnGJo4M+bg6osLpS0XaQtPr6Y9jyUxvRO/4HfJJhv
         qcMByRxhFydjP3TM7Q8ssBfxtNHECg9m1Nl9pR58BFLidjra2Z7qfeHqbyrv6hgMTKnV
         +oSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ywz9bVoE1DzxV9MhnsdwwWFnI4wZgqy/yb9tIIgg0Kc=;
        b=Pz/88Px4jurfo9ZsPvTbXMT12A6r3D4D1/qdfYHaBCU8y0sO5k2WJ1H439c/v5hulL
         6GtkdWu/y8DVAv72l9i8ckubpUcueGljlO3dH9QT6V1gkl+++zs/08YC9iwzinB9y8lR
         Ds3bRV2IAMpiCFhWy0Gty1DGzI8froJkgZCYu+Ox8lpmaYCkkkB4EBq1uvCt6WVfmkBc
         iJDIQMvtbaM1ALBRItknP/ALgFID1H/s30LyEq1SbbPeRc4tgklJngf0rZI/YHWN3ACW
         lEkwx55t1Y0d6YVLQ5u7gU6z2RS/3ZStbxkDIqEYJl69daV8wFXcIOJ0QtXZBIGRRqPT
         +TVA==
X-Gm-Message-State: APzg51DANKQ8TJ0ZsCoC8rHgkImRDimgOIJhUhAPaLOQucZOmysMsa+H
        5TaMGAiTbKssShsTTW3GGBs=
X-Google-Smtp-Source: ANB0VdZvpQiXht0C2VM/zo/dkNpZJxdgKSMNOLgEiVYsGEXpTyGY769z6rKtJxB3zpK7sY9yFXzzWw==
X-Received: by 2002:adf:f984:: with SMTP id f4-v6mr9442388wrr.105.1534954269928;
        Wed, 22 Aug 2018 09:11:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d33-v6sm2787694wma.16.2018.08.22.09.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 09:11:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] t0020-crlf: check the right file
References: <20180822124437.11242-1-szeder.dev@gmail.com>
Date:   Wed, 22 Aug 2018 09:11:08 -0700
In-Reply-To: <20180822124437.11242-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 22 Aug 2018 14:44:36 +0200")
Message-ID: <xmqqo9du5qlf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> In the test 'checkout with autocrlf=input' in 't0020-crlf.sh', one of
> the 'has_cr' checks looks at the non-existing file 'two' instead of
> 'dir/two'.  The test still succeeds, without actually checking what it
> was supposed to, because this check is expected to fail anyway.
>
> As a minimal fix, fix the name of the file to be checked.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---

This originates from fd777141 ("t0020: fix ignored exit code inside
loops", 2015-03-25) where a loop

    for f in one dir/two
    do
            do things on "$f" || break
    done

was unrolled to correctly break out of the &&-chain.  The filenames
on the update-index line correctly copied one and dir/two, but the
has_cr line somehow lost dir/ prefix.

Thanks.  Will queue.

>  t/t0020-crlf.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> index 5f056982a5..854da0ae16 100755
> --- a/t/t0020-crlf.sh
> +++ b/t/t0020-crlf.sh
> @@ -160,7 +160,7 @@ test_expect_success 'checkout with autocrlf=input' '
>  	git config core.autocrlf input &&
>  	git read-tree --reset -u HEAD &&
>  	test_must_fail has_cr one &&
> -	test_must_fail has_cr two &&
> +	test_must_fail has_cr dir/two &&
>  	git update-index -- one dir/two &&
>  	test "$one" = $(git hash-object --stdin <one) &&
>  	test "$two" = $(git hash-object --stdin <dir/two) &&
