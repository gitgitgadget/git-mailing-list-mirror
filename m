Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69AF4207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947856AbdDTWHl (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 18:07:41 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33502 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947819AbdDTWHk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:07:40 -0400
Received: by mail-oi0-f53.google.com with SMTP id y11so38152776oie.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8dBUYBPdcBwcM7ayxOmE7xjLlErHoR0lcbnArV3TmWc=;
        b=rhA7B8Ggw4qDIYNN/5DsBdLoOmrq5nTDwAcHkzIhhvNiqz+0HbFDPOwZlj9Fs1x058
         UyuH8PVFs109GQFwkSKCoMKiRCEmfA5fudiM9WJ9Mv/yMEZMbpyKc2sWA9MjYkMS4lsb
         ieL4INftpppQPGdwsqp/8n4Fyv9JuS95XKFKMJNphn1/qwlGdxh/gTZoa6AH6DhUgmGt
         wlkGoxJqY6Bn+X/SDrDPqrWJAgxVq0VYw6Q/wLjhADFl+tokmCN9wP9W1L+7GkfiDRR2
         Eo/Qo06uoBXGDnZe8P/qjDv/aiuO+neSVos74Kkn3OMFO9ibEVtCvAD1XZ4YZWys/9y+
         4VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8dBUYBPdcBwcM7ayxOmE7xjLlErHoR0lcbnArV3TmWc=;
        b=VctLLGwZVGzrqrZXyL2M43dRWueOlqSqb05i674hNPvu83rvuHm8SpF+6ftxbPRDpb
         jY9W4UQoivEv5mzn5wNP0OAVUaSZ9ViTOcxThUbckjPXTrVYOP2zmkifpzRxyTDTefs/
         7d8HOCtnnXVENDaQhlG/8AZeqLLakrEC8DKNmjGYqnDGCBlYPl10WE1DzR5XuwNKBd3A
         j6TwdTJ3hl12RDLOvw8hd0cVtzv5Y5mynFnWJ4KFTlSz9oCNfIJpDlYTBARkSo0tH+Aw
         VPcsXBQnnESTzzvKLJQaBvzH+YtHmC1CQ3S55eyXPIuwOKfLvrZmbRmQVXa5cCa535Td
         nsLg==
X-Gm-Message-State: AN3rC/7qaQukjIn4S5o+cQ5sYCi9TqaWhPwNG7jBWc9ISfADlV5KdakA
        t36ez6qxcsKclq6h
X-Received: by 10.84.222.129 with SMTP id x1mr12341777pls.44.1492726058887;
        Thu, 20 Apr 2017 15:07:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6c7e:3273:2d37:5651])
        by smtp.gmail.com with ESMTPSA id 186sm12152758pfx.72.2017.04.20.15.07.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 15:07:37 -0700 (PDT)
Date:   Thu, 20 Apr 2017 15:07:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     maxime.viargues@serato.com, git@vger.kernel.org
Subject: Re: [PATCH 1/2] submodule.c: add has_submodules to check if we have
 any submodules
Message-ID: <20170420220736.GH142567@google.com>
References: <20170411194616.4963-1-sbeller@google.com>
 <20170411194616.4963-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411194616.4963-2-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Stefan Beller wrote:
> +int has_submodules(unsigned what_to_check)
> +{
> +	if (what_to_check & SUBMODULE_CHECK_ANY_CONFIG) {
> +		if (submodule_config_reading == SUBMODULE_CONFIG_NOT_READ)
> +			load_submodule_config();
> +		if (submodule_config_reading == SUBMODULE_CONFIG_EXISTS)
> +			return 1;
> +	}
> +
> +	if ((what_to_check & SUBMODULE_CHECK_ABSORBED_GIT_DIRS) &&
> +	    file_exists(git_path("modules")))
> +		return 1;
> +
> +	if ((what_to_check & SUBMODULE_CHECK_GITMODULES_IN_WT) &&
> +	    (!is_bare_repository() && file_exists(".gitmodules")))
> +		return 1;
> +
> +	if (what_to_check & SUBMODULE_CHECK_GITLINKS_IN_TREE) {
> +		int i;
> +
> +		if (read_cache() < 0)
> +			die(_("index file corrupt"));
> +
> +		for (i = 0; i < active_nr; i++)
> +			if (S_ISGITLINK(active_cache[i]->ce_mode))
> +				return 1;
> +	}
> +
> +	return 0;
> +}

It may be a good idea to rearrange these by order to correctness.
Correctness may not be the best way to describe it, but which is the
strongest indicator that there is a submodule or that a repo 'has a
submodule'.  That way in the future we could have a #define that is
SUBMODULE_CHECK_ANY or ALL or something....Now that I'm thinking harder
about that we may not want that, and just require explicitly stating
which check you want done.

Anyways good looking patch, and I like the idea of consolidating the
checks into a single function.

> diff --git a/submodule.h b/submodule.h
> index 8a8bc49dc9..5ec72fbb16 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -1,6 +1,12 @@
>  #ifndef SUBMODULE_H
>  #define SUBMODULE_H
>  
> +#define SUBMODULE_CHECK_ANY_CONFIG		(1<<0)
> +#define SUBMODULE_CHECK_ABSORBED_GIT_DIRS	(1<<1)
> +#define SUBMODULE_CHECK_GITMODULES_IN_WT	(1<<2)
> +#define SUBMODULE_CHECK_GITLINKS_IN_TREE 	(1<<3)
> +int has_submodules(unsigned what_to_check);

-- 
Brandon Williams
