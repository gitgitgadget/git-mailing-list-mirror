From: Linus Torvalds <torvalds@osdl.org>
Subject: git merge performance problem..
Date: Sat, 15 Jul 2006 14:48:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607151445270.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jul 15 23:48:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1s0M-0001Bo-KS
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 23:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945920AbWGOVsv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Jul 2006 17:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945926AbWGOVsv
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Jul 2006 17:48:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53911 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945920AbWGOVsu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Jul 2006 17:48:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6FLmknW022523
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 15 Jul 2006 14:48:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6FLmjCS006512;
	Sat, 15 Jul 2006 14:48:46 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.698 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23939>


Junio, I think there is something wrong with git-merge. It sometimes takes 
up to ten seconds, and it's stuck at the

	git-show-branch --independent "$head" "$@"

call.

I don't know quite what that thing is even meant to do (we do already know 
the parents, why do we do something special here?) but even apart from 
that, the whole thing must be doing something seriously wrong, since it 
takes so long. Does it check the whole commit history?

		Linus
