From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC] statplot: a tool for mining repository statistics.
Date: Thu, 1 Mar 2007 13:30:04 -0500
Message-ID: <20070301183004.GB8858@spearce.org>
References: <20070301072953.GA8730@spearce.org> <81b0412b0703010158i1a3963f4wabda2f72c1fd0bc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 19:30:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMq2e-0007Fz-8J
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 19:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965484AbXCASaK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 13:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965474AbXCASaK
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 13:30:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42288 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965484AbXCASaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 13:30:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMq2R-000278-B8; Thu, 01 Mar 2007 13:29:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3866120FBAE; Thu,  1 Mar 2007 13:30:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <81b0412b0703010158i1a3963f4wabda2f72c1fd0bc4@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41112>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Tried it on my repo but the program produced some records with
> all zeros. I.e.:
> 2005-11-10 6 222 235 463 1785888
> 2005-11-11 3 34 2 39 9729
> 2005-11-12 0 0 0 0 0
> 2005-11-13 0 0 0 0 0
> 2005-11-14 6 227 330 563 716230
> 2005-11-15 3 121 209 333 1162839
> 
> What could this possibly mean?

There were no new objects attributed to 12 and 13 of Nov, 2005.
The program allocates a zero'd array for every day in the entire
range, then increments each day with the number of objects introduced
by commit(s) on that day.  It then just prints the entire array,
rather than only printing the non-zero lines.  ;-)

Horribly simple code.  Maybe too dumb for inclusion in git.git.

-- 
Shawn.
