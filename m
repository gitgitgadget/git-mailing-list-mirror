Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E731F453
	for <e@80x24.org>; Sat, 19 Jan 2019 07:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfASHp0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 02:45:26 -0500
Received: from ikke.info ([178.21.113.177]:47566 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfASHp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 02:45:26 -0500
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Jan 2019 02:45:26 EST
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 89AEF4400C0; Sat, 19 Jan 2019 08:38:08 +0100 (CET)
Date:   Sat, 19 Jan 2019 08:38:08 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Eric Wong <e@80x24.org>
Cc:     Steve Keller <keller.steve@gmx.de>, git@vger.kernel.org
Subject: Re: How do I get rid of unneeded objects?
Message-ID: <20190119073808.GA14639@alpha>
References: <trinity-02f2f7de-850d-4ad6-b709-86b7914cd81f-1547818792471@3c-app-gmx-bs22>
 <20190118224055.zpsz63b3gaxtwscu@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118224055.zpsz63b3gaxtwscu@dcvr>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 10:40:55PM +0000, Eric Wong wrote:
> Steve Keller <keller.steve@gmx.de> wrote:
> >     $ git reflog expire --all
> 
> I've never used "git reflog" directly, but I think you need to
> add "--expire=all" to cover all time.  "--all" is only for all
> branches, so you need "--expire=<time>" is for a time range.
> 
> Fwiw, I use a single command:
> 
> 	git -c gc.reflogExpire=now gc --prune=all

Instead of --expire, you could also use --expire-unreachable, so that
you don't get rid of your entire reflog.
