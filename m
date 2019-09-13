Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA681F463
	for <e@80x24.org>; Fri, 13 Sep 2019 12:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbfIMMF0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 08:05:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36266 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMMFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 08:05:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id t3so2519088wmj.1
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 05:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7wB44pVclDZOdqxVMvkhsgZ0poUMx0XgIWzlX8a80BI=;
        b=Ye5PCxIr8lLgNIfd9IIqcfOEvwEYtVjotK1DnuE0Vky4ZuvEYG0Fg/6oWUorm2hU+O
         Ee0E2V8MYPtNDXvq+/CzyFTlWEv5DW/HwSqVXoan8MARmMhYVmjuF3194AVh5n4r9bZU
         h4t0nlOj1tFwgYvHrZ+/j/zJ2SpeVqrpQEQUyD1NCeFUBoIlS2sLqqBusDTChuTVpO5W
         B180987Z/b7sif+QsNayfqxfWD7Qrq6IkfNfYdMG0jy9vWgPz3L4eZIn/4szWnN02sYb
         2bI1DR31a2x3RJNjAJswPy4oCwqTxNu78LWGXd+m4Pd3oKUPCnjr/E3pPW4qqyHrCytP
         jqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7wB44pVclDZOdqxVMvkhsgZ0poUMx0XgIWzlX8a80BI=;
        b=AKnYDa8PLejQkwc/JO1BVlIYWzAalTELwN7nmp7Y2dFTMq+kyKRE8mRdkByAgsicjX
         3zbClZCPOW44W271Cr4+l+NJA/eCW9eNtHQX06QOK6W9zgUa3s6Z2budKWXO/5FlDSp5
         A0wE4sIcI0kCip6hhmNySiCHXojT8nbZca4MlG0LWyrva6sqq6CaAYUXAojxReMIH06W
         Cq7IaLsn7iWs6lBTsftXlbToinP7jU333uYgg7SgZt6zgf6jyDJfeDiDJmAFjAAijhbp
         Lv5Rnx7YpkzKDqvRwTamsl0eWTeG0Vqu72szO7+hAgPvLODDZj4KrcGQXV2mgCsVXdpW
         k/sQ==
X-Gm-Message-State: APjAAAU1w2WKrEinAcJ/nghM5eqC+IR/wiP/oixmZYkmnaaQqvVsUgbZ
        pbYCylggMz0KPqhVspox4gE=
X-Google-Smtp-Source: APXvYqyYNOHZi3ye3JFlmUTkPSai2q3XaByOu0kb1FMxUTZqK06PhTzzjkGYNLmjiwoRB/7RgB1nuw==
X-Received: by 2002:a05:600c:2152:: with SMTP id v18mr3210284wml.177.1568376323961;
        Fri, 13 Sep 2019 05:05:23 -0700 (PDT)
Received: from szeder.dev (x4dbd0815.dyn.telefonica.de. [77.189.8.21])
        by smtp.gmail.com with ESMTPSA id w4sm939847wrv.66.2019.09.13.05.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 05:05:23 -0700 (PDT)
Date:   Fri, 13 Sep 2019 14:05:21 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 2/3] Makefile: strip leading ./ in $(FIND_SOURCE_FILES)
Message-ID: <20190913120521.GP32087@szeder.dev>
References: <cover.1568101393.git.liu.denton@gmail.com>
 <cover.1568309119.git.liu.denton@gmail.com>
 <239ffa690cc0bf65e2ee7fbdbb9c481499e37020.1568309119.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <239ffa690cc0bf65e2ee7fbdbb9c481499e37020.1568309119.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 12, 2019 at 10:28:32AM -0700, Denton Liu wrote:
> Currently, $(FIND_SOURCE_FILES) has two modes: if `git ls-files` is
> present, it will use that to enumerate the files in the repository; else
> it will use `$(FIND) .` to enumerate the files in the directory.
> 
> There is a subtle difference between these two methods, however. With
> ls-files, filenames don't have a leading `./` while with $(FIND), they
> do. This does not currently pose a problem but in a future patch, we
> will be using `filter-out` to process the list of files with the
> assumption that there is no prefix.
> 
> Unify the two possible invocations in $(FIND_SOURCE_FILES) by using sed
> to remove the `./` prefix in the $(FIND) case.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index b88b42d7ed..e2c693440b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2610,6 +2610,7 @@ FIND_SOURCE_FILES = ( \
>  		-o \( -name 'trash*' -type d -prune \) \
>  		-o \( -name '*.[hcS]' -type f -print \) \
>  		-o \( -name '*.sh' -type f -print \) \
> +		| sed -e 's|^\./||' \

Ramsay pointed out to me (in an off-list email) that the list of
library header files is generated in a similar way, and then those
leading './' have to be removed later.  See how the LIB_H and CHK_HDRS
variables are assigned.

I think it would be great to apply the same treatment there, too, to
eliminate those './' prefixes right at the source.

