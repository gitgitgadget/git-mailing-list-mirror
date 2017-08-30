Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469A7208E3
	for <e@80x24.org>; Wed, 30 Aug 2017 22:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750975AbdH3Wkc (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 18:40:32 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33682 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdH3Wkb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 18:40:31 -0400
Received: by mail-pg0-f45.google.com with SMTP id t3so23763632pgt.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Icposr5ZI7n70Pm6Q1xMX0qQulxSPGwUsq0/LNjY4A=;
        b=C4xod+liv/jidrZxxLms8q7gMFdqUugVZ7DQ6MR6VORJsHFTTH5qfh+c+OtLPwfXp7
         swt14TW0VorJkqxnoIZTNbo0EX1d4Cw20BJS3VQ1RCC7FB0mYG66ZvWKhZ1kCWfjDQ/k
         +yt4e/G1ZaFYAdYHB/AXYmubiE3H2TIXp3/CIVZhHyzQOMcqu+1wbK3sbXNMQJ5Pp0Yq
         RzmlrjMpEkGsgSMVGc2LiR6Xae5RIaecyq6yeeYC6au4FSs02DB8T5POOrSEIM46Fk55
         TY6eN41AQj0OC3pEbygA/CAVc57P3SKeL4O8Zt7dDkwbnhxo/mCAk7WhcZKPMTFGPVsr
         UesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Icposr5ZI7n70Pm6Q1xMX0qQulxSPGwUsq0/LNjY4A=;
        b=aGd3Gj8pFbR9pN/VdmAkarru04wYzukgA52i5s6LZmans1E7zrKbs7cilsGc0p85o9
         Z2c/hH19ZrpthUafFTNqe/PtPxuuwgP0GNIukmdEI6fHmAH0SZ003zDdt27+15aocoKk
         V4pMWIo5pkUiA1SmhjBBUiqmH8vdDS0nWTkrSdXpZnqT7RCm5fLBKjCu5xcwoCNApVQr
         zrESYStBk8VwbujHIVmJPUnuc6IIoSRjtDBT5fdij1mwEcQXKO5RrnAr7qkHgN4EChxk
         JUtC1To3x5iGm0svMUyFZjqFDA9jQT3IE6a5rGrmzHtpBYODxFivpshVGcGGyCmI/HOo
         9FDg==
X-Gm-Message-State: AHYfb5gxcbiUznEusk8NrbYKxEej5Ow5S2JyiWduBfKebn3Oex3yqg1Z
        lkbDQY6laeT9sOQ6
X-Google-Smtp-Source: ADKCNb6XAN/i5fwz9ZprmryqqQowjFSDFZsM99qwohyOxibOZ8FtRt2y8IQz+RGy0BHUUthlVr9CRw==
X-Received: by 10.99.2.2 with SMTP id 2mr147691pgc.382.1504132831164;
        Wed, 30 Aug 2017 15:40:31 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:81c4:afb0:c46d:bc75])
        by smtp.gmail.com with ESMTPSA id x128sm4913664pgb.1.2017.08.30.15.40.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 15:40:30 -0700 (PDT)
Date:   Wed, 30 Aug 2017 15:40:28 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 07/39] sha1_file: add repository argument to
 alt_odb_usable
Message-ID: <20170830224028.GE50018@google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
 <20170830065631.GH153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830065631.GH153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/29, Jonathan Nieder wrote:
> From: Stefan Beller <sbeller@google.com>
> 
> Add a repository argument to allow the alt_odb_usable caller to be
> more specific about which repository to act on. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
> 
> Since the implementation does not yet work with other repositories,
> use a wrapper macro to enforce that the caller passes in
> the_repository as the first argument. It would be more appealing to
> use BUILD_ASSERT_OR_ZERO to enforce this, but that doesn't work
> because it requires a compile-time constant and common compilers like
> gcc 4.8.4 do not consider "r == the_repository" a compile-time
> constant.

Very clever trick :)

> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  sha1_file.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 7c6ffd205a..1c757b44a3 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -280,7 +280,9 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
>  /*
>   * Return non-zero iff the path is usable as an alternate object database.
>   */
> -static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
> +#define alt_odb_usable(r, p, n) alt_odb_usable_##r(p, n)
> +static int alt_odb_usable_the_repository(struct strbuf *path,
> +					 const char *normalized_objdir)
>  {
>  	struct alternate_object_database *alt;
>  
> @@ -348,7 +350,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
>  	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
>  		strbuf_setlen(&pathbuf, pathbuf.len - 1);
>  
> -	if (!alt_odb_usable(&pathbuf, normalized_objdir)) {
> +	if (!alt_odb_usable(the_repository, &pathbuf, normalized_objdir)) {
>  		strbuf_release(&pathbuf);
>  		return -1;
>  	}
> -- 
> 2.14.1.581.gf28d330327
> 

-- 
Brandon Williams
