X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 13:34:45 -0500
Message-ID: <20061121183445.GA22283@spearce.org>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org> <20061121180643.GC7201@pasky.or.cz> <ejvfng$cj6$1@sea.gmane.org> <20061121182135.GD7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 18:35:07 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061121182135.GD7201@pasky.or.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32014>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmaSO-00020C-I8 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 19:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031279AbWKUSew (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 13:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031280AbWKUSew
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 13:34:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35800 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1031279AbWKUSev
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 13:34:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GmaS9-0001gB-5X; Tue, 21 Nov 2006 13:34:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6101020FB09; Tue, 21 Nov 2006 13:34:46 -0500 (EST)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> wrote:
> BTW, the other frequent reason why empty commits come up so frequently
> is a FAQ "how do I create an unrelated branch in my repository" - their
> idea is that they will create a new branch starting with an empty commit
> (of course noone would think of anything like that in inferior VCSes
> because replacing the checked out trees would took forever; how cool Git
> is!).
> 
> (The answer is usually "create the branch in a separate repo and then
> fetch it to the original one". But it feels a bit kludgy given the
> otherwise seamless support for unrelated branches. (Not that I ever was
> a big fan of unrelated long-lived branches in general.))

Or just abuse git-symbolic-ref:

	rm .git/index
	git symbolic-ref HEAD refs/heads/unrelated-branch
	git add ...
	git commit ...

see, so simple.  And no need to create an unrelated repository and
pull across to this one...

-- 
