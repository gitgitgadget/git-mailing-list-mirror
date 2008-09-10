From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] origin link for cherry-pick and revert, and more about
	porcelain-level metadata
Date: Wed, 10 Sep 2008 12:44:24 +0200
Message-ID: <20080910104424.GH10360@machine.or.cz>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080909230525.GC10360@machine.or.cz> <48C794D6.20001@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 12:45:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdNCb-00040s-01
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 12:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbYIJKo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 06:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbYIJKo2
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 06:44:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43962 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbYIJKo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 06:44:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 71F14393A2DD; Wed, 10 Sep 2008 12:44:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48C794D6.20001@gnu.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95510>

On Wed, Sep 10, 2008 at 11:35:18AM +0200, Paolo Bonzini wrote:
> 
> > Why do you actually *follow* the origin link at all anyway? Without its
> > parents, the associated tree etc., the object is essentially useless for
> > you
> 
> Stephen posed the origin links as weak, but it is not necessarily true
> that you don't have the parents and the associated tree.  For example,
> if you download a repository that includes a "master" branch and a few
> stable branches, you *will* have the objects cherry-picked into stable
> branches, because they are commits in the master branch.

But that is irrelevant. If you already have the objects, whether to
follow the origin link does not matter at all.

I argue that the following the origin link by one step is harmful as it
violated the internal Git object model and does not have real benefits.
If you want to have the origin links, do not follow them at all - the
commit objects themselves are not useful. (Or, optionally, follow them
fully - that of course can make sense.)

> > And why are the notes created by git cherry-pick -x insufficient for that?
> 
> For example, these notes (or the ones created by "git revert") are
> *wrong* because they talk about commits instead of changesets (deltas
> between two commits).

(BTW, I don't feel strongly enough about the header-freeform distinction
to argue about it and some of your and others' points are good. But even
if we have the origin links, I think we should only follow them not at
all or fully.)

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
