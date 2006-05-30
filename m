From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-cvsimport problem
Date: Mon, 29 May 2006 21:37:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605292122580.5623@g5.osdl.org>
References: <Pine.LNX.4.63.0605300236270.25988@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 30 06:37:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkvz0-00070E-8j
	for gcvg-git@gmane.org; Tue, 30 May 2006 06:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWE3Eh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 00:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWE3Eh0
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 00:37:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19432 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932109AbWE3Eh0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 00:37:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4U4bI2g006138
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 21:37:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4U4bHAV028584;
	Mon, 29 May 2006 21:37:18 -0700
To: Grzegorz Kulewski <kangur@polcom.net>
In-Reply-To: <Pine.LNX.4.63.0605300236270.25988@alpha.polcom.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21012>



On Tue, 30 May 2006, Grzegorz Kulewski wrote:
> 
> and it looks like it hangs in the middle with message:
> 
> cvs [rlog aborted]: unexpected '\x0' reading revision number in RCS file
> /home/cvsroot/lms/templates/noaccess.html,v

Are you sure that CVS archive isn't corrupted? That sounds like an 
internal CVS error to me. Doing a "git cvsimport" will obviously get every 
single version of every single file, so it will inevitably also hit errors 
that you migt not hit with a regular "cvs co" (which will only get the 
current version).

There's bound to be some "fsck for CVS" (since people edit files by hand, 
and mistakes must happen), but I have no idea.

That said, it's not like we haven't had our share of cvsps issues and 
other things, so who knows..

> and to my understanding does not do anything usefull next. Nothing is imported
> (there is only nearly empty .git tree).

Do "git log origin" to see what has been imported. If a cvsimport is 
broken in the middle, you'll not get any checked-out state, and your HEAD 
won't point to anything, but the "origin" branch has been created and 
contains whatever has been imported so far.

			Linus
