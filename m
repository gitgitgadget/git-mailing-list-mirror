From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Rebase v.s. fast forward
Date: Sun, 22 Feb 2009 20:00:36 +0100
Message-ID: <20090222190036.GB6504@efreet.light.src>
References: <1234914604.3334.7.camel@rottwang.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Sun Feb 22 20:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbJaa-00047m-M2
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 20:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbZBVTAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 14:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbZBVTAj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 14:00:39 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:34668 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbZBVTAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 14:00:39 -0500
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by mail.bluetone.cz (Spam Firewall) with ESMTP
	id 1720D32B55F; Sun, 22 Feb 2009 20:00:36 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by mail.bluetone.cz with ESMTP id QcWejv03HsJKBDnT; Sun, 22 Feb 2009 20:00:36 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1LbJZ6-0004iF-Oh; Sun, 22 Feb 2009 20:00:36 +0100
Content-Disposition: inline
In-Reply-To: <1234914604.3334.7.camel@rottwang.fnordora.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111050>

On Tue, Feb 17, 2009 at 15:50:04 -0800, Alan wrote:
> I am dealing with a kernel branch of a branch that undergoes frequent
> rebases and I want to know the easiest way of handling things.
> 
> The tree is pulled from kernel.org. Patches are applied to the tree by a
> developer here on a branch.  I take that branch, make my own branch, add
> drivers and other modifications and publish to a different repo.
> 
> Now that 2.6.29 is occurring, every time there is a new RC candidate, he
> rebases the tree and tells everyone to rebuild.  Since the developers on
> my projects have their own branches off of my tree, rebuilding
> everything is starting to look like a big pain.
> 
> Is there a way to take a rebased repository and apply the changes in a
> manner that does not require reconstructing everything from patches?

No, there is not. When you have some changes on top of rebased branch, you
have to rebase them.

> Can you fast forward on a rebased repo or are you just hosed?  (Or would
> that be considered "frebasing"?)

Well, fast-forward condition is when you pull and you have no local changes.
Which I guess is not your case.

I am not sure whether pull properly detects the case, where the pulled branch
got rebased (so strictly-speaking it's not a fast-forward), but there are no
local changes, but since you probably do have some local changes, it would
not help you.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
