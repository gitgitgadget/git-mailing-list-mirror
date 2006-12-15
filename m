X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Enable reflogs by default in any repository with a working directory.
Date: Thu, 14 Dec 2006 19:20:15 -0500
Message-ID: <20061215002015.GI26202@spearce.org>
References: <20061214224117.GA26374@spearce.org> <Pine.LNX.4.63.0612150112010.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 00:20:36 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612150112010.3635@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34453>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0oN-0007ie-CG for gcvg-git@gmane.org; Fri, 15 Dec
 2006 01:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751633AbWLOAUX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 19:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWLOAUX
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 19:20:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44533 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751640AbWLOAUV (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 19:20:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gv0o3-0007iF-1R; Thu, 14 Dec 2006 19:20:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 3B76D20FB65; Thu, 14 Dec 2006 19:20:15 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Thu, 14 Dec 2006, Shawn O. Pearce wrote:
> 
> > +int is_bare_git_dir (const char *dir)
> > +{
> > +	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
> > +		return 0;
> > +	const char *s = strrchr(dir, '/');
> > +	return !s || strcmp(s + 1, DEFAULT_GIT_DIR_ENVIRONMENT);
> >  }
> 
> This function does not really determine if the repo is bare. I have no 
> better name for it, though.

guess_if_bare_git_dir ?

I struggled to name that thing because it can't really tell, its just
guessing... but it is going to be right most of the time.  Of course
I'm sure there's some Git user somewhere who will confuse it.

-- 
