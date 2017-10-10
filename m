Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB0B20372
	for <e@80x24.org>; Tue, 10 Oct 2017 01:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755764AbdJJBfy (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 21:35:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35138 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754707AbdJJBfx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 21:35:53 -0400
Received: by mail-pf0-f193.google.com with SMTP id i23so31605914pfi.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 18:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s5xX0peV3smw7Urm/S4BhRjSTb4hl2nsxaJVdGvWZEc=;
        b=tRBYN4w8IMj+7W2dTAptdFk3ghp6HhZx2JVByRj/7hMPLoiAayLgTJxnbhCsvDAlLS
         C9iNkpQtSSVnJsEAcsxUWO7w0/+fmf074X/pde6PRRkpReJDvFEK+4oTNZvWw7qLXMAg
         rvvyP5WFxKyaNc2VbxqJb5+v52bmbvJOW9Jt+PM0U7yXc0h3RVbuSIwAE2XM/P5VoZOD
         oH4cujdhaf65EVj6AGVAY+Iy5IySRYXRVKiq31jH2LdlDSmdHRwaNpseuIQjoS/YYjxH
         ieqRNxQcCLXwLcHyGFh66hwiGPHI86ps0r+/LR8pNH/u5zALP+s33fEvJJsZY02rPT3H
         ryyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s5xX0peV3smw7Urm/S4BhRjSTb4hl2nsxaJVdGvWZEc=;
        b=IK+e/uaMo+DBplU6sW+u2cUCrgC0SLhUNdXor5+4jbjbarWatLprRlbVV3MxjrqXAD
         +CWoTiJqYtqr5sVXmeK+94mQ1afo209E8X9z5h61CYs2sxsGIvolsJIA80SC4Obt8AgM
         //p+w5iDrq+K+63rt9zAPcLYVVnG4wZSS3lDDCrCoUWp3kuh3Uf+dch6DCYGXcnXCKdr
         Qf5PGi4P/7ql9NlMM9JRzLotL4LtLu7ZbWJaJHz7CykCq56xswuujlZCVZDoFZIYkccQ
         g2Dn/sayo3uc42GGAU9pHAqpOQX9yRkOnJ5QmcqTKdxY/9NG0cHiblaWc6ie2Hg7tcyx
         9/yA==
X-Gm-Message-State: AMCzsaXiFhjXu9K6nLH/6N5/2yIR+WCMRl1yESYUQQB7mTSwRoXifdFl
        cT6bxE4sOyuyZo9BUNJJOiI=
X-Google-Smtp-Source: AOwi7QBarB7DyWXcrIXSvJKollna9MqOlcFGoSsM1rHXpGJNilfPV3mhFXf+TzW1cTjVtVWSvmjyag==
X-Received: by 10.84.235.9 with SMTP id o9mr10309832plk.8.1507599352726;
        Mon, 09 Oct 2017 18:35:52 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id z8sm17658993pfg.23.2017.10.09.18.35.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 18:35:52 -0700 (PDT)
Date:   Mon, 9 Oct 2017 18:35:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 08/24] refs: convert read_ref and read_ref_full to
 object_id
Message-ID: <20171010013550.GP19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-9-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-9-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> All but two of the call sites already had parameters using the hash

nit: "already have", since commit messages use the present for the
state of the codebase without the patch applied.

> parameter of struct object_id, so convert them to take a pointer to the
> struct directly.  Also convert refs_read_refs_full, the underlying
> implementation.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/checkout.c     |  6 +++---
>  builtin/remote.c       |  2 +-
>  builtin/replace.c      |  4 ++--
>  builtin/show-ref.c     |  2 +-
>  builtin/tag.c          |  4 ++--
>  builtin/update-index.c |  6 +++---
>  bundle.c               |  2 +-
>  fast-import.c          |  2 +-
>  notes-cache.c          |  2 +-
>  notes-merge.c          |  2 +-
>  notes-utils.c          |  2 +-
>  notes.c                |  2 +-
>  refs.c                 | 20 ++++++++++----------
>  refs.h                 |  6 +++---
>  refs/files-backend.c   | 16 ++++++++--------
>  remote-testsvn.c       |  2 +-
>  remote.c               |  6 +++---
>  sequencer.c            |  2 +-
>  transport-helper.c     |  5 ++---
>  19 files changed, 46 insertions(+), 47 deletions(-)
[...]
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -379,7 +379,7 @@ static int checkout_paths(const struct checkout_opts *opts,
>  	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
>  		die(_("unable to write new index file"));
>  
> -	read_ref_full("HEAD", 0, rev.hash, NULL);
> +	read_ref_full("HEAD", 0, &rev, NULL);

Yep, this is nicer (and likewise for the rest of them).

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
