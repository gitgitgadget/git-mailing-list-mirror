From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: how to display file history?
Date: Mon, 15 May 2006 08:15:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605150811400.3866@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB670F4F8@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 17:15:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffen3-000304-Jr
	for gcvg-git@gmane.org; Mon, 15 May 2006 17:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWEOPPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 11:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWEOPPQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 11:15:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964907AbWEOPPO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 11:15:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4FFFBtH009021
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 08:15:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4FFFAQi005881;
	Mon, 15 May 2006 08:15:11 -0700
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB670F4F8@hdsmsx411.amr.corp.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20055>



On Mon, 15 May 2006, Brown, Len wrote:
>
> it is tiresome to access kernel.org/git tree display
> to see the list of commits that changed a particular file.
> (and for files on my local disk, this isn't available).
> 
> How do I print the list of commits that change a particular file
> on my local disk?

Just do

	git whatchanged -p <file>

which has worked pretty much since day one. In fact, it's much better than 
that. The "file" can be any abritrary combination of files and/or 
directories, and it will track them all at the same time. So

	git whatchanged -p arch/ia64 include/asm-ia64

will track the ia64-specific changes.

Newer git versions (ie 1.3.x+) support this in "git log" too (it worked on 
older gits, but it was unacceptably slow, so you might as well consider it 
"nonworking"). So

	git log [-p] <filespec>

is your friend.

Finally, as usual, "gitk" is just a fancier log viewer. So just do

	gitk arch/ia64 include/asm-ia64

and enjoy.

You really shouldn't go to gitweb. The history view of gitweb is much less 
capable than any local view.

		Linus
