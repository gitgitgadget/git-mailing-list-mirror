Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 388141FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 23:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbcLAXC1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 18:02:27 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34542 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbcLAXC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 18:02:26 -0500
Received: by mail-pg0-f51.google.com with SMTP id x23so99889331pgx.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 15:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U+J4cwU85ruialU8RzxHwACdg6c2MhGFbnz0z/VCwaI=;
        b=SiwrsIBj3RQxd1uwIHUSWYICfhPSDItMcp4pVtYInaEC0ZiTgM3lUXmres8RN0krAp
         UH6jIqjgE+kQsDIHhIbwSl4CDe4u+Nv8SR0v0ykHMyC86kPcxSRvI6aSf+ZYWC6MrerJ
         rDWWF8oz4NyjU8qfSPgwGn5Q/Rc2TMNFFbOam4fIEELJWWKMabYqx+gxj/hUWRKg9BNU
         6wvXa+f/kof4isJw1UI5ssnTv6jXt7yvFoEOxsnVDYWEhdZf1Yf5sh0z13nqFqtbcJ+b
         MqqhJ/wtzGVCvaAzYL6U9KgWR4R2zllBrjo+IVhuYuP52B/ozgUM2bNA34A9KG7EJscp
         RULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U+J4cwU85ruialU8RzxHwACdg6c2MhGFbnz0z/VCwaI=;
        b=NrE2+n9Gm8dAO86e0c8gtaWkx8snv1EvH5VqRyCb7N8H+iarBb1S7h7RDWS8iPjXA2
         aNNyw2i4JGPtaj9f3Ww7H+XK18iovsLB02FTo50icN4vkBcqJa9yQkwd6JVelm/nNAXV
         zADkVfZXUeCyweBtYCMegYixOUW/OVU+lfdbMjXfMHYFKKVbwY5P8iGRHaWD6DoobM12
         548YY5csBi9Dd+w2Tc3P0sB8QS1vtyO98xkd1gS9LtwlOXTvT/XwwqqLMBVWVNotUAIP
         EhrrA4IBqZBNhFLITKvux1bMPe1Bh3syqBKDHtNkLzv7oFy+oQjlLp1jnW4a+GWlV1G2
         jMFQ==
X-Gm-Message-State: AKaTC00T9oAYtwgEmNBMVHku5zXFeNvqFU/rmVjFgsXIUJYL4ZyGrF2ATN81ARmcxWjKSTFw
X-Received: by 10.84.170.195 with SMTP id j61mr90117673plb.13.1480633345421;
        Thu, 01 Dec 2016 15:02:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id l69sm2510436pfk.34.2016.12.01.15.02.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 15:02:24 -0800 (PST)
Date:   Thu, 1 Dec 2016 15:02:23 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 5/6] http: treat http-alternates like redirects
Message-ID: <20161201230223.GI54082@google.com>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
 <20161201090432.wtcu2jpacwcf6a4a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201090432.wtcu2jpacwcf6a4a@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Jeff King wrote:
>   - set CURLOPT_PROTOCOLS alongside CURLOPT_REDIR_PROTOCOLS
>     restrict ourselves to a known-safe set and respect any
>     user-provided whitelist.



> diff --git a/http.c b/http.c
> index 825118481..051fe6e5a 100644
> --- a/http.c
> +++ b/http.c
> @@ -745,6 +745,7 @@ static CURL *get_curl_handle(void)
>  	if (is_transport_allowed("ftps"))
>  		allowed_protocols |= CURLPROTO_FTPS;
>  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols);
> +	curl_easy_setopt(result, CURLOPT_PROTOCOLS, allowed_protocols);
>  #else
>  	if (transport_restrict_protocols())
>  		warning("protocol restrictions not applied to curl redirects because\n"

Because I don't know much about how curl works....Only
http/https/ftp/ftps protocols are allowed to be passed to curl?  Is that
because curl only understands those particular protocols?

-- 
Brandon Williams
