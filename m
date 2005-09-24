From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Fri, 23 Sep 2005 17:43:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509231737140.3308@g5.osdl.org>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter TB Brett <peter@peter-b.co.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 02:44:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIy8l-00083S-IY
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 02:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVIXAn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 20:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbVIXAn2
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 20:43:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10647 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750900AbVIXAn1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 20:43:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8O0hM4s019500
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Sep 2005 17:43:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8O0hKvC018824;
	Fri, 23 Sep 2005 17:43:21 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9216>



On Fri, 23 Sep 2005, Linus Torvalds wrote:
> 
> Davide, maybe I'm being stupid, but I'm thinking that it might be possible
> to generate a -u3 diff by basically walking the xdiff file in a linear
> fashion: if the edits are in strictly ascending order

Ahh, no. Looking at the xdiff format, the edits are strictly ascending in 
the destination, but they may take stuff from the source in any order, so 
it's not like you can generate a diff from it by just walking it.

Oh, well. I guess we're better off just using the external diff command, 
even if it is slower to execve an external diff. 

The GNU diff sources are hard enough to read that I don't think we want to 
try to merge the unified diff generation from there.

		Linus
