From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Modified files coming from v2.6.12 checkout
Date: Wed, 15 Feb 2006 15:21:55 -0500
Message-ID: <20060215202155.GA6301@spearce.org>
References: <20060215200442.GB5742@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 15 21:22:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9TA4-0003Yn-Nk
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 21:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWBOUWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 15:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWBOUWA
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 15:22:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:25240 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751284AbWBOUV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 15:21:59 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F9T9q-0001ko-G0
	for git@vger.kernel.org; Wed, 15 Feb 2006 15:21:50 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id C7B8620FBA0; Wed, 15 Feb 2006 15:21:55 -0500 (EST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060215200442.GB5742@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16255>

Gaaah.  This is was on MacOS X.  Whose filesystem isn't case
sensitive yet somehow tries to be.  If ipt_TOS.c and ipt_tos.c
both exist in the same directory I'm not surprised this works ok
for everyone else except me.  :-)

Fault found: A problem exists between the chair and the keyboard.
I'll switch to a Linux system to work with Linux kernel sources.

Sorry for the noise.


Shawn Pearce <spearce@spearce.org> wrote:
> I'm trying to do a performance test suggested by Catalin. I cloned
> (what I thought to be) Linus public kernel tree[1] then locally
> cloned it again and tried to checkout a working directory of v2.6.12:
> 
>   $ git-clone [1]
>   $ git-clone -l -n linux-2.6 bigmergetest
>   $ cd bigmergetest
>   $ ls -a
>   .       ..      .git
>   $ git-update-ref HEAD $(git-rev-parse --verify v2.6.12^{commit})
>   $ git-read-tree HEAD
>   $ git-checkout-index -u -a
>   git-checkout-index: include/linux/netfilter_ipv4/ipt_connmark.h already exists
>   ...
>   git-checkout-index: net/ipv4/netfilter/ipt_tos.c already exists
>   git-checkout-index: net/ipv6/netfilter/ip6t_mark.c already exists
> 
> That can't be right.  Why do so many files already exist during
> an empty checkout? git-status is reporting these files as being
> modified.  If I commit these 'modified' files there's actually a
> rather large delta if I diff v2.6.12 and the new commit.
> 
> I've tried this both with git 1.1.4 and 1.2.0.  Same result.
> I've also tried it with both the v2.6.12 tag and the current HEAD.
> Same result just different files having the problem.
> 
> I just looked at the linux-2.6 directory which I cloned from [1];
> it appears to have the same problem but on a slightly different
> set of files than the v.2.6.12 clone:
> 
>   $ git-status | grep modified | wc -l
>        18
> 
> Thoughts?  Suggestions of where to start looking for a fault?
> Does the fault exist between the chair and the keyboard?
> 
> 
> [1] http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/

-- 
Shawn.
