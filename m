Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4CA1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 15:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408702AbfJRPbS (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 11:31:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37353 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393138AbfJRPbR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 11:31:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so6521929wmc.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LdFj8ob9G1cvBda/N8yBOOi3K9tGlARcwVj9wmHio5k=;
        b=EJHHmW7m3rGW61htXIeZS+GmTG/Om2TswoCC4UyOk/CftW0u/nJ35//XwGQhYLBbQy
         UQanuUhWwIylOPIPFD7q6Mv3Ui7R7hVkyumiOsbxYryKDEUh3mZ3SbTIWqf4+5yJ0ZlB
         cemoNkBlWXASpkUthU8yRBjwhEK6FelhMykJ3G+U6MvHTwdAKzx4BOBG9Tn+h5UxJBZj
         g1DR+E3ZRRYfzNu+X6j47cEkOOMYrqaTdQLf8h+91WCdLcliPDtUeCV7TxKfFNiegjXG
         SnigYxNsjF8t/sPQi4ZPb0AZEEZBI0mLKN7YX91JymmSa8As4Wrt+zqIGU4D4EsA8wn4
         tGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LdFj8ob9G1cvBda/N8yBOOi3K9tGlARcwVj9wmHio5k=;
        b=BziqcTpUajHOGOVbdrDmVSg1y7D+ef1sdSVz6O/w+AA24bt2WFOoBU8hss69lgIrjc
         Ea09DlDZ7dpZOPx6chyfVBMrOHiNIveCqP1XrXPnj/QaM4rV3fX7NZ3eJ9lHxkByp5tG
         woIjO8c8VNfahQMp1uXyjyiBli5TqW/L3KDSOOgFIGpKOUrLmASZc0t7KsD9N9ap7COt
         GnYMteE1Z/B3wPepznsKayrxf4oc1zevcOZPlB/dzktKKxgwzayHZY9LdBHTh5DPEV22
         yKJgR92jDujarJZcHtZDE1ga9IXZF1grbsXL4ngy2gjkCYUYwWdCsoPWCFjKLNkySPrt
         hknA==
X-Gm-Message-State: APjAAAWh9zXxDKn65gsKxUYzKUC7cuaiVWRhJUsTcXo9RwJEqDX+YKWV
        8Mz8FH0eLTqwNiwSwI5XhqM=
X-Google-Smtp-Source: APXvYqztfLRWSqZJ852GFEpWwXjfQ8Ac8wlvXICkgmNpK0re+/BZzNktCY1b5JM4oeaKSvU4YhRj2w==
X-Received: by 2002:a1c:4456:: with SMTP id r83mr8067872wma.44.1571412675680;
        Fri, 18 Oct 2019 08:31:15 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id o22sm7774556wra.96.2019.10.18.08.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 08:31:14 -0700 (PDT)
Date:   Fri, 18 Oct 2019 17:31:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 09/17] sparse-checkout: use hashmaps for cone patterns
Message-ID: <20191018153112.GF29845@szeder.dev>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
 <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <28606a152c79c4e399c5a9c77038888eda34341d.1571147765.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28606a152c79c4e399c5a9c77038888eda34341d.1571147765.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 01:55:56PM +0000, Derrick Stolee via GitGitGadget wrote:
> Running 'git read-tree -mu HEAD' on this file had the following
> performance:
> 
> 	core.sparseCheckout=false: 0.21 s (0.00 s)
> 	 core.sparseCheckout=true: 3.75 s (3.50 s)
> 	 core.sparseCheckout=cone: 0.23 s (0.01 s)

The previous patch added 'core.sparseCheckoutCone', so this last line
should be 'core.sparseCheckoutCone=true', shouldn't it?

