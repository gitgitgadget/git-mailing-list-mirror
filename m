From: Paul Mackerras <paulus@samba.org>
Subject: Re: lstat() call in rev-parse.c
Date: Tue, 25 Apr 2006 09:23:33 +1000
Message-ID: <17485.24053.35997.868256@cargo.ozlabs.ibm.com>
References: <17483.27938.890830.375324@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0604230906370.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 01:23:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYAPC-00004z-9n
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 01:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWDXXXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 19:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWDXXXn
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 19:23:43 -0400
Received: from ozlabs.org ([203.10.76.45]:18338 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751478AbWDXXXm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 19:23:42 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8C52E67A03; Tue, 25 Apr 2006 09:23:41 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604230906370.3701@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19117>

Linus Torvalds writes:

> So the rule is: if you don't give that "--", then we have to be able to 
> confirm that the filenames are really files. Not a misspelled revision 
> name, or a revision name that was correctly spelled, but for the wrong 
> project, because you were in the wrong subdirectory ;)

OK, fair enough.  In that case we need a better error message, so I
don't get people complaining that gitk can't show the history of files
that don't exist any more.  How about something like:

Argument "foo" is ambiguous - revision name or file/directory name?
Please put "--" before the list of filenames.

I'll hack up a patch to this effect.

Paul.
