Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD8A1F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 18:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdKHSJh (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 13:09:37 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:56959 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbdKHSJh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 13:09:37 -0500
Received: by mail-it0-f42.google.com with SMTP id r127so7546419itb.5
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 10:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/XuU0Wn6oS4gNCSRWsT/X9iZvzWCbiP43DPk+rXVMrc=;
        b=elg3oTtZSPvyfToB2bWGVfNAiUT85GpH73QlzF2hBvEopoXfNseoel8YV4QNSA8eYr
         /2SdbWU5aEWGucN0mBEZvEPjko8tQsOu1VmnHioZLslRtAwVrW2DaFdYgNApkjwtb1xc
         K0O1DaRXrSoY5gqMXtRd19pBfOHgWsz9iHnk2f/C6VSng2gXR0Ewv3J8MVyGBBBBaFYO
         u0e0LgcqBSZGX1W98FlIRuf+nWjS+PcA0j1pbLk0tPH38N0ejGqQ+SwEh4QSviRL5kHo
         1vygwTalcq2DoiRV6xrHELg82pyGKIcC/+sqZf06gh0UFzI9zKpUpvqkD547VCxRgTJj
         9QCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/XuU0Wn6oS4gNCSRWsT/X9iZvzWCbiP43DPk+rXVMrc=;
        b=iwZqHNRdF/HdXeNut+0s5QJFrsac20vG82cqW2V5nY6Do4i84fxjsV8h5dn78D3+ti
         pqYXZTeLl7nlyVUuSSzsjxwEZY+TgFEJJ7aKpIJ4X1eqpuAeKVn4mnjloGn+SLA44i5m
         eTe+Ge4HFD4Fp+uuOUcNwfwUY/d7GlAcDprCWQCuWGHYZhzN7lAp6oCuOarD2yPUVRfS
         yE8ow+t2xYMVDqmDve4uGjIsGVmAK5Kj+t/gUFY6LUenN5cIQll9VKNzFqXnhUMr0kBc
         Bo+G7T5pd6EFMNulYX7R228ga5sVy8wJKtCPWL2NIfLotGM9A8xnURmv0RHmQODxSZUU
         wOpQ==
X-Gm-Message-State: AJaThX6PoH6gxI28wvbpBYZ1haOG+SN6Ikf98nT64UiyYWsgXUqxY3rU
        j/WMQ4pUpcROsRxrll1+38c64g==
X-Google-Smtp-Source: ABhQp+Rc7XQWubePWzvrfPEefaBDudmj4E8WOth1o7sf/zEu8AOzBeliHr9OZ32TboyPqexgWprlTg==
X-Received: by 10.36.219.198 with SMTP id c189mr1821801itg.29.1510164576007;
        Wed, 08 Nov 2017 10:09:36 -0800 (PST)
Received: from google.com ([2620:0:100e:422:fdd2:e3b5:33d4:8de0])
        by smtp.gmail.com with ESMTPSA id 78sm2165334ioo.37.2017.11.08.10.09.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Nov 2017 10:09:35 -0800 (PST)
Date:   Wed, 8 Nov 2017 10:09:33 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2017, #03; Wed, 8)
Message-ID: <20171108180933.GA11916@google.com>
References: <xmqqinell3of.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinell3of.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/08, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> The tip of 'next' has been rebuilt on top of v2.15, while kicking a
> few topics back to 'pu'.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>     http://git-blame.blogspot.com/p/git-public-repositories.html
> 
> --------------------------------------------------
> [New Topics]
> 
> * bw/rebase-i-ignored-submodule-fix (2017-11-07) 1 commit
>  - wt-status: actually ignore submodules when requested
> 
>  "git rebase -i" recently started misbehaving when a submodule that
>  is configured with 'submodule.<name>.ignore' is dirty; this has
>  been corrected.
> 
>  Will merge to 'next'.
>  I've edited in the tweak brought up in the discussion.  Please
>  eyeball to sanity check.

Tweaks look good to me!

-- 
Brandon Williams
