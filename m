X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 25 Nov 2006 12:12:35 +0100
Message-ID: <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org> <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net> <20061122034056.GB23856@spearce.org> <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net> <20061125065338.GC4528@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 11:13:48 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061125065338.GC4528@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32284>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnvTZ-0004d0-I9 for gcvg-git@gmane.org; Sat, 25 Nov
 2006 12:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966389AbWKYLNb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 06:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966423AbWKYLNb
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 06:13:31 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:13706 "EHLO
 smtp5-g19.free.fr") by vger.kernel.org with ESMTP id S966389AbWKYLNa (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 06:13:30 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp5-g19.free.fr (Postfix) with ESMTP id 6E05827B3C;
 Sat, 25 Nov 2006 12:13:24 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id 99C06201C;
 Sat, 25 Nov 2006 12:12:35 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Sat, Nov 25, 2006 at 01:53:38AM -0500, Shawn Pearce wrote:
> Yann Dirson <ydirson@altern.org> wrote:
> > We don't need to have commits in the tree for this.  We'll just have
> > submodule commits which are not attached to a supermodule commit, and we
> > can access the whole submodule history through the submodule .git/HEAD,
> > just like we do for a standard git project.
> 
> No.  You cannot do that.
> 
> How do we setup .git/HEAD when bisecting the supermodule?
> Or merging it?  Or doing anything else with it?

Would there be any problem assuming git-update-ref would take care of
updating it ?

> Ideally the .git/HEAD of every submodule should seek to the commit
> that points at the tree of the submodule which the supermodule
> is referencing.

You mean, whenever we seek the HEAD of the supermodule, right ?

> This lets you then perform a bisect within the
> submodule when you identify the supermodule commit which caused
> the breakage.
 
That is, first bisect the supermodule (which naturally bisects the
submodule with rough granularity, assuming there are many submodule
commits for at least some supermodule commits), then bisect the submodule
between the two commits identified at supermodule level, right ?

> We need the submodule commits to do this.  Doing it without is
> too expensive.

Maybe I missed something again, but I'm still not convinced :)
-- 
