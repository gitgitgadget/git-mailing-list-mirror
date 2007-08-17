From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: commit author x commit committer issue
Date: Fri, 17 Aug 2007 00:58:40 -0700
Message-ID: <20070817075840.GA9504@soma>
References: <46B9C92B.3000000@st.com> <20070816092002.GD16849@muzzle> <46C43F5F.3040508@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard MUSIL <richard.musil@st.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 09:58:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILwjF-0005mR-FD
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 09:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757542AbXHQH6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 03:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757486AbXHQH6m
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 03:58:42 -0400
Received: from hand.yhbt.net ([66.150.188.102]:39521 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066AbXHQH6l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 03:58:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 878462DC08E;
	Fri, 17 Aug 2007 00:58:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46C43F5F.3040508@st.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56050>

Richard MUSIL <richard.musil@st.com> wrote:
> Eric Wong wrote:
> > Richard MUSIL <richard.musil@st.com> wrote:
> > I also want to avoid creating extra junk on the SVN repository which I
> > don't personally consider very important.  SVK does stuff like that with
> > merges, and only SVK understands the metadata it uses.  I prefer
> > transparency.
> 
> I made some suggestions in this thread about using revision
> (unversioned) property of SVN fot git "metadata". AFAIK using rev. props
> is completely transparent to other SVN clients (in this case those not
> being git-svn), so they could easily ignore them.
> 
> It could be optional on git config property for commit and autodetected
> for clone/pull.
> 
> The scenario I could easily imagine (though it is not something I am
> currently using) is having dev teams using git internally (because its
> much easier for tracking local development) and having SVN repo as a
> "central hub". In such environment, there will be probably one person in
> each team (dev. lead) collecting commits from others and once things are
> set, he will commit all changes to svn. In that particular case, he does
> not have to worry about different sha1s, because they use only one SVN
> (as it was meant to be used). But he could be sad about losing all
> authors info about the people commits. And my personal believe is, this
> is how git-svn may enter svn world on big projects.
> 
> But you are right, it is up to you to decide. It was just an idea ;-).

It'd be easy for git-svn to write metadata to rev-props.  Whether or not
it reads and does anything with them is another issue...  I think Sam
was working on something that allowed it to track merges on the
git-side, but we'd be introducing a third or fourth method of
non-standard merge-tracking into SVN :)

In any case, this behavior should always be optional and off by default.

-- 
Eric Wong
