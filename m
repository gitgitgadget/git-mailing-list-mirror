From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git SVN Rebranching Issue
Date: Tue, 4 Nov 2008 16:33:19 -0800
Message-ID: <20081105003318.GA5666@hand.yhbt.net>
References: <20081103140746.GA5969@mars.cyantechnology.local> <20081104084111.GB14405@untitled> <20081104094224.GC24100@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kern <matt.kern@undue.org>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 01:34:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxWLy-0001w4-Kk
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 01:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbYKEAdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 19:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbYKEAdV
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 19:33:21 -0500
Received: from hand.yhbt.net ([66.150.188.102]:36239 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441AbYKEAdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 19:33:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 855402DC01B;
	Wed,  5 Nov 2008 00:33:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081104094224.GC24100@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100131>

Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Tue, Nov 04, 2008 at 12:41:11AM -0800, Eric Wong wrote:
> > 
> > Short answer: you can use grafts to remove parents.
> 
> Using grafts requires some cautious, especially when it is used to make
> some commits unreachable, because git gc can remove unreachable commits.
> Also, a repository with grafts cannot be cloned.  So using grafts looks
> like more as workaround rather a real solution.

I don't think extra history is harmful at all, so the grafts could even
be temporary.  AFAIK, the extra history is only an aesthetic issue in
visualizers (and I actually like to see it myself).

Besides, git svn is just a workaround until the SVN repository is
replaced entirely by git :)

> > It was actually an intentional design decision on my part preserve
> > parents based on branch name.  We would eventually otherwise lose
> > history of the now-deleted branches, as reflogs can expire.
> 
> Would it not be better to save the old branch using "@SVN-NUMBER" as
> suffix? Thus, those do not need the old branch can easily delete it.

That would require renaming _existing_ branches to their "@SVN-NUMBER"
name; which would break mechanisms for tracking branches based on
refname.

-- 
Eric Wong
