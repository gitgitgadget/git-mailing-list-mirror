Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006181FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 00:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754767AbdDAAT2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 20:19:28 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35860 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdDAAT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 20:19:27 -0400
Received: by mail-pg0-f66.google.com with SMTP id 81so20571513pgh.3
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 17:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7f7bJ9wQOmifGbtRtL7dBAmKhaI9eU+6KbIFrVRfr0w=;
        b=G1ex6Yc6D4pSvEr+R73NldVcvt8Pji1gFkOgadgBqBpCaDmnGX524evmPmdStVwsRt
         iHZ6aCIIE1SWWQmEfd0PBc+zo5OmHhGyUW0lntx6MWvF/R54hRTf7ogVoX33ce8/pQT8
         xX4aoszcFj/lZA0fZ8iAxNIWh1sx4M3/2a9t05K/RXlFQ4RXrc/gXf7gCyabIIN5UN/e
         eVgLBjtal2dFR/PAWBKviF5Kg6URgogCs6jw8sceYRv+EBHRQZwYMEgFwSLU8NkK8+Vw
         0sIn1KTDb+/EenuC8xPsWr4RdEG2h+4iKFDBYCtkcxTfKPrYmJ5otnqnVOeiHyX4wSHV
         wtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7f7bJ9wQOmifGbtRtL7dBAmKhaI9eU+6KbIFrVRfr0w=;
        b=W5TScClrjPfnEmuJ0+vrjHTq8yZBiBZ3gHXqcfEB/9POeK1tusAeUBhubhhLSKkIuI
         6627ABK8130k6d3PSTYvyz6orcxr4ozfk67bEITZ+1NSU+1M7vUEBmN0wIY1IpY890GW
         +RfBjHoQLv+aaFva/INII9zkJgJ3W8ztSacR55a7kSbK8B87gBPHD0Xq+zIfiNLYAd3d
         rHnACG3+ZwL9m7cHtaV78EnzzFqnT1rtSYUc+0o4PRSENq0Kl7nje2jUP374KHsk5o7W
         naHwrjb68ZoB7QrB75kVEFAG8Jb7gs4Fxho4pKtngM6q4t1RUukiIim8qs+Gzh97eduF
         Lvsg==
X-Gm-Message-State: AFeK/H0nt1kgwFUhfVge9VmSO6WslocrhEBSYWMI8FGyvXJGFeboVk6Zik84Pl0XF/025g==
X-Received: by 10.84.241.71 with SMTP id u7mr6024230plm.104.1491005967094;
        Fri, 31 Mar 2017 17:19:27 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8962:97f5:cc56:a89d])
        by smtp.gmail.com with ESMTPSA id t6sm12526695pgt.8.2017.03.31.17.19.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 17:19:26 -0700 (PDT)
Date:   Fri, 31 Mar 2017 17:19:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] push: propagate push-options with
 --recurse-submodules
Message-ID: <20170401001924.GC8741@aiede.mtv.corp.google.com>
References: <20170331231135.195195-1-bmwill@google.com>
 <20170331235623.166408-1-bmwill@google.com>
 <20170331235623.166408-3-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331235623.166408-3-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Teach push --recurse-submodules to propagate push-options recursively to
> the pushes performed in the submodules.

Some time in the future we may want "push --recurse-submodules" to do a
dry run pass before doing the final push, so that if it is known that
some of the pushes wouldn't succeed (e.g. due to not being
fast-forward, or the server not being reachable, or the server not
supporting push options) then git could stop early instead of some
succeeding and some failing.

But that's a larger and separate change from this one.  Users of push
--recurse-submodules today know they are effectively asking for
multiple pushes that are not guaranteed to succeed or fail together.

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  submodule.c             | 13 +++++++++++--
>  submodule.h             |  1 +
>  t/t5545-push-options.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  transport.c             |  1 +
>  4 files changed, 52 insertions(+), 2 deletions(-)

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
