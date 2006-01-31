From: Jonas Fonseca <fonseca@diku.dk>
Subject: [Cogito] Various bugs
Date: Tue, 31 Jan 2006 05:13:18 +0100
Message-ID: <20060131041318.GC30744@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Jan 31 05:13:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3mtT-0006Bf-3Q
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 05:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWAaENW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 23:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWAaENW
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 23:13:22 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:63386 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1030206AbWAaENV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2006 23:13:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id B449C52D46B;
	Tue, 31 Jan 2006 05:13:20 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30270-10; Tue, 31 Jan 2006 05:13:19 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 1DD4652D2E4;
	Tue, 31 Jan 2006 05:13:19 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id EB97A6DF88D; Tue, 31 Jan 2006 05:12:43 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0634961A1B; Tue, 31 Jan 2006 05:13:18 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15300>

A few Cogito bugs I found yesterday.

 - cg-fetch between local repos fails when the cloned branch URL does
   not point to a .git directory and a needed object from the repository
   being cloned is packed. git-local-fetch expects a .git directory.

 - cg-commit -c will do the wrong thing (use the invokers gecos info)
   when the author name is empty. One workaround is to make
   pick_author_script append a space at the end of the GIT_* variables.
   GIT will strip those and no gecos info is used.

 - cg-status reports a deleted file both as deleted and as unknown:

	fonseca@antimatter:~/src/elinks/0.12 > git --version
	git version 1.1.6.g1506
	fonseca@antimatter:~/src/elinks/0.12 > cg --version
	cogito-0.17pre.GIT (d3aa9a2b3375e36c774ea477492db76baa1db03e)
	fonseca@antimatter:~/src/elinks/0.12 > cg rm AUTHORS
	Removing file AUTHORS
	fonseca@antimatter:~/src/elinks/0.12 > cg status | grep AUTHORS
	? AUTHORS
	D AUTHORS

-- 
Jonas Fonseca
