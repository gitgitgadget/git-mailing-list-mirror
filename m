From: "Theodore Ts'o" <tytso@mit.edu>
Subject: How to manage heads on a remote repository?
Date: Sun, 14 Oct 2007 06:46:25 -0400
Message-ID: <E1Ih0zJ-0004FZ-0A@tinytim.thunk.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 12:46:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih0zn-0005Q6-1K
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 12:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbXJNKqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 06:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755368AbXJNKqo
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 06:46:44 -0400
Received: from thunk.org ([69.25.196.29]:37734 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755431AbXJNKqn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 06:46:43 -0400
Received: from root (helo=tinytim.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Ih19M-0002MI-Cz; Sun, 14 Oct 2007 06:56:48 -0400
Received: from tytso by tinytim.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Ih0zJ-0004FZ-0A; Sun, 14 Oct 2007 06:46:25 -0400
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60826>


I'm currently exploring the idea of not only making the equivalent of
"pu" and "next" available on a public repository for one of my projects,
but also the topics/* branches.   When thinking about how I might do
this, one snag I ran into is that the topics/foo and topics/bar branches
are ephemeral, and so when I replicate them to a remote repository,
either on kernel.org or repo.or.cz, I would need a way of removing a
head for a topic branch that had already been merged.

Creating new topics/foo branch or updating is easy; just do a git push,
and they will get created on the remote side.  I don't see an easy way
of deleting a ref on a remote branch, so any automation at the moment
looks like it would require me writing my own script and using something
like this:

      ssh remote-host git --git-dir=xxx branch -D topics/foo

... which of course wouldn't work repo.or.cz since it requires shell
access.

Am I missing anything?

							- Ted
