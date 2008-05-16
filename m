From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Migrating a git repository to subversion
Date: Thu, 15 May 2008 20:01:01 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805151952260.2941@woody.linux-foundation.org>
References: <42dc968d0805151608q2ed89fc8madcd8d341a4ed1df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alf Mikula <amikula@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 05:02:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwqDC-0004yj-Mp
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 05:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758624AbYEPDBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 23:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758588AbYEPDBG
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 23:01:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42643 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758572AbYEPDBE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2008 23:01:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4G312Wh012130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 May 2008 20:01:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4G3115M023469;
	Thu, 15 May 2008 20:01:02 -0700
In-Reply-To: <42dc968d0805151608q2ed89fc8madcd8d341a4ed1df@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.428 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82253>



On Thu, 15 May 2008, Alf Mikula wrote:
> 
> Having said that, I want to demonstrate git's git<--->svn
> capabilities, and currently everybody here has and understands
> Subversion.  So, I want to initialize a Subversion repository with my
> git history from my local git repository.  Here's what I tried:

Hmm. I don't think there is any git2svn thing, but if your history is 
linear (which is really the only thing SVN can handle, since SVN doesn't 
really do "merges" in the git sense at all), you could just write some 
silly script to extract the patches one by one and commit them using SVN.

Or use "tailor", which should be able to convert from pretty much anything 
into pretty much anything (again, assuming it's linear).

Or, and this gets extra points for being disgusting, use "git-cvsserver" 
to serve a remote CVS repo, then cvssuck to create a local CVS repo out of 
it, and then do cvs2svn to create a SVN repo. Ta-daa!

(Ok, that last one really is too ugly to live, but if it works, it really 
sounds like the true rube-goldberg way to do it, and should be done just 
because it is there, to paraphrase George Mallory).

			Linus
