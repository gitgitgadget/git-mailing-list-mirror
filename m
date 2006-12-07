X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Thu, 7 Dec 2006 14:26:32 -0500
Message-ID: <20061207192632.GC12143@spearce.org>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com> <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:26:46 +0000 (UTC)
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33610>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsOtD-0005wT-Im for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163223AbWLGT0g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163222AbWLGT0g
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:26:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34481 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163223AbWLGT0g (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:26:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsOt1-0003oJ-AC; Thu, 07 Dec 2006 14:26:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 AFDDA20FB6E; Thu,  7 Dec 2006 14:26:32 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
> 
> > I have a kind of awkward project to work with (~44k files, many binaries).
> >
> > The normal "git commit", which seem to be more than enough
> > for anything and anyone else, is a really annoying procedure
> > in my context. It spend too much time refreshing index and
> > generating list of the files for the commit message.
> >
> > At first I stopped using git commit -a (doing only update-index),
> 
> I am not sure what you are trying.  Do you mean stat() is slow
> on your filesystem?

Its Cygwin/NTFS.  lstat() is slow.  readdir() is slow.  I have the
same problem on my Cygwin systems.
 
> > Is there any simple way to modify git commit for such a workflow?
> > Failing that, any simple and _fast_ way to find out if the index
> > is any different from HEAD? (so that I don't produce empty commits).
> 
> Maybe you want "assume unchanged"?

Yes, basically.  The Cygwin/NTFS issues Alex is pointing out are
exactly why git-gui has a "Trust File Modification Timestamp" option
on both a per-repository and global level.  My larger repositories
(~10k files) are difficult to work with without that option enabled.

-- 
