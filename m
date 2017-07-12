Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BCB0202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 17:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754056AbdGLRa1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 13:30:27 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36231 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753913AbdGLRa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 13:30:27 -0400
Received: by mail-pf0-f181.google.com with SMTP id q86so16166635pfl.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ztng5/7cbvHLsaehEMr4b3Fa4Mhhv/QmBv6CmzTjL0o=;
        b=GkcpJWsyTr466/0WtfRr34LRTy7Hjj4CbIQR6D6tpvV2WDd3gMimU6I1KPivvZAYg7
         kU3v7S9YjlwcYVFzVn+AH/9z/T2r04Jp2XpkKsxhWhxeFU4vAON6QLyQIoyLz4nIFOxH
         4cJzTuAbTnzosD199YGI6KTBpO/6qivI1eZ9Iig/rfeIIKC782rvFlsLZl2qzP5Zg2IX
         NlhwAT5zit19eQsfNqMf8hJZ+EEKc25lsYTHLQSZgJ7AH3ITwbpJaDpLbYQq5QALpETo
         Dg9rh9QfUwmi6R/AUjNLlmRvszG1S+aEIUKhCwFSBbYagKH0zVpriXKul1gu/jwIOzsN
         9qCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ztng5/7cbvHLsaehEMr4b3Fa4Mhhv/QmBv6CmzTjL0o=;
        b=HOI2DTDg/9UxZ2ylZw9sHoL/HJ0X1bA9SZCpO1qKHzfD4oFv0r5kZd92MnEMcQ+fOF
         cp0c+AnqwOLJacK+ITd3Geu8USWUK8pyOny7sKCVN7uPGilo1ObXInFqYUbT0Rq9YL/y
         zgRgBz2sGY0wtNg1fEBRCftYjSIz+7fEle5qBahVUGAgDrbM4sDcc7EOGAXVz26nElbO
         7UBgA4fLBneqLrvThWzeqTOUwrrvxm0yCiroxmRgG+wPFX9Ysx7C/SH6+V1cYK8U+IrV
         VwT/tE6wUAIBNNwj2F3kCbKuubROfcLIFeJLRRhePG+cAuPk4e/zK932bGwo0jKj48Hb
         qFvA==
X-Gm-Message-State: AIVw113enpYk1VQO4iTjAqK5d3MA4ulya4dB+oWhXMiuuamoDBV++ltP
        F7HcruxYrgexPAq8
X-Received: by 10.99.123.28 with SMTP id w28mr4957074pgc.183.1499880626163;
        Wed, 12 Jul 2017 10:30:26 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3d1f:bb9:8897:56b4])
        by smtp.gmail.com with ESMTPSA id n90sm7172806pfk.105.2017.07.12.10.30.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 10:30:24 -0700 (PDT)
Date:   Wed, 12 Jul 2017 10:30:23 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 2/3] setup: have the_repository use the_index
Message-ID: <20170712173023.GC65927@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170711220408.173269-3-bmwill@google.com>
 <20170712000042.GC93855@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712000042.GC93855@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > Have the index state which is stored in 'the_repository' be a pointer to
> > the in-core instead 'the_index'.  This makes it easier to begin
> > transitioning more parts of the code base to operate on a 'struct
> > repository'.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  setup.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/setup.c b/setup.c
> > index 860507e1f..b370bf3c1 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -1123,6 +1123,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
> >  			setup_git_env();
> >  		}
> >  	}
> > +	the_repository->index = &the_index;
> 
> I wonder if this can be done sooner.  For example, does the following
> work?  This way, 'the_repository->index == &the_index' would be an
> invariant that always holds, even in the early setup stage before
> setup_git_directory_gently has run completely.
> 
> Thanks,
> Jonathan
> 
> diff --git i/repository.c w/repository.c
> index edca907404..bdc1f93282 100644
> --- i/repository.c
> +++ w/repository.c
> @@ -4,7 +4,7 @@
>  #include "submodule-config.h"
>  
>  /* The main repository */
> -static struct repository the_repo;
> +static struct repository the_repo = { .index = &the_index };
>  struct repository *the_repository = &the_repo;
>  
>  static char *git_path_from_env(const char *envvar, const char *git_dir,

I agree with your approach, though as stefan pointed out we may not be
able to use the syntax just yet...but we should still be able to use the
bulky old syntax for the time being.

-- 
Brandon Williams
