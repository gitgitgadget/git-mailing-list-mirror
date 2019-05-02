Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A481F453
	for <e@80x24.org>; Thu,  2 May 2019 16:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfEBQsK (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 12:48:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33389 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEBQsK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 12:48:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so1423064pfk.0
        for <git@vger.kernel.org>; Thu, 02 May 2019 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aA3z995wMTdo4+gpkW5j3JvHMdsAZIbNA/UT+SGB+Vo=;
        b=IvOH1Ft/vKH8ao85QA0Z6m8hLPGxUCanYFkhrDbxh5akFuCimjK0DG+XUhqYQR80fA
         ZZ5cFK9yGCXxgTgn3ah/iWiLaC0IRUXAezctbqxYTbNOh348xWuMpcQbzA+NoGEy0CoI
         zieu1JDgxCyJrZ0xT+v0L+DiZme3CxDVpoCTugLvy+A5by1nA6GJc4X4Pafxx8h1xro2
         EOoJIjWihKDwvbLmEiGl/wRY6yZt5UdSzp/rhpj0hHZke61HFsWcgacT53pSq5cX/WWX
         0Rn/XQjUMHRqpVe6lUMRKFRY7v3KUaXAGIhmaKDNn29eiIu0qXdseKPmS2zkv1h+SKN1
         +6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=aA3z995wMTdo4+gpkW5j3JvHMdsAZIbNA/UT+SGB+Vo=;
        b=nTGBeqCh37NzpQ+P/ONWVkD0T4TJXedcAznFCxfr/syhhJa8La4MEoFSqijpYPeNco
         OqMx4XtTlnQjhL7Q0TeFbNEFlwRdWtpwTa/qrVCIzucDDnrj63fPFjx8JVjziU7/Byy4
         BCJwLbHN/TzvgFmt1lIxW0wD1rwxKHhMX/XEJucPs8W+wjb74Qy+8KMQnMp4SByiNl3K
         RPFFnDNHnLQsUWLulU+2KQASACPhupAc5DoGR18lrhte863TGEBXNDTiEqJkdF57dOu2
         BApRsZfQJ8nABwW7G7Ub1PZ3kHMMfJJ28Oh9WeRd+schR8soL1WNwWsHfT8RtRsM1VuD
         KZZg==
X-Gm-Message-State: APjAAAWINWD+skiMTK25MTXfTPe3sb6OuAXMPXDjmc3PaNuOosvKHAm/
        qxaKPQJBPd7Ag+C+1m4W+LH/Uw==
X-Google-Smtp-Source: APXvYqw3BqzmhF1QOjCA9NScmXgDuFnA+fZi+qpJpZvvHYzAFh+lFuuM9M9UKp6IfkPoTKR0WXvSFQ==
X-Received: by 2002:a65:5c89:: with SMTP id a9mr5059357pgt.334.1556815688737;
        Thu, 02 May 2019 09:48:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id u7sm17628767pfu.157.2019.05.02.09.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 09:48:07 -0700 (PDT)
Date:   Thu, 2 May 2019 09:48:03 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/partial-clone-connectivity-check (was: What's cooking in
 git.git (Apr 2019, #05; Thu, 25))
Message-ID: <20190502164803.GB26779@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
 <20190425221657.GV60888@google.com>
 <20190502025206.GA25395@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502025206.GA25395@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.05.01 22:52, Jeff King wrote:
> On Thu, Apr 25, 2019 at 03:16:57PM -0700, Josh Steadmon wrote:
> 
> > On 2019.04.25 19:15, Junio C Hamano wrote:
> > > * js/partial-clone-connectivity-check (2019-04-21) 1 commit
> > >   (merged to 'next' on 2019-04-25 at ebd8b4bffd)
> > >  + clone: do faster object check for partial clones
> > > 
> > >  During an initial "git clone --depth=..." partial clone, it is
> > >  pointless to spend cycles for a large portion of the connectivity
> > >  check that enumerates and skips promisor objects (which by
> > >  definition is all objects fetched from the other side).  This has
> > >  been optimized out.
> > > 
> > >  Will merge to 'master'.
> > 
> > Peff asked for a perf test for this [1], but I haven't had time to write one
> > yet. I can do that in a separate patch if you still want to merge this
> > as-is.
> 
> I won't die without one, but it would be nice. It may also be that an
> existing perf test, but I don't think we cover partial clones in t/perf
> at all. Might be worth just a straight-up "git clone --filter=blob:none"
> test.
> 
> Also, in the proposed merge message above, it should be --filter, not
> --depth, right?

Yes, thanks for the catch.
