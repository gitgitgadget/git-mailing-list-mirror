Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DDC61F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeBVAms (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:42:48 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33711 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeBVAmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:42:47 -0500
Received: by mail-pl0-f67.google.com with SMTP id x18so1941344pln.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P0z+R7P3fV2DXu090t5mJQoiElqHsHsS5q6tXPcfzTI=;
        b=j5u1bka4RXsa5QmHPmVTRVp3h01LXZT4b6fO4LSfS/w0CgUz9WA0gTqkXYgnfBiT2K
         V04939qONXm2rFoGl+pMoFDGYTprKrDXODsoaM1WXi6MRyi6L7s2H0XRSCmoO8IeSf4x
         PLTyk3xxrBCIDzvNeuuCM7hmW5T2caZ4d059pAwWJfdlxLZkS7SnI9qzd71zr0vw0Ew8
         rDkX58zjYbC64X3YsGzuXrowQuDsM3Z6QxBd23AADz7D99FuJh+FbuOcjnvCkyA85y9Q
         TTI2ePh/bmuZDSR/gOhTbSrk4Xe1XiTKsKqTt/a2klv8umbPYvtReGgtmCfE1yv+J/1n
         Btww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P0z+R7P3fV2DXu090t5mJQoiElqHsHsS5q6tXPcfzTI=;
        b=jghq9eUrlhH1ZyNDMG0w6NmEmRenVUwpA6cWfrsrgOBJia5qi+URdJL1M3z8BnG4Ok
         huT1VTiM/eV2VBH7DrLWguPAZCgR+uWkKTqZZZJikSQZ8fsSt44JLgF3sD8QEJHYhDnT
         bI1eBSjjDktqizUw69WDaCJqzZn7s3Kw/QK4t0y+Nsgin2CKdBj5LhL339h2cEbLeMCN
         DHFcaIy/sR+T86HniDKjt+Xr7FCAdSHhSWSZXoMLSVmLfVcWxXJuKyP1E11NFYm5Si+q
         MNtajPRSc+BQc8yi0Ssjzk6KN+/8vnpcJZtoQRvsQYc8GQtvuY/JiuxwbcSubrFQTaeC
         Jt1g==
X-Gm-Message-State: APf1xPCGUWkB9MwS9CFtAEjmi7IsBMLBNO+AUBDJSTDXQR6zofl2ZHiW
        i8td0+FaZfQ+o4P7Z0qmOAutAg==
X-Google-Smtp-Source: AH8x227dU1caDVJwzrx7RyeDJ0PEfOsHN22uyGrsCf0LJYtH6oMPWOgwvf+Ix+3yYgsfLkwKgxKNEw==
X-Received: by 2002:a17:902:710f:: with SMTP id a15-v6mr4677668pll.87.1519260166404;
        Wed, 21 Feb 2018 16:42:46 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id m3sm18524530pgd.3.2018.02.21.16.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:42:45 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:42:44 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH 04/27] object-store: free alt_odb_list
Message-ID: <20180222004244.GD127348@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-5-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221015430.96054-5-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/20, Stefan Beller wrote:
> Free the memory and reset alt_odb_{list, tail} to NULL.

Good to see memory leaks being avoided (well they will be on other
repository objects)

> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  object.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/object.c b/object.c
> index 11d904c033..17b1da6d6b 100644
> --- a/object.c
> +++ b/object.c
> @@ -446,7 +446,24 @@ void clear_commit_marks_all(unsigned int flags)
>  	}
>  }
>  
> +static void free_alt_odb(struct alternate_object_database *alt)
> +{
> +	strbuf_release(&alt->scratch);
> +	oid_array_clear(&alt->loose_objects_cache);
> +}
> +
> +static void free_alt_odbs(struct raw_object_store *o)
> +{
> +	while (o->alt_odb_list) {
> +		free_alt_odb(o->alt_odb_list);
> +		o->alt_odb_list = o->alt_odb_list->next;
> +	}
> +}
> +
>  void raw_object_store_clear(struct raw_object_store *o)
>  {
>  	free(o->objectdir);
> +
> +	free_alt_odbs(o);
> +	o->alt_odb_tail = NULL;
>  }
> -- 
> 2.16.1.291.g4437f3f132-goog
> 

-- 
Brandon Williams
