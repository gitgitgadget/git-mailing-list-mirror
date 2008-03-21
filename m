From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Switching branches without committing changes
Date: Fri, 21 Mar 2008 00:06:47 -0400
Message-ID: <20080321040647.GE8410@spearce.org>
References: <A17C3E8C-3D0E-41B4-8A43-37EC8C3F55C2@faithfulgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:07:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcYXX-00016g-L4
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 05:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbYCUEGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 00:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbYCUEGv
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 00:06:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55109 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbYCUEGu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 00:06:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JcYWZ-000898-Od; Fri, 21 Mar 2008 00:06:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A930720FBAE; Fri, 21 Mar 2008 00:06:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <A17C3E8C-3D0E-41B4-8A43-37EC8C3F55C2@faithfulgeek.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77702>

Joe Fiorini <joe@faithfulgeek.org> wrote:
> I'm still a newbie to Git (and this list), so if I don't provide  
> enough details please let me know what you need and I will provide :).
> 
> I'm trying to switch branches without committing my changes.  Is this  
> possible?  For example, I'm working on a site, I'm testing the  
> implementation of a new technology (branch B), I'm not quite done  
> there (or I forget to commit everything) and I want to implement  
> something else new.  I create a new branch off of B, called B.1, and  
> then make some changes.  I commit only the changes that apply to B.1  
> and then try to go back to B.  However, I get an error saying a file I  
> changed in B is not uptodate and it cannot merge.  What am I doing  
> wrong and how can I get back to B?

Use `git checkout -m` to switch the branch anyway.  However, if
there is a merge conflict while you are trying to carry the changes
to the other branch you may be faced with a merge conflict you are
not prepared to resolve, or simply cannot resolve in a reasonable
period of time.

You may want to use `git stash` to save your dirty changes off to
a safe area, then switch branches.  Your changes won't be there,
but you can get them back with `git stash apply 0`.  If things go
badly, you can go back to B.1 and use `git stash apply 0` to put
the changes back where they were, and figure out what you are going
to do from there.

-- 
Shawn.
