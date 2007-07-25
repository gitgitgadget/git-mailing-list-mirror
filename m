From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Wed, 25 Jul 2007 13:40:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707251327390.3607@woody.linux-foundation.org>
References: <46A5B5F5.6000202@trolltech.com> <46A6F21D.2010306@trolltech.com>
 <Pine.LNX.4.64.0707251024390.14781@racer.site>
 <200707251205.48235.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:42:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDngu-0004wR-5V
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 22:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718AbXGYUmh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 16:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754565AbXGYUmh
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 16:42:37 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52498 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752706AbXGYUmg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jul 2007 16:42:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6PKf1hT017716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Jul 2007 13:41:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6PKesPH020821;
	Wed, 25 Jul 2007 13:40:54 -0700
In-Reply-To: <200707251205.48235.andyparkins@gmail.com>
X-Spam-Status: No, hits=-3.234 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.14__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53717>



On Wed, 25 Jul 2007, Andy Parkins wrote:
> 
> I don't disagree with you at all - it is completely ridiculous for Windows 
> users to moan about lack of Windows support without contributing any help.  
> However, I think there is a good reason.
> 
> I think it's a chicken and egg problem.  The only reason I started making 
> (small) contributions to git was because I was using it already.

I think this is 100% true, and worth repeating.

A lot of people seem to think that open source is about having lots of 
people help with the project, and that development happens much faster 
that way.

But what people often seem to miss is that pretty much all projects 
didn't start out "open source". They *all* started out as somebodys 
personal project (where "somebody" could be a small group, not just an 
individual, of course), and while maybe the _license_ was open source from 
the beginning, you cannot get away from the fact that in order to actually 
be developed as open source, in the end some *individual* has to just do 
it.

No project ever gets useful help until it's already useful. Being open 
source doesn't get you past that hump - it only helps you *after* you've 
already gotten past it.

Now, admittedly, I think one issue with Windows is that the "hump" is 
simply much bigger. The initial cost (not necessarily in money, but in 
effort) of getting involved in a development process is just a *lot* 
higher for Windows users than it is for just about any UNIX.

If you're on some unix platform, the cost of getting involved is basically 
that the project should already work to some degree, and then there may be 
some relatively *trivial* issues with making sure that you've got a 
compiler installed and the basic libraries. But that's really quite easy 
on just about any UNIX, to the point that most people don't even have to 
think about it.

In contrast, on Windows that "hump" is a whole lot harder. You don't just 
have to have a compiler, you have to have some *specific* compiler, 
because under Windows, they all have different development environments, 
and few projects support them all. 

So you have a double whammy: not only are people doing less development on 
Windows to start with (so the project itself is likely not as usable), but 
something as totally *trivial* as getting a simple C development 
environment isn't even trivial. And git makes it worse by requiring a very 
odd component (in Windows terms): the shell.

I really hope we'll get the the C rewrite merged soon. Especially the big 
ones, ie commit / merge / am / clone / fetch. Those are the complex ones 
that it's hard to get excited about when they don't work. Once those work 
well, you could probably use git pretty completely even without shell, 
even if you'd be missing a few features - and those features would now be 
small enough that a relative beginner can cut their teeth on them.

The good news seems to be that most of those big scripts already exist in 
a C version, so it's not like it's some utopian dream any more.

But getting a development environment is still much more painful under 
Windows than just about anywhere else.

			Linus
