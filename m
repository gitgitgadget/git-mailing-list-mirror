Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50AFD1FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 16:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdFHQcj (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 12:32:39 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34058 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdFHQci (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 12:32:38 -0400
Received: by mail-pg0-f44.google.com with SMTP id v18so17699883pgb.1
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xl4MHJ2ApSJ/NKQHfUPVwpEWWjPNGN9yeznQkaIoYog=;
        b=lV1xUZMNZDk7DHuTvSpbVM8dzv+74Md714GaNdCcLVBwQeu0yc7Ho8j+c2+h4ZZ7Kg
         fKdySBrWcYMynOT5SLJbz/4aXf7m92xzg2TUV7orLyadaloCh6O4wU+HEvq12ZOPeo0V
         i0pGXz56Eir53ouQGQB0mASlwghAA4rLjLJBRvxmr3aOyK476GUM1sqM5OWMQNaXjLEL
         ihmAsJiIGB10NpKh9taqUSWcuuFEFl1B+Ov/jnFEHW/FiN2O/oA7yyyc/W7s56dsu4z9
         9x4TNBbjXD587v6wRq4t8bf0jgz3cFstC3U2gZmf7ooB5FFfiINxAdGjGxECwrLY7CjH
         BPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xl4MHJ2ApSJ/NKQHfUPVwpEWWjPNGN9yeznQkaIoYog=;
        b=OMi+13+wJtndMRrxg7N3EqYICVCvDfeQNaIDFuUEjVOKfwK/ixHw7y7FvIarQaobgK
         TMmdrLUXjDwrOZ7Q5iZiLO4eaGuJNYVW4gqqFOEk3PQM2SQ2hIcvS5hElAK3Zq1qkV/I
         dzkDoTzsqbCCrvTuf8uxR/yU3EwL1FDHQvHTFg9PA/7cRvem+sj0ygi7rVm56vhdqpFe
         FELhSlTgAZlaWs5MssHNi8B1BE5nVv8v2Y92jd4STcqDVpzhzVbaWWPymoQNdOWZAru9
         q5dU9rO2FQImHzzD4MIWHaOxyxWgJ3QHlj6+PvafAcE4vpGW6QiyfKUydH1diymbW/f8
         iFZg==
X-Gm-Message-State: AODbwcCctydAH4yiYy7PPodgyskWSTTCOzoKqrlLdQ2dsY6rIParMbms
        ZQmKgPshOwcJ1MvF0qug+w==
X-Received: by 10.98.43.206 with SMTP id r197mr37281940pfr.202.1496939553062;
        Thu, 08 Jun 2017 09:32:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:4d0d:6f3d:27f:3a24])
        by smtp.gmail.com with ESMTPSA id s131sm11223164pgs.6.2017.06.08.09.32.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 09:32:32 -0700 (PDT)
Date:   Thu, 8 Jun 2017 09:32:30 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/9] read_early_config(): optionally return the
 worktree's top-level directory
Message-ID: <20170608163230.GK110638@google.com>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
 <6d339785a007c2805bdc17c4e24da713a5996703.1496851544.git.johannes.schindelin@gmx.de>
 <20170607181333.GD110638@google.com>
 <alpine.DEB.2.21.1.1706081204330.171564@virtualbox>
 <20170608144628.GH110638@google.com>
 <alpine.DEB.2.21.1.1706081729450.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706081729450.171564@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Thu, 8 Jun 2017, Brandon Williams wrote:
> 
> > On 06/08, Johannes Schindelin wrote:
> > 
> > > Back to the worktree_dir variable.
> > > 
> > > I think part of the confusion here is that it may be left alone even
> > > when there is a worktree. For example, if we are already in the
> > > top-level directory. Or if the worktree somehow points to a different
> > > directory than the one containing the .git/ directory.
> > > 
> > > Therefore, I renamed this variable to `cdup_dir` to reflect the fact
> > > that it is only touched if Git determines that it is in a subdirectory
> > > of the directory containing the .git/ directory.
> > 
> > Ok, maybe I'm just not following but just from reading the variable name
> > I can't really understand what 'cdup_dir' means.
> 
> My idea would be that this is in line with the
> 
> 	git rev-parse --show-cdup
> 
> incantation.

Ah ok, 'cdup' just doesn't really mean much to me.  Is it supposed to
stand for something?

-- 
Brandon Williams
