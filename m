Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B771F453
	for <e@80x24.org>; Thu, 25 Oct 2018 11:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJYUDM (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 16:03:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33630 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJYUDM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 16:03:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id f1-v6so682180edi.0
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 04:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eTbORSFn4VN1pvtUDIPbb0kNOnkvDCCyeIFN9kcT1RM=;
        b=RrjADZj7+FtX7+b7+Vksi4GPfmkrZgDrD7oGPP3LFQjM1gv2OX6x7cHevUTcUufaZG
         ARhWpwEEb2W2M3nW4Ju4QCsARW2a0xu6nA2UH1LtvFaeIwsB4hEcL5k2aNrILTzubVam
         k82QgE2vqegTi58oD0QmI1ToeG2HmPUr/flN2h1l+3pRBOJN+F8+Gt/1cV+29f+saRL9
         H0GYNG/DSFUOc6XdKDgv4E11W7p1lXbVT82fialMIQuMBMywMBqAVVjahXOnrqgiGpWY
         LqpW9eTMfK36ZdE5JPZXS0xxXV05b9dROTR4CvIJYRJWqaWgAGFVT550XYJ2Cz3P7tjp
         UanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eTbORSFn4VN1pvtUDIPbb0kNOnkvDCCyeIFN9kcT1RM=;
        b=YanAKlNTjGpNYgZEcvQum86gha2Fphv3hRTCgjdI6EPny4Q4la1NLFXZo3meuUBpf3
         diw/W7cRQN9teU0jdD7C52dFiVJXp1KNdYGvmzcihhDDzNXCtCRaec9u5wWuUx161ZzV
         1Cx/JD2+j+qIYDi6eBHsDC6RSMQrwm54voOKcTAxnhJ1y56WWnl7v/87rEm/UlTVOx7O
         +Kom82+QqZbL9EobLTZeqXd2wFpGP5W/ba2C7MxZvLcsjDQZjZSJPI9oOh3jQaWnuS11
         u9Scb3Et4Gs7/dgw/UoqxkOoNqbX6eB+JpEhKAOBSJfZkvmbkgwW6TIOIBnqLM2R6tbQ
         5zfQ==
X-Gm-Message-State: AGRZ1gLHpgCpyU+ITShE8sANcVm5ZqxH0eEw8Gmt5a0W6pBoLmvdmKby
        Tb6lB2wl2drKG1kmYqtoKF4=
X-Google-Smtp-Source: AJdET5fudl2upfStGrhV8HzgWEzdxnZUncMUj0lNdWAa+vYb1NAyTAYYEm1MCYNoJOl9ZQLy+a7D/A==
X-Received: by 2002:a50:ec9a:: with SMTP id e26-v6mr1265558edr.134.1540467048634;
        Thu, 25 Oct 2018 04:30:48 -0700 (PDT)
Received: from szeder.dev (x4db0730d.dyn.telefonica.de. [77.176.115.13])
        by smtp.gmail.com with ESMTPSA id b2-v6sm1262667edy.52.2018.10.25.04.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 04:30:47 -0700 (PDT)
Date:   Thu, 25 Oct 2018 13:30:45 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, peff@peff.net,
        chriscool@tuxfamily.org, l.s.r@web.de, ramsay@ramsayjones.plus.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] khash: silence -Wunused-function in delta-islands
 from khash
Message-ID: <20181025113045.GM30222@szeder.dev>
References: <20181025110427.13655-1-carenas@gmail.com>
 <20181025110427.13655-3-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181025110427.13655-3-carenas@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 04:04:26AM -0700, Carlo Marcelo Arenas Belón wrote:
> showing the following when compiled with latest clang (OpenBSD, Fedora
> and macOS):

s/^s/S/
This applies to your other commit messages as well.

But more importantly, please be explicit about the compiler version
that emits the warning, so others won't have to guess when stumbling
upon this commit in a few months or years time.

> delta-islands.c:23:1: warning: unused function 'kh_destroy_str'
>       [-Wunused-function]
> delta-islands.c:23:1: warning: unused function 'kh_clear_str'
>       [-Wunused-function]
> delta-islands.c:23:1: warning: unused function 'kh_del_str' [-Wunused-function]
> 
> Reported-by: René Scharfe <l.s.r@web.de>
> Suggested-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  khash.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/khash.h b/khash.h
> index d10caa0c35..532109c87f 100644
> --- a/khash.h
> +++ b/khash.h
> @@ -234,7 +234,7 @@ static const double __ac_HASH_UPPER = 0.77;
>  	__KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
>  
>  #define KHASH_INIT(name, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
> -	KHASH_INIT2(name, static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
> +	KHASH_INIT2(name, MAYBE_UNUSED static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
>  
>  /* Other convenient macros... */
>  
> -- 
> 2.19.1
> 
