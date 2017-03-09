Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE7E20135
	for <e@80x24.org>; Thu,  9 Mar 2017 00:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbdCIA2W (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 19:28:22 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36422 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdCIA2W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 19:28:22 -0500
Received: by mail-pg0-f44.google.com with SMTP id g2so1830550pge.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 16:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cO8Ae86rB8iPmOrULT/lWdD4TM+0mrcXkhs+EIcUPeU=;
        b=eE8YkZkvQgjRI/bI4F/3kvwZAR2/0dFdNYyExL4Oe/iGNMUEC6DrNDeUq8HYCNurSX
         GUsN1E1YHZB8INYY+2Y2twxgKyXzeoNv6S5mgogFThYmho8hQRrLfalFK3++/SXs10sb
         9kSeEXJ9YXkFB+cPMaLs9ATmUPo9LGs4ftma2Cc1FbkKVUZnSWkAtU73ee6y5cT/gY/0
         g4hQ9MKKO1392D44apFXeLC3nFjfDo7rPOOZ5XaOtFVNfhScHNKrE/88MENaBhYGJdxb
         wf2fGxDf9tGWKiN2XWlQiqtMX3UIZyDveUb3r/sXf8taoxs8FZxrQsfO2y/BFGkX2K1o
         OeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cO8Ae86rB8iPmOrULT/lWdD4TM+0mrcXkhs+EIcUPeU=;
        b=S+xMPhDsKAGfut0wZPToibbIMm4fPNDpoDHucRx2KFiHNrG4yU1kVZZ1Pzn4zF7iBW
         qKCYuDZNpb/1o59ZvdJFuHy8DZmd8w1uq6Vh8QUUoLRu+sZ+cB8gaETM81QXBL+WQqFq
         2ouO65HA/yW7HwHbFjDPAD8VZIe2tEEv+ZT2U8GcoJibXWyX2UG5htYDZuKRhiCBxxx/
         TMneWG4HSj7DJiyj2L1cnhm29eyCfqx3BC/KgXZFBfNc3MA1FDi3cYf5H1OgbC3oxVeQ
         JTJdqQW5yJo+VFCimgnm0zVPssZWryaVmNgLIkMa/Qjbr05d576iFYvcTvh4bMobHupr
         /N0w==
X-Gm-Message-State: AMke39lEhgDVAPCc6tHadMGSDXIKFKjjSt6PnJRIEjQnaInnzjIGJzCiPBE50/ewGuYFyY6C
X-Received: by 10.84.215.155 with SMTP id l27mr12846708pli.31.1489019300630;
        Wed, 08 Mar 2017 16:28:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:cdd8:47c3:cffc:85d3])
        by smtp.gmail.com with ESMTPSA id s26sm8341638pge.33.2017.03.08.16.28.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 16:28:19 -0800 (PST)
Date:   Wed, 8 Mar 2017 16:28:18 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Valery Tolstov <me@vtolstov.org>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/2] Remove duplicate code from module_clone()
Message-ID: <20170309002818.GA153031@google.com>
References: <CAGZ79kbnpUtrKdjQdQ-r6rRuVvnawooLFk1bO8jOSgxNkx2Dbg@mail.gmail.com>
 <20170309000352.18330-1-me@vtolstov.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309000352.18330-1-me@vtolstov.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Valery Tolstov wrote:
> > Then the next step (as outlined by Documentation/SubmittingPatches)
> > is to figure out how to best present this to the mailing list; I think the best
> > way is to send out a patch series consisting of both of these 2 patches,
> > the "connect_work_tree_and_git_dir: safely create leading directories,"
> > first and then your deduplication patch.
> 
> Combined two patches
> 
> Stefan Beller (1):
>   connect_work_tree_and_git_dir: safely create leading directories

It looks like this patch is apart of Stefan's checkout series.  So I was
slightly confused when first looking at this patch since I'd seen it before.
The usual protocol would be to rebase off of Stefan's series and build
on that (assuming you have a dependency against his series), indicating
that you are doing as such in your cover letter.  Though what you have
here should hopefully give the maintainer enough context to know where to
put it, so you should be good :)

> 
> Valery Tolstov (1):
>   submodule--helper.c: remove duplicate code
> 
>  builtin/submodule--helper.c | 20 ++------------------
>  dir.c                       | 32 +++++++++++++++++++++-----------
>  submodule.c                 | 11 ++---------
>  3 files changed, 25 insertions(+), 38 deletions(-)
> 
> -- 
> 2.12.0.192.gbdb9d28a5
> 

-- 
Brandon Williams
