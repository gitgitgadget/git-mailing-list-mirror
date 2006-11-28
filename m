X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 20:06:18 +0100
Message-ID: <20061128190618.GB12463MdfPADPa@greensroom.kotnet.org>
References: <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org>
 <45689747.3020403@midwinter.com>
 <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
 <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251936590.3483@woody.osdl.org>
 <Pine.LNX.4.64.0611260241320.20138@iabervon.org> <456C0313.3020308@op5.se>
 <Pine.LNX.4.64.0611281218290.20138@iabervon.org>
 <20061128180817.GA12463MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0611281315020.20138@iabervon.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 28 Nov 2006 19:08:18 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0611281315020.20138@iabervon.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32565>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp8I3-000054-QE for gcvg-git@gmane.org; Tue, 28 Nov
 2006 20:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936033AbWK1TGV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 14:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936037AbWK1TGV
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 14:06:21 -0500
Received: from psmtp04.wxs.nl ([195.121.247.13]:36290 "EHLO psmtp04.wxs.nl")
 by vger.kernel.org with ESMTP id S936033AbWK1TGU (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 14:06:20 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by psmtp04.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.07
 (built Jun 24 2005)) with SMTP id <0J9G00E46FQIZG@psmtp04.wxs.nl> for
 git@vger.kernel.org; Tue, 28 Nov 2006 20:06:19 +0100 (MET)
Received: (qmail 13764 invoked by uid 500); Tue, 28 Nov 2006 19:06:18 +0000
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org

On Tue, Nov 28, 2006 at 01:37:54PM -0500, Daniel Barkalow wrote:
> If submodule was the only thing that got changed, it's not dirty; if it 
> were dirty, some of its contents would also have gotten changed.

For me, the commit is the only "content" of the subproject that the
superproject should care about, so the submodule being dirty or not
is completely irrelevant (for committing), but it seems you see the
subproject more as a (working) tree than as a commit. Of course, as
Linus already mentioned, a "git commit" could still warn you if the
subproject was dirty.

> Surely:
> 
> "git commit submodule/foo bar"

I wouldn't dream of doing such an operation, because it doesn't make
sense to me.  (So as far as I'm concerned, you can make it do whatever
you'd like it to do.)  You can only commit the subproject as a whole.

> should do "git commit foo" in submodule, and then commit the supermodule 
> with the new commit for the submodule and the change to bar. And so
> "submodule/foo" is something you could commit changes to, so it should get 
> picked up by -a.

