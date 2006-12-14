X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 04:36:37 -0500
Message-ID: <20061214093637.GC1747@spearce.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com> <elpvro$rvj$1@sea.gmane.org> <200612140927.27259.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 09:37:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612140927.27259.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34293>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gun1K-0007r6-Eh for gcvg-git@gmane.org; Thu, 14 Dec
 2006 10:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932178AbWLNJgv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 04:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWLNJgv
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 04:36:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60576 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932178AbWLNJgu (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 04:36:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gun15-0001Fo-U7; Thu, 14 Dec 2006 04:36:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 D5BDF20FB65; Thu, 14 Dec 2006 04:36:38 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> I think the problem in most cases is that git outputs _too much_.  Also, I'm 
> not imagining that "git-add ." would list every file that it added - who is 
> that going to help?  It should say "added X files to index" or similar.  You 
> surely can't be arguing that that slows down your expert workflow?

git-commit-tree's "committing initial tree" and git-init-db's
"defaulting to local storage area" are both probably too verbose
and should just get removed.

The progress meters in git-pack-objects that you see during clone,
repack, fetch and push at least keep the user amused.  I do read
the output of repack every so often, but in general I don't care
about the output of clone, fetch or push - all I care about is
that my objects got to the remote system and were accepted, or not.
Which means that at least for me the output could be reduced down
to just the bandwidth transfer meter, for really slow links.

But I'm not sure that git-add should output anything.  Last I checked
the 'mv' command in Linux doesn't say "Move 5 files" when I move 5
files into a directory.  Likewise I don't think that knowing that
6781 files were added is useful, what if it should have really been
6782 files?  I'm unlikely to know, care, or realize it.

Your niggle list (is that what you called it) has been useful
fodder for discussion.  I'm glad you took the time to write it up,
and to argue it so well on the list.  There's a number of items on
it that I'd like to see happen too; enough that I may code some of
them if nobody beats me to it.

-- 
