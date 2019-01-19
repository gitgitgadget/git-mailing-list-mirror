Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FEB1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 01:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfASBSi (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 20:18:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33980 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfASBSi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 20:18:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so17266818wrw.1
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 17:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B9H/HFMVc6dXQJuCEFOcxgi9vdUyGaSffOmsXaxg8Ss=;
        b=DQfU7LNX3ec/mwTRmDRotN2PBtin7aHK/y5cP1pthrhI/VKVKS4e/uYOuitvpAhPUP
         G5VBokdtPP5m6tCPoz1E2kmGFnC4UBbu8EYMBgR3Jc81UsXKiZg8dsyrhr0ObDzV8LPQ
         q1yLHiiPpSWO1kKytG3xqAtnVUw1Mk9iyup7Uo4rjHIcyBfr4/UqeDYlApAt19k7H55T
         SsBoA8k2I387m8NgpPJjDMoRui7UuzXx70nI2K9HddoFl8zBXJjHbzGRDn/zexh3Mz2P
         rWr4eUlN+qPHgToxIkD99UTPK96uNdagx6jzWDRaJ/jTGN5LIQ3/nVSQmEeDWi09A1bb
         uhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B9H/HFMVc6dXQJuCEFOcxgi9vdUyGaSffOmsXaxg8Ss=;
        b=L5WdZU8is9oGeDeXvRMTDucAtIVog2e4/l9xV+GBrQtrkDwNuYo6DH37CarVriaxXK
         ulnGVX30pSiS2GoR89UgLZGojOvuZpYUolcCjnbMiqbWft2duGOa3y8HC2fIt429uiAk
         9Bi/FAuP8MrXQ9pUlq5h+TZt/c3/VNvmxzwSA56ira4yaljRzvVOmbkDv6hHrNXWlqcH
         FoWzOpxrRTa+3qRM4ozRkWHsOinqRY0RVHK+UPRzMykQjDCO0OAWHMs1G78AUyOmLOjZ
         MMtbPxLJTamqKB1fPjYRC8AnV/VBLWHiUF1uHHCcwPaftv5L6IAbUkVu8U52oioHufat
         QHZw==
X-Gm-Message-State: AJcUukfJ0pNNSTaoWsX640CeVFarn8oocuizcvuyDxlLY6yEIIbsGrIG
        tpyDosxh5DIAy9OfpnUtTzk=
X-Google-Smtp-Source: ALg8bN6WNYzR38tZY665MIopKoc7k5zTEEVESICkUntoF+2pY1OAmuc1dABRL5TN0snRlvPFh3iXLw==
X-Received: by 2002:adf:a743:: with SMTP id e3mr18107258wrd.56.1547860716994;
        Fri, 18 Jan 2019 17:18:36 -0800 (PST)
Received: from szeder.dev (x4dbd9ead.dyn.telefonica.de. [77.189.158.173])
        by smtp.gmail.com with ESMTPSA id t63sm37741203wmt.8.2019.01.18.17.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 17:18:36 -0800 (PST)
Date:   Sat, 19 Jan 2019 02:18:34 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 70/76] diff.c: convert --inter-hunk-context
Message-ID: <20190119011834.GP840@szeder.dev>
References: <20190117130615.18732-1-pclouds@gmail.com>
 <20190117130615.18732-71-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190117130615.18732-71-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 08:06:09PM +0700, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  diff.c          | 6 +++---
>  parse-options.h | 3 ++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 3e7c36524d..cc10b27df0 100644
> --- a/diff.c
> +++ b/diff.c

> @@ -5503,9 +5506,6 @@ int diff_opt_parse(struct diff_options *options,
>  	}
>  
>  	/* misc options */
> -	else if (opt_arg(arg, '\0', "inter-hunk-context",
> -			 &options->interhunkcontext))
> -		;

This hunk removes the last remaining callsite of the static opt_arg()
function:

  diff.c:4581:12: error: ‘opt_arg’ defined but not used [-Werror=unused-function]
   static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
              ^
  cc1: all warnings being treated as errors


>  	else
>  		return 0;
>  	return 1;
