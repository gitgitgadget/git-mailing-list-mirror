From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Mon, 16 Apr 2007 08:45:55 -0400
Message-ID: <E1HdQah-0008Q2-7E@candygram.thunk.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:46:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdQbD-0007EC-Py
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 14:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbXDPMqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 08:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbXDPMqH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 08:46:07 -0400
Received: from thunk.org ([69.25.196.29]:52900 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030506AbXDPMqG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 08:46:06 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HdQhC-0007Xe-D1; Mon, 16 Apr 2007 08:52:40 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HdQah-0008Q2-7E; Mon, 16 Apr 2007 08:45:55 -0400
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44642>


I've recently noticed that I'm often firing up gitk for no other purpose
than to see which changesets have which tags and branch heads.  Often
I'll fire up gitk, quickly look at the tags/branches, and then kill it
before it's done parsing the repository, resulting in python errors as
it dies.

So I'm wondering why we haven't arranged to have git-log show this
information, and whether there would be any objections if "git-log"
showed something like this:

commit 7d5021d2ef5d414908d8e4db26c324c1de19f9f1
Head: tytso-patches-20070223
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Fri Feb 23 14:46:01 2007 -0500

Cherry pick "unload head on shutdown" patch

...

commit c8f71b01a50597e298dc3214a2f2be7b8d31170c
Tag: v2.6.21-rc1
Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date:   Tue Feb 20 20:32:30 2007 -0800

    Linux 2.6.21-rc1

Would there be objections in adding this to --pretty=medium (i.e., the
default), or would it be better to add something like tihs to
--pretty=full or --pretty=fuller?

The only reason why I could imagine not doing this by default would be a
potential performance problem if there were thousands of heads or branch
heads.

						- Ted
