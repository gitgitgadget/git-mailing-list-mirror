From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Build git on HP/UX
Date: Thu, 28 Jun 2007 10:04:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706280951480.8675@woody.linux-foundation.org>
References: <20070628105952.GC8925@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: michal.rokos@nextsoft.cz, GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Thu Jun 28 19:04:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3xQG-0008JZ-HJ
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 19:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758867AbXF1REq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 13:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758314AbXF1REq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 13:04:46 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33391 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757145AbXF1REp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jun 2007 13:04:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5SH4ZhR023764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Jun 2007 10:04:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5SH4T2p029852;
	Thu, 28 Jun 2007 10:04:29 -0700
In-Reply-To: <20070628105952.GC8925@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=-2.625 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51119>



On Thu, 28 Jun 2007, Thomas Glanzmann wrote:
>
> could someone here describe what he did to build git on HP/UX?
> Some of my questions is:
> 
>         - What build chain did you use (gcc?)?

The compiler shouldn't be a big issue, although git does expect something 
much better than K&R. Ie you need a *modern* compiler. 

(To be honest, the git sources do use some gcc extensions, but 
 (a) I think they are all successfully conditional on gcc already
 (b) most modern vendor compilers support a lot of them anyway


The Makefile is very GNU-make, though, so even if you don't have gcc, you 
should have GNU make, or you'd need to create your own makefile.

And you'll need perl, and a basic set of development libraries: zlib and 
openssl are the minimum set, I think (apart from the basic C library with 
networking extensions).

For full functionality, you'll need ssh, rsync, tcl/tk, curl, expat, SVN, 
CVS, cvsps, etc - obviously depending on what you're actually going to do.

			Linus
