Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE08A1F667
	for <e@80x24.org>; Fri, 18 Aug 2017 07:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750926AbdHRHIj (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 03:08:39 -0400
Received: from vie01a-dmta-pe08-1.mx.upcmail.net ([84.116.36.20]:32883 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750773AbdHRHIi (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Aug 2017 03:08:38 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe08.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dibOW-0003mL-6t
        for git@vger.kernel.org; Fri, 18 Aug 2017 09:08:36 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id yX8S1v0135BuuEg01X8TpZ; Fri, 18 Aug 2017 09:08:28 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id EA24A45D7A18; Fri, 18 Aug 2017 09:08:25 +0200 (CEST)
Date:   Fri, 18 Aug 2017 09:08:25 +0200
From:   Martin Koegler <martin.koegler@chello.at>
To:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [Patch size_t V3 00/19] use size_t
Message-ID: <20170818070824.GA3401@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
 <20170817203554.GB31284@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170817203554.GB31284@tor.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 10:35:54PM +0200, Torsten Bögershausen wrote:
> On Wed, Aug 16, 2017 at 10:16:12PM +0200, Martin Koegler wrote:
> > From: Martin Koegler <martin.koegler@chello.at>
> > 
> > This patchset is for next [24db08a6e8fed761d3bace7f2d5997806e20b9f7].
> 
> I applied it succesfully, and run the test suite on a 32 bit system.
> The Laptop reported one brekage in t0040:
> t0040-parse-options.sh   not ok 19 - OPT_MAGNITUDE() 3giga

I missed test-parse-options.c - I'll post an updated versions considering all comments.

parse-options takes the variable as void* - so the compilers also fails to recognize the usage
of incompatible types.
 
> Beside some t5561-http-backend.sh (which are most probably not caused
> by this patch.
> 
> The raspi had 2 deadlocks, like "git push --signed dst noop ff +noff"
> or
> trash directory.t5541-http-push-smart/gpghome --sign -u committer@example.com
> Even this most probably not caused by the patch. (and the test is still running)
> 
> Well done, and on which platforms did you test ?

Linux 64. 

Regards,
Martin
