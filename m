From: tytso@mit.edu
Subject: Re: [RFC/PATCH] rebase: add -x option to record original commit
 name
Date: Sat, 6 Feb 2010 08:32:27 -0500
Message-ID: <20100206133227.GE321@thunk.org>
References: <1265419166-21388-1-git-send-email-jaysoffian@gmail.com>
 <7vzl3ngn7w.fsf@alter.siamese.dyndns.org>
 <76718491002051758s577d8b5eq2323cd66d479662@mail.gmail.com>
 <7vtytvf4vp.fsf@alter.siamese.dyndns.org>
 <76718491002052018s324747ecj31963b493868dbbd@mail.gmail.com>
 <7vbpg3dldq.fsf@alter.siamese.dyndns.org>
 <76718491002052119j5d6bae35s146bed8da03e3983@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 14:32:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdkmI-0002kx-Kf
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 14:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755852Ab0BFNcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 08:32:41 -0500
Received: from THUNK.ORG ([69.25.196.29]:37961 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755783Ab0BFNce (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 08:32:34 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1Ndklw-0004aW-Am; Sat, 06 Feb 2010 08:32:28 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1Ndklv-0004Ua-ML; Sat, 06 Feb 2010 08:32:27 -0500
Content-Disposition: inline
In-Reply-To: <76718491002052119j5d6bae35s146bed8da03e3983@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139164>

On Sat, Feb 06, 2010 at 12:19:02AM -0500, Jay Soffian wrote:
> On Fri, Feb 5, 2010 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > How could that be a counterproposal to a deprecation of -x and adding
> > hooks as a replacement, as a solution to more general issues?
> 
> Sorry, it's been a long week and I wasn't thinking clearly.
> 
> Yes, adding post-cherry/rebase hook(s) would keep all parties happy. :-)

I really don't think it's a contamination of the log when it's used to
record a cherry pick of patch from the dev stream to an older
maintainance branch, but I'll grudgingly accept doing via a hook; but
can there be an easy way to control whether or not the hook is
actually executed?  

*Normally* I don't want cherry-pick -x, but some of the time I do want
it, and manually enabling and disabling the hook by having to do some
kind of "chmod -x .git/hooks/cherry-pick" command.  I suppose I could
create an alias for cherry-pick-record which does a "chmod a+x `git
rev-parse --git-dir`/hooks/cherry-pick; git cherry-pick $*; chmod a-x
`git rev-parse --git-dir`/hooks/cherry-pick", but that seems really
hacky.  :-(

So it would be nice if there was some kind of command-line option to
cherry-pick which could be passed to the hook script.

					- Ted
