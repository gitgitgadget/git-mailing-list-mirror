Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A3041F428
	for <e@80x24.org>; Wed, 15 Aug 2018 05:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbeHOINi (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 04:13:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38026 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeHOINh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 04:13:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3-v6so74398pgq.5
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ns4hyrFumIK8ZUc4sUQNkIktdyUCdsPPgGahbE07Bl0=;
        b=EdnKd8JYWtuHXs8VynvHHWNHYsDdd5RJ75Jt6q8SnuXWSwoKR2cLQ7u/tM52IW3qHt
         8MchErheofWtSWIo0vqizqlOszvB9pv5GCoDfThxYFEhtd9GeB32IXoojMSj5ZeOqaDo
         5Ydxb4tS0U2ab4rqOOqGYAkWjko13HA1WOEpMBKyBeOhoRYkHSOiQuvl5DHS4FUBVxr6
         vTbiR64uHvPrZAAYs6n6PimpNwqus0IGO1l3OO4NLSWk5KgfT29m671O6BdqiIfqa0Vi
         FSFcFj+iwxISSohVaV+I4cZZeHDHkDZJL/Dd4HhgerKvR4yj2/7mWbv/5hH9UglYTBbp
         pZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ns4hyrFumIK8ZUc4sUQNkIktdyUCdsPPgGahbE07Bl0=;
        b=awXniro5E+75eDhBTxlOq7vNlABDE0ujrvDkoaVocOC/z0Em4DiD0sN+tpzHZ30Ec4
         zsZeHHS36eNFZNKvpBb49ScUrATIDCIEthYg/2Dv9iM4lTe1q6vt5E9nGFxiqOn7YppW
         QnEC6t0FqJMy8qfuRh80JO8Z/eCQXZ5ZUoPV6EunE3kJBxndbPPlKYyWHUd6Qv3RcEAN
         Plk8AnOHBOBcgXO5DJAmop+1Xdc02XiOX0vftWMEJga0bUPYyiPMEjEHAFfQ6RR4stQU
         KmvZ1ZrA2sGgbr0A0b2kwEAx/PfHjrotCe8qtwZCy6JqFJtMupeyg6ZIeyejgsv+gCL8
         zrCA==
X-Gm-Message-State: AOUpUlHNl/gPwpKpiFjf2QahAGxxMXmaYNQwXCRGKGSKMnCHUnRaoUJ0
        6GRmMNL2SIFWVA3nOO6Jyuo=
X-Google-Smtp-Source: AA+uWPwoQHKtHBwc2c5wojKmTdhlFcyyMjstaCeLLH+/7WV6PY8j9FatpLG71G/0RTdT0PEAZ+t9jA==
X-Received: by 2002:a65:560a:: with SMTP id l10-v6mr24085230pgs.130.1534310579556;
        Tue, 14 Aug 2018 22:22:59 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e82-v6sm33913540pfk.87.2018.08.14.22.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 22:22:58 -0700 (PDT)
Date:   Tue, 14 Aug 2018 22:22:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCHv3 3/6] Move definition of enum branch_track from cache.h
 to branch.h
Message-ID: <20180815052257.GE32543@aiede.svl.corp.google.com>
References: <20180811205024.11291-1-newren@gmail.com>
 <20180813171749.10481-1-newren@gmail.com>
 <20180813171749.10481-4-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813171749.10481-4-newren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> 'branch_track' feels more closely related to branching, and it is
> needed later in branch.h; rather than #include'ing cache.h in branch.h
> for this small enum, just move the enum and the external declaration
> for git_branch_track to branch.h.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  branch.h      | 11 +++++++++++
>  cache.h       | 10 ----------
>  config.c      |  1 +
>  environment.c |  1 +
>  4 files changed, 13 insertions(+), 10 deletions(-)

\o/

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
