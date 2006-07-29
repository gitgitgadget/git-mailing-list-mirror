From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git prune pig slow
Date: Sat, 29 Jul 2006 16:48:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607291647030.4168@g5.osdl.org>
References: <20060729224106.12312.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 30 01:49:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6yYY-0002yN-1s
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 01:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWG2XtP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 19:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWG2XtO
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 19:49:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57819 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750798AbWG2XtO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 19:49:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6TNmenW006442
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 29 Jul 2006 16:48:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6TNmds2022993;
	Sat, 29 Jul 2006 16:48:40 -0700
To: linux@horizon.com
In-Reply-To: <20060729224106.12312.qmail@science.horizon.com>
X-Spam-Status: No, hits=-0.503 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24441>



On Sat, 29 Jul 2006, linux@horizon.com wrote:
> 
> No, that's dangerous too.  The index file is considered part of the root
> set for git-fsck-objects, but not for git-repack.

Indeed.

Although at least you won't lose any history - at worst you'll have to 
basically do a "git reset HEAD" to make things right again.

I was careful when I wrote the new git-prune to take the index into 
account, but I'd forgotten about it wrt the "git repack -a -d" suggestion.

		Linus
