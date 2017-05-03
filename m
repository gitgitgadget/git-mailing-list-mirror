Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95CDA1F829
	for <e@80x24.org>; Wed,  3 May 2017 17:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbdECRH3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 13:07:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35879 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbdECRHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 13:07:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id v14so5094647pfd.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MgSx1YvCroRTokNcwd3fawrShPhSz+7pPUWyf+B+t4U=;
        b=KJFP2w66YeJBDPqsFtW8CLpQgQR/4rUyuTi9R2aacMe+huap9lZ+i/DMN4VvhBSnS1
         83z0+ZDwFKOtrb4BT+wqYCAEXKP6abo8Jw4NN7W8nEzoS91vm3cknh9W84rA5zQzl49t
         kmcqnYxBySEtXoYKUwvgvdI1nxLmCbvtja/xGDGnL1u4G5PkX4z/zjva1AMGFlxttbk0
         9MGf35FX7ew7fKHw9xTOrbeUHY+6z+dWTJGSONhJEgJzGsI3XFK5FcjjU/4vVGV2YQAk
         GPd2X/GIJ4JYvCrWR3nWd42jOyGH/rnyuThv3NECzoAq/anzj1raVBb7HbU0bIgglt8g
         CR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MgSx1YvCroRTokNcwd3fawrShPhSz+7pPUWyf+B+t4U=;
        b=FRi9hEjKgul5bFMzXK2j6roXH/HEbMtKCyt8SZKVi1P/LR5u2tQ8GVUX70DiOKrB/t
         0WGZDVyuReCS7VGKiHKWXFUizWU2Fag3KRlY4DJb382Ms5Zxs+Qy2e61hwZoG2uYme9w
         f2Rjsf3SWLN5f61E7M1rpvi8zP2bdgVdpMU+eP5P+d26XKQjKWmijw52OxCouGwMY6xq
         WCGFzoIxDXMIMO4Mquxmr/8gsulIwOJH9NSZouTVymAWI+uk/52DYG6fv01TUnmyMD84
         ciNYRt8ZcgCJtLGP2ZwW4kgsJH4yryuOihIpI1pNLD3X3SX2I3jN/YJ8pYMHn0EH/Tec
         Sxjw==
X-Gm-Message-State: AN3rC/6iOUYCkSWobt0w+4gebQDGLrlV/hZ9trNkBJevEu0du5yr7BU2
        tLhPhwjSYbkihCdmEmQ=
X-Received: by 10.84.179.65 with SMTP id a59mr48609093plc.171.1493831241460;
        Wed, 03 May 2017 10:07:21 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:8ce6:bd0b:35b6:826c])
        by smtp.gmail.com with ESMTPSA id u85sm5676270pfg.64.2017.05.03.10.07.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 10:07:21 -0700 (PDT)
Date:   Wed, 3 May 2017 10:07:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] git-filter-branch: be assertative on dying message
Message-ID: <20170503170719.GB28740@aiede.svl.corp.google.com>
References: <20170503162931.30721-1-jn.avila@free.fr>
 <20170503162931.30721-4-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170503162931.30721-4-jn.avila@free.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jean-Noel Avila wrote:

> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>

As with the previous patches, this is a good place to put the motivation
for the patch.

> ---
>  git-filter-branch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 2b8cdba15..dd3a605d0 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -239,7 +239,7 @@ git rev-parse --no-flags --revs-only --symbolic-full-name \
>  sed -e '/^^/d' "$tempdir"/raw-heads >"$tempdir"/heads
>  
>  test -s "$tempdir"/heads ||
> -	die "Which ref do you want to rewrite?"
> +	die "You must specify a ref to rewrite"

I find both the old and the new messages pretty uncompelling.  The user
got the usage wrong but we don't know what they were trying to do ---
e.g. maybe they specified the ref to rewrite but in the wrong place.

Would e.g. a simple call to 'usage' work?

Thanks,
Jonathan
