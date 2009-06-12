From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Mercurial on BigTable
Date: Thu, 11 Jun 2009 20:46:45 -0700
Message-ID: <20090612034645.GO16497@spearce.org>
References: <d411cc4a0906101215t313b2037k713aa1ce974c30cc@mail.gmail.com> <4A3065C5.3070203@op5.se> <m34oun41pz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 05:47:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MExjF-0005Vd-9u
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 05:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944AbZFLDqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 23:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbZFLDqn
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 23:46:43 -0400
Received: from george.spearce.org ([209.20.77.23]:59012 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbZFLDqm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 23:46:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 62477381FD; Fri, 12 Jun 2009 03:46:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m34oun41pz.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121387>

Jakub Narebski <jnareb@gmail.com> wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> > I'm more curious as to why they didn't choose git. The only explanation
> > that was actually true is that hg works well over HTTP 
> 
> Well, Google App Engine was in Python, so it follows that the crew
> would have it easier understanding Mercurial code (which is written in
> Python with parts in C for performance), and in moving it to BigTable.

This has nothing to do with Google AppEngine.  GAE has CPU and
bandwidth limitations in place that make running a source code server
like Hg on it impossible.  E.g. the maximum size you could download
in a single HTTP request was 1 MB, now its up to 10 MB (IIRC).
The Hg hosting runs in a different cluster than the GAE hosting does,
and are managed by different teams.

> Adding Java to Gogle App Engine is, as far as I know, fairly recent;

True, yes, GAE Java support is fairly new.

> additionally JGit (git implementation in Java) is not yet full
> implementation.

JGit implements sufficient parts of Git to be a full server, and
could power a hosting site... indeed it powers Gerrit Code Review,
which some companies do use as their entire Git server solution,
rather than e.g. Gitosis.
 
-- 
Shawn.
