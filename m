Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C761F45F
	for <e@80x24.org>; Fri, 10 May 2019 21:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfEJVPJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 17:15:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51995 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfEJVPI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 17:15:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id o189so8855425wmb.1
        for <git@vger.kernel.org>; Fri, 10 May 2019 14:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kG6RCReL9zrw+znvxTnqil7OfQVm3pyK4/jJ6MmTMGI=;
        b=QkyhCfdhaXftwKHSPx24kjHtMRICrD79Qt2VlHBRKdL9zSNAn2ifHZ460891UA8cps
         zMf7cMKsx7Xh7vu1WRN73tgf/37jK57SFxG17XSxlrARGgp1KtT1B0acLl2m5ItGuJ2K
         YD7YZnVYPjlDbo7QZLiW61XftNzr19BpCDifBwhhPEoD8QWCUNdgdrBJeAV3lwVko5dy
         g5jLGllelnovHFOkVeCMOLxMGUKyU+zCMKefsAXVIIrXFB7zdlmBYyYiELoAelpDpbZZ
         j/ciZkW/Lha+DSAps2CT4gWQ0EaR8kfvs6RN+Ao9GJKvQTF8itT3tWOsBadu2NQW/oM9
         Z6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kG6RCReL9zrw+znvxTnqil7OfQVm3pyK4/jJ6MmTMGI=;
        b=DLu00iCSemXmsJR06BxJ+NJpSI/RE7Hb95kruN9TLJbp5Mv83/4gllYQnUlQpeHHFz
         4s6JGosxKT31agJXJ4Woj0dymcWpLlgZGcTOJFzKWH7PWnnzZIjG7l5zF/cR75bLe+x4
         DaCVboBBVdXGxZIrnFSYRTIzcTS+xNFNhPT2osSAnqqsI2O8SAuNtX3q7cxvlomdHRgk
         QIv60DdjKbo6oOuPK7AOeXpJdEnMyQGZSV/O0WbZIJg3iAHCG3DMxpd+9Ctnl8FvrJjX
         9kHSfzOJUmY9A3IdsuzGmCa3SKI+UiXroNcIjP+3wSV5H6vGQX2zxwt20DE45dXi2b41
         7eMQ==
X-Gm-Message-State: APjAAAXAZHgebtQT+992enivjOM0ySt97cV+ECu+wuwRWDgQkkyyiH1a
        uLv2YUh/AcyIiTTASfQh7Eo=
X-Google-Smtp-Source: APXvYqz8roC5ClIg9OM0m0lwMUlhY7RwUPJTQMTbtM1EVbFwOKzrT7ev80+Rp+tGUP6RnnVyEKpaPg==
X-Received: by 2002:a1c:3:: with SMTP id 3mr599070wma.44.1557522906235;
        Fri, 10 May 2019 14:15:06 -0700 (PDT)
Received: from szeder.dev (x4d0c00f2.dyn.telefonica.de. [77.12.0.242])
        by smtp.gmail.com with ESMTPSA id h24sm10494165wmb.40.2019.05.10.14.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 14:15:05 -0700 (PDT)
Date:   Fri, 10 May 2019 23:15:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] trace2: Add variable description to git.txt
Message-ID: <20190510211502.GS14763@szeder.dev>
References: <pull.189.git.gitgitgadget@gmail.com>
 <768bdf1c210fd34776f667b080a23eb6f9e17125.1557517464.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <768bdf1c210fd34776f667b080a23eb6f9e17125.1557517464.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks for the quick turnaround.


On Fri, May 10, 2019 at 12:44:26PM -0700, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Documentation/technical/api-trace2.txt contains the full details
> of the trace2 API and the GIT_TR2* environment variables. However,
> most environment variables are included in Documentation/git.txt,
> including the GIT_TRACE* variables.
> 
> Add a brief description of the GIT_TR2* variables with links to
> the full technical details. The biggest difference from the
> original variables is that we can specify a Unix Domain Socket.
> Mention this difference, but leave the details to the technical
> documents.

I think that it would be better to spell out the details instead of
linking to the technical docs, because the link will only really work
if you view the docs in a browser and you have the full docs
available.  OTOH, in 'man git' there are no links to conveniently
click on, and the git packages from e.g. Ubuntu only include the man
pages, the technical docs and the docs in html format are in the
separate 'git-doc' package.


> Reported-by: Szeder Gábor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git.txt | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 00156d64aa..e802886999 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -661,6 +661,27 @@ of clones and fetches.
>  	When a curl trace is enabled (see `GIT_TRACE_CURL` above), do not dump
>  	data (that is, only dump info lines and headers).
>  
> +`GIT_TR2`::
> +	Enables more detailed trace messages from the "trace2" library.
> +	Output from `GIT_TR2` is a simple text-based format for human
> +	readability.
> ++
> +The `GIT_TR2` variables can take many values. Any value available to
> +the `GIT_TRACE` variables is also available to `GIT_TR2`. The `GIT_TR2`
> +variables can also specify a Unix Domain Socket. See
> +link:technical/api-trace2.html[Trace2 documentation] for full details.
> +
> +`GIT_TR2_EVENT`::
> +	This setting writes a JSON-based format that is suited for machine
> +	interpretation. See link:technical/api-trace2.html[Trace2 documentation]
> +	for full details.
> +
> +`GIT_TR2_PERF`::
> +	In addition to the text-based messages available in `GIT_TR2`, this
> +	setting writes a column-based format for understanding nesting
> +	regions. See link:technical/api-trace2.html[Trace2 documentation]
> +	for full details.
> +
>  `GIT_REDACT_COOKIES`::
>  	This can be set to a comma-separated list of strings. When a curl trace
>  	is enabled (see `GIT_TRACE_CURL` above), whenever a "Cookies:" header
> -- 
> gitgitgadget
