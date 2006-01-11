From: Linus Torvalds <torvalds@osdl.org>
Subject: git binary size...
Date: Wed, 11 Jan 2006 10:26:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jan 11 19:26:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwkgC-0008Cp-1T
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 19:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWAKS0X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 13:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWAKS0X
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 13:26:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32154 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964772AbWAKS0W (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2006 13:26:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0BIQIDZ028830
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Jan 2006 10:26:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0BIQHdt032403;
	Wed, 11 Jan 2006 10:26:18 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14494>


Guess what the difference is here?

	[torvalds@g5 ~]$ du -sh bin/
	14M     bin/
	[torvalds@g5 ~]$ du -sh bin/
	5.8M    bin/

Give up?

In one case, "git" was compiled with the default options in the git 
Makefile. In the other one, the "-g" was removed.

Now, maybe this is extra visible with PowerPC (32-bit) binaries, and it's 
not as bad on x86, but it's still a bit distressing.

That "-g" doesn't buy users much of anything, and I doubt most developers 
care that deeply most of the time either (and can easily add it when they 
do care). It's left-over from long ago when it was much more useful.

So I'd suggest just removing it.

		Linus
