From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/3] Remove more parsers
Date: Sun, 29 Jan 2006 14:04:19 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jan 29 20:02:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3HoW-00042F-1E
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 20:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWA2TCH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 14:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWA2TCH
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 14:02:07 -0500
Received: from iabervon.org ([66.92.72.58]:46605 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751110AbWA2TCG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 14:02:06 -0500
Received: (qmail 19670 invoked by uid 1000); 29 Jan 2006 14:04:19 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jan 2006 14:04:19 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15230>

I found some more open-coded tree parsers and a commit parser. These 
changes shouldn't affect behavior meaningfully, and all of the tests pass. 
I did notice, however, that the rev-list functionality of pruning by path 
isn't actually tested in the tests; I forgot to update it and it didn't 
cause any tests to fail. I also couldn't figure out if 
"same_tree_as_empty" has important side effects, so I updated its use of 
diff_tree; in order to do what the name says, "return t1 && !t1->entries" 
would suffice.

There's also a parser in convert-objects, but it may be best to keep it, 
since it may want to deal with things which are now considered invalid, 
and would be rejected by the normal parser.

	-Daniel
*This .sig left intentionally blank*
