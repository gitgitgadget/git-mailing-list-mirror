Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311B520437
	for <e@80x24.org>; Wed, 11 Oct 2017 05:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750959AbdJKFQW (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 01:16:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35424 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdJKFQV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 01:16:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id i23so1287870pfi.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 22:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gqPVgLsAHm11ElfzxnC4gQStxRWqYvVJwNumUpYru/8=;
        b=KnZ9ckeGkWATjysuMpmnkJgZ5EEYOpPJTjIw8AlnE4iq97nReVrlc5ngqvR6HcbBGh
         3h1f09cZ/KFtRfjtjwlhBGmBdlqpY6QYz496QeGa1MisgSFK5VM08F5jdGIyv1dII7JL
         54O05trPjjOdUpSGTlK8y2RQXGv0nlBUjPFcTAwffWwvtC/VVCJ/yxDMOHgy3sWW9ZNM
         Xgt0o3DN47lB8P03Oly56Nr2Rn1ShaizfcEKnunWKDLxllTOl0MWnyhTJugdUkPaX9AT
         zrKowLtVCFsOD5Qjp2dNWHO+O7IqVCEa9LhSGLw/tHa+RyizvsW1c94j6E1fXXijoMji
         UKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gqPVgLsAHm11ElfzxnC4gQStxRWqYvVJwNumUpYru/8=;
        b=NEGijzPGMMTvqVJ2jaYYpQDcCNN4cducuzhwwTqYXjABJoBEU9BUtjpHaNI/9EQG7H
         nJTR+Glw0vENEYIxS4MwO/TriFPvoirB88mHo0apCTiZaIsE9Zra9kSKqBHfe6ES3No9
         aRlY9dhaQ4US6UZPAhnuH/D+f38SsMNzLrZl5Un88k0ptFA7FLaOsUFFXqOvjVcb81tM
         bFEbbuZNwVpsNKI+nemAUzwFahqBrcPUCvnNExn8kNhDQJ9maiuSFaubmISxchm+Vc7K
         0LGEET0IvET8useEMKDRF9WqBm7MkCpyT76+7rTVuXXZBGYxVc7ANXVHeMe+vDJUeZuo
         hxQA==
X-Gm-Message-State: AMCzsaW/f+/bQ3hTIPoq4xPl8CzEso597/aouRSRSIYBRb4DknhC9OEi
        iiYK4jYdlFNyVPU4GpPNJrELozp/
X-Google-Smtp-Source: AOwi7QCdtf5uSHnxKs70NIJzYHgzRMMTZhDUSjTjPBNjkCX5i6EqlolWKxMOQPxeeSE4wyOxKuOIcg==
X-Received: by 10.98.152.74 with SMTP id q71mr15200209pfd.291.1507698980518;
        Tue, 10 Oct 2017 22:16:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:8577:c864:99f:8edc])
        by smtp.gmail.com with ESMTPSA id d7sm20129685pgf.20.2017.10.10.22.16.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 Oct 2017 22:16:19 -0700 (PDT)
Date:   Tue, 10 Oct 2017 22:16:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing list <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH] checkout doc: clarify command line args for "checkout
 paths" mode
Message-ID: <20171011051604.GA140836@aiede.mtv.corp.google.com>
References: <alpine.LFD.2.21.1709300523190.27819@localhost.localdomain>
 <20170930143258.GA20886@alpha.vpn.ikke.info>
 <alpine.LFD.2.21.1709301800060.7869@localhost.localdomain>
 <xmqqo9prv86l.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.21.1710010603340.17338@localhost.localdomain>
 <xmqqtvzis87i.fsf@gitster.mtv.corp.google.com>
 <xmqqefqao1av.fsf_-_@gitster.mtv.corp.google.com>
 <20171011032240.GZ19555@aiede.mtv.corp.google.com>
 <xmqqzi8ymg4f.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzi8ymg4f.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> here is another attempt, this time to avoid "Restore" and <paths>...
>
>  Documentation/git-checkout.txt | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)

Thanks.  I find this one easier to read indeed.

[...]
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -13,7 +13,8 @@ SYNOPSIS
[...]
> @@ -101,6 +95,14 @@ specific side of the merge can be checked out of the index by
>  using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
>  file can be discarded to re-create the original conflicted merge result.
>  
> +'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
> +	This is similar to the "check out paths to the working tree
> +	from either the index or from a tree-ish" mode described
> +	above, but lets you use the interactive interface to show
> +	the "diff" output and choose which hunks to use in the
> +	result.  See below for the descriptoin of `--patch` option.

nit: s/descriptoin/description/

With that tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
