X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 13:52:59 -0500
Message-ID: <20061121185259.GA22461@spearce.org>
References: <200611211341.48862.andyparkins@gmail.com> <ejvfng$cj6$1@sea.gmane.org> <20061121182135.GD7201@pasky.or.cz> <200611211839.58709.andyparkins@gmail.com> <20061121184817.GE7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 18:53:24 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061121184817.GE7201@pasky.or.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32021>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmak3-0005Q9-Tc for gcvg-git@gmane.org; Tue, 21 Nov
 2006 19:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031310AbWKUSxH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 13:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031312AbWKUSxH
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 13:53:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43995 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1031310AbWKUSxE
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 13:53:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gmajm-0006Wc-C9; Tue, 21 Nov 2006 13:52:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 D6EC020FB09; Tue, 21 Nov 2006 13:52:59 -0500 (EST)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> wrote:
> On Tue, Nov 21, 2006 at 07:39:56PM CET, Andy Parkins wrote:
> > for file in $(git-ls-files); do git-update-index --force-remove $file; done
> > 
> > Before creating the new files and "git-commit"ing.
> 
> Ok, this approach looks actually reasonable (contrary to the frequently
> suggested rm approach, which is rather dangerous).
> 
> Perhaps git checkout --empty could do this?

Or perhaps just delete .git/index?

Any git-update-index --add or git-add command will immediately create
an empty index.  Indeed this is the initial state after git-init-db,
since there is no HEAD to load into the index there is no index...

-- 
