Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5177D1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 22:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeCNWDM (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 18:03:12 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41799 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeCNWDL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 18:03:11 -0400
Received: by mail-pg0-f66.google.com with SMTP id w17so1963707pgq.8
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 15:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zKDw8y+mjtVPkZvGC2PZVxfVVWGyoFHFxaZOdUcRtT4=;
        b=d2AyLGetnw0ZdFdgn9TFw09LG8uAlwXsdtbzPK+doG9i1hO6XV3q6tOfwcRQ+vARQc
         Los3bBr1zTLy2kxyocR2DZLf7PX45YCNEUQKL/KFltjXvKKeVGgWsMpS6X3ofGc4TzQ6
         xQDAscRnRf7E7TFjixDUKJT0elVb9lvG0+8YVhOaIQc+fBDETeShPOfNhEL4Sog9JGtb
         yDlkQoLNs6AKTtUay1Quj9ZsB6epBcDVsYRm6m33QjU2HxCX81L4UX7fE8MPF5wxv33l
         /5WyCAhdiBodIJ0W1h6PZOzQVLx1NvMbGNxKKppzc9csE3snUDyCS4fzLuPmdIWHEejO
         u0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zKDw8y+mjtVPkZvGC2PZVxfVVWGyoFHFxaZOdUcRtT4=;
        b=YarB6/rmonVD4ZVwQbe0eav1HTwKwPEA0u4qrqAbBSNgCwW+1AcfinWEBJz4P5SQUX
         nN7U/hWvN8UAk3PW1h8rFuVAWCYE/A1Tl0zGnmloZYaofpN8j7cfd3Jj2FAwG5utdnbq
         hZpHpwpgIawCTQaiVDC/1dcImKl7xLv2pSWwx/GYgf13TmSWczm3gIH/RBNJTek8Wy94
         9ikBXfyDzzsAKkuvf6Vtf2Rz9VdJ1bcKzdJZB+TDm0j3wKMI+/QmKdQ1xYTgD8pE85oL
         Kf2bPQ3aQyVykmlHsNcuaLmLN/0eqHM9HR1EHa4NUUgzWaMaJPmGUnLjkFv1cMEP0cvG
         NulQ==
X-Gm-Message-State: AElRT7EDbqTVYRenlkfO7q9rWpnCyr9JEBkiS29+WOp68tbo/SAbIeUw
        zPzNTyjtyvbIEmRULAFgxJvdr2JJ
X-Google-Smtp-Source: AG47ELv6yeLZ1pf0sHvq/rSMw7nO/2hQGtkQEyrFWazama1R+5wyMkdE6zbSJSFAMD+zclsOEAuRAQ==
X-Received: by 10.98.76.155 with SMTP id e27mr4154992pfj.45.1521064990284;
        Wed, 14 Mar 2018 15:03:10 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a14sm6448913pff.75.2018.03.14.15.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 15:03:09 -0700 (PDT)
Date:   Wed, 14 Mar 2018 15:03:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] http: fix an unused variable warning for 'curl_no_proxy'
Message-ID: <20180314220307.GB136265@aiede.svl.corp.google.com>
References: <517c4210-c381-899e-b13a-00f8e4caba74@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <517c4210-c381-899e-b13a-00f8e4caba74@ramsayjones.plus.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ramsay Jones wrote:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> I happened to be building git on an _old_ laptop earlier this evening
> and gcc complained, thus:
>
>       CC http.o
>   http.c:77:20: warning: ‘curl_no_proxy’ defined but not used [-Wunused-variable]
>    static const char *curl_no_proxy;
>                       ^
> The version of libcurl installed was 0x070f04. So, while it was fresh in my
> mind, I applied and tested this patch.

Mind including this in the commit message?  Especially the error message
can be very useful.

With or without such a commit message tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

This variable has been unused in the old-curl case since it was
introduced in v2.8.0-rc2~2^2 (http: honor no_http env variable to
bypass proxy, 2016-02-29).  Thanks for fixing it.

Sincerely,
Jonathan

> ATB,
> Ramsay Jones
> 
>  http.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/http.c b/http.c
> index 8c11156ae..a5bd5d62c 100644
> --- a/http.c
> +++ b/http.c
> @@ -69,6 +69,9 @@ static const char *ssl_key;
>  #if LIBCURL_VERSION_NUM >= 0x070908
>  static const char *ssl_capath;
>  #endif
> +#if LIBCURL_VERSION_NUM >= 0x071304
> +static const char *curl_no_proxy;
> +#endif
>  #if LIBCURL_VERSION_NUM >= 0x072c00
>  static const char *ssl_pinnedkey;
>  #endif
> @@ -77,7 +80,6 @@ static long curl_low_speed_limit = -1;
>  static long curl_low_speed_time = -1;
>  static int curl_ftp_no_epsv;
>  static const char *curl_http_proxy;
> -static const char *curl_no_proxy;
>  static const char *http_proxy_authmethod;
>  static struct {
>  	const char *name;
