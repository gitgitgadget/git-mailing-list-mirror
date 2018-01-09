Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02381F406
	for <e@80x24.org>; Tue,  9 Jan 2018 20:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754880AbeAIUG4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 15:06:56 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32770 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754046AbeAIUGz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 15:06:55 -0500
Received: by mail-pf0-f195.google.com with SMTP id y89so9347048pfk.0
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 12:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2FcqrhVGQfsww0tNmOKiz0lxwd6C1juXD5rpArT2oxY=;
        b=ZxPcoJ02NJmQRbwuUY+qiBeCJG1MkXr55Y+s39oa28Yu90dh0LVlq0klMZzVpbqQID
         Ee4G4dVr73Gj9MvFc5jmFl3qcUotKiNKiz4p3JtkhicMp+XhCCAh/dkztSo9cG/l7RGP
         rggQUgHSDm5G5MeXQNpy+G2Wh2Anq2459QylYl479fxEQ/s4qJAXFuKxTJaU7fTUNOzQ
         wKj4wYWCzF5YvDAxfJw0Dfq1jOKbVp1LcqmRndKWffHNJ/SBmKxZ4W84l96QuFSumkJK
         oiqrZRsy22eBa3NIQm/JD+e39XfKx2sf/Mkl1Q5PrTTiriISan/WMXarkVMA12a3EvEF
         sPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2FcqrhVGQfsww0tNmOKiz0lxwd6C1juXD5rpArT2oxY=;
        b=cCNkRv8WI64xnQjjYMujLroIeRVhaWOyK8OPDA1W/w3uGAVD52ETx/YXOuycWAzP50
         NqwaHDbvt14tdmABtcfRmJCatZon2riXt+U5mRcqfW0/ZRo+F79bTHAINxLStiF866Yn
         Qp8TqHmSNdfQY/EYHYXosieDo2SNWHOe8b2HPj3N0FK5r4LwUr3qumKcN21wGdbYcH3X
         UOWSjt/AhaERvagiuJYr6IOA/oeFVXCvqE4AQUMzwFzsBCGoVvC3tvdZJ5lzLe3svhNI
         NMTJqc1HllDBvxTWVhx8UMgvEWZjfaQwGaymeV9Uh7Ew3Wq8NQiy/0rbbmm13rOoMemO
         gxsw==
X-Gm-Message-State: AKGB3mKEhaERN130l3n90A4xXl49GkNxswbzg4CUztMWH91KGum2FfoU
        nRnRG0y2ciRcQZmUfQdARzCfUA==
X-Google-Smtp-Source: ACJfBouKhqxmna3L5aKRO9/76zj7lvSJ+lTLfTsEZo+46MehIMlylVV8ccD5+VYkwU3UmP+2cWgvqA==
X-Received: by 10.99.141.193 with SMTP id z184mr7050281pgd.261.1515528414550;
        Tue, 09 Jan 2018 12:06:54 -0800 (PST)
Received: from google.com ([2620:0:100e:422:5de7:5b51:7854:d1a5])
        by smtp.gmail.com with ESMTPSA id h80sm13577220pfj.12.2018.01.09.12.06.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Jan 2018 12:06:53 -0800 (PST)
Date:   Tue, 9 Jan 2018 12:06:52 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [PATCH v1 0/2] Incremental rewrite of git-submodules
Message-ID: <20180109200652.GE151395@google.com>
References: <20180109175703.4793-1-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109175703.4793-1-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09, Prathamesh Chavan wrote:
> The patches [1] and [2] concerning the porting of submodule
> subcommands: sync and deinit were updated in accoudance with
> the changes made in one of such similar portings made earlier
> for submodule subcommand status[3]. Following are the changes
> made:

The two patches look good to me.  Thanks for continuing this work!

> 
> * It was observed that the number of params increased a lot due to flags
>   like quiet, recursive, cached, etc, and keeping in mind the future
>   subcommand's ported functions as well, a single unsigned int called
>   flags was introduced to store all of these flags, instead of having
>   parameter for each one.

This is unfortunate.  The use of a flag word or using bit-fields are
essentially equivalent so its unfortunate that the conversion to using
one or the other caused review churn.  My own preference would be to use
bit-fields ;)  I also noticed that the flags you are using start with
OPT_* which conflict with the parse-options namespace, sorry for not
catching this when a few of your older patches made it into master.
This isn't a big deal since no symbols look to collide so I am not
suggesting you change this since I would prefer to eliminate more
unnecessary review churn on this series.

> 
> * To accomodate the possiblity of a direct call to the functions
>   deinit_submodule() and sync_submodule(), callback functions were
>   introduced.
> 
> As before you can find this series at: 
> https://github.com/pratham-pc/git/commits/patch-series-2
> 
> And its build report is available at: 
> https://travis-ci.org/pratham-pc/git/builds/
> Branch: patch-series-2
> Build #195
> 
> [1]: https://public-inbox.org/git/20170807211900.15001-6-pc44800@gmail.com/
> [2]: https://public-inbox.org/git/20170807211900.15001-7-pc44800@gmail.com/
> [3]: https://public-inbox.org/git/20171006132415.2876-4-pc44800@gmail.com/
> 
> Prathamesh Chavan (2):
>   submodule: port submodule subcommand 'sync' from shell to C
>   submodule: port submodule subcommand 'deinit' from shell to C
> 
>  builtin/submodule--helper.c | 345 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 112 +-------------
>  2 files changed, 347 insertions(+), 110 deletions(-)
> 
> -- 
> 2.14.2
> 

-- 
Brandon Williams
