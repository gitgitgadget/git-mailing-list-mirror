Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D52E1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 12:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfAIMXs (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 07:23:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53008 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfAIMXs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 07:23:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so7417990wml.2
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 04:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CSjDOA+JsyKk+pDeWU8EXSk5F5sMoSdRqdJnh3ptODs=;
        b=A9Z1Doo9nmLBEdfBhmylgHQZ1JbYYw55s+sr/uUeaYqq71IsjzVr/cKnf5yPL/074w
         KfRAfVN097c2YHtgb9JyDaIVN58F5G8zltN5SXJk0w2/mJpwzZRBKnklgqfv5QhEd/Oh
         0fDbDxYzMN/Z7v47tivq+XCsnJWuACZg/3IhpDfSZwz8vdojYgnUulUBzFTja6q21aPv
         rL4qawD0SwTRw/qOelSFVHrmkFvHJjSSCgbcShz6Ocoy2fjnk2Do5pVPce5RKcgh/JHX
         QCT5B0BzNP/nHGfSC94FjBUVfReWruVWXAJgFLOwptwWtriaiWDs7DU43oABhFbJ/fyO
         vAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CSjDOA+JsyKk+pDeWU8EXSk5F5sMoSdRqdJnh3ptODs=;
        b=QaXkJbC2v4a5DiMBmA3noAH9eAPDG+ho31qDEt+TWZVTycv3i0rIjw1O4SUyqMc2gs
         Uls6ny8mMdCraLA6/Y6JLeRX7M29oDhhTNaMoW2A9jRVQOTepEYd9Lg493XAzp+5TnGW
         L3zdK5S2tt5Nd+OylC40boxyPOvAyct1r9AzUUZRpNkpwEOyinqLgsub1omiZJS0rdYG
         xmnWmhq8TzZgZGgT8vHNtZbwI0vPWoOemC7N5rBQsNSsCni8GPM2rVMbJJUtDHEKtxzx
         R/gm0EAsZ5N/gstM+97X5ng5fl0GkhRVGiScp4KO3bUemVMuzz6ZHO/FF6j7NekuiVjN
         Y71w==
X-Gm-Message-State: AJcUukeim93JNK94fVdnN9CN0HWKj5CK5Um4xbxyUoGEPIpdpb7xhmlw
        yn2GstjRB6dNtH4+rpcCWmg=
X-Google-Smtp-Source: ALg8bN5OZFS2wSFOjOEvb3/h0X/0ci60PlZowcA4LPAAtPLxMDxCdFIsY2OEH5bB8L2VNrjreYDBJQ==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr5406210wmd.36.1547036625594;
        Wed, 09 Jan 2019 04:23:45 -0800 (PST)
Received: from szeder.dev (x4db906b6.dyn.telefonica.de. [77.185.6.182])
        by smtp.gmail.com with ESMTPSA id c15sm10405805wml.27.2019.01.09.04.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 04:23:44 -0800 (PST)
Date:   Wed, 9 Jan 2019 13:23:42 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/1] filter-options: Expand abbreviated numbers
Message-ID: <20190109122342.GF4673@szeder.dev>
References: <cover.1545261186.git.steadmon@google.com>
 <cover.1546906008.git.steadmon@google.com>
 <d35827de35d2a158cd5325569eaaf355563bf028.1546906008.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d35827de35d2a158cd5325569eaaf355563bf028.1546906008.git.steadmon@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 07, 2019 at 04:17:09PM -0800, Josh Steadmon wrote:
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index 5285e7674d..9efb3e9902 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c

> @@ -111,6 +112,21 @@ int opt_parse_list_objects_filter(const struct option *opt,
>  	return parse_list_objects_filter(filter_options, arg);
>  }
>  
> +void expand_list_objects_filter_spec(
> +	const struct list_objects_filter_options *filter,
> +	struct strbuf *expanded_spec)
> +{
> +	strbuf_init(expanded_spec, strlen(filter->filter_spec));
> +	if (filter->choice == LOFC_BLOB_LIMIT)
> +		strbuf_addf(expanded_spec, "blob:limit=%lu",
> +			    filter->blob_limit_value);
> +	else if (filter->choice == LOFC_TREE_DEPTH)
> +		strbuf_addf(expanded_spec, "tree:%lu",
> +			    filter->tree_exclude_depth);
> +	else
> +		strbuf_addstr(expanded_spec, filter->filter_spec);
> +}
> +

All compilers error out with something like this:

  list-objects-filter-options.c: In function
  ‘expand_list_objects_filter_spec’:
  list-objects-filter-options.c:124:29: error: ‘LOFC_TREE_DEPTH’ undeclared (first use in this function); did you mean ‘LOFC_TREE_NONE’?
    else if (filter->choice == LOFC_TREE_DEPTH)
                               ^~~~~~~~~~~~~~~
                               LOFC_TREE_NONE
  list-objects-filter-options.c:124:29: note: each undeclared identifier is reported only once for each function it appears in
  list-objects-filter-options.c:126:14: error: ‘const struct list_objects_filter_options’ has no member named ‘tree_exclude_depth’
          filter->tree_exclude_depth);
                ^~
  make: *** [list-objects-filter-options.o] Error 1

