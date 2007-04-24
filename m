From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Only use ETC_GITCONFIG=$(prefix)/etc/gitconfig ifeq ($(prefix),$(HOME))
Date: Tue, 24 Apr 2007 02:19:11 -0400
Message-ID: <20070424061911.GQ17480@spearce.org>
References: <462D673A.1010805@freedesktop.org> <7v8xci9uea.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 08:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgEN3-00077W-EG
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 08:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161662AbXDXGTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 02:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161665AbXDXGTT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 02:19:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59812 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161662AbXDXGTS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 02:19:18 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgEMd-0005fv-Sr; Tue, 24 Apr 2007 02:19:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 52BF620FBAE; Tue, 24 Apr 2007 02:19:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v8xci9uea.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45418>

Junio C Hamano <junkio@cox.net> wrote:
> Josh Triplett <josh@freedesktop.org> writes:
> > Use ifeq in the Makefile to set ETC_GITCONFIG=/etc/gitconfig unless the prefix
> > points to $HOME .
> 
> I personally have four installations of git under $HOME by
> setting prefix to $HOME/git-{maint,master,next,pu}.  I would
> rather not see this to break, as I suspect there are other
> people who depend on this behaviour.

I second that.  :-)

$ cat config.mak
...
current_branch := \
	$(subst refs/heads/,,$(shell git-symbolic-ref HEAD 2>/dev/null))
ifeq ($(current_branch),)
	prefix := $(HOME)/sw/git-unknownbuild
else
	prefix := $(HOME)/sw/git-$(current_branch)
EOF

;-)

-- 
Shawn.
