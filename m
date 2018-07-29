Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC32C208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 20:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeG2WXx (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 18:23:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43545 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbeG2WXx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 18:23:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so10562670wrv.10
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 13:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uQ4n+Vrs/xqgnrC0+G59N4smE8zIEo+9oeD2RK86yHg=;
        b=NpnVi6hRv/G28ks2A73yZPuaODgeMNeQPh/kTgd+5xjTLrLg68Hp5K7mgnLMQrCKMn
         AdGVRwUTaf4Rcf1l+oNVDeAD2RRbTtKwO8mciupdvQ7IfbkNySPzAhq0yLtKWJl42bDC
         d8qYWD1yCTZ/ox2s12cnlgXxa+9TFZCbi5evpcL56Mzv+CHqnqxSBSeaMpcsLehuoavD
         JInvYczLGQ0ajiC2qaJ4d0YoHuFiCWH3Swki1ZFVtjJvKxHNyqpvOpUuCZmgLlTnMkRS
         dvyBb9m0aDVKD9YvSY4B6KtbVKTsnqpvGRh+QwKWCZhYWNVZoc6sz2vc/8dz07EU9izO
         +/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQ4n+Vrs/xqgnrC0+G59N4smE8zIEo+9oeD2RK86yHg=;
        b=STK72TB6+Na8FaXjEcfW9bwALqEc+aA910KLFbKfgro/ceRPun4G1THYZLZOmg/+3m
         kuDjQrq/pxrSkmWCKh9IPVbbUpr7ZlOSzhluZDZY2p+0G1Y6EKnVOT2h3RbTN84phdH7
         iAGCS/sSoKbqHS5ND+XcylWXu4yzh3c6OBzop5IMeHvxChWB9YUHW/EglBtaXTgpCFQx
         cNifhhEoMQF97L+sVotIVHaISc1pEZLgfavyD6I5HaUB59S55dii+TotgUzuhwvXoe1j
         lAYTnwBK1VLXdlxHqaHCHsaaJWC3CHHxqNnDgp8ra6n3XfZD+a+NU2BGvIYDRfUr6Kap
         4CQQ==
X-Gm-Message-State: AOUpUlEbrdgYb5jjQG/YqDgsA1ZAIfo9nTFCZmRQs+BhduxzOwp5VXEr
        h8fpftPk2Gsdc9eOSSyEea4=
X-Google-Smtp-Source: AAOMgpeFYQvGVqVVh+7laqMYd1zwMfUj7vSd688zM6mVi3PG5pebOa6hPP8R8LJJV4qSYJXvr1XIEg==
X-Received: by 2002:a5d:550a:: with SMTP id b10-v6mr15234579wrv.228.1532897524781;
        Sun, 29 Jul 2018 13:52:04 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id g63-v6sm10994843wmf.3.2018.07.29.13.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 13:52:03 -0700 (PDT)
Date:   Sun, 29 Jul 2018 21:52:02 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 10/21] range-diff: do not show "function names" in
 hunk headers
Message-ID: <20180729205202.GA9955@hank.intra.tgummerer.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
 <pull.1.v4.git.gitgitgadget@gmail.com>
 <0a52f887887cae039ee84b90cc05a6396242a744.1532210683.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a52f887887cae039ee84b90cc05a6396242a744.1532210683.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/21, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> We are comparing complete, formatted commit messages with patches. There
> are no function names here, so stop looking for them.

While there are no function names here, trying out range-diff without
this patch applied, the headers were getting here do seem kind of
useful:

    1: 92588fc6b6 ! 3: 43c9ef552c
        @@ -8,8 +8,16 @@ diff --git a/read-cache.c b/read-cache.c
    	[...]

The filename can be quite useful in this output.  I guess this is a
bit brittle though, so I'm also happy to defer changing this to show
something useful to the list of possible future enhancements
(obviously doesn't necessarily have to be implemented by you at that
point).

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  range-diff.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/range-diff.c b/range-diff.c
> index 8329f52e7..3fc3a4018 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -9,6 +9,7 @@
>  #include "diffcore.h"
>  #include "commit.h"
>  #include "pretty.h"
> +#include "userdiff.h"
>  
>  struct patch_util {
>  	/* For the search for an exact match */
> @@ -307,6 +308,10 @@ static void output_pair_header(struct strbuf *buf,
>  	fwrite(buf->buf, buf->len, 1, stdout);
>  }
>  
> +static struct userdiff_driver no_func_name = {
> +	.funcname = { "$^", 0 }
> +};
> +
>  static struct diff_filespec *get_filespec(const char *name, const char *p)
>  {
>  	struct diff_filespec *spec = alloc_filespec(name);
> @@ -316,6 +321,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
>  	spec->size = strlen(p);
>  	spec->should_munmap = 0;
>  	spec->is_stdin = 1;
> +	spec->driver = &no_func_name;
>  
>  	return spec;
>  }
> -- 
> gitgitgadget
> 
