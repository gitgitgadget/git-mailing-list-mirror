Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3BEC1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 22:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfDYWRG (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 18:17:06 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:38570 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfDYWRG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 18:17:06 -0400
Received: by mail-pl1-f181.google.com with SMTP id f36so481641plb.5
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 15:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jw5xQo04Tw76avuvAZglqIBnW+JCixcNbA+p0Sj/flI=;
        b=oba6I0nUU5pgD6V6aEyBQmypLfZQDsLPdRqZc7gLwgxsfZzJxvx6nNAkOl/DS1yKZ+
         xSN4o1DVDVqFGMJs/1f5L3codqEIyczv5YQP1XoYQ2O9STFwf5XGpPRBh0IAaUNbvBDk
         JZO1bXb28BtQGkDcq2o9PJGX+ItyA8smfhmITQ6NhzM5xx6ePuTZHBW+EDqW3wAvkB3i
         Ab1tbglGJg1G3bX6WrHFNWiZ4Emny0fY05KRlyqH0qvu/+RRneg+JCM7DwwzKSgVPi92
         VMHNcHCachPDo8hSrOGzbx9R+rwDuZYzBSld9OqWEYbP2dKviWea0bS9dzaSu+47ggJW
         IOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Jw5xQo04Tw76avuvAZglqIBnW+JCixcNbA+p0Sj/flI=;
        b=XgcUmRx405uNWmhjuZkOy1gdNj3keXgoPymWamhz4aVxsny21Eqry80GFTvyD6ubCB
         DhE1pwk9BmBY8op7gSolCp4GcMI9yeWPZVFXr9hPT68pM/uSFNal1XyVq+svxAYqdJ1l
         CpZLOWp0AzfjGywCGHoHkBQNBZIuvw2TUTbmzf7sLBsE4s0HvdQ3iwXribR4jAG7d2HK
         2iQK2p25Jw0iODHd1s60HcTR0ogcbIYRruP1WWp3r2exJEmLRYqpEDvc/EfVjpv37nRo
         rGXJ2lFqGHODj9hhUQYVjAz+YNka+oJ1Iluc5iRai3AlSmKbPzf1tMCcPRThI+T+hmhw
         wACg==
X-Gm-Message-State: APjAAAXtyhZrAIyPSePuZ6BLX0nIWnKamNRmwOlU5mpdyuwIMJ+AwHmP
        XfVeDMdJui7pkdU9OCRKSq13Dgo1TJRVVA==
X-Google-Smtp-Source: APXvYqxnQXIg0n8UO++uNAZora5/JB2ggserKrbTRPF+bI6naH6M0VX2TZcBPlGL/QMbR/dk+MbKsA==
X-Received: by 2002:a17:902:bd92:: with SMTP id q18mr42511875pls.136.1556230624745;
        Thu, 25 Apr 2019 15:17:04 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id 128sm26941008pgb.47.2019.04.25.15.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 15:17:03 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:16:57 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: js/partial-clone-connectivity-check (was: What's cooking in git.git
 (Apr 2019, #05; Thu, 25))
Message-ID: <20190425221657.GV60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.25 19:15, Junio C Hamano wrote:
> * js/partial-clone-connectivity-check (2019-04-21) 1 commit
>   (merged to 'next' on 2019-04-25 at ebd8b4bffd)
>  + clone: do faster object check for partial clones
> 
>  During an initial "git clone --depth=..." partial clone, it is
>  pointless to spend cycles for a large portion of the connectivity
>  check that enumerates and skips promisor objects (which by
>  definition is all objects fetched from the other side).  This has
>  been optimized out.
> 
>  Will merge to 'master'.

Peff asked for a perf test for this [1], but I haven't had time to write one
yet. I can do that in a separate patch if you still want to merge this
as-is.

[1]: https://public-inbox.org/git/20190422213113.GB4728@sigill.intra.peff.net/
