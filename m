Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56A4202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 17:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbdKQRQh (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 12:16:37 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34096 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdKQRQf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 12:16:35 -0500
Received: by mail-pf0-f179.google.com with SMTP id x7so2389585pfa.1
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 09:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PMxzY1I8km9ELU8jj5Kqvhdn41OMHQRKS99zNQDLpYo=;
        b=XhB3p1LRPC2gIWvZONeqB7O+K5mFLRAx8x8RGotA0qSGEjY+yO6glvS12Hj44l3+UM
         bSKVMcCVyEnSAx09gSXmGaj3mEReAGHEnL8bF+4QSjBhQhnvlNKDT1kwC+lf78AwJHhh
         4fURO3d8kvEThOTVj5kWt3IpHTVvhQo+wIF/pRt8DHWuAfnGO/9ljS09NA03L4LpesCO
         agkpEYGQVIq4f+HMtr1hadPezTtn+F8AivzHBpbK5ALlr3FzWEK0CyXsPWydIFxKdtAi
         KcjQWFnPJjzWxbl3+RjHIciXuf2/Vjdnzug7x2B94wrAovTHoUbZCzxQDGd2fKykiMIt
         lsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PMxzY1I8km9ELU8jj5Kqvhdn41OMHQRKS99zNQDLpYo=;
        b=ObU+bR19KdJvHqpYHthE2xMKVLDxsdu7PWHiOR+fs+sDg48gZSmtosxyM+bCL70dGy
         pWT23t477BeipLHhADk9FIPfDgbCcb4/MpvOpyHSQ1UdfTwCVEWRYC/YF6thV9UuUXx7
         b83kCsjknXa6F0FJkEmGcxXrLAPe7bzIPxPZ1SN3JM/mid+xvpud43MmTRpxQaBWyVmj
         aXEPzVT6F0SlOhRzuUQtoeN02GmkxYLHQe3wcbGWN8QypaUWwEQ9wb8aAHdf/1sm7e45
         +1B4/Ke9mK3e8n/aF+TmTbbf31BL5XQjDQ2Gi/D7Ysry6+tiaVvaoP/+JVdr+hAk86ov
         ceMg==
X-Gm-Message-State: AJaThX7gR3P1xf4liD4dKXpGAg4sWfEW0hdR/xknnjeGHozMq+9Vf5j2
        exvjxku5e/88+LQNt5IJ+eCVXFhV
X-Google-Smtp-Source: AGs4zMZHUbE9Xch0y5c4qVVduiS37/nZPKIFkMOoZpvZ8XFil2Sw6NsJICocnlU70WAGFQJxzqHRkQ==
X-Received: by 10.159.249.1 with SMTP id bf1mr2194304plb.401.1510938995071;
        Fri, 17 Nov 2017 09:16:35 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k80sm9214733pfh.30.2017.11.17.09.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Nov 2017 09:16:34 -0800 (PST)
Date:   Fri, 17 Nov 2017 09:16:09 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: is there a rationale for some sample hooks but not others?
Message-ID: <20171117171609.3lwjlrhm43o3pqir@aiede.mtv.corp.google.com>
References: <alpine.LFD.2.21.1711170114080.6483@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711170114080.6483@localhost.localdomain>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

Robert P. J. Day wrote:

> given that a newly-initialized repo contains samples for some hooks
> but not others, is there a simple rationale for why those particular
> sample hooks are provided, and not the rest?

I assume this is in the context of reviewing the Pro Git book.  Thanks
for doing this work.

Let me turn the question around: do you think it would be useful to
have samples for all hook types?  What would you like those samples to
look like?

Thanks,
Jonathan
