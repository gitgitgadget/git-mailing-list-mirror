From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Don't crash during repack of a reflog with pruned commits.
Date: Thu, 21 Dec 2006 20:23:44 -0500
Message-ID: <20061222012344.GD14773@spearce.org>
References: <be6b1443171482e1930bd7744a0218db0c03d611.1166748450.git.spearce@spearce.org> <20061222004906.GC14789@spearce.org> <7vmz5g92h7.fsf@assigned-by-dhcp.cox.net> <20061222010018.GB14773@spearce.org> <emfbk4$f45$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 02:24:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxZ8r-00078l-Oc
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 02:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945900AbWLVBXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 20:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945901AbWLVBXt
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 20:23:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59046 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945900AbWLVBXs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 20:23:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GxZ8K-0000Vi-Ka; Thu, 21 Dec 2006 20:23:36 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0475420FB65; Thu, 21 Dec 2006 20:23:44 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <emfbk4$f45$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35112>

Jakub Narebski <jnareb@gmail.com> wrote:
> I still think it is a good idea to allow user (experienced user)
> to set to not consider reflog for saving. Especially that there
> exist repositories which have reflogs with long pruned commits,
> and it would be nice to preserve the reflog info, even if some of
> information is not available.

In my humble opinion there is *no* value in a reflog whose commits
are "corrupt" (due to missing commit object or missing tree/blob
it references) as you cannot get that commit back.  And its hard
to get any other data from it.

My local git.git repository got killed during a repack because
I was missing 1 blob (an old version of builtin-blame.c) from
Junio's pu branch.  Apparently I had a reflog on that tracking
branch which went back pretty far and although the commits in that
log were still available, the blob wasn't.

-- 
Shawn.
