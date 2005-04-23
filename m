From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Catching up: git-pasky-0.6.2 broken?
Date: Sat, 23 Apr 2005 15:12:39 +0100
Message-ID: <20050423151238.C32116@flint.arm.linux.org.uk>
References: <20050423124758.B32116@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 23 16:08:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPLIr-0003gc-Kf
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 16:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVDWOMq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 10:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVDWOMq
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 10:12:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9743 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261590AbVDWOMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 10:12:43 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DPLNB-0005tS-4B
	for git@vger.kernel.org; Sat, 23 Apr 2005 15:12:41 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DPLN9-0005Tz-AV
	for git@vger.kernel.org; Sat, 23 Apr 2005 15:12:39 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050423124758.B32116@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Apr 23, 2005 at 12:47:58PM +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2005 at 12:47:58PM +0100, Russell King wrote:
> I've been away from git stuff since about Wednesday due to eye problems.
> Yesterday and today, I've been trying to catch up, but I'm running into
> problems.
> 
> I grabbed git-pasky-0.6.2, and followed Linus' message about converting
> repositories.  I've updated all the "heads", and cleaned out all the old
> sha1 files.  After updating, I did a read-tree for the tracked head,
> followed by checkout-cache -f -a and update-cache --refresh.
> 
> Therefore, in theory, everything should be in sync.
> 
> However, git pull now has nasty side effects.  At first I thought this
> was down to something still being out of sync.  However, on the second
> pull, it's still producing the same complaints.
> 
> It's almost although git has a single patch file subversely written into
> it to apply lpfc and qla changes which it's trying to apply irrespective
> of the objects downloaded.
> 
> Any ideas what's going on?

Could the problem be related to some random garbage left in .git/add-queue
and .git/rm-queue?

If so, how did these files get generated in the first place, and why
weren't they removed when they were finished with?

IMHO updating a repository from an external source should _NOT_ be
affected by the presence (or absense) of these two files, which
contain only _local_ state information.

-- 
Russell King

