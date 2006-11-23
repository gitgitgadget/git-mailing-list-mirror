X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 24 Nov 2006 00:23:13 +0100
Message-ID: <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org> <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net> <20061122034056.GB23856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 23:24:16 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061122034056.GB23856@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32175>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNvO-0002WR-T5 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757484AbWKWXYH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757485AbWKWXYH
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:24:07 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:36804 "EHLO
 smtp3-g19.free.fr") by vger.kernel.org with ESMTP id S1757484AbWKWXYE (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:24:04 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp3-g19.free.fr (Postfix) with ESMTP id 32B9E4A0C2;
 Fri, 24 Nov 2006 00:24:03 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id 7B3951F066;
 Fri, 24 Nov 2006 00:23:13 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Tue, Nov 21, 2006 at 10:40:56PM -0500, Shawn Pearce wrote:
> Yet we still want to be able to efficiently perform operations like
> "git bisect" within the scope of that submodule, to help narrow down
> a particular bug that is within that submodule.  To do that we need
> the commit chain (all 10,000 of those commits) in the submodule.
> To get those we really need a commit-ish and not a tree-ish, as
> going from a tree-ish to a commit-ish is not only not unique but
> is also pretty infeasible to do (you need to scan *every* commit).

We don't need to have commits in the tree for this.  We'll just have
submodule commits which are not attached to a supermodule commit, and we
can access the whole submodule history through the submodule .git/HEAD,
just like we do for a standard git project.

Or do I miss something else ?

Best regards,
-- 
