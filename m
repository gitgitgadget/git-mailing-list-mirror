X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git and "dumb protocols"
Date: Fri, 3 Nov 2006 18:27:21 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611031803370.9789@iabervon.org>
References: <vpqu01i16g8.fsf@ecrins.imag.fr> <20061102104848.GH20017@pasky.or.cz>
 <vpq4ptixdfj.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 3 Nov 2006 23:27:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <vpq4ptixdfj.fsf@ecrins.imag.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30896>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg8Rh-0002p5-8J for gcvg-git@gmane.org; Sat, 04 Nov
 2006 00:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932498AbWKCX13 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 18:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWKCX13
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 18:27:29 -0500
Received: from iabervon.org ([66.92.72.58]:49163 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S932498AbWKCX13 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 18:27:29 -0500
Received: (qmail 24856 invoked by uid 1000); 3 Nov 2006 18:27:21 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 3
 Nov 2006 18:27:21 -0500
To: Matthieu Moy <Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org

On Thu, 2 Nov 2006, Matthieu Moy wrote:

> I'll probably do, but my concern is broader than that. I like the
> ability to use almost any webhosting service for my revision control.
> GNU Arch was quite good at that, bzr is also (doesn't support webdav
> very well yet, but read-only-HTTP, sftp and ftp are there), so I'd
> like git to do the same.

You should be able to put together the repository you want hosted locally 
and use any webhosting service updating procedure to update what's hosted. 
AFAIK, git.kernel.org is a completely dumb mirror of master.kernel.org, 
working like that.

The main thing is that you want "objects" to be updated before "refs", and 
you don't want to do any git operations during the mirroring. But it's not 
even that important, so long as whenever you leave the mirror for a while, 
it matches some final state (with respect to git) of the master.

What you actually care about the git-native stuff for is preparing the 
master image, so that you don't have random cruft from your working 
repository, and then you just want it to mirror efficiently.

	-Daniel
