Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E011121847
	for <e@80x24.org>; Tue,  1 May 2018 22:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeEAWgZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 18:36:25 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40410 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeEAWgW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 18:36:22 -0400
Received: by mail-pg0-f67.google.com with SMTP id l2-v6so9168264pgc.7
        for <git@vger.kernel.org>; Tue, 01 May 2018 15:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZLgMe4C2nebjdcUyCTietuXCXNOohCyWuIpKNvscStQ=;
        b=MKLsJJSGhekOSTBHVTcLsxVyvYmoOn/yWBsr1L3flWnCSfkpl6LTLikPEqE3MafWLj
         gn00LlpZcR+toneqlPlH1QAHCiB2Et93UUJ2vKeeY6DiV3Ztf+A4BrPvumR+kS1EXXqE
         jqBZv1Qc4eEWXoeE/A0YXuu+YbOiR78OFN4Kndu/obVjbOEq3TOdJPZ7sXRYC7JTx4SX
         m9KZLPKsqvMH43lriNr3EzCS2yamLaX10i8S78rVIEf+kEl4AGU2GdqXrlF9lpH4ojK2
         chvVtNFcuHaRLdctf+kP8iD2FQkTw6VaNfccVh3Y4ZvmrQYHc2vD6S2LGQBt3Lt1fqS5
         p7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZLgMe4C2nebjdcUyCTietuXCXNOohCyWuIpKNvscStQ=;
        b=P/LY2i49TLmfDOuOCaoJ2FYCbH7iAjYW+Cl87eehFlvnt+JdjLIh7x8MU88kJ0y4eh
         52zDu3w1kU2v8KQrWLthprV16/5HlBmM+iQkQ4XXVDl8AnMMaFpxpZwUTQY0e43t4Vxl
         Cr7vcq/derGhT3oMGSyJit2DtE7ViVgBe55i/jiaYWThtbaGfoBq+zGJHsmGjgeVqTlC
         01CNZ4OwZIkUMvx39S0sNxKvTBNanPW1q+vvQpPzJZOJvV5Na15JrjuqOTOIz8eJI1rs
         WlrksRDsuXbVWmZBObltK7pHUs60dMh3rJAW14STPcekrG+/0z087asb+p53veLczi/2
         GIgg==
X-Gm-Message-State: ALQs6tCBUxUp1zZg3D/R4dAs3Zy17VNKduuBP7vziglo7LkGI5b0P6eP
        2Z60bD2Ol9c4I9wwM0GxHxzSHA==
X-Google-Smtp-Source: AB8JxZpBoBzuFW87oljV25DtJ42pQcWk0teL/iutJete/jo3MtpuiI/q6m/hzfAkNy1WMqXcwnh6iA==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9-v6mr17921516plb.100.1525214181243;
        Tue, 01 May 2018 15:36:21 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id d4sm21708674pfl.24.2018.05.01.15.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 15:36:20 -0700 (PDT)
Date:   Tue, 1 May 2018 15:36:19 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] {fetch,upload}-pack: support filter in protocol v2
Message-ID: <20180501223619.GA122314@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
 <0486dfdfe614f908b322552b02ebbb3f1f6cd6fc.1525213052.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0486dfdfe614f908b322552b02ebbb3f1f6cd6fc.1525213052.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, Jonathan Tan wrote:
> The fetch-pack/upload-pack protocol v2 was developed independently of
> the filter parameter (used in partial fetches), thus it did not include
> support for it. Add support for the filter parameter.
> 
> Like in the legacy protocol, the server advertises and supports "filter"
> only if uploadpack.allowfilter is configured.
> 
> Like in the legacy protocol, the client continues with a warning if
> "--filter" is specified, but the server does not advertise it.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/technical/protocol-v2.txt |  9 +++
>  fetch-pack.c                            | 23 +++++-
>  t/t5702-protocol-v2.sh                  | 97 +++++++++++++++++++++++++
>  upload-pack.c                           | 12 ++-
>  4 files changed, 135 insertions(+), 6 deletions(-)
> 

> @@ -1428,7 +1434,9 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
>  int upload_pack_advertise(struct repository *r,
>  			  struct strbuf *value)
>  {
> -	if (value)
> -		strbuf_addstr(value, "shallow");
> +	git_config(upload_pack_config, NULL);
> +	if (value) {
> +		strbuf_addf(value, "%sshallow", allow_filter ? "filter " : "");
> +	}

This is a bit difficult to read and there is no reason why we would need
to read the entire upload_pack_config to determine if we need to filter
things (we will need to read the config if cmd "fetch" is requested
though).  Instead it may be better to do the following:

  if (value) {
    strbuf_addstr(value, "shallow");
    if (repo_config_get(r, "uplaodpack.filter"))
      strbuf_addstr(value, " filter");
  }

This way its easier to read and you only are reading the required value
from the config.

>  	return 1;
>  }
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 

-- 
Brandon Williams
