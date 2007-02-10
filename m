From: Theodore Tso <tytso@mit.edu>
Subject: Re: git-pull and tag objects
Date: Sat, 10 Feb 2007 09:23:22 -0500
Message-ID: <20070210142322.GB25607@thunk.org>
References: <1170933407.15431.38.camel@okra.transitives.com> <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com> <7v4ppurka1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 15:23:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFt8Z-00063p-3F
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 15:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbXBJOXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 09:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbXBJOXc
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 09:23:32 -0500
Received: from THUNK.ORG ([69.25.196.29]:45091 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932257AbXBJOXb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 09:23:31 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HFtDW-00024Y-0M; Sat, 10 Feb 2007 09:28:42 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HFt8M-00033K-J0; Sat, 10 Feb 2007 09:23:22 -0500
Content-Disposition: inline
In-Reply-To: <7v4ppurka1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39218>

Thanks for this great explanation of how tags work.  Hopefully some or
all of this can get incorporated into the git's user's manual.
Adding the paragraph to the git-tag as you did in your patch is a
good start, but having the entire explanation of how things work in
the user's manual would be a really good thing, IMHO.

This brings up another question which I've been looking for, but for
which I haven't found a good answer in the git documentation.  A
google search shows a suggestion by hpa (and a brief discussion from
sct) about how to handle conflicting tags back in 2005, but as far as
I can tell it didn't go anywhere.

Anyway, the questions that don't appear to be addressed in the git
documentations are:

1) Suppose I do a "git tag" of a release, and then realize that I
messed up, and I need to do some additional release work (i.e.,
editing a debian changelog file, etc.) before really doing another
release, what do I do to tag a later revision as the "real" version
v1.2?

2) Suppose I have v2.6.20 pointing to a particular revision, which was
obtained from pulling from Linus's tree, and I pull from some other
tree, say the wireless tree, and the maintainer there either
accidentally or maliciously has the tag v2.6.20 pointing to some other
revision.  What happens in that case?  Does the answer change if the
tag is a signed vs. unsigned tag?

3) The git-tag man page talks about GPG signing tags, but it doesn't
talk about how a GPG-signed tag is validated.  Does this happen
manually or automatically?  If it happens manually, how should a tag
be verified?  If the answer is using git-verify-tag, then there should
probably be better references in the documentation to git-verify-tag.
It might also be a very good idea to have a config option which
automatically verifies signed tags.

4) Is there a good/easy way to show whether a tag is a signed
vs. unsigned tag?  Short of using "git cat-file -t <tag>", there
doesn't seem to be, and being forced to use a low-level git command to
get that kind of information seems.... unsatisfactory.

Thanks,

						- Ted
