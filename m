From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 11:12:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704171107510.5473@woody.linux-foundation.org>
References: <200704171041.46176.andyparkins@gmail.com>
 <200704171235.34793.andyparkins@gmail.com> <Pine.LNX.4.64.0704170847380.5473@woody.linux-foundation.org>
 <200704171803.58940.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdsAV-00019O-KW
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 20:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161326AbXDQSMk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 14:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161335AbXDQSMk
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 14:12:40 -0400
Received: from smtp.osdl.org ([65.172.181.24]:56290 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161326AbXDQSMj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 14:12:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HICZ6q011776
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 11:12:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HICYGq003845;
	Tue, 17 Apr 2007 11:12:35 -0700
In-Reply-To: <200704171803.58940.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.964 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44808>



On Tue, 17 Apr 2007, Andy Parkins wrote:
> 
> Why on earth would it not apply?  It's being applied using git-apply, 
> which will unexpand the keywords as it goes - as I keep saying.

So you will never work with anybody outside of git?

What about tar-files when you export the tree? Should they have the 
expanded version? 

> You keep saying these sweepingly general things.  It can be made to 
> work.

No, it CANNOT.

Trust me. There's NO WAY IN HELL it will "work" in any other sense than 
"limp along and not be usable".

Yes, you can make it "work" if you:

 - make sure that you never _ever_ leave the git environment

   But why do you want keyword expansion then? The whole point is if you 
   have other tools than the git tools that look at a file. Even your svg 
   example was literally about having non-git tools work with the data. 
   What if you ever email the file to somebody else? 

 - you make all git tools explicitly always strip them.

   Again, what's the point again? You add keyword expansion, and then the 
   only tools that you really allow to touch it (except your "print it 
   out" example) will have to remove the keyword expansion just to work.

That's not "work". That's just stupid. Yes, you can make your "print it 
out" example work, but as alreadyt mentioned, you could have done that 
some other way, with a simple makefile rule, quite independently (and much 
better) than the SCM ever did.

		Linus
