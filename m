Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B7920248
	for <e@80x24.org>; Mon, 18 Mar 2019 20:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfCRU22 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 16:28:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34989 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfCRU22 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 16:28:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so1524981pgf.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xYzO9y0uhuixdEQbFSfHu55oy46W5j9AyonO62pOsFU=;
        b=YYVaB/6ZX168zJPZvWQa5ErUakQQ5KdhuWBtA0pCEV/zZv8jS4rQPkUWMSFKy3q3jb
         lkujANsQYYNCH8wDbcAqW91ImqbCKjJYQJsEqv+FDPrLEqX/26D1WNs+XDvn5DyDZdtj
         ngPCf1ceDrfO/UtrtqbGosqzTXZVrDxuJnUBda/K3+dki4dDsygOBJbWCuiYFgRUWfJA
         cyEwIyUtnjB92LxVjoXfMrh//p1FtpnGtYUBdYBOvfCliBIQq4wNBvmi9oDV7crJtHWA
         /OB3a6vjcUH0b9aqamFj4SJX8FugnJB8wehVP3ZwIBHl6hiRlYIYIUgJdtCagrIkLcze
         RmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xYzO9y0uhuixdEQbFSfHu55oy46W5j9AyonO62pOsFU=;
        b=PyOLvPbYg56j+lVGnQ0PSX/8wxv7Fk1sqB5h5h0xgF0TZjU+tAsxw7Bm+1/mxgobuo
         TmHYnfvBMuzNptzIGd+uWMwjyYsik4m0lpBeee+g9f6DyX5sHnjlI4jrbm18xx+c8V9x
         crq/v+kB88IW4N8zOcWsPBxq7lMrabSSE8Ao7GzoSRH2lnMHsbnNbx1EwetVjeVQeb0I
         bLktSi9gAImQtNE/QQLZlUQRFzdr9/50Cu4y4zw/CUIb25dHPROVm5TDanQWuwykKzSO
         RlC3dt+ERWsm0JNOP75RBtiabynzhrlD2PoVyksacYvti+0zvSW1/JdNBsnN7SSz14fM
         qz8g==
X-Gm-Message-State: APjAAAWSKcLecGoddgOYGAoO2DvblYL7LxGUWNqVut+AfUS+eUQUNLjH
        SOGXDAa0NTlXHyIUGO90Q/w=
X-Google-Smtp-Source: APXvYqzuRCX5XWTzxk+/33rpk1ON4QwvDfC0u+wyeurXEwh0hkCR3vjfWBBVdvNbFlwG99+QS7TeZw==
X-Received: by 2002:a17:902:3f83:: with SMTP id a3mr20975466pld.6.1552940906974;
        Mon, 18 Mar 2019 13:28:26 -0700 (PDT)
Received: from gmail.com (37.76.230.35.bc.googleusercontent.com. [35.230.76.37])
        by smtp.gmail.com with ESMTPSA id j12sm6729713pfa.33.2019.03.18.13.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 13:28:26 -0700 (PDT)
Date:   Mon, 18 Mar 2019 13:28:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 4/4] gc docs: downplay the usefulness of --aggressive
Message-ID: <20190318202824.GA24222@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
 <20190318161502.7979-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318161502.7979-5-avarab@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -41,10 +41,20 @@ OPTIONS
>  --aggressive::
>  	Usually 'git gc' runs very quickly while providing good disk
>  	space utilization and performance.  This option will cause
> -	'git gc' to more aggressively optimize the repository at the expense
> -	of taking much more time.  The effects of this optimization are
> -	persistent, so this option only needs to be used occasionally; every
> -	few hundred changesets or so.
> +	'git gc' to more aggressively optimize the repository to save storage space
> +	at the expense of taking much more time.

This part looks good.

> ++
> +Using this option may optimize for disk space at the expense of
> +runtime performance. See the `--depth` and `--window` documentation in
> +linkgit:git-repack[1]. It is not recommended that this option be used
> +to improve performance for a given repository without running tailored
> +performance benchmarks on it. It may make things better, or worse. Not
> +using this at all is the right trade-off for most users and their
> +repositories.

This part kind of feels like giving up.  Can we make --aggressive have
good runtime read performance so we don't have to hedge this way?
E.g. is this patch papering over a poor choice of --depth setting in
--aggressive?

> ++
> +The effects of this option are persistent to the extent that
> +`gc.autoPackLimit` and friends don't cause a consolidation of existing
> +pack(s) generated with this option.

Thanks and hope that helps,
Jonathan
