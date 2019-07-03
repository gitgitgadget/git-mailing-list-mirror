Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE5231F461
	for <e@80x24.org>; Wed,  3 Jul 2019 08:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfGCI5c (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 04:57:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54386 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfGCI5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 04:57:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so1329501wme.4
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lb2Jbsm89ea107dFgMLWAsWU+eT0pg5B7kNmyXIxrpo=;
        b=IiagPnyLlv5DdZbM2e0G1gcqi7uNobms8w5/E7eCYDhjLf5fCyVcnhW2UN/W5RxNMR
         6yHYysSNRW3BzyjW/X/E4GGXjAZTpnXvFJnQUUL12dZ4buapw3zPsNxEKmvmWt5REuxe
         92ygQmDaWid/rFjnSrtSpDGIUmGEiN8UZ0NcShmNQmv454fHekoZ4oDE6Oa66Xkgp6GX
         KUjv4t4Smfx9oxOEwtTYX0QwnZZGhZbgmyM5l8SGIz6+sxdoO/MQNz0E2by9ITWwGTYq
         cQC2fxyRJGiD+99hbevQ82PWAZIiJ5neYNa4ARSw3i7VMG/VLj+oSYNggdJw04lB2jJb
         k5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lb2Jbsm89ea107dFgMLWAsWU+eT0pg5B7kNmyXIxrpo=;
        b=ZgGXRgNwibRHOOCMjBwtFcOFjNITTqV8uKrtZ5UV6Tr9erWvlmPTwcjmpDnKLTLtTQ
         ym2yv2QZvW3zk+w9+Kb1mCRFyEjXnJ6iRYhwblWO4PbRpCtPQ7kznBh9aNe0S4jdBjDR
         ntYUDz7BkGV3Vrdna69acKt35A2WDO2kFDbmwV+VVGxYYXyX+jE6kYzju6mLZZfTANiD
         hYjvJWTNccbdY6DimSrnGcx8oapxg6kBhMEVS1pPufCFwalemu2j/iUz5qJI602QfwCK
         GJUhnxe0nHYgaLjTEypEqQxdqxDx9IVaK2w/nAIaB7Z/b2McsjlwNNaZodF2oxQKAvSJ
         NZ1Q==
X-Gm-Message-State: APjAAAUrqQ1oyWPtz+zN1k6JR0pxMpqn5o0xMS9bXYl2ugcHcoicN72q
        F4clTYyY+vjwPIKug1re3FY=
X-Google-Smtp-Source: APXvYqwGX3HPTK4Zv0R8jhZ0x5RAH55mBvwaZMllXp2oMT4ynuw6Er6luFi21sNS/8PRZFp5KEuj7g==
X-Received: by 2002:a1c:eb16:: with SMTP id j22mr6856945wmh.140.1562144249861;
        Wed, 03 Jul 2019 01:57:29 -0700 (PDT)
Received: from szeder.dev (x4db51bef.dyn.telefonica.de. [77.181.27.239])
        by smtp.gmail.com with ESMTPSA id t14sm1133040wrr.33.2019.07.03.01.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 01:57:28 -0700 (PDT)
Date:   Wed, 3 Jul 2019 10:57:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to
 dir_iterator_begin
Message-ID: <20190703085726.GN21574@szeder.dev>
References: <cover.1560898723.git.matheus.bernardino@usp.br>
 <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
> index c739ed7911..8f996a31fa 100755
> --- a/t/t0066-dir-iterator.sh
> +++ b/t/t0066-dir-iterator.sh
> @@ -65,4 +65,99 @@ test_expect_success 'begin should fail upon non directory paths' '
>  	test_cmp expected-non-dir-output actual-non-dir-output
>  '
>  
> +test_expect_success POSIXPERM,SANITY 'advance should not fail on errors by default' '
> +	cat >expected-no-permissions-output <<-EOF &&
> +	[d] (a) [a] ./dir3/a
> +	EOF
> +
> +	mkdir -p dir3/a &&
> +	> dir3/a/b &&

Style nit: space between redirection op and pathname.

> +	chmod 0 dir3/a &&
> +
> +	test-tool dir-iterator ./dir3 >actual-no-permissions-output &&
> +	test_cmp expected-no-permissions-output actual-no-permissions-output &&
> +	chmod 755 dir3/a &&
> +	rm -rf dir3
> +'
> +
> +test_expect_success POSIXPERM,SANITY 'advance should fail on errors, w/ pedantic flag' '
> +	cat >expected-no-permissions-pedantic-output <<-EOF &&
> +	[d] (a) [a] ./dir3/a
> +	dir_iterator_advance failure
> +	EOF
> +
> +	mkdir -p dir3/a &&
> +	> dir3/a/b &&

Likewise.

> +	chmod 0 dir3/a &&
> +
> +	test_must_fail test-tool dir-iterator --pedantic ./dir3 \
> +		>actual-no-permissions-pedantic-output &&
> +	test_cmp expected-no-permissions-pedantic-output \
> +		actual-no-permissions-pedantic-output &&
> +	chmod 755 dir3/a &&
> +	rm -rf dir3
> +'
> +
> +test_expect_success SYMLINKS 'setup dirs with symlinks' '
> +	mkdir -p dir4/a &&
> +	mkdir -p dir4/b/c &&
> +	>dir4/a/d &&
> +	ln -s d dir4/a/e &&
> +	ln -s ../b dir4/a/f &&
> +
> +	mkdir -p dir5/a/b &&
> +	mkdir -p dir5/a/c &&
> +	ln -s ../c dir5/a/b/d &&
> +	ln -s ../ dir5/a/b/e &&
> +	ln -s ../../ dir5/a/b/f
> +'
> +
> +test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default' '
> +	cat >expected-no-follow-sorted-output <<-EOF &&
> +	[d] (a) [a] ./dir4/a
> +	[d] (b) [b] ./dir4/b
> +	[d] (b/c) [c] ./dir4/b/c
> +	[f] (a/d) [d] ./dir4/a/d
> +	[s] (a/e) [e] ./dir4/a/e
> +	[s] (a/f) [f] ./dir4/a/f
> +	EOF
> +
> +	test-tool dir-iterator ./dir4 >out &&
> +	sort <out >actual-no-follow-sorted-output &&

Unnecessary redirection, 'sort' is capable to open the file on its
own.

> +
> +	test_cmp expected-no-follow-sorted-output actual-no-follow-sorted-output
> +'
> +
> +test_expect_success SYMLINKS 'dir-iterator should follow symlinks w/ follow flag' '
> +	cat >expected-follow-sorted-output <<-EOF &&
> +	[d] (a) [a] ./dir4/a
> +	[d] (a/f) [f] ./dir4/a/f
> +	[d] (a/f/c) [c] ./dir4/a/f/c
> +	[d] (b) [b] ./dir4/b
> +	[d] (b/c) [c] ./dir4/b/c
> +	[f] (a/d) [d] ./dir4/a/d
> +	[f] (a/e) [e] ./dir4/a/e
> +	EOF
> +
> +	test-tool dir-iterator --follow-symlinks ./dir4 >out &&
> +	sort <out >actual-follow-sorted-output &&

Likewise.

> +	test_cmp expected-follow-sorted-output actual-follow-sorted-output
> +'
> +
> +
> +test_expect_success SYMLINKS 'dir-iterator should ignore recursive symlinks w/ follow flag' '
> +	cat >expected-rec-symlinks-sorted-output <<-EOF &&
> +	[d] (a) [a] ./dir5/a
> +	[d] (a/b) [b] ./dir5/a/b
> +	[d] (a/b/d) [d] ./dir5/a/b/d
> +	[d] (a/c) [c] ./dir5/a/c
> +	EOF
> +
> +	test-tool dir-iterator --follow-symlinks ./dir5 >out &&
> +	sort <out >actual-rec-symlinks-sorted-output &&

Likewise.

> +	test_cmp expected-rec-symlinks-sorted-output actual-rec-symlinks-sorted-output
> +'
> +
>  test_done
> -- 
> 2.22.0
> 
