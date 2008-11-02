From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Sat, 1 Nov 2008 21:06:34 -0400
Message-ID: <20081102010634.GF8134@mit.edu>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <20081030143918.GB14744@mit.edu> <1225389068.19891.28.camel@maia.lan> <51419b2c0811011327j492b520dq2388fc8972b48cab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	Sam Vilain <samv@vilain.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 02:08:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwRSB-0004kE-Fw
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 02:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbYKBBGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 21:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbYKBBGi
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 21:06:38 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:48009 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752008AbYKBBGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 21:06:37 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KwRQI-0003k3-Pq; Sat, 01 Nov 2008 21:06:34 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KwRQI-00064q-5D; Sat, 01 Nov 2008 21:06:34 -0400
Content-Disposition: inline
In-Reply-To: <51419b2c0811011327j492b520dq2388fc8972b48cab@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99792>

On Sat, Nov 01, 2008 at 02:27:03PM -0600, Elijah Newren wrote:
> 
> There is another option, though it has its own problems too.  There
> are basically two kinds of reverting here -- reverting all the changes
> *in* a given revision (which I'll called 'revert-in') and reverting
> all the changes *since* a given revision (typically HEAD; I'll call
> this 'revert-since').  These two operations can be supported from the
> same command, though their use cases are different enough that it may
> seem slightly weird:

In my opinion, that is a Really Bad Idea from a usability and UI
design point of view.  Each command should do one and only one thing,
and not do different things depending on what options you give it.
Git violates this rules in a number of places already, What you call
"revert-since" and "revert-in" are so different that using the same
subcommand is just going to horribly confuse users.

Better to have "git revert" print a message explining that it is
deprecated, and to tell users that they probably want either "git
cherry-pick --revert" or "git revert-file", depending on whether they
are an experienced git user (in which case they probably want git
cherry-pick --revert"), or if that person who is familiar svn or hg's
"svn revert" or "hg revert", they probably want "git revert-file".

     	     	    	     	  	   - Ted
