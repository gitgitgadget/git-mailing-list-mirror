Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F75D1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 10:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfJJK2c (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 06:28:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42609 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfJJK2c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 06:28:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so7159083wrw.9
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 03:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LS4RmDElKyAPVM95q7frDZoh0agDhr2/IMWFiwuQB9w=;
        b=H8vpc61hszYDV6l5nnEP9EvX4rHF5KYnSIt56smvj5RhQKQ0bMNceIOtxPhQPT8+u8
         DDpL82p8YgLDbMN/DsfMiv1+F9aIdoesnqA6ciVRW17wGGF6y+sJjLNmPAxXo8R/602l
         cCRyQCCSke5XkiMqiEo92zdziOTWnMM9+2OpTJDEMTccPFY8VN+WknSB386XRDR+0bAx
         d61nTbvmwXecgjchp+cWiQ0ikQiBEHmgSpLq65XNMSw34J2AqiLPfhe8phfSijhn6iQv
         9zHxVOxcyza+VgLiIJpRmHBcjIwIcZBSEUA5dV6l6vUzQG+GFCBzY99ZZKDyzuSGiP94
         X1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LS4RmDElKyAPVM95q7frDZoh0agDhr2/IMWFiwuQB9w=;
        b=Ef2xov661njarXf7ogxktUFr5Sbtejmli7lEPcynkXSEizoGjOvfi+lVrfBB1bCGRh
         2PWpCdbcuzSf7jcyqLLynZuO2puLdnNvssB/0LNLqpaxT7mvJvgI19cvCLrTnmjuoB8D
         xqbl9ulPcJy/SZYYuQ2XefyTS+8VtPEMBqm5A4KBWVBNC9txfKWkmlkihNUoFD37N5WF
         gdYIGY0lv3gdsgXioULQssVLXMN4vck5Yq0itAm7JxAlLwbHzpgf2qevmug80bueN5yN
         aBZrFE6cR9rs3PDD1wEMnglf1Smd0Sge38rYExfgNmSlmrfLUFF3Y1tEVATBZdYw+7kY
         S2LQ==
X-Gm-Message-State: APjAAAV5gLFfWhIoeEqkn57mZSxay4gQWHhRehii/bClskf78x/wC9hh
        Zr+I1PYll0iWXxsVJjYnv1s=
X-Google-Smtp-Source: APXvYqxIcwHmjHP0F/whLDVh73WN1GEzwufmElM6LjgEa1c2MaPJVSeRTy5cxj534bzY1bMcDNAdBQ==
X-Received: by 2002:adf:94c5:: with SMTP id 63mr8359605wrr.199.1570703310444;
        Thu, 10 Oct 2019 03:28:30 -0700 (PDT)
Received: from localhost ([95.149.189.152])
        by smtp.gmail.com with ESMTPSA id z22sm5012059wmf.2.2019.10.10.03.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Oct 2019 03:28:29 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:28:28 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] doc(stash): clarify the description of `save`
Message-ID: <20191010102828.GA12497@cat>
References: <pull.384.git.gitgitgadget@gmail.com>
 <572c7d0c51ffc68dc4603752d05fa7a418dbdd71.1570702000.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572c7d0c51ffc68dc4603752d05fa7a418dbdd71.1570702000.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The original phrasing of this paragraph made at least one person stumble
> over the word "from" (thinking that it was a typo and "from" was
> intended), and other readers chimed in, agreeing that it was confusing:
> https://public-inbox.org/git/0102016b8d597569-c1f6cfdc-cb45-4428-8737-cb1bc30655d8-000000@eu-west-1.amazonses.com/#t
> 
> Let's rewrite that paragraph for clarity.
> 
> Inspired-by-a-patch-by: Catalin Criste <cris_linu_w@yahoo.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks for picking this thread up again, I had already forgotten about
it.  The updated wording sounds like an improvement to me.

> ---
>  Documentation/git-stash.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 8fbe12c66c..53e1a1205d 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -87,8 +87,9 @@ The `--patch` option implies `--keep-index`.  You can use
>  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
>  
>  	This option is deprecated in favour of 'git stash push'.  It
> -	differs from "stash push" in that it cannot take pathspecs,
> -	and any non-option arguments form the message.
> +	differs from "stash push" in that it cannot take pathspecs.
> +	Instead, all non-option arguments are concatenated to form the stash
> +	message.
>  
>  list [<options>]::
>  
> -- 
> gitgitgadget
