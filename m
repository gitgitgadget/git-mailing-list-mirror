Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2DDC1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 00:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeJPIVJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 04:21:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39537 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeJPIVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 04:21:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so9950545pgv.6
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 17:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jizutCnf35J3dAZrVeKu0UlmusivEbewvEFhVWx5aZM=;
        b=Yp6X3i+HwAujaN2sBWSt7TsEfKs0zYT4aYgBCKSRRjY37VS0etss5a6G/RpKHlhWRu
         GL+PA2k1ed+vzkr108XkpNz2kxvm1KKjNv2oG/vmiRzpSl0eJDu4894yw8YZjmrhFK9Q
         biUmGdI9TxO849m5+qnyFUxUAWrHNJ3XGCN43GatI7i39i+ctX2g0dQwMyxcQ+U4D46/
         U9e/5n2oH/xgKHTqOd/fAsLFlEmdbb0mHNFGXsfqWfSgPzT7z9tEI+tjL6plRUs6kj+W
         eYbs7oVz3mn/gamZw7uYKHwaButcuf11Wnd3OXnAQ06Tdz3NlSC4iM320QHZdZa6tVF8
         CIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jizutCnf35J3dAZrVeKu0UlmusivEbewvEFhVWx5aZM=;
        b=bfIfzfcynrjzOc5qzTdWfXFYnz63UUHFqXyB4g7gid6QuonUCwJ3pQjeF8p2oqt02I
         cnomLSMCMXv8piF8Kmctr7/dmX+HnHDY6e0wb25NCnDiMcJgH5+0UqV1fqX0whDrlaEG
         WCdXDzUuH++L9XK+f9I4GkqR7u64LfyhA7jazsy+eOO3wcuPFyYMTFTk1VNfXNLBuEUb
         GmF1uByxlb+OU5nooyILIS6LbVPIayvtoOrKjgC9glkNlnfWikVVrwrw/ebM9kArBOt7
         yrdiI82449RoL1imgfFQ5ID+nrhGTKOvqJW/yBYs6EsOgOnMrl1eCR6Kz/BBNpkMaFP7
         pm2Q==
X-Gm-Message-State: ABuFfogDQzjHg+iyKtgBn9clPb0L9QDwiFV13rCgltZmVGgpVz9smmrj
        zphminLTvM4dElOnlKU27c8=
X-Google-Smtp-Source: ACcGV63LI4KGVZFVYjRMNWhIV7uYPuzP9GLxXEQbtGGDHcv4wRfuruGrHO97YxpLR3mAwHm0A+RvBA==
X-Received: by 2002:a63:8742:: with SMTP id i63-v6mr17973169pge.27.1539650007404;
        Mon, 15 Oct 2018 17:33:27 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id f1-v6sm11445850pfg.71.2018.10.15.17.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 17:33:26 -0700 (PDT)
Date:   Mon, 15 Oct 2018 17:33:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jaewoong Jung <jungjw@google.com>
Subject: Re: [PATCH] submodule helper: convert relative URL to absolute URL
 if needed
Message-ID: <20181016003324.GA104911@aiede.svl.corp.google.com>
References: <20181012215314.44266-1-sbeller@google.com>
 <20181016001949.173333-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016001949.173333-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> The submodule helper update_clone called by "git submodule update",
> clones submodules if needed. As submodules used to have the URL indicating
> if they were active, the step to resolve relative URLs was done in the
> "submodule init" step. Nowadays submodules can be configured active without
> calling an explicit init, e.g. via configuring submodule.active.
>
> When trying to obtain submodules that are set active this way, we'll
> fallback to the URL found in the .gitmodules, which may be relative to the
> superproject, but we do not resolve it, yet:
> 
>     git clone https://gerrit.googlesource.com/gerrit
>     cd gerrit && grep url .gitmodules
> 	url = ../plugins/codemirror-editor
> 	...
>     git config submodule.active .
>     git submodule update
> fatal: repository '../plugins/codemirror-editor' does not exist
> fatal: clone of '../plugins/codemirror-editor' into submodule path '/tmp/gerrit/plugins/codemirror-editor' failed
> Failed to clone 'plugins/codemirror-editor'. Retry scheduled
> [...]
> fatal: clone of '../plugins/codemirror-editor' into submodule path '/tmp/gerrit/plugins/codemirror-editor' failed
> Failed to clone 'plugins/codemirror-editor' a second time, aborting
> [...]

Thanks.

"git log" and other tools have the ability to rewrap lines and will get
confused by this transcript.  Can you indent it to unconfuse them?

> Signed-off-by: Stefan Beller <sbeller@google.com>

Please also credit the bug reporter:

Reported-by: Jaewoong Jung <jungjw@google.com>

[...]
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -584,6 +584,27 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +

nit: inconsistent vertical whitespace (extra blank line?)

> +static char *compute_submodule_clone_url(const char *rel_url)
> +{
> +	char *remoteurl, *relurl;
> +	char *remote = get_default_remote();
> +	struct strbuf remotesb = STRBUF_INIT;
> +
> +	strbuf_addf(&remotesb, "remote.%s.url", remote);
> +	free(remote);
> +
> +	if (git_config_get_string(remotesb.buf, &remoteurl)) {
> +		warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
> +		remoteurl = xgetcwd();
> +	}
> +	relurl = relative_url(remoteurl, rel_url, NULL);
> +	strbuf_release(&remotesb);
> +	free(remoteurl);
> +
> +	return relurl;
> +}

I think this would be easier to read with all the release commands
together:

	...

	free(remote);
	free(remoteurl);
	strbuf_release(&remotesb);
	return relurl;

[...]
> @@ -634,21 +655,9 @@ static void init_submodule(const char *path, const char *prefix,
[...]
> -			relurl = relative_url(remoteurl, url, NULL);
> -			strbuf_release(&remotesb);
> -			free(remoteurl);
> -			free(url);
> -			url = relurl;
> +			char *to_free = url;
> +			url = compute_submodule_clone_url(url);
> +			free(to_free);

I still think this would be easier to read with a style that makes
the ownership passing clearer:

			char *oldurl = url;
			url = compute_submodule_clone_url(oldurl);
			free(oldurl);

With whatever subset of the above tweaks makes sense,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
