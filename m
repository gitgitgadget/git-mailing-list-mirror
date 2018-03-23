Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EAD61F404
	for <e@80x24.org>; Fri, 23 Mar 2018 20:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeCWUPQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 16:15:16 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:45229 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbeCWUPP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 16:15:15 -0400
Received: by mail-pf0-f178.google.com with SMTP id l27so5144467pfk.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Pya9Y8GOn0okQLaKCLPECdKBfn+Mr+DkEy00xAfES08=;
        b=JRmGsW2VP//i4VRr/sp1UvrMkmVN1KHYZlrCDnHKpFtliTRmHzj/nFcGtt4lJPTHfv
         R8Y/UbUY9EbXAah4Em8so3K/j9EyyevOSY8C4Ae5Y6VY3vGCZlqAiyHIng8lenjHTcwM
         x1LJmsmqhF3+xwCrYZyAx7jx+41G/5FT12RS30C7/RsF9aF6pMcNTq/kFD2nAQl7r3mo
         UFIriyC+8GvpDdbKUa9od3VDNoYcM2NG0e5+hIrV6OC/xQu/MPnBcdcNkvgL2Fg97h5c
         Lup/IVc2H7tkP9a8EJcIthLCvrZL4UC4dIKZN5yU90xnEu57WShXhW+DGkC5Wc0aYTec
         Mgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Pya9Y8GOn0okQLaKCLPECdKBfn+Mr+DkEy00xAfES08=;
        b=ew8im3k0hmrvc46m2MJ1gdU2oHgGrnellDTTLY/Iv+WLyDXCvQgf5RG+GOmDcZnK18
         g0ajQL0jHzRO865eVhA3BCgGQ2xJQP1DFNlK9Ap/7iLjyICyFGRLlHyDIsXCJAfizd5M
         Xj7KkXgFAa6VoKtfRwedkEOxIb/0nXHwO1EJaqaB/+c9LFHEUW3tx7IxynzmdvnHSj8k
         v3IwRTYLsfY5fNqRtrpKoJxUI0jNjgigO7CezNNE8m1tmD+fNL/+Pr1B3LvXJ8Sa+kQ5
         4NmYnYspQZH9gQu79RGBHQacb2t0icD4Y8Y3p3FNBCSAk9BK7emr/fZmn9C+aXUvWAww
         ZNMA==
X-Gm-Message-State: AElRT7EJR9hjZCUnU7kYjbfejH5k5P/oog9FPYmgO04RY1D/k7gMFgkd
        nVuxO+LoOXPAjOkLwxioTwsITA==
X-Google-Smtp-Source: AG47ELsuUD7zS49VvvVSedbDPtVWSaAF47zipJzJwYUma5RCN4Q0imSXGdbjreh/nLplFWzn4F9mvg==
X-Received: by 10.101.69.4 with SMTP id n4mr19800578pgq.101.1521836114817;
        Fri, 23 Mar 2018 13:15:14 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id m13sm16399753pgs.25.2018.03.23.13.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 13:15:13 -0700 (PDT)
Date:   Fri, 23 Mar 2018 13:15:12 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/12] sb/packfiles-in-repository updates
Message-ID: <20180323201512.GE243756@google.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323174527.30337-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180323174527.30337-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/23, Nguyễn Thái Ngọc Duy wrote:
> This is the rebased version on the updated sb/object-store I just sent
> out plus the fix for get_object_directory(). The interdiff (after
> rebased) looks small and nice

Nice! Thanks for fixing that.  This series looks good to me :)

> 
> diff --git a/packfile.c b/packfile.c
> index e02136bebb..63c89ee31a 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -890,7 +890,7 @@ static void prepare_packed_git(struct repository *r)
>  
>  	if (r->objects->packed_git_initialized)
>  		return;
> -	prepare_packed_git_one(r, get_object_directory(), 1);
> +	prepare_packed_git_one(r, r->objects->objectdir, 1);
>  	prepare_alt_odb(r);
>  	for (alt = r->objects->alt_odb_list; alt; alt = alt->next)
>  		prepare_packed_git_one(r, alt->path, 0);
> 
> I notice there's still one get_object_directory() left in packfile.c
> but that should not cause problems with converted functions. That
> could be done in "phase 2".
> 
> Nguyễn Thái Ngọc Duy (1):
>   packfile: keep prepare_packed_git() private
> 
> Stefan Beller (11):
>   packfile: allow prepare_packed_git_mru to handle arbitrary
>     repositories
>   packfile: allow rearrange_packed_git to handle arbitrary repositories
>   packfile: allow install_packed_git to handle arbitrary repositories
>   packfile: add repository argument to prepare_packed_git_one
>   packfile: add repository argument to prepare_packed_git
>   packfile: add repository argument to reprepare_packed_git
>   packfile: allow prepare_packed_git_one to handle arbitrary
>     repositories
>   packfile: allow prepare_packed_git to handle arbitrary repositories
>   packfile: allow reprepare_packed_git to handle arbitrary repositories
>   packfile: add repository argument to find_pack_entry
>   packfile: allow find_pack_entry to handle arbitrary repositories
> 
>  builtin/count-objects.c  |  3 +-
>  builtin/fsck.c           |  2 --
>  builtin/gc.c             |  3 +-
>  builtin/pack-objects.c   |  1 -
>  builtin/pack-redundant.c |  2 --
>  builtin/receive-pack.c   |  3 +-
>  bulk-checkin.c           |  3 +-
>  fast-import.c            |  3 +-
>  fetch-pack.c             |  3 +-
>  http-backend.c           |  1 -
>  http.c                   |  2 +-
>  pack-bitmap.c            |  1 -
>  packfile.c               | 76 +++++++++++++++++++---------------------
>  packfile.h               | 11 +++---
>  server-info.c            |  1 -
>  sha1_file.c              |  8 ++---
>  sha1_name.c              |  2 --
>  17 files changed, 58 insertions(+), 67 deletions(-)
> 
> -- 
> 2.17.0.rc0.348.gd5a49e0b6f
> 

-- 
Brandon Williams
