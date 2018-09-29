Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790C51F453
	for <e@80x24.org>; Sat, 29 Sep 2018 10:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeI2Qfc (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 12:35:32 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:34957 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeI2Qfc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 12:35:32 -0400
Received: by mail-wm1-f52.google.com with SMTP id o18-v6so4376501wmc.0
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 03:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BX19tlzqlOLaNLyZpD6mAsAIFk4qVyBi9tKtw6sPOQg=;
        b=XLfVDneBwsf3UDngbo5H5qWolCffKZbfb+0Kkyb/UfiyOnQb6KbGjPG8odhEJiXPR0
         3p2tb2jqdXCIpnyg6xVxhN0Xkg+51k49Rdz0ApD/aSfGZ/9iGc+eb4g1zqbfK9NBPW1u
         caPAgAogbZeGDIlPrF7fHPdywtwwZaTOP1LbY/NZOkVjYVTj7OuSN4YLMiXfI0xOtBW2
         8yN31nqTOU5cRK3ccKXZnnqDYOHx+SwAq6vMqwRJjhTryEw9RPqht5skBM/gm+SXbMuw
         coJLcDZ8pJFjYGGHBerd56ozwpe6xEy4/Sgf2ToZ+bfF1wHGaMdHPZkDfk4+ZkVJEN+B
         9DYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BX19tlzqlOLaNLyZpD6mAsAIFk4qVyBi9tKtw6sPOQg=;
        b=Y6n9W8DIIFCy7Z4dsA27DqMhCD6hU4ham7niwmokgUSEIIempXQrKQlCxaemwBZXLs
         f2eMgWpG5SqDURKRZSS66PghxQVLuob+EiJqN+Ha1O2oW+T9atFJt8RH/sXNiZ0uz3NX
         S/FnAlKdPaUYyfrUhzImv6vxkbwOZh3DB14Ro8BEmp96V1jyb1Jds/FVrxsa/hZcmgsA
         l7h99yAaZOwhe6Aois0JPUxLhjKcZmqY+1rMu/pWg9YAcMXy18wdHJd/f8aIymibRnJA
         YxuDKdk35QFMeorSkOmpYU+eJ8aTRkvZrWscbzssdGQQUIIIYjp0nQnOAa4/8rbIzU6w
         tqFQ==
X-Gm-Message-State: ABuFfogwrdAPkDxn1z+v8Sx3G8dk01Xws2NHE3bvPdJTN5y5Xb6NSjJd
        SGeTXDtbwrRSxJCyuctMnMOTGKjk
X-Google-Smtp-Source: ACcGV613qCB7v2r7thEfk4Y1aBC1DC0kaKEBiTlaFPsTIDFjDRdYxYq/HGsfZxWl7OPHvv+RLpttLg==
X-Received: by 2002:a1c:9b91:: with SMTP id d139-v6mr4126132wme.50.1538215660429;
        Sat, 29 Sep 2018 03:07:40 -0700 (PDT)
Received: from localhost (x4db14438.dyn.telefonica.de. [77.177.68.56])
        by smtp.gmail.com with ESMTPSA id 124-v6sm6424612wmk.20.2018.09.29.03.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 03:07:39 -0700 (PDT)
Date:   Sat, 29 Sep 2018 12:07:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] split-index: don't compare stat data of entries
 already marked for split index
Message-ID: <20180929100737.GG23446@localhost>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180928162459.17138-1-szeder.dev@gmail.com>
 <20180928162459.17138-6-szeder.dev@gmail.com>
 <20180929053608.GB20349@duynguyen.home>
 <20180929091429.GF23446@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180929091429.GF23446@localhost>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 11:14:29AM +0200, SZEDER Gábor wrote:
> > > Note that comparing the cached data in copied and original entries in
> > 
> > s/cached data/cached stat data/ ? I was confused for a bit.
> 
> No, it's indeed cached data, but now that you mention it, the subject
> line does need a s/stat //.

Or rather s/stat/cached/

