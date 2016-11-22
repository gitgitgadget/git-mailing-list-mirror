Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3F8F1F4CF
	for <e@80x24.org>; Tue, 22 Nov 2016 00:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753620AbcKVAJs (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 19:09:48 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36267 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbcKVAJr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 19:09:47 -0500
Received: by mail-pf0-f181.google.com with SMTP id 189so351513pfz.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 16:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gcVgl9Itq2FWwERYQyuip5Uaz7R+fA9OoxzAujFrF9s=;
        b=eX9kZgp4ULZdjijNOxEgkYp1B7MzDrRrdiiL6g4gpndKLXUWXz4WeyIwPLq81m+tTX
         yqo6sT1bd1eCyqZfa7v+mL+YnDwv2UJq1ZkDjMu2T3NEIsIuakw2f3Iz4KK9VBsL9WNp
         N+gKXPrWf4cNJaIw66NF4iCSY9RO1GzXfKjYVMfsoP/nWXrItAqa2jaTcBVepJN9lN9s
         Ol1sJoHlb2Cz0Z6S2w5WRiFXS4jbKK61OZZ3pAgRN1ipYsOgXq/avEC/Vj8lFwBneaUN
         27+BKjh9U/Py//FBHJq7mJdKNmml9BMAnro2MByRi8TECEtelBpLcLwwcnHTZvo6YEOT
         LYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gcVgl9Itq2FWwERYQyuip5Uaz7R+fA9OoxzAujFrF9s=;
        b=JGPR5D62w3pr6HjPU/rnKaELvr9052pu74Z/cdyPQ5EPZJn3JNmDYW+tnWKY0hBnoU
         xfSEsZiu6KAVDk4QT49Z3AnDDj+HwKCUh6U1iWEDtpIJLgLw1SLJYlscoiWpeF8q/jWG
         /NVgYA+LhntHLoJ8QhWeSsZ4TWrNIjeJgSe1QlaZ7GU+qZmY/thITsAihyh3cH9GfGnj
         wmXg6/Q/G7CKwyHVCpBsJfcDk0XpluckFiLlsaLkYKHLbpABqzybKOCsj4mEZRocKJwg
         /5TcPljEe6Bl48AKn6vnZ3jZPC07PAFIjAqZ0l1gVp1s9h0MvEAryBIpg6r/iq/6Q9ui
         iHAA==
X-Gm-Message-State: AKaTC011VyNYsaSh6TRamSTLjmdAzwBBDchcYZa3b8OFPHi3TFo6NebtupiJ2EO3FDBpdEyx
X-Received: by 10.99.149.22 with SMTP id p22mr38024918pgd.21.1479773386835;
        Mon, 21 Nov 2016 16:09:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:9837:5b20:fc2:14ed])
        by smtp.gmail.com with ESMTPSA id b64sm39992126pfc.74.2016.11.21.16.09.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 16:09:46 -0800 (PST)
Date:   Mon, 21 Nov 2016 16:09:44 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com
Subject: Re: [PATCHv2 3/3] submodule-config: clarify parsing of null_sha1
 element
Message-ID: <20161122000944.GC149321@google.com>
References: <20161121232709.8906-1-sbeller@google.com>
 <20161121232709.8906-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161121232709.8906-4-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/technical/api-submodule-config.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
> index 768458580f..a91c1f085e 100644
> --- a/Documentation/technical/api-submodule-config.txt
> +++ b/Documentation/technical/api-submodule-config.txt
> @@ -55,8 +55,11 @@ Functions
>  
>  	The same as above but lookup by name.
>  
> -If given the null_sha1 as commit_or_tree the local configuration of a
> -submodule will be returned (e.g. consolidated values from local git
> +Whenever a submodule configuration is parsed in `parse_submodule_config_option`
> +via e.g. `gitmodules_config()`, it will be overwrite the entry with the sha1

s/will be overwrite/will overwrite

> +zeroed out.  So in the normal case, when HEAD:.gitmodules is parsed first and
> +then overlayed with the repository configuration, the null_sha1 entry contains
> +the local configuration of a submodule (e.g. consolidated values from local git
>  configuration and the .gitmodules file in the worktree).
>  
>  For an example usage see test-submodule-config.c.
> -- 
> 2.11.0.rc2.18.g0126045.dirty
> 

-- 
Brandon Williams
