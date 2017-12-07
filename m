Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F017820954
	for <e@80x24.org>; Thu,  7 Dec 2017 19:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbdLGToT (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:44:19 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36032 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdLGToT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:44:19 -0500
Received: by mail-it0-f68.google.com with SMTP id d16so17076346itj.1
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 11:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6bfcTy/iWLxgMfBEGP0/XXbjX50IF1hXCLIouiASe9A=;
        b=WyhpD169nJVlNeSA6xiKmgHypuXhmsrnDB87JnA9Rwc/vXC7MLSGcb+pQhUZY5jDUe
         WYNggkaefahIoFAvrWGa63CwHLkWNPHyTbzjS0ql870cEBqtx1pv2EIP+RVpbJW+ZbQZ
         Q6rtRo0q22veirIjKKqJq6/br6zkrPqpCOUmDYAqaugNCu6Lm60KATWywMCHhFjK8zE9
         JnosRepOqQQafglk/sbxxjLHJ4cFLfmGoifQoWrLLNksH102eA59IEZpcEX9arv07zWj
         DHFQwDB6IK7XAQoTUUH20uO4tgYMqWFfST9NdQOI98xquC1XFOv7ufwqfBlKjRKr8nR+
         qUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6bfcTy/iWLxgMfBEGP0/XXbjX50IF1hXCLIouiASe9A=;
        b=VAXNfIthq5Rp1nsqb09fU1Qaxg0Foz5rcKxZ3R8u4WivEKJRb/LEoV43He2CE+hjEt
         X83NDniNM7NYcXOYxx13wbg5SXVi+BK/nNlCMaXKuARm2ttDQT1uiP1quqGxC85zHypX
         Tbl4vQ76/u8iTujniUQV7a5QM6Vkyy3k7ZkXEfki4/TCfV7k7VBFsNVlJ9XZXwty0Gq/
         OTb8id/fnslOxGuTnuV3BhNqHAc02s2tG7h14BdWJuPyOn7D8JK8HJ/lT4gJd8B/tjgc
         laIHz44l6+m6JuwFgYz/FH8GCtTfQFj+TrgQs9aecmIAZVzO5Vjo8L1SR1ruuQ1uHoMG
         hZyQ==
X-Gm-Message-State: AKGB3mIwePZBh5+2J3YOX6DCSDIpH7GjZBQe0sHEdPSxC6ipZLvxsVib
        35uSpkvuXDMueA5gCm8Nk7KLLA==
X-Google-Smtp-Source: AGs4zMYyvyvFTU83ktl0tM7asjHs/8evlOvND/hwJ0LZu+F44L+EE3USz1vvjzgwncAEzPnTRAheqw==
X-Received: by 10.107.202.3 with SMTP id a3mr7152362iog.260.1512675858156;
        Thu, 07 Dec 2017 11:44:18 -0800 (PST)
Received: from google.com ([2620:0:100e:422:949a:89bd:af08:7a9c])
        by smtp.gmail.com with ESMTPSA id y21sm2761504ioi.14.2017.12.07.11.44.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 11:44:17 -0800 (PST)
Date:   Thu, 7 Dec 2017 11:44:15 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jonathantanmy@google.com, christian.couder@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 09/12] fixup: sha1_file: convert gotos to
 break/continue
Message-ID: <20171207194415.GE152943@google.com>
References: <20171205165854.64979-1-git@jeffhostetler.com>
 <20171205165854.64979-10-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205165854.64979-10-git@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Jeff Hostetler wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 

I'm a fan of eliminating looping goto statements.  I understand their
need for doing cleanup, but I think they should be reserved for that
specific case.  Thanks for cleaning this up!

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  sha1_file.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index fc7718a..ce67f27 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1180,30 +1180,30 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>  		}
>  	}
>  
> -retry:
> -	if (find_pack_entry(real, &e))
> -		goto found_packed;
> +	while (1) {
> +		if (find_pack_entry(real, &e))
> +			break;
>  
> -	/* Most likely it's a loose object. */
> -	if (!sha1_loose_object_info(real, oi, flags))
> -		return 0;
> +		/* Most likely it's a loose object. */
> +		if (!sha1_loose_object_info(real, oi, flags))
> +			return 0;
>  
> -	/* Not a loose object; someone else may have just packed it. */
> -	reprepare_packed_git();
> -	if (find_pack_entry(real, &e))
> -		goto found_packed;
> -
> -	/* Check if it is a missing object */
> -	if (fetch_if_missing && repository_format_partial_clone &&
> -	    !already_retried) {
> -		fetch_object(repository_format_partial_clone, real);
> -		already_retried = 1;
> -		goto retry;
> -	}
> +		/* Not a loose object; someone else may have just packed it. */
> +		reprepare_packed_git();
> +		if (find_pack_entry(real, &e))
> +			break;
>  
> -	return -1;
> +		/* Check if it is a missing object */
> +		if (fetch_if_missing && repository_format_partial_clone &&
> +		    !already_retried) {
> +			fetch_object(repository_format_partial_clone, real);
> +			already_retried = 1;
> +			continue;
> +		}
> +
> +		return -1;
> +	}
>  
> -found_packed:
>  	if (oi == &blank_oi)
>  		/*
>  		 * We know that the caller doesn't actually need the
> -- 
> 2.9.3
> 

-- 
Brandon Williams
