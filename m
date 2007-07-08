From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Push code for transport library
Date: Sun, 8 Jul 2007 17:14:18 -0400
Message-ID: <20070708211418.GA4436@spearce.org>
References: <Pine.LNX.4.64.0707081608100.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jul 08 23:14:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7e5L-0008TD-3g
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 23:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197AbXGHVOY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 17:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757202AbXGHVOY
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 17:14:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60540 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757157AbXGHVOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 17:14:23 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I7e55-0001ba-No; Sun, 08 Jul 2007 17:14:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0103620FBAE; Sun,  8 Jul 2007 17:14:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707081608100.6977@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51920>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> This moves the code to call push backends into a library that can be
> extended to make matching fetch and push decisions based on the URL it
> gets, and which could be changed to have built-in implementations
> instead of calling external programs.
...
> +static const struct transport_ops git_transport = {
> +	.set_option = set_git_option,
> +	.push = git_transport_push
> +};

Interesting.

But can we please avoid that struct initialization syntax?
I build Git with a C compiler that doesn't understand it.  No, I
can't upgrade the compiler.  In the past we've largely been able
to avoid using this feature of C99.  If you look at the current
codebase this would again become the first usage of the feature,
as I have long since eliminated all of them.

-- 
Shawn.
