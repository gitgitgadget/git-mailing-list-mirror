X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-PS1 bash prompt setting
Date: Mon, 27 Nov 2006 01:54:00 -0500
Message-ID: <20061127065400.GA19174@spearce.org>
References: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE> <Pine.LNX.4.63.0611261524130.30004@wbgn013.biozentrum.uni-wuerzburg.de> <20061126094212.fde8cce7.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 06:54:24 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061126094212.fde8cce7.seanlkml@sympatico.ca>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32386>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoaNa-00060y-V1 for gcvg-git@gmane.org; Mon, 27 Nov
 2006 07:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757138AbWK0GyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 01:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757166AbWK0GyJ
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 01:54:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:5870 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757147AbWK0GyG
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 01:54:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GoaNN-0007Tc-SA; Mon, 27 Nov 2006 01:54:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 E100220FB79; Mon, 27 Nov 2006 01:54:00 -0500 (EST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote:
> On Sun, 26 Nov 2006 15:27:07 +0100 (CET)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > But there really is no good place to put it: most commands need a git 
> > repository, and those which do not, are inappropriate to put an option 
> > "--show-ps1" into. Except maybe repo-config. Thoughts?
> 
> What about just making it an option to the git wrapper?

I'm using something like this, and will be adding it to
git-completion.bash tonight:

	__git_ps1 ()
	{
		local b="$(git symbolic-ref HEAD 2>/dev/null)"
		if [ -n "$b" ]; then echo "(${b##refs/heads/})"; fi
	}
	PS1='[\u@\h \W$(__git_ps1)]\$ '

it works very well...

-- 
