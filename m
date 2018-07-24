Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2451F597
	for <e@80x24.org>; Tue, 24 Jul 2018 04:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbeGXFpa (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 01:45:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37766 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388166AbeGXFpa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 01:45:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so1171800plc.4
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 21:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mTetJetOt/p9adv41lepnl2kIStOOzMOf6FA0L6+QgA=;
        b=bwDc3o9cUaMpfeGCNuaY8L6YmSm+0cP+Jc/7ks1pDmiGrHr+ExbE153G8cNCgbWIsz
         uWUgQjMeDjNxQJKQNUknWFX7QtkjIErWizMLD1zgJEnF3wEhUw/KPGMxlzN7Y52A0hnO
         f69sGn0QWamojk65YQFT6V3NdSrOh2nLaXTXcr6JM6nXfWfvNV3O0EvUh14Fbnh8rIft
         bfIIQRsa3yxpLQBAfPg0k8QOVMKsw03/oBpDMLFqUqwD9pE/qEA+J3q8zPgh4DBsIiSw
         PkYlTKpVk2O3Rz+QxyWFe9olh7lIlQIK0y5JvLaProd4b0W++ZG0bPsRkMlMRhk5BP6m
         b7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mTetJetOt/p9adv41lepnl2kIStOOzMOf6FA0L6+QgA=;
        b=dmgnWnk4vhkPBnBHodDo+mQ48jkDR/x22kmgOOWBMwXgPu5n5vNGc3hJTNh1KdIOQQ
         6fkgW3lGaKxUha/0TBSJP4nNPX1/Z1zN6eIeJFPqjRMCM3hfE4idO+phxw4M4Zze/r9T
         6SBtRX/0j0B+Okm8LBVbEJlIA4OWMU9tL/Q2obzqu1iE2Fb3N63399LDZkUpGA+JpySF
         fwhZNk+4FqcnJKtcjd3bsT6QRigvNjErzK7H6c4VMj68bXkcQksccxSnxwKkOqBWDymA
         tiG1f0hJIh5jVHTCGwxASnG/PgB86zXsFtQpwg7UvPcUQtnALXnLhANXiXB6mTMQS2Zf
         H+Eg==
X-Gm-Message-State: AOUpUlGjMQCF33BHesSOO55clv0AhiqI2aYSEhVEkcOK5gaiAhCgCeii
        jsfpi6r1ENQ6qx/3jDRRBAeynLvj
X-Google-Smtp-Source: AAOMgpeqgSkpQvhzvVmHiDgQdem99/oWkvHGc7+J19vKH/mQEwCIn5nNwO4q11ym3GQYGdM84oI5hw==
X-Received: by 2002:a17:902:724c:: with SMTP id c12-v6mr15149257pll.326.1532407258251;
        Mon, 23 Jul 2018 21:40:58 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y86-v6sm23281052pfk.84.2018.07.23.21.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 21:40:57 -0700 (PDT)
Date:   Mon, 23 Jul 2018 21:40:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/diff-options: explain different diff
 algorithms
Message-ID: <20180724044051.GA208393@aiede.svl.corp.google.com>
References: <20180724003619.185290-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724003619.185290-1-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> As a user I wondered what the diff algorithms are about. Offer at least
> a basic explanation on the differences of the diff algorithms.

Interesting.  Let's see.

[...]
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -94,16 +94,34 @@ diff" algorithm internally.
>  	Choose a diff algorithm. The variants are as follows:
>  +
>  --
> -`default`, `myers`;;
> -	The basic greedy diff algorithm. Currently, this is the default.
>  `minimal`;;
> +	A diff as produced by the basic greedy algorithm described in

Why this reordering?

> +	link:http://www.xmailserver.org/diff2.pdf[An O(ND) Difference Algorithm and its Variations]

This URL doesn't seem likely to stay stable.  Are appearances
deceiving?  (Maybe so, since that's the same host as libxdiff's
homepage <http://www.xmailserver.org/xdiff-lib.html>.)  It might be
worth mentioning the author and date just in case.

> -	Spend extra time to make sure the smallest possible diff is
> -	produced.
> +`default`, `myers`;;
> +	The same algorithm as `minimal`, extended with a heuristic to
> +	reduce extensive searches. Currently, this is the default.

Amusing --- this means that the Myers diff is spelled as "minimal"
instead of "myers".

>  `patience`;;
> -	Use "patience diff" algorithm when generating patches.
> +	Use "patience diff" algorithm when generating patches. This
> +	matches the longest common subsequence of unique lines on
> +	both sides, recursively. It obtained its name by the way the
> +	longest subsequence is found, as that is a byproduct of the
> +	patience sorting algorithm. If there are no unique lines left
> +	it falls back to `myers`. Empirically this algorithm produces
> +	a more readable output for code, but it does not garantuee
> +	the shortest output.

Probably also worth mentioning that this was invented by Bram Cohen
for the bazaar vcs.

>  `histogram`;;
> -	This algorithm extends the patience algorithm to "support
> -	low-occurrence common elements".
> +	This algorithm re-implements the `patience` algorithm with

What does reimplements mean here?  Do you mean that it is a variation
on patience?

> +	"support of low-occurrence common elements" and only picks
> +	one element of the LCS for the recursion. It is often the

Does LCS mean longest common subsequence or longest common substring
here?  Probably best to spell it out to avoid confusion.

> +	fastest, but in cornercases (when there are many longest

s/cornercases/corner cases/

> +	common subsequences of the same length) it produces bad
> +	results as seen in:
> +
> +		seq 1 100 >one
> +		echo 99 > two
> +		seq 1 2 98 >>two
> +		git diff --no-index --histogram one two

I wonder if these details (about all the algorithms) should go in a
separate Diff Algorithms section and this section could focus on
what use cases warrant using each, referring to that section for
details.  What do you think?

Thanks and hope that helps,
Jonathan
