Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF931F404
	for <e@80x24.org>; Tue, 14 Aug 2018 17:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbeHNTyW (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 15:54:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45343 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733145AbeHNTyW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 15:54:22 -0400
Received: by mail-pl0-f66.google.com with SMTP id j8-v6so8559500pll.12
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 10:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qhi4ebiu1ecF1Vwgp/mK/M6/OlLgsdqdwLAyPl7zkls=;
        b=mZ9G2QMnIT/iR941rgtztGmDSRAianSgsevw83NsyJkoWtQtMbvH2wgcNITW+yQCap
         RHMlltatI6Cq5+6Oc2vQwJpNBPX8G4gfH0RSJSML3MJURh0XFlwIlar1gifUD76TrrkB
         EFRI2Balc5PqbsKTPOrCDRE57bTU0Fhg0BkpPyeQkbZSzd6avoWIR0fX5mdtWs+T4UrE
         1OV0u4aJa7fMoO3reTgpr9qaISZIMIog8cVBu8c4mhD9J4XIZQ/DbLQpK/rLddu2rLxT
         Lf3P2UCoEyg9ytpiG/zlMvaXN/oomuaKTXHGMlmOo1tm96Mfej7d87DMPpQMEoVhXEHI
         G37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qhi4ebiu1ecF1Vwgp/mK/M6/OlLgsdqdwLAyPl7zkls=;
        b=PJ6FkGCFbg7GMAfspi7IFdXpl7gcQQu8C36w4/E4670AT2aZbPKnMkFLjYh2nKxUbr
         iEPsdtKAr7B5bwQIOoOVC29qCuzcsCo/okU7dbolpL/wyL8I1faDJ6eXm7UMEVg57e9T
         k8cHUDVlJ8z4CYa2r9QNsebaOc3el9K14avFK6zJPA1WP9cBIvjV8FtqmMAktpKyAAM9
         5nzdasfQ7iu+z9D0TYOZ2AUr0bSxT+SMyW4jOADdq4LKyFrnwLX8S2dKnpxf+EWcM7r7
         YbT+6tv7s6nCvqvteIbdd/DnObF4IatsASS1eWs36x7bSiSZsb58d/NsFY/EtDJyImIc
         CaOw==
X-Gm-Message-State: AOUpUlEwlOFBhL0m0iQ6vJUxJIATWzpkPs+QBIuCo79e61vd+Xu6OOG2
        6qakrz6Dz6EcoP1d2dZ/2ivGCA==
X-Google-Smtp-Source: AA+uWPyfOx5s2V9zOBHMwFG37fgwWBrfpTndbiEEeAbk5UJa2rr/bu2oh5thx2BfpU8e5XLd5FKb7Q==
X-Received: by 2002:a17:902:b58e:: with SMTP id a14-v6mr21436249pls.22.1534266381917;
        Tue, 14 Aug 2018 10:06:21 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id y86-v6sm32431735pfk.84.2018.08.14.10.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 10:06:20 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:06:19 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org,
        Daniel =?iso-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 3/7] t7411: be nicer to future tests and really clean
 things up
Message-ID: <20180814170619.GE240194@google.com>
References: <20180814110525.17801-1-ao2@ao2.it>
 <20180814110525.17801-4-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814110525.17801-4-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/14, Antonio Ospite wrote:
> Tests 5 and 8 in t/t7411-submodule-config.sh add two commits with
> invalid lines in .gitmodules but then only the second commit is removed.
> 
> This may affect future subsequent tests if they assume that the
> .gitmodules file has no errors.
> 
> Remove both the commits as soon as they are not needed anymore.
> 
> The error introduced in test 5 is also required by test 6, so the two
> commits from above are removed respectively in tests 6 and 8.

Thanks for cleaning this up.  We seem to have a habit for leaving
testing state around for longer than is necessary which makes it a bit
more difficult to read and understand when looking at it later.  What
would really be nice is if each test was self-contained...course that
would take a herculean effort to realize in our testsuite so I'm not
suggesting you do that :)

> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>  t/t7411-submodule-config.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
> index 0bde5850ac..c6b6cf6fae 100755
> --- a/t/t7411-submodule-config.sh
> +++ b/t/t7411-submodule-config.sh
> @@ -98,6 +98,9 @@ test_expect_success 'error in one submodule config lets continue' '
>  '
>  
>  test_expect_success 'error message contains blob reference' '
> +	# Remove the error introduced in the previous test.
> +	# It is not needed in the following tests.
> +	test_when_finished "git -C super reset --hard HEAD^" &&
>  	(cd super &&
>  		sha1=$(git rev-parse HEAD) &&
>  		test-tool submodule-config \
> @@ -123,6 +126,7 @@ test_expect_success 'using different treeishs works' '
>  '
>  
>  test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
> +	test_when_finished "git -C super reset --hard HEAD^" &&
>  	(cd super &&
>  		git config -f .gitmodules \
>  			submodule.submodule.fetchrecursesubmodules blabla &&
> @@ -134,8 +138,7 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
>  			HEAD b \
>  			HEAD submodule \
>  				>actual &&
> -		test_cmp expect_error actual  &&
> -		git reset --hard HEAD^
> +		test_cmp expect_error actual
>  	)
>  '
>  
> -- 
> 2.18.0
> 

-- 
Brandon Williams
