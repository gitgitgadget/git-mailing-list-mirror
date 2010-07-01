From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Why is "git tag --contains" so slow?
Date: Wed, 30 Jun 2010 20:54:15 -0400
Message-ID: <E1OU82h-0001xY-3b@closure.thunk.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 02:55:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU83U-0007IW-BG
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 02:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045Ab0GAAyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 20:54:17 -0400
Received: from thunk.org ([69.25.196.29]:42561 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808Ab0GAAyR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 20:54:17 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OU82h-0007PU-Sw; Wed, 30 Jun 2010 20:54:15 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OU82h-0001xY-3b; Wed, 30 Jun 2010 20:54:15 -0400
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150002>


I'm trying to write a script that can determine the first kernel release
(i.e., a tag of that matchs v2.6.*) that contains a particular commit.

I can do this using "git tag --contains <commit-id>", but it's quite
slow.  It takes something like 8-9 seconds.  (8.5 seconds of user time,
8.6 times of wall clock, to be precise).

I can get the information much faster using "gitk -1 <commit-id>", which
finishes painting the screen in under 2 seconds, but that throws up a
GUI and then a human has to pull the information out using their eyes.
(Yeah, or I could figure out where in the 11,631 lines of Tcl script the
"preceeds" line is calculated, but I figured I'd ask here first.)

Is there a better way of calculating what I want from the command line
using the built-in native git tools?  And if so, why is git tag
--contains apparently 4 times slower than gitk at performing this task?

Thanks,

						- Ted
