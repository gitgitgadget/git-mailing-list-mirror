From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Mon, 16 Oct 2006 17:23:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161714590.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
 <200610170155.10536.jnareb@gmail.com> <Pine.LNX.4.63.0610170157270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 02:24:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZckU-0001eP-GY
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 02:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422977AbWJQAX5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 20:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422979AbWJQAX5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 20:23:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5067 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422977AbWJQAX4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 20:23:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9H0NjaX002020
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Oct 2006 17:23:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9H0NhtO001765;
	Mon, 16 Oct 2006 17:23:44 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610170157270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.473 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29003>



On Tue, 17 Oct 2006, Johannes Schindelin wrote:
> > 
> > Unless you have branch(es) with totally different contents, like git.git
> > 'todo' branch.
> 
> But I _do_ work with it! I just don't need to "checkout" it! Example:
> 
> git -p cat-file -p todo:TODO

Ok, if there ever was an example of a strange git command-line, that was 
it.

> (How about making git-cat be a short cuut to "git -p cat-file -p"?)

Well, you can just add

	[alias]
		cat=-p cat-file -p

to your ~/.gitconfig file, and you're there.

[ For all the non-git people here: the first "-p" is shorthand for 
  "--paginate", and means that git will automatically start a pager for 
  the output. The second "-p" is shorthand for "pretty" (there's no 
  long-format command line switch for it, though), and means that git 
  cat-file will show the result in a human-readable way, regardless of 
  whether it's just a text-file, or a git directory ]

So then you can do just

	git cat todo:TODO

and you're done.

[ So for the non-git people, what that will actually _do_ is to show the 
  TODO file in the "todo" branch - regardless of whether it is checked out 
  or not, and start a pager for you. ]

I actually do this sometimes, but I've never done it for branches (and I 
do it seldom enough that I haven't added the alias). I do it for things 
like

	git cat v2.6.16:Makefile

to see what a file looked like in a certain tagged release.

People sometimes find the git command line confusing, but I have to say, 
the thing is _damn_ expressive. I've never seen anybody else do things 
like the above that git does really naturally, with not that much 
confusion really.

Even that "alias" file is quite readable, although I'd suggest writing out 
the switches in full, ie

	[alias]
		cat=--paginate cat-file -p

instead. That kind of helps explains what the alias does and avoids the 
question of why there are two "-p" switches.

			Linus
