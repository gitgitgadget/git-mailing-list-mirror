From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and file name case on cygwin
Date: Sat, 3 Feb 2007 17:38:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702031733190.8424@woody.linux-foundation.org>
References: <ad8ce5c20702031400h78ddc11o34f98a461339bb55@mail.gmail.com>
 <Pine.LNX.4.64.0702031716130.8424@woody.linux-foundation.org>
 <7vmz3uzpc2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Niklas_H=F6glund?= <nhoglund@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 02:38:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDWLC-0001sL-N4
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 02:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbXBDBit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 20:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbXBDBis
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 20:38:48 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55668 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbXBDBis (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 20:38:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l141cIQ5007426
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 3 Feb 2007 17:38:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l141cHfh020078;
	Sat, 3 Feb 2007 17:38:17 -0800
In-Reply-To: <7vmz3uzpc2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.392 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.173 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38632>



On Sat, 3 Feb 2007, Junio C Hamano wrote:
> 
> Are there plans to "fix" the confusion by renaming them to
> reduce chances of name clashes on such suboptimal filesystems?

I don't think so. Nobody really does development on such broken 
filesystems, and I kind of have this nagging suspicion that Niklas noticed 
just because he wanted to test git, not because he really wanted to do 
Linux development under Windows ;)

That said, it might not be horrible to do. Doing

	git ls-files | sort -f | uniq -ic | grep -v ' 1 '

shows that we only have 19 names so afflicted, and they're all in 
netfilter. Maybe the netfilter people could be convinced not to do it.

But really, do we actually expect anybody to really *care*?

		Linus
