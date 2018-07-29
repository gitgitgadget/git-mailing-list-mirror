Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5E8208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 21:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbeG2XAH (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 19:00:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43545 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeG2XAH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 19:00:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so10621389wrv.10
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 14:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v/0gjlEZaCfW7wTnPtWMVsIWzi+lxZ60gZtv+xVb5kU=;
        b=qoTaMCUaRVXd6zDvbtyIDupKYjay3C+wonXBDm3DBdqonZVFghEYO4oHnDoz0YVjvo
         +NzQmTZftykoMOt20oWOqoWKQY6d4Xvfe76aYf6/3SWjfkSOpa+wgSoPWPSZk+ASa7G6
         fKWH4wfALgA9JFTFX6L5TE31fZ2g0EHkQs4BkAV6uk7EJ3i8Zm+sU2b9l9thJkRJkBzM
         lIokg9ZFYJD2OOakriRMGzpr9IRo/6VcQ6SMBsi55+QAsFpiLWmHwnzVdBJ3Rb5HJhTX
         UINfNY7LfmneMrdG8G0I5jJU28rT0O0LisNx7PoZjNCeClAALNrX08Sg9s50As59pVL9
         Jn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v/0gjlEZaCfW7wTnPtWMVsIWzi+lxZ60gZtv+xVb5kU=;
        b=eCBZVxM4kNirngIY332OK4T1GHafPV96OjTZ6auvus7AYpqA8NYFAeyOd9ZuBNYbdk
         UbM2LO1etkYXS7P1BELrMR/Lygwt21fDLgk8AZO6890++sUIxvCBDAuQliNgOOET4eoW
         f5hpKPAaSHV73KvfNjxogE/vjmjwSEY3tB54m4zRKC5vPJKLznFnPXEc3a8GXQbtQzVS
         Te7YQkAeMcSGkkO0ww9Lt3Nmnt3JejIonSobU/lv7dRJ1qHhKmDtr+t8obaUOeAPIgRd
         6Fyahp8vBS7F/Kfo07fe1IBEoHLLhjGq7cwFEwJF1U1tuoG4Ni/EEO54h8rHcetIEIZr
         wHJA==
X-Gm-Message-State: AOUpUlG0jhREd0RWEl05jAjYRVYN4du758ECkraeJ0OR4owO0z0vn7G7
        mbCovkHIo1I+o4/bELa1pIY=
X-Google-Smtp-Source: AAOMgpcM09a++9M98tgNZsRSpgSnhPU4rKsLolp/qL+nE08RUXa55dRRLlxQP4Oj8SNjLFnoIMbGyw==
X-Received: by 2002:adf:ec04:: with SMTP id x4-v6mr14080254wrn.245.1532899691586;
        Sun, 29 Jul 2018 14:28:11 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id d12-v6sm10692112wru.36.2018.07.29.14.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 14:28:10 -0700 (PDT)
Date:   Sun, 29 Jul 2018 22:28:09 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 09/21] range-diff: adjust the output of the commit
 pairs
Message-ID: <20180729212809.GA13316@hank.intra.tgummerer.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
 <pull.1.v4.git.gitgitgadget@gmail.com>
 <9641ab5c0df984f5e7ea9c49debffffe2a929095.1532210683.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9641ab5c0df984f5e7ea9c49debffffe2a929095.1532210683.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/21, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This change brings `git range-diff` yet another step closer to
> feature parity with tbdiff: it now shows the oneline, too, and indicates
> with `=` when the commits have identical diffs.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  range-diff.c | 64 ++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 55 insertions(+), 9 deletions(-)
> 
> diff --git a/range-diff.c b/range-diff.c
> index 1ecee2c09..8329f52e7 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -7,6 +7,8 @@
>  #include "xdiff-interface.h"
>  #include "linear-assignment.h"
>  #include "diffcore.h"
> +#include "commit.h"
> +#include "pretty.h"
>  
>  struct patch_util {
>  	/* For the search for an exact match */
> @@ -255,9 +257,54 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
>  	free(b2a);
>  }
>  
> -static const char *short_oid(struct patch_util *util)
> +static void output_pair_header(struct strbuf *buf,
> +			       struct strbuf *dashes,
> +			       struct patch_util *a_util,
> +			       struct patch_util *b_util)
>  {
> -	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
> +	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
> +	struct commit *commit;
> +
> +	if (!dashes->len)
> +		strbuf_addchars(dashes, '-',
> +				strlen(find_unique_abbrev(oid,
> +							  DEFAULT_ABBREV)));
> +
> +	strbuf_reset(buf);
> +	if (!a_util)
> +		strbuf_addf(buf, "-:  %s ", dashes->buf);
> +	else
> +		strbuf_addf(buf, "%d:  %s ", a_util->i + 1,
> +			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));

I failed to notice this earlier, but here we are starting to use
util->i, which I was wondering about earlier.  Good :)

> +	if (!a_util)
> +		strbuf_addch(buf, '>');
> +	else if (!b_util)
> +		strbuf_addch(buf, '<');
> +	else if (strcmp(a_util->patch, b_util->patch))
> +		strbuf_addch(buf, '!');
> +	else
> +		strbuf_addch(buf, '=');
> +
> +	if (!b_util)
> +		strbuf_addf(buf, " -:  %s", dashes->buf);
> +	else
> +		strbuf_addf(buf, " %d:  %s", b_util->i + 1,
> +			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));

And here for range b.

> +
> [...]
