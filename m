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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5DC1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 15:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfAIP4L (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 10:56:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35485 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731016AbfAIP4K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 10:56:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so8865501wmt.0
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 07:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TySLZQP13ZnXlu+Igj928cJfvfqfyJAoEZrDaSxlcQI=;
        b=psz3nQbxczdC9Ax9p9QRN2MT6+lfahZZZ+ZXXN7DcBXty796ku/3xwwJrqa4Ntvmdv
         ppiPKeywu5+hGzqusgo69djf8CUk4ApOlgYr9sCTT+8jwXzKHHxAuoCalQUA0Q7cW7aG
         hQC8BySiu8zS6JuA0GpkOtRefHgIdDg/7XNTTfwjUji0yvlhRrjqzMq3BLIDXbQYOxjG
         CwTvCw1yndpGYTVdarc6Ywvws6FKdBj8wTSOwxARkYydvxCerVoBrbgMjcy0SGRzHHyD
         j6Q5Nr5X2okp0PCW6GtDrG/Fsar58HKyzeRf6gexVKHdKG8cZ3ky6i1MCjp+9prmZBWR
         k/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TySLZQP13ZnXlu+Igj928cJfvfqfyJAoEZrDaSxlcQI=;
        b=NvE3zjlSwr+6fAid/3Xzni1U+RpMynvKXwKtI3rc+yHh1YassZdYqKAo3I+bczvFz/
         PJVKsjm0Too8TviKwMhP+xmYZzqRDV44HdXKbD5yVqdQwd/JEHqhbHow5uaP3QJlb5Ht
         N57Uhyl4d4+m2irrwAdtrXgP7mPmPXMFFFiTUt2f6sqpVxRh4L7d6eD6pugqM/NGIpJp
         1DfkhhsX3+eTR4uCm+pLG8IXlIrEYP7fag6Sw/YROI73dqZ/y11boc41ezCQJHNl9STh
         Msdar3LdWxh3SL9MJen9F8Dq+Ti1bdd7HdQnkmFFd/e9HBI9p6f+8LMrIyWre96/ZGVq
         vw1w==
X-Gm-Message-State: AJcUukdVXtNHBVQcHnPQifyg/wqOYnVFmgWscev7/XhmB9RnlfR00SmX
        xHWipCHYWysdzw5BM58pLO0=
X-Google-Smtp-Source: ALg8bN4ldrgGyHEuPMuezyqHQeSswytyG0oiJb0O/J/OyCxoa+U0/1rAE7tiEbdbD51ucW70K9W5+A==
X-Received: by 2002:a1c:ae15:: with SMTP id x21mr6120833wme.146.1547049369022;
        Wed, 09 Jan 2019 07:56:09 -0800 (PST)
Received: from szeder.dev (x4db906b6.dyn.telefonica.de. [77.185.6.182])
        by smtp.gmail.com with ESMTPSA id b18sm49911585wrr.43.2019.01.09.07.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:56:08 -0800 (PST)
Date:   Wed, 9 Jan 2019 16:56:06 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 7/9] multi-pack-index: prepare 'repack' subcommand
Message-ID: <20190109155606.GI4673@szeder.dev>
References: <pull.92.v2.git.gitgitgadget@gmail.com>
 <pull.92.v3.git.gitgitgadget@gmail.com>
 <b39f90ad09265614efd466fee5089354a193ae8c.1547047269.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b39f90ad09265614efd466fee5089354a193ae8c.1547047269.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 09, 2019 at 07:21:17AM -0800, Derrick Stolee via GitGitGadget wrote:
> Introduce a 'repack' subcommand to 'git multi-pack-index' that
> takes a '--batch-size' option. The verb will inspect the

s/verb/subcommand/

> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 145de3a46c..d87a2235e3 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c

> @@ -40,6 +43,11 @@ int cmd_multi_pack_index(int argc, const char **argv,
>  		return 1;
>  	}
>  
> +	if (!strcmp(argv[0], "repack"))
> +		return midx_repack(opts.object_dir, (size_t)opts.batch_size);
> +	if (opts.batch_size)
> +		die(_("--batch-size option is only for 'repack' verb"));

Likewise.

