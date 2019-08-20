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
	by dcvr.yhbt.net (Postfix) with ESMTP id 906D81F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfHTHbe (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:31:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33919 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfHTHbe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:31:34 -0400
Received: by mail-io1-f65.google.com with SMTP id s21so10166576ioa.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G3VxtoLa4ZJkt+IaGjtdzJi9RG7foE/LrqugcL9MnWY=;
        b=BD+dN8yXjTbe3cemiKqhB/2v7fevhNdQsu1iQxWtGHArb/GRLuC5Y0o7Tffu1uHxnV
         K/NR9OZybV2v2Ye784/DJLPR6/LEnMUxZNfzSJgQ8efxIFTqasfMhioDwOpewIQQ56jX
         FGogpzA8/EW+3eOkUDrnxCezfKaJDFR1AkUQUZPgiA8t9zDifkn6EaTFi6BODYfOalp+
         /Q5lyT9pXpjRitvdi/4Q2defDnoHUmX88BQ88fUL8gk3bV/gm3g6UkNdUUUCuEYVxISz
         xczSBBwVXm3uyNFtgSREAqYSe3k7hikW64rTm0Yp06dTELu9kw8S+8raTI4SqrT5A1sc
         rNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G3VxtoLa4ZJkt+IaGjtdzJi9RG7foE/LrqugcL9MnWY=;
        b=p7G3XOKO2v/H3eMh1JKj8WpxYwRQDbbws7ILaoaLdBI7/VtvRt9KIghQE/5fDPhQXR
         AubfRjtSyJqLhMHPmTVC0oH126bRsO2ch3brFzOJqukI8E41krkrdgNLFmvp2HE4rw7B
         xYkEp0bEZR8AhwLYm9tfRZSGtMpj/UstGPgyaq8tguchokN7cJvBpGIyKMwBP/gueaHd
         7eW3X7vV4C03fWsjj2oiIOjdmIngNhNPdpWSRhaJ35zundjDSha7ArgEfHD9e7SYygbq
         iKQMRolZJYKT/Csaf5pST+BYFvS/XtCUtLeBmdzihYozKM8JtLPPYQgCzXX4tQSpzcoI
         vngA==
X-Gm-Message-State: APjAAAWkvVkHonkvzozHMtsHwRQv5XzqzCMqjwLszU96Lei3j0j1bh9O
        ox04IdH3tzZp+szkbKjF1M51m/Fj
X-Google-Smtp-Source: APXvYqyIZVrOVbun+goZ81BM/2p8iKKIzOdbNejYed/xnoPQF1ymX4xjZyo/r1vyOSY1CS+f6m+vxQ==
X-Received: by 2002:a6b:db15:: with SMTP id t21mr31432339ioc.258.1566286292922;
        Tue, 20 Aug 2019 00:31:32 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id b20sm12430068ios.44.2019.08.20.00.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:31:31 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:31:30 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 10/13] t4014: stop losing return codes of git commands
Message-ID: <20190820073130.GA32049@archbookpro.localdomain>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
 <64069c0c540b109b46b2cc6c90e3b5c912aa18c5.1566285151.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64069c0c540b109b46b2cc6c90e3b5c912aa18c5.1566285151.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 03:19:08AM -0400, Denton Liu wrote:
> @@ -808,20 +821,24 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
>  	git format-patch --ignore-if-in-upstream HEAD
>  '
>  
> -git_version="$(git --version | sed "s/.* //")"
> +test_expect_success 'get git version' '
> +	git_version="$(git --version | sed "s/.* //")"
> +'

Oops, this should read

	git_version="$(git --version >version && sed "s/.* //" <version)"

Anyway, I was considering keeping the upstream pipe but it feels very
weird having an unchecked Git command (especially since, from what I can
tell, `git --version` isn't tested anywhere else). Thoughts?

>  
>  signature() {
>  	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
>  }
>  
>  test_expect_success 'format-patch default signature' '
> -	git format-patch --stdout -1 | tail -n 3 >output &&
> +	git format-patch --stdout -1 >patch &&
> +	tail -n 3 patch >output &&
>  	signature >expect &&
>  	test_cmp expect output
>  '
>  
>  test_expect_success 'format-patch --signature' '
> -	git format-patch --stdout --signature="my sig" -1 | tail -n 3 >output &&
> +	git format-patch --stdout --signature="my sig" -1 >patch &&
> +	tail -n 3 patch >output &&
>  	signature "my sig" >expect &&
>  	test_cmp expect output
>  '
