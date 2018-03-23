Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BEFE1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 18:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeCWSnc (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 14:43:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37207 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCWSnb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 14:43:31 -0400
Received: by mail-pf0-f194.google.com with SMTP id t16so833610pfh.4
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 11:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/dwCBasir7cIeN7d6GM22luxNF+BOgAXJW9QTYqwZkA=;
        b=LwnDD5AtV7GJbC0k7yE34XNAPjrITvsxr2sdVfST8544K55CL4AXgdkaipgsuWVv4v
         HUsiaWUIzCjSWfJ3O3r1uX/+rRhgjumVWYTLMHy6PdCXsYnaCY/W49tLtv58qJfMTXvv
         bzLLMpk8cn/9oGoWsrtvB79dnA6zH4LKKy5heOkV2YjKvh29xRFR38rGMpa/V8VHc5ts
         BPxQZnKwsXwKPEPMRfq7sqm3jELQHC3WL5jXj8PgINnd6HnqzgQJYBAGk7L/7QNF6EEj
         mMPBZYkF7pQ3KBltalLXqArHFVGJ7zVua4iK4X/FpPQRNVTBo5Y7XuJmZBKex776PnRZ
         a81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/dwCBasir7cIeN7d6GM22luxNF+BOgAXJW9QTYqwZkA=;
        b=qhCXXKhzrvLH1gnrqva16r3rCraEI8fvxyjQiG3poffhBFHfR61FWoCDsaFU2+LMso
         0dIpDzw1zEI0uX8UyYviLjA8LJlU1ZR/ibv4bC1sQuY16rLRX7rVJ5rPkiIkFT3z1AZh
         29OoCs0xQhVLhEtcbYmy1WTgYM7JM8RX1N4/veJf/Wdw4CTr1fBCBxj2czHUODXNj9Ne
         JrZ3ZtUTunqPMTPz4TufErnkzlogwDwjQdG4PWzFgevhSWULn23Vir7TaxolhsD8CISw
         AuFxJNDZSCDT8VM1s29mN438Dif1jM9zt2rKh0RIispAyqLL1/1hicy0srUM0fM6LYvd
         9ojQ==
X-Gm-Message-State: AElRT7HOejcox+lTURHkvlsgSL2qmwgxHx62r62PKUrvIAVlfnANB7Ch
        K01cH+akvKIfwW8lksi1jcllQQ==
X-Google-Smtp-Source: AG47ELuCyAC9uuALiuSp1LUSS7FELaQq9bbabQUFYWjmQFbAcEr+qCz63cni2AgAJIeNmQjkRzr7yQ==
X-Received: by 10.98.14.215 with SMTP id 84mr20603204pfo.168.1521830610330;
        Fri, 23 Mar 2018 11:43:30 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id c14sm16988010pfn.185.2018.03.23.11.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 11:43:29 -0700 (PDT)
Date:   Fri, 23 Mar 2018 11:43:28 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/27] object-store: free alt_odb_list
Message-ID: <20180323184328.GC243756@google.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
 <20180323172121.17725-5-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180323172121.17725-5-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/23, Nguyễn Thái Ngọc Duy wrote:
> From: Stefan Beller <sbeller@google.com>
> 
> Free the memory and reset alt_odb_{list, tail} to NULL.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Thanks for fixing the memory leak.  Looks good now.

> ---
>  object.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/object.c b/object.c
> index 6ddd61242c..581347b535 100644
> --- a/object.c
> +++ b/object.c
> @@ -454,8 +454,30 @@ struct raw_object_store *raw_object_store_new(void)
>  	memset(o, 0, sizeof(*o));
>  	return o;
>  }
> +
> +static void free_alt_odb(struct alternate_object_database *alt)
> +{
> +	strbuf_release(&alt->scratch);
> +	oid_array_clear(&alt->loose_objects_cache);
> +	free(alt);
> +}
> +
> +static void free_alt_odbs(struct raw_object_store *o)
> +{
> +	while (o->alt_odb_list) {
> +		struct alternate_object_database *next;
> +
> +		next = o->alt_odb_list->next;
> +		free_alt_odb(o->alt_odb_list);
> +		o->alt_odb_list = next;
> +	}
> +}
> +
>  void raw_object_store_clear(struct raw_object_store *o)
>  {
>  	FREE_AND_NULL(o->objectdir);
>  	FREE_AND_NULL(o->alternate_db);
> +
> +	free_alt_odbs(o);
> +	o->alt_odb_tail = NULL;
>  }
> -- 
> 2.17.0.rc0.348.gd5a49e0b6f
> 

-- 
Brandon Williams
