Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2BED20281
	for <e@80x24.org>; Fri, 15 Sep 2017 17:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdIORJC (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 13:09:02 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35738 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdIORJB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 13:09:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id i23so1495114pfi.2
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 10:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9RUQh4J1BREVOcpyRxx9fD7Z/TjMA5yhrBrV+0mO6Sc=;
        b=bse8lHPxHASqL5y4mFBhjXk4d77jwq+EOzVMrjCEXHrQauKE95Sz3a5l0stFtLg2JO
         ZozORr4CHJV9entWPuNUWSTvyBLgHj8Ac7liVhRaBWTm/0QZWa0YLpq3flbUuMDgDPax
         rC4TCvCvzgZm6/NjgOQwIEOHZ82JsQD3PoWby8zXczxyyGyMm1qzd82PFRyAPxSov5u4
         BzXbIiRz0IYak7D65AwVjZsGLrYvIehf98eq6u41Nmv8AA+QJj3U56VaO7NkwRcFC3ZJ
         OeAwBuEYneRqOC/8oZKD+JS0HkugximZ/sHzpEX5a+qgD44B4QVbVr+XpPsowMzjqbFD
         xq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9RUQh4J1BREVOcpyRxx9fD7Z/TjMA5yhrBrV+0mO6Sc=;
        b=X8YVW+yRYS29AWoc6KjzPHsAoi0/CnTk21t0QkIowEJGtT51S/bsIY/dvFVZZvhVtI
         0Z9KmhlkhYH+zV2R/siAm72/IqnLVGTFYql7Xuhk9z+sEN+9eSNWcKkWgxgzxBSSPxjE
         +Nyz/+AY6lHEKWOI8kRH+EY0I+9HXQuj/N7YzCK5K0T11RuDnaRsjzLvcI1pK9hDezMX
         XiHziawJuEieIuq8PGXAA17MPQ+28tzWE4ne2GNarjoCBlZId2OT+Zl1xqAGM/AqFaeT
         g0V9VgXH/m+ob7f2h9ylw8n4zyKSiunMxvSRfNZbxdJ16Y6PCG88e1WcKX2CJGIuul7u
         WjWQ==
X-Gm-Message-State: AHPjjUgd5Bt+FMY6cRQjsC5Z/+hLEIVMAVv1582T79/2/MX7vI7EPa3M
        MAtFNo3lMIGmQQ==
X-Google-Smtp-Source: ADKCNb4Nbg0eTzCVF7fu5ruiNiF/fa6AyoL9BbeQZ4AmAWzCNOTLx1s4Z/3wuYflSyeCCTH0pxuIhQ==
X-Received: by 10.101.81.135 with SMTP id h7mr25563545pgq.48.1505495340604;
        Fri, 15 Sep 2017 10:09:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:539:86cc:e014:7a2])
        by smtp.gmail.com with ESMTPSA id i12sm2670205pgr.21.2017.09.15.10.08.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Sep 2017 10:08:59 -0700 (PDT)
Date:   Fri, 15 Sep 2017 10:08:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        git@jeffhostetler.com, kewillf@microsoft.com
Subject: Re: [PATCH 0/3] Improve abbreviation disambiguation
Message-ID: <20170915170857.GS27425@aiede.mtv.corp.google.com>
References: <20170915165750.198201-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915165750.198201-1-dstolee@microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:

> This is my first patch submission, and I look forward to your feedback.

Thanks for writing this.  Looks exciting.

[...]
> When displaying object ids, we frequently want to see an abbreviation
[etc]
> Note that performance improves in all cases, but the performance gain
> is larger when there are multiple, large pack-files. This gain comes
> from the lack of in-memory caching of index files that have already been
> inspected.

Can this (especially the performance information) go in the commit
message for one of the patches?

Otherwise it is harder for people to track down when looking at these
changes later with "git log".  In the worst case, if the mailing list
archive is down, then people would not have access to this information
at all.  For that reason, I try (though I often fail!) to restrict
cover letters to giving hints at e.g. what changed since the patch
series last visited the list, and to make the commit messages in the
patches themselves as self-contained as possible.

That aside, looking forward to reading the patches themselves in more
detail.  Thanks for working on this.

Sincerely,
Jonathan
