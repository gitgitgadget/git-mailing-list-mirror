Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DDB71F462
	for <e@80x24.org>; Tue, 30 Jul 2019 22:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbfG3WII (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 18:08:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43117 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfG3WII (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 18:08:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id r22so3156368pgk.10
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 15:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OyCe+hPhOarRvf4eFoqNZKthU6v6vsdldsBaYpwXHxg=;
        b=FbkWSEseeWDjOxi8FNvQW8Qul2tlk8NwoCCXkc9uKDcFF7wk3SwmCJhkgkiVVstjDU
         K033Q+E5K/Dq4URwRVR7lbYTsQQa3ucQPLzaLgO9p8sUMwJCW70egVtmaCjLisXeaIRF
         w9S36LWDgAgu7Kzekw/nWtCfU0G9agy368AXRbzXX2KQZIcHzFnezCjC9i31+DiA61no
         M4X3DURiJUjYB7dFZ60XYxQgkVXKBgFPayaPTNQkf8AS+fLMy0Qn2/YAKF81lUCKdFbv
         9GDRBl2H0q9cBXLCX0/bSeELx6KrtVsOpAIk8KADatIJIuhzNo2I+u/vx2n+0I8Ynsjh
         5HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=OyCe+hPhOarRvf4eFoqNZKthU6v6vsdldsBaYpwXHxg=;
        b=Gk3mShQ7DrwchhuNcV0K9pgwWjTfyUIpL5QBCId4oQjNs4iUiBzDKrXln5YxOy73vU
         XwXiyEilwLcwzZqfh21Zk0M5Ptdet11In1Pl5ssevyIOgfOLOgmlNVZPz4wzDY+uxdjD
         iOxVjgfPCaE9Avf19dfUmvzsJL2RDFn9l2Ze9rR7OfqPRkhIu2m4l+VCtDz3S/JCrhGG
         ALz93f/0EYoyJpDNbFSTt2bYG6186jmCrIvS/5dnVHqJO0e2/oMUYrQ7RjoE7Vjuk+Fh
         Vxs+7XXaytQHxO0IXFbSBKzsZtwLkO1PJg+O/qfgAE/3IIRuytR7mp0eNl8D+m+4F17O
         7PrQ==
X-Gm-Message-State: APjAAAVrNyew73zNH3GoNkHZBFlpb33wu01hFjD3iFGsrXNYtte3+kTT
        vGlOsqlz6lT0E9q41D3xzCrUAR+pQCYe6Q==
X-Google-Smtp-Source: APXvYqwkyuQg5LvcVFgEZb4wCGRG6PaDEbotbTCQrvmR2DUJSOwBE5SOglUnsIyqdarski7EbGpKAQ==
X-Received: by 2002:a63:f750:: with SMTP id f16mr81516370pgk.317.1564524486742;
        Tue, 30 Jul 2019 15:08:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id v13sm77194860pfe.105.2019.07.30.15.08.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 15:08:06 -0700 (PDT)
Date:   Tue, 30 Jul 2019 15:08:01 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] trace2: don't overload target directories
Message-ID: <20190730220801.GN43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <9ccf15ac-0e53-7044-e7b0-03bb229824d8@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ccf15ac-0e53-7044-e7b0-03bb229824d8@jeffhostetler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.30 14:00, Jeff Hostetler wrote:
> 
> 
> On 7/29/2019 6:20 PM, Josh Steadmon wrote:
> > trace2 can write files into a target directory. With heavy usage, this
> > directory can fill up with files, causing difficulty for
> > trace-processing systems.
> 
> I'm routing data in my org to a daemon via a Named Pipe or UD Socket,
> so I'm not seeing the thousands of files problems that you're seeing.
> However, we were being overwhelmed with lots of "uninteresting" commands
> and so I added some whitelisting to my post-processing daemon.  For
> example, I want to know about checkout and push times -- I really don't
> care about rev-parse or config times or other such minor commands.
> 
> I went one step further and allow either "(cmd_name)" or
> the pair "(cmd_name, cmd_mode)".  This lets me select all checkouts
> and limit checkouts to branch-changing ones, for example.  I drop
> any events in my post-processor that does not match any of my whitelist
> patterns.
> 
> Perhaps you could run a quick histogram and see if something would
> be useful to pre-filter the data.  That is, if we had whitelisting
> within git.exe itself, would you still have too much data and/or
> would you still need the overload feature that you've proposed in
> this RFC?

Our problem is not so much with the volume of data as the fact that a
few special users have a ton of git invocations in rapid succession,
each of which creates a new trace file. If we had a more synchronous
collection system like yours it would probably not be so much of a
challenge. But the massive number of files created in a short timeframe
revealed some inefficiencies in our collection system (which are
thankfully being addressed by the owners of that code). But we probably
still want some sort of overload prevention feature as long as we're
using the target directory approach.
