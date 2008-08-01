From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 13:11:27 -0700
Message-ID: <20080801131127.20b3acfd.akpm@linux-foundation.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
	<20080801124550.26b9efc0.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:13:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP0zc-0004yQ-4y
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbYHAULs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755441AbYHAULs
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:11:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48443 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755124AbYHAULr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 16:11:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71KBRU9031504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 1 Aug 2008 13:11:28 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m71KBRhJ000771;
	Fri, 1 Aug 2008 13:11:27 -0700
In-Reply-To: <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.824 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91086>

On Fri, 1 Aug 2008 12:56:44 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Fri, 1 Aug 2008, Andrew Morton wrote:
> > 
> > That's how I noticed it - copied, pasted, MTA barfed.
> > 
> > Converting a usable name+email-address into an unusable one seems ... unuseful.
> 
> Umm. Those signed-off ones weren't even _converted_ They were written by 
> people.

This was the Author: line.

Afaik that person doesn't send patches via git, and that this text by
some means was transferred into git from an emailed patch.

So unless he explicitly typed a "From:" line (without quoting his name)
into the top of his changelog, some piece of software somewhere has
stripped the quotes when it was converting his name from the email
headers into the git Author: line.

> Also, you seemed to miss the point that it's not a name+email-address. 

I know exactly what it is.

> It's a name. Oh, and there's an email address too. But they aren't 
> connected. We often just print out the name *without* the email address. 
> Why should those things have to know about some totally irrelevant email 
> quoting rules? They weren't emails, didn't know about it, and didn't care.

Well, as I said, it's a minor point.  It's just that converting
something which _can_ be copied and pasted into an MUA into something
which cannot seems...  odd.

Most sane MUA's will omit the quotes if the name part does not need
them, so simply retaining the quotes if they were originally there
would be an OK thing to do.


So how serious is this issue?

Well, if all MUAs either generate synchronous error messages or will
insert the quotes for you then not very serious at all.

If, however, there are MUA+MTA combinations which do _not_ inform about
or correct the error then this failure to quote the name could cause
people's emails to get lost altogether, which is a bit serious.


Also, _most_ git Author: lines _can_ be successfully copied-and-pasted
into an MUA.  The fact that a small minority of git Author: lines cannot
be used this way is a bit dangerous.
