From: Linus Torvalds <torvalds@osdl.org>
Subject: Command line hint of the day
Date: Mon, 14 Nov 2005 10:58:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511141049410.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 14 20:00:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbjXK-0003oT-TM
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 19:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVKNS6g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 13:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVKNS6g
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 13:58:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51427 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751238AbVKNS6g (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 13:58:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAEIwYnO026462
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 10:58:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAEIwYpB023120
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 10:58:34 -0800
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11836>


So I got a question about ppp in the kernel, and quite frankly, the things 
I know about ppp can be engraved with a jack-hammer on a grain of rice.

So what did I do?

	git whatchanged $(git-ls-files *ppp*)

actually does something useful. It will only look at files that are 
_currently_ called *ppp*, so you'd not see files that have been deleted, 
but it does the right thing for what I wanted.

You can also do "git log" or "gitk" instead of "git whatchanged", but the 
whatchanged thing has the advantage that it can run incrementally. Doing a 
"git log" ends up figuring out _all_ the commits before it can display 
them, since it also does the densification etc.

Maybe we should have a git man-page section of "strange but useful 
examples"? Things people do just because they are useful, but may not be 
immediately obvious to somebody who comes from CVS-land and uses git as 
just another old SCM?

		Linus
