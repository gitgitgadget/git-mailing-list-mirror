Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA6320954
	for <e@80x24.org>; Wed, 22 Nov 2017 20:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbdKVUXD (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 15:23:03 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35019 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdKVUXD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 15:23:03 -0500
Received: by mail-it0-f68.google.com with SMTP id u132so7837323ita.0
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 12:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z0RyGINHNKJtCk6Ts3eF8NNBJbdazLJnJzgpbaoZfrA=;
        b=cpJFHtvgS+St2vMDFeDcD48eiXdGD9a2fQOTQpmkj9gGZhFjixMaop9rR+Ro/FrWu7
         +huKyR0yoGXQxKGaVVY8iUqPoNyr2fcyTU4V8F9IeooNLPNQi/3AxdyY3FDrVMu29n0T
         iNZmccJX+a969O0/P6XUnj3m8BBJGrYOhx4Li0Xt8pCZwoVgGOogbfLr+i9PJKRxnuBj
         U4UKCDGiMN6gz1EvjDrezaZMosXRSA2ihW/r1f7Ys7NfUsOa3wIxVq9PnVKDWfn6hhSE
         t01KRL+Jec6y4+7Ez3vqm0DRwUYA9+H2nOJ8/e2xTh6Qi6vKYqf5p7JJN8L5ocOIUQiC
         oNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z0RyGINHNKJtCk6Ts3eF8NNBJbdazLJnJzgpbaoZfrA=;
        b=KP1NW4cFHJE/gMqZaT84N9TBVIm4bTMLKEM/hqqL2ctdJR/J2a9n2sUhDkYdeurWyo
         uovGcIf5qoePnFh4X75wD7i+A0+jWCEwVGb3K9B2xz9iEbkLtN1Qb89VZBPBNFjVMDJV
         o3sUkKnMz63hwpVQHU8+6jR6cNZSdkqQVI3BPam9HAK3HAoIkEY1u5GnZrWnxaKS4JqY
         /fvcOlduZt3ygdEQFHIU6nTCvGVuOyH4iPwwV+9TAuDoQM510pMjV4WeK5jG5kYHdoRc
         PgRuVO6czuLfiM+FXbwIN3Zpk7+bd0Pm++OBbOvwx73sTRwqo4nuLGWfUdlYPqkce/Q6
         2HKQ==
X-Gm-Message-State: AJaThX7+urhWMv3niyvamR/T9lKqu4Z0rxcrRw/lRjCMxsoTHhxlIGtY
        3ZLSzvCN910HXBz7bo3VIkkqAuiW
X-Google-Smtp-Source: AGs4zMZMs5ptIGBbtL2Yq78DgQiHhenz5hiD+9X9ZhWkaJy48DqDu0oQltHK1GTHrVGCfVZ4oPedPg==
X-Received: by 10.36.175.17 with SMTP id t17mr8853368ite.66.1511382182258;
        Wed, 22 Nov 2017 12:23:02 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k2sm7194246iok.43.2017.11.22.12.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 12:23:01 -0800 (PST)
Date:   Wed, 22 Nov 2017 12:22:59 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] test-lib: add LIBPCRE1 & LIBPCRE2 prerequisites
Message-ID: <20171122202259.GC11671@aiede.mtv.corp.google.com>
References: <20171122133630.18931-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171122133630.18931-1-avarab@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Add LIBPCRE1 and LIBPCRE2 prerequisites which are true when git is
> compiled with USE_LIBPCRE1=YesPlease or USE_LIBPCRE2=YesPlease,
> respectively.
>
> The syntax of PCRE1 and PCRE2 isn't the same in all cases (see
> pcresyntax(3) and pcre2syntax(3)). If test are added that test for
> those they'll need to be guarded by these new prerequisites.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/README      | 12 ++++++++++++
>  t/test-lib.sh |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/t/README b/t/README
> index 4b079e4494..599cd9808c 100644
> --- a/t/README
> +++ b/t/README
> @@ -808,6 +808,18 @@ use these, and "test_set_prereq" for how to define your own.
>     Git was compiled with support for PCRE. Wrap any tests
>     that use git-grep --perl-regexp or git-grep -P in these.
>  
> + - LIBPCRE1
> +
> +   Git was compiled with PCRE v1 support via
> +   USE_LIBPCRE1=YesPlease. Wrap any PCRE using tests that for some
> +   reason need v1 of the PCRE library instead of v2 in these.

Are there plans to use the LIBPCRE1 prereq?  It might be simpler to
only have LIBPCRE2, and LIBPCRE1 can still be expressed as

	PCRE,!LIBPCRE2

which I think is clearer about the intent.

Thanks,
Jonathan
