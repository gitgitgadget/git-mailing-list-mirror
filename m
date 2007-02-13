From: Theodore Tso <tytso@mit.edu>
Subject: Re: Including the release notes in the git-1.5.0 release?
Date: Tue, 13 Feb 2007 13:05:41 -0500
Message-ID: <20070213180541.GH8670@thunk.org>
References: <E1HGyPn-0003Te-9s@candygram.thunk.org> <7vzm7ix895.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH22e-0000CB-Uf
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbXBMSFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXBMSFs
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:05:48 -0500
Received: from thunk.org ([69.25.196.29]:53281 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbXBMSFs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:05:48 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HH27Q-0002MA-I0; Tue, 13 Feb 2007 13:11:08 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HH229-00006u-L0; Tue, 13 Feb 2007 13:05:41 -0500
Content-Disposition: inline
In-Reply-To: <7vzm7ix895.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39565>

On Tue, Feb 13, 2007 at 09:44:22AM -0800, Junio C Hamano wrote:
> As the text assumes familiarity with git 1.3.0 or so, I am not
> sure if making it as one of the manpages makes much sense.

Yeah, that's a good point.

> Also there is a question of what to do when 1.6.0 comes out.
> Will its release notes replace 1.5.0 one?  If so changes from
> which version will it describe?

What I've seen some projects do (including some commercial products)
is to keep them around with the old file names.  So if we have

Documentation/RELEASE-NOTES_1.5.0.txt
Documentation/RELEASE-NOTES_1.6.0.txt
Documentation/RELEASE-NOTES_1.7.0.txt

and a symlink from RELEASE-NOTES to Documentation/RELEASE-NOTES-<cur_ver>.txt

that would make a lot of sense....

> and have pointer to v1.5.0.txt from Documentation/git.txt would
> be a sensible and easy thing to do.

The only reason why I suggest Documentation/RELEASE-NOTES_1.5.0.txt
instead of Documentation/v1.5.0.txt is that it might not be as obvious
what "v1.5.0.txt" is for someone just looking at it in the
Documntation directory, where as "RELEASE-NOTES_1.5.0.txt leaves no
doubt.

But keeping the the old release notes around is good both for people
who are upgrading from older versions, and it also means that for
someone who wants to answer the question, "suppose we want to enable
feature <foo>", what which older versions of git clients will be
breaking.  

(I was about to suggest that we just break the older git clients using
dumb http protecols on kernel.org, befure I realized that that meant
breaking git clients that were released last August.  Whoops; it's
amazing how much improvements git has seen in the last six months,
that it seems a lot longer ago... :-)

							- Ted
