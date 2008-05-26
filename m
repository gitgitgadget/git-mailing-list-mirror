From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git and appending merge commits
Date: Mon, 26 May 2008 00:51:36 -0400
Message-ID: <20080526045136.GC30245@spearce.org>
References: <483A300E.6090104@zombino.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Majer <adamm@zombino.com>
X-From: git-owner@vger.kernel.org Mon May 26 06:52:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0UhE-0002vd-6G
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 06:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbYEZEvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 00:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbYEZEvk
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 00:51:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50666 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbYEZEvk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 00:51:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K0UgM-0001x6-DR; Mon, 26 May 2008 00:51:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BC24420FBAE; Mon, 26 May 2008 00:51:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <483A300E.6090104@zombino.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82899>

Adam Majer <adamm@zombino.com> wrote:
...
>   5. append master merge changeset
> 
> #5 results in "messsed up" diffs
> 
> For an example of such a mess up please see,
> 
> http://git.debian.org/?p=collab-maint/mrtg.git;a=commitdiff;h=a8bc78ffd6d51ab09a791fa97e25f57b60eecd06
> 
> It appears that the tool generates a patch to a patch and displays that
> instead of the appended merge diff which is what I would have expected..
> 
> Is current output by design?

Yes, it is by design.  This is a feature of Git that very few
(if any) other systems have.

What you are seeing here is a combined diff.  It is a diff of the
final output of the merge against its two parents (the two branches
that were merged together).  Places where both a "++" or "--" prefix
a line indicate a place where the merge commit adds something that
is not in either parent.  This is stuff that the merge author edited
himself/herself during the merge.

If you had not amended the merge, you would have seen a less
interesting diff here, as the combined diff output tries to
avoid showing trivial changes.

-- 
Shawn.
