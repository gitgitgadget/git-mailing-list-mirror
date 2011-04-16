From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Sun, 17 Apr 2011 03:00:53 +0400
Organization: '
Message-ID: <20110416225729.GB5739@external.screwed.box>
References: <201102142039.59416.jnareb@gmail.com>
 <201104162317.56045.jnareb@gmail.com>
 <20110416215328.GA5739@external.screwed.box>
 <201104170019.07997.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 01:01:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBEUL-00027V-KJ
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 01:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab1DPXBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 19:01:06 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:55737 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab1DPXBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 19:01:03 -0400
Received: from localhost (tor12.anonymizer.ccc.de [62.113.219.5])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id F3F2F5AEF;
	Sun, 17 Apr 2011 02:36:47 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201104170019.07997.jnareb@gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L(~u
 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171702>

You're face to face with man who sold the world, Jakub!
2011/04/17 00:19:07 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
JN> > There are more disadvantages of such  an approach:
JN> > - for CGI, the process is being executed on every request. On some systems, e.
JN> >   g., Windows, launching a process is very expensive, sometimes more than
JN> git-http-backend is written in C, not Perl.

Yes, it's about it.

JN> > - for development, some different parts of the code for the same purpose do
JN> >   exist, e. g., client and storage i/o. The more it is being developed, the
JN> >   more features it satisfies, the more such a code.
JN> 
JN> Gitweb is written in Perl.  This language is good for prototyping, for
JN> fast development, and for easy writing of a web app.  Gitweb works on
JN> porcelain level - it is an user interface (a web one).
JN> 
JN> C is good for performance.  git-http-backend is only an example
JN> implementation.  The "smart" HTTP protocol works on porcelain level.

It doesn't mean that different parts of code do exist in them for the same purpose.
It doesn't mean that such a code can not be reused by both.
C code can be used by Perl.

JN> >   For example, I suppose git-http-backend will have 'get a particular
JN> >   commitdiff quickly without fetching all the repo' feature one day
JN> >   to be used in web clients' scripts, e.g. will serve the same way
JN> >   for git cli as a file system. This will make it have the same
JN> >   feature like 'commitdiff' feature of a gitweb but implemented 
JN> >   differently.
JN> 
JN> Unix philosophy which Git tries to follow is "do one thing and do it
JN> well".

This is why the code must not be reused?
Does it mean "there is more than one way to do it and we will use all of them for the same purpose in the same project"?

JN> I don't believe git-http-backend would ever talk to web browsers, and
JN> it is quite unlikely for git to acquire non-distributed client-server
JN> mode.

This is why I must not have a possibility to check out N latest commitdiffs easily from my script to recognize current state of the particular repo's art without fetching all over the repo? Suppose repo doesn't have a porcelain web interface, but even if it does, it's not for it.

JN> And if it does acquire such feature, then gitweb will be simply modified
JN> to use it...

or git-http-backend? or both?
isn't it just better for them to reuse the same code?

JN> > - the routing of the request, the deciding what to do with the particular
JN> >   HTTP request, becomes more obfuscated. First, web server decides what CGI
JN> >   should approve it. Plus two more decision makers are those 2 CGI, all different.
JN> > 
JN> > It's just why I never supposed git to have 2 different native web interfaces,
JN> > especially in sight of plumbing vs porcelain contrast in cli, sorry for
JN> > confusion.
JN> 
JN> Those are not two _web interfaces_.  Gitweb is one of web interfaces
JN> to git repositories; more at
JN>   https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Web_Interfaces
JN> 
JN> Fetching and pushing via HTTP is not web interface, is HTTP _transport_.

but HTTP is an application protocol, not a transport protocol. And the what the application supplies by the protocol is the interface.
Do you mean the Git's plumbing is a protocol and not an interface to be used by application? And porcelain is an interface, correspondently.

JN> For one you use web browser, for other you use git itself.

on the client side those are different projects.
on the server side those are the same. 

Different technologies, right. But not incompatible.

JN> But this discussion got very off-topic...

Not about Javascript, right.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
--
http://vereshagin.org
