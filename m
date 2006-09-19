From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 18:18:57 -0400
Message-ID: <20060919221857.GB11601@spearce.org>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com> <eeppkl$rm9$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:19:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPnwB-0004ug-4c
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWISWTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWISWTD
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:19:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48581 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751233AbWISWTB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 18:19:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPnvW-0007OI-N2; Tue, 19 Sep 2006 18:18:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EE22920E48E; Tue, 19 Sep 2006 18:18:57 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eeppkl$rm9$2@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27300>

Jakub Narebski <jnareb@gmail.com> wrote:
> Unfortunately, one cannot (as of now) use result of git-describe as
> <commit-ish>. I'd rather have it fixed, than port idea from _centralized_
> SCM do distributed SCM.

This doesn't work?

	git log $(git describe | cut -d- -f2 | sed 's/^g//')

Its obviously so clear and easy to type!  :-)

That should be pretty easy to teach sha1_name.c:get_sha1_basic to
look for the pattern commonly used by git-describe, break on "-g",
verify the tag, then unabbreviate the ID.

-- 
Shawn.
