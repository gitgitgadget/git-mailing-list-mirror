From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Respun - Scripts to use bundles to move data between repos
Date: Thu, 15 Feb 2007 23:37:32 -0500
Message-ID: <20070216043732.GA28894@spearce.org>
References: <11715851974102-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 05:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHuqp-0008Kq-VF
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 05:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423164AbXBPEhh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 23:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423165AbXBPEhh
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 23:37:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43832 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423164AbXBPEhg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 23:37:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHuqY-0003lE-1q; Thu, 15 Feb 2007 23:37:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4EE9420FBAE; Thu, 15 Feb 2007 23:37:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <11715851974102-git-send-email-mdl123@verizon.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39885>

Mark Levedahl <mdl123@verizon.net> wrote:
> 7) Pipe ref list directly into git-pack-objects. - doesn't handle
>    rev-list-args such as --since=5.days.ago, piping through git-rev-list
>    first does so I left it that way.

Yuck.  I just went back and looked at the pack-objects source.

Apparently we only accept ref names and SHA-1 values here, and
`--not` on a line by itself.  Nothing else is valid.

The documentation is a little misleading, as usually when we say
something is processed the same way as rev-list does it we usually
also mean that any valid option to rev-list is also a valid option
in that context.  Here its not.

-- 
Shawn.
