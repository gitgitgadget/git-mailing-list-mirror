From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 07:36:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603250734130.15714@g5.osdl.org>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
 <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 16:36:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNAom-00087K-4i
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 16:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWCYPg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 10:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWCYPg2
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 10:36:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751430AbWCYPg2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 10:36:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2PFaLDZ014039
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Mar 2006 07:36:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2PFaJSs001462;
	Sat, 25 Mar 2006 07:36:19 -0800
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17986>



On Sat, 25 Mar 2006, Morten Welinder wrote:
>
> The primary correctness concern is that patch understands
> the output, ie., the libxdiff + patch brings out right back.
> 
> It ought to be fairly easy to script checking every file change
> that ever went into a git repository.  You won't cover evil
> cases that way, but it should provide some assurances that
> nothing is too wrong.

I did _some_ tests, and especially "git-apply" is very useful, since it is 
actually a lot more anal than regular "patch".

It all worked fine except for files that don't end with a newline. Davide 
points out that he just forces the EOLN at the end in his test harness, 
but that's not exactly acceptable for a real project that actually has 
real cases.

I'll be taking a look at trying to fix it. 

		Linus
