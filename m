X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH]  Make logAllRefUpdates true by default
Date: Mon, 27 Nov 2006 00:01:00 -0500
Message-ID: <20061127050059.GA18970@spearce.org>
References: <11645554033331-git-send-email-wildfire@progsoc.org> <7vhcwmt19w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 05:01:35 +0000 (UTC)
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vhcwmt19w.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32382>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoYcL-0000WN-0r for gcvg-git@gmane.org; Mon, 27 Nov
 2006 06:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756794AbWK0FBH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 00:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756807AbWK0FBH
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 00:01:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57058 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1756794AbWK0FBF
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 00:01:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GoYbq-0007H7-Ar; Mon, 27 Nov 2006 00:00:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 62EFD20FB09; Mon, 27 Nov 2006 00:01:01 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> I do not think I can take this patch in its current form.
> 
> Although I think majority of users would find it convenient to
> have ref-log enabled by default on repositories to be developed
> in, it does not make sense to enable ref-log by default for bare
> repositories that is used as a distribution point.  So at least
> this needs an option to disable it (if you make it the default),
> or enable it.

What about just suggesting that the individual user run:

	git repo-config --global core.logAllRefUpdates true

?

This has the effect of enabling reflog by default for any repository
that the user creates or clones, unless its explicitly disabled in
that repository.

I've done this in any account that I use to access working directory
repositories and it works well.  But I also just realized that I have
it enabled in one account which also pushes to some bare repositories
through local filesystem URLs and thus those bare repositories are
also getting reflogged.  But given that they are used as backups of
my working directory repositories (different drive) and are never
pruned, I actually consider that to be a feature.  :-)

Your idea of guessing the intent of the repository and setting up the
configuration based on that intent is a good one, but unfortunately I
have no suggestions for how to solve the (1)..(3) cases you raised.
But setting core.logAllRefUpdates in the global configuration of
an interactive account appears to be a reasonable workaround.

-- 
