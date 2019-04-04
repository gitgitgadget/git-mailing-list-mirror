Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5FD20248
	for <e@80x24.org>; Thu,  4 Apr 2019 17:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfDDRZU (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 13:25:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52556 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbfDDRZT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 13:25:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so3950386wma.2
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7YnjEIE2Ye+nGHWvs5iqgjRf2TedVY7fOpXs5yjIhJ8=;
        b=EnFFMbWhfvXQ6ko4v9LoW3TV9gDnn2oYQvzAIpTwhkMyXdhicyr2zWOOtr2HaHbBE2
         eu8Zs8+D2JOXYtf/ocqWi/G9gCKE9XyZJjoQgAgkuXiyM3v/eg6ZEApWAt6T4mCqFQsn
         C2vAxDtBOISO7Fd5I3ecX48Qp67Qqz/qlES5Dft1UZSU8p7I92bTpl/4CxrQ/TnStR0+
         Ku+wDPZ7KHFG6Kf0APcL2Lsd/eIJXAVFqCGOkCInPqyieX1pp9mFeTji2qGbBX+YT1Mv
         DkpbNWnyTP1YlfcXQaR+W6uFEZGmjhW4eZmfaiW7umxHJJb414LTWlfRF5SLZaNbxxAQ
         dhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7YnjEIE2Ye+nGHWvs5iqgjRf2TedVY7fOpXs5yjIhJ8=;
        b=X1t5zK42dc8OBdaJZJtbq9zyKhLEOsmcTImeg6pkfsQaV9Q9XvEPy6lKYrT+QMSSzb
         2lscu+0dX615N4wfIDRkh/HRk6r37MOIIY1oS4zoKa+Jl8WqZvcQIQa7rw/sMv2+9JGP
         v+x/702v8z0wMYOAr7frhq7bqQB/4AcNqMUA2AMO4uZa8+wVeYgswoxuvViNwGbLBftF
         m/KtMqrqMpU4NDODKXM3PlGAdRr0v4ClW+iPddFWVzuoce04kGh0dRjjzdtlWw7j5vpN
         ylKVgCl+WOzx9Y8BqQrPC+MdtGYC/YmhXhX0/Jtgbzm1GMFymwgS68F5RBQ72SbwvHCJ
         oisA==
X-Gm-Message-State: APjAAAUr1HEJcle8pVl3v26yQ9q5IrBkWzdL7w3kjOHW6Ql5Z7OjYg+1
        TSM0OgwomnqSHTxr5xrrfJc=
X-Google-Smtp-Source: APXvYqyTmrHyaErA5SxSZU6b+XDt63ooEZ/89YfPS8BMYUHQgLzcNgWaDHmlhlsXwxRdMotTmJyixw==
X-Received: by 2002:a1c:ef08:: with SMTP id n8mr4852664wmh.85.1554398718051;
        Thu, 04 Apr 2019 10:25:18 -0700 (PDT)
Received: from szeder.dev (x4db96230.dyn.telefonica.de. [77.185.98.48])
        by smtp.gmail.com with ESMTPSA id l21sm10829629wme.4.2019.04.04.10.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 10:25:17 -0700 (PDT)
Date:   Thu, 4 Apr 2019 19:25:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com
Subject: Re: [PATCH v2 01/32] rebase: 'make coccicheck' cleanup
Message-ID: <20190404172515.GR32732@szeder.dev>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
 <20190403113457.20399-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403113457.20399-2-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 06:34:26PM +0700, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/rebase.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 77deebc65c..c064909329 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1592,8 +1592,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  				branch_name = options.head_name;
>  
>  		} else {
> -			free(options.head_name);
> -			options.head_name = NULL;
> +			FREE_AND_NULL(options.head_name);
>  			branch_name = "HEAD";
>  		}
>  		if (get_oid("HEAD", &options.orig_head))
> @@ -1793,7 +1792,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	 * we just fast-forwarded.
>  	 */
>  	strbuf_reset(&msg);
> -	if (!oidcmp(&merge_base, &options.orig_head)) {
> +	if (oideq(&merge_base, &options.orig_head)) {
>  		printf(_("Fast-forwarded %s to %s.\n"),
>  			branch_name, options.onto_name);
>  		strbuf_addf(&msg, "rebase finished: %s onto %s",

You are already using Coccinelle v1.0.7, aren't you?

For some reason previous versions don't notice these two
transformations.  I have patches with these transformations lying
around here for some time now, but haven't submitted them yet, because
I don't really like the way I run Coccinelle v1.0.7 in our static
analysis CI build jobs [1]

Anyway, here are my commit messages for these transformations, please
feel free to re-use them:

  -- >8 --

Subject: builtin rebase: use oideq()

Use oideq() instead of !oidcmp(), as it is more idiomatic, and might
give the compiler more opportunities to optimize.

Patch generated with 'contrib/coccinelle/free.cocci' and Coccinelle
v1.0.7 (previous Coccinelle versions don't notice this).

  -- 8< --

Subject: builtin rebase: use FREE_AND_NULL
    
Use the macro FREE_AND_NULL to release memory allocated for
'head_name' and clear its pointer.
    
Patch generated with 'contrib/coccinelle/free.cocci' and Coccinelle
v1.0.7 (previous Coccinelle versions don't notice this).

  -- >8 --


[1] https://github.com/szeder/git/commits/travis-coccinelle

