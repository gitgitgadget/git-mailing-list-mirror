From: Paul Mackerras <paulus@samba.org>
Subject: gitk highlighting descendents/ancestors
Date: Mon, 29 May 2006 22:35:06 +1000
Message-ID: <17530.60026.636981.60532@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon May 29 14:35:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkgxw-0004qZ-NP
	for gcvg-git@gmane.org; Mon, 29 May 2006 14:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWE2MfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 08:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWE2MfP
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 08:35:15 -0400
Received: from ozlabs.org ([203.10.76.45]:62416 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750782AbWE2MfO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 08:35:14 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6B92F67AC5; Mon, 29 May 2006 22:35:13 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20946>

I have implemented a feature in gitk (on the "new" branch) where it
can highlight the commits that are, or are not, descendents or
ancestors of the selected commit.  For now it is invoked via a
drop-down menu.  Does this look useful to people?

At the moment, if you select "Not descendent" then the selected
commit and all the commits below it will be highlighted (since they
can't be descendents of the selected commit).  Similarly if you select
"Not ancestor" then the selected commit and all commits above it are
highlighted.  That's technically correct but doesn't seem very useful;
maybe I should suppress those highlights.

Also, whatever matches the string put in the "Find" field will be
highlighted.  I have taken out the "Files" and "Pickaxe" options in
the Find function, and put the pickaxe function into a new drop-down
menu for the highlighting function.  I have code ready to go for
shift-up and shift-down to move to the previous/next highlighted row,
once Junio applies my tiny patch to builtin-diff-tree.c.

Paul.
