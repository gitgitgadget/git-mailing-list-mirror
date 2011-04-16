From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Sun, 17 Apr 2011 01:53:28 +0400
Organization: '
Message-ID: <20110416215328.GA5739@external.screwed.box>
References: <201102142039.59416.jnareb@gmail.com>
 <201104162132.57650.jnareb@gmail.com>
 <20110416204823.GA5586@external.screwed.box>
 <201104162317.56045.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Peter Vereshagin <peter@vereshagin.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 23:54:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBDRJ-0005RT-Nm
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 23:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab1DPVxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 17:53:44 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:54452 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331Ab1DPVxn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 17:53:43 -0400
Received: from localhost (unknown [81.218.219.122])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id DDA855AEF;
	Sun, 17 Apr 2011 01:29:29 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201104162317.56045.jnareb@gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L(~u
 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171697>

You're face to face with man who sold the world, Jakub!
2011/04/16 23:17:55 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
JN> > JN> No, fetching and pushing using HTTP transport, be it "smart" or "dumb"
JN> > JN> Gitweb is web interface for _viewing and browsing_ repositories using
JN> You can configure web server in such way that you can use the same
JN> URL for fetching with git as for browsing repository with web browser

There are more disadvantages of such  an approach:
- for CGI, the process is being executed on every request. On some systems, e.
  g., Windows, launching a process is very expensive, sometimes more than
compiling of perl source itself.
- for development, some different parts of the code for the same purpose do
  exist, e. g., client and storage i/o. The more it is being developed, the
more features it satisfies, the more such a code. For example, I suppose
git-http-backend will have 'get a particular commitdiff quickly without
fetching all the repo' feature one day to be used in web clients' scripts, e.
g. will serve the same way for git cli as a file system. This will make it have
the same feature like 'commitdiff' feature of a gitweb but implemented
differently.
- the routing of the request, the deciding what to do with the particular
  HTTP request, becomes more obfuscated. First, web server decides what CGI
should approve it. Plus two more decision makers are those 2 CGI, all different.

It's just why I never supposed git to have 2 different native web interfaces,
especially in sight of plumbing vs porcelain contrast in cli, sorry for
confusion.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
--
http://vereshagin.org
