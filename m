From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Documentation/git-ls-tree.txt: Add a caveat about
	prefixing pathspec
Date: Mon, 21 Jul 2008 23:04:52 +0200
Message-ID: <20080721210452.GP10151@machine.or.cz>
References: <20080720233956.GH10151@machine.or.cz> <20080721075618.14163.45309.stgit@localhost> <7v1w1nvf7q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 23:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL2Zu-0004G7-PT
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 23:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbYGUVEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 17:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbYGUVEz
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 17:04:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44643 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbYGUVEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 17:04:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4F79E393B308; Mon, 21 Jul 2008 23:04:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1w1nvf7q.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89404>

On Mon, Jul 21, 2008 at 01:00:57AM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > +Note that within a subdirectory of the working copy, 'git ls-tree'
> > +will automatically prepend the subdirectory prefix to the specified
> > +paths and assume just the prefix was specified in case no paths were
> > +given --- no matter what the tree object is!
> 
> Don't be negative upfront.  Explain why this is a good thing first.
> 
> 	... were given.  This is useful when you are deep in a
> 	subdirectory and want to inspect the list of files in an arbitrary
> 	commit.  E.g.
> 
> 		$ cd some/deep/path
> 		$ git ls-tree --name-only -r HEAD~20
> 
> 	will list the files in some/deep/path (i.e. where you are) 20
> 	commits ago, just like running "/bin/ls" there will give you the
> 	list of files you have right now.

Frankly, I think this is overdoing it. I'm all for being positive, but
it is obvious why this is good thing when you inspect a root tree and
there's no need to be too wordy about it - it should be enough to
acknowledge this later by the "as expected" as I note below.

The documentation should be detailed and complete, but not too chatty,
or it gets too hard to read again.

> > +Thus, within a subdirectory, 'git ls-tree' behaves as expected
> > +only when run on a root tree object (e.g. with a 'HEAD' tree-ish,
> > +but not anymore when passed 'HEAD:Documentation' instead).
> > +
> > +
> >  OPTIONS
> >  -------
> >  <tree-ish>::

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
